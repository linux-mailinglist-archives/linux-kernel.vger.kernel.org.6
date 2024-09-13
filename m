Return-Path: <linux-kernel+bounces-328601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F8797865B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38878281817
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5124C7E0FF;
	Fri, 13 Sep 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TL+fxFfd"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC496BB4B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247038; cv=none; b=YijzkqFwdkgs+SHJy2HLndH8Wpw1rMaxo0PkYSuopRTL3KdpMmkHU3SHsW8JygVW56q+xy2BFAfkUFs+5ZHE+57MXSIWR6vmNA16gc9nng6d1PQD3MxuSvBrQ20UKNY54ejnSI8/eiQsH/GH824mkz6aDf7ZjUQXXw3bCzkJG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247038; c=relaxed/simple;
	bh=8WbxGBSvn5rwQymHF4M6G6ZnUhK1rbxtExhx/o7QBCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIsLFMLta3N8CZ71jEK6P98OCIIcKNkgnEzYuKsn/TgBVlGtb694/AYyrZg3BxNQBev63ZTTwzxylg1N0DWOVcg1LM+Y1+z6eB3lovWyvx63T2S0OAsjamm9mgodoyT7KtQei6l6JQOhJztz5iQmtH2Bn6RPhWqD277LPBj47PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TL+fxFfd; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4X50y828v0z9swM;
	Fri, 13 Sep 2024 19:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1726247024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avxAXBZIHosQwZAL3nU4/XFwoH0jkpslKikMAFvSkK4=;
	b=TL+fxFfdWtl3qFXmo4vJqbxXq60QOELM0HsKaXjcoYc42mBI+hCtUGvH83w0J5EAfI3iVp
	mrh3ucnd3Rr2laY6I4xtM90X8JCYIimf6FpJaI7s/PGPU6PAjbyC5vGjUoRSttqZ4NLaIy
	vwiP839t+KIsed+oaLCUYOTCn9PO69CzGpIXS7QwShtAQHVN0G5a7r5XAKkcs8dpVr9l+G
	9TfjaVDCaBVf/3Ct40/y1gFyGQzFDRrSTgvllzWp0DnAjAnwjhaYDeGAEpQ96268baCkKN
	2XgsaZwgBv6/TujSGlS980c8Xhoy2TgsnqBuU5gav4qA8faaQiSq+BnQtx41Og==
Message-ID: <fa243d3e-abe2-47d9-928f-70e24065baf1@mailbox.org>
Date: Fri, 13 Sep 2024 19:03:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/sched: Fix dynamic job-flow control race
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>, Asahi Lina <lina@asahilina.net>,
 Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Danilo Krummrich <dakr@redhat.com>, open list <linux-kernel@vger.kernel.org>
References: <20240913165326.8856-1-robdclark@gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20240913165326.8856-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cqrhgikb5fxynet6ffh9qq55ggbxmc5q
X-MBO-RS-ID: 3e2dbf2b7d24b5fb6bf

On 2024-09-13 18:53, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Fixes a race condition reported here: https://github.com/AsahiLinux/linux/issues/309#issuecomment-2238968609
> 
> The whole premise of lockless access to a single-producer-single-
> consumer queue is that there is just a single producer and single
> consumer.  That means we can't call drm_sched_can_queue() (which is
> about queueing more work to the hw, not to the spsc queue) from
> anywhere other than the consumer (wq).
> 
> This call in the producer is just an optimization to avoid scheduling
> the consuming worker if it cannot yet queue more work to the hw.  It
> is safe to drop this optimization to avoid the race condition.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index ab53ab486fe6..1af1dbe757d5 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1020,8 +1020,7 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
>  void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
>  		      struct drm_sched_entity *entity)
>  {
> -	if (drm_sched_can_queue(sched, entity))
> -		drm_sched_run_job_queue(sched);
> +	drm_sched_run_job_queue(sched);
>  }
>  
>  /**

The entity parameter is unused now.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

