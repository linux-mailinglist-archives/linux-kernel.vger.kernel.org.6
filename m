Return-Path: <linux-kernel+bounces-398777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC779BF5F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7065B28173A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1192B202F8D;
	Wed,  6 Nov 2024 18:59:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21070208987
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919596; cv=none; b=OIGamSQuj5wK1Ad/9GKuotkldgm5Dv8HMK6ALirddy11V0FrLXC5TbdvakaRnw6Oq2fPtI8C4K0GW1cmcwYaY64XkbZwUZN8MViofFt5ekctfC2J2Qk7MwFdVvFXaNAj1dGTM6M3kzIisQjI5aQ/nZm/6I5LrJduzlAkoiGbSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919596; c=relaxed/simple;
	bh=rx0kaDsVZKaL8YeXydHw3Eqose6ARo4UL0m49ysgz1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxRGoIn9Jzz5eyY5X+1a/UQd1YXJyRkWzR7vB2rCAej+PyLeYav50CnKmiobi1JBtxwNujMCc0x9+CgjhI8XWpS5WxMjEg76gNOtUHgFMjYapU3l4QtCoQg5eFc3iadBUG6uXfhhicWpwnxLbQ72JNexXZLTrCZQhL7Lv0t2IG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 561F0497
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:00:23 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AF7E3F528
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:59:53 -0800 (PST)
Date: Wed, 6 Nov 2024 18:59:44 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Lock XArray when getting entries for heap
 and VM
Message-ID: <Zyu8oP3a4l678uhd@e110455-lin.cambridge.arm.com>
References: <20241106120748.290697-1-liviu.dudau@arm.com>
 <20241106131641.47487624@collabora.com>
 <ZytqzTg2QnEkvDcl@e110455-lin.cambridge.arm.com>
 <20241106142133.09378b5a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106142133.09378b5a@collabora.com>

On Wed, Nov 06, 2024 at 02:21:33PM +0100, Boris Brezillon wrote:
> On Wed, 6 Nov 2024 13:10:37 +0000
> Liviu Dudau <liviu.dudau@arm.com> wrote:
> 
> > panthor_heap_pool_release() does not take the panthor_heap_pool::lock, so the protection
> > is not really there. I could fix panthor_heap_pool_release() and then add a
> > lockdep_assert_held() before both calls to xa_load() if you think that's a better
> > solution.
> 
> Hm, but panthor_heap_pool_release() doesn't release the heap contexts,
> it just calls xa_destroy(). If we have objects remaining in the xarray,
> they'll be leaked, but that's not a race. BTW, can we make this two
> separate patches. I feel like the thing on the vm is an actual fix,
> while the second one (adding a helper with a lockdep_assert()) is
> safety net that's worth having, but not necessarily something we need
> to backport.

I've decided to drop the panthor_heap.c changes as Boris is right, the pool->lock
should be enough. Adding a lockdep_assert() right after the down_write() call
also feels a bit silly, so I did not bother with it.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

