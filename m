Return-Path: <linux-kernel+bounces-222650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17259910551
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A031F21934
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7698E1AD4B2;
	Thu, 20 Jun 2024 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwy2WmpJ"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA881AD40B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888437; cv=none; b=cANFs2eE4JNMNR5QZLvKxfZd6FhICFR02622pqwt+OUh1kBWafipvIxpdiyhpA/MEq2cmYTFjjYF3OPQQtuSjlp2VUKSBCtFwkTYat1DTwyfOVWBKKdcCfpWBcFEiWdfFN0G6V1ZSfk/V76exEDNX9rHjsBX1NZi7/ENcia959s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888437; c=relaxed/simple;
	bh=wT1pyIEtuFagvq/G8IRdvb+rlps6hLADk+Hl9Zs9Ph4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C31iCbVmwKA7LDv/dTqW+FVlY/5CJFfegR/W0N9IH0ID3xTTF2vwRGiYEoyUvq7g8OU5vUWA+3IHpvVP75hDK4fSeGou1W3Pbix6jBqWDMp94/yN0YK5GIaCDIX9FgxRojmuheDOCj3YAjecqbSg0CaTBI2KdhDWxbUFywdWK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwy2WmpJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c1a4192d55so711121a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718888435; x=1719493235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo56YfkzAdoTyNp8vVJoVwGhrq9JVENLESkm+nuUbCs=;
        b=Kwy2WmpJ5O2e4LnQUben2zWjzdb+/DJAskEyMn87zFK2f9Q4Bz+WDzjqkWAdYA7HT3
         17baxOeVRlBTn11mK8/ljRXiA9Xvl7rRBr0PgYd+k1MM6n3nW2/E1Q4DZbDiPCx9VRXx
         zb7/hLlCyITOvz/AnnxNrtXHaGuD7/PidvZ1Zy/eJqCFWZf/jZq4EYGllYUeZ/IkewLg
         BciKvREElpbOEosu3s8W6UFhVSc8DkIs1isuEVlllY+YWiCderUJ0uppR3iNSWS/dCGF
         c8WqrgMovYGNn0uGkKLUCko/67RrusBF2poMM2pWW0/IaUFrBKPE75v9aZNIZoGUPQrr
         /v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888435; x=1719493235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo56YfkzAdoTyNp8vVJoVwGhrq9JVENLESkm+nuUbCs=;
        b=h3woc9wOWTvG0HaZwoRlgG8jE6YRWg3XgRdGKUjkukN4UO1WrdjU3Z0pHYBZNvkO1l
         XSjSy5hzF9gebBfCO7QFkuXU7r7lHJqLZ93Zv+5mB+QNIkUfgX2VSftJwlgi9GLfInpI
         23Mr0VVINDI2xXsyKTe7WqyFvaWQSylcrY+mzX3WKrv9vfoVsYchK1EnzQAidcq2GkDw
         LseP3ZFHtAkAlvu1omx1hkXRLgPNkVWv2kPE2+dkqoDBoOSjQwIRzLykjxZFdllh7oKj
         hu9xP1RhxBWbTX6qyWDslo6iiUKc6ZscxwkWOoI6MNNriwOacD9e49YYavL9oBZt0rWV
         aRFg==
X-Forwarded-Encrypted: i=1; AJvYcCVQeMcLynT+5Jq1kIVGbn4pNjA/PSMrbwA+wPJ7dkFY/BTDj74MRMZRUPtLTCzO8FjTeTJggGd/uBgJTy46CcIk79fksNyL3ivY+SkP
X-Gm-Message-State: AOJu0YzEUn3ARKbkfM/Y0/qYgbBLog6z0TS8UorsWWm73WHsnSsDHWdv
	etK5FBH+xWL8u1twUbVteAFTOdqSOTstoDwPW0Br9mx19SrHpoupUIhq+X13PPZVl/VXL6aq+1J
	6AEcpPpNcR42pzVTTsHlbzEME9F4=
