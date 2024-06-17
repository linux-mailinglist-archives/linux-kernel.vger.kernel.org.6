Return-Path: <linux-kernel+bounces-217853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B82390B533
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1E286501
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70A8480;
	Mon, 17 Jun 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8DPm6jd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615FC8E1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638046; cv=none; b=cMfJ9192/RUDOOdy4UY9O259rA3SEnSnTbLMOh9JsjmD+oosNQkZ267IagY5KfJAV1Aga/uNmkpvStLME4KN+YTTV789lAxcDjfPC79g589/wijA0U0GurQvhzQA4z5JgcKlrkRw56HKUALUo8/IEzhrBOm5OHgqWs7TeiNM6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638046; c=relaxed/simple;
	bh=dFfnPY2LQuHSLUvCh4VkFkCM0jwP4XrN51PLoGp0vlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTaCBScz8yWOyz5tQjHlVP5eBeGHxRek2wNH+1t4BzaV5TlNY0YYC+Owyujmwj6TvdCH5X4yyZtlu3nvKjUv99zKypkDLOKwl8bTs5aZr5PaRlrFVzfcaRj1eqWS7MLUxPWtyRQRR+8YLV05KwE/A6fReAL5dSgxVauIkMJh96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8DPm6jd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718638043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3yNOohsWGaypNKhl1iDB1/cvtnFfZJdux3KpEMAOgs=;
	b=D8DPm6jdpzE+gL5PfX+vhX5hU4BOun+pV7ELoNVa7UV31uoJ8doOPj+tLRYH9k23630iYb
	YGHWi+V5rB3AGVK48DScFnw7LdB5J5GNsOkD41pJkaKgMuUocC6XXk/eDrQmpM8+dwbPkg
	bG1720A6/PdaIbLNXqj2dIYT49+KrrM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-zs4InKeKP5m4hr2nh3apoA-1; Mon, 17 Jun 2024 11:27:21 -0400
X-MC-Unique: zs4InKeKP5m4hr2nh3apoA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3608fb58acaso1228327f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718638040; x=1719242840;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3yNOohsWGaypNKhl1iDB1/cvtnFfZJdux3KpEMAOgs=;
        b=NPxcVOXXuGEcr8z4q1alfDb+vTiDjvhViA+yhvnzyp+NNFBXrlImSBhrO+GlLiuSGu
         n1B/Fr6k0NtOfBJ/XmQWBylzvMQNKAb2mhFxMgKAYNDFtjnS3X+ybylTeMIThZPJHTJE
         K3mhoTyMGQIHPAaDvbuOdo4XyIlACRXd4wTZvFvpx7zgO2A7c9Z/L+TQUuscwg2n0HA5
         RvtPcvByvbg4b5wdH1vSfwqQ4oXRi6RHLAo28bIJ+wHAW2fRcETk4D8b3dkwQmMM/99X
         C2JKwA7eSgaSYZli9LvxDf9d5ca31RPdrwL3+ZO9F36VyKeoHJkpbnI9U+h+BmFiM5Y9
         mEpw==
X-Gm-Message-State: AOJu0Yz6ZO9KFkktRsnY0uxT0o8rzk28SHBwBGgZdwwRLIrucW305Akn
	6eUp2igGajZbhcRC/38NyE3DAHMdMfT8Ex9s/nnNWGKYu9pL1sKD1SWiM9/xsIPjDGbj58oXu2Y
	3WTVyXyAyTEKTnN3ULhQtE4UzKq/8UolknjGs20HEDOpWynmc7aToMkUMwqqBRg==
X-Received: by 2002:a05:6000:82:b0:35f:e4d:f3dc with SMTP id ffacd0b85a97d-3607a741964mr9404284f8f.9.1718638040655;
        Mon, 17 Jun 2024 08:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRjNmUohArz1oiIJJtmkoA2K/cMFwDCp/vUBbIHNHAgBY0QFm8dKaVEvyDta7bhr4F1pF9tg==
X-Received: by 2002:a05:6000:82:b0:35f:e4d:f3dc with SMTP id ffacd0b85a97d-3607a741964mr9404262f8f.9.1718638040302;
        Mon, 17 Jun 2024 08:27:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104954sm12066178f8f.99.2024.06.17.08.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 08:27:19 -0700 (PDT)
Message-ID: <cd389206-88a6-4e6f-9fca-491fb186ed5e@redhat.com>
Date: Mon, 17 Jun 2024 17:27:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Constify struct nouveau_job_ops
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <860e9753d7867aa46b003bb3d0497f1b04065b24.1718381285.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <860e9753d7867aa46b003bb3d0497f1b04065b24.1718381285.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/24 18:08, Christophe JAILLET wrote:
> "struct nouveau_job_ops" is not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> In order to do it, "struct nouveau_job" and "struct nouveau_job_args" also
> need to be adjusted to this new const qualifier.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>     5570	    152	      0	   5722	   165a	drivers/gpu/drm/nouveau/nouveau_exec.o
> 
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>     5630	    112	      0	   5742	   166e	drivers/gpu/drm/nouveau/nouveau_exec.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to drm-misc-next, thanks!

> ---
>   drivers/gpu/drm/nouveau/nouveau_exec.c  | 2 +-
>   drivers/gpu/drm/nouveau/nouveau_sched.h | 4 ++--
>   drivers/gpu/drm/nouveau/nouveau_uvmm.c  | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
> index e65c0ef23bc7..a0b5f1b16e8b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_exec.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
> @@ -188,7 +188,7 @@ nouveau_exec_job_timeout(struct nouveau_job *job)
>   	return DRM_GPU_SCHED_STAT_NOMINAL;
>   }
>   
> -static struct nouveau_job_ops nouveau_exec_job_ops = {
> +static const struct nouveau_job_ops nouveau_exec_job_ops = {
>   	.submit = nouveau_exec_job_submit,
>   	.armed_submit = nouveau_exec_job_armed_submit,
>   	.run = nouveau_exec_job_run,
> diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
> index e1f01a23e6f6..20cd1da8db73 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_sched.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
> @@ -42,7 +42,7 @@ struct nouveau_job_args {
>   		u32 count;
>   	} out_sync;
>   
> -	struct nouveau_job_ops *ops;
> +	const struct nouveau_job_ops *ops;
>   };
>   
>   struct nouveau_job {
> @@ -73,7 +73,7 @@ struct nouveau_job {
>   		u32 count;
>   	} out_sync;
>   
> -	struct nouveau_job_ops {
> +	const struct nouveau_job_ops {
>   		/* If .submit() returns without any error, it is guaranteed that
>   		 * armed_submit() is called.
>   		 */
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index ee02cd833c5e..9402fa320a7e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1534,7 +1534,7 @@ nouveau_uvmm_bind_job_cleanup(struct nouveau_job *job)
>   	nouveau_uvmm_bind_job_put(bind_job);
>   }
>   
> -static struct nouveau_job_ops nouveau_bind_job_ops = {
> +static const struct nouveau_job_ops nouveau_bind_job_ops = {
>   	.submit = nouveau_uvmm_bind_job_submit,
>   	.armed_submit = nouveau_uvmm_bind_job_armed_submit,
>   	.run = nouveau_uvmm_bind_job_run,


