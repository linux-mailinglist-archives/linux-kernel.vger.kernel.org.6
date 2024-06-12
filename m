Return-Path: <linux-kernel+bounces-211578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE969053F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD69B287750
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026A817CA1D;
	Wed, 12 Jun 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdxnY/DA"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E217083D;
	Wed, 12 Jun 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199603; cv=none; b=Gy/80djEoTzwljEGX7J4N1GUWo07BJYdedYx2xhgbatLeZqUjLBks7bKhecrBFEr3g8rQLM2QH4mOul3BPwnzUGS3jVchLreF1M1UqtwzWID6P2d4T46ho9oZUsHLOFuCZ2hil2dr1L2u6g6BqsPOQ7e2Z/ACj4xPCcdCRXTpu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199603; c=relaxed/simple;
	bh=qofywMV5/uv8Sye/afC+Jj1O5QoX0nVKMe+D3Ox+mH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2K2eDde9cIAqDKfDZALnhDA5dQELar6Wf30+wjkIpwkiuzdsSkDqh7dvav640FESXxqLQuPjgKCJa16kaJGHde3X0S7YZpo/wnYHBYYVxDzvMfE4yn6vmusTrJDMGaUke2AygUtZvkTR5vVxcj0fr8LCCpIDIDxUI9QPa9Q56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdxnY/DA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so316006466b.2;
        Wed, 12 Jun 2024 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718199600; x=1718804400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxSRp9AgxyNNYPtlrdSJYTaRP0/nzbJTU1dqjCUg+7Y=;
        b=HdxnY/DA+J/Vqk6R4tj61q6ThNXffWnEf3Hvzm0h+7DhMqI/Peuot4JUxHUbovNAXE
         Bqpnz+icPHYUJExrNjhZgumswyx3JyA1O2RfGGL5wh6QFgFjex89TvKly9uJ+cd/hqRu
         /bc951X3gyl/r7BC9+wLhfnUK1TF5/SLJqd7uZtCyTey0j6f+lh7ij6IUYOIUdxvQVXd
         P9UK+vfBi37VjnAmMLE80tgIVM11QkURjSuHDLBG9LMmxSkrHJcfdnoJAFjpl1gzc69K
         q8p325grvVhLSlGqbOHglgjhTdpdETOz9eJe14vVa3/o40LltZZO4Mb7Ec8f8tStG9Cs
         oYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199600; x=1718804400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxSRp9AgxyNNYPtlrdSJYTaRP0/nzbJTU1dqjCUg+7Y=;
        b=OVsqjhdzXDCdKdY5x+J8m496BSsPWKi7Jm+zuh+PfxQvAMfrCRMbvv/2aB0Y4FG73N
         lm4kw7cGMv5AfwUjw6LUltDr+eLJFYqDDn/gReDts8dEuTxjz3Og5U/g9Y3i+7mtNp3Q
         sRz2YuaNXrK4cKsCm+eyhTaGM3tSo3bp5MJ4D4vo/M3XTW4SFMdrYKVcVhD2u6ekZ83j
         NMB3hRP0hivNi4U/PMUEqiJyURzZ8n84JjoBcqan5iFd0BMtbxrpgW34FsqWeJ7LjOW6
         USgod/wBa90L/qERg9qiXrfHBTJuMBvnK7ntN6l5w7ThwD4K5bIQ77v3uoe6f9Z/rvAw
         hZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCUBWCaCeBELvc94RBXArtFCjKQ2bIUljCAX3zLVSMRlZJow8UnTPj3Cn03qydTa4QYBX2N4ngioUdm+wP79KiAXs6PioKfnMgsJq6wQjAH56TwuE8xgTfcQWrtDbqb52gjf4LdYRBLr
X-Gm-Message-State: AOJu0Ywzy+Ka6b1v9Y2T9t+AxfFxXNzosV798zSd2NdttQj8RtaUsiSF
	zDAaZsOcCjfLj8jFkrHT6sLeqAZv8CIxT1CRsLLXwlbU6iSkTrsQ3o0rJ5NW22te6Ry+27AhUyo
	hcGtZzkD6mcqFz5ESexcOfBbfKLZyvEoPanOcWLtk
X-Google-Smtp-Source: AGHT+IFORC6nwYwsG9+can2YBbSr+OG9w7Qx4gXZTETrgSbBDvaGHpxaOFL34klylO1pz109avkjnc/23nimkdxALkE=
X-Received: by 2002:a17:906:f582:b0:a6f:13f0:c8e9 with SMTP id
 a640c23a62f3a-a6f47d3b89cmr133183666b.53.1718199599430; Wed, 12 Jun 2024
 06:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240611142953.12057-1-joswang1221@gmail.com>
 <2024061219-reroute-strike-7230@gregkh> <CAMtoTm2tUDD-CCs4wqigx9ZNqHjWUCA_F080i+v55vubu8wtmQ@mail.gmail.com>
 <2024061254-oval-womb-a6c1@gregkh>
In-Reply-To: <2024061254-oval-womb-a6c1@gregkh>
From: joswang <joswang1221@gmail.com>
Date: Wed, 12 Jun 2024 21:39:47 +0800
Message-ID: <CAMtoTm0DtH=pi_20UibBjea1P5OkfKP3eY3G5s_Ta4pks0M3Lw@mail.gmail.com>
Subject: Re: [PATCH v3, 3/3] usb: dwc3: core: Workaround for CSR read timeout
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 8:56=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jun 12, 2024 at 08:47:31PM +0800, joswang wrote:
> > On Wed, Jun 12, 2024 at 3:58=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, Jun 11, 2024 at 10:29:53PM +0800, joswang wrote:
> > > > From: Jos Wang <joswang@lenovo.com>
> > > >
> > > > This is a workaround for STAR 4846132, which only affects
> > > > DWC_usb31 version2.00a operating in host mode.
> > > >
> > > > There is a problem in DWC_usb31 version 2.00a operating
> > > > in host mode that would cause a CSR read timeout When CSR
> > > > read coincides with RAM Clock Gating Entry. By disable
> > > > Clock Gating, sacrificing power consumption for normal
> > > > operation.
> > > >
> > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > > ---
> > > > v1 -> v2:
> > > > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch
> > > > v2 -> v3:
> > > > - code refactor
> > > > - modify comment, add STAR number, workaround applied in host mode
> > > > - modify commit message, add STAR number, workaround applied in hos=
t mode
> > > > - modify Author Jos Wang
> > > > ---
> > > >  drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
> > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > Where are patches 1/3 and 2/3 of this series?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Patches 1/3 and 2/3 are other cases. The maintainer is reviewing them
> > and has no accurate conclusion yet, so only patches 3/3 are submitted.
>
> How are we supposed to know this?  A patch series should be taken all at
> once, right?
>
> confused,
>
> greg k-h

I am very sorry, I misunderstood the patch series before. How should I
deal with this patch now? Should Patches 1/3 and 2/3 also be
submitted?

