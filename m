Return-Path: <linux-kernel+bounces-546536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB80A4FBDA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE743A8743
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0619E2063F3;
	Wed,  5 Mar 2025 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nYmC+BP7"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001E205ACB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170443; cv=none; b=WETVZn5xkpsjYb25Gbgy91qEl9PIHGY11iBESrTDpIU9jYOeqdx1EwIImiyt/fUg4jN5oA1A7astW1EONxcp8mfKRAEfwvhiaU+DSUGG3JZXz0onqTBEiQFhp8KK7UZvzlotW5XFOdeQ5RF4FuamtZKU9u8epIUddur5yfe8vls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170443; c=relaxed/simple;
	bh=LHkL3KRuNaccS9Vjluq7eDHrzCRV9vjozDXsO9ZgV+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1EwzZI6lKyezXQOgvPvtIr3s08KyVXxOM9fUJ++V14pTgXIiPiGnTKOttNT/NxdnQ+rsumX66detcCSKusFyx2uGGkl36zh1+RoJGrPbMcJR235Mh2HdPTsf+tF3leKRijOi+zhlP3B0IamY5VZTaKvaD9qRnQxxA7wkpPXnHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nYmC+BP7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bd03ed604so9326665e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741170440; x=1741775240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCPKjpK6VO4lMEf73NVEG6/3JrmmaR4wPO/hIV6JAAc=;
        b=nYmC+BP7w4WH460ckaprL5YKEhl7UwFGzh/QUcBNwvABAMXv/NIldeaUgTxIDj3UB1
         DnO7nQj7Wvc4QQAM/qoYiomSkFyAAaTxHeLKqbCoS3ZYIu7uCQ0JAi7BsaAyP3TenCQ/
         eTBLNXt7P77lbLwL6AYghVJKctUhHQolNXp/SDN0Vvw93eqisvqSgNXD5awD2br0tIMN
         uWjssKch+9HvUARyUPdpU4S8VPsGYHxCXCTwAQy7oIohhQbdopZ27w1zAVWx9QpTQ3Ud
         zHm6ckL0FOl/yCRQQp35ys9Yi/ovZa1/UpIU/z8SXZmsiptaKjgyvb0vVcIjQmpyurk2
         kWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170440; x=1741775240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCPKjpK6VO4lMEf73NVEG6/3JrmmaR4wPO/hIV6JAAc=;
        b=ngDhYpJc8uPQTA7LuZu0zUWoja98IKipIZQy6J5Ch7YIpjLyyFoaaVW+O8Q0YaI00t
         YFLV95FCb0/pTjl8keKB8+mSMk5C+Vtg5ml8CAGKeFKgHHaF6YIkksCg/ZAjvyMzRojV
         dueNUEwL9g72N0ATCsxubtUj3Aw8oz3RjFfbEhtRSiW8lCaqBXVaoqh9J0KNQiVHlVGa
         EY2kKd++JNvihaiw0jHI/ZBgVvyX/MSUl8nvzSdC4JirNYE6PWLZogf4K/QQVTMssaxT
         KdAQjYGLLsyHSKf97TD7KvuGbtLV/Bau1kBVzL9tvjVBwfCng74iVRVZHCIHwo5tFTsq
         +JRw==
X-Forwarded-Encrypted: i=1; AJvYcCVqaaKuOSHU7rxth0PBcz58hbUB+sCBWHt5hX86O7e32pMFNXeQ3tJnTOb0YvUQhgTfJCe2xwqny+VLg5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9lIoKKwItivZA/HCXhuKB26SdXKw90+PP2IbRQhrpVCmfswx
	zGq0OMFybq69oBpgdVZpgVfVxPxRmDxcjTQwWoug+fFtSMTXEVNXYgy7vv3Vhmc=
X-Gm-Gg: ASbGnctYKIhRYvKhx31ZBnUERp0usLVYxSlXHxLKo/vdB8hbL7UGuufdXNKVg30tEqB
	nbaRvKmz+J2qnqJprNpTfIo1ymDrjUipbnIaGS0wEThbIN5prv+jMsNl6eNLm3JN+chdbjIU4PY
	rUBRdYVZYOdG+Mvdgnwe0BalmhFf3xWAs7cGah3cmvqH8FFYfIlIU0HD57pGxN9S0H1wd9Y7ELJ
	YFVuWVt9lsNPBlDPXb0EiuW9CZ3szZpgzPR6wsW9pIOViZz4gw4ESkhg/v9lT9MVE2VzaPl1+CH
	+BWXT0JPfPbzOp1Z2XygXn37WRRL4BKIyA9Yy2kuHUhI
X-Google-Smtp-Source: AGHT+IHMvKES4+39p/GD/gutXcsrB/9GUV4+AbW8RNvVpOWUIzKEe0uSKYCHBVcKeGfHAgKJtsSHgg==
X-Received: by 2002:a05:600c:5120:b0:43b:c316:1fee with SMTP id 5b1f17b1804b1-43bd298f96fmr19612845e9.15.1741170439670;
        Wed, 05 Mar 2025 02:27:19 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e514:53b3:5af8:e408])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485ddedsm20185004f8f.89.2025.03.05.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:27:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Yixun Lan <dlan@gentoo.org>
Cc: linux-gpio@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] pinctrl: spacemit: destroy mutex at driver detach
Date: Wed,  5 Mar 2025 11:27:10 +0100
Message-ID: <20250305102710.52762-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The mutex initialized in probe() is never cleaned up. Use
devm_mutex_init() to destroy it automatically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 59fd555ff38d..67e867b04a02 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -9,6 +9,7 @@
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
@@ -749,7 +750,10 @@ static int spacemit_pinctrl_probe(struct platform_device *pdev)
 	pctrl->data = pctrl_data;
 	pctrl->dev = dev;
 	raw_spin_lock_init(&pctrl->lock);
-	mutex_init(&pctrl->mutex);
+
+	ret = devm_mutex_init(dev, &pctrl->mutex);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, pctrl);
 
-- 
2.45.2


