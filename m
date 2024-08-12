Return-Path: <linux-kernel+bounces-282742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C50794E80E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC482280D41
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9254165EFF;
	Mon, 12 Aug 2024 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="21EVACra"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CDE165F01;
	Mon, 12 Aug 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448779; cv=none; b=LpCP6uYLyPW/SEtqajZuXuIUHjG7jviYMc81zt71PkU4yKkULYKe8TCpzg6AT5oCCipCpTw2Ao848/JeaUbMYuMUdTGEoXhcpNMs3NIDrzB4JwDI4uhL9JSQwmVMmSeMOKuMDUy1AUbfrZTbcuBh8d89xhUQkt0vor/NtGJAt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448779; c=relaxed/simple;
	bh=lovVcsparyQLzbiTdzR4lipqejlHTuMFMVwgsKqkt5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIsQ9YyPHQ0clzN/uGjhGw9L3XmZYdZwSezJLnD4nw5tIsZg+BgJbBdwpWvTgJAiaWKuwhfrqTIUlhBsguMsMjY3eOu1bZthP2CsjThtrywMO3as7mnxVjsqWpaudjkyt3vWyA4WeR05j+CGDXtZfmbNblUcDRSAQNQ8Pycepu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=21EVACra; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3F84D2E096CB;
	Mon, 12 Aug 2024 10:46:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1723448771;
	bh=lovVcsparyQLzbiTdzR4lipqejlHTuMFMVwgsKqkt5Y=;
	h=Received:From:Subject:To;
	b=21EVACrac3SEeEzj4QwkGsaX2Ecdv1I0hFCXXQ/S+GRNsXj5b82L1XD9+xTihbObQ
	 TviWro+QUg80VIvFDuv45ID09euibeodR5TPPoaaJ4K66CJ4Rxc5DPIQis0NO9e6Oz
	 mKG2AszFSQ7UrqwweTqdncs72Esl5jBWTS6ofLTw=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2f1a7faa4d5so28429301fa.3;
        Mon, 12 Aug 2024 00:46:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXrmMU3VlrD3ufjx6vqIITyx1bCSir3RIyVO1yqYOqts08+wOz12EcEaiGgRbPWFWJOKSe5AYj3MvjQb4f1NS9n6bxcyofuqhQlgTaXFz11PGFKa9rKfdbgTp/Q2ag+2ApLM0KmaLFTGoA=
X-Gm-Message-State: AOJu0YzWedufCR2vsu95q73hFAdGXJHyz0YS0zz2jnm7GTGe1SccGCa8
	IRlrmeqhx8p1zr3HmDnqmGlXx4kVTfbQ0+yPnaCZ6KLb4JK1m5lQLAY4dfno08VuTNsreUoP6/A
	xf95FFl6zJyfJP2vMabCt2vZJRyg=
X-Google-Smtp-Source: 
 AGHT+IEGDxiXteEGjvdwhj+3EgeaSWNthj1Z7EwZ38GB6EXFwI85n3rWFDPUxgr+Yz72Dce2gCSF873McunVeaAwslI=
X-Received: by 2002:a2e:6a02:0:b0:2ef:2b6e:f8c8 with SMTP id
 38308e7fff4ca-2f1a6cfa608mr57926631fa.42.1723448770481; Mon, 12 Aug 2024
 00:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812045325.47736-1-jlobue10@gmail.com>
 <87frra2ocp.wl-tiwai@suse.de>
In-Reply-To: <87frra2ocp.wl-tiwai@suse.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 12 Aug 2024 10:45:59 +0300
X-Gmail-Original-Message-ID: 
 <CAGwozwF7aR5UypRTe7tNFR+xOfQ=rhqkzYUgBcYH4_LvO9_zXQ@mail.gmail.com>
Message-ID: 
 <CAGwozwF7aR5UypRTe7tNFR+xOfQ=rhqkzYUgBcYH4_LvO9_zXQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: tas2781: Fix ROG ALLY X audio
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan LoBue <jlobue10@gmail.com>, perex@perex.cz, tiwai@suse.com,
	shenghao-ding@ti.com, kailang@realtek.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	derekjohn.clark@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
 Jan Drogehoff <sentrycraft123@gmail.com>,
	Richard Alvarez <alvarez.richard@gmail.com>,
	Miles Montierth <cyber_dopamine@intheblackmedia.com>, "Chen,
 Robin" <robinchen@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172344877178.29866.6774265500680865942@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi,
I have spoken with Shenghao and Robin Chen (who I CC) from Texas Instruments.

There is no such thing as TAS2XXX1EB3. For Ally X, there are two firmware files:
TAS2XXX1EB30 and TAS2XXX1EB31. Both are licensed with GPL
according to Shenghao.

Since the linux driver has no concept of the 0 and 1 suffix, I propose
we symlink the
0 one to TAS2XXX1EB3. If required, the driver can be augmented in the future
to either choose the 0 or 1 file.

According to Robin Chen about the difference with the files:
> They are IO, I/F settings, audio tuning and speaker protection. In current cause, you can ignore them.

The only source we know of right now is the Windows executable.

I would be happy to upload those files in linux-firmware later this week.

We validated that this patch meets all basic functionality, including no pops
during sleep and mic operation.

Some users reported lower volume than windows, but perhaps that is due to
Dolby integration in windows, or using the 0 firmware file instead of 1 and
in any case a minor issue.

Best,
Antheas

On Mon, 12 Aug 2024 at 10:26, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 12 Aug 2024 06:53:25 +0200,
> Jonathan LoBue wrote:
> >
> > This patch enables the TI TAS2781 amplifier SoC for the ASUS ROG ALLY X.
> > This is a design change from the original ASUS ROG ALLY, creating the need
> > for this patch. All other Realtek Codec settings seem to be re-used from
> > the original ROG ALLY design (on the ROG ALLY X). This patch maintains the
> > previous settings for the Realtek codec portion, but enables the I2C
> > binding for the TI TAS2781 amplifier (instead of the Cirrus CS35L41 amp
> > used on the original ASUS ROG ALLY).
> >
> > One other requirement must be met for audio to work on the ASUS ROG ALLY X.
> > A proper firmware file in the correct location with a proper symlink. We
> > had reached out to TI engineers and confirmed that the firmware found in
> > the Windows' driver package has a GPL license. Bazzite Github is hosting
> > this firmware file for now until proper linux-firmware upstreaming can
> > occur. https://github.com/ublue-os/bazzite
> >
> > This firmware file should be placed in
> > /usr/lib/firmware/ti/tas2781/TAS2XXX1EB3.bin with a symlink to it from
> > /usr/lib/firmware/TAS2XXX1EB3.bin
> >
> > Co-developed by: Kyle Gospodnetich <me@kylegospodneti.ch>
> > Signed-off-by: Kyle Gospodnetich <me@kylegospodneti.ch>
> > Co-developed by: Jan Drogehoff <sentrycraft123@gmail.com>
> > Signed-off-by: Jan Drogehoff <sentrycraft123@gmail.com>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > Tested-by: Richard Alvarez <alvarez.richard@gmail.com>
> > Tested-by: Miles Montierth <cyber_dopamine@intheblackmedia.com>
> > Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
>
> Applied to for-next branch.
>
> Meanwhile, could you ask TI guys to include the missing firmware files
> in linux-firmware git tree, too?
>
>
> thanks,
>
> Takashi

