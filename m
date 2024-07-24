Return-Path: <linux-kernel+bounces-261221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086593B453
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C53B23F65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EEA15B132;
	Wed, 24 Jul 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmGYGRM5"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D71D699
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836435; cv=none; b=jonLnbNPSjUWNUDB88sFs6fRBZc9RyG5tjMqvhRJzpSF6exYcWUYMrecsFMcGJClYNN/nH9siHW+JzEa6YtbrnL4fjh/SWhW0P+zwvaYn/+Oy710E1zPlTaeUp3gP2FgI+gTjDQr9JJ46v7aDFEl2unWzy9lZwylZV2/zTe8PaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836435; c=relaxed/simple;
	bh=lzIm185bnoucuun/35aeQA/+6rvPimlWkuHpsSjAD9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCTtOq/TJFiO8B7ExWoKGTZUSe49UK5VEWHJNJWA5FQESB1y0pWeDxk4dQdQkbiTWTPBgAqdiXAhkliw4o2iOHvcoRpyxZLQs5u4ZvIv4CBxHTIRl4DPgGmIA69Yfl9JqQXcdQtuOXN6NsH8zXrsIM8HQs9orHtwz5q9QW/g9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmGYGRM5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so2582759b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721836433; x=1722441233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wESv1LdQX+UtQLY9Z+JdLQpHYUmswcLuSV3X1wwd0A=;
        b=SmGYGRM5z5qCI9wZ0IXc1qQaW1/2llD+AI6G5Sjq8sl/y41ECn6aqRy0LkD2vmMdKp
         amCm9bk1J/vcAIlSkP9Fvn5qOiVSm0xbK/mCn/PP4AbFuIk+dgIFlZeQEsN+nVMf4qfJ
         wIYfc8aU1QsZoQ3bL1AMZ8HYoQKydXgog2LCf+GLoZ6bRw2aNGMM5CGz+vYmC6z3AUZr
         5mctYstseBMzYGHcoOsd7pnLzWxJQU6LBu5RRsBEbwjYfqUv0YBlR5rAp2yfRp1mwtNL
         gFqfhlETJhB+PYgGNc/9UpQCa/UqdYwxN2XjQK11rxkA4qlOHv1TvTX11WLnrBDODRuN
         5TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721836433; x=1722441233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wESv1LdQX+UtQLY9Z+JdLQpHYUmswcLuSV3X1wwd0A=;
        b=woSXkqNdDYFkU5GptIsz/YFyyaj5zGCRyTCDZTYY+z4v75a61t69Z3w0BL+15L/fgo
         1Rsp5koGTOOe6sSBXQpePERYmr6Km0UIXUoFN6mnf/77cV7czJz1VMJJXajjeGw6ovwK
         07oVLIXoMGbdvRNdz56k+976c0hNC2zccuPTIhyO8cr5avkOK/U3Aj8ZSVl+Gy2d0ie4
         9Vjlm55KyUGbjhQOoXWdMsvn1dlCkUuE6x0WELW6VLmshdvPLdLkxTMr0+QZWhHKj4HJ
         /QJX9lBgHLs4PDrs94PFl7F3iUIPcfnticbhfNzv5w1vs9y/kWFgZlUWxyxkCe4y75/o
         Rq4g==
X-Forwarded-Encrypted: i=1; AJvYcCWb7KFiAQaF0z+M/ZlI2328zooGH2Xg1s2l9wAzLKIu/FgZjjI3LMwBpgEE/beGpamBTHWPMu9CMzMrT4ZN7aWbe1fA1PsbNyEKfLfn
X-Gm-Message-State: AOJu0Yypqib/FImvob0SHmFpiHhfqxLWBqw4ScrCNl7DEjsEUAPj5HKn
	mYtqmsBJQG6QpGsD8GKQpb6iGNm31Ef9GWfQOlAsYnVP9zWX/e+brnMUDt6hESeD+4pHSU2PH5c
	ePKED7UHHuHKxEg8gFafI7gXO4zE=
