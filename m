Return-Path: <linux-kernel+bounces-304909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60845962695
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D256CB22478
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F5C17335E;
	Wed, 28 Aug 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=boris.brezillon@collabora.com header.b="K1SW5Yyb"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762415B968
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846997; cv=pass; b=Ci2gMnG7IiWS+lrSeNfn5qtg6wiC8tkCPY7up4EJB54p7jSuHTUNll6Ik5wdBJ4XlhBl4yK2iAdX5wfEgHIp3qaf3kDNgX8XS/aqid8+VnqIyZsamc9EH3MaocI01pkx62uXDCf4sy04mtFB6/b7Ri6796Up9uU5Yk1TVA9QRsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846997; c=relaxed/simple;
	bh=SWxy9dNvuw9+7KrOKHf/BAYV82YT9IX/hCsz6DOZSLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ow8otLvK+bOlLm9xJ2fdsB0d6f2iWVC3rnADPisysDjU5rdzBBNyK7RsN+2cSp5oZ9HEBFm+6f1hyIdfuY2Lm3fRDbxI8SUfikK3Mz15tLoOFl9T3xVu2VY/AogwbzjRWe4d0KV1mxuPrzPoq2uqYcEaoPl2E454eenB46czWrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=boris.brezillon@collabora.com header.b=K1SW5Yyb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: mary.guillemard@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724846981; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HAzQoaczWakjbtMeXq46QXk5wl91/oKcwKW0j/VuM5ZPH3ufilNz9WpgOy/S/TLdk3w+t4EcMQ/mXMfj+HW6C5ne5cHJjGxzNRv5TlHOoQircgPx/xYQtT0+zypR54U716QJb/HXlOwzOf0jYIVtNe4wBekfx3ImN5VbNb/Q068=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724846981; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xntgS2uvEEMX85luL7QWnwVnGkglIAXxMpsX5Pn67Ys=; 
	b=IZisTRI58lHk3jkxTzp/prER0R9Xf+SM1Hj1UQvGTlyHJ54APsiurDppjm/PRW/7Ckb5MIedn2PT2p6AqJntGCh2eZUrXC4VRBTYza3OAIFO4CaJnfOGBFPvGf44zs8XoyhicjwZTb7Mdlbr71W1BbTEuAFmibMnX/CPgBxj88E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=boris.brezillon@collabora.com;
	dmarc=pass header.from=<boris.brezillon@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724846981;
	s=zohomail; d=collabora.com; i=boris.brezillon@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xntgS2uvEEMX85luL7QWnwVnGkglIAXxMpsX5Pn67Ys=;
	b=K1SW5Yybg9wwiJEZm4nJ6tR+gh2r6F+Wlsa19bmRjBVhIQSgN93cGyiP2vDKGfVW
	cvujmhykwJOHXJ4W1dpY28yQc8+iajYe9dnE4y1+irxYWo962osXc3l7O2tn/1n3SM2
	saUuCR0QCIhX0S2RUX9QsGVbGSNiMbgj1r1UBh5k=
Received: by mx.zohomail.com with SMTPS id 1724846979255972.6503075294414;
	Wed, 28 Aug 2024 05:09:39 -0700 (PDT)
Date: Wed, 28 Aug 2024 14:09:29 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Mihail Atanassov <mihail.atanassov@arm.com>
Cc: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Christopher Healy <healych@amazon.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
Message-ID: <20240828140929.5c602436@collabora.com>
In-Reply-To: <327a3440-8d01-4787-83be-a00fbbe0b593@arm.com>
References: <20240807153553.142325-2-mary.guillemard@collabora.com>
	<327a3440-8d01-4787-83be-a00fbbe0b593@arm.com>
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
X-ZohoMailClient: External

Hi Mihail,

On Thu, 8 Aug 2024 12:41:05 +0300
Mihail Atanassov <mihail.atanassov@arm.com> wrote:

> > 
> > +/** + * struct drm_panthor_timestamp_info - Timestamp information +
> > * + * Structure grouping all queryable information relating to the
> > GPU timestamp. + */ +struct drm_panthor_timestamp_info { +	/**
> > @timestamp_frequency: The frequency of the timestamp timer. */ +
> > __u64 timestamp_frequency; + +	/** @current_timestamp: The current
> > timestamp. */ +	__u64 current_timestamp;  
> 
> As it stands, this query has nothing to do with the actual GPU so
> doesn't really belong here.
> 
> It'd be more valuable, and can maybe give better calibration results
> than querying the system timestamp separately in userspace, if you
> reported all of:
>   * the system timer value
>   * the system timer frequency
>   * the GPU timer value
>   * the GPU timer frequency (because it _could_ be different in some 
> systems)

Duh, I wish this wasn't the case and all SoC vendors went for the
arch-timer which guarantees the consistency of the timestamp on the GPU
and CPU. But let's say this is a case we need to support, wouldn't it
be more useful to do the CPU/GPU calibration kernel side (basically at
init/resume time) and then expose the formula describing the
relationship between those 2 things:

CPU_time = GPU_time * GPU_to_CPU_mul / GPU_to_CPU_div +
	   GPU_to_CPU_offset;

>   * the GPU timer offset

Assuming you're talking about the TIMESTAMP_OFFSET register, my
understanding is that this offset should be set by the kernel driver to
account for any disjoint caused by suspend/resume cycles, or any
design-specific offset between the arch-timer and the timer feeding the
GPU timestamp block (hopefully the arch-timer is directly propagated to
the GPU though). The timestamp read by the GPU/CPU already has this
offset added, so I'm not sure I understand what's the value of exposing
it to userspace. As long as the CPU/GPU timestamps are consistent,
userspace probably doesn't care, but I might be missing something.

> 
> > +}; + /** * struct drm_panthor_dev_query - Arguments passed to
> > DRM_PANTHOR_IOCTL_DEV_QUERY */
> > 
> > base-commit: f7f3ddb6e5c8dc7b621fd8c0903ea42190d67452  
> 


