Return-Path: <linux-kernel+bounces-174556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA178C10B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA693281CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8100B15B130;
	Thu,  9 May 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="fSGo6bwI"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C626AF2
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262800; cv=none; b=MuqkNsN83LHC5ZZO3FUk6DXemcqDQjQBYJs+SrvnBS9IHCSqS+qgBbu0A2mNTJ0b2z5/sZksOFn8nt1LyMDIkYVSTZzM3DOekjdRRNKo7R1QJeBmsKIwTCF2Tt3erpX0QMt60MhvMcSfNB86mUJIpzDSA371NP3yxb/0x5DPFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262800; c=relaxed/simple;
	bh=etRxQYnyTSJhlQA0xJ7YSbm6MYsu37W7y3Rk3gxAjcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aD7HfZBi79Ts7exQBJO2oB5gk7ynxmfH5wgJZ4edhLNy9AIDdGDCJ8RShTJhFcV8e1oMiSscm2eB+W+vg2MaSnvIM7N+qQ+t7ZmJZ2GxrtDaErFiu7fC/PLsnVKgW+uYzfZdJoUnz+chJV0HO6OVxpbU3uuU7hyE12HW9pdPgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=fSGo6bwI; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61ae4743d36so9449217b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1715262797; x=1715867597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdFa90PddlvioOWqeSbKbQrk9EgH4c2dEjX31dZlhXM=;
        b=fSGo6bwI5qrWkNULH9uznBEVseDWwHmvZGTnLXlFqzFZ1kEmYxdBTwalYU92Z55IUi
         PFQ+FhzeCoI3WVvBPPcl66gpxFdNomAb8flA57NodxI94MakvyoFoQxLqJ1aE+iTsFiF
         9MgMdSryUjE8GDIGm4BlFTU1RNud43dLq+ApaV5n2VcaE0xb+wGki09+42Ixw1/udpSd
         XQmTuRcKwscDdHiEoD63G6+MghwCZSKawqeOx7XoE9JnAQj02ry/mMEMz090NLPoWRMv
         b0X1sYl8+2JZx2v+ItAYbhwio5JXiXdash9xs1hudz/UzsWwBnqdC7DnV0w1QSgx0njG
         s3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715262797; x=1715867597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdFa90PddlvioOWqeSbKbQrk9EgH4c2dEjX31dZlhXM=;
        b=fC++hSHrsdkD/mlRM7JZE7EGMd0mZ34q7h7wTE9Dawhi5ZBaQZpfEmm2MjDxtv59Co
         X5pCBfdt7fQqRA98w/b+oj9HL0/pVchlXdP8G3LZ2J0nQxYpzw7bQfSmeqCYNwf6qrQC
         i13aG6PKK4TKvtSMX97F7Z6WW/W9JHCefXAr9nt6qt7wMZjhy4kjh2BqXk4YSm8MqbZq
         r7C25GyvK65FQEMy3S2hjO9CasGM3PQJ11M7p3Ys9p2cnYfQ2ll/oY429Y9hFFjZt6o3
         bYvxXMMIv/H+orTt4BkcEUqSmEnBR+a/U74XwNbQCuLSSaMgZO4wISnwJP4joOOHMTCc
         CzHQ==
X-Gm-Message-State: AOJu0YyHXAK+zPvfNwWmV3Sv+YppQ1QKVm6hWyEkKjm5RAQaO9t98tCI
	K+3x1vo0Xl46wJGz0JlQTtNCiL6ZHyupnBQI4ADwK1reWLUw9fACKNmu6wdTfgGGb06AS/vb0BH
	8KoE=
X-Google-Smtp-Source: AGHT+IESkDsfKcajkzFueSJQwxd6+wafjtDL7ZNO4xsMv8mkG1vYkjvh1CLjd8ni0qLkHvWQE3qGeA==
X-Received: by 2002:a25:b10f:0:b0:de5:4eef:542d with SMTP id 3f1490d57ef6-debb9e6f67emr6435112276.57.1715262796951;
        Thu, 09 May 2024 06:53:16 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e23480bsm2994657b3.24.2024.05.09.06.53.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 06:53:13 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61bee45d035so8701327b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 06:53:13 -0700 (PDT)
