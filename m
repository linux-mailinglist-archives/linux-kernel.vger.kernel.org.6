Return-Path: <linux-kernel+bounces-221996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ED490FB87
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F855B214A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805291D555;
	Thu, 20 Jun 2024 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJph/Mii"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593491BC5C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718852911; cv=none; b=bRVx1BMaFuZcfyahoXxT0msU+9h73H3pqNlX2UY8QLEqgaqEfCOeu3jc1ZheD7WIpW/1tUJdThP+djhai2Yg/ZNQqN8B+7ru9w5e1PP8L15QWgu7Uii29/bFPft8Dzsiw6uxLKqfZ1fUQ2DmrO1fPA2eywYsU1RF+ZPCSEiunsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718852911; c=relaxed/simple;
	bh=8P2mxdIUvPc4hytMFMZTpR4BJGrP+NBu9YthFrxaiOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHlKRSdFOmdB9Th31/6Sk+z9VKx/QrxK/Xl7vTZxX/IVk9t/wiUOAZB5JoxuYqiNl8qL+S7oLRKw/9wXtho1NI11egpKq2PYPOc5uCVIzJHhnYZ+6FKpV7ldM/nP0ebvHvuR6pFU86gQ2HEgRlq+c2r0QySCADogz3MSXOFQah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJph/Mii; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25ca04d24dfso244901fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 20:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718852909; x=1719457709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8P2mxdIUvPc4hytMFMZTpR4BJGrP+NBu9YthFrxaiOA=;
        b=JJph/MiitwCP8USFqoKSpzsfRForLhslURR9jwo/xTaE1C5S4KcN1WTmvX6aZXzkVU
         rgzzVRWkbRcsj14dHdMIW/w2RdI0s1hRmfrQtqcyP9nUrrnDuHu0RuKvmuIx0+zo9Dy5
         xxv2uLHdHxPLKUs+0ENTDEsMw5+6V377IdFhg+WLCGIWxY2tO3OC37Xuhu61C7DhnG15
         pj4TtKZhTabPvpLqsQ97p/S+HPWEUyRnSN7C+/c0U20rtpq8VQ+ZroJfqFNAiO4CqnjA
         va0XwsWiADsOtCHqrXonwCuiAYhQ/MYxc6VgP5r8/0WkPbZ0jB9ccA4StAMU2qa5nmBH
         clNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718852909; x=1719457709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8P2mxdIUvPc4hytMFMZTpR4BJGrP+NBu9YthFrxaiOA=;
        b=P0bTHQU15B4RVrSkBATu8dqjFPTRWJdz8hQ82jU/U9j02lQF2Loi/QqwuPsHsZ3ha3
         aY4ZE4hlLP1xrK6RtTJHhijjJ9qZ6AoBaqbKtxH6EglI2xI1zwpQvC/524ZxuNiNplm1
         0O6gNMDa3kE95bvQKAYpfepGH+FoaAssa4TVJC+Bp4LTvc72msnVYn2Q+QJeTzYIHV8T
         7fcDAuJ22zi7M8PrDyzTGtvXvFonmHQgNFrz8kdECnAJwvlK2HIUqBaWG1nZL6cymUTc
         ePkVPoGAN6Uetgtq19Gr+IkC9RaTVT07dpkOf0dcSanZhIY1dDaEPew6F0btorKm4x/M
         ngXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeP35RqaveVl+G6N4u15vhrstDBBZHe9eBrW/POe0KiFTFXd5m+MFfIlO+kHiIVtUhNYuCdUBGDF0TsT83FDbYHvioJZ2kjAvs1Mth
X-Gm-Message-State: AOJu0YybAsO6Vfg7NRJ1enU7gEO4YOv+++HKDgvGVunXXt7amy6jKnJR
	69i+omjQY7McVgcps5CY9A9ZQ2FJl4Q3dBLNq7jVLcpPLLgkN+CWjMD/WhdhVEBdjQj1JX9yDPc
	aWetrhp/qm3r7OZcBlqSUgSTHLNE=
X-Google-Smtp-Source: AGHT+IHvdS8mu92L+RrrtmqzJGBDlrfMrtZjM5WsvTb+pETz+9KQK84qr/HN71paaXRXxlauZU6llMpo2kTI4u8z4A0=
X-Received: by 2002:a05:6870:c18b:b0:258:42be:ce5e with SMTP id
 586e51a60fabf-25c9498fcd6mr4498884fac.16.1718852909141; Wed, 19 Jun 2024
 20:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu> <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
 <20240617110348.pyofhzekzoqda7fo@airbuntu> <20240618145851.je4a7cu4ltrt3qxa@airbuntu>
 <CAB8ipk_LXzkkGzT1SS6U8i4nW6j9coxeuwn6vuUFusCQcFM8zw@mail.gmail.com> <20240619180348.rp22d4ozb4emncuq@airbuntu>
In-Reply-To: <20240619180348.rp22d4ozb4emncuq@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 20 Jun 2024 11:08:18 +0800
Message-ID: <CAB8ipk_EDm4MQ=0OK7ygXMtaUSUo1V=ZTMRT9rro+bf+6am3uA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:03=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 06/19/24 10:46, Xuewen Yan wrote:
> > On Tue, Jun 18, 2024 at 10:58=E2=80=AFPM Qais Yousef <qyousef@layalina.=
io> wrote:
> > >
> > > On 06/17/24 12:03, Qais Yousef wrote:
> > >
> > > > > Sorry, I miss the "fits_capacity() use capacity_of()", and withou=
t
> > > > > uclamp_max, the rd is over-utilized,
> > > > > and would not use feec().
> > > > > But I notice the uclamp_max, if the rq's uclamp_max is smaller th=
an
> > > > > SCHED_CAPACITY_SCALE,
> > > > > and is bigger than actual_cpu_capacity, the util_fits_cpu() would
> > > > > return true, and the rd is not over-utilized.
> > > > > Is this setting intentional?
> > > >
> > > > Hmm. To a great extent yes. We didn't want to take all types of rq =
pressure
> > > > into account for uclamp_max. But this corner case could be debatabl=
e.
> > > >
> > > > Is this the source of your problem? If you change util_fits_cpu() t=
o return
> > > > false here, would this fix the problem you're seeing?
> > >
> > > FWIW, if this happens due to uclamp_max, then this patch to do the ca=
pping is
> > > still needed.
> > >
> > > I think it's good to understand first how we end up in feec() when a =
CPU is
> > > supposed to be overutlized. uclamp_max is the only way to override th=
is
> > > decision AFAICT..
> >
> > Sorry for the late reply...
> > In our own tree, we removed the check for rd overutil in feec(), so
> > the above case often occurs.
>
> Yeah, the current definition of overutilized is not good enough. So I can=
 see
> the need to do that..
>
> > And now it seems that on the mainline, uclamp_max is the only way to
> > override this.
>
> Thanks for checking. Your patch is correct and if we combine this with an=
other
> patch to use get_actual_cpu_capacity() in util_fits_cpu(), they are good
> improvements.
>
> Are you still happy to send an updated patches?

Okay, I'll send the new patches soon:)

Thanks!

--
xuewen