X-Google-Smtp-Source: AGHT+IGkCbnRIx7IFaeYonMZlkeB3XKEqfo4q/s8I6cwOjZDrKDaz9jQ8V6eHBbJAVGM5xL2TR+fVuMexk4s3VvjGLo=
X-Received: by 2002:a05:6a20:4315:b0:1c3:a411:dc49 with SMTP id
 adf61e73a8af0-1c472c602e0mr292435637.51.1721836432973; Wed, 24 Jul 2024
 08:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
 <e61010e4-cb49-44d6-8f0d-044a193d29b2@redhat.com> <51f68b3b-dd21-44ef-8ec8-05bea5db6e55@t-8ch.de>
 <6db5abf9-cbdd-4ec0-b669-5df23de6c2ad@redhat.com> <87sevzf9pw.fsf@intel.com>
In-Reply-To: <87sevzf9pw.fsf@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jul 2024 11:53:41 -0400
Message-ID: <CADnq5_PC4u_nTKsB0dwr2UyXNu9+2EJd+KEYjBdpbBototkwOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm: backlight quirk infrastructure and lower
 minimum for Framework AMD 13
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Matt Hartley <matt.hartley@gmail.com>, 
	Kieran Levin <ktl@framework.net>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dustin Howett <dustin@howett.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 4:58=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Thu, 18 Jul 2024, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi Thomas,
> >
> > On 6/24/24 6:15 PM, Thomas Wei=C3=9Fschuh wrote:
> >> Hi Hans!
> >>
> >> thanks for your feedback!
> >>
> >> On 2024-06-24 11:11:40+0000, Hans de Goede wrote:
> >>> On 6/23/24 10:51 AM, Thomas Wei=C3=9Fschuh wrote:
> >>>> The value of "min_input_signal" returned from ATIF on a Framework AM=
D 13
> >>>> is "12". This leads to a fairly bright minimum display backlight.
> >>>>
> >>>> Add a generic quirk infrastructure for backlight configuration to
> >>>> override the settings provided by the firmware.
> >>>> Also add amdgpu as a user of that infrastructure and a quirk for the
> >>>> Framework 13 matte panel.
> >>>> Most likely this will also work for the glossy panel, but I can't te=
st
> >>>> that.
> >>>>
> >>>> One solution would be a fixed firmware version, but given that the
> >>>> problem exists since the release of the hardware, it has been known =
for
> >>>> a month that the hardware can go lower and there was no acknowledgme=
nt
> >>>> from Framework in any way, I'd like to explore this alternative
> >>>> way forward.
> >>>
> >>> There are many panels where the brightness can go lower then the adve=
rtised
> >>> minimum brightness by the firmware (e.g. VBT for i915). For most user=
s
> >>> the minimum brightness is fine, especially since going lower often ma=
y lead
> >>> to an unreadable screen when indoors (not in the full sun) during day=
light
> >>> hours. And some users get confused by the unreadable screen and find =
it
> >>> hard to recover things from this state.
> >>
> >> There are a fair amount of complaints on the Framework forums about th=
is.
> >> And that specific panel is actually readable even at 0% PWM.
> >
> > If a lot of Framework users are complaining about this, then maybe Fram=
ework
> > should fix their VBT in a BIOS update ?  That seems like a better solut=
ion
> > then quirking this in the kernel.
> >
> >>
> >>> So IMHO we should not be overriding the minimum brightness from the f=
irmware
> >>> using quirks because:
> >>>
> >>> a) This is going to be an endless game of whack-a-mole
> >>
> >> Indeed, but IMO it is better to maintain the list in the kernel than
> >> forcing all users to resort to random forum advise and fiddle with
> >> lowlevel system configuration.
> >
> > One of the problem is that what is an acceptable minimum brightness
> > value is subjective. One person's "still too bright" is another
> > person's "barely readable"
>
> Side note, IIRC the minimum brightness in VBT was not originally about
> subjective minimums, but rather to avoid electrical issues that 0% PWM
> caused in some board designs.

