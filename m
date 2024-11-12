Return-Path: <linux-kernel+bounces-406342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D099C5DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB34F282802
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC3207202;
	Tue, 12 Nov 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dz6Czezm"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED7206E9D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429919; cv=none; b=K3Q+ALPh1lWNl+F4UHvNQLNHCb/L8GbnLxU/ewL4WaIKehDf9juv8TrBfRQM+wjtB3FWG7gyLHNItU0SGNHWGcosLi+2aEQK7A6izo7+StbfU1t3/i3JCcBBCc1CzpLeyAkThDAVzmLbeKqfbaSCf5ChdXO+1iKxuem0oZTmHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429919; c=relaxed/simple;
	bh=BU8SAKQYYL8r7gG8XVr4DhdTnDYI57qUJDwd90+MhkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OA+fxecIyT3soUMnGznSkM25vnpZlRk5qZYpEd6BlE6APXr2+iA/smtyUcXHkqsftc/rEIY1t4rVsmbDFsE2gZC1GtPDZinegWgWV1gmctF+ZPTZPzF1s7E+lbC3PUMTbm/0ZnLpfJf4TKpUft9mPg38HdnO1QLx/sxSWb2Mq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dz6Czezm; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f9JaviCbLXmyeAuQ/U0n+aUYuMEEP12gJE4r6O2lA6Y=; b=dz6CzezmviA0qhKwz4iETP5x++
	60lndbluRwU2y7LIH/85fO/EIxtU0DTh93U+Loi47xtk4d5Hxt32CLMbrYemVc0eYVEz2ljYazoHw
	oI1VjVYYPwbdxUpwpB757Rn5ZlzzdK8eGro/nIUB+rBY1xqaFITK8rI9vvwYxQ2MX3ski8MVtLDMf
	v0c46+ni+C2Nm1P2Y619iYPRJB2UOnhErPAcP3S8Z3uAd7DDT5L+WID89wr9hDhGLiftrIZ89SXbq
	LNMa8ZgeGN8fpHIvQN+nFyZitDtl4aMlfFN19uO7dlCNb86S+0RjiXk/OVhjaizKOUZXi2sAJrJ4p
	qFs4H62g==;
Received: from [179.118.191.54] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tAu0X-005xVV-V4; Tue, 12 Nov 2024 17:44:50 +0100
Message-ID: <0829825f-6e6e-465e-aa3c-444d57bd115e@igalia.com>
Date: Tue, 12 Nov 2024 13:44:43 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v9 2/2] drm/amdgpu: Enable async flip on overlay
 planes
To: Harry Wentland <harry.wentland@amd.com>
Cc: kernel-dev@igalia.com, Daniel Stone <daniel@fooishbar.org>,
 Xaver Hugl <xaver.hugl@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, joshua@froggi.es,
 Leo Li <sunpeng.li@amd.com>, Maxime Ripard <mripard@kernel.org>,
 Simon Ser <contact@emersion.fr>, dmitry.baryshkov@linaro.org,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
 <20241101-tonyk-async_flip-v9-2-681814efbfbe@igalia.com>
 <3a97b828-2864-45fd-9fa1-5341bd456d3e@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <3a97b828-2864-45fd-9fa1-5341bd456d3e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harry, thanks for the reply!

Em 11/11/2024 18:10, Harry Wentland escreveu:
> On 2024-11-01 14:23, André Almeida wrote:
>> amdgpu can handle async flips on overlay planes, so allow it for atomic
>> async checks.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index 495e3cd70426db0182cb2811bc6d5d09f52f8a4b..4c6aed5ca777d76245f5f2865046f0f598be342a 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> @@ -1266,8 +1266,7 @@ static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
>>   	struct drm_plane_state *new_plane_state;
>>   	struct dm_crtc_state *dm_new_crtc_state;
>>   
>> -	/* Only support async updates on cursor planes. */
>> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
>> +	if (plane->type != DRM_PLANE_TYPE_CURSOR && plane->type != DRM_PLANE_TYPE_OVERLAY)
> 
> This wouldn't just be called for flips, though, but could also be
> called for updates on a plane, right? Those could cause for problems.
> 

I see, I think you are right and can be called from a non-flip commmit.

> There's also nothing special about OVERLAY vs PRIMARY planes, other
> than that amdgpu needs a PRIMARY plane, IIRC. So updates on PRIMARY
> planes should also work (or not).
> 

Right, the PRIMARY plane type is already supported for every DRM driver 
in the API so I didn't explicitly added it here.

> Maybe this should check that we're actually dealing with a simple
> flip, i.e., a simple surface address update.
> 

Right, that makes sense to me, thanks!

> Harry
> 
>>   		return -EINVAL;
>>   
>>   	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>>
> 


