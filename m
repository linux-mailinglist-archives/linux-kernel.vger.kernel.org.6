Return-Path: <linux-kernel+bounces-353286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C688992B96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774221C22C87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CBE1D26EA;
	Mon,  7 Oct 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tWfRtOXr"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D81547D4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303844; cv=none; b=HQtY2Oj3Ec0ueBDOu30SWDOE9US+DM9W1ZEQtuV7fjT296OZR6Kq4G6J375IlcexjOZgHrq37yw87kBC21bG4L3MQJBPEe38jrQO4LaYcVI6c9+fIqM1Arln+Z41+06Uny1Bg8mG9F/k1Nxq9q9qLNw38NHUu9kpYtnHjFcpH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303844; c=relaxed/simple;
	bh=ljxkkQiirnsTHdJpU5rItPvp6S0o8DSXCp5gNxL4BzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9sbIHEahqa1vUPpLlETBv3m63/ZFgB3k86FU8x/ctOClw3e8OjiWeRK2nxRkEO57hdc4mWyxG4CrpYZZk7YyqfWuK2Wsl3AU2Jzy5jT8HFqHAJAVLGQDUusA39lPFFA4Yr+hn0RMyeGOAm7cirFuY7yjM7S0//0h6GVsl0hTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tWfRtOXr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cd8972738so2953698f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728303841; x=1728908641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0x8y87bn5ImDPZMm7UguhM/GLub+WZyzCKBTUmGFdo=;
        b=tWfRtOXr54KCy1uqBGF7zCFZkIF1B1a33YpAczJsluS0og2+UTHVfa5Q+EIha4qztK
         hBs1ZB+NZwljLqcX9X/mgZINsRXdvZD16Mxj5aogRS/9DKXrVyFjsIblEDntodiEFFkG
         GvSUe0vdwChnzH1xC/8jiOFHMi9eYjEB5PxIwDFk0mzGKpS6UOdh7E1Bb3AxWTEyACP7
         O0MYmbFfLBApgSEvKzCCKWYqxJPUmyhZxyOrguIFtsb7Kz6u+nZCZpMasgCtvVCugT2S
         Wd4vzHsFjqrN5QKGQIcxQyMX+O4DNQ4Rq5je8ch/YFJsjUKhAbY66Hl0Z/cGkrHl39uC
         /NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303841; x=1728908641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0x8y87bn5ImDPZMm7UguhM/GLub+WZyzCKBTUmGFdo=;
        b=v9c6DuofiArllEhR2OXuoFbRKXOiWx4F6U98IsVjrjYAEearPJVUitfW1mLUvUbCvq
         62jj3wdzVXQD2Z6FhnguZ9hBOLryc5Vb1Yl9jJaZ1pCnfwhUr2t6YUKjCZJa1bWGztPS
         b6lP1/f4dRFAPDLJXTuONcz6uionPILYKXmBd8lmQgqlhrCnZ5iyFwQ3NoGMYWZ3Au/F
         7XaXjtRQS1gHVeftTLZACVCxNuEz8tg4uz8Omsj6eDF4dcKoJLhNBjGsHfRQYX/bPa+0
         vigk3D24vlohIC+1BKqTJYUIKRe5HFsGyo2jlmysQt2PyciXevwvz5eOFZhVEUE6lz2Q
         4+sA==
X-Forwarded-Encrypted: i=1; AJvYcCUhIwWgUqAvfbArEqb7uWpZ09vsIhMWW/3fYYwOKXsybFqIToXiKQh3SSCtHS2xzUjZCWypoyJUk0rgcgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1bOQLLCvYSFEU8JERsGP+z3bcZYe7JS1ECtJ5zO/7TnP6jV3
	tw9DQRzmB5Z5z1oXS4KQr9N30TvoLHPXhQ2SXe/Jc+tCQKhRIc1ZaYgObWJy2iQ=
X-Google-Smtp-Source: AGHT+IH7Z3gGU+OpbosbKN5JB3GncLHxrRWfwfdnT4hZxzI1DxGshRKwTaLqBpQOhnt6dyskjjSC7Q==
X-Received: by 2002:a5d:4a06:0:b0:37c:d26d:1d03 with SMTP id ffacd0b85a97d-37d0eafa5b9mr7222670f8f.43.1728303841039;
        Mon, 07 Oct 2024 05:24:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695eee7sm5626914f8f.82.2024.10.07.05.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:24:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] mtd: rawnand: davinci: order headers alphabetically
Date: Mon,  7 Oct 2024 14:23:48 +0200
Message-ID: <20241007122350.75285-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability, put all includes in alphabetical order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mtd/nand/raw/davinci_nand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 392678143a36..5510b39c0b98 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -10,15 +10,15 @@
  *   Dirk Behme <Dirk.Behme@gmail.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
-#include <linux/mtd/rawnand.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/mtd/partitions.h>
-#include <linux/slab.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #define NRCSR_OFFSET		0x00
 #define NANDFCR_OFFSET		0x60
-- 
2.43.0


