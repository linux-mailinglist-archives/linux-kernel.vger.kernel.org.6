Return-Path: <linux-kernel+bounces-305429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A8962E78
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544B3281800
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC22A1A7052;
	Wed, 28 Aug 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JtMf+wBE";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ZxHYRJMn"
Received: from a7-49.smtp-out.eu-west-1.amazonses.com (a7-49.smtp-out.eu-west-1.amazonses.com [54.240.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA01A4B84
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866073; cv=none; b=GyUjZvbcikYmXV3s2YWHAEBhlH/jtLaAvXp+zIHKYCYb34Sip4lvwL5cgshP7YdzoVI5HSxuSJppY3pmB5uK6ftsJk2jqL7oikRpZWGWKg9oAAQTxkG0e0UNO9+OMiu/aG+DFkE6zb3yJ3vfoUASRPdiZqSs2Fz36kyWt8qWBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866073; c=relaxed/simple;
	bh=eGt8cEzUOUnC8smyg5wsy0R9ZyB5SWf7wZVjyoxAkn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dvo+6XIOsxM4Gbi67/WR7I3UTH0jWiOguDKBaqVAFOIZyCQ7b/kOfi+MVG4i8rmf3XDkyDYIzRr5X/L9GwnWZaeAznDzZM5sh2dqeBrJnw2gaOO+cOtGNKtpztOpES0o9W5NjectUGmQGggg0PXV/e2da1qDljSltpgt/Fbsi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JtMf+wBE; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ZxHYRJMn; arc=none smtp.client-ip=54.240.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1724866070;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eGt8cEzUOUnC8smyg5wsy0R9ZyB5SWf7wZVjyoxAkn0=;
	b=JtMf+wBE8Ev8QFIS9RvoY3yAGzlJMU1bq3rh+a6r5uhut1rZzLtGXqczFduU8J2c
	yQGiMALAw2IlGZo1cfqTLbJhstnqDKVT1M2AbNDC/cWU+dfnmX5c3jUkOECNZe5Rmm5
	TJg6a+43Bf3pEc9zVQPbWrbh5fTQG0HZv80G2ZIrXdIbk21MT3o3EekOTN5GEKUsJdJ
	Ta4tcK3zX0QYyhL1idklFT7Tx46ql5OcNR7j56hrmt5FTTJKCrwkDtUtgIYNprfo4Hb
	dbzacP1i36nnlT5eQbgaH4Z4YIWRPKyxwzC+9hAhmd9qz4YvDnC11plZnL0geEIMTNn
	uZEX6MDbAw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1724866070;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=eGt8cEzUOUnC8smyg5wsy0R9ZyB5SWf7wZVjyoxAkn0=;
	b=ZxHYRJMnbjDOEPKvv4LnNd/dVo1sL1wheY0QxYBplsDxr95FfYRyrS6JWYvhS/ZT
	/B7WSGXRn2bDE89bg5yDmMKJWZZ1VnviqixG5Rh5vxgxuLelg7IbWrnRKOYXmdWXgfC
	PZDr27kLfNYXYK5f30mnkmkI8dQgHfz7V+6cajAY=
Date: Wed, 28 Aug 2024 17:27:50 +0000
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Mihail Atanassov <mihail.atanassov@arm.com>
Cc: Mary Guillemard <mary.guillemard@collabora.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	kernel@collabora.com, Christopher Healy <healych@amazon.com>, 
	Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	nd@arm.com
Subject: Re: [PATCH] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
Message-ID: <010201919a07868c-a8b90e57-0e61-4a05-8271-f4f4f86ca4cf-000000@eu-west-1.amazonses.com>
In-Reply-To: <20240828180703.4510a4e2@collabora.com>
References: <20240807153553.142325-2-mary.guillemard@collabora.com>
	<327a3440-8d01-4787-83be-a00fbbe0b593@arm.com>
	<20240828140929.5c602436@collabora.com>
	<c38324e4-055f-44b5-beb4-6b3e6b860e69@arm.com>
	<20240828180703.4510a4e2@collabora.com>
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
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.08.28-54.240.7.49

On Wed, 28 Aug 2024 18:07:03 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Wed, 28 Aug 2024 14:22:51 +0100
> Mihail Atanassov <mihail.atanassov@arm.com> wrote:
> 
> > Hi Boris,
> > 
> > On 28/08/2024 13:09, Boris Brezillon wrote:  
> > > Hi Mihail,
> > > 
> > > On Thu, 8 Aug 2024 12:41:05 +0300
> > > Mihail Atanassov <mihail.atanassov@arm.com> wrote:
> > >     
> > >>>
> > >>> +/** + * struct drm_panthor_timestamp_info - Timestamp information +
> > >>> * + * Structure grouping all queryable information relating to the
> > >>> GPU timestamp. + */ +struct drm_panthor_timestamp_info { +	/**
> > >>> @timestamp_frequency: The frequency of the timestamp timer. */ +
> > >>> __u64 timestamp_frequency; + +	/** @current_timestamp: The current
> > >>> timestamp. */ +	__u64 current_timestamp;    
> > >>
> > >> As it stands, this query has nothing to do with the actual GPU so
> > >> doesn't really belong here.
> > >>
> > >> It'd be more valuable, and can maybe give better calibration results
> > >> than querying the system timestamp separately in userspace, if you
> > >> reported all of:
> > >>    * the system timer value
> > >>    * the system timer frequency
> > >>    * the GPU timer value
> > >>    * the GPU timer frequency (because it _could_ be different in some
> > >> systems)    
> > > 
> > > Duh, I wish this wasn't the case and all SoC vendors went for the
> > > arch-timer which guarantees the consistency of the timestamp on the GPU
> > > and CPU. But let's say this is a case we need to support, wouldn't it
> > > be more useful to do the CPU/GPU calibration kernel side (basically at
> > > init/resume time) and then expose the formula describing the
> > > relationship between those 2 things:
> > > 
> > > CPU_time = GPU_time * GPU_to_CPU_mul / GPU_to_CPU_div +
> > > 	   GPU_to_CPU_offset;
> > >     
> > 
> > TIMESTAMP_OFFSET should indeed be set by the kernel (on resume). But I 
> > don't think we need to post M/D+offset to userspace. The 2 Frequencies + 
> > the scalar offset are the raw sources, and userspace can work back from 
> > there.  
> 
> Sure. No matter how you express the relationship, my point was, if the
> calibration is supposed to happen in the kernel at resume time,
> returning both the CPU/GPU time in DEV_QUERY_TIMESTAMP to make sure the
> sampling is close enough that they actually represent the same
> timestamp might not be needed, because you can easily convert from one
> domain to the other.

I think it makes more sense after reading [1] :-). This being said, the
maxDeviation is here to account for any latency that might exists
between each domain sampling, so I'd be tempted to read the CPU
monotonic time through the regular syscalls rather than add it to the
DEV_QUERY_TIMESTAMP ioctl.

[1]https://docs.vulkan.org/features/latest/features/proposals/VK_EXT_calibrated_timestamps.html

