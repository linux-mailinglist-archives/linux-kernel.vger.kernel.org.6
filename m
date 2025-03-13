Return-Path: <linux-kernel+bounces-559933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D70A5FB54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B01884471
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF2269803;
	Thu, 13 Mar 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELGyxWmk"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37E26A0A2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882488; cv=none; b=VtUjvFzVTG70jEX6IYr8+1vzyiLnkpENpMk4oo6QutucNJUg/SFI6h8oalNegG00yTvXrKZhysJKgovALY/XjpP/38F80GOPYqbwhP7fWqfMCnQtlBwpPeVmjxYsW1Z6KyHcGVf0I69u2gsTT7GwtSoCyXsjfuCpETTOAT5Rdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882488; c=relaxed/simple;
	bh=9N/P0gsrSaPyvMxnl5goMi6Yiohr0Th43iTaeqFq6K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=of+4/t9lpRAfs9AHQ7+Y8AUqT8vksMmqiQuHTUH+KsT8vCp9H7J3oKxDAklGugpvN7NB8GIMsiHodV5E4X1T03WRtL/8WtNZzrTkXeRUmYfhgZ5ceWHN4yrtyK4PWhH72ECdXNaZ6bmaLItv4UNP4BFNuXXx8x+YDSPT7V02IbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELGyxWmk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913d45a148so986963f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741882485; x=1742487285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/7iciAKS3QF0Rjid5oBOozUpBYB/1kUNlh/Uit+k5yc=;
        b=ELGyxWmkxVALpbyU7nKNwTge7w/Smn0jihCf9a30Hd1OsoRT4WmNOwuMNeEXRI7iNH
         wD79nb0SaeSwugWDTRdDY4FeaUN8JVq1Df1Hs6vUizRq5fzDzMhqmR3ZxqrGUwOfSSAA
         rKiFXTp0Naspdy7YHEqfWOjCgTfUQwwxy2BRud6kFbNzBaC+G9uTatUF8u9UN+IR6lWQ
         U5+WoT2sQuFPdUVj61YigLXqNn5zeH4UrOd6jjP10IDDmXYjgSdV7ijl+boV/M36YCr3
         xjke670LHHyGEPQszKRIjIhn8kVqW7bYXxEOkGyDhyy2oWRBCO8e3Z+QRAg2eQJCSW/X
         B6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741882485; x=1742487285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7iciAKS3QF0Rjid5oBOozUpBYB/1kUNlh/Uit+k5yc=;
        b=qeGSPXpclHIRG5BrKOEAQNAByxbsh8M0JuutIRRh8Xi5my3jQhvxUstZZpWIHRCd0s
         M2lsqHfyQTixaelUYS6MjF05GUidrisT8MiN/t9kH62/ShSWyZZrLcL7eJ4zu7U1BBp1
         u4tHHKFehweQu2V4PblugcyTm07ToqFYfYFNgdHOQrhIKROmctRzAq24b3GQeNfu7EEY
         y4WGMnii6ryHFbmFjz/ryIyiPFI+To5mQTWteHU3GITQ3nsjk0+sAxtBCb6lIgqhEfmY
         8IOuk4vnAp2TZkEWQK7NcIzJXuiwMSQkognmw9do0vClo+xazrIR+rem/PSeB0ZMTKVs
         NCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlwiQ0C3dhvuCvZfC/N3y7AgXC1b/1WLTvrXqLGozRNyca7+zA55HZJ9iy5g+cI2CcFuNOxNJwq9m3dUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tH4Z1kJLXCdtjm8A+2gBKQcQAqsP/UVahmYkOrehkP8QvdYj
	5GqWIV7rDlwKEUxalYIZ6R5gVLYM2DJgG3hDIXpzl2CVx8VBQBrF
X-Gm-Gg: ASbGncvjWELU2EERVYVe8/dC+0YNekQYfzDFpMwpLhSHWfHdduU3JxMg5rW6ugbMhxH
	IpXTPLDjR8KO8+ypgYb7VXUV48P5XZZ357GP/pIYssICtqIavsUawC81MtwDdvCpUnafR7+3Cxr
	m10xyreMLa+1sa+vUdAA7DC4Ou7oDWPkt9W5IunyYzL17r1+YbkO1Nd0dE1TZW4AJV4wh6Wc+dy
	95SZ9l56ei4OxOpM7BKV7o2a4rlyagdroX8spZoz3TLmzuKW3qUNGjrToC6EKeRnuvAVoBScSTL
	lsXqoWQdpjcaKjt3e2bKULDqrnLjn6XmBYhLN+k4bxxL+g==
X-Google-Smtp-Source: AGHT+IHXAw3BfWqOXz0Wo0hoZ6qISw2lxtxABE9KJ5Emvwop5XDdhFITpSqR7vJSKMaMzhuVEZocjg==
X-Received: by 2002:a5d:6c63:0:b0:390:f6aa:4e7c with SMTP id ffacd0b85a97d-396c210606fmr178125f8f.28.1741882485043;
        Thu, 13 Mar 2025 09:14:45 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:41ee:4f4e:e8e9:935f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b83sm2664465f8f.52.2025.03.13.09.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:14:44 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: christian.koenig@amd.com,
	ray.huang@amd.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	thomas.hellstrom@linux.intel.com,
	Arunpravin.PaneerSelvam@amd.com,
	karolina.stolarek@intel.com,
	jeff.johnson@oss.qualcomm.com,
	bigeasy@linutronix.de
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ttm/tests: fix incorrect assert in ttm_bo_unreserve_bulk()
Date: Thu, 13 Mar 2025 16:14:24 +0000
Message-Id: <20250313161424.10688-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ttm_bo_unreserve_bulk() test function, resv is allocated using
kunit_kzalloc(), but the subsequent assertion mistakenly verifies the
ttm_dev pointer instead of the resv pointer.

Fix the assertion to properly verify the resv pointer.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index f8f20d2f6174..e08e5a138420 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -340,7 +340,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, ttm_dev);
 
 	resv = kunit_kzalloc(test, sizeof(*resv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, ttm_dev);
+	KUNIT_ASSERT_NOT_NULL(test, resv);
 
 	err = ttm_device_kunit_init(priv, ttm_dev, false, false);
 	KUNIT_ASSERT_EQ(test, err, 0);
-- 
2.39.5