X-Received: by 2002:a25:1303:0:b0:de5:d1cd:b580 with SMTP id
 3f1490d57ef6-debb9db87famr5937174276.36.1715262792938; Thu, 09 May 2024
 06:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <8c55dba5-6308-685e-13da-e728197d8101@quicinc.com> <CAAObsKD4-k7Ya4Mi=vEPaC9DucbnVGDO5SaEUt-_o2_Bg+_FgA@mail.gmail.com>
In-Reply-To: <CAAObsKD4-k7Ya4Mi=vEPaC9DucbnVGDO5SaEUt-_o2_Bg+_FgA@mail.gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Thu, 9 May 2024 15:53:01 +0200
X-Gmail-Original-Message-ID: <CAAObsKCm49y-nUph=m9c+-eG37SaGKG93-1etwOQab4f5MXxOg@mail.gmail.com>
Message-ID: <CAAObsKCm49y-nUph=m9c+-eG37SaGKG93-1etwOQab4f5MXxOg@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oded, Dave,

Do you have an opinion on this?

Thanks,

Tomeu

On Fri, Apr 26, 2024 at 8:10=E2=80=AFAM Tomeu Vizoso <tomeu@tomeuvizoso.net=
> wrote:
>
> On Thu, Apr 25, 2024 at 8:59=E2=80=AFPM Jeffrey Hugo <quic_jhugo@quicinc.=
com> wrote:
> >
> > On 4/24/2024 12:37 AM, Tomeu Vizoso wrote:
> > > If we expose a render node for NPUs without rendering capabilities, t=
he
> > > userspace stack will offer it to compositors and applications for
> > > rendering, which of course won't work.
> > >
> > > Userspace is probably right in not questioning whether a render node
> > > might not be capable of supporting rendering, so change it in the ker=
nel
> > > instead by exposing a /dev/accel node.
> > >
> > > Before we bring the device up we don't know whether it is capable of
> > > rendering or not (depends on the features of its blocks), so first tr=
y
> > > to probe a rendering node, and if we find out that there is no render=
ing
> > > hardware, abort and retry with an accel node.
> > >
> > > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > > Cc: Oded Gabbay <ogabbay@kernel.org>
> >
> > I hope Oded chimes in as Accel maintainer.  I think Airlie/Vetter had
> > also previously mentioned they'd have opinions on what is Accel vs DRM.
> >
> > This gets a nack from me in its current state.  This is not a strong
> > nack, and I don't want to discourage you.  I think there is a path forw=
ard.
> >
> > The Accel subsystem documentation says that accel drivers will reside i=
n
> > drivers/accel/ but this does not.
>
> Indeed, there is that code organization aspect.
>
> > Also, the commit text for "accel: add dedicated minor for accelerator
> > devices" mentions -
> >
> > "for drivers that
> > declare they handle compute accelerator, using a new driver feature
> > flag called DRIVER_COMPUTE_ACCEL. It is important to note that this
> > driver feature is mutually exclusive with DRIVER_RENDER. Devices that
> > want to expose both graphics and compute device char files should be
> > handled by two drivers that are connected using the auxiliary bus
> > framework."
> >
> > I don't see any of that happening here (two drivers connected by aux
> > bus, one in drivers/accel).
>
> Well, the text refers to devices, not drivers. The case we are talking
> about is a driver that wants to sometimes expose an accel node, and
> sometimes a render node, depending on the hardware it is dealing with.
> So there would either be a device exposing a single render node, or a
> device exposing a single accel node.
>
> Though by using the auxiliary bus we could in theory solve the code
> organization problem mentioned above, I'm not quite seeing how to do
> this in a clean way. The driver in /drivers/gpu/drm would have to be a
> DRM driver that doesn't register a DRM device, but registers a device
> in the auxiliary bus for the driver in /drivers/accel to bind to? Or
> are you seeing some possibility that would fit better in the current
> DRM framework?
>
> > I think this is the first case we've had of a combo DRM/Accel usecase,
> > and so there isn't an existing example to refer you to on how to
> > structure things.  I think you are going to be the first example where
> > we figure all of this out.
>
> Yep, I will be grateful for any ideas on how to structure this.
>
> > On a more implementation note, ioctls for Accel devices should not be
> > marked DRM_RENDER_ALLOW.  Seems like your attempt to reuse as much of
> > the code as possible trips over this.
>
> Indeed, thanks.
>
> Cheers,
>
> Tomeu
>
> > -Jeff

