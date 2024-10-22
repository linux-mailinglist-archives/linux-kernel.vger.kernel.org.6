Return-Path: <linux-kernel+bounces-376106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F09AA01C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C282876F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4921993AF;
	Tue, 22 Oct 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZugQ+dNW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635218E02D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593061; cv=none; b=LOD6HvJBoWT4OrjntWkLqdXSp4PwzgTQ9BgB9Lg+/CUWRu/6porgUgRpxFZSpJAuFx8XY6UmcFts2BMQNaXoKJeauQ0FmvYbDOly1rDbiUFMtNpo9jgDP9Yu0sMiggeV68LKSjlOJIthsTTCyAwbxDE8cFMNlLuj/tP4uTFB8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593061; c=relaxed/simple;
	bh=ckwdXkesd1lkAUGXB2NkOvoDnLV225VqIN/edVwVwvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZDjm2PtPDaTPgj7Gz7UfS7zcKvKzKNj+BKuUWwLwgjr4GSOn01NfFnI2I5PiIF900xSKci+iB0/YXw+NFV0kO/v6fGE0gwA1wzpGM28CgI0Xhx/TnsxJqGauX14wZntJmRjxPNjRdvQ7OQj67xbnCh3RMREC0eTYaZTDQz+RxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZugQ+dNW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729593058;
	bh=ckwdXkesd1lkAUGXB2NkOvoDnLV225VqIN/edVwVwvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZugQ+dNW06+dJxsk1cWVB+lYF0mpPSqkQYI/H3V6ossWlAgrWOLWyA7p1B8q27PrB
	 l8twj9/sEBjLFl18AyixCNfEeif9uS6QGxJryyxGUL2ERta8Q/6JNYh1P4VOOnL/HT
	 OD8VsV2vB2lVJ+GvQtvk3T/3m/CO1B/C+lKCjyYcaCFJHg9SXZyvPSLRV/T1zu0iYK
	 wZD6FUFQZ6Cma4BpUAnRnoSOv0p9g7yZcy6hjeTw8ow3jZ4G8UeCQZTAp7PquALZdQ
	 Fm+qFuO8iCbEz1QfJCb3hPBvdc4kUxCi5Ci8oxEDNBTZ4t6qN4X8groTTTNdpt3/wN
	 JldAru3d8U/Jg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CBB9D17E1522;
	Tue, 22 Oct 2024 12:30:57 +0200 (CEST)
Date: Tue, 22 Oct 2024 12:30:52 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 faith.ekstrand@collabora.com
Subject: Re: [PATCH] drm/syncobj: ensure progress for syncobj queries
Message-ID: <20241022123052.3e0f3f17@collabora.com>
In-Reply-To: <20241017162054.2701638-1-olvaffe@gmail.com>
References: <20241017162054.2701638-1-olvaffe@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 09:20:53 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> Userspace might poll a syncobj with the query ioctl.  Call
> dma_fence_enable_sw_signaling to ensure dma_fence_is_signaled returns
> true in finite time.
> 
> ---
> 
> panvk hits this issue when timeline semaphore is enabled.  It uses the
> transfer ioctl to propagate fences.  dma_fence_unwrap_merge converts the
> dma_fence_chain to a dma_fence_array.  dma_fence_array_signaled never
> return true unless signaling is enabled.

Looks like a bugfix to me. Should we add Fixes+Cc-stable tags so it
gets backported to stable branches.

> ---
>  drivers/gpu/drm/drm_syncobj.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 4fcfc0b9b386c..58c5593c897a2 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1689,6 +1689,9 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
>  			    DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED) {
>  				point = fence->seqno;
>  			} else {
> +				/* ensure forward progress */
> +				dma_fence_enable_sw_signaling(fence);
> +
>  				dma_fence_chain_for_each(iter, fence) {
>  					if (iter->context != fence->context) {
>  						dma_fence_put(iter);


