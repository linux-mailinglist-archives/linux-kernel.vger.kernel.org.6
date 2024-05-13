Return-Path: <linux-kernel+bounces-177823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDFF8C4504
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1FE1C22D52
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597315534D;
	Mon, 13 May 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAIsV2a8"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087914D2BF;
	Mon, 13 May 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617389; cv=none; b=CB9Tm+9QKG+7x5wp/DSeOOYX0YvCqDWg7faCywDalZxQBGRuUABt/d1BYZYG/upwlRRM5UpPTP/MzY7kIWSIPLMabLOxlsIw1GrcurguVnrGgqZp8JlTTrnhqijJ3mDK9V9Ggpel6nFN2lM79qhpb3vDBDLZaneRJNdJND+Ny+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617389; c=relaxed/simple;
	bh=tU5iMDV8gjUhmVJh7j8CQlek2eWRD3LUNk3dM4XNrHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS3ZqakO91WxTFpS22LMAHp9svCtCvL1y5z+TE7n13+z18C5iyi/ZbmRRMnPLDt9mKX6es+A5tOPWwxhpnBiImeq7nQ/hX3Kfp2ExfbtHHrIWcFms3dEjDFsdo3TCjntCgU0T28LFBjLUxHl0ichpOh0+GG7bOnlzoCS0e22PCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAIsV2a8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59c0a6415fso1250445566b.1;
        Mon, 13 May 2024 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715617386; x=1716222186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=do8Ze4h0ioxHWgi223BvWvnwG6lXL2Rpq7UGOO6zuhE=;
        b=jAIsV2a8l1vKCdtU048ymf9TIBj3RU6EZSmaryK8LgvGZypRH48PgCYOr/Zscsz9OD
         qHKtvgDPeibOSw96sWrXSQG0cCQ8/nCB0brwwF106ph+Bpv8BvTTs/nCkW10gXXBpzYE
         G7JfVxJHNL+bzyEU3Mxmntp6yGVkF5q5Gr3LIdnc9SozKqkIyCDu40qyAtzQYCeoCKYy
         CaNVTGWy+hmckmjsatytb5Sw3dDTL2OaG9+FfC+Bvru/f06tUOC1xwQSbuJeHCFwL0Th
         ddQjjipc44JxxSm4Wn3FxyvjKDFYIMQE3EzMRD5qQj2CqBKHmoRIqfhmtXHlFwoLgfwu
         f6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617386; x=1716222186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=do8Ze4h0ioxHWgi223BvWvnwG6lXL2Rpq7UGOO6zuhE=;
        b=DCWBKFrRpUOmvMjk3r60ESTbv4g15NOExGXRqVzgsbJ1b3DxuyFU5COs6vgoH8MbtL
         G3UN0yrz11PhHqOWuZKq95DhkwzxxH6rQ1Yj9byrfiG0PgJPCBvLVYK+rKafguyOCwdX
         d/jFkrmK3XafG2J01G/Ab88qnTjOSgjLme1HPEXEwD2j6za2uOhrRYKowpMEQEIER6UU
         89/C4jLx+M3roDE8VzQ4RUoPyrOkMDk2pqWbg7glQObAX1txNny877OaTZy0WUmC/mc+
         o2Wsf8cLB3Ws1WU/fYD+I4Rlkfcrd8pOiEBU/uWo1Q4/gxgpecpACXdcQESGtVqAo3ed
         ulJA==
X-Forwarded-Encrypted: i=1; AJvYcCXDDPCLx2N0tOUwQKmmKKfVZINfoLlGh0zi8Ih3ofA62V+DC3is8PqDe36F+3UIF41gyAFfNVs1GX9X7xujfLIWWxzmSRlRWgeAN4PAkM1przbDiTW34cE6Get/819mDiSKWvu1dAsP
X-Gm-Message-State: AOJu0Yy/CjdoouDYzA/MDhwlGxGj9t8MUGrmoi1pN2lr7Pa5bN5ekqeN
	qfpWr86Fhw0ryb0Ocq5wOAdSixY9PUJ+OiXNa6qRy46f07drpZOl
