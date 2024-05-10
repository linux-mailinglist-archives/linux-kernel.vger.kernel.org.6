Return-Path: <linux-kernel+bounces-176001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039A48C289B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272081C2469E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB7B172793;
	Fri, 10 May 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O3Pq4O36"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F86171E69;
	Fri, 10 May 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357993; cv=none; b=bpcuc/Y5XPf5sWQvefqOEX6HvTfoLlcWthaGqmG39+45f4ZsJpvmtqKWwV97mrdky088mFt/hm+Th9bEBlFa43/a7AZPwllxI56XscU2GuO8efn5Ply+cLlIVzUa4BGTyvDWKFK9S1tndN3gb0zHeFgr146eJCQkB4fTsoXVFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357993; c=relaxed/simple;
	bh=2O3IcUj/y/oFSH8nw9A6/t9ezhPzsGSPrVsREkagaKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwoLkwL9/No3wmsG+dIXW6Ksrp2EaTNPf4pSo/YfOlEmrbLPK7l3WlY3G9Yy/LjeqEkMTEwPFW8N9i6luwGA3VbcAvynAvhxUzbbY+Gp7yz3yTH9+jdPiyhKZDf6lhDhOeU1LO2i+rfAw+RERKYkezzoppzwxFMs0n3b1wwhOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O3Pq4O36; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D3FD1C0005;
	Fri, 10 May 2024 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715357988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbabZJ/2W2xFmYWiTlcU5Sr+WrjFVh8Q4pQSbiNIFzU=;
	b=O3Pq4O36UcSLsRyGKiy+PiMqvNUx9X/1DUatpy134SIpYRFn8rhReygYL0CVB+BGCwk6fZ
	YZP0/b5iKrIfhme5Bx77TR5eQdjQp9V/fFB1ycAMT/rdGpTmdW8JkS8Jn+vr5bXvgn88EX
	IvAP5E0PS8htzcI3nvFtwP3ayiRgpj3QJ1DG6zj09Z9ec69cOs9b0vNt9/HcF9TnJOron7
	2C3gmqD+GMuXyXFryMVfoAVwLYWInvEESrq6J1r9cEv5vzr4TkEr9m9Sjb+d7n/5Qbfsov
	9J5TF1dki3TkzOI5DxCWU+MULXs3azP6JW3IQaF1AOuskaHomx1481s/qg9vkA==
Date: Fri, 10 May 2024 18:19:45 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Shargo <jshargo@google.com>
Cc: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	daniel@ffwll.ch, brpol@chromium.org, corbet@lwn.net,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	hirono@chromium.org, jshargo@chromium.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, marius.vlad@collabora.com,
	mduggan@chromium.org, melissa.srw@gmail.com, mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com, tzimmermann@suse.de
Subject: Re: [PATCH v6 0/7] Adds support for ConfigFS to VKMS!
Message-ID: <Zj5JIah0jWnIn2Ix@localhost.localdomain>
Mail-Followup-To: Jim Shargo <jshargo@google.com>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	daniel@ffwll.ch, brpol@chromium.org, corbet@lwn.net,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	hirono@chromium.org, jshargo@chromium.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, marius.vlad@collabora.com,
	mduggan@chromium.org, melissa.srw@gmail.com, mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com, tzimmermann@suse.de
References: <ZjCtgSaL50YrS-F-@phenom.ffwll.local>
 <20240508181744.7030-1-jose.exposito89@gmail.com>
 <CACmi3jF6Dp3PE8X=T5kTO2+eYJQi7jWACFdmp9jzKxUtcQphnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACmi3jF6Dp3PE8X=T5kTO2+eYJQi7jWACFdmp9jzKxUtcQphnQ@mail.gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 09/05/24 - 18:18, Jim Shargo a écrit :
> Sima--thanks SO MUCH for going through with everything leaving a
> detailed review. I am excited to go through your feedback.
> 
> It makes me extremely happy to see these patches get people excited.
> 
> They've bounced between a few people, and I recently asked to take
> them over again from the folks who were most recently looking at them
> but haven't since had capacity to revisit them. I'd love to contribute
> more but I am currently pretty swamped and I probably couldn't
> realistically make too much headway before the middle of June.
> 
> José--if you've got capacity and interest, I'd love to see this work
> get in! Thanks!! Please let me know your timeline and if you want to
> split anything up or have any questions, I'd love to help if possible.
> But most important to me is seeing the community benefit from the
> feature.
> 
> And (in case it got lost in the shuffle of all these patches) the IGT
> tests really make it much easier to develop this thing. Marius has
> posted the most recent patches:
> https://lore.kernel.org/igt-dev/?q=configfs
> 
> Thanks!
> -- Jim
> 
> 
> 
> On Wed, May 8, 2024 at 2:17 PM José Expósito <jose.exposito89@gmail.com> wrote:
> >
> > Hi everyone,
> >
> > I wasn't aware of these patches, but I'm really glad they are getting
> > some attention, thanks a lot for your review Sima.
> >
> > Given that it's been a while since the patches were emailed, I'm not
> > sure if the original authors of the patches could implement your
> > comments. If not, I can work on it. Please let me know.
> >
> > I'm working on a Mutter feature that'd greatly benefit from this uapi
> > and I'm sure other compositors would find it useful.
> >
> > I'll start working on a new version in a few days if nobody else is
> > already working on it.
> >
> > Best wishes,
> > José Expósito

Hi all!

Very nice to see other people working on this subject. As the series 
seemed inactive, I started two weeks ago to rebase it on top of [1]. I 
also started some work to use drmm_* helpers instead of using lists in 
vkms. I currently struggle with a deadlock during rmmod.

I need to clean my commits, but I can share a WIP version.

Maybe we can discuss a bit the comment from Daniel (split init between 
default/configfs, use or not a real platform device...)

For the split, I think the first solution (struct vkms_config) can be 
easier to understand and to implement, for two reasons:
- No need to distinguish between the "default" and the "configfs" devices 
  in the VKMS "core". All is managed with only one struct vkms_config.
- Most of the lifetime issue should be gone. The only thing to 
  synchronize is passing this vkms_config from ConfigFS to VKMS.

The drawback of this is that it can become difficult to do the "runtime" 
configuration (today only hotplug, but I plan to add more complex stuff 
like DP emulation, EDID selection, MST support...). Those configuration 
must be done "at runtime" and will require a strong synchronization with 
the vkms "core".

Maybe we can distinguish between the "creation" and the "runtime 
configuration", in two different configFS directory? Once a device is 
created, it is moved to the "enabled" directory and will have a different 
set of attribute (connection status, current EDID...)

For the platform driver part, it seems logic to me to use a "real" 
platform driver and a platform device for each pipeline, but I don't have 
the experience to tell if this is a good idea or not.

[1]: https://lore.kernel.org/dri-devel/20240409-yuv-v6-0-de1c5728fd70@bootlin.com/

Thanks,
Louis Chauvet

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

