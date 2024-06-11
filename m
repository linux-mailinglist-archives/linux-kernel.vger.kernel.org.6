Return-Path: <linux-kernel+bounces-210340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540890428D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A2EB21FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFD44F5F9;
	Tue, 11 Jun 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="r1AdC6K4"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB841C6D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127594; cv=none; b=S6ESWnIinD3pZmrKpA+wcAjc6Wbx6hPNwBcF+JgNH8XymabhxBQmgd4ZESmCJzUf3IgduGXo963Kw3CN24f0g44sY4ZaBE9Ob3YKBAhRhZ5Gd6PMFvhknrKEM9ANz92/jddxsaLqrK6gYtAbYEovaEQWC+l/9QXkaNGVLrKjH44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127594; c=relaxed/simple;
	bh=M+YEW6v90HYOunPyx/IlYlhLI0yXEPgyWnG6YGrfh14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAyAgCgV6I6j/OHbbFi7/DLJCDexcr2QJbIkU/pHbINCjqQDj5EJRIj7BmcllBSYdJP03Rr7U8ub8XEZfFDMrFOjspE5WX+yIBd71ci/+/XJwAIEQnYP/DRsm4Yn/TPve/zNR1nIGCax7FieVLhNKaXOfZldst2k3iLKoss94zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=r1AdC6K4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfaff6bf125so4370128276.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1718127591; x=1718732391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+YEW6v90HYOunPyx/IlYlhLI0yXEPgyWnG6YGrfh14=;
        b=r1AdC6K4XiwuWp+D2P5+JJfvx803s7FZyQX7rwY2sXXlr/HO4icJVDZdWNOK8rsnky
         gKI2tn/doGYrRMGrlbqab+wXUOSJd+QItqBLEd7ofMBq87dTMOU6yiNTxyzDE+r6h9Za
         /IpXIrFRrZ1GuXOG4sz0C2l59GVdJnyVkAXa2aAZpfzmzGHDmzF9dS3Ow3miqKFvBmmI
         OtZHoP9SPHO2DHeTq8pZOr/t2rPKKFzYZPKaO7GSz8TWMjTMchtimwZjDemOLDoG+WpZ
         hGOXfrnhOVJ57eZh89ApZnwEZdh6ob3hmjESKblODGYD50zmNr479wlycU5l1D2xbAJ3
         TpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718127591; x=1718732391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+YEW6v90HYOunPyx/IlYlhLI0yXEPgyWnG6YGrfh14=;
        b=RE/F83XSnsk4ZY3Ks6OF5AO4q7hEUsc8AuktPkSQTgFPYwCIH/cwW3Yo6IvJdQiGSy
         DXcwSICYQTleM9SokXquCm8T6fWPB8cmqt5SiMtcHvW0LcLvvE8CmfzziINVIG/S0iug
         nIZ967muxMt4j15e3azlDUPgN0+qc7Fz+Qo9PM2UAXMBxUastjqD8Rbi8kkenA6V6nyJ
         Yl1NyEiPYb6tSWKgsKMb/h1vdL1WeuVcUrt/sRiV/p7JUcai8gosZsdtcexnb0Ob3h+5
         DpE3OW5H9MoMujRcyCe96f7nLmpucOi77fJt1k9Gjj5IM1Vzjmnw4fjl/wQGSrHeGp56
         8ZhA==
X-Forwarded-Encrypted: i=1; AJvYcCVJZvn2LgVXnYtTR5wVcbxQbIVM/JrjWGj3toXePjRveeOuczamal3VarbGBb5pJjFxPrraNtG/tSI2wTA9TSVtKt/qq1mUVfIQVtKC
X-Gm-Message-State: AOJu0YyzLSgJKLZEjbvufc6V1w52kCCBwPoTkWLgnVpqHET9NlHKdv1o
	w6J3VhF9UesoPnWmstt52E0qaECSuIFtvJtadpXKCQIrTZoLBb0pWB1yJx0MCaZuPVjXV7SUfuq
	iCM6vuJkEFIAAtYt5w5Kj0z9Yr9+mcU5ops4xJA==
X-Google-Smtp-Source: AGHT+IHpvYwqV9BO3US0LJmfVBiXIJYyylZtaBYtv8R/58jOsl6ckUjdYf0HzAM/Skx/2BjUIGC5Og2SM/I+ruYFwRo=
X-Received: by 2002:a25:ab24:0:b0:dfa:ff7e:d410 with SMTP id
 3f1490d57ef6-dfaff7ed6f5mr11899278276.40.1718127591425; Tue, 11 Jun 2024
 10:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607-trimmer-pummel-b452ed15e103@spud> <20240607155704.GB1242@pendragon.ideasonboard.com>
 <CAPY8ntBNNOFR1nn05g4Y-SOv_tN0YJv9wygO=+S80-zA1oq7mg@mail.gmail.com>
 <20240607-celibacy-contend-c4a6be15804b@spud> <20240610-wolverine-hanky-37cc8c409958@wendy>
In-Reply-To: <20240610-wolverine-hanky-37cc8c409958@wendy>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 11 Jun 2024 18:39:35 +0100
Message-ID: <CAPY8ntA2f8D3d=7sXBcjGbOUYSw=Wa14yEd-=tmbJ5jJba+5Ug@mail.gmail.com>
Subject: Re: [PATCH v1] media: i2c: imx219: fix msr access command sequence
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Adam Ford <aford173@gmail.com>, 
	Andrey Konovalov <andrey.konovalov@linaro.org>, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Hi Conor

On Mon, 10 Jun 2024 at 08:32, Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Fri, Jun 07, 2024 at 06:55:01PM +0100, Conor Dooley wrote:
> > On Fri, Jun 07, 2024 at 06:29:49PM +0100, Dave Stevenson wrote:
> >
> > > > > ---
> > > > > I got the report of this third hand, I don't have a device and can't
> > > > > test this. I do wonder why the RPis get away with the sequence that
> > > > > seemingly doesn't work for the guy that reported this to me. My theory
> > > > > is either that they noticed the sequence was wrong while adding some
> > > > > other MSR access that is needed on this board while either cross
> > > > > checking the values written or because the other MSR accesses didn't
> > > > > take effect.
> > >
> > > Did the change fix it for the reporter? We're using the driver with no
> > > changes to the register settings cf mainline.
> > > Why it works on the Pi but not on a Microchip board is likely to be
> > > something quite subtle.
> >
> > I've asked, maybe it turns out to just be the first of my suggestions,
> > and they noticed it was not matching in passing.
>
> Apparently it was the latter & they did need to fix the sequence to be
> able to write the MSRs.

Fair enough.

> > They did introduce two
> > additional MSR accesses, both outside of the range documented in the
> > datasheets I could find online. They did have explanations for what those
> > undocumented MSRs did (0x5040 and 0x5041) in the mail I got, but given
> > it's third hand info to me, I dunno if we have the datasheet etc. I'll
> > try to find out some more next week.
>
> Seemingly what those two additional MSRs do is under NDA so I would have
> no way of justifying a patch to add them or the devicetree property
> required to know whether or not the additional MSR writes is needed. :)

NDAs can be a real pain sometimes.
I'm happy with the patch though, and it doesn't stop anything else
working on the Pi.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

