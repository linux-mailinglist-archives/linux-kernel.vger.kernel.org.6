Return-Path: <linux-kernel+bounces-226961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63820914677
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63281F20EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93412131BDD;
	Mon, 24 Jun 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JO5CXx1L"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB6256E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221493; cv=none; b=blnwRPrigxFQLcGYE9mtsJU3QAoShsVx+r9mT2tRmOJpYS4DtI0wltxONHoNl2ocx4/0Ts8aWhawOoYHY/XVB9vZy9CE//JWz6g25i5z6/km6ZKVAWwK71Q9alxMXddbZ4p5Z/q+yl/B/nqFsoWAVHnKlduQ6fRIeWTXY/ZGk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221493; c=relaxed/simple;
	bh=5H3KKhZN5GJiSaTipCifosMbbea1dREGVfXXXegHfDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeABmE/I9gunKwglYP811y2Huqb0LhAsZ+vYZcaho3HVdm6G+1M8imytmMMhpG3XT8LQKfpGvcqn+WepjLwUAC0iT8I6RmQHXFVhJDea/uOLIxFwWctGISrY7kzW7wcqScVQOI+C4Yxi6WB9vuTvg6SocMxDulJEvgpCrDC13U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=JO5CXx1L; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3643e23012eso147300f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719221490; x=1719826290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhj3olTv6SUOY87PzY2paXqF2zIZ/sD/SzJjIPsH4iY=;
        b=JO5CXx1LiSIY7rhSQvJZS2KMzOHgsUCnjOkKtniZ+Izw1ExzHOD5K0hTiWoHiZNKqo
         FYhzQLkoNk21/aJO21A9yE3x+xNret/S1c7yDneBtlHUQCIlEArAwfmVfU+LDdqFfud5
         IlpEsfU8TbML1aLeX5iwh9DfuykfSA9EIL7Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221490; x=1719826290;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhj3olTv6SUOY87PzY2paXqF2zIZ/sD/SzJjIPsH4iY=;
        b=PilPQN7QfQ4A9fAb+qlDVISOc4QLWFjukkk9t15RXnYaAh+1BgPA4/Gz/zMrHN8G/O
         X+J0PPOndFigeS6HnH8CYAaDjvuwTs2k9eK8yKmwYTo53Kg4mYcyG2nq43hwEfNQifm1
         T2KFk1gwPiGtMwTymZkec1PqxQT+8kXl5x7wl/VAPdgaGS3qx44wwcH1H1Wx3lfeqS1m
         9o0gvS00qvajjj8wFYP0BHOQu+6lwWpeZ9SWPwuWSR4zOkkefmLIZkoJWW23IbsDeM2K
         VgxfGM907o6AxnwdCfhlUOsBrHxCsur74TdwFY5EXJOQ/g67B5gHKqdtT1AJHSRISkTe
         BgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwiXvlFb8Q6lp4gZViKVYRuC2I/tH2b1FBGD3EinRKNCTfG72NcK3zivU78V4lh/aHlVsMA83N4cndtcMd4c20CeB5r2CAShuYbPyV
X-Gm-Message-State: AOJu0YzwZpZmIP86xV502XmXlU4djyBYRoaygY34PwKr8lrV2wJQldne
	V4ntNuFogyfjiNzyvzkAS5p888d1sGPF8PxeOHqX7uwg3e5jQNliRytR74wzL1c=
X-Google-Smtp-Source: AGHT+IGBvhkvIomB/OFmxsSh5OVMla/tqc6JCmz9Gjt/KuAZcaeO00S9dc+jYrcpEBr0xQnh5CMXDw==
X-Received: by 2002:a5d:59aa:0:b0:366:e4b4:c055 with SMTP id ffacd0b85a97d-366e4b4c18fmr3641032f8f.7.1719221490289;
        Mon, 24 Jun 2024 02:31:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638e90cbesm9513907f8f.58.2024.06.24.02.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:31:29 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:31:27 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Oded Gabbay <ogabbay@kernel.org>, srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org,
	quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org,
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
Message-ID: <Znk87-xCx8f3fIUL@phenom.ffwll.local>
Mail-Followup-To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Oded Gabbay <ogabbay@kernel.org>, srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org,
	quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org,
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@gmail.com>
References: <20240612064731.25651-1-quic_ekangupt@quicinc.com>
 <zbpia232dh4ojfsvhcqxrp6cwfygaalu5cycdrs47pqmnrisvk@dq24nww26gkm>
 <z6g5ool5vomkudiroyaxh532rhlfu5x4i3l5xoqrsho2sxv4im@v5ghemjkpc3v>
 <CAA8EJprgCJKOnZo7Q31KZV3SA3NqWxcMmoUxuqnVF+8cQW5ucg@mail.gmail.com>
 <6f59552d-d7a3-5e05-3465-e707c1b7eaf2@quicinc.com>
 <ZnWhwJtTXS32UI9H@phenom.ffwll.local>
 <CAA8EJppRP0HdM6AfmL0uga2esDey12LVjuSn=wJZtV4Uz0CgZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppRP0HdM6AfmL0uga2esDey12LVjuSn=wJZtV4Uz0CgZg@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Fri, Jun 21, 2024 at 10:48:27PM +0300, Dmitry Baryshkov wrote:
