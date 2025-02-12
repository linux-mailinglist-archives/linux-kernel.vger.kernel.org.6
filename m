Return-Path: <linux-kernel+bounces-510642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D427BA31FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3818E3A2452
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C818204593;
	Wed, 12 Feb 2025 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcQhR5le"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D720126A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344978; cv=none; b=LKUHOKoSadBQ459boLz5qEJkNk8ABZtGWfYGFwdtYkNRLk5fPxy4ih7S8bd7PcHExXusT1RIiPpkLlkZCy8fU0TwqWG+CteTD/ald59eEoCFGOTvK3XVPuiSgRcMGpougvDPqXWojuQCQvzZNWLIkeQ/XEaP1i3pA+GkWS0VVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344978; c=relaxed/simple;
	bh=5tF4DvzDsVt7KQ/mFgmWdWH6GKf+bgfdnRM0E/Qka0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT63zG3G/Z49PhdjCTOejdsI0+ih6kdv+wVAegSPBBXXTuLTI8+D5RRZu3N1dKRfHsUpEBhIoFYLPsVpo5jOKq2TAo7XLUQ9NB6RWkgHvL9ic/9Ck+hhQCVyuad3mJgKPwdoTENid7ZpF60A1WVgbU0eBwLjHNEdX0N0GmYGTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcQhR5le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9052FC4CEE5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739344978;
	bh=5tF4DvzDsVt7KQ/mFgmWdWH6GKf+bgfdnRM0E/Qka0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dcQhR5lebHxfdK1vHdGgzMSiIWrxtwV10WzDMSDwKZJWyRUlX97wK7f3hxXu+thbJ
	 QOmyMuOrodb3sNXvU+e0xCIDPInA+frr0zbnFou5EnQWr1EUo9nDMBKrZ46N5R83Vr
	 sxXqQ1+s3CJZrBC8jxUpKjwdAw2mDszEbNfGIoN4YG/uXb9AE87xfAa1fR/D9rtO58
	 W/Vl+TboOcpUDykNJ0b1DcAFz5k0h4wPdH6Io9MwhkeRwtonoo+5a9AL57Ed6Uolsh
	 YlBXEqDeHtxmXPaRhTJhKAaDthABCUHBhRy9KsBWubqdQ3Y7abyi/IwBkCEW1BqN6Y
	 io2IEYvrfiUAA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so8749080a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:22:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWckRKVQmrnrN4WqYak/NbivXKK39J+pEH9GBpgTTsmtgrIFYpKH+1SRwKQSZ0j73NLzYiHwCFdvfb4SCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8zYJ2lOO62B/KIhs8yaNXOS++K6xvPfLDuRPJeMGcxUlwiRVw
	Q0zflm33VH8IdC33aa+FOuuH9+BYzYy+tiWN77H7QIbBYvudPOQWk57YY5Yi7U7qwDpfLOqAPGa
	s3/tkVBE8WveoDE86l8zwrN+KOBw=
X-Google-Smtp-Source: AGHT+IH4oQXZ75PaiQ5q94lbM6UPkG1or1sTEbMNPus1+v5Ba6Wxh3nB65ZO7Zu13k5WPTyEWCcXXDkoaEPGpZrm2lM=
X-Received: by 2002:a05:6402:13d2:b0:5dc:8845:6a0d with SMTP id
 4fb4d7f45d1cf-5deadd9ccd0mr1570670a12.14.1739344977083; Tue, 11 Feb 2025
 23:22:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn> <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn> <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com> <20250211233056.q47mp5askk7qrxcp@jpoimboe>
In-Reply-To: <20250211233056.q47mp5askk7qrxcp@jpoimboe>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 12 Feb 2025 15:22:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
X-Gm-Features: AWEUYZkwP3dB1uiekSoXe4aycfg9SEbwDK21JX739EF38anakQ8LqK3tzyOMtg0
Message-ID: <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra <peterz@infradead.org>, 
	loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:30=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Feb 11, 2025 at 07:59:57PM +0800, Huacai Chen wrote:
> > Hi, Josh,
> >
> > On Tue, Feb 11, 2025 at 5:26=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel=
.org> wrote:
> > >
> > > On Mon, Feb 10, 2025 at 02:07:43PM +0800, Tiezhu Yang wrote:
> > > > On 01/15/2025 09:34 AM, Josh Poimboeuf wrote:
> > > > > On Sat, Jan 11, 2025 at 02:57:42PM +0800, Tiezhu Yang wrote:
> > > > > > Hi Josh and Peter,
> > > > > >
> > > > > > On 12/17/2024 09:08 AM, Tiezhu Yang wrote:
> > > > > > > This version is based on tip/tip.git objtool/core branch [1],=
 add some weak
> > > > > > > and arch-specific functions to make the generic code more rea=
dable, tested
> > > > > > > with the latest upstream mainline Binutils, GCC and Clang.
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.g=
it/log/?h=3Dobjtool/core
> > > > > > >
> > > > > > > Tiezhu Yang (9):
> > > > > > >   objtool: Handle various symbol types of rodata
> > > > > > >   objtool: Handle different entry size of rodata
> > > > > > >   objtool: Handle PC relative relocation type
> > > > > > >   objtool: Handle unreachable entry of rodata
> > > > > > >   objtool/LoongArch: Add support for switch table
> > > > > > >   objtool/LoongArch: Add support for goto table
> > > > > > >   LoongArch: Enable jump table for objtool
> > > > > > >   LoongArch: Convert unreachable() to BUG()
> > > > > > >   drm/amd/display: Mark dc_fixpt_from_fraction() noinline
> > > > > >
> > > > > > Are you OK with the first 8 patches?
> > > > > > What's the merge plan for this series?
> > > > >
> > > > > Sorry, my inbox is still reeling from the holidays.  I will revie=
w this
> > > > > soon.
> > > >
> > > > What are the status of the first 8 patches?
> > > > What is the next step? Is there anything else to be done here?
> > > > I would really appreciate any advice on how to get this merged.
> > >
> > > Please post a new revision rebased on tip/master, with patch 4 droppe=
d,
> > > and I'll queue them up for -tip.  Thanks for your patience.
> > You will queue the whole series, or the first 5 patches, or the first 3=
 patches?
>
> The new series now has 7 patches:
>
> Tiezhu Yang (7):
>   objtool: Handle various symbol types of rodata
>   objtool: Handle different entry size of rodata
>   objtool: Handle PC relative relocation type
>   objtool/LoongArch: Add support for switch table
>   objtool/LoongArch: Add support for goto table
>   LoongArch: Enable jump table for objtool
>   LoongArch: Convert unreachable() to BUG()
>
> I was planning on queueing all 7.
>
> In particular, patch 6 should stay with the objtool patches since
> they're directly related.
>
> But I was also just going to grab 7 as well.
>
> Please let me know if you disagree.
What about you merge the first 5 patches, and then I merge the last 2
to the loongarch tree? (I prefer to merge the whole series to the
loongarch tree with your acked-by, but that may be inconvenient to
you).


Huacai

>
> --
> Josh

