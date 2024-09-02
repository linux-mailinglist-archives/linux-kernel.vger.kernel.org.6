Return-Path: <linux-kernel+bounces-311301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD8496874F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4FA1F23CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED97B19C54A;
	Mon,  2 Sep 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXE9l6dC"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D2D18757D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279184; cv=none; b=dTI1O8tb0vaeaTRwuz67MDz5LyovRvCgiWKkufVBoBfGUHbQ4u75tFTcWQl+m5Kxty1Ue4P6Sw91wVEYFf9pY00tFN4KDUhV6NMavnVfet1ItW1+Cr5VJ1tYQccFDIJh49AIJ6ASJF/NtTPOxk3Fw0sCNM4A9rx2zdXZtu5h8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279184; c=relaxed/simple;
	bh=voSDFC64/9+eQufT2uKU+VGuqkr8JxCzAp6cWay6/CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkmzVnUetLli3qRAGELKYHYv2mXNv/VggY1vdypgb4vzLPqmjGiwRUYm96Esf8jMZdcvcEzIqQt8BOyLORYGFSRdQsoY13/ptB0HHNFLE1mx6No4TArmAKJ2HCZYIzG8V70njcOsvabBiFG9pN/jhNAqKA6qV+beaW5EsfpDyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXE9l6dC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bbbe94b88so4252585e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725279181; x=1725883981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYib0QMZaOs6u8Joez0VPTTXflKLuQwQvtW7hTM4gWI=;
        b=fXE9l6dCQuZLksRj/96Y1TlzaOFpoI84RuqiMvAZbEhnQuLWp2px0bQRmkjkXoA0na
         3H2yZvHtPUkTNgAa0udxJh8H0tN2ee4yR9vi+BLdGVyCmxnKcwvjEbmVjGr8LiMYB2J6
         AQDcKYMIFaOG3i8SLIiOb7/cqDFG3aCdK1r4MyRd35nGF3SgH3THyZn7rudOnAag/oSY
         gfxs52NO4bxeva8360rFXOEk4uar1EoYYIvQwGF41o98VL/jvnmAH+TlaRpFVR/Kqcbu
         MSdmE7gz9xxdheLuV2BlJy5qv9jT2jAVPyf/72qMWhW4xtT2+I6+7uiVbyVMPm6AqUyG
         G7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279181; x=1725883981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYib0QMZaOs6u8Joez0VPTTXflKLuQwQvtW7hTM4gWI=;
        b=ExgKpxu+3SIWUKs5yl+jy4bDKwFNkTx5rSdL21efWkLck5wm89zfjEGgV5UZRWysJb
         3MJwQ0+7yGZ5+y2/wOuhTqc0QmyL9JjPS/0SZN5KS+xt+ZtqFAeL07JqNckWkeND+sIc
         aCUA/ei/D/KmEOTtRHjmrh4XoXA/JtnisdvC7+RqrOjAqf6t00n+aEz3CcQlE5bVAEfy
         kkyJHmCz3mM5S8xNIDWbVqNx+L1ZwpRCi+J0tllYT5V13ithJw4mVV2FYZ2K/Sz7bLZW
         Xnn1k7I2MvRB8UwjFtn39H8Xq3cGV9YGY3LSIjs9SSWlJfvo3Mk1ZEOJC+4j9N68fs5L
         vBug==
X-Forwarded-Encrypted: i=1; AJvYcCUDHRVjdh9XOAH/yGiyCRmEsO7ZkXnj3XUFy+FR2xQ+DR3CzO0DFRhbqc8FKe3PkfNMeCbG8j44zKrfyVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAWB0jKSFz2xkwUH7rQah0Wp26dUvdRwBDcK2bJ2cPDcqTheFM
	1GAEYhAvauTy00xLH3AUnBAPpOWb8EmdYVFnG3AaaLH7KIKPL2acUZigQht0TZ8=
X-Google-Smtp-Source: AGHT+IHD310/3AikH1lbaJPSlXvik0ZpI17arkIZscjpxXSSdkSa4qGR1gYWBzk/DMz3/9ov+WQf2Q==
X-Received: by 2002:a05:600c:4fd6:b0:428:f17:6baf with SMTP id 5b1f17b1804b1-42bbb44913bmr42372975e9.5.1725279180987;
        Mon, 02 Sep 2024 05:13:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33d55sm138519735e9.41.2024.09.02.05.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:13:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] gpio: pch: kerneldoc fixes for excess members
Date: Mon,  2 Sep 2024 14:12:58 +0200
Message-ID: <20240902121258.64094-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop kerneldoc description of 'lock' to fix W=1 warning:

  drivers/gpio/gpio-pch.c:101: warning: Excess struct member 'lock' description in 'pch_gpio'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Rebase
---
 drivers/gpio/gpio-pch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
index ee37ecb615cb..63f25c72eac2 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -84,7 +84,6 @@ struct pch_gpio_reg_data {
  * @gpio:			Data for GPIO infrastructure.
  * @pch_gpio_reg:		Memory mapped Register data is saved here
  *				when suspend.
- * @lock:			Used for register access protection
  * @irq_base:		Save base of IRQ number for interrupt
  * @ioh:		IOH ID
  * @spinlock:		Used for register access protection
-- 
2.43.0


