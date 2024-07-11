Return-Path: <linux-kernel+bounces-249677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CAC92EE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66171283B64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951916F27E;
	Thu, 11 Jul 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3SVPilJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CEF16E860
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721156; cv=none; b=VydODU9eIk2dgaPWis4z10NCRFrb2FyC35KJD8tGpeWyYS8lOZ73xP53ygQ6jCzEd4opag0781dFtQ0q85VNa/50UGQpAN1A7r2MGR2GZzIWj1ollTEDECKL7ZMSK3yb4pM0NyYLRzrzOUwGZmi4Ejkgg7iQmoF8I1bzzDD4v/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721156; c=relaxed/simple;
	bh=R54mHHWhwuWx/Bc0YJ4ZuueryQZh0szCtEiD8e1zQjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpJLhMIkD9F4c77QZuXRGX0n0GhEj3hpLYZbotB3pB6ScQn5FCKjGb6o64xm5Wa10D/yu+sDg6t8dvTV8S2brnFWx8wBUPdL3Vk3FhsZscy0V52jhS026D+AKjxcPLm+8kxjTeQrvKIj0WWXI0tUs7pA8iUNV629k8BoJSzCxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3SVPilJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720721153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cH5nbFjOkzVxAKshaS/V3UeyG5ukQIAiJeRXo8zubdw=;
	b=F3SVPilJF4sdWQc5YtXfhyxxrBU5EUSaKKgmnwoOO1rokR0p2+F2n3+ts01otrxNl8F8bs
	Q4xKNKb/sqILhWemHaw9zXMsUho05Ak+C7J9wHr+4gXpHKRMo6JqAHnJyfG9CVExUNwDGC
	kkolSIl04g9EqGPz25ENyqr7tpRzsEc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Pfl55XfqMl6fdA1TglO52A-1; Thu, 11 Jul 2024 14:05:52 -0400
X-MC-Unique: Pfl55XfqMl6fdA1TglO52A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36789dfcc8bso552429f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720721151; x=1721325951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH5nbFjOkzVxAKshaS/V3UeyG5ukQIAiJeRXo8zubdw=;
        b=P4gmZDcjDo3iXTr/b2n0hStGqdiIIWL+nukVOz8PcH8/hXUhbu8a7vskDKFU8DcfWd
         QrnVyOnGAbC0+9M1qAZmLjQzp3bF2eQWfjAZw2lccCgTbaABnK8JtKYapMpOiJhkz/vR
         ITCzSp9bWcXmGvc3B436nO1sl0Hp4ghNUEzyWs8tSXk1EXzLERakrajD024Rx+HgfrCu
         eYZROByZePu1BkTi+v1TxFQfa7RQP53V2is/pjIF6TScKnUpJxNKpGIBvJcY//ByXJ2J
         q6cz8kI+W87lGOPyH04BqKj89qaDt6nBrWge/OgZIUbs9WDuhtp4Mt+yas/vcvUqfxTI
         kHSw==
X-Forwarded-Encrypted: i=1; AJvYcCW66UlTu+o55DDnOeJm2waqlOYro78tDjoykW2zRPXFVG0ZEqSVc6Fa5Q8zdbb57u5PeS9emlOCuOKrJMybqC4PT1d0R+S425xZhGwn
X-Gm-Message-State: AOJu0YyGlgtQK+HIL4BY1nTiJ5sO/cFMs40FwF/9+ZUjhOfv0VIP4f81
	I61Kfvh15toKNwvN4QMNsh0FoOVozRuvQUtInWFqDEMj/AjaBfIXG6KjIkg8GAxrwblzRvadSIb
	EFcvDnD/BSjWAhTP1kSbyUbzRSaO7nFqjXyReiFeah/IjgKX+ZotVEkt+R4rJdA==
X-Received: by 2002:a5d:404c:0:b0:367:96b5:7852 with SMTP id ffacd0b85a97d-367cead160amr5846763f8f.55.1720721151225;
        Thu, 11 Jul 2024 11:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbvXumq8NE1L60m9LVsiI8UizYuufQvzoRjF4iDhvTdBKyfc4C360PBuGfWMVvQlH9Ft1d0g==
X-Received: by 2002:a5d:404c:0:b0:367:96b5:7852 with SMTP id ffacd0b85a97d-367cead160amr5846755f8f.55.1720721150911;
        Thu, 11 Jul 2024 11:05:50 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367fba1b15esm1867923f8f.22.2024.07.11.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 11:05:50 -0700 (PDT)
Date: Thu, 11 Jul 2024 20:05:48 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: Improve variable names in
 nouveau_sched_init()
Message-ID: <ZpAe_OsUP0ZMO5J-@pollux>
References: <20240711173551.76148-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711173551.76148-1-pstanner@redhat.com>

On Thu, Jul 11, 2024 at 07:35:51PM +0200, Philipp Stanner wrote:
> nouveau_sched_init() uses the function drm_sched_init(). The latter
> function has parameters called "hang_limit" and "timeout" in its API
> documentation.
> 
> nouveau_sched_init(), however, defines a variable called
> "job_hang_limit" which is passed to drm_sched_init()'s "timeout"
> parameter. The actual "hang_limit" parameter is directly set to 0.

Good catch.

> 
> Define a new variable and rename the existing one to make naming
> congruent with the function API.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_sched.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
> index 32fa2e273965..ee1f49056737 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_sched.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
> @@ -404,7 +404,8 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
>  {
>  	struct drm_gpu_scheduler *drm_sched = &sched->base;
>  	struct drm_sched_entity *entity = &sched->entity;
> -	long job_hang_limit = msecs_to_jiffies(NOUVEAU_SCHED_JOB_TIMEOUT_MS);
> +	const long timeout = msecs_to_jiffies(NOUVEAU_SCHED_JOB_TIMEOUT_MS);
> +	const unsigned int hang_limit = 0;

Please don't create this variable though, it's not needed.

>  	int ret;
>  
>  	if (!wq) {
> @@ -418,7 +419,7 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
>  
>  	ret = drm_sched_init(drm_sched, &nouveau_sched_ops, wq,
>  			     NOUVEAU_SCHED_PRIORITY_COUNT,
> -			     credit_limit, 0, job_hang_limit,
> +			     credit_limit, hang_limit, timeout,
>  			     NULL, NULL, "nouveau_sched", drm->dev->dev);
>  	if (ret)
>  		goto fail_wq;
> -- 
> 2.45.0
> 


