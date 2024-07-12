Return-Path: <linux-kernel+bounces-250160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B8192F4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65941F22CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C617C69;
	Fri, 12 Jul 2024 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX3CqWv2"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB218EA2;
	Fri, 12 Jul 2024 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761257; cv=none; b=BtLAeVYblgwg/92RgA44xQc49YvCQIFlzpKy8DXvasFRHiJpIz/YYlxBtxORSs/mnEMzNsUDJf+K8F1Q7oNU10j/nMkHb05Zs7EQqs/GjOWVAKtFrMooi4eqCMpfdElcXNIH630lUc3/efCZEBWdW4hjv3QAINt/68iMGsX1Hbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761257; c=relaxed/simple;
	bh=NMFC30txfsq92Dfx6kq9iMPwL95nsCp8lXcX7M2w2v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyv4lyWY+QEds77mq7jGlrwzplzBckZ9UfYdydfnvfa6X7ZTkobZvaUOkCy2QnBQh4jIEwLdouQz0NxxqL1lA4D3uLxYUQ1HAjfGgSm95+MF7Lo0Am2Rn82PFn32LJO3iGz+q8yjCDu5eF3vJg+YZfXbmEydQBBlXf7dbEe87EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX3CqWv2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eeb2d60efbso18883901fa.1;
        Thu, 11 Jul 2024 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720761254; x=1721366054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMFC30txfsq92Dfx6kq9iMPwL95nsCp8lXcX7M2w2v0=;
        b=eX3CqWv2/Xrp+5/Fq89disxghpmzDFu/b9n26Fy4r7C4GHFlG/OQkhe8w/GNv0e1qI
         biyPCjJC/eBS4PMn+IXe9ubdWMlMFwnmm5qpJnfGUK8YOnIYjhkVTlBF4zXEGvtGYQAC
         T/04PxF31UqC596IB1ZC0qIWi2nCqVVu5w3x8YDZ+QaVOglFYyQ94mXrSa7WHMFU5V0R
         Ey/RNjejzxxxxeI5vq6BDwJE9i0MAg/vbSaEdri97XE6wENICvX0gc/QXqVNWQQJ7mSD
         UtsODL6zZtsx7nZH/3TcdS/Hvn8pi8yZ7CT9BXjWCwElSJ2TDbaBYUAa5cnbgYBJHzKM
         L3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761254; x=1721366054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMFC30txfsq92Dfx6kq9iMPwL95nsCp8lXcX7M2w2v0=;
        b=gM6n0pmpZkWXcEWAfjKsqSpQ0iXvwLjt6FSAVkHNaRI+kQxHoi81Bq76b1jczyUNnr
         FnxU1L+DQtuwN4RX2Jc2qOZU1WrjEqgfEvgyE4/g065UUMdHRJQMdxWO4O3Rhdw1mUla
         Twoy7YS4PUtoF8AbVI2caH2WkHOuL94E1GTMtnGBRZPsJIE0eLJ85ggdTx8NUhcoA14l
         IK/2d3iVxGZSoubpVqBYK6pN8bB8RFdgmO6BmeEXHYhUEJ3IIyv1hoPfHL9jQM2rIMAf
         1WQj1gV2QQ0pWKhfclwL2oPzA1jsZU438CtOc5ltvc+iXx4QsBcrID8E1G1no4PIbWht
         rgSg==
X-Forwarded-Encrypted: i=1; AJvYcCVmtFMKuzgw95Kl1tYv//8ib3sMiewSzeclGeNVYB+eSrFnhiBE2Wx/DFanc+bPs8FW5eBO60lv1gipIwfYDu3Tf8Sr+Yq7vyJ0o9F/Dl5Foi36A52O4K+oJFtKi9I310CrAQoDtQP6LQ==
X-Gm-Message-State: AOJu0YxiM2ekhWrkbPjHcIloGjupIDart+XVD6Rb0byMPV8RelzhsQ6V
	3oKmaKxtGS+DFjCpX6ax9Yppg7bC8fnyHclcGiO6wePntTAWCihJ88/o8LSOXxgFSKQNrpMS+Wr
	aX11eNl+9ypVVxLtQTRYC1GVciA==
X-Google-Smtp-Source: AGHT+IGBI5iCwBB9eH/bc/39EcbPRi8ExzKrhHUNXI2RWEUigoA0xaqti8YY43MlF/6vgKlgBmBcjzhOS2wl0AeBzHk=
X-Received: by 2002:a2e:990f:0:b0:2ec:5b10:685a with SMTP id
 38308e7fff4ca-2eeb30e5dfamr67980611fa.17.1720761253525; Thu, 11 Jul 2024
 22:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629103914.161530-1-erezgeva@nwtime.org> <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org> <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
 <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org> <CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
 <3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org> <CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
 <9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org> <CANeKEMP+mRefYZNb+TuBmOD7dC6=7Rg7D1EcfnjJoiaeaV28SQ@mail.gmail.com>
 <875xtd48ps.fsf@geanix.com> <CANeKEMNJ3_ET5pQo2wg7_GSLX+vE+dqW-CV=v2DnG10xcgSdzQ@mail.gmail.com>
 <D2MZ405LVTN8.3LTVN3KTUD6A3@kernel.org> <CANeKEMNtXb4ZV7kcLbHY+Mti6dPV9UZ2wTyUq5z0qtmtNNqSVA@mail.gmail.com>
 <D2N20HB4BIC4.O13SZINCMJ9P@kernel.org>
In-Reply-To: <D2N20HB4BIC4.O13SZINCMJ9P@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Fri, 12 Jul 2024 07:13:37 +0200
Message-ID: <CANeKEMObi8G4yt=pScLQXxY_owa=sRAV0NRu=oEw-o1Ug344rg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Michael Walle <mwalle@kernel.org>
Cc: Esben Haabendal <esben@geanix.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Jaime Liao <jaimeliao@mxic.com.tw>, leoyu@mxic.com.tw, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, Julien Su <juliensu@mxic.com.tw>, 
	Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 00:13, Michael Walle <mwalle@kernel.org> wrote:
>
> On Fri Jul 12, 2024 at 12:09 AM CEST, Erez wrote:
> > On Thu, 11 Jul 2024 at 21:57, Michael Walle <mwalle@kernel.org> wrote:
> > >
> > > Hi Erez,
> > >
> > > No top posting please, see also
> > > https://subspace.kernel.org/etiquette.html
> >
> > It was a single question. Which I think can be answered in one reply.
> > In cases where there are different parts in the mail, it makes sense
> > to avoid top posting.
> > I do not believe we need to be pedantic.
> > The guidance is not holy, it is aimed to make communication more comprehensive.
> >
> > >
> > > On Thu Jul 11, 2024 at 8:57 PM CEST, Erez wrote:
> > > > Yes, I think we should.
>
> Regarding top posting, what was the question here?
>
> I don't see any context. So don't expect any reply from me.

Fair point.
I'll try better next time and write more comprehen answers.
I do hope my reply on the second part was more informative.

Erez

>
> -michael

