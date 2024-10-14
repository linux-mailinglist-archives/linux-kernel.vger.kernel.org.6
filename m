Return-Path: <linux-kernel+bounces-364162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F4099CC02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C01C22D71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5841AAE2C;
	Mon, 14 Oct 2024 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lw15VpqL"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049011537AA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914129; cv=none; b=OW+96C3wfMVt5eQAHYgKgnqBcNkvVF4ftEnR0hNA7Azj9utj49f8vrM6O46AFsqlZ46XTGdNqL+GN60JpCdrOZYFvu0SLgVV7GuLgX+cJ2/uCxRQYajz21/nFgfECZWov0zRHSsl8RQwiJ+DBzZTKUkIr1HesLlWJOSqlHNzn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914129; c=relaxed/simple;
	bh=OB3yO9FQv0J593fU52zHVnW8M9sIKaaudWV4PCqWeY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APDnIfOzQLImnFbxKni5L3BR5Urokr4mEjeRLgbOFSKf0L69gcV2bPVkRH21JuyvTaGerYEQ9Ak4j0tF1R13NAPKZ9tL1rpGACxgFLGojzwhRF4tu/jPQPtxWBVjn3WeeZoBjspvKPXXLh2TOxHbTFtsRabCYpl00JnzxAWNv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lw15VpqL; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so19456251fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728914126; x=1729518926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOBAB4fCN+OYdhF4Gj278BY1JY5UgUE5qLDzZmKiBEQ=;
        b=Lw15VpqLztVfCUckdCH2p/oWcadCfGzQquMTEwxjJtCyoR4A4B01BzOBtMkd59/3+r
         fZTjmyWcnt/BY5GdPrq0Dcrzzqs3tKZEPGvYs+e5Jz9DoXp2ppA5skUyl23U/Ox8c46Z
         t6lEnsY8Cu752OpHytfVg8+pzsAz94YarUY+AotXf6mLBaQCt33r2VfLvmI2jYL1vVf3
         CxJNFZT0rDVmth/bMQl+WuhzYthYL1VYLdeETcKBNLVu3TRC6FZKGprtfoYp5tRDgNT3
         L19AhV4JY/lUSByEx6uy5kg/hgSSm54Iv9Ud3xQU3hMNowXM98mIIFQ7RxSpgmHrkcqd
         Hw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914126; x=1729518926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOBAB4fCN+OYdhF4Gj278BY1JY5UgUE5qLDzZmKiBEQ=;
        b=PKCFPVigjJb9mHIqA1bdzgq0ho4jFCKW6RtvdmDjD5isYBHUW6mmtmBTpBqlImiBw6
         Ulg3mihOutTc+j8/jCvLwnyiB8hqVvAH2RTQTI13wxDlc4r1VA5sEq4W91teH7EyqTAE
         outdsciDu60qnspJ7yTe06lCZxH1J94RPE+bKvU2O7dwbwZP9rzqhMnAtCyWSFnC5TJq
         H2DjdAh8Qw2cesZ8oGkonwQuQfFOa8nXKGcPL7u2l3kBs26CBul7u+wsBOe4gJ9rg1da
         pbUELwfMMIBF1BMTvyalFr6AojTX8qcBICroT15NpovwD91dkQv/tb8H9WmV83wTB2OW
         HKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV67fk0vlU5ffreO/L4ss8IyYRB7VXqSU8O00SFMPhG5eEt74m24NNE3o23mpzBttkLbdGHnHPek7Nn+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYq6cK40RWLNI6PkGaDQ8Twk5PKnpeT9CrdofCVewGzZLtqJ60
	TE45TRKT4MwCUxG9WgGDLlLxlw8A5z7aTJIbsW9yYZlnfmDG39nod8UG/+V0ITw=
X-Google-Smtp-Source: AGHT+IHXfxymwMuBTLIPhj1IILaLlqCN68Kc44a6pGyIrVl/vNinMfPWVaScDLDhzz6b1w5Xu/CMGQ==
X-Received: by 2002:a05:651c:1509:b0:2fa:bd30:1928 with SMTP id 38308e7fff4ca-2fb3f2d1b11mr26316081fa.32.1728914126119;
        Mon, 14 Oct 2024 06:55:26 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb438c06f7sm8039641fa.55.2024.10.14.06.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:55:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 14 Oct 2024 16:55:20 +0300
Subject: [PATCH v2 1/2] ARM: add CLIDR accessor functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-armv7-cacheinfo-v2-1-38ab76d2b7fa@linaro.org>
References: <20241014-armv7-cacheinfo-v2-0-38ab76d2b7fa@linaro.org>
In-Reply-To: <20241014-armv7-cacheinfo-v2-0-38ab76d2b7fa@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=OB3yO9FQv0J593fU52zHVnW8M9sIKaaudWV4PCqWeY8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnDSLKtlJv5vCrtJr/cNbUxbxVvYF7NDouakMt/
 W1CwyiX+LOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZw0iygAKCRCLPIo+Aiko
 1eKFB/wLj20pVDg44I5tdPc6vbCK41LLd742EI7OeUQjip1Myn2p+pnpfgShdMzFHwpnhcVz+fa
 Y9D5UQ/73fOaI8EMt/CO//nyZbPZlu9N40Zto9dDrzK+0X726hn/F3prsFNMv006TFfUUzKYSzU
 7G7WVg9nkw7wJ9druObfFR8Ph/b5ouw6tq6gXI4w25YtvTtKs+SoMxlYODeBQzKY3yN9T/DiEaX
 rPj5MwtIYfX/H1HWKuGJ6YyJMq4TSNGBmW9OIOQJnYogypC1bmE8+mgOFi8cFX2ys+jFvJybFtj
 drlm+eQF1wGx1JzNAnDxx6gtSNqrx/CUJIU4EW/pQZYEIABX
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add functions to read the CLIDR, Cache Level ID Register.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/include/asm/cachetype.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index b9dbe1d4c8fe..b01c59076b84 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -83,6 +83,14 @@ static inline unsigned int read_ccsidr(void)
 	asm volatile("mrc p15, 1, %0, c0, c0, 0" : "=r" (val));
 	return val;
 }
+
+static inline unsigned int read_clidr(void)
+{
+	unsigned int val;
+
+	asm volatile("mrc p15, 1, %0, c0, c0, 1" : "=r" (val));
+	return val;
+}
 #else /* CONFIG_CPU_V7M */
 #include <linux/io.h>
 #include "asm/v7m.h"
@@ -96,6 +104,11 @@ static inline unsigned int read_ccsidr(void)
 {
 	return readl(BASEADDR_V7M_SCB + V7M_SCB_CCSIDR);
 }
+
+static inline unsigned int read_clidr(void)
+{
+	return readl(BASEADDR_V7M_SCB + V7M_SCB_CLIDR);
+}
 #endif
 
 #endif

-- 
2.39.5


