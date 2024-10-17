Return-Path: <linux-kernel+bounces-370520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4A9A2DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78259283BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A20227B8D;
	Thu, 17 Oct 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuZBcqne"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A6F1DE8A1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194043; cv=none; b=iTXoIl0LAlOq67QKJJFZl7ZZIe5HXMtPrHEYbiTPnZPJ/wWKVNOSj2jeUZJuDkVb/PWy5Fjs8D1OsRcQtypWN9OZRM0cn2p2X0EpIG/OeCxyOKHrVTJ8lG7xPhB4k14IZM2i68XOE2cAz7tQQl1DyAzg3ptjODlh9CRYXZsBWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194043; c=relaxed/simple;
	bh=IHi8t/Hjw1MvLyZq2tHFP9G1ZBIL5ssdRs8SQV2DQwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XItfXaBYx7/xcyE6jLtV4GZaFEGW5DdRhoY35n5yJ00VKFZ60kT6Mtx9gw3dJeIWzjWIwBflcbwkk+zx84TgoPnXmnwplj9YBt4U7ZPT0OtspcVMYKow8XPfLJiEwNMysMXcAmPvyoEymLRciO9/eGXizZJic+EOVnyZvoiNcKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YuZBcqne; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a156513a1so161857766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729194036; x=1729798836; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4OVlCn0UaUWh7bWeiu1Ka2GuXCsdMF034zBPeBiB8O4=;
        b=YuZBcqne1HtwK3dHYaTNwW++Fj98cHbIkIa4YpJxe3UoQs45T7zV0OxI/W7IS1qVsW
         yWPd/MayGSAr0A1QJ1H94CYhS4d+TGi2A5ZALoSbxFCwffQogMzxmD5yawmGEvLHb9qe
         ilnKkgsWf65c3ZRAh0u4OCflnBCl3BQj6tYBbCag0xu4CZuJ9YGHBIL6jeGBVHsLLqiF
         uldT4iQwJgdwnpbb44l2z+AAC+BO3LsCuwebPGHGUErPBiEg1WHIgdTvbch1+yVUWydK
         u4QMnkox0GFAk9rITTW2PfzHhzeKJ50zE7fVN/+WIYY33bNVH8OWIHhQMo2CFxrPHuY2
         dELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729194036; x=1729798836;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OVlCn0UaUWh7bWeiu1Ka2GuXCsdMF034zBPeBiB8O4=;
        b=eaJxXQbYijKLIjG3mIhTCBxRmSJywjQGHIikj3BrW30DtrgoyEmY868yqFwkApU+Bb
         eCU5xv3L7td8KaxdU2x1OAj8dIUVMWhDYZRsesIPsh3jb2p901TrZ17spSNU7Is1qsSr
         IJu8e0n4AN27EM6Vb93++0wBh8zdTrKnXm1xl+BLrK+cn9tlGws06+cgPjYzgI051Z2V
         W1ibE0Wj+MVF/V3E3h/HI5Z1nxd499a/ZYkVrJct21WcGrbyVVLKM+QvNADsfhpTN8aW
         oEcNk5Bk1rsIBnWv6RVg7xXsrnciuArm3p8SRhpvdM5Rfi5E8aESqYM4fPDFDvRnatD8
         XQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwX3+wPSIL8P+5YnCKZ3sgu9IXmQZmB4iS0KDm7mdMbgOYu1Wz9PsS6Z+xbewgBbKEybswXbHB2s0zcsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsbZ6l+4xbxnVJsYGQIa9OVV8PpiXApYeDRFmtZzO7i5fx2qb
	WOV3GAqn1KqrH71XMDzW5zZaMCS+nUR6Gt7LEEEi0ani08HwAJJoZykcJJzATgs=
X-Google-Smtp-Source: AGHT+IGB8YRLVexFRV2mAH/o1FOXGUr7in+Kju2Iz89bABqeFQYgpmZ27BOoxu2BX9pjvnrZofmNYw==
X-Received: by 2002:a17:907:f14d:b0:a9a:1792:f24 with SMTP id a640c23a62f3a-a9a34cbece0mr715958666b.24.1729194036034;
        Thu, 17 Oct 2024 12:40:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c27212sm2902966b.201.2024.10.17.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:40:35 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:40:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
	Vignesh Chander <Vignesh.Chander@amd.com>,
	Shiwu Zhang <shiwu.zhang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
	Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: Fix a double lock bug
Message-ID: <2e19e095-c022-45a3-8bb3-9a9321bc1905@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was supposed to be an unlock instead of a lock.  The original
code will lead to a deadlock.

Fixes: ee52489d1210 ("drm/amdgpu: Place NPS mode request on unload")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis, not testing.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index fcdbcff57632..3be07bcfd117 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1605,7 +1605,7 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 					     gmc.xgmi.head)
 		adev->gmc.gmc_funcs->request_mem_partition_mode(tmp_adev,
 								cur_nps_mode);
-	mutex_lock(&hive->hive_lock);
+	mutex_unlock(&hive->hive_lock);
 
 	return r;
 }
-- 
2.45.2


