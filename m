Return-Path: <linux-kernel+bounces-516944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11779A37A07
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C370316A68A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD114EC62;
	Mon, 17 Feb 2025 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcsmt+1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95137DA8C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739762035; cv=none; b=fshIIKTHojJvgZB45DU0JYXDI4R8OSN9KUJhbiz0zf3Sc3laPvVrov40sEBqBZeif4x8QuKuOcAkUndB2fg6Id2ANVY44jq9NmlMhAstrq7tSofP85Gl6snIvi3HUhxoU+Drzm2FeKvn9rwroR1nBwLuddN3Nw8CTVcEKd2PC3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739762035; c=relaxed/simple;
	bh=pAyuXlE9n0iPIhV0i94vEhmyYjpu9Z6Gs9XjgJKObMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dThoo+ZEcxGdJfszw5itetkL0WtVSieEpqOiEvMCDpEhUhrr4Pnqg0wNIT8BdtOEVMXjncJyIEv2hxDYO0R3x/bhjb5aBnppHhwJuXCIQ5bCWvqClSQVNEKdWm9mTboCZm/jjvtrEPHwLnJ0pIg8GFxjUd9pdUxRVE32LkEoUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcsmt+1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AEBC4CEE8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739762035;
	bh=pAyuXlE9n0iPIhV0i94vEhmyYjpu9Z6Gs9XjgJKObMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bcsmt+1D2s7i/BD/AKkNAhMn9l6KLBp9fffzVlbTZqvRhi0texFb6Kg2y/Ar48Wch
	 9PJDine34K28X4ZoZVYZzVbVV9ZqEwcE+ggmcjya1Qc9ztCdrZS6Zc9i5j+jsGmWQg
	 d0t18Ki33P/1uNuv9G/VJaQyrgAahvrn+ka+GDk/euWOSINkZ8chE0B+S7u7oawq2r
	 0qQmnCAmCOI9IFTZ4Kmk5sK92tGvF807tJ16nufNe0TIKAO+1kzfMCeESLzmgDIqN8
	 dC5ID6OeeBBJQmRG9UDhUv7T+KuE4CxgLDpqCow3DZJvrsNigBtzDclhPcV/ONGPXS
	 PqRFOmE4BtmAw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso658961866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 19:13:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPmmkgeiLOs8lQ112y/p5MiMFvdQa1pZ9Nbdq2dDSyn6DL6v7Lc2m2An391rnC/OMmxhp4I08mDJX3L0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtlWpeidj82w21dT6s398NstgTglVloIAwY9fvHCFExkppK2N
	z7xFJ1c6hS8R1yIl5ZRuYzDw8NF1UPJiNgeQXcZE7svsTh7QazcEBjX4Ajx9fYm/v3RbILsIv7/
	Bf8xxigpvTBNTZO8LzS3lveQZAYk=
X-Google-Smtp-Source: AGHT+IE+lCxd/VN0cFWcgSvPgk7Nu3WrmBw9zHE0Olw6SOhdkJGmzxd7XkXEOYSYzwMWE4/pbWbtUHzEsFxBtaHqNSs=
X-Received: by 2002:a17:907:7854:b0:ab7:c1d5:14f9 with SMTP id
 a640c23a62f3a-abb70931a60mr796940066b.10.1739762033809; Sun, 16 Feb 2025
 19:13:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn> <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn> <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
 <20250211233056.q47mp5askk7qrxcp@jpoimboe> <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
 <20250213025108.svqgj5nzseqs6qox@jpoimboe>
In-Reply-To: <20250213025108.svqgj5nzseqs6qox@jpoimboe>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 17 Feb 2025 11:13:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5mYGnxHPxAeXkHo2XBvi-RtPjDQRBnDiDyKVtFv-ZBBQ@mail.gmail.com>
X-Gm-Features: AWEUYZnerjRjGiFDoG8vssKUp_r7uyi3vq83RlWmu1DWGBTmDSKGJJGP4uNTOm4
Message-ID: <CAAhV-H5mYGnxHPxAeXkHo2XBvi-RtPjDQRBnDiDyKVtFv-ZBBQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra <peterz@infradead.org>, 
	loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:51=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Wed, Feb 12, 2025 at 03:22:45PM +0800, Huacai Chen wrote:
> > > The new series now has 7 patches:
> > >
> > > Tiezhu Yang (7):
> > >   objtool: Handle various symbol types of rodata
> > >   objtool: Handle different entry size of rodata
> > >   objtool: Handle PC relative relocation type
> > >   objtool/LoongArch: Add support for switch table
> > >   objtool/LoongArch: Add support for goto table
> > >   LoongArch: Enable jump table for objtool
> > >   LoongArch: Convert unreachable() to BUG()
> > >
> > > I was planning on queueing all 7.
> > >
> > > In particular, patch 6 should stay with the objtool patches since
> > > they're directly related.
> > >
> > > But I was also just going to grab 7 as well.
> > >
> > > Please let me know if you disagree.
> > What about you merge the first 5 patches, and then I merge the last 2
> > to the loongarch tree? (I prefer to merge the whole series to the
> > loongarch tree with your acked-by, but that may be inconvenient to
> > you).
>
> I want the first 5 patches to go through the -tip tree because we'll
> have other patches depending on them.
>
> I'll go ahead and take the first 5.
>
> If you take in patches 6 & 7 separately, that might introduce a lot of
> warnings.  But it's up to you.
>
> For patches 6 & 7:
>
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
OK, please take the first 5 patches, I will merge your objtool/core to
the loongarch tree and then apply the last 2 to avoid build warnings.

Huacai

>
> --
> Josh

