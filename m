Return-Path: <linux-kernel+bounces-358491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7B997FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 094A1B265C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFE320606D;
	Thu, 10 Oct 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wpYPC3OB"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BD1BBBFC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547437; cv=none; b=I4iQqYWglaVwMtE8QYC2wqjOwxNt9PE/czsBLkLk19yxW+tsqWj6kXA65x5smmyigNbE5mA4j72pRPkzNXscA1+IRc5+JO05ZTVvWvsNisqN6SkQ2mVxpSreFFgxW64itHp9mcMlOV0RCRO9cipuZGD3KOd8zICcNyrOnbXddBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547437; c=relaxed/simple;
	bh=4Hnw26mcyPUG+bSpHqaDPucCGEMOkROxTInnOfHr5og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvTnFdckE7AkgPbxq8dBE2Nopb9uXXBvW73pHkw2fVWZlWyJMzeUf0oW3YOAbM3WiSlr5hrLwr/uRkzU9ylbASo3OT6USI8QSwwzEVHrntPWJD/z8PeIGQHCrccSwUCbde3e2lKNqwTMECRI0BWqfrEDUN+jib6XWDvf3VZuCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wpYPC3OB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb806623eso5271155e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728547433; x=1729152233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOHSJVTdLAqav+eEKmBbCxq8KtaWLAU67BYMtt/w3UU=;
        b=wpYPC3OButPHmA6BVhV+k/lYYKajzMAHJNvoisJtwzj37RXp1xjdmPEc7lbHt89iLX
         HqDs6oqumHMCQHWloD4nn2K/SjpYgLK47EFp6vFsaNmm6MZeB8uGABvAIi7Id6wlIIL2
         PKJt645vvQVi6gURdH6tv359HZ049enA+EVUn6KfUZEQBfW1sn1mcE6MmA8F2M8k5uId
         dvh+k3T7/MnaOPNfg49OmpyFx2/YGVpJwfHjgGyWzx5hgjKYf/mjYEIlLZbuLUlHaWWX
         BXvVsROnHnIEdQwXfiW+3+bnogwDXG+XnGYwZ95gOHbPTHfLcMIWkVnDOjuiod6Ngk98
         QLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728547433; x=1729152233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOHSJVTdLAqav+eEKmBbCxq8KtaWLAU67BYMtt/w3UU=;
        b=uMwJct4Ft4EuWByhOZ9ZSgvPDjhljv8LVEEFGfuar5Sin3HKE+NT3a9VcS7PAcb5Of
         gTYYAfDy7hVWuRUQSFwu+2ZTkQvZvBEgDJ3KiHGsJry7arHxSrzW2UWsi4ZfyDLSDUEw
         /FGrvrb0pF9tYH+My6y3kFs6gEqy8Rs0meJVB/4lvI2y3zI9Tn8tpQaj2nZ/A5dotxF7
         UuENFEu4OBPAsHsrK6vnJ4myqxQx4d4ZFD5n/GnvBGgjitvlymA9Ez6kRHKJTJ9DaLDY
         xhGzMrkrpRc+lEQDFbG4uTfeWuOySE81Lk3qwZCcvND/EqKWcNdt3KACZPMdyVSxOJVS
         clVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO/FcpqABCZiiZmA9Q4jVY0k1NkZ8/DthWfYtWalWKruPv3rkzWccDBcuebwkyIdUIsg+J2ccBUsulagM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3HqjsybRm4XZLh7Rxqf7A80smYfoqloDiw009VLjZlAjc7hU
	EsbOMAxfI6AlFYXjh4zvDqQx598o6RVCyqFB5KGjm1ayAvv7QxbfF9c96xXIn4JBBpVQVp3qy0c
	j
X-Google-Smtp-Source: AGHT+IEVjmNCPCIiHOq4s9rPIdkzMfu4AW4u4I1oaeC0njtcNkIz+cNZ/lJCbEU3ps1f+YR/oUmeiw==
X-Received: by 2002:adf:facb:0:b0:37d:4aa5:eaed with SMTP id ffacd0b85a97d-37d4aa5ecb4mr1052794f8f.41.1728547432952;
        Thu, 10 Oct 2024 01:03:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5e5d:bfca:20cc:60ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fd90sm776097f8f.79.2024.10.10.01.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:03:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] pinctrl: aw9523: fix kerneldoc for _aw9523_gpio_get_multiple()
Date: Thu, 10 Oct 2024 10:03:47 +0200
Message-ID: <20241010080347.7759-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The parameters' descriptions are wrong, drop the invalid ones and
document the ones that are missing the description.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-aw9523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 5cb24c1dcb0d..9bf53de20be8 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -550,10 +550,10 @@ static int aw9523_gpio_get(struct gpio_chip *chip, unsigned int offset)
 
 /**
  * _aw9523_gpio_get_multiple - Get I/O state for an entire port
- * @regmap: Regmap structure
- * @pin: gpiolib pin number
+ * @awi: Controller data
  * @regbit: hw pin index, used to retrieve port number
  * @state: returned port I/O state
+ * @mask: lines to read values for
  *
  * Return: Zero for success or negative number for error
  */
-- 
2.43.0


