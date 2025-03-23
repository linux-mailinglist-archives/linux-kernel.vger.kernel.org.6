Return-Path: <linux-kernel+bounces-573028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72E3A6D21B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85D71895919
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FC11F130F;
	Sun, 23 Mar 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfN5de3p"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E991C860E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769578; cv=none; b=B/ERxmU8ADBcXmwEA6IYmtqwCnl76FbHLONhd1ksbsSjvm/nXIKJdKR9FDysQHPgLfyjhQKotr+gzgo+ePY8fGvtAcg19bkh5+qys9MYnEbw9QpinEyaWUelwYMEq+9fL8I8wO7CNC1nrUJCUt11LYrhK66rzPKqx5NidsZnVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769578; c=relaxed/simple;
	bh=H8JdpLkt9gjn8rcrkSJLgzbur0dmxI9LF5La3T8/4+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHFpDLmB2zmlTEfqW4pQFubbvbYmPUfkhDes7sN9iiJ6ox672ghruQ9R1dbwO+6hOynZU3tpSvaZBAHuDMzbfa6hwdiXFDHDPZ6IBFIGDsB4B7e8FRMcy3tGgD8kyCeHndvU6hQxnM59wYCxJVVSH1s0c+O+797SEmSMLNTJ9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EfN5de3p; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so7231977a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769571; x=1743374371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5FeheMvzJmbwWW+zZr6R44NUMWEXy77OJnz7z8P8Mo=;
        b=EfN5de3pUHEWdjCzks+RAYj0koIZpp0Sb/fzfpalHCT8dWNDDtt6pS0ou5cHtJFZ/T
         +K3NzuugxktQnf9qQnGplv/1Zd35mMcUGDzrBSz0F10sPsviteJyh4rH2dHR76FlljsW
         1juhbKbIHfLgji6PP2VBrW7vap8/ELoR1+50ukGt8ZcsV66d/rio867pnuO8h5g5glCC
         JaysGBUUQJDbWaQFC5FvmsYVY6Z8nFIb9b1E1AkWnTZG+aJCGmishTvtAyyXzpKA9rbF
         ynAPfighPi0bhe58jcdSeXJkQCuO9zWXMXGWMtWOaUGTVaodHMoIKumWjNG+sOwVKbBZ
         GjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769571; x=1743374371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5FeheMvzJmbwWW+zZr6R44NUMWEXy77OJnz7z8P8Mo=;
        b=kGG5JNXwXI/AnKtXdZQQBm1quzyKdaBbib4fIAj4rCoBwDr8eXXF3Y71YQrTyccbhI
         E5BcqRKYvhpASntBSgKxrFbLuoZG+dWEQAWkNP7eavZM95Z20TESCEJd4X8q+Wd5WMv7
         Ri6ZflDbe13o+iIyS/lZBbQunpEGPwq+DckrneL8AZRUNpiB5ejs/WSqCVlvmBOjynuH
         cq87srtVuemqsLFObIawSoALcVkE0IB3yQ/HKRH/sOqCnKp/a3Vgk6Q9pYeTWqEN8F0D
         ReH+k3l3Ma7zD88Rzir7nk5HtPoStM6agDgr6/K94WX9r6EYEXchbvNPUd7jnYM8a4ac
         kr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUudInMusbT4FkwgAJf1ySLq829XOr2Gc7yf4SmLlSRGYO638HXIQS1BOC/EFY8XkG4OSDS81MgxF6Gl48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37AkEBuL0g/d0zQYZlsFVEYPCGQwTsLcy7Ytx0vCJjeUmy5ZU
	pev6AIwFF0JlL0uoFiTyoRsrrXNnu6VehZEJrSq8s1NSc9kAboP/EzktvUr7rG0=
