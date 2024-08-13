Return-Path: <linux-kernel+bounces-284572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F695029F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C7B1F218C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859A193094;
	Tue, 13 Aug 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwzEhyq3"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5842170A18;
	Tue, 13 Aug 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545659; cv=none; b=Oa3MYDfxiEITmw9+HBIkf7GdPxx1tik1hcVw+gJhznX6Qld51xcfbu3DWevsusjfw0u4TEYBNHdiQ/IhY8+2Ka6czCso6FVq27VkbNRRaPoeGatTS0U1Y0pE7BELAPjiawMy4HJfIhGJrYg8L9/A2QfbdgrsrlX5Q8S5feYegFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545659; c=relaxed/simple;
	bh=Fp90d7EQn1pt4MJXrpVgCCudh+WngdMzXIDpdOX9gT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vamlg7HatsNwQIYg9EaUx1NkSAelWFd/S2DEBOpelJAgbXv42c1Lc8KPqa92QeHBBEU0czsrJlY0MFuOScF3krJPIdlNJS1KeG1WdoR3ZfaI8y27VyPu3CriT7QqSCX6liF/j+ZcBXcDQaHJ0RQ9+lprGAJcVTUzdINWogy7NY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwzEhyq3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3685a5e7d3cso3270582f8f.1;
        Tue, 13 Aug 2024 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723545656; x=1724150456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=21uElUyce8JR249X6uJAS7PnRRTOtflHbVAbFYHYmwk=;
        b=TwzEhyq3uNsz0VoIJ4zuOjl04AAYZaCNu7jtGkp0ICfgX/ODbnIZCIBdz/oTEqJsaq
         YnMX0SVI8LUCGgU44R3RXbfA0wM209zIN98o7jhwldr5NnigZHkVWR55yR8eBv8C08BV
         mTbSXof4hoYDs7YxHVu7EW4XiMExd5TnEyPkUfn254/YjuCXT9jlM0toDtqYYxq8IH/l
         vqhykQ30VzEwkw8Pk3oUdKlhIh6GfzxLT2B2BVgaXc9vKiUITkB+VFmxh9hO6mfxxHPq
         y1q/Lt1HethHcn+pgDEWcNBHFkXePPodQJtCh9DV79W7lznG+Jqg9PGvHPYKX1Sx9TRV
         PSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723545656; x=1724150456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21uElUyce8JR249X6uJAS7PnRRTOtflHbVAbFYHYmwk=;
        b=alNc7PFKf5aSeclnD1L9pPGhBlnJ6RriJZUXh1oqDrFMhzx1LuiRWgDq826gtreKWx
         xYuuWiniwaJ9B52aHmJSSLAH25Tgu/T4DMWOYvsslDVFSHqCnQm1Dhwl36Uu7IASvcwD
         lhO3uJDWBQ5SvoBz3aKugUXBxCzOxtVhGjb2LwdHOM/9tnPRJnJD6/itb0FpPKucJz4G
         PtpGDcCyssxNMkzcYeZDU+CB8OflRqWYBvtR5lL1Tsy+QVD96e6GJm46k+GY0BM/JXWv
         KinsNutDRRYXO3dPgvaseu1AbDdgfIIl/25geCcWeZw0FtgSYL15UaH4L89PJiAYrJem
         6B1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXdZEFBggLTCkshzn8+ecwRQDR9kfit8ns+2FHy+5EpKSTb2acaN2p/fQuRHSD3cp5RmvK25uVx4BSciS7JfmvZPkO+nciH1pqUfb0nhQq1dh4eAKxFc0bcQ9rjj18MZwsGyUf9qNC
X-Gm-Message-State: AOJu0YwZaQ/N6iZQ0774f7sfi4S0YOSasr2zbNNenQaaq3n6mYh6mZgu
	rTTwKRiQKVqSjEb4IeRobyn5F3zFMjDB7o4O9uOx98HcgUtUo/Yx
X-Google-Smtp-Source: AGHT+IEOCDk/eufgFxeF7PpSktbwtQYgJNiXJF2+V70NlTfR0jqK/v79u3BSknWzkzE+26GFwngCkw==
X-Received: by 2002:a05:6000:186c:b0:36b:a3c7:b9fd with SMTP id ffacd0b85a97d-3716cd3a62fmr2856837f8f.56.1723545655652;
        Tue, 13 Aug 2024 03:40:55 -0700 (PDT)
