Return-Path: <linux-kernel+bounces-322548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF10972AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BCE1C23E04
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A117E012;
	Tue, 10 Sep 2024 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="p5AmSKrt"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A317CA1B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953215; cv=none; b=aS177Ks+n2wUZBlr2O1v+dOpMZoE8PeWmahXkg1jX/oHtiEdHfzu5/ewfi4coYcixQhC8ZKaymYP6cIFcLXOklAfmbTLSI7khnKGKvbsQr67BSz57Saqx3nUkaLYDaNpBDykzg/6FDr0Vrcte2QPm8oHOo9bLuOfsIU6eyz3lrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953215; c=relaxed/simple;
	bh=Gj5V2Egk4EGbaKkPeTjpfC7Xya042ySnvCaQqI4xPns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4GSPQuvYGVtdgB8i1Ksoa75FimZ9OTlpnp758AYvzKuEtSU7mvGm9XtXUlOQIsDDihoKkUYfWaKI1hmJb5nAYVTmIzFc+bXJIWxCTflPAMy/B99pgseEPgSMT1HnzE/j/W3fACqnbh/rRjDCftYyKWYr+b9Nk6I+cl14Brk2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=p5AmSKrt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c3eef39eso2914075f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1725953212; x=1726558012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxMzW8bRkSWH7N3FT2nOWV85gkTf+9ZwqbV1H9/D7u0=;
        b=p5AmSKrtbLdv7meTVTf5hyBISVIAbYsSeIruRy/t5Lkkk7R8o+bHIYIPWo8sVnHO+c
         bsUlhmgpmziGZm/u/DaopeGcZxW6hvExzm0ZROpJ7AsYd+wPJXdi1W0K8nTguq6IebWm
         I4fP9ePDkDZGT8QDwLdAnpjRxJRUPDVPZmn1x/15oHfa7Ef9mfx22NBDycOowmUHL8k9
         pB2DBLy14Nfv6VqPqbzvrD9oboVypmG9Zka8aRW6+CVpa3ElTyQ9h5KmXhy2YrzpAcv7
         ZxtxHym/a07wrBVlCNzcpf2o7FBv95jan7WCcabtcTokuIZnkl1f9UF+qoPjnC4SfVvP
         v8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725953212; x=1726558012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxMzW8bRkSWH7N3FT2nOWV85gkTf+9ZwqbV1H9/D7u0=;
        b=w4e5gZ8xGLXq4gVRKB89Au0vpe+XCRGWtQqas1hoWv9Y9cteOHTnwKMs66UCJ31huy
         7nIXze0Rp6Za0zryz/I0XK+Umevn8Sl38Qr9C6113MoJ6A7qoEoMzvliU7Ox5rkIHu8J
         FGqU5A8bfpeALmq1C5sbOTi4Psd2XiavQjc5h0XbFIwZNpG3IhZcQd1K5UlbYf1BOlhU
         bMjdAk5Of036CvsjAGOvJZou46LTJBlsEVrPEAZVdZTLYbET2bAukabMz02qRZIDV/Ir
         ct2L0t4PgVG6Jb6+dhnG63nXAimvAoUHRK58DtjeeJvDnVqoyMF43ZvJbf34LAKzY7Aa
         eWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAH7YyFfuACJoATdE/MfMlNKSBEeetBQxTdiBM6TKGTMDwNlEgGcRJBiB11Btt3u5ig+ComtLvmApjZec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCn+nVeC2CwMtD5+LNwgEJKoDnkGYa6PMUffdS4/cllyBM4WW6
	/imUNBwZzV+FlXuLDgcIqmbMf/f5ZjAXye9XpgxR/RzypBdKbANpEBt8toNasWM=
X-Google-Smtp-Source: AGHT+IGESuTP3eLnl+EJI3vciZdTv1kUP9QMFpZOxqQKA5bFwEZ0VHvpLLczzXOyCMDvE2xlo0xZ8w==
X-Received: by 2002:a05:6000:a8c:b0:371:7dda:d7d9 with SMTP id ffacd0b85a97d-378895c3004mr8487755f8f.9.1725953211362;
        Tue, 10 Sep 2024 00:26:51 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956655fcsm8006471f8f.38.2024.09.10.00.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 00:26:51 -0700 (PDT)
Message-ID: <c970dfb2-078c-4bf1-8b50-6e535cf4adf7@ursulin.net>
Date: Tue, 10 Sep 2024 08:26:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/syncobj: Fix syncobj leak in
 drm_syncobj_eventfd_ioctl
To: "T.J. Mercier" <tjmercier@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Xingyu Jin <xingyuj@google.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240909205400.3498337-1-tjmercier@google.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240909205400.3498337-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 09/09/2024 21:53, T.J. Mercier wrote:
> A syncobj reference is taken in drm_syncobj_find, but not released if
> eventfd_ctx_fdget or kzalloc fails. Put the reference in these error
> paths.
> 
> Reported-by: Xingyu Jin <xingyuj@google.com>
> Fixes: c7a472297169 ("drm/syncobj: add IOCTL to register an eventfd")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>   drivers/gpu/drm/drm_syncobj.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index a0e94217b511..4fcfc0b9b386 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1464,6 +1464,7 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
>   	struct drm_syncobj *syncobj;
>   	struct eventfd_ctx *ev_fd_ctx;
>   	struct syncobj_eventfd_entry *entry;
> +	int ret;
>   
>   	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
>   		return -EOPNOTSUPP;
> @@ -1479,13 +1480,15 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
>   		return -ENOENT;
>   
>   	ev_fd_ctx = eventfd_ctx_fdget(args->fd);
> -	if (IS_ERR(ev_fd_ctx))
> -		return PTR_ERR(ev_fd_ctx);
> +	if (IS_ERR(ev_fd_ctx)) {
> +		ret = PTR_ERR(ev_fd_ctx);
> +		goto err_fdget;
> +	}
>   
>   	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>   	if (!entry) {
> -		eventfd_ctx_put(ev_fd_ctx);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_kzalloc;
>   	}
>   	entry->syncobj = syncobj;
>   	entry->ev_fd_ctx = ev_fd_ctx;
> @@ -1496,6 +1499,12 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
>   	drm_syncobj_put(syncobj);
>   
>   	return 0;
> +
> +err_kzalloc:
> +	eventfd_ctx_put(ev_fd_ctx);
> +err_fdget:
> +	drm_syncobj_put(syncobj);
> +	return ret;
>   }
>   
>   int

Easy enough to review while browsing the list:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

