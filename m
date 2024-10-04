Return-Path: <linux-kernel+bounces-350023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6465A98FEC9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E562816F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B313CFA5;
	Fri,  4 Oct 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixt9CnNi"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F9C6F305
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029798; cv=none; b=WFnyrFj4qN9l/U8cXIMkrSXI6+ZKuqRwN9K04KyqYZrsrgYksntX4lBQIae2vC9yxH/GpR+ftHBJqdr1GM2oc+n4RcOJYfGosrMuwa/TbeGGQJQiOCTJZgelyOWXbJ9QmviZPZEY/k9vCpCrnLPD7e1+uebYxOi+K1bj6peT9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029798; c=relaxed/simple;
	bh=c43f90flHYTN0da2c6xEBraaBOdF9VKmWMVoG3VLcl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+KyphWV0GtiBxDqXjfb8YRXjtmLTVeOF8AadmyhjhpfggkaaTL1rlKqpeVAVIz6KKxav4qs6H5oLVsgs4Dv4tk6L0hBtGAoXbPMoN5Doh2J/EGnyLQpVl0hhSbaSw4Ru9ereKisA4te0DbMskCXJqK3DBm9b4Rld/dVhnFTEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixt9CnNi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b7463dd89so20346805ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728029796; x=1728634596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EpHwQlBLt9aUuZVqI52DbACRCcwYewzEXJNWbf21nvo=;
        b=Ixt9CnNiO9EGFJ2xteGbOXw5ja4c5LxZFzSt7XO0JMJTt9mf25ZxPbckdb2Lk2yvEt
         tPMoEU588EQAwnr9nFkIPOai2bRDSgASMcR3LGMJQUnZsq0gWXA8oJiXNCnI8kEp0r2R
         AnusNRtWjk1v7no1OedJeSo+XK1zIkt8rFQqabWZfzkh/GPtSo1BYaRz13lpweEhYnVV
         t9dwE2WXGKCt+rGZZd6Cw7P5tA47uT8znOQ9MfWszXugVTzcgZwiQKC7ql6/x7ONIYSv
         1m/6oWcHPoHO4mejJNIHaz6P0WbPIAOqcCuWmYmjokdxyzpN0qQcjIua2uv3yiGanMLc
         fgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029796; x=1728634596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpHwQlBLt9aUuZVqI52DbACRCcwYewzEXJNWbf21nvo=;
        b=AvLcQAfo3kgJVFIl0GsFt7o1oZ7tJsP9J46X8PjAjMQ7bniCFs3hBToDBu+NkfaUT1
         PZ/3xCXmdvNjZcmm2RBhRISKT9HA0zjtjL3YGxz6RfVyBKDW5D79LSzxqdzD5nsAWasR
         dBQ4r6WWMuCTcASJ4Qxq3MmOwfmAKvuQaXEPJ4zBJBaPWLr6G1aoXmz/oNylx3+sVT+o
         3IcLMd9F4c7ASz1x+pFMwGTvbJwb6qRpczlBxbAshVaXV/rFb0Ch3SfgCKo114QxPrG/
         2HEniifAS8wCTkeMiZmQ8i6ESYw05xpGex9UTtii5tKLbXq0wiQVerJ1zh98E3mFTro7
         Kmig==
X-Forwarded-Encrypted: i=1; AJvYcCWA4GtmkvOpe2OhPUoL4Xvr04Po8no2FxoWNHMZ9wjyipyulkeZo2vMFEm0ytz2WMYqDf9qbE3rThDNl9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFpTmxP3DdXHrYTvDsojfA8snk9unYdYq4ZS9+BVzn85B4SG+g
	Hp3tf+bK0YU4n9DVaZLDo3XE+bqyizZ3+9wRfoRhvMW9XjkXSUqmKyv0MX8y
X-Google-Smtp-Source: AGHT+IESstItqCuBNL/elHzMasRvg1qmLhXnxawENnsB30tcavQLHFcDrefZED0ZlkxVd/XHEigKaA==
X-Received: by 2002:a17:902:e551:b0:20b:4875:2c51 with SMTP id d9443c01a7336-20bfe024d5cmr32004945ad.27.1728029796105;
        Fri, 04 Oct 2024 01:16:36 -0700 (PDT)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:4e5:4fce:4f6a:9764])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead49b4sm19832125ad.32.2024.10.04.01.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:16:35 -0700 (PDT)
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
Date: Fri,  4 Oct 2024 13:46:18 +0530
Message-Id: <20241004081618.27599-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix shift-count-overflow when creating mask.
The expression's value may not be what the
programmer intended, because the expression is
evaluated using a narrower integer type.

Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..7df402c45f40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void *data, u64 *val)
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 			if (ring->sched.ready)
-				mask |= 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
+				mask |= (u64)1 << ((i * adev->jpeg.num_jpeg_rings) + j);
 		}
 	}
 	*val = mask;
-- 
2.34.1


