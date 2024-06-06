Return-Path: <linux-kernel+bounces-204166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC438FE51C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC452876A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7816F195392;
	Thu,  6 Jun 2024 11:18:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB7153585
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672735; cv=none; b=Dgco7KDeh0j9/q+LveXfOEN7C69PFZ+p25FZH0BewieBXz/Lt5XLzYQ2BGHkw0wHHb0WOiFIX9+kNwImw2qEtq4k4Kg557A+dnB9CwIUQhF0us6M7bMlVA0MqdNeWQCkikWxjd6caLafROT6B2WlomTmgzUDtVqE5GHTLEQ03xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672735; c=relaxed/simple;
	bh=7jev0F1MNj88ehg7RxQ/SzvgEtu1Ajfuk8eCFTpmozM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlqFeKbtmk0KNMswaqVkRjqC2lVBYUCVdNrpo9on5D6YyKALLLoJyew3nchYlBxxqyt7H3fdfxqeVkOYBY7QOwsRW6O53RLSfwBHru2xts28aIMV0TJG7oaTYd9ZfDuXZ/+BVJlZpcbwWFWOedBOVUSgsNw4XNM1rLQTLltIS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D3571576
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 04:19:17 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 59BC73F762
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 04:18:52 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:18:43 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: pengfuyuan <pengfuyuan@kylinos.cn>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] arm/komeda: Compile DEFINE_SHOW_ATTRIBUTE() only when
 CONFIG_DEBUG_FS is enabled
Message-ID: <ZmGbE3g_OFuowEgF@e110455-lin.cambridge.arm.com>
References: <20240606075846.1307007-1-pengfuyuan@kylinos.cn>
 <87ed9abhxx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ed9abhxx.fsf@intel.com>

On Thu, Jun 06, 2024 at 11:20:58AM +0300, Jani Nikula wrote:
> On Thu, 06 Jun 2024, pengfuyuan <pengfuyuan@kylinos.cn> wrote:
> > We do not call komeda_debugfs_init() and the debugfs core function
> > declaration if CONFIG_DEBUG_FS is not defined, but we should not
> > compile it either because the debugfs core function declaration is
> > not included.
> >
> > Reported-by: k2ci <kernel-bot@kylinos.cn>

Can we see what the bot reported?

> > Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> 
> An interesting alternative might actually be to remove *all* the
> CONFIG_DEBUG_FS conditional compilation from the file. Since the debugfs
> functions have no-op stubs for CONFIG_DEBUG_FS=n, the compiler will
> optimize the rest away, because they're no longer referenced. (For the
> same reason, I don't think this patch has an impact for code size.)
> 
> The upside for removing conditional compilation is that you'll actually
> do build testing for both CONFIG_DEBUG_FS config values. Assuming most
> developers have it enabled, there's not a lot of testing going on for
> CONFIG_DEBUG_FS=n, and you might introduce build failures with the
> conditional compilation.
> 
> Of course, up to Liviu to decide.

Yeah, I quite like the idea of removing the conditional compilation from
the file entirely.

Pengfuyuan, do you mind sending a new patch removing all the CONFIG_DEBUG_FS
from the file, rather than moving things around?

Best regards,
Liviu

> 
> 
> BR,
> Jani.
> 
> 
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > index 14ee79becacb..7ada8e6f407c 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -21,6 +21,7 @@
> >  
> >  #include "komeda_dev.h"
> >  
> > +#ifdef CONFIG_DEBUG_FS
> >  static int komeda_register_show(struct seq_file *sf, void *x)
> >  {
> >  	struct komeda_dev *mdev = sf->private;
> > @@ -43,7 +44,6 @@ static int komeda_register_show(struct seq_file *sf, void *x)
> >  
> >  DEFINE_SHOW_ATTRIBUTE(komeda_register);
> >  
> > -#ifdef CONFIG_DEBUG_FS
> >  static void komeda_debugfs_init(struct komeda_dev *mdev)
> >  {
> >  	if (!debugfs_initialized())
> 
> -- 
> Jani Nikula, Intel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

