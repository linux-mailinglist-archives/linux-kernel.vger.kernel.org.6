Return-Path: <linux-kernel+bounces-510763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36370A3219A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E8B161E74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E691205AAC;
	Wed, 12 Feb 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nbQmluS4"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C472054FC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350765; cv=none; b=lIPTgvuWe7fiUd3e5bUKvaJLa5K2As1DCPgmKKSpCpN0kw+E14TDVfTN5UKUNpZ7dK7hG/Pt3Dub9S80++0Zn/0OYSLMXZxCOJdZMtKTt8QZCK2UbP2j+4CAGD2yWoW98gdpvX9UIQclGn+O9Vq1Czcj6oo76W3VglHiLRt1PhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350765; c=relaxed/simple;
	bh=k4EFS67+OSzd7mMGXZ6yWM2eULBPefQQnxTnKpQBiGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1VSXWrMLhRhlHH0jGWUhJQflWOpZxXEHGwhPy2leVBorlp4qmtQ8eWrmGTk/Rk3IN8c3ZPl4gTXAGny5iQ2h10UJnYxQjyGktlm6L/o+hxQH5lyR6MDOXBBOjBFuatPVc/uAOkw3j1F6loDbh3Ktyzj6rmXk2ewK+QeFJMGhv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nbQmluS4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43934d6b155so3530375e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739350762; x=1739955562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGTn43wFwxBQyxqbkwKJtGIvMk3JyrzFT6OLqV1izpk=;
        b=nbQmluS4nzLhnIiy9f3Hcd6ONQHKPoJjRjazJsYbJuDRg9nxFRtNTk5NssVAr/ND10
         u1u/YeyjwEWmr0o2H4ZarC/NXw0Uc8Kf/JBO/GRm4yMV8s6dqhpah1pdq+fIOA0McCSZ
         JvfhWr0ToB3PF5jB0bP9X6maKd0XKM0RInH4WYZ/ybSlyaC2sjIBEVgjqWS0nqHCSgdi
         cmSxS+ryYAdpoQO8EKxNWUYW1WIJi/wvWb8ZFON6QjX7GAJsfWgtT3W32f/rWiX/wA1v
         pGX6NvRJxOMeU5LRPWIQUnXDjXET8MOL52vU8neivZQhgC/n9dvEL+Hzt1bxZ8h9Snls
         /ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739350762; x=1739955562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGTn43wFwxBQyxqbkwKJtGIvMk3JyrzFT6OLqV1izpk=;
        b=kBoAX1hN+R8p15dcONzNklh296LJQby7+TpfaJfcIgkidRVXDQ11u9vCQWxc7X0Lz2
         BBlxJAo0Bx2u8PuJ40araE7C3mDwx/IDubBes997nOJl0VIGKmz2kiBhxOxOThzR+VEr
         QBt2sem0oqOuJmQse03IEFqQdp/wpXmqcOkqVkrE8FgQv1N+gN7tTRKXW09AyQfqtARx
         S5e8Kh4Ibgn4oXIWbPbS3i7qjhJ6iGEhA05oASnIYL1LfmSgX7o2cZPcKNfo2METM3tx
         7t5mdTgk4etaAKBSpPDgJ7DLq7Vx6YY3nvHUiqm1enPFwfcpENiP0Z2Wyd8jqczc6OUn
         +sTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGyKLPikBWm9jhoofHnY36eXhnC1+mWZUMaZ3SKu4kRXn+JP3ndb2Fp/uyZe2FJVmzJxv9Y8mfVCpMk+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrL6Kz1c63XP5cTh4cSFxM9D0ro2BCCixF5UtbBqPdswHTzvA
	6zlofEcIT3GuiL+aeM2jV1EtqlWpy6mWWr9utm4PjJgmC+MpOvQ8n5WkMH/RWkY=
X-Gm-Gg: ASbGncvbtAhHWYsRASF3fJ9ulclUaT2PZwN4wTl4M0MHAchC+SesSlmccOwZI/sIrhX
	QbwpVhqAS5owrJGFhXmcRQfuYM3jvS5chTsN1arck66h1Hp3ivIKTSA3fZ2XdXFCJCjkKodYHHm
	qXeLSi3YY+m7Jv1PhyPgXXWfU+Naut/YNXrHWh9TgaJb985DM4bTspCvoPL/yHryQ014iTRzraq
	qsAYzZ15iSzd93PWF4YOMQ4amJcDhc9xqL5BFZWssWdLAPIUiGqruXCCdkq7Xd+iLElY7xDj8kh
	j2dpcsk2/j36I0Q=
X-Google-Smtp-Source: AGHT+IEG3GeWGBdsf/djtVQU2OU7vHk9Fqxlcdeuau/EFRL0RMjo++ts4nycnHc+/7bfHyaPQRMzNQ==
X-Received: by 2002:a05:600c:3510:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-439583b578bmr18887125e9.9.1739350761900;
        Wed, 12 Feb 2025 00:59:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcef5c9c6sm12948568f8f.86.2025.02.12.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 00:59:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] leds: aw200xx: don't use return with gpiod_set_value() variants
Date: Wed, 12 Feb 2025 09:59:18 +0100
Message-ID: <20250212085918.6902-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

While it now returns void, it will soon be converted to return an
integer instead. Don't do `return gpiod_set...`.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502121512.CmoMg9Q7-lkp@intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/leds/leds-aw200xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 08cca128458c..fe223d363a5d 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -379,7 +379,7 @@ static void aw200xx_enable(const struct aw200xx *const chip)
 
 static void aw200xx_disable(const struct aw200xx *const chip)
 {
-	return gpiod_set_value_cansleep(chip->hwen, 0);
+	gpiod_set_value_cansleep(chip->hwen, 0);
 }
 
 static int aw200xx_probe_get_display_rows(struct device *dev,
-- 
2.45.2


