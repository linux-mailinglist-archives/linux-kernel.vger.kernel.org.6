Return-Path: <linux-kernel+bounces-348872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5498ECEA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7FC282B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1172214A617;
	Thu,  3 Oct 2024 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbXY4VMa"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A31B969
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951197; cv=none; b=rIMa1zWXaFvco7V45xQwZ9HHwVHqmNuxaovn/6YqlCwacDf95cxVjRV+yZCxyB3zxTVVfL78jp5JpZRO9/Pwwr4YMQJ1Ps00qnNG+OvjHNt4dZ4IWUe7M3WgNlfvr4KwUNRm/G4/JBIdOWp16I6J5PT0xYvngZMB2eOBJNArHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951197; c=relaxed/simple;
	bh=FxpyQzoh912sS3hqD9kd0r7Hy+Y/txR7kzHQsiC3DAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qs/3TLJx93bLYQMJI0HsDwp28AoQ9StYUDQTNY/lYNL2QEgCeNxFJMXdU6KQ1rmqEPG0bKSsIh8ao6WVd0qOtTm9EnmL/vGh4YeDVaONfAZVRfs51KJqLQY/5odCknR1D7k9IlibOOmcYM4IvGqn2ePy2JxuuQ0bWwRAfoo9rCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbXY4VMa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b84bfbdfcso12675085ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727951195; x=1728555995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDaF4ZaP993V4kYD6pYXH6Xnw0kgfu6U+rAc0OMJWWQ=;
        b=NbXY4VMaSmJKi1cugbQCF36GSa0m3+97XM5gcIeyOFbwWKzVAj71nnszdrpKuSdR2p
         qn1/f5jYjsT/knn196Dc5qavUKNlwbNQWTeRhhKQRiUMTRCbte5in3BICxY2Ssvad6jP
         Zavq+XaSLzHXOtH2F+RMpi8rYUoXNlnvEE0GFiW8occ+tLxFlQxOHjSXOb2dL8Ba3GsI
         UyTfs9LqxnxngMfZk7r5YRZcU1DIHwfeyrefWfEQGOHDP+m153VUtseiKpB6KwpqzVnQ
         2tNTFyjLzzh0icmqiqe3K7n4aCYshBv3vl06TNhlCEW/jKOBxGS5M88gwvPHdjvf+E0i
         u3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727951195; x=1728555995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDaF4ZaP993V4kYD6pYXH6Xnw0kgfu6U+rAc0OMJWWQ=;
        b=Jr9NEuvVGP1XR30Ge9hA9PEzML/tcIg1LCZHuwncWg6xLmB015Q5/980wxTqPv5d4g
         Vrnd5ECElZjCm5VTiOsKg4rsxfU01qaOO24XPw8Q7dGAmPznXFFu94nFn4PIoYB7cahV
         bo7pDn33YTL+5lUZp+q48kfFfmEqlxVaEvo1DYLSGlZ9I/Dm8WF7R9jDxMUxMwZW8ZI4
         mhfbRiea/Y+xKKSE7R9mp1Ieakw5E7+Wh0NQgcbXVRxpU24d9ydvW4Gdof8rWNZz/XAj
         9/o0Dk8tOxZS2GTUNLaD/XUMfli+4EKbgKgX0qMik3hsf7abp6fOLJc/N/f8AE8246T8
         BPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjt6G22nPEeo+kHLCuYs1mS0gEibwl1fPGzpwR634MryFz4UTxP5Mk5rzFVwza8cqtqdNUOah9R/UEc/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qvONCU1YYTJ1NPS56Hhsy1xAH01c2igN+ujJ/eZOQuHloX9+
	R19QsqFfirdXijnMutJy+Jh2nkQe68bkebne58V3WjXDOt/m9whBOGfWzZ8H
X-Google-Smtp-Source: AGHT+IGo37GKqQtikoviYEnk2OxpIfz8FZmT6Ip6E5UkGYqwcD89Hrh/VwPrSgDk9Mm6GjcwA32CbQ==
X-Received: by 2002:a17:902:d503:b0:20b:9831:9edf with SMTP id d9443c01a7336-20be18c7b4cmr47675395ad.6.1727951195194;
        Thu, 03 Oct 2024 03:26:35 -0700 (PDT)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:d1e9:7a9b:5841:2826])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca14bdsm6514475ad.64.2024.10.03.03.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:26:34 -0700 (PDT)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	leo.liu@amd.com,
	sathishkumar.sundararaju@amd.com,
	saleemkhan.jamadar@amd.com,
	Veerabadhran.Gopalakrishnan@amd.com,
	advaitdhamorikar@gmail.com,
	sonny.jiang@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH-next v2] Fix unintentional integer overflow
Date: Thu,  3 Oct 2024 15:56:23 +0530
Message-Id: <20241003102623.11262-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix shift-count-overflow in JPEG instance
multiplication. The expression's value may not be
what the programmer intended, because the expression
is evaluated using a narrower integer type.

Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 V1 -> V2: addressed review comments
 
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..b6f0435f56ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -357,7 +357,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
 	if (!adev)
 		return -ENODEV;
 
-	mask = (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
+	mask = ((uint64_t)1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
 	if ((val & mask) == 0)
 		return -EINVAL;
 
-- 
2.34.1


