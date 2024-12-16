Return-Path: <linux-kernel+bounces-447004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C769F2BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798577A298D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3D1FFC47;
	Mon, 16 Dec 2024 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hlY5Jgct"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C871C3318
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337949; cv=none; b=Z/wPHwk3ExHYcks8CGTAMN1WLVS0hNl8xs0Miqmr9OijEifOCWdRL77/cLlOQNIqciQ02GtrNpNoHmcD44ULqp3EzxQ/5kQB85BgrZEbgEzoQaCx+hTWzwZLwlXA71WV/TOYE9PhAekNQ0RiYGfIDX1/1krqbkeOJMUxjWVwavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337949; c=relaxed/simple;
	bh=stz1SJq/Snyh4whvwTjwKWhJ4BJeLSUDWvVT8RfU/qE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAkCVClBy7IY4TVEwwpeVhBDQj8h1iT1wAJoGt2vOi6Xb7wEFY4GC/aTG129IEU6gfcVQAOjfcH7T3IYikUNf2LtyMzg6K29WtfWGcOJvyCZF2FESiCJCRXx+AU1yrFghUHkqGxvoo22kqQPr7NJR8Xu220Y4O44LZak6z0/XZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hlY5Jgct; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43624b2d453so42271215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734337946; x=1734942746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLkgv4Tj9vskkWftFwtwTzw0pR5u98oJo45zy3Xi1Q8=;
        b=hlY5JgctnfSuk1nBtsv+wZXW345ik8bsSvARfnCDKps0KGTfLVzWtiLYho3ZAWpc32
         BA18j7iR3W3JWuI99jJ0LJjSwZOEKB5Ah1+qMN0yexGQV1alcW4ux2NGpCwhPrYU+heW
         SrBzQLozaZce0+p7xqP8tqgtGAps/snsnfynsZhdX0K64V45VVeTgFyaRodjN9V1wlqu
         B+S/u0pteIewCF9WElgin98wO9m7OAiQ/jjp1/4X0Eccrl2dyDlNl8YDO9JNGX4LUeJx
         obTBEBZnXxnt5UNCHtdUaZQE+vc8HQLUCv/yjPvTafmys2fUzkTrpqoLTW66/XwubgP3
         VOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337946; x=1734942746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLkgv4Tj9vskkWftFwtwTzw0pR5u98oJo45zy3Xi1Q8=;
        b=N6wJ7TEQS4O3d5NNdmIVT9NInFNjWtEU0PiDz6rv7uWw2jJJkfeX9bMcdO+BmrcL6Z
         ID4gomYPmGSq4mpjLahvy2NtDzuFwktJbEPw6Jfis/sRHffp7MnPVlxvCSDX5lLnGg+s
         vrsJy1JbY9bDnfgR8pE9s232fQVzuQ9rGHgTHFgTZD+GdddLMR3kwtJ1q2lCA70BZdHL
         nyYpbczdqmhBTzxK79ZibZYsI1Gm1akJAnD1cm6WhXda8se7/GzBmcfjSalibe+Xph5D
         WjRpy6Tkezdh+lauk7gvw/dFnC4Z2uke9be2ORgxDT0CkUDS9goh3LS0ya4MEpfjAzwZ
         0w1w==
X-Forwarded-Encrypted: i=1; AJvYcCUpFFzr/4JUlt0rtNiDXIHy1ejDWAlhGUP3EtZ0Q142pTE6dq8hadCbhr5E5eQ7s9X8QdzoZ7A9ssNE93A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlW9MyXdy5tDfRchZjOZg83LzLbaNCaIZBH2OfvWNSEVx/1ygq
	nPlANGe6AuwchV4hZ+/8YVXRtXtKE7ttv2rrwfv/LlAk6gZHI4jvsKs4Q70C8YA=
X-Gm-Gg: ASbGncur82hN4J8vO3EUON34qzNyb1bZeRITTNQQeKJwG6xvesnXtJoIIX8Zh7wlVjg
	64W/Z5lu3lOB6is5D9PfxLctZNj6jXD8XYfP23iikKvHpNQNrmmjmwJYbe9c9X98GalRKa0nvhB
	ldzF3XWpCoFYYaC3gmXQKR+Swc+J0gq4DaZ7ajWUERVcsgbEobWoSxppplvzEtrbXyELajL6hWE
	Br/JYwmm1Lf7VsoMv+5TbRJyNN5l52+D/U7tvFb0MjqJEOoxQZt1Vj0
X-Google-Smtp-Source: AGHT+IHpEDK9LPFIzTbxV5qeAnXs2TL2pQ/3jIs5yECkuUiId6xGZT2w1z9K8k3JSr/vVH+sjvZBNw==
X-Received: by 2002:a05:600c:a089:b0:431:4f29:9539 with SMTP id 5b1f17b1804b1-4362aaa652emr93906875e9.32.1734337945954;
        Mon, 16 Dec 2024 00:32:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ddd7:943f:c7de:9971])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm7384843f8f.57.2024.12.16.00.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:32:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] Input: davinci-keyscan: remove leftover header
Date: Mon, 16 Dec 2024 09:32:17 +0100
Message-ID: <20241216083218.22926-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The corresponding driver was removed two years ago but the platform data
header was left behind. Remove it now.

Fixes: 3c9cb34939fb ("input: remove davinci keyboard driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/platform_data/keyscan-davinci.h | 29 -------------------
 1 file changed, 29 deletions(-)
 delete mode 100644 include/linux/platform_data/keyscan-davinci.h

diff --git a/include/linux/platform_data/keyscan-davinci.h b/include/linux/platform_data/keyscan-davinci.h
deleted file mode 100644
index 260d596ba0afe..0000000000000
--- a/include/linux/platform_data/keyscan-davinci.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2009 Texas Instruments, Inc
- *
- * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
- */
-
-#ifndef DAVINCI_KEYSCAN_H
-#define DAVINCI_KEYSCAN_H
-
-#include <linux/io.h>
-
-enum davinci_matrix_types {
-	DAVINCI_KEYSCAN_MATRIX_4X4,
-	DAVINCI_KEYSCAN_MATRIX_5X3,
-};
-
-struct davinci_ks_platform_data {
-	int		(*device_enable)(struct device *dev);
-	unsigned short	*keymap;
-	u32		keymapsize;
-	u8		rep:1;
-	u8		strobe;
-	u8		interval;
-	u8		matrix_type;
-};
-
-#endif
-
-- 
2.30.2


