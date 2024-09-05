Return-Path: <linux-kernel+bounces-316516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E796D092
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE61CB20C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E43192D70;
	Thu,  5 Sep 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l1r5SLHA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB618A94F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521970; cv=none; b=oyzH5NzCY1hUQ+PMlSHv5V8sovQMk7riuq7jkjQoY7IjDbxAaQ0a9WcwwaVyQOdsFgMscIG86QuYluKC1AirEjYP/H7vd/d4hpfq+VmE+WXlBiwVgn0K+jJtJRYJmIEYyi1x6jCYw3OM6O6gHI+QRbUTlCh1se9A3kaOD1OMweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521970; c=relaxed/simple;
	bh=6PVIDeH5+SCHyQgXpSCPJGW2vBWFSE2R18JkRXg2fy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRSdtG+mQ7lOc2HogrpI0MtYd6+U1exIKcImqwqRPpqwOfh2lJRHJLCfWskYDm31+judGdxhH2h9TsXZU3CS8GczcWhg0GR81pJ31pMOK4zRMbuZ/9Pzif6G4mz142lofhErR6+Soo9r83imSIO+wjbmXYz3rpHsnQ7Nw25LpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l1r5SLHA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725521966;
	bh=6PVIDeH5+SCHyQgXpSCPJGW2vBWFSE2R18JkRXg2fy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l1r5SLHAinmX5GH3XdbcDGHgxIP59IRIO4BfwfXkgQMjd9p1nJW8kZQhdNAY1YNAp
	 5SdAmzzPc2gp95yxF8qStTeSWSV/5IvkxZ8A7RXiDO6kuG/dWlL0o+kwbKDkco1eEJ
	 Vl0g8KAasK4HPDYhviTFavg9/TnzObqu72Wqn1CDcPgd7Dth3SPXonBTBq2ptggNgB
	 Rd6LpkaTGFiKeN3W4a6Etx+NIbFpBUO8xp1rZYYbH+xkW4O6lpDug35WmFrPX2IsU5
	 qo8CbXYZjL3HY7f2w0ZdSN1qoKDQQMPVRJttmd3WfKG7cyNI//ccsWhsknABkhDW9e
	 S1z+HfAr7aUVQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D86C217E0F93;
	Thu,  5 Sep 2024 09:39:25 +0200 (CEST)
Date: Thu, 5 Sep 2024 09:39:23 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Mary Guillemard <mary.guillemard@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com, Mihail Atanassov
 <mihail.atanassov@arm.com>, Steven Price <steven.price@arm.com>, Liviu
 Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
Message-ID: <20240905093923.64ca39e1@collabora.com>
In-Reply-To: <20240904121911.31ddaf09@collabora.com>
References: <20240830080349.24736-2-mary.guillemard@collabora.com>
	<20240904121911.31ddaf09@collabora.com>
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

On Wed, 4 Sep 2024 12:19:11 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Fri, 30 Aug 2024 10:03:50 +0200
> Mary Guillemard <mary.guillemard@collabora.com> wrote:
> 
> > Expose timestamp information supported by the GPU with a new device
> > query.
> > 
> > Mali uses an external timer as GPU system time. On ARM, this is wired to
> > the generic arch timer so we wire cntfrq_el0 as device frequency.
> > 
> > This new uAPI will be used in Mesa to implement timestamp queries and
> > VK_KHR_calibrated_timestamps.
> > 
> > Since this extends the uAPI and because userland needs a way to advertise
> > those features conditionally, this also bumps the driver minor version.
> > 
> > v2:
> > - Rewrote to use GPU timestamp register
> > - Added timestamp_offset to drm_panthor_timestamp_info
> > - Add missing include for arch_timer_get_cntfrq
> > - Rework commit message
> > 
> > v3:
> > - Add panthor_gpu_read_64bit_counter
> > - Change panthor_gpu_read_timestamp to use
> >   panthor_gpu_read_64bit_counter
> > 
> > v4:
> > - Fix multiple typos in uAPI documentation
> > - Mention behavior when the timestamp frequency is unknown
> > - Use u64 instead of unsigned long long
> >   for panthor_gpu_read_timestamp
> > - Apply r-b from Mihail
> > 
> > Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
> > Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>  
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Queued to drm-misc-next.

