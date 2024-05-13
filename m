Return-Path: <linux-kernel+bounces-177323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8054B8C3CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56DEB20B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F4146D67;
	Mon, 13 May 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO5KWf3u"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CA146D51;
	Mon, 13 May 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587724; cv=none; b=fPlRBuuOxqu+oHQU2HAPh4WkSVhYuB/FRjykmD8HJPJ51CGxC3ZtVYNFcZLUE4XyXdcvvB8rQltMv809y6k3Uysrz0XAnRA2KOddGv/8TwK4hyDUtG16h7cUZo5uUc5kx4qEmDXbLwlb3LpxSoysmGAnQ/FQYYHSgBTbIsr4ZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587724; c=relaxed/simple;
	bh=e5Q+Z71JoPm4mw1PEubJIFTdVzb+FM23cc92+SA8twU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMcQyqWg9yJPDHTw+Vciq1TnJMstKAtOVfUoM+kVaRFUXY9PA7OxZijCMFT8bTDxNDkIfGrhYVHsLHWHdV5QFEx6FIeRNOrpw89oa/Nr/PWNO9j6FbV/Dve7NSSXsvZlU4lsxwMifke0IALY34tqQJ6ngcEE8h9aU22MspzUhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO5KWf3u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34f52fc2191so2158011f8f.1;
        Mon, 13 May 2024 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715587721; x=1716192521; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TYCqLLcC+r5dGNKTuLB1ayvdzDR51lh0R2uUNOwd6XA=;
        b=RO5KWf3uamtqrIZYlghAaSDSRJ6MAD1mMkKf8Bmsi4tFcJ1qHJXwegbfDWCz1tAcMA
         Aw7urTuaudFuL7/oQxB/eVKeSacvLMGszW0MtBvj41C33KeZw2SA/wKBORrecNUQjhOW
         Nr6M2hHhWsHW5KCH1RC16jDAcFfPq1WIBejfkuZyYCJQ5/4ZlD9QUQJEjBzI8PbOBOUi
         lL62UGqF/SbBCgAihXc4C8o9VmkfqJgI+GUQySdAQaWiX/Ct0SwNUNpowNhauTM/C0Dt
         omddBtuU5Z6atPlEHOJcsWEkY9HGt41SvWcwiGsEQ+grqg4iWPNg1lr9lvc9cJ3Lzmmo
         qBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715587721; x=1716192521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYCqLLcC+r5dGNKTuLB1ayvdzDR51lh0R2uUNOwd6XA=;
        b=WNGB+YTHjT91KRR73OeBgGNbz9EyhPDXqiyUyi7Ba/TcmHtsREdosOOBcUm5jXxqMr
         jpySC7xGivBGVNYOigL9XjMSDWOKQMCQeA7prgAkmOYubzoRFXCFQ5BmKrKcmXV96B/d
         OV0NdfW61SpPl6H/VNTU7L5skvmeiOwoyly+OfI7vq2er2fK5WIvN/8rRInkecvyl5H4
         kGPMGFA7hEeVgQZHJzUdSFE+3qCIAx+GpSm0H3lw5eOoBIJx5xixG/7n7mMIw1M8rAj0
         rUaQAktlr1I71tkphL9pwpsO9D8QFTnKb0soTwhbsqHnZpDrsCvEoxZQ39iGMxPAwYj9
         jIRg==
X-Forwarded-Encrypted: i=1; AJvYcCXaOp+Ick0MiVOqxRXKiprH3TkBHv80zmKUGMwxt+PDAqxBfwc118MpbfGDPJBrst9yeMI2TlnarwWk5/k2gfQAZ5Lt7pfznjkmJTC0b3mb68dwWHs0l+QFnzjVPMH6bUh2GERWPrW3
X-Gm-Message-State: AOJu0YxZylu3IhCEJWL66R6besUu3NDuntofwoYRguMj72tJQnCjecTE
	juFrvf7H+bkxWzoTYj2G+mZur1oyNAuaoBSJx0ULvW4xRJ3bWw3G
X-Google-Smtp-Source: AGHT+IEe9VUuVGU/HsjfLLb0XpK11DKQTSBN2cfjD0XUZz+WBxZjwSjj5+vzLMvgsNfHz+JGeZoNSw==
X-Received: by 2002:a5d:53c8:0:b0:34d:354:b9c1 with SMTP id ffacd0b85a97d-3504aa62bb7mr6086423f8f.57.1715587720508;
        Mon, 13 May 2024 01:08:40 -0700 (PDT)
Received: from fedora ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b895731sm10565071f8f.42.2024.05.13.01.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:08:40 -0700 (PDT)
Date: Mon, 13 May 2024 10:08:38 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Jim Shargo <jshargo@google.com>, daniel@ffwll.ch, brpol@chromium.org,
	corbet@lwn.net, dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com, hirono@chromium.org, jshargo@chromium.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, marius.vlad@collabora.com,
	mduggan@chromium.org, melissa.srw@gmail.com, mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com, tzimmermann@suse.de
