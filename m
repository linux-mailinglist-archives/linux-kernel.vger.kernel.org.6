Return-Path: <linux-kernel+bounces-423295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CFA9DA57E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97FEEB23757
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812C194C75;
	Wed, 27 Nov 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aih+0fXK"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50841194A7C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702464; cv=none; b=NiN5jxP0a3D1okdQ5mGNoEDGAPNWM9PbAED5MBwpz4wugHPG+ptAwBco7gNwqQB+qb0zrx/S06ja8nURu9Lut9nvbMCgiSwN4Wmyf044CN1mcTLacuqGRtU93SNz6txaTsFGYRYbREHIxpeo9XMPIrAapTYWZxmNlPqU67ccegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702464; c=relaxed/simple;
	bh=3x2rkS/9xSuYjNsgmEI8IWJUxHytL8VB42+YYQIZlIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr6hCf4PlFyZwfxMsx58DbeyNKKveV+5mSqYRq9Kta4G79jhZY141cNSmRDGfPhZEvw7udjAvoADDXjLXj1pUxs4uCRC8pI60NeDmg+yLQazDIAB2oj3XNzyRfjaK/N2s5K5Uoe0GygidAyUQ3olXOxHwDvykjpLIErdzDXJG6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aih+0fXK; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffbfee94d7so31971791fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732702460; x=1733307260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8SF/u3Kdyele1Gw5pa2FdRL14/nwlUm+VEkXrZYjykA=;
        b=aih+0fXK6xuZfUVmhw344I4JUJdJyf1rs1+nLYFRfbTfGXNFZQzMYVJFfCsbLyN3cD
         qNpynK0w5GzJ/MOQpHSKJJS4Y1mbADC7QxuiZMve+hcsOvuCBqLGgl5RvqREoEgy2+9z
         t2ZSZVLhF1pj89xtPwY+FUfTxr67iSbuoCEmCuVKk8OTB3d7Px+fWD8pKFcRiLWXsu1F
         ViVpCKYQCIkK7/nvSExE4bnFFwvIiWLGviP4gBUIqc0yw9yMva7hwXqx71XrknXuK/2p
         Ly9zdCHNQT+tkc+1qqAlLZRM9XPnm6w8W1jJYiVarNrw55hglEaSVPGEekrELtMQnzbw
         iyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732702460; x=1733307260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SF/u3Kdyele1Gw5pa2FdRL14/nwlUm+VEkXrZYjykA=;
        b=g1BWQOYG9snllikeXN4GXFpWAv6pGDPhhcLhoDXsx0vbdB2Tq8T4MxG0DuhbSQ39to
         w5poPUSpIRfTxbGMVKFuVYMGE0OOrABqwHHhmOn/erj5vN2FTkSpRF9cU9GRyTDWdHfw
         GmsgqbNsW9QI5YmEunfVGrPvrN4J+4c8kDwm6/bE5mEBYEOWAXK+l0SKbwKaP6rZTqln
         lVfrqbu2e4dVH9eYcwhNejFfHYh23uMo5qt1vIa+ghPjaPAP4a1E1ctDs6Ygzd5SNuG1
         bUPAuZgent3GzHRRSJYGhq8odMFrHPwM9hIR9Fe8wVkY9GcFhIql+1vdJkuGLpScdeQ6
         kEsw==
X-Forwarded-Encrypted: i=1; AJvYcCVAPh5F4NlNJnjYB+iFWcJasUEZkbQjdVFkL94lsFGUwtmKn2B8yMLynWV/WGJvfbG0duUCv/WGJ/PRtJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbjkphtfTdSzKpIio32vOXRM+jLGndT0KaP4rAxS464iSXpvV
	BqGyrOuSJy+EJuxFS8scfWU0+sSar5s0jxqGH5UC5wWKoxy9X1Iiat4gjdXMMeSSGxDMa0AgDrA
	b8Up+Sm12SrRxRoRMPfSp/ftfH8Y=
X-Gm-Gg: ASbGnctWs8i8PD9Iq8iDHGZ7onrf0jW6hjHBM/WtyQc3SDyxFlBBBWVJ5zFpBMXDPUG
	OoArm6j13739VGzME8dAsVrA7VMMAlGMUelbT27nf/1lIBegwbNDvkP/bJoMljg==
X-Google-Smtp-Source: AGHT+IF2dxXz0WdUwwnQcsA4C1kLqtW+yUfnZT3lt19jRglq/d6SHa1adRS19e4hggnZItqn3H03ch/9FbLUjE89uZ0=
X-Received: by 2002:a2e:a882:0:b0:2ff:7a4f:e770 with SMTP id
 38308e7fff4ca-2ffd60ac565mr7217171fa.31.1732702458697; Wed, 27 Nov 2024
 02:14:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119153941.8307-1-advaitdhamorikar@gmail.com>
 <CAJ7bepJ9vd8s4Yd+HpvGyZG3PE8oK8YPMFxtkPRO-W-t-Pe63Q@mail.gmail.com> <202411262248395277af39@mail.local>
In-Reply-To: <202411262248395277af39@mail.local>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Wed, 27 Nov 2024 15:44:07 +0530
Message-ID: <CAJ7bepKvu_mpJF47WtanZLDsbbx5+GhFkKSKmOdjgDoGQZe-uQ@mail.gmail.com>
Subject: Re: [PATCH-next] i3c: master: Fix potentially uninit variable
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Yes and no, I don't think -ENODEV is allowed here, see platform_uevent
> and i2c_device_uevent.

Thanks for the feedback. So if devinfo is uninitialized is it possible to
initialize the i3c modalias using OF and ACPI uevent_modalias?

My humble apologies if this is a trivial question but I'm not really familiar
with i3c and found the potential uninitialization using a static analyzer.

Thanks and regards,
Advait

On Wed, 27 Nov 2024 at 04:18, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 27/11/2024 01:26:08+0530, Advait Dhamorikar wrote:
> > Hello,
> >
> > I would really appreciate it if I could get some feedback on this patch,
> > I would like to know if this approach is the right way to proceed.
> >
>
> Yes and no, I don't think -ENODEV is allowed here, see platform_uevent
> and i2c_device_uevent.
>
>
> > Thanks and regards,
> > Advait
> >
> > On Tue, 19 Nov 2024 at 21:09, Advait Dhamorikar
> > <advaitdhamorikar@gmail.com> wrote:
> > >
> > > devinfo is uninitialized if the condition is not satisfied,
> > > add an else condition to prevent unexpected behaviour.
> > >
> > > The variable will contain an arbitrary value left from earlier
> > > computations in `i3c_device_uevent`.
> > >
> > > Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> > > ---
> > >  drivers/i3c/master.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > index 42310c9a00c2..7594d3793eb0 100644
> > > --- a/drivers/i3c/master.c
> > > +++ b/drivers/i3c/master.c
> > > @@ -284,6 +284,8 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
> > >
> > >         if (i3cdev->desc)
> > >                 devinfo = i3cdev->desc->info;
> > > +       else
> > > +               return -ENODEV;
> > >         manuf = I3C_PID_MANUF_ID(devinfo.pid);
> > >         part = I3C_PID_PART_ID(devinfo.pid);
> > >         ext = I3C_PID_EXTRA_INFO(devinfo.pid);
> > > --
> > > 2.34.1
> > >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