Received: from fedora ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bcc5sm9843187f8f.24.2024.08.13.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:40:55 -0700 (PDT)
Date: Tue, 13 Aug 2024 12:40:53 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Marius Vlad <marius.vlad@collabora.com>,
	Jim Shargo <jshargo@google.com>, daniel@ffwll.ch,
	brpol@chromium.org, corbet@lwn.net, dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com, hirono@chromium.org, jshargo@chromium.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, mduggan@chromium.org, melissa.srw@gmail.com,
	mripard@kernel.org, rodrigosiqueiramelo@gmail.com,
	tzimmermann@suse.de, maarten.lankhorst@linux.intel.com
Subject: Re: [RFC] Adds support for ConfigFS to VKMS!
Message-ID: <Zrs4NY5FkMEomaog@fedora>
References: <ZrZZFQW5RiG12ApN@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrZZFQW5RiG12ApN@louis-chauvet-laptop>

Hi Louis,

On Fri, Aug 09, 2024 at 07:59:49PM +0200, Louis Chauvet wrote:
> Hi everyone,
> 
> I'm excited to share some good news! I've recently completed the addition 
> of a ConfigFS interface to VKMS, which allows to configure VKMS from 
> user-space, at runtime. You should be able to:
> - Create new devices
> - Create planes/crtc/encoders
> - Configure rotation, color range, color encoding
> - Link planes, crtc and encoders.

Nice! Thanks for the hard work.

During the last 2 or 3 weeks I worked on ConfigFS support as well and
I have an RFC series ready to be sent to the mailing list.
My version is a bit simpler than yours because it doesn't implement extra
features (color formats, etc) and it can be applied on drm-misc-next.
I'll send the RFC as soon as I finish typing this email :)

I don't have any preference about which ConfigFS series we end up
using as long as we get the feature implemented.
Instead, I think that having 2 different implementations is a great
opportunity for better reviews because we have a good idea about how
the implementation might look like and it'll make easier to find bugs.

> The entire series can be found on my GitHub repository:
> https://github.com/Fomys/linux/tree/b4/new-configfs
> 
> This series is big, consisting of over 40 commits. Although it's not 
> completely cleaned up, all commits compile successfully and (almost) pass 
> checkpatch.
> 
> I plan to split this series into several smaller ones:
> 
>  - Adding support for additional color formats
> 	4a4f75873cca..d74006d7f9c4
>  - Reintroducing the writeback algorithm
> 	9e74d259e1be..f839dcf6a7d8
>  - Clarifying documentation
> 	b3bfd0ba2283..93945f0fbfc7
>  - Properly splitting headers
> 	c70018038572..67258bd8a180
>  - Switching to drmm_ helpers
> 	844e701e1d6d..f3050d125f64
>  - Using a proper platform device driver
> 	4658f99dfe3e..a3258e4d7550
>  - Introducing a vkms_config structure
> 	95ad6da46638..5b2d080b4626
>  - Adding ConfigFS support
> 	866ad75102ae..f900ad18ab8c
> 
> What's currently missing:
> 
>  - A deep cleanup to ensure checkpatch compliance and proper
>    functionality for every commit
>  - Updating documentation
>  - Reviews 
> 
> The primary area where I need assistance is reviews and testers. I'm aware 
> that Maìra is very busy and can't review quickly, but any other 
> individuals who can test and/or review this series would be greatly 
> appreciated.
> 
> My next step is to add connector support, but as I will use this work and 
> my previous series [1], I would like to see it merged first.
> 
> If any of the original authors would like to be credited for 
> their contributions, please let me know. I rewrote most of the code, but 
> the general idea was originally from them.
> 
> José, I am sorry, I think I missed your mail where you told me you already 
> reviewed some commits: 
> 
> > I reviewed the first 9 patches and added a few comments on your
> > GitHub fork.
> 
> I am not able to find any comments, can you send me the link to the page 
> with them? I would like to read/apply them before submitting the first 
> part of the series.

My comments were in the GitHub commits, but I think they were lost after
rebasing/force pushing.

Hopefully, I saved a copy of your patches with my suggestions applied and
commit messages where missing:
https://github.com/JoseExposito/linux/commits/patch-vkms-header-refactor/

I think you should be able to extract the diff easily.

It might be a better idea to share the patches in the mailing list for
broader discussion and to avoid loosing review comments.

Thanks a lot for your work Louis!
José Expósito

> Thanks for your time,
> Louis Chauvet
> 
> [1]: https://lore.kernel.org/all/20240809-yuv-v10-0-1a7c764166f7@bootlin.com/
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

