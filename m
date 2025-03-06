Return-Path: <linux-kernel+bounces-548466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE4FA5453E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79DF07A40AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7F1A2C04;
	Thu,  6 Mar 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jzT6y1Qv"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119732E3369
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250759; cv=none; b=m9AqwO4s/4zDrLC7BXNuXpnyftU1OHlbyTzUHNv2bLQUVJ1etI5CAM9nlSLi/ddn+y9vqdDSrNDyjqbKqjXav8i59BjN16tfvD5pCsWcfjm9QI106cuvRtTzT3ldX7jKGMVmXbmU01LK5wKdTldSQe6dgovPGIXHmtik6n74xuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250759; c=relaxed/simple;
	bh=2pC/NIK87ccSo1zsQk2KWs49NfbckgPjUxX+qp30qb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiFehcFcVVZqTtJElrPr9eN4uADYmBwxsruNX3FMVw1Xq8ckfnQlWQ5y4DP6jAnbGpy/29BL4+GKspaYiALVfoLk01skUxPoLEz7dkcL84ydGb/+bTsk3X6c+/KRi2XPLxzV9Awtfp8O1ywILtIuvU+m4O8m2g33LjsvYDiZbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jzT6y1Qv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bccfa7b89so2947535e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741250756; x=1741855556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=exM5WeQf7V88qX4aXEQgDj3AKfapiBe/11rzDjhEwBc=;
        b=jzT6y1QvTo3uJZg8unpTi902nJbY//c7RbCi7bh4lroKLupAd9uDtzR7084t+E3c08
         jnYZIIwCi3tpw0iaT57GuvTSj6RVjqGJ0n98dfGEO+2maI2rXwkT9h+P6zE9kBmhGk4k
         SwEVsHSLkAjQUMjo1C+fNNY1Xo4bTeIOyNGWlBDlnSBX4QiUjQp7A28bZJ0e7kT9DL1i
         1B3yFJnScWE+khxOVmbG1UekIHQhKOPaLJleIMOQPV5BHt6ewoZqla+NjA9Doj6Tq7Pz
         1KCjfQgz0PD/IFWfVKKHABvBPXUGblITw7537Z2OPKkDlJ0Osp9Qdf+LeZibGaitZJ8v
         3RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741250756; x=1741855556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exM5WeQf7V88qX4aXEQgDj3AKfapiBe/11rzDjhEwBc=;
        b=k9Lw+XFRKrnb9BfLJ+JRjFRj2S2uZpal2uHE9Vo4OiLXaFSMeKVRnhGmAcYz7lQNVG
         N0sc8lWavRKTJRoVpcFCCgauPWc4+kDfeMgsC+0vDB+6Ps15kQwhYupnGQbOD4LaS6NK
         2vmoTOKB2XFWuN6dsc0fP2LAmOPoB0kxBiTi1MQ81zeLpOwTsoVtUKyJ2dCfPhBbzQLO
         1V5eD0IYo3Md2cpiwqzPnSDU+cEwTsm1Qg+XNJbi6p8jzHqwrZ3fo3U97pvCZemPSiRW
         bQC+eG8zAKpNq3edwuw4OLQ+p9pKlLRQ0CKWwkAPU2aDCibQo6bZc1pQ70EPfVCZV1UB
         SJmg==
X-Forwarded-Encrypted: i=1; AJvYcCVGOxJz1MupoGwlHpT02nEtkISTbHDN5ji6/ST0hO7UrKdojeN8Whnns3qg9NAflL25x9pIDuUSuVF9K/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyB5VGzLunATbPvgE2+FfoAua7FoxhVow+rPKYc7Chuu9vMAV5
	iuSBM407090iREH5wpiVkpj1r8osOGK3xEVufugYdaPEmAp53NpEATITrUrLvZg=
X-Gm-Gg: ASbGncuByH/4HTpXIjh/Kvp1KzN/ggnRkKVVvAqVDR59nkIrjdbU5CgfehjesZlhM+h
	6oNrfsBqEesk/X03oVJOEjgckvv3ZEMlO5uwGN5ooWPRo1No1jQRzIm4zpcBOJxJhgllKOinZux
	ysVfzsKhVYN46DOUP5GqJMojlMr+inVTI1E63hY+BMwnh6uW0mqMRaG+eE3XbN2PajY4mKckwIo
	kirSDrij0qhZGuyjnPzO6nwgQ9/y/5qXmABNVP4+glDYfQxrivyAcJfqAypX20yoYhSi4iy90Ps
	Ex4BHfGVxAW4dpewzAL074IpJA9D0lncGLgNc0HOlH8=
X-Google-Smtp-Source: AGHT+IHDs91S0oaws6PWoor39yct8o1C0NI6ivNX/zDIW11OE8J6I3CdTUAnY4C9EKwnKsz0wC36kw==
X-Received: by 2002:a05:600c:450a:b0:439:9a43:dd62 with SMTP id 5b1f17b1804b1-43bd2ae5de9mr46019805e9.24.1741250756015;
        Thu, 06 Mar 2025 00:45:56 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ce13:b3e4:d0d:c6a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8dbb2fsm12631655e9.20.2025.03.06.00.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:45:55 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] irqchip: davinci: remove leftover header
Date: Thu,  6 Mar 2025 09:45:52 +0100
Message-ID: <20250306084552.15894-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit fa8dede4d0a0 ("irqchip: remove davinci aintc driver") removed the
davinci aintc driver but left behind the associated header. Remove it
now.

Fixes: fa8dede4d0a0 ("irqchip: remove davinci aintc driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/irqchip/irq-davinci-aintc.h | 27 -----------------------
 1 file changed, 27 deletions(-)
 delete mode 100644 include/linux/irqchip/irq-davinci-aintc.h

diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
deleted file mode 100644
index ea4e087fac98..000000000000
--- a/include/linux/irqchip/irq-davinci-aintc.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2019 Texas Instruments
- */
-
-#ifndef _LINUX_IRQ_DAVINCI_AINTC_
-#define _LINUX_IRQ_DAVINCI_AINTC_
-
-#include <linux/ioport.h>
-
-/**
- * struct davinci_aintc_config - configuration data for davinci-aintc driver.
- *
- * @reg: register range to map
- * @num_irqs: number of HW interrupts supported by the controller
- * @prios: an array of size num_irqs containing priority settings for
- *         each interrupt
- */
-struct davinci_aintc_config {
-	struct resource reg;
-	unsigned int num_irqs;
-	u8 *prios;
-};
-
-void davinci_aintc_init(const struct davinci_aintc_config *config);
-
-#endif /* _LINUX_IRQ_DAVINCI_AINTC_ */
-- 
2.45.2