X-Google-Smtp-Source: AGHT+IHKC6CrHUOjOmuZQsPk6EGTrsHOWj8+gQvMSh7sQSxaD6YJXgmgkBvr6YUSEsKf5bV1e1GGNQ==
X-Received: by 2002:a17:906:a08:b0:a59:c3e2:712f with SMTP id a640c23a62f3a-a5a2d536941mr627228866b.9.1715617385345;
        Mon, 13 May 2024 09:23:05 -0700 (PDT)
Received: from fedora ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b016e2sm611980666b.155.2024.05.13.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:23:04 -0700 (PDT)
Date: Mon, 13 May 2024 18:23:02 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Marius Vlad <marius.vlad@collabora.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
	Jim Shargo <jshargo@google.com>, daniel@ffwll.ch,
	brpol@chromium.org, corbet@lwn.net, dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com, hirono@chromium.org, jshargo@chromium.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, mduggan@chromium.org, melissa.srw@gmail.com,
	mripard@kernel.org, rodrigosiqueiramelo@gmail.com,
	tzimmermann@suse.de
Subject: Re: [PATCH v6 0/7] Adds support for ConfigFS to VKMS!
Message-ID: <ZkI-ZjAYCJaMvmQD@fedora>
References: <ZjCtgSaL50YrS-F-@phenom.ffwll.local>
 <20240508181744.7030-1-jose.exposito89@gmail.com>
 <CACmi3jF6Dp3PE8X=T5kTO2+eYJQi7jWACFdmp9jzKxUtcQphnQ@mail.gmail.com>
 <Zj5JIah0jWnIn2Ix@localhost.localdomain>
 <ZkHKhtBmyS12i3fH@fedora>
 <ZkHXS6iBLgRoApNl@xpredator>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkHXS6iBLgRoApNl@xpredator>

On Mon, May 13, 2024 at 12:03:07PM +0300, Marius Vlad wrote:
> Hi all,
> On Mon, May 13, 2024 at 10:08:38AM +0200, José Expósito wrote:
> > On Fri, May 10, 2024 at 06:19:45PM +0200, Louis Chauvet wrote:
> > > Le 09/05/24 - 18:18, Jim Shargo a écrit :
> > > > Sima--thanks SO MUCH for going through with everything leaving a
> > > > detailed review. I am excited to go through your feedback.
> > > > 
> > > > It makes me extremely happy to see these patches get people excited.
> > > > 
> > > > They've bounced between a few people, and I recently asked to take
> > > > them over again from the folks who were most recently looking at them
> > > > but haven't since had capacity to revisit them. I'd love to contribute
> > > > more but I am currently pretty swamped and I probably couldn't
> > > > realistically make too much headway before the middle of June.
> > > > 
> > > > José--if you've got capacity and interest, I'd love to see this work
> > > > get in! Thanks!! Please let me know your timeline and if you want to
> > > > split anything up or have any questions, I'd love to help if possible.
> > > > But most important to me is seeing the community benefit from the
> > > > feature.
> > > > 
> > > > And (in case it got lost in the shuffle of all these patches) the IGT
> > > > tests really make it much easier to develop this thing. Marius has
> > > > posted the most recent patches:
> > > > https://lore.kernel.org/igt-dev/?q=configfs
> > > > 
> > > > Thanks!
> > > > -- Jim
> > > > 
> > > > 
> > > > 
> > > > On Wed, May 8, 2024 at 2:17 PM José Expósito <jose.exposito89@gmail.com> wrote:
> > > > >
> > > > > Hi everyone,
> > > > >
> > > > > I wasn't aware of these patches, but I'm really glad they are getting
> > > > > some attention, thanks a lot for your review Sima.
> > > > >
> > > > > Given that it's been a while since the patches were emailed, I'm not
> > > > > sure if the original authors of the patches could implement your
> > > > > comments. If not, I can work on it. Please let me know.
> > > > >
> > > > > I'm working on a Mutter feature that'd greatly benefit from this uapi
> > > > > and I'm sure other compositors would find it useful.
> > > > >
> > > > > I'll start working on a new version in a few days if nobody else is
> > > > > already working on it.
> > > > >
> > > > > Best wishes,
> > > > > José Expósito
> > > 
> > > Hi all!
> > > 
> > > Very nice to see other people working on this subject. As the series 
> > > seemed inactive, I started two weeks ago to rebase it on top of [1]. I 
> > > also started some work to use drmm_* helpers instead of using lists in 
> > > vkms. I currently struggle with a deadlock during rmmod.
> > > 
> > > I need to clean my commits, but I can share a WIP version.
> > 
> > Hi Louis,
> > 
> > If you could share a RFC/WIP series it would be awesome!
> > 
> > Since you are already working on the kernel patches (and I guess IGT?),
> > I'll start working on a libdrm high level API to interact with VKMS from
> > user-space on top of your patches. I'll share a link as soon as I have a
> > draft PR.
> 
> Just out of curiosity what API would that be? These should fairly
> simple that they can be configured from a shell script 
> (mount/mkdir/rm/echo/umount). Believe should be easy enough to test stuff with 
> bunch scripts like that.

