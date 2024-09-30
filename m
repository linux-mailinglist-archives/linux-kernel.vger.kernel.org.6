Return-Path: <linux-kernel+bounces-343516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856DD989BED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FAC1F220AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A26166F00;
	Mon, 30 Sep 2024 07:52:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423CC165F1E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682728; cv=none; b=hsbNmQlFgd1KmCEKep2prdjvsulcnWncPpXzWEycKLB4JZmot0PvjGwC+v5Oga1z4DaqzNrJiETLeyW7FUhxu8PMFyQNb9se13FzfhfM+k6lFUNfS00ixQphaDeFg5Kb+d4mhOOV1GYjM/Kb05QHOQ6UjxZpeJqHVprxeTNYPmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682728; c=relaxed/simple;
	bh=nwfJVHCtZGikZKleGgEFM5SdxFJAtdSrBjjgSNeh0P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oskk5h5iIajXWKkEtO0ys7ejJF6PbJohazoEc0WZW9PJqE/PC/VVC6MoxGgfYXPWuHHCbQf8jRyk4s4NkZSSmBo8Xc6jJdHDu4J0rp2DZpqalC3ymgTeuCMqH7o96qT5YSkH+xLJ+Ca9SwyZmDgochVchCjpk3z8YNE6ZiKgS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4AAEFEC;
	Mon, 30 Sep 2024 00:52:34 -0700 (PDT)
Received: from [10.57.76.28] (unknown [10.57.76.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872003F64C;
	Mon, 30 Sep 2024 00:52:02 -0700 (PDT)
Message-ID: <7a568b22-d259-4f04-98f7-b3b25f326037@arm.com>
Date: Mon, 30 Sep 2024 08:52:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Set FMODE_UNSIGNED_OFFSET in fop_flags
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Jan Kara <jack@suse.cz>, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240929221034.1889572-1-linkmauve@linkmauve.fr>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240929221034.1889572-1-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/09/2024 23:10, Emmanuel Gil Peyrot wrote:
> This fixes a regression introduced in commit
> 641bb4394f405cba498b100b44541ffc0aed5be1.  No panthor device, card or
> render node, could be open() since this commit, returning EINVAL
> instead.  This prevented Mesa from working on SoCs such as the rk3588
> which contains a Mali-G610 GPU.
> 
> The commit mentions which drivers must be changed to set that flag, but
> panthor seemingly got forgotten, triggering the WARN_ON_ONCE() added
> in drm_open_helper().

Hi Emmanuel,

Liviu posted an identical patch earlier:

https://lore.kernel.org/r/20240920102802.2483367-1-liviu.dudau%40arm.com

The problem is because 641bb4394f40 isn't yet back-merged into any DRM
tree we can't merge it yet (as that commit added the definition of
FOP_UNSIGNED_OFFSET).

Liviu was going to ask the DRM maintainers for advice - I'm not sure
what the outcome way. But anyway we should get -rc1 back-merged soon and
then can apply this to drm-misc-fixes.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 34182f67136c..c520f156e2d7 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1383,6 +1383,7 @@ static const struct file_operations panthor_drm_driver_fops = {
>  	.read = drm_read,
>  	.llseek = noop_llseek,
>  	.mmap = panthor_mmap,
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  #ifdef CONFIG_DEBUG_FS


