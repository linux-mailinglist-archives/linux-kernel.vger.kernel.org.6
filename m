Return-Path: <linux-kernel+bounces-441143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B19ECA43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EEF2833B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF5211A24;
	Wed, 11 Dec 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="u2vOGOir"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE81EC4FF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912631; cv=none; b=r/zi42TS9TLAeX8axvbPjpCNhfjPigHzGEEV2gd5q0ZtjQJlq2cIsTFY44N38huZnWc4jAVVlOaGF1hfY/mV5dYNh84C/qugLDBSJM8rY5MmLCqs8LxwKj1mMcK6Hcvy5+yGKnqvFb6WLMBp2sa3EHzWO5teoU19MgFMAXUK4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912631; c=relaxed/simple;
	bh=AvkwhoWiBNLBQ0DMxqKzJFjYJd3orUN55tfFIIyDd00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agH4koe/T6pAv6uMZ2nb6gYuxJk3+N6dqOC89qPkB2QIjz8rOKW2tKXeakOCMB6p/PNP1L5TonxCYzgc8cA1N4ZqD8/zIjZG0a3006X06nsREPyT9cDv+0wqfW0dQY1GkenkA5n6cOFvUPLTFkUzQy0qtEC8v2JGkz1R2AOQv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=u2vOGOir; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so2780175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733912628; x=1734517428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoYTxKIN+xa5B1OH/ejn5xfQpSaxCFnsi2/bPSTrz2Y=;
        b=u2vOGOirK819S0RuSFaLClgEbh7kJgUaQp1yNMrAef5O7rCRSRRnQRO3QFeNMB7BuS
         q0yoKwc6FuCIKXDUxVSTqQLov6gD17zYATWbiTwFr70Bt7M9MaWVwl/w0hYOG90foGqM
         HxqqB6fc2Z7kGQn0dE98K9BjVW4yMDLAZpYgMsGtDn4hth/xt/vBk69slj6nykH2IHDb
         kUEDiSK5r6N5lNX5pwvbBx4+V/ad8IKyD6W8AKgxJm0k05+3njbqlC+5YOGAtVvJDBn/
         gBFWUHQAadL0+zwQQMnaPGA2Zh4kDgZSk9p3KFKPm5hWTqaiIZrr0QXVRQBIty0TGRRM
         BXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912628; x=1734517428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoYTxKIN+xa5B1OH/ejn5xfQpSaxCFnsi2/bPSTrz2Y=;
        b=WwSIgCx8yuVCPRBn9JRKmuPWra/PxFhXelDnLccSsTFL5CBgCYIk27kn366KqtH1fm
         qWl9tXQvSnUMe6Nnva+NbFbpwJxI+9dXdU9n0NdlFaWDuguWIPJtqPitLxgBmLemyTnu
         PAHRdiwJcABad1gC5UAJd28vnjUrcWv04zhOcen0U0POMVXU4U6OKLVeO02HDHkCSpfm
         NmL1GOT8sNonppEp/tn3sWzk5jY7+jvY3fovmVhGZiW5Dr6xoZnIdQLZ4NrYmXicBwpA
         PAOMwr0FIxm+N6zq8iiRg7wqPNX4R7MX8cIZkZpl+ql0vIXXNmC+TuNPZSp/QhuDbaOj
         4JHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+kbRb3iwIgp0K3icGH9k8S0/iLqoBEqxyANTkclaqOeK3vDbEvWnGO8HLSp5xA9Ypl/XhjRFXoRt7lYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLo1SrSgupO+a43B8hgbt4uxYTNtbB5VFb2ca+1+I4nx7LXHlX
	Agy9+wX33b7srFWwlyHdW08ILfkEGgWIr4PTDw0/WyMgjJ87REDMmVWVmk8ZSL8=
X-Gm-Gg: ASbGnctywov9I05MajCcBDK0deIEv3dFzfQKPg8vLkkaXU2twWtlTuAC1nBb9QrxkAK
	AOYQ6VNG3rjIED0R7dsMtzpHFr4yj1iWHIGcOg062LykQEukHinUPUmqW8hGGHcHmuW8bzdQ09O
	WTN2HayhCwl3VMwmA2dzsedrvzJp/KjiMea5UbeAPXA5hmM9g0etW0qnVl0izTpOh1+1c7Bb1do
	E5xdQNauPqNmjn5L9WqkZx4UmYa5YOJlOB2qEGgnjWQOXxbFj8C2w==
X-Google-Smtp-Source: AGHT+IFbH76aSaMWfUWSLsltMf1aj67sgeQOV+1fX/o5OmT9HfAeHOm6psOWA85iumCSEI4DBs/c8Q==
X-Received: by 2002:a05:600c:1511:b0:434:9ce6:3ec with SMTP id 5b1f17b1804b1-4361c5b1b37mr13444565e9.7.1733912628390;
        Wed, 11 Dec 2024 02:23:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d1b3:c106:bf71:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514da2sm935137f8f.66.2024.12.11.02.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:23:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] i2c: davinci: use generic device property accessors
Date: Wed, 11 Dec 2024 11:23:37 +0100
Message-ID: <20241211102337.37956-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211102337.37956-1-brgl@bgdev.pl>
References: <20241211102337.37956-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Don't use generic OF APIs if the generic device-level ones will do.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/i2c/busses/i2c-davinci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index bab9f785eeec..6a909d339681 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -23,9 +23,9 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
@@ -173,7 +173,6 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	u32 clkh;
 	u32 clkl;
 	u32 input_clock = clk_get_rate(dev->clk);
-	struct device_node *of_node = dev->dev->of_node;
 
 	/* NOTE: I2C Clock divider programming info
 	 * As per I2C specs the following formulas provide prescaler
@@ -207,7 +206,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 		psc++;	/* better to run under spec than over */
 	d = (psc >= 2) ? 5 : 7 - psc;
 
-	if (of_node && of_device_is_compatible(of_node, "ti,keystone-i2c"))
+	if (device_is_compatible(dev->dev, "ti,keystone-i2c"))
 		d = 6;
 
 	clk = ((input_clock / (psc + 1)) / (dev->bus_freq * 1000));
@@ -811,7 +810,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->algo = &i2c_davinci_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->dev.of_node = dev_of_node(&pdev->dev);
 
 	if (dev->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;
-- 
2.45.2