My plan is to add a very thin C API around mkdir/rmdir/etc.

It is true that VKMS can be configure easily using a bash script; however,
compositors with test suites written in C (or with bindings to libdrm) would
have to write similar wrappers around the mkdir/rmdir/etc calls.
I think that it could be beneficial for them to have a shared wrapper available
in libdrm.
 
> Perphas landing the I-G-T tests first (assuming we're settled 
> on how exactly this would work) might be of greated help to get a green lit 
> the kernel driver side? Skip if vkms/configfs/something else that tells
> us VKMS doesn't have ConfigFS eneabled, and run it when that is on.
> 
> The lastest iteration was shared by Jim at 
> https://lore.kernel.org/igt-dev/20230901092819.16924-1-marius.vlad@collabora.com/
> 
> That way sub-sequent BAT CI would pick up issues, and can also used
> independently by Louis. Should also divide the work-load evenly with
> Louis focusing on the just the driver. Happy to review and test it.
> 
> > 
> > > Maybe we can discuss a bit the comment from Daniel (split init between 
> > > default/configfs, use or not a real platform device...)
> > > 
> > > For the split, I think the first solution (struct vkms_config) can be 
> > > easier to understand and to implement, for two reasons:
> > > - No need to distinguish between the "default" and the "configfs" devices 
> > >   in the VKMS "core". All is managed with only one struct vkms_config.
> > > - Most of the lifetime issue should be gone. The only thing to 
> > >   synchronize is passing this vkms_config from ConfigFS to VKMS.
> > 
> > I agree, this seems like the easiest solution.
> > 
> > > The drawback of this is that it can become difficult to do the "runtime" 
> > > configuration (today only hotplug, but I plan to add more complex stuff 
> > > like DP emulation, EDID selection, MST support...). Those configuration 
> > > must be done "at runtime" and will require a strong synchronization with 
> > > the vkms "core".
> > > 
> > > Maybe we can distinguish between the "creation" and the "runtime 
> > > configuration", in two different configFS directory? Once a device is 
> > > created, it is moved to the "enabled" directory and will have a different 
> > > set of attribute (connection status, current EDID...)
> > 
> > Once the device is enabled (i.e, `echo 1 > /config/vkms/my-device/enabled`),
> > would it make sense to use sysfs instead of another configfs directory?
> > The advantage is that with sysfs the kernel controls the lifetime of the
> > objects and I think it *might* simplify the code, but I'll need to write a
> > proof of concept to see if this works.
> Can indeed sysfs be used similar to ConfigFS? To me it sounds like sysfs is a
> view into a kernel objects, mostly for viewing and slight modifications
> but not manipulating, adding/removing, on the fly, various things. Sort
> of see it the other way around, device enabled with sysfs but
> configuration happens through ConfigFS. At least from a user-space pov.
> > 
> > > For the platform driver part, it seems logic to me to use a "real" 
> > > platform driver and a platform device for each pipeline, but I don't have 
> > > the experience to tell if this is a good idea or not.
> > 
> > I'm afraid I don't know which approach could work better. Trusting Sima and
> > Maíra on this one.
> > 
> > Jose
> > 
> > > [1]: https://lore.kernel.org/dri-devel/20240409-yuv-v6-0-de1c5728fd70@bootlin.com/
> > > 
> > > Thanks,
> > > Louis Chauvet
> > > 
> > > -- 
> > > Louis Chauvet, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com



