Return-Path: <linux-kernel+bounces-251021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BBB92FFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805AD283D58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA2F176AD6;
	Fri, 12 Jul 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yc4zCgtv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903043AA9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805942; cv=none; b=B1eO902BpDBTZGGZ2ZoXQ5KGpQ8wa/wZ3RIkGVrxeuymaYzQYEwb5Xl3Zih87ivxGv5NtWvWH/wTVZM6yuBm1meAbQwJXkbZFWfrfkBS40bVlKxNQMs3+ZnKh31GFn45G3WDWQ2bvBLy11kZ+Kk2kmYSlXjGRuxD7SYihDvvPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805942; c=relaxed/simple;
	bh=Yl2R9WEiLRLloFtcSMn3rl9ebdywIs7N6zGMlEUTs5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REv007D81S14cTDJD5W1ccZXD3Isbic8qi3lpPj8frRUMAQVRi3YUYjF8zDcI0icVcLO8wA3aU40ROIegeChULXzk4oYeDhrK+N0VNEUZBOMX7Z4AXfL8gl3P+Pb229EZEVmSn29PR3p15Km2S3KdWuyZVJjR7kd/caZph1ni7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yc4zCgtv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720805940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sipNUbj7qIymRT+79qbVwcgrJBEdFVUgDof1TAUYRzU=;
	b=Yc4zCgtvzEiOD9JbqhuimwLozjknBWgDS1uUiY5uDaXB7a8RD8jNE6wz04XG5aovD7K7ks
	frTnONs+Qmks8WFWOwpFFzFrj/wy20d1J8XBJQltanomooVtk2BoZ50j6DD9/sLAZOSdFl
	1gE2Kpw2xgrXXhH2YtYThb8nsqn9Qls=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ccv0oHfCMe2HOu2dSiC1HQ-1; Fri, 12 Jul 2024 13:38:58 -0400
X-MC-Unique: ccv0oHfCMe2HOu2dSiC1HQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-426703ac975so13225705e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720805937; x=1721410737;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sipNUbj7qIymRT+79qbVwcgrJBEdFVUgDof1TAUYRzU=;
        b=EszTSvlQX2etzje7isGaHQIuRdwltF5EFiTkecVp9IdxW8JlwnaKGbliRFbBAA0Xi8
         aZA8n40RoGhkYjlTHPT3cSvQw8SiqqXtyH1MFgZt8S1jFURt+LXAh/SHeRleA86ViW14
         Nkoof09JBIfysJghdJWQHTqKAQY/fRBviO2bSlFUs2wWENdKImuCR+WQyaGpqE98ZMqK
         MsjaelTo9N5M6lgdl3oI7zuoySUs01lzSINVhgilUR8oX0tzcDGp+/SCUjxsng1Ityku
         R+ynPaQC2vlZNNMujaJre6lLjatMk20DURgXciwEAXpEuSN3k7YzOnK7tpKnzfGhdc8h
         kzlw==
X-Forwarded-Encrypted: i=1; AJvYcCWT1kCSkJInrxDvVChxC1wKJKiVq6b05qFws3n6i+JAhONIPd0rTlQo6iQUViJuZ0g5h33kT/Z82lcBJA/bTJP47pEAR3mK+57eqeuV
X-Gm-Message-State: AOJu0YzE4ZlEYWLTZ/sVT9XPAh8l0sspt1GfZ04YXUU2+yP+f+YHDzs8
	DrLszFVZkvtY227Y5y/+8Vpw1ON/n4U+grIQ2nk09yg4zFCuV55VlkWb1ySYWqbhFBhq36i2BDm
	9C1s5FMpz0/zHzoKYzLJx7aczz6GVkXU1n7ybp7b4rnrivo1Dy6DKEowHCTzpGQ==
X-Received: by 2002:a05:600c:4613:b0:426:526f:4a1f with SMTP id 5b1f17b1804b1-4279daf2585mr30621035e9.16.1720805937770;
        Fri, 12 Jul 2024 10:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwxyB3tY2Z4sxPaWpQBWCpnq//rThRXFxa0CLe10n5BDi1DzzpSy6RoH9nNF6GDL7AeQz3Ow==
X-Received: by 2002:a05:600c:4613:b0:426:526f:4a1f with SMTP id 5b1f17b1804b1-4279daf2585mr30620885e9.16.1720805937464;
        Fri, 12 Jul 2024 10:38:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde890f6sm10676030f8f.53.2024.07.12.10.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 10:38:56 -0700 (PDT)
Message-ID: <6c5ba940-8e18-4b4f-9e30-5608b228ec8b@redhat.com>
Date: Fri, 12 Jul 2024 19:38:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/nouveau: Improve variable names in
 nouveau_sched_init()
To: Philipp Stanner <pstanner@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240712062618.8057-1-pstanner@redhat.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240712062618.8057-1-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 8:26 AM, Philipp Stanner wrote:
> nouveau_sched_init() uses the function drm_sched_init(). The latter
> function has parameters called "hang_limit" and "timeout" in its API
> documentation.
> 
> nouveau_sched_init(), however, defines a variable called
> "job_hang_limit" which is passed to drm_sched_init()'s "timeout"
> parameter. The actual "hang_limit" parameter is directly set to 0.
> 
> Rename "job_hang_limit" to "timeout".
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Applied to drm-misc-next, thanks!

> ---
> Changes in v2:
> - Remove variable "hang_limit". (Danilo)
> ---
>   drivers/gpu/drm/nouveau/nouveau_sched.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
> index 32fa2e273965..ba4139288a6d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_sched.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
> @@ -404,7 +404,7 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
>   {
>   	struct drm_gpu_scheduler *drm_sched = &sched->base;
>   	struct drm_sched_entity *entity = &sched->entity;
> -	long job_hang_limit = msecs_to_jiffies(NOUVEAU_SCHED_JOB_TIMEOUT_MS);
> +	const long timeout = msecs_to_jiffies(NOUVEAU_SCHED_JOB_TIMEOUT_MS);
>   	int ret;
>   
>   	if (!wq) {
> @@ -418,7 +418,7 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
>   
>   	ret = drm_sched_init(drm_sched, &nouveau_sched_ops, wq,
>   			     NOUVEAU_SCHED_PRIORITY_COUNT,
> -			     credit_limit, 0, job_hang_limit,
> +			     credit_limit, 0, timeout,
>   			     NULL, NULL, "nouveau_sched", drm->dev->dev);
>   	if (ret)
>   		goto fail_wq;


