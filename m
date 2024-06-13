Return-Path: <linux-kernel+bounces-212521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BBD9062A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3490B21148
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE211304BA;
	Thu, 13 Jun 2024 03:28:41 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A1748E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249320; cv=none; b=Zh3yJOZynTz5eOVGnCs0tVZH54g3/pp9UYqd5VkULV0mElhoszHcdP5XHnnvemKmq95HPB+eWHHP+DSWDGat/Gsnktm8ZCfAEZ8MWjsUQ5Nk4jcufZ3fb3+gB0uBKTd1c5YYXRJOU815F++Eu/mrAF/TXHC5MnRAaJFEBmz2E5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249320; c=relaxed/simple;
	bh=n/PPgK5K0GotzQ/uPPwNsR7mfn1H3/0FJcaWtmGAKW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/By53c07NjQtFv6vgWCSvWbki2AbbEGQwWezT6vBat4qHGgWlcsv8DYuq9NunNNOpy5VLyZUVbdIJXbDbV5In18zAmVo+TGrMAP8rM5EhOAC1iWyc6WKY3nwM3pFViVwGOGoKSyjRHOiR/6sKhhAiRlquyYVVJdKsahb5dqZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4ed127d7c3dso150236e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718249318; x=1718854118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lhNM4y2L46tcjO0HaVOmUt/V/J9/oSem/zD16s3nQU=;
        b=li666nURRBlB7GwHtqEJ4oS/3uXF/nkXGVy+luWqR+QOj0L+KGRSx6x7lXHyVkIV/P
         RFaUmaR1RqRAHB+s706DnExpFhunDVBXizq+uCaAL/yZLITD8KjQ7m3+n0dVW7KmZyIQ
         zA9EIcU0BVPlhXxSBQ/Fhy71LXhPDPRutLyQ72ANpyezrv7X0qumlYUVyO3ZPVuoHnmT
         uZb4/QgzCp52EK1/en+FN3Y7DMDXgco1M95IZHkmf8K2EwCNYK/66YiHXYIAsXtTctUW
         FxlTxVRwWLrej6uIFLQDgkdcuRkNxcgkMWvCR5qJe1chFmfaA8EaZkdX8e2WNl+dTVga
         lQaw==
X-Forwarded-Encrypted: i=1; AJvYcCXIKSfUBEhHgFJFES3A7wvBNcq7h1FU5B3uVhiVGXFwvl3TQxzZ30HNwW2ZI7jDEMuz/01rgfooajf+DOHPhAdClLH5BpgRcC+rv9bQ
X-Gm-Message-State: AOJu0YxuZYc/XUs0+ussNIdCwdG4tMibLRMYMXrGjbtbqZAU224KdrMF
	xzP+txNF3Olk6SE+gNmKs7X+nKKuSOGNLRP/aA7zfDdJImbjwvy/MA+zLMHfAU3GAlTe4ZSvAPM
	+m8w7DHC/Fjvu0G4AmSAzuD47RTk=
X-Google-Smtp-Source: AGHT+IER2m9h4J2ED0nainxeDLQuifIsGahGrZNtZTVvEFTbBmBIYVADnQWf3zikEVERXmvOfozYTe94r+45kRqOZQg=
X-Received: by 2002:a05:6122:124e:b0:4da:ced8:b09a with SMTP id
 71dfb90a1353d-4ed07720855mr3363389e0c.0.1718249318101; Wed, 12 Jun 2024
 20:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612081216.1319089-1-zhai.he@nxp.com> <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
 <CAGsJ_4wsAh8C08PXutYZx9xV3rLRwLG-E6Mq-JgoSO5LA1ns=A@mail.gmail.com> <AS1PR04MB9559D82F720BC9A64077186AEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
In-Reply-To: <AS1PR04MB9559D82F720BC9A64077186AEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 13 Jun 2024 15:28:26 +1200
Message-ID: <CAGsJ_4zGRnGhn1zA1=H+TgqL8z59_Dy7x7YVKsKY0wRFt4tu9w@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
To: Zhai He <zhai.he@nxp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhipeng Wang <zhipeng.wang_1@nxp.com>, 
	Jindong Yue <jindong.yue@nxp.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 2:34=E2=80=AFPM Zhai He <zhai.he@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Barry Song <baohua@kernel.org>
> > Sent: Thursday, June 13, 2024 5:37 AM
> > To: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Zhai He <zhai.he@nxp.com>; sboyd@kernel.org; linux-mm@kvack.org;
> > linux-kernel@vger.kernel.org; stable@vger.kernel.org; Zhipeng Wang
> > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>; Christoph
> > Hellwig <hch@lst.de>
> > Subject: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
> > device-specified CMA memory is not enough.
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t this
> > email' button
> >
> >
> > On Thu, Jun 13, 2024 at 6:47=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org>
> > wrote:
> > >
> > > On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he" <zhai.he@nxp.com> wrote:
> > >
> > > > From: He Zhai <zhai.he@nxp.com>
> > >
> > > (cc Barry & Christoph)
> > >
> > > What was your reason for adding cc:stable to the email headers?  Does
> > > this address some serious problem?  If so, please fully describe that
> > > problem.
> > >
> > > > In the current code logic, if the device-specified CMA memory
> > > > allocation fails, memory will not be allocated from the default CMA=
 area.
> > > > This patch will use the default cma region when the device's
> > > > specified CMA is not enough.
> > > >
> > > > In addition, the log level of allocation failure is changed to debu=
g.
> > > > Because these logs will be printed when memory allocation from the
> > > > device specified CMA fails, but if the allocation fails, it will be
> > > > allocated from the default cma area. It can easily mislead develope=
rs'
> > > > judgment.
> >
> > I am not convinced that this patch is correct. If device-specific CMA i=
s too small,
> > why not increase it in the device tree? Conversely, if the default CMA =
size is too
> > large, why not reduce it via the cmdline?  CMA offers all kinds of flex=
ible
> > configuration options based on users=E2=80=99 needs.
> >
> > One significant benefit of device-specific CMA is that it helps decreas=
e
> > fragmentation in the common CMA pool. While many devices allocate memor=
y
> > from the same pool, they have different memory requirements in terms of=
 sizes
> > and alignments. Occasions of memory allocation and release can lead to
> > situations where the CMA pool has enough free space, yet someone fails =
to
> > obtain contiguous memory from it.
> >
> > This patch entirely negates the advantage we gain from device-specific =
CMA.
> > My point is that instead of modifying the core code, please consider co=
rrecting
> > your device tree or cmdline configurations.
> >
> Because we enabled secure heap to support widevine DRM, and secure heap r=
equires security configuration, its starting
> address cannot be specified arbitrarily, which causes the default CMA to =
be reduced. So we reduced the CMA, but in order
> to avoid the impact of reducing the CMA, we used a multi-segment CMA and =
gave one segment to the VPU.
>
> However, under our memory configuration, the device-specific CMA is not e=
nough to support the VPU decoding high-resolution code streams, so this pat=
ch is added so that the VPU can work properly.
> Thanks.

I don=E2=80=99t quite understand what you are saying. Why can=E2=80=99t you=
 increase
VPU=E2=80=99s CMA size?
It seems you mean that only in some corner cases do you need a large
CMA, but most
of the time, you don=E2=80=99t need it to be this big? So you have to "borr=
ow"
memory from the
default CMA. but why not move that portion from the default CMA to
your VPU=E2=80=99s CMA?

Thanks
Barry