It's the same on AMD.  There was undesirable behavior on some panels
if the level dropped below a certain threshold.

Alex

>
> BR,
> Jani.
>
>
> >
> >>> b) The new value may be too low for certain users / use-cases
> >>
> >> The various userspace wrappers already are applying a safety
> >> threshold to not go to "0".
> >> At least gnome-settings-daemon and brightnessctl do not go below 1% of
> >> brightness_max. They already have to deal with panels that can go
> >> completely dark.
> >
> > Right, something which was added because the minimum brightness value
> > on VBTs often is broken. Either it is missing or (subjectively) it is
> > too high.
> >
> >
> >>> With that said I realize that there are also many users who want to h=
ave
> >>> a lower minimum brightness value for use in the evening, since they f=
ind
> >>> the available minimum value still too bright. I know some people want=
 this
> >>> for e.g. various ThinkPad models too.
> >>
> >> From my experience with ThinkPads, the default brightness range there
> >> was fine for me. But on the Framework 13 AMD it is not.
> >>
> >>> So rather then quirking this, with the above mentioned disadvantages =
I believe
> >>> that it would be better to extend the existing video=3DeDP-1:.... ker=
nel
> >>> commandline parsing to allow overriding the minimum brightness in a d=
river
> >>> agnostic way.
> >>
> >> I'm not a fan. It seems much too complicated for most users.
> >
> > Wanting lower minimum brightness really is mostly a power-user thing
> > and what is the right value is somewhat subjective and this is an often
> > heard complained. I really believe that the kernel should NOT get in
> > the business of adding quirks for this. OTOH given that this is an ofte=
n
> > heard complaint having some generic mechanism to override the VBT value
> > would be good to have.
> >
> > As for this being too complicated, I fully agree that ideally things
> > should just work 100% OOTB, which is why I believe that a firmware fix
> > from Framework would be good. But when things do not work 100% adding
> > a kernel cmdline option is something which is regularly asked from user=
s /
> > found in support questions on fora so I don't think this is overly
> > complicated. I agree it is not ideal but IMHO it is workable.
> >
> > E.g. on Fedora it would simply be a question of users having to run:
> >
> > sudo grubby --update-kernel=3DALL --args=3D"video=3DeDP-1:min-brightnes=
s=3D1"
> >
> > will add the passed in argument to all currently installed (and
> > future) kernels.
> >
> >> Some more background to the Framework 13 AMD case:
> >> The same panel on the Intel variant already goes darker.
> >> The last responses we got from Framework didn't indicate that the high
> >> minimum brightness was intentional [0], [1].
> >> Coincidentally the "12" returned from ATIF matches
> >> AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, so maybe the firmware is just not set
> >> up completely.
> >
> > Right, so I think this should be investigated closer and then get
> > framework to issue a BIOS fix, not add a quirk mechanism to the kernel.
> >
> > IIRC the amdgpu driver will use AMDGPU_DM_DEFAULT_MIN_BACKLIGHT when
> > that setting is 0 in the VBT.
> >
> >>
> >>> The minimum brightness override set this way will still need hooking =
up
> >>> in each driver separately but by using the video=3DeDP-1:... mechanis=
m
> >>> we can document how to do this in driver independent manner. since
> >>> I know there have been multiple requests for something like this in
> >>> the past I believe that having a single uniform way for users to do t=
his
> >>> will be good.
> >>>
> >>> Alternatively we could have each driver have a driver specific module=
-
> >>> parameter for this. Either way I think we need some way for users to
> >>> override this as a config/setting tweak rather then use quirks for th=
is.
> >>
> >> This also seems much too complicated for normal users.
> >
> > I agree that having a uniform way is better then having per driver
> > module options.
> >
> > Regards,
> >
> > Hans
> >
>
> --
> Jani Nikula, Intel

