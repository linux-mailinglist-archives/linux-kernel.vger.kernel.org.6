Return-Path: <linux-kernel+bounces-441144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220249ECA42
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC12164BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D1211A28;
	Wed, 11 Dec 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y6SD1s1k"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214EE1EC4E6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912632; cv=none; b=WbseXO4pD8+gSRyva6ksxrcuYG7WylARpfqFHW5+QhZZCrI4TL3JdtOJBkMhhWmZZGEOoeMfyIEnhYr/RUVTWLgQGrsOIwG/A7xbN7vNNgIuNzV7SPUAbA9nkNAEGiKbGkVuyqttZmWz2QFX0ohAxksBoa4pIk13/LRQoC7pVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912632; c=relaxed/simple;
	bh=GE9nHhh+tAvrTDd3Wg4VS4ZKn+ysGa0R/sXj1ES1Tx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pojvnwP1ZSgml8rlvUFLPFtuAfg0kYdPv+4aXZ4lCjVmVDVaKMZlCTsbd71Ym9S+Sl61Fxbu/8oaU3TNgOsg+2bmqPMSYpwtWJ4zwtf8y8+3Rk+8u5QEsWsMyrYRhaBYuZ4H4my+FhP4pOYw3ulO1GY4BD1nJl6wUhQAi8/W1Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y6SD1s1k; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e27c75f4so4776078f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733912627; x=1734517427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTKqCe2SELpX+WlhYxUqap5glecVBp4pq97MmKxgypE=;
        b=Y6SD1s1k9l4b+NTA/O1xdNrVp7nekZ2FOa7XLIlPFjzP6LYhWXrzL8ScJ3/udSyDxa
         KIode21kOD3Iv4RSVtA16qSxU3z9Kq9/uLIFQPMMuSy63oq8zppi1N/qqBZkqu2UPXm6
         Y54qeHaYJt5HN8YnUL4gwFTowZmW3KVtLBQ4TMHLvsOQjufmWVMu25PJEX4D3kOqQwz6
         OKD8habDl0x+WZ5nufIhvKH1UHxns9FL6NqLwrkSphuGkMa7ZRx1Lj0GemXJcxF6z6J2
         GbWVjwyUWVpsPRA5+9Ba7KMBA4QOyKU6EV/PPrCpC8b2T1NHaFbOzoeEGS4OprtU8Dyu
         E9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912627; x=1734517427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTKqCe2SELpX+WlhYxUqap5glecVBp4pq97MmKxgypE=;
        b=A2aXZaU5T5xCfpUPEzBE5xirLlgxJQAhJxHfVnLBdyKdfjAXKwYqv17nXxE3znuULr
         ktWml8DoBvKnGocoCrKYr6JweJmdXpm3zYzcbER178xQjfTsCocsNcvC+RHTAokBt8YN
         WBftRfp0ofgP9654OfAdVag3xnl6VlYpgKXa1moW9ySD5V3X3ecVh2Q/kOqf6ZanTAZc
         k3zn5vMmLhko+z0cqzm/+x44pMYxdGTiuyKfjCq1HtUJS4gWg1YE7wRP4I9iPubzmDz4
         wSm9ijWasBJJPofISJNnXOGFZvQvokw/ggbkzfejkwmZBDtNFp/cBRQBSU0UcF3T5oOS
         tYGw==
X-Forwarded-Encrypted: i=1; AJvYcCU/paCxvtxC0dxC6xSY14/y6d7hei1/GdUjsF70kjvy1cox/foD6VokgwPQptM76xTj2qIrhd1906AE36A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbUR9k6phGhFrtJbtORNc8Cx5aP5q+rP0UXnlpPYIkTS/dRFh
	TMa9DPN8AzNeufIGREPu2a43UQ0dMJ/z6gZ3C6igIq+JjWev6fnI8vSNSpM8TD8=
X-Gm-Gg: ASbGnctUyzVHDdGfEiAUIBWFwtQqXPZl5mjsOfUOQ0tXYnL+ArEhf5gWONgwqOphwLu
	WyP6FzjGi5flGTGsU5LEtAoX3x/xC71B3HoxwLi8b6ruhG1rVrIGuLL0tnhRLe++zLj6e6lJZ9k
	jYYvc50ZUCDGophDtvgRP/sOFwTeX0owGs6orzOXyRsw3MCOMT9KMXRl9x2OUX4DR8fz+dW5VJZ
	uz8zRZj1iMVBM8fKW1eN/Cmz/lFh3qrTY4NvhRLqdgSldrhbCzP7g==
X-Google-Smtp-Source: AGHT+IGb04BT249VC+YXzPYDilPJen43l7hFegMSZVIrm1PY3iqvihpx9mzJpwggyt25syAnQKuRgA==
X-Received: by 2002:a5d:64e8:0:b0:385:fc70:7eb with SMTP id ffacd0b85a97d-3864ce7fe09mr1468743f8f.12.1733912627500;
        Wed, 11 Dec 2024 02:23:47 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d1b3:c106:bf71:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514da2sm935137f8f.66.2024.12.11.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:23:46 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/3] i2c: davinci: order includes alphabetically
Date: Wed, 11 Dec 2024 11:23:36 +0100
Message-ID: <20241211102337.37956-2-brgl@bgdev.pl>
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

For better readability order included headers alphabetically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/i2c/busses/i2c-davinci.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 4b499931fdfd..bab9f785eeec 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -11,22 +11,23 @@
  *
  * ----------------------------------------------------------------------------
  */
+
+#include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/clk.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/cpufreq.h>
-#include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
 
 /* ----- global defines ----------------------------------------------- */
 
-- 
2.45.2


