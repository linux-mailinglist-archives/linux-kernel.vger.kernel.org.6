Return-Path: <linux-kernel+bounces-237987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3A9241BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C257B1F26DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174A1BB6B3;
	Tue,  2 Jul 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnAMx7iQ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83CD14884E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932481; cv=none; b=e/+f2btvk8BrQ5j25TXX6qiyzYR24Lcj/vkhw88Ycj4AsZypOghL20owG8dnuk10/JGb3L3F50DICLs0Mj9kPiO/3KIULYcXZsRxWv2VKdtijC/gJ7XCGYu8WWT7yBWgVDXR5GpmC3Ljc3aIr0nliLOitIGWJvTVTUEq25ENOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932481; c=relaxed/simple;
	bh=831tu98jKFCFQ3uP5sVH2PjPbyOqkBN44XZyqazKP/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YJEHpefEUgWRULLrtMxUpuV/HcsRA935k+LZDjGBy2pSiCbN2alyUqAJOuNTZoJDPxlTZxVKUhzLf3W1jeHWFZL5atSbi/x9VxWiWy6FFUGrCMddF90Ro6nu3anct9O/DUeczXmCwXDmIbZUMWpsf3RVQZdLBq8m6QCv5r9J0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnAMx7iQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f480624d0dso32539915ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932479; x=1720537279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kccJC5x8mJGzE036SHnXkNKeOkpSU8i0/myZGjFkRi8=;
        b=EnAMx7iQu5f8tYyjDqz95RGDeLzdusH+szsbdo7c5aRg3fBePh/u/i4YA4t3WSmhrX
         yLs+16WoR4xbdJAGPOTFSpV9PDT44UuQI7NP06mWC6FjLUrBwMAusgpJLMiA2uY0r6xn
         2+d3JwUGJ2jZ+OD+ibBjutxHeIfTLK9k1ykE12I8vxC05KWTdpWqfe6ZEjZxpB4ii8J3
         XENQN0oleS5cjqqDg8VfE9/ZaoHOAYaMBHuAs5+Jz5VxJH0UOz/MJQAr0DirllHa5O4Z
         7/joCW4HlzID8wm2WRQ9QaIlmn/kD2ESJimXZASKG8SsIz+75sOkZrAgyO/jAcA16ohI
         wKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932479; x=1720537279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kccJC5x8mJGzE036SHnXkNKeOkpSU8i0/myZGjFkRi8=;
        b=ri5+WQruV7rl9JPuDKnnkCH/TjmNrj1C49KHrJG4E3cJMEsvPHf2lkNJ0s0719iNf3
         WMwUi8FYk3ID1zbN2FMn7vYXywSfMR9aldVjnYK+O55PozA7r6X/y5X6q1N9bAXLEk04
         yYMTU39QtDwGz0iGLK0AnLzCbZrjXGXMW8Y8j5OCH470M9bYLLO9LIvFGQYXb229rmLn
         f2gRlp1zG4hBiD9kXCL63RnlnhODapOyg3Zk2A/IrWOEEyngc6+YgM8paDiPiCpqR9S5
         FBjYV2HbeynkzbzLnmjUbC4m4rkQ1OHaa9n749a2z/u7k9uBfsohtYUglbSJJUx4nPkL
         B2fw==
X-Forwarded-Encrypted: i=1; AJvYcCXQgP4Ke43Jgc4Tn6D51voHe+X4GrJ+zfyDvyz/jZnJUh0J18Vn8LOdS3GQzHOFz5BD2pngayeRJuAAAIiTmGQZeL1aaPBE3wonsv4L
X-Gm-Message-State: AOJu0YwW/Ohm2InU9/SHjrdi7VBG/f1nC8HDO2yDcCDjz8f1oee3QHDq
	B/mTftbbOTZajh2+rTo5L2TBZgrhUetVKMen91d17DTZ+LZHExro
X-Google-Smtp-Source: AGHT+IE7mDrMbY3nNfbC0OUxkT91CI3YYSTu2s7yLJufJoLhDvsBQaufm8doEdyDfmd+GBWU7/FyWQ==
X-Received: by 2002:a17:902:e841:b0:1fa:9c04:946a with SMTP id d9443c01a7336-1fadbc5c2a9mr90903915ad.1.1719932478846;
        Tue, 02 Jul 2024 08:01:18 -0700 (PDT)
Received: from dev0.. ([49.43.162.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf92ee538sm15371925ad.274.2024.07.02.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:01:18 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com,
	julia.lawall@inria.fr
Subject: [PATCH] gpu: ipu-v3: Removal of of_node_put with __free for auto cleanup
Date: Tue,  2 Jul 2024 15:01:09 +0000
Message-Id: <20240702150109.1002065-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove of_node_put for device node prg_node.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-prg.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 729605709955..d1f46bc761ec 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -84,8 +84,8 @@ static LIST_HEAD(ipu_prg_list);
 struct ipu_prg *
 ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
 {
-	struct device_node *prg_node = of_parse_phandle(dev->of_node,
-							name, 0);
+	struct device_node *prg_node __free(device_node) =
+		of_parse_phandle(dev->of_node, name, 0);
 	struct ipu_prg *prg;
 
 	mutex_lock(&ipu_prg_list_mutex);
@@ -95,14 +95,11 @@ ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
 			device_link_add(dev, prg->dev,
 					DL_FLAG_AUTOREMOVE_CONSUMER);
 			prg->id = ipu_id;
-			of_node_put(prg_node);
 			return prg;
 		}
 	}
 	mutex_unlock(&ipu_prg_list_mutex);
 
-	of_node_put(prg_node);
-
 	return NULL;
 }
 
-- 
2.34.1