X-Gm-Gg: ASbGncvaZTq0yasbUq3cFLVBtizMiHMfXvtK16v4dmdqeO/eBw1CBwEgXHgK3t0fXBG
	EzYDfJdDBIRIsWmr23hGttkVRWmU7CFHgNAXqmnnUHHERpo/izOotyAIvte/XPMTrGZQmU7JxOi
	teyyNdHJLZ5cnopnYRFB7lVnYO5KTdeTFb9zrMEqlvL4rCPfmqTOjb33DyMxGJFtcdXZMsUgoxo
	b7rdxxco/SdbZvOkCDL6wDucaGeWGkAzdhNWlB5tUwswSFUW4LOZO4PQpAXs7mtQ8eksFe7z9BE
	M21KnPc/omNPYoiOLYoOCJGorMHZ02KL4ajSSuOxXFhhWrmvmMeAf5I//BZS/WEVl3lILgFC/Hy
	HaHyEyDsMqOVFk7fHjg+6MqQv3HW1
X-Google-Smtp-Source: AGHT+IGUlU/bQ4EEwEZ8SvxfGdwz6JP0ixr4oFBkCNhTZdri22pju1M/NgGRE9XtZE8yWlr6k3maUQ==
X-Received: by 2002:a17:907:3d88:b0:ac3:8d24:a7e with SMTP id a640c23a62f3a-ac3f22b476amr1025053966b.26.1742769571302;
        Sun, 23 Mar 2025 15:39:31 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:30 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:29 +0000
Subject: [PATCH 13/34] mfd: sec: merge separate core and irq modules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-13-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

There is no reason to have these two kernel modules separate. Having
them merged into one kernel module also slightly reduces memory
consumption and module load times a little.

mapped size (lsmod):
         before:             after:
    sec_core   20480    sec_core   24576
    sec_irq    16384
    ----------------
    total      36864

Section sizes (size -A):
         before:             after:
    sec_core    6780    sec_core   13239
    sec_irq     8046
    ----------------
    Total      14826

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
Checkpatch suggests to update MAINTAINERS, but the new file is covered
already due to using a wildcard.
---
 drivers/mfd/Makefile                     | 3 ++-
 drivers/mfd/{sec-core.c => sec-common.c} | 2 ++
 drivers/mfd/sec-irq.c                    | 8 --------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8a8c678134a9721c7f78e432ddd0df33b2b0de69..67fac46c8eeb9c7b4429e8a496a1d7d40d2b7b31 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -232,7 +232,8 @@ obj-$(CONFIG_MFD_RK8XX)		+= rk8xx-core.o
 obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
 obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
 obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
-obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
+sec-core-objs			:= sec-common.o sec-irq.o
+obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o
 obj-$(CONFIG_MFD_SEC_ACPM)	+= sec-acpm.o
 obj-$(CONFIG_MFD_SEC_I2C)	+= sec-i2c.o
 obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-common.c
similarity index 98%
rename from drivers/mfd/sec-core.c
rename to drivers/mfd/sec-common.c
index 27f5036ffa1009304147755c91d00be333dd206a..fcf7668efd3215ad70d81916ede249ed5f9d45ae 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-common.c
@@ -290,6 +290,8 @@ DEFINE_SIMPLE_DEV_PM_OPS(sec_pmic_pm_ops, sec_pmic_suspend, sec_pmic_resume);
 EXPORT_SYMBOL_GPL(sec_pmic_pm_ops);
 
 MODULE_AUTHOR("André Draszik <andre.draszik@linaro.org>");
+MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
+MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
 MODULE_DESCRIPTION("Core driver for the Samsung S5M");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index bf86281401ac6ff05c90c2d71c84744709ed79cb..4afac3aa0a582994bf04c41768c1c788c54ee2e9 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -6,7 +6,6 @@
 #include <linux/array_size.h>
 #include <linux/build_bug.h>
 #include <linux/dev_printk.h>
-#include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/mfd/samsung/core.h>
@@ -510,10 +509,3 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sec_irq_init);
-
-MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
-MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
-MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
-MODULE_DESCRIPTION("Interrupt support for the S5M MFD");
-MODULE_LICENSE("GPL");

-- 
2.49.0.395.g12beb8f557-goog


