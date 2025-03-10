Return-Path: <linux-kernel+bounces-553998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D9CA591B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B553AE6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0198227586;
	Mon, 10 Mar 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X08vEahF"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9CB226D12
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603642; cv=none; b=PdHTBahVHRI3+Lp5EyjKjwemYlz+r4B6ZieN0/I2QKLy2eB7fxDFwjuUcEQBQCS4mWESaO4sFl6cqdmksFP52bWzjFyeDA8w8jNXjb3ifDDRWRvl5cXmmTZNZtHkW+ygIODoja/x3BHsYuU1lOvB0rvuWJXHURp2ZWoUlZube1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603642; c=relaxed/simple;
	bh=yZDLwHLfwqgSEJuN56eo4V3J1jrerAKvj2dir6+1stM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RI3w5UQ1DKVkOJHAklu5ZNzpxadLw40nIsZTI+1gdp3BSjSqErc3GaqEuh3MHevuze5TOzcqUiUV3ESVB9NF6PLQ915B8bjWBwp4kCBTKD0DXYGPTZtSlTrkgDR5UQ1SWI/Ub1/IGi78JPVHvlSANyIQ28UYrkLVVHw3QPdX8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X08vEahF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913d45a148so1221455f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741603639; x=1742208439; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/usSyZvOMqcO02UgIaZS38RjkJHQ2qzt+JqdGQEbLM=;
        b=X08vEahFNpilP3mGBWbsQQoQZAhW+fNe4DupsbHI3vnfhtqnvVNyJ1dlMn2900ko1u
         8Q7R8lIZVi9nLGIBm7A6Jl1VEiVCnQeow+eacAr4yEtzktQ4T5YPmhftpOQvtkCKnAa4
         UBDMXQCJdZ4CeEDMacZIO4LnV4c5BwHNA38Fa/5SSzpLIbVVZvIst/Bi6VMQ0GHMI3DO
         WXgNq55ouwX+SiKSiyvdNZ+r/SDjsQ9L4Aa3wHRUwm6DVt7LOJyGIeP52Ze7ELpSkCLg
         jDBvS9F5MHuzLFh4BjWEqGG4rXZgRB6uATJiNseUBj1OQj6Ap9e2BvvwCF7iFCACPZ/D
         Q53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603639; x=1742208439;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/usSyZvOMqcO02UgIaZS38RjkJHQ2qzt+JqdGQEbLM=;
        b=VF1F7l+Jt887BkYX5bDCpxFrP2ZGbEq1JlUd8L2pjG4OkvlwJdnxPReKmNwpgBgKFM
         j/HbTDM5A/jHChqOiB3bEopv25VhB4PlRoPK0dIpXBLCe3RJvlbNMYyBn/gtGRPMWVbk
         Bz/FmJ7E1nNanimKzr96ItbNG2ybNSMzIvdPliM+Eh9eYojWtLgxDGEGQwqR8LDp7ji6
         xHyuZa1uQONwhLs3RVTao2vOW17kGg3kRnBkos+hsXIIz60KUKYXdlytCX/RvuA9G0KY
         n1YsdVRyp6/38OkbMm6H4Or86nO/makHT5GLVuapCkoq1L9Pe3m0enH4xFzxtdeeu54j
         O54g==
X-Forwarded-Encrypted: i=1; AJvYcCWr8oytMhdzEcEAnib7NPZPd5aeZlCekWevmQKmk57zw3eRXOOdfXmfm5ZaJlQdTG/PljOFieHkGMUrIXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKIVIDDdO/j1HJIaF0sVSfcvJhee74w1pH1Anbw76HY8/1uu+
	SXUKEISfj5u3+NgTvOmI49mu1HTyWibLg+lVFQCs6g+RLcJxYq0tNvJqhIcy+Q0=
X-Gm-Gg: ASbGnctZ2a0Fw1PjoBqwHQMgRyjoINv9gBy3WntPkrKIY4KX/KiZVYTAbgaT5m38C/F
	WdkJELPhpf0uGatnqA+mOVtceSPNyiGYF9Ux3tX2sVRvLQDdJOWJ7jvCS09kqpDeUDuKUbP2onD
	s4H6i2iJMHWg0BG1/dzeceuwc77wo31ovKTe8Wfui2EhA4F6+wInzQwcy7kaQeGJL0SNJnK97D/
	oN6FciGTJvpQoSTIKhy+ECk3V67cU/poK58D0XJK0ScRGa4BvSt2NOMOw9JzhLt/cEZjwUE5PMB
	LdKNkfMHjBu28flnq49Pi5YlHy/TMC1HEmAcnY3lWdzwYSRAR6Ju5it0rN+u
X-Google-Smtp-Source: AGHT+IG0DRVFzL2VYuk4+0xwXKcyqK/IIpus26os/g6Pm2aV01RIKQYEWia+Sq3ARp2iOSgT/MR1WQ==
X-Received: by 2002:a05:6000:4105:b0:391:41c9:7a8d with SMTP id ffacd0b85a97d-39141c97c1bmr2940385f8f.54.1741603638928;
        Mon, 10 Mar 2025 03:47:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0195casm14715253f8f.53.2025.03.10.03.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:47:18 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:47:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Tim Huang <tim.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Likun Gao <Likun.Gao@amd.com>, Le Ma <le.ma@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Use tabs for indenting in
 amdgpu_sdma_reset_engine()
Message-ID: <2503b45f-751e-4b50-96fd-8dad33821c40@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This line has a seven space indent instead of a tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 39669f8788a7..3a4cef896018 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -621,5 +621,5 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 	if (suspend_user_queues)
 		amdgpu_amdkfd_resume(adev, false);
 
-       return ret;
+	return ret;
 }
-- 
2.47.2


