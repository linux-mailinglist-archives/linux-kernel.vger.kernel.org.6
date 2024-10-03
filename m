Return-Path: <linux-kernel+bounces-348667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494F98EA36
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0167C283373
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76447F69;
	Thu,  3 Oct 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSn5VEv8"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B90126BF7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939704; cv=none; b=GIvszs/zG3GhtuXktNgQ7No0am+sjamke/vUsZA5wzSknktQvqdfBA7I/NFdH+2aIhjzHhhjPFu1yJkSbb1ZBzuRDFnhKVzBreQiskRdjzCkbkS4V1Czbw+3qLDZMDHFnDYuUlRWLSwdlLryjIPzT5Ew4FIg5fWG9aKtj+qW9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939704; c=relaxed/simple;
	bh=X3dvCMgk1rOHffa12B6uqLaEGtxrmP3GTRXzv8+1oHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=htJoexgu5i7DLd2opVOL0KSdx0++ilE6/yUK4NTBZ7ynt2yHkWcOoNd2SdmAXyNUJgmu7/0Zucfo8ERTL8MUKqLtD9ker56IDWNrYD3K4AWzKMXDubjnd/+x8OqSwTxVqTPtHy+mstxWHx28agYnv0B8kIkJUwPyRYEcgXn5W7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSn5VEv8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so487294a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727939702; x=1728544502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wa4pIu5pC+135xygnD713lEhYzLZxMaLiQkWjJzvNgM=;
        b=dSn5VEv8Y7TgGdY46/eX8vF4/Ncy3KP2sCzY8ZmHRoICAI9b3DD/6yKULDrgNysudI
         AVsboDt5MrK+YF0bO+mHEEn5jhEGRU19+qtpnUdLFzmMJJuHtC1dQ707pBAfiEiBLnr6
         LYQXPQ40Vccx03PXTmF7I/xCtJJrd9lqf7uEr4mzfeyi5WCtQ/0XQ+Lj/VXgKjMe+luj
         i6S6i3JRn07MuHMnoQXUEj0SksUoK8GAuCtDy1mMOmIzLsG/JLpdfXLJzAOu3UEFcIQ2
         A0MTTud8PS+YnWJbpfKehv9SdcaT0Fe+9hF8OCaSuym8D6rdc/PYo66X3iAJ8UZkGHnS
         W6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727939702; x=1728544502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wa4pIu5pC+135xygnD713lEhYzLZxMaLiQkWjJzvNgM=;
        b=RuX5Rb0hwsaLlMXtlQfXAngkZSfXm/wGcQP4n1ZvSBvh6K+sZiiH7KGs6us6iw4oyg
         /ZHctFQojUZtOF3lEswh67XlUv6USL2XxP+mTv6CVpvLxpFxGyFaBlf17GG3NZ/P6qU3
         q7OPVQwhYVPmG+m0BNuXAoOzW/wWRJ9hwIb99voKl5/oM6rD4QVX05w+GcLrrGWyHsEy
         irRSrHAZpX2YLpC1TZQkfDF86w5IsXbVylnqLU0pwGUyj2Ch0POu5yk86B6gxQbLSiOX
         vT9UKTBUodpTCre/PvTJCW8JvzoFZLwghjEYXnd1tXXtKMq0FlX2LfZLPb47y9uhNqqI
         FhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMMThNqAJZ3JMkXRUCyxKPmc7jx6LuJY/TdyHqSVLp6w0a6/baJh4qBeMGlSNZZ5R3v5fJc8ZarK5saTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgY4PMgXzw7cNceTND85o9JZuoLs3zlMNsGGiSHRnfpzRuBfTB
	QlPA2YiSHbbpYuqdB7DgPn42vzwaUX8sbJhhNMKWCcnewvNnRrHx
X-Google-Smtp-Source: AGHT+IG395izEmIc+wheQbgooKM2yOIXSyp8HxCpDyfAtHvRK9D3lYz5JKBwip2Ls4SZJD7e4PEZOQ==
X-Received: by 2002:a17:90a:8f03:b0:2d3:d68e:e8d8 with SMTP id 98e67ed59e1d1-2e1849e48bemr5475891a91.40.1727939702292;
        Thu, 03 Oct 2024 00:15:02 -0700 (PDT)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:b1fd:ba19:3835:b7cf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bff53549sm763656a91.55.2024.10.03.00.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:15:01 -0700 (PDT)
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
Subject: [PATCH-next] Fix unintentional integer overflow
Date: Thu,  3 Oct 2024 12:44:31 +0530
Message-Id: <20241003071431.328259-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix overflow issue by casting uint8_t to uint64_t in JPEG
instance multiplication.
The expression's value may not be what the programmer intended,
because the expression is evaluated using
a narrow (i.e. few bits) integer type.

Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
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