X-Google-Smtp-Source: AGHT+IGIdcCe6buOTlAadQ7gua8XUNjpkK1EYJm9Gvkr0f8wJye9l9wm8XtUQH2rjUK609SCLx4/hleK+RT693usL0U=
X-Received: by 2002:a17:90b:3552:b0:2c3:11fa:41f with SMTP id
 98e67ed59e1d1-2c7b5daec84mr4671563a91.45.1718888435008; Thu, 20 Jun 2024
 06:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612222435.3188234-1-dianders@chromium.org>
 <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
 <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
 <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
 <CADnq5_M+H_h1Me_O3u=R3q52PgYcCwwY9Mr8_R1eX0G7HvBp2w@mail.gmail.com>
 <CAD=FV=X=9PV+zbmd2S-TBBxq+yQZ2D+-cCHjFX-gm-f+DyXXiQ@mail.gmail.com>
 <CADnq5_OXUKj=bfK0NOAhOzmhYCSnQXbxHbwLOaBQ6wFX033Wgw@mail.gmail.com>
 <CADnq5_O1EGj-_xx7LuiXSVY7MSmfS7_1-hqShFk6Deu1wsBwOA@mail.gmail.com> <20240620-puzzling-hopping-griffin-e43ba6@houat>
In-Reply-To: <20240620-puzzling-hopping-griffin-e43ba6@houat>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 09:00:23 -0400
Message-ID: <CADnq5_PwE0n39hPuEfasGLrwe+rzzzisaKfwz9a9bbpR+RDgqQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] drm/amdgpu: Call drm_atomic_helper_shutdown() at
 shutdown time
To: Maxime Ripard <mripard@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Candice Li <candice.li@amd.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shashank Sharma <shashank.sharma@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org, 
	chenxuebing <chenxb_99091@126.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 3:10=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi,
>
> On Wed, Jun 19, 2024 at 09:53:12AM GMT, Alex Deucher wrote:
> > On Wed, Jun 19, 2024 at 9:50=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Tue, Jun 18, 2024 at 7:53=E2=80=AFPM Doug Anderson <dianders@chrom=
ium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Jun 18, 2024 at 3:00=E2=80=AFPM Alex Deucher <alexdeucher@g=
mail.com> wrote:
> > > > >
> > > > > On Tue, Jun 18, 2024 at 5:40=E2=80=AFPM Doug Anderson <dianders@c=
hromium.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > >
> > > > > > On Mon, Jun 17, 2024 at 8:01=E2=80=AFAM Alex Deucher <alexdeuch=
er@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <dia=
nders@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Based on grepping through the source code this driver appea=
rs to be
> > > > > > > > missing a call to drm_atomic_helper_shutdown() at system sh=
utdown
> > > > > > > > time. Among other things, this means that if a panel is in =
use that it
> > > > > > > > won't be cleanly powered off at system shutdown time.
> > > > > > > >
> > > > > > > > The fact that we should call drm_atomic_helper_shutdown() i=
n the case
> > > > > > > > of OS shutdown/restart comes straight out of the kernel doc=
 "driver
> > > > > > > > instance overview" in drm_drv.c.
> > > > > > > >
> > > > > > > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > > > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > > > Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> > > > > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > > > > ---
> > > > > > > > This commit is only compile-time tested.
> > > > > > > >
> > > > > > > > ...and further, I'd say that this patch is more of a plea f=
or help
> > > > > > > > than a patch I think is actually right. I'm _fairly_ certai=
n that
> > > > > > > > drm/amdgpu needs this call at shutdown time but the logic i=
s a bit
> > > > > > > > hard for me to follow. I'd appreciate if anyone who actuall=
y knows
> > > > > > > > what this should look like could illuminate me, or perhaps =
even just
> > > > > > > > post a patch themselves!
> > > > > > >
> > > > > > > I'm not sure this patch makes sense or not.  The driver doesn=
't really
> > > > > > > do a formal tear down in its shutdown routine, it just quiesc=
es the
> > > > > > > hardware.  What are the actual requirements of the shutdown f=
unction?
> > > > > > > In the past when we did a full driver tear down in shutdown, =
it
> > > > > > > delayed the shutdown sequence and users complained.
> > > > > >
> > > > > > The "inspiration" for this patch is to handle panels properly.
> > > > > > Specifically, panels often have several power/enable signals go=
ing to
> > > > > > them and often have requirements that these signals are powered=
 off in
