Return-Path: <linux-kernel+bounces-368616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECB59A1262
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CD628616F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D25C212EF9;
	Wed, 16 Oct 2024 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="es/QFLE+"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310311711
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106352; cv=none; b=iCWU8ReRb0S/yv6bQfYmoiTjeiS8aItAHFwgY5SGfd55RG+FniiHtRERf0UduL3Ywks3JQzHtdEARhTvoz0zUbuuumCTUDTLYsCXkIdfXxvb5zWLAMvgKwncA1Plj5JWt1vFacaOhuHePga3KkM4VdzSi2IbIs6ExbXq8PHTdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106352; c=relaxed/simple;
	bh=VokmqUex0gxEbClNcfMI1HcrZ3mz/pDmExmI02fcrHU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvGs6XM2MyEym+zIKBwF4/pY+GOo4BsnI5yjlCrYWLcvXhOxwo3Ccx/K3ekrjqNJkbaAM1qT46t7oficR/yq2Ghbra8ugXPqWOuKQ/E3aNDJ2EzLTTzuCEu9MkYuCYgTXCyjJfDy9AQxlIxYAkHsXHlT7ejMzx+6ASrSpupwXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=es/QFLE+; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bylu2pig5vgtbgkyzos4fvvlim.protonmail; t=1729106348; x=1729365548;
	bh=VokmqUex0gxEbClNcfMI1HcrZ3mz/pDmExmI02fcrHU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=es/QFLE+trj1jXjWwLbJDsxsgI6ZpXekFOwUB1GMPjFzmxT/lMlj5WU5LusWoHXSO
	 a4e1S8jOD+75MoYRIC4FnwAc/TL/K72JOgBs1DhuH+LO7uDKTRHjCb1XWDWOzvxnSy
	 V4pARN5UhVZjSQy+3HEVoyr22Kh8i5gEmLohrBQekUv6jVnOajDkY0o1KDIdfehT04
	 AjwkY16weo6/bzFDXceDOtu2A+Gx9zDvou/+hFrg5gPq8TRdSTw+7JdX1PpZPBvzDG
	 bAGQjHey8YX0i8uEquxoRlM1I/ATn3R8Q7ZblplwlKCN96NvPrifWeiOjVNAjvJbA3
	 2hG6WQIa2FNdw==
Date: Wed, 16 Oct 2024 19:19:05 +0000
To: Daniel Stone <daniel@fooishbar.org>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: Andy Yan <andyshrk@163.com>, hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re: Re:Re:[PATCH v5] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <kYKfHO8oonY1wP8ZvanmTnvgjGfw0uek8cmMIV99Bc6zO3EE32B2LKaypAphAxVJKx2I-Lnd3CzvyTRVAaM4xhj75z7dOzlp7xPMlFQKRN0=@proton.me>
In-Reply-To: <CAPj87rOmPyat12S4WUixiUBAsuAEEbyNX5VY2JS+wn5a1jux0A@mail.gmail.com>
References: <20241014222022.571819-4-pZ010001011111@proton.me> <7b45f190.452f.1928e41b746.Coremail.andyshrk@163.com> <o_Cyz_ARcHj4zNlovv75MBwslIRhn3YWlscoNrlpLVobh7eWIMEQR5bNv0yhHx2KEx_gbYi_gH-8Y-CdvRZs9lZscz3-lhAbM50GXUdtSKY=@proton.me> <30940542.b36d.19290215124.Coremail.andyshrk@163.com> <1974DYrs9gLrQrZ5VwCglFgKDDK686iyqnS_g6uPB-s9wZ_4CqfZXPjmYWihLgrkRu7ptNjpkFeqB0uTt73RFId6cL8FowQ8LFltPmaKCoI=@proton.me> <1ae9f15d.e52.19292e05e73.Coremail.andyshrk@163.com> <CAPj87rOmPyat12S4WUixiUBAsuAEEbyNX5VY2JS+wn5a1jux0A@mail.gmail.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: e2497491b4b02a9caaaac23dabf6ca08f7b82d0a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wednesday, October 16th, 2024 at 2:27 PM, Daniel Stone <daniel@fooishbar=
.org> wrote:

> Hi all,
>
> On Wed, 16 Oct 2024 at 02:11, Andy Yan andyshrk@163.com wrote:
>
> > At 2024-10-16 04:13:40, "Piotr Zalewski" pZ010001011111@proton.me wrote=
:
> >
> > > Ok I get it now. Is such rework correct? - when gamma LUT for rk356x =
is
> > > being set, instead of disabling the LUT before the gamma LUT write fo=
r the
> > > current CRTC's video port, active video port is selected. Selection i=
s
> > > based on if DSP LUT EN bit is set for particular video port. eg:
> >
> > If the userspace want to set gamma for CRTCx, then that is indeed where=
 they want to set the
> > gamma on=E3=80=82The driver silently sets the gamma on another CRTC, wh=
ich is not what the user wants.
> >
> > I think there are two options=EF=BC=9A
> > =EF=BC=881=EF=BC=89return a error if gamma is enable on other CRTC=
=EF=BC=8C this is what we done in our BSP code[1]
> > (2) disable the dsp_lut on privious CRTC, then switch to the current CR=
TC which userspace wants.
>
>
> 1 is the only solution that can work. Silently changing the colour
> properties of a separate CRTC is not OK, since this can lead to
> displaying incorrect content.

Ok right kernel keeps track of the state and sees gamma as enabled even if=
=20
dsp lut en bit was cleared.

Would it be better to check if gamma is already enabled on another CRTC in=
=20
atomic_check rather than atomic_begin/atomic_flush (and silently fail) like
in[1]?

[1] https://github.com/armbian/linux-rockchip/blob/rk3576-6.1-dev-2024_04_1=
9/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c#L3666

Best regards, Piotr Zalewski