> On Fri, 21 Jun 2024 at 18:52, Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Fri, Jun 21, 2024 at 09:40:09AM -0600, Jeffrey Hugo wrote:
> > > On 6/21/2024 5:19 AM, Dmitry Baryshkov wrote:
> > > > On Fri, 21 Jun 2024 at 09:19, Bjorn Andersson <andersson@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jun 12, 2024 at 09:28:39PM GMT, Dmitry Baryshkov wrote:
> > > > > > On Wed, Jun 12, 2024 at 12:17:28PM +0530, Ekansh Gupta wrote:
> > > > > > > Move fastrpc.c from misc/ to misc/fastrpc/. New C files are planned
> > > > > > > to be added for PD notifications and other missing features. Adding
> > > > > > > and maintaining new files from within fastrpc directory would be easy.
> > > > > > >
> > > > > > > Example of feature that is being planned to be introduced in a new C
> > > > > > > file:
> > > > > > > https://lore.kernel.org/all/20240606165939.12950-6-quic_ekangupt@quicinc.com/
> > > > > > >
> > > > > > > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > > > > > > ---
> > > > > > >   MAINTAINERS                          |  2 +-
> > > > > > >   drivers/misc/Kconfig                 | 13 +------------
> > > > > > >   drivers/misc/Makefile                |  2 +-
> > > > > > >   drivers/misc/fastrpc/Kconfig         | 16 ++++++++++++++++
> > > > > > >   drivers/misc/fastrpc/Makefile        |  2 ++
> > > > > > >   drivers/misc/{ => fastrpc}/fastrpc.c |  0
> > > > > > >   6 files changed, 21 insertions(+), 14 deletions(-)
> > > > > > >   create mode 100644 drivers/misc/fastrpc/Kconfig
> > > > > > >   create mode 100644 drivers/misc/fastrpc/Makefile
> > > > > > >   rename drivers/misc/{ => fastrpc}/fastrpc.c (100%)
> > > > > >
> > > > > > Please consider whether it makes sense to move to drivers/accel instead
> > > > > > (and possibly writing a better Kconfig entry, specifying that the driver
> > > > > > is to be used to offload execution to the DSP).
> > > > > >
> > > > >
> > > > > Wouldn't this come with the expectation of following the ABIs of
> > > > > drivers/accel and thereby breaking userspace?
> > > >
> > > > As I wrote earlier, that depends on the accel/ maintainers decision,
> > > > whether it's acceptable to have non-DRM_ACCEL code underneath.
> > > > But at least I'd try doing that on the grounds of keeping the code at
> > > > the proper place in the drivers/ tree, raising awareness of the
> > > > FastRPC, etc.
> > > > For example current fastrpc driver bypasses dri-devel reviews, while
> > > > if I remember correctly, at some point it was suggested that all
> > > > dma-buf-handling drivers should also notify the dri-devel ML.
> > > >
> > > > Also having the driver under drivers/accels makes it possible and
> > > > logical to  implement DRM_ACCEL uAPI at some point. In the ideal world
> > > > we should be able to declare existing FastRPC uAPI as legacy /
> > > > deprecated / backwards compatibility only and migrate to the
> > > > recommended uAPI approach, which is DRM_ACCEL.
> > > >
> > >
> > > I suspect Vetter/Airlie need to be involved in this.
> > >
> > > Its my understanding that accelerator drivers are able to reside in misc as
> > > long as there is no use of dma-buf.  Use of dma-buf means they need to be in
> > > drm/accel.
> > >
> > > There is precedent for moving a driver from misc to accel (HabanaLabs).
> > >
> > > Right now, I'm not aware that fastRPC meets the requirements for drm/accel.
> > > There is an open source userspace driver, but I'm not aware of an open
> > > source compiler.  From what I know of the architecture, it should be
> > > possible to utilize upstream LLVM to produce one.
> >
> > Yeah so fastrpc is one of the reasons why I've added a dma_buf regex match
> > to MAINTAINERS, and given this move has shown up here on dri-devel that
> > seems to work.
> >
> > But also, it slipped through, can't break uapi, so I just pretend it's not
> > really there :-)
> >
> > That aside, going forward it might make sense to look into drivers/accel,
> > and also going forward new dma_buf uapi will be reviewed to fairly
> > stringent standards. We're not going to impose the dri-devel userspace
> > rules on everyone, each subsystem tends to know what's best in their
> > ecosystem. But if something just ends up in misc so it can avoid the drm
> > or accel rules (and I think media is also pretty much on the same page
> > nowadays), then expect some serious heat ...
> 
> After discussing this on #dri-devel, I'm going to retract my
> suggestion of moving the driver to drivers/accel/, unless there is an
> actual interest in moving to drm_accel.h style of uAPI.
> 
> It should still be noted that there is a strong recommendation to
> start from scratch and to use DRM / accel uAPI, either using the
> existing driver for the legacy platforms or dropping it completely.
> When the fastrpc driver was started by Qualcomm engineers, there was
> no standard method of implementing the accel drivers. Since 1st of
> November 2022 we have drm_accel.h.

Yeah, if fastrpc just keeps growing the story will completely different.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