> > > > > > the proper order with the proper delays between them. While we =
can't
> > > > > > always do so when the system crashes / reboots in an uncontroll=
ed way,
> > > > > > panel manufacturers / HW Engineers get upset if we don't power =
things
> > > > > > off properly during an orderly shutdown/reboot. When panels are
> > > > > > powered off badly it can cause garbage on the screen and, so I'=
ve been
> > > > > > told, can even cause long term damage to the panels over time.
> > > > > >
> > > > > > In Linux, some panel drivers have tried to ensure a proper powe=
roff of
> > > > > > the panel by handling the shutdown() call themselves. However, =
this is
> > > > > > ugly and panel maintainers want panel drivers to stop doing it.=
 We
> > > > > > have removed the code doing this from most panels now [1]. Inst=
ead the
> > > > > > assumption is that the DRM modeset drivers should be calling
> > > > > > drm_atomic_helper_shutdown() which will make sure panels get an
> > > > > > orderly shutdown.
> > > > > >
> > > > > > For a lot more details, see the cover letter [2] which then con=
tains
> > > > > > links to even more discussions about the topic.
> > > > > >
> > > > > > [1] https://lore.kernel.org/r/20240605002401.2848541-1-dianders=
@chromium.org
> > > > > > [2] https://lore.kernel.org/r/20240612222435.3188234-1-dianders=
@chromium.org
> > > > >
> > > > > I don't think it's an issue.  We quiesce the hardware as if we we=
re
> > > > > about to suspend the system (e.g., S3).  For the display hardware=
 we
> > > > > call drm_atomic_helper_suspend() as part of that sequence.
> > > >
> > > > OK. It's no skin off my teeth and we can drop this patch if you're
> > > > convinced it's not needed. From the point of view of someone who ha=
s
> > > > no experience with this driver it seems weird to me that it would u=
se
> > > > drm_atomic_helper_suspend() at shutdown time instead of the documen=
ted
> > > > drm_atomic_helper_shutdown(), but if it works for everyone then I'm
> > > > not gonna complain.
> > >
> > > I think the problem is that it is not clear exactly what the
> > > expectations are around the PCI shutdown callback.  The documentation
> > > says:
> > >
> > > "Hook into reboot_notifier_list (kernel/sys.c). Intended to stop any
> > > idling DMA operations. Useful for enabling wake-on-lan (NIC) or
> > > changing the power state of a device before reboot. e.g.
> > > drivers/net/e100.c."
> >
> > Arguably, there is no requirement to even touch the display hardware
> > at all.  In theory you could just leave the display hardware as is in
> > the current state.  The system will either be rebooting or powering
> > down anyway.
>
> I think it mostly boils down to a cultural mismatch :)
>
> Doug works on panel for ARM systems, where devices need (and need to
> handle) much more resources than what's typical on a system with an AMD
> GPU.
>
> So, for the kind of hardware Doug usually deals with, we definitely need
> the shutdown hook to make sure the regulators, GPIOs, etc. supplying the
> panel are properly shutdown.
>
> And panels usually tied to AMD GPUs probably don't need any of that.

Makes sense.  I think drm_atomic_helper_suspend() is a viable
alternative if drivers want to leverage their existing suspend code.
I could write up a doc patch unless there is reason to prefer the
shutdown variant.

Alex

