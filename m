Return-Path: <linux-kernel+bounces-185104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746EB8CB095
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E72284C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF896142916;
	Tue, 21 May 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="lzN6s/ez"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221914290C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302486; cv=none; b=VoERJXEJeFtspe5Bj7d1quFEB5zfw/cXoCdayaXRyu/JBvddp8pQAYN6nGjZr1xLzTA7qXiU5uu9TNuk9RsM01TqdFLeixC4385ZO2C5ZEOno8+YGi1qxbsrM7ojv/ZBRXBTG7mgAtV8IsjfALI1l0DIEljdoKIVi4lSHcUMu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302486; c=relaxed/simple;
	bh=SB1OqSLlnsVqan3jm+OCZqKbhfuxNUZmUtXn7elwayA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Z+7zD1Su/ei9KMUfiu+smg5jUhPak3J22ocDvsOExd0+OJyRb2ypA535Qb2taxWFhT5yl0ZnufIRd+3Q3pBhgixLUz32vMmZRpU8od5sEeJSUWOx0T3kfOnfkK5YDFKNIiNGXrPcMFG4HAGu24XqO5TBK24oEQ3jLvDIcOS5xqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=lzN6s/ez; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-620390308e5so36924217b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1716302478; x=1716907278; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB1OqSLlnsVqan3jm+OCZqKbhfuxNUZmUtXn7elwayA=;
        b=lzN6s/ezF5BSxwJN6HwHkzw6Jt4/keHdsf8ESiicHvKipBsTOQDaaFkzL4mTWPaEio
         Q+k06vNqUomc3/OpFSDRvo/mwejZonNksOgO05HI8/slG7na/x18Fx7heCsrNdDhLmqA
         17xQjebci6nqE1xjHln0ZA1xJ2RexI0hHBXNSxwKqQErfvIEDGF+UA3r3Sor/ApuEGtS
         k1ngV2vUoUs1KIU5A8mc3pDI9IH8YU65NGcSAhTdnwhRICnRr73WjS+lzoyyb41vBNve
         RvII3pFATMkV+JMmk/egutBj4i0AQ0cmlvb7yHYdkBaqVUNO9s/nDRwsifDSxbG9XfA8
         CZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302478; x=1716907278;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB1OqSLlnsVqan3jm+OCZqKbhfuxNUZmUtXn7elwayA=;
        b=Ae+qeGVDAKwCpaqQPPfqHPuCMO8TP7VQG3ERR2Bv0bXIJH3eXfSpkO1ftyu30/yZcP
         KkIygLCDnuSMBKDPn/9H+49BUtGe6qC/an7hgfLct6no2YmMlUdHX9OkKgZfwWOEajTY
         QQO/v4JA3iaLXLcStxMCfwLUyqJd6h4QZov+++UqMBSKHH5qODGRFDM5v2OSOn12K50R
         o02PIoats52opXML07/BeC70cTMLxegyUealsSdXgUjnRR8IwscvOn9IS7NOZ3t6C6lt
         ceoTfHGV+1Njs1t+kgm3tTl5cjVi7dmCwLOI87PYTH9rmwqH0U9moyMzAXSiXlgVSDrf
         dJKw==
X-Forwarded-Encrypted: i=1; AJvYcCVFhAWxLU7vX+usKK1mw0iaibVf5TFvzy+bgloKhWXRn5qBhZN44QtuWmJ0xoRnk4XBQskCtQcEHECw7zLFFB/omPRxmLIHF5hI8EyD
X-Gm-Message-State: AOJu0Yx6oO1IgpHc9NjZgt/YtgO5Il8wM4/AYBNtXGrQ3P2okkwSx4R0
	CA0sEaU4ZjpT07jgo5U64oyMDG8FqD2Qm8UDs2KeOB+8BXZM6axhEG2+7NADi5fcTgHABDHrGPh
	EnKbv0w==
X-Google-Smtp-Source: AGHT+IH41UBvd/p2EZxgg6neo+B0A15GYVfMjxx9fHEfN4KhcnjkGVtU7OQ56gVJi+XgjVVdrkIQTQ==
X-Received: by 2002:a81:4e06:0:b0:61a:b7c8:ea05 with SMTP id 00721157ae682-622b001ec63mr331264077b3.35.1716302477515;
        Tue, 21 May 2024 07:41:17 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-627bc199c3bsm5614827b3.136.2024.05.21.07.41.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 07:41:17 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de60380c04aso3906137276.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:41:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1rZuOxno1h8TPHuPOQwYJdXpa7pslbD39kq9Xqx7ZXagIwBGZYEJ5XfbPBwHmMBsZ3OWIbUGEBC0jeKvcagDH/BenoDELUFbGSjJf
X-Received: by 2002:a25:ae45:0:b0:de6:1057:c85f with SMTP id
 3f1490d57ef6-dee4f2cf86emr30830551276.22.1716302476510; Tue, 21 May 2024
 07:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>
 <ZkyPoIXBeBUqFJ48@phenom.ffwll.local>
In-Reply-To: <ZkyPoIXBeBUqFJ48@phenom.ffwll.local>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 21 May 2024 16:41:05 +0200
X-Gmail-Original-Message-ID: <CAAObsKAJvgg54zBEP-e3PKPLVeX+akZFJudjutjzVVZOJa-41g@mail.gmail.com>
Message-ID: <CAAObsKAJvgg54zBEP-e3PKPLVeX+akZFJudjutjzVVZOJa-41g@mail.gmail.com>
Subject: Re: DRM Accel BoF at Linux Plumbers
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, open list <linux-kernel@vger.kernel.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Christian Gmeiner <christian.gmeiner@gmail.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Olof Johansson <olof@lixom.net>, 
	Lucas Stach <l.stach@pengutronix.de>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 2:12=E2=80=AFPM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> On Sat, May 18, 2024 at 10:46:01AM +0200, Tomeu Vizoso wrote:
> > Hi,
> >
> > I would like to use the chance at the next Plumbers to discuss the
> > present challenges related to ML accelerators in mainline.
> >
> > I'm myself more oriented towards edge-oriented deployments, and don't
> > know enough about how these accelerators are being used in the cloud
> > (and maybe desktop?) to tell if there is enough overlap to warrant a
> > common BoF.
> >
> > In any case, these are the topics I would like to discuss, some
> > probably more relevant to the edge than to the cloud or desktop:
> >
> > * What is stopping vendors from mainlining their drivers?
> >
> > * How could we make it easier for them?
> >
> > * Userspace API: how close are we from a common API that we can ask
> > userspace drivers to implement? What can be done to further this goal?
> >
> > * Automated testing: DRM CI can be used, but would be good to have a
> > common test suite to run there. This is probably dependent on a common
> > userspace API.
> >
> > * Other shared userspace infrastructure (compiler, execution,
> > synchronization, virtualization, ...)
> >
> > * Firmware-mediated IP: what should we do about it, if anything?
> >
> > * Any standing issues in DRM infra (GEM, gpu scheduler, DMABuf, etc)
> > that are hurting accel drivers?
> >
> > What do people think, should we have a drivers/accel-wide BoF at
> > Plumbers? If so, what other topics should we have in the agenda?
>
> Yeah sounds good, and I'll try to at least attend lpc this year since it'=
s
> rather close ... Might be good to explicitly ping teams of merged and
> in-flight drivers we have in accel already.

Sounds like a good idea to me. Will check if the people that sent the
previous aborted attempts are still interested in this.

Cheers,

Tomeu

> I think the topic list is at least a good starting point.
>
> Cheers, Sima
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