Subject: Re: [PATCH v6 0/7] Adds support for ConfigFS to VKMS!
Message-ID: <ZkHKhtBmyS12i3fH@fedora>
References: <ZjCtgSaL50YrS-F-@phenom.ffwll.local>
 <20240508181744.7030-1-jose.exposito89@gmail.com>
 <CACmi3jF6Dp3PE8X=T5kTO2+eYJQi7jWACFdmp9jzKxUtcQphnQ@mail.gmail.com>
 <Zj5JIah0jWnIn2Ix@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zj5JIah0jWnIn2Ix@localhost.localdomain>

On Fri, May 10, 2024 at 06:19:45PM +0200, Louis Chauvet wrote:
> Le 09/05/24 - 18:18, Jim Shargo a écrit :
> > Sima--thanks SO MUCH for going through with everything leaving a
> > detailed review. I am excited to go through your feedback.
> > 
> > It makes me extremely happy to see these patches get people excited.
> > 
> > They've bounced between a few people, and I recently asked to take
> > them over again from the folks who were most recently looking at them
> > but haven't since had capacity to revisit them. I'd love to contribute
> > more but I am currently pretty swamped and I probably couldn't
> > realistically make too much headway before the middle of June.
> > 
> > José--if you've got capacity and interest, I'd love to see this work
> > get in! Thanks!! Please let me know your timeline and if you want to
> > split anything up or have any questions, I'd love to help if possible.
> > But most important to me is seeing the community benefit from the
> > feature.
> > 
> > And (in case it got lost in the shuffle of all these patches) the IGT
> > tests really make it much easier to develop this thing. Marius has
> > posted the most recent patches:
> > https://lore.kernel.org/igt-dev/?q=configfs
> > 
> > Thanks!
> > -- Jim
> > 
> > 
> > 
> > On Wed, May 8, 2024 at 2:17 PM José Expósito <jose.exposito89@gmail.com> wrote:
> > >
> > > Hi everyone,
> > >
> > > I wasn't aware of these patches, but I'm really glad they are getting
> > > some attention, thanks a lot for your review Sima.
> > >
> > > Given that it's been a while since the patches were emailed, I'm not
> > > sure if the original authors of the patches could implement your
> > > comments. If not, I can work on it. Please let me know.
> > >
> > > I'm working on a Mutter feature that'd greatly benefit from this uapi
> > > and I'm sure other compositors would find it useful.
> > >
> > > I'll start working on a new version in a few days if nobody else is
> > > already working on it.
> > >
> > > Best wishes,
> > > José Expósito
> 
> Hi all!
> 
> Very nice to see other people working on this subject. As the series 
> seemed inactive, I started two weeks ago to rebase it on top of [1]. I 
> also started some work to use drmm_* helpers instead of using lists in 
> vkms. I currently struggle with a deadlock during rmmod.
> 
> I need to clean my commits, but I can share a WIP version.

Hi Louis,

If you could share a RFC/WIP series it would be awesome!

Since you are already working on the kernel patches (and I guess IGT?),
I'll start working on a libdrm high level API to interact with VKMS from
user-space on top of your patches. I'll share a link as soon as I have a
draft PR.

> Maybe we can discuss a bit the comment from Daniel (split init between 
> default/configfs, use or not a real platform device...)
> 
> For the split, I think the first solution (struct vkms_config) can be 
> easier to understand and to implement, for two reasons:
> - No need to distinguish between the "default" and the "configfs" devices 
>   in the VKMS "core". All is managed with only one struct vkms_config.
> - Most of the lifetime issue should be gone. The only thing to 
>   synchronize is passing this vkms_config from ConfigFS to VKMS.

I agree, this seems like the easiest solution.

> The drawback of this is that it can become difficult to do the "runtime" 
> configuration (today only hotplug, but I plan to add more complex stuff 
> like DP emulation, EDID selection, MST support...). Those configuration 
> must be done "at runtime" and will require a strong synchronization with 
> the vkms "core".
> 
> Maybe we can distinguish between the "creation" and the "runtime 
> configuration", in two different configFS directory? Once a device is 
> created, it is moved to the "enabled" directory and will have a different 
> set of attribute (connection status, current EDID...)

Once the device is enabled (i.e, `echo 1 > /config/vkms/my-device/enabled`),
would it make sense to use sysfs instead of another configfs directory?
The advantage is that with sysfs the kernel controls the lifetime of the
objects and I think it *might* simplify the code, but I'll need to write a
proof of concept to see if this works.

> For the platform driver part, it seems logic to me to use a "real" 
> platform driver and a platform device for each pipeline, but I don't have 
> the experience to tell if this is a good idea or not.

I'm afraid I don't know which approach could work better. Trusting Sima and
Maíra on this one.

Jose

> [1]: https://lore.kernel.org/dri-devel/20240409-yuv-v6-0-de1c5728fd70@bootlin.com/
> 
> Thanks,
> Louis Chauvet
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

