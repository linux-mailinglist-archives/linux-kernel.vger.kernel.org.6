Return-Path: <linux-kernel+bounces-536679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C52A482F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81124170D33
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEA426B2BA;
	Thu, 27 Feb 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tkEcuOSk"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F22376E1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670119; cv=none; b=n2fTQv1Fc+G23apP6FXldOzsD4j4c+qf/D7hCZ3nfKUHh40+g3Ey80F3bho1SyqTmXtwg+NzSaU/b061AlRY8CasFIi9+ffoHsuMiNOwksyxn1djzUYwtT4pRzUhTWjnDNV4tS7t23PrFXpEq1ORV5P5Z5Jf0K3ZR4We2uN3EEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670119; c=relaxed/simple;
	bh=BStIM3Q7aMRwq331CSOFWaO4WkNTxhb2jNd4nMSki1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abGgb1J77diB0vVBBT9ntecirlohQIrtSWmaczn/ARxmsts4dhPW9bzghrEPn70//BQ1W/FCip0J42sMzR29jqG3cLGi/9yPQG38qJ9cX7wiOrsTQ32nwUI6XzTf+oFZOplz5WyN5OMdcucfkYfG3bfwLLzqfRuf85GP1TC1lfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tkEcuOSk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43994ef3872so7794315e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740670115; x=1741274915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7624OFG3qUFRR8VK+5r19R1qPbs5o2C0+F6XuFtMrc=;
        b=tkEcuOSkhHGDdv//67ud61P8dBDyAHjDRfsqECkXBxx0b9bBKJ+zHQYNX/Yl2CcgzD
         YQqkQ1NGpuAAiZJisv1PQurQum+U5zm3q8uTDHr6bl57X0mZD8ZM+KBEdj1XWf2ElLZT
         N8bbtOrIA9Bw+qF14yoEOWCbCRksE6VNkbv171PNam/om4ZgtZfG0fiLosd9jPl357KC
         olC4D1CShktQ7EyN5mEckX+cdaNPsNGGsnSHO2V6ERAPmNuaAQlGIC5ledpXcZmtuGpN
         JvWQLBFbp+hv0ZFa15cbPybBxDRlimLszMTWdbetniPJ+GUqUHGBtQeUqMB+fiPRHXwD
         2QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670115; x=1741274915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7624OFG3qUFRR8VK+5r19R1qPbs5o2C0+F6XuFtMrc=;
        b=UM4l0ykduRhWNPnkfTTKVZCQgj/L7RrRqRkkzp4CyIgpy7CEUMl33F4vRrqR/4AoM4
         HCT9EEA1RuOz4GVMzh6q7LyLTyKLT/dUEWCN15pItCjIcjVbU/AzwDti1MPm20lDXZpA
         1dGjvALYvl82Hi7gFvHLZIiR5mINA3h+66m38l8d5xwKrw6XwkmGzyuCRVnNz3eG2VHp
         XFHcD9snn5piF6IBDf2FHFNDuda6R6XzqyXKpvSsE4m1qa+O8CQdGrzyumoleOZNgyar
         MwjqBQHqnNJMADyIzRSguK63uuk0EXY6Bco912hT5Wrw7tYZm+gGsdVgP6/xgWzaenxI
         Bi1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0RoxmKRojYC0hjpFCOIRQQUnXC+KU2yF6AaxTZb1PfIu+JX+lCrHbmGcgBOs9rE1JVdxyOEwZ8DeEBRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4l0N4vmDAumiar0dWMpC43pCanM2UPtix/Xs/cXR3PfoYM3s
	4/ZmuZ1IkrclDvJVhlAcoHfvpctQEK5uhylQW+zXGDZPomd01g4SPLxue+fBOHk=
X-Gm-Gg: ASbGncs3fHYMdYGD5SYm7wbY41gwVtLtPNOvRmlZCc9fYZ8OQtCCo1MKp6113df1sWH
	pDwRlHliWDpJmzBJ5iVrUHGb4d4cX9hdtij23jnXaJWRspJbLP86EMjAEc8ncPxM+e9k/Y5jgbD
	mrqNZ0k9s3OYm0umc5S1JLy4bfOE682cY+3PXQ2sJVR921p2YQZbRlLQOGKUUXEtfTpNvm1MDjh
	OucbqQVQJJNLDN2WCoh1WsejB6YYOci+9sWbLNxVBy7msn1OYJVvpuouj74vCSeY6q8j8x6cg2i
	naMrlly3+5cMWmuNaQEqt4rztA==
X-Google-Smtp-Source: AGHT+IHcKD1/SdfUB9xzo7Is4+i7lHq2eb7AMjlPIjV3WON0VG0sd7gLXvwwR7Rnwswx9QdNhmKzww==
X-Received: by 2002:a05:600c:1387:b0:439:9f12:1809 with SMTP id 5b1f17b1804b1-43ba3b47d85mr16911445e9.20.1740670114206;
        Thu, 27 Feb 2025 07:28:34 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b50f:c403:bf52:2dbb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm26179345e9.18.2025.02.27.07.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:28:33 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] gpiolib: remove unneeded WARN_ON() from gpiochip_set_multiple()
Date: Thu, 27 Feb 2025 16:28:31 +0100
Message-ID: <20250227152831.59784-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIO drivers are not required to support set_multiple() - the core will
fallback to calling set() for each line if it's missing. Remove the
offending check from gpiochip_set_multiple().

Fixes: 98ce1eb1fd87 ("gpiolib: introduce gpio_chip setters that return values")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/ab3e42c0-70fa-48e0-ac93-ecbffef63507@samsung.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1b4af0f97e5a..6cfbc8869cf8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3608,9 +3608,6 @@ static int gpiochip_set_multiple(struct gpio_chip *gc,
 
 	lockdep_assert_held(&gc->gpiodev->srcu);
 
-	if (WARN_ON(unlikely(!gc->set_multiple && !gc->set_multiple_rv)))
-		return -EOPNOTSUPP;
-
 	if (gc->set_multiple_rv) {
 		ret = gc->set_multiple_rv(gc, mask, bits);
 		if (ret > 0)
-- 
2.45.2


