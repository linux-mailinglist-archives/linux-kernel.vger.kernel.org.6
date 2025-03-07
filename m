Return-Path: <linux-kernel+bounces-550958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDB2A56668
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D8A1891AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A5F217664;
	Fri,  7 Mar 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEcRD0nP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE4216E30
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346207; cv=none; b=jm1OUQbZ7DP3vnqtM9ilbANMSbeI+8ik6vLUZPQhFOZp5j5ZIJwO3pBjeK9yosvILmQCQZQ0prkv6RiVCh0mE3hzIggpgYusmXK5bB9PXTTTwQvcUkqB9g5/7BCdoQypCB+a8y0KnyW/vwo5Fu9FByc2Ewj4ACZmgNsvVneOveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346207; c=relaxed/simple;
	bh=mRU/TFaL4e6XK0tcZjzvJPjDs61j/v0SE/FCbM4Kz8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0kMocVPwSBSDS1sJYGlpBNtIsc6D/KFZKv5EJ88J4DL5QYd6ZViKp5jSbnQ2pPBdlp9eGFEMJKdzI0luuRthRRrELyNkAtCt104cxhWt8H2ub0wukLQdkikhu0/UYjz6fKS+PuXcd3Do2d2KU5TkTA/YFt2wJDp1QLHQHSN5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEcRD0nP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8B5C4CEE7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346207;
	bh=mRU/TFaL4e6XK0tcZjzvJPjDs61j/v0SE/FCbM4Kz8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YEcRD0nP86wgTrcTAoZ5NJBYNIXEbIf5gZSI4aPMS1M2+1DGvDloemA6dTcXiaT1j
	 FUidEODiOpN4j9L2vMAHoXOTl2GKZFLA4KwNJ94YwQCk65vDz0PoyBizVzxNzziVjp
	 1nkyr4pyrYhJgL4GWzBkRqJgq/TNwb1za1xr0xXfuqTLDleBZZ+/nJc5LpG1P/8eau
	 5fQz7Kwvrd6wpeozWQj23LYWDuyaTqqamTVH6zwnqMyrEm5uhsPz1ze1xVU2dpOBUt
	 WAOulJBZOyF7kMHcl6WfMctXZQZ59FMQiOTShBONJiwmJdlk0o4KGZgEYj946NAqRt
	 i+K4XFhINT+tw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5452c29bacfso1880603e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:16:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAQ2O3/PKCtZeXo4mB3uTGkneTsWhM2aaTc3OZoNz2dDkwGQlomm9jaKNZiP0GGjMdQM9/LZ1eNV0g4XY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5clOxmpePHxTMaxq/omI/kqaF3tN6QaXNPeUnrP4TOGvaklvI
	UaZarr1aHHD91gmFtpuPbuuiEB1addbYj2tawIa/fPePckcTKkAy9Jwc3VNT/07exFjbBgWukOF
	owOBbpNZuy/z7yTv0eeyzyB2ZVmw=
X-Google-Smtp-Source: AGHT+IEd8LNwJeFbdQ3uj2O6NksToZNoHhmgCNCRphkDy84JxoDFKdZ7tPd6rGQNzVWWtVSbV4qDBVVujGNfC0cWrYs=
X-Received: by 2002:a05:6512:1242:b0:549:66d8:a1f1 with SMTP id
 2adb3069b0e04-54990ec56b5mr1217665e87.45.1741346205601; Fri, 07 Mar 2025
 03:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307050851.4034393-1-anshuman.khandual@arm.com>
 <17931f83-7142-4ca6-8bfe-466ec53b6e2c@arm.com> <c3dddb6f-dce1-45a6-b5f1-1fd247c510ab@arm.com>
In-Reply-To: <c3dddb6f-dce1-45a6-b5f1-1fd247c510ab@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Mar 2025 12:16:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE0mCPSKLyNUkLZXLntX-=aCGKdn5b3Zgme3PbyYFgFdg@mail.gmail.com>
X-Gm-Features: AQ5f1JoPPqfSFsuuGLR7flaiIcakquC0OyiZXiqRSi8scsvaTC-cqIRH-u_m12o
Message-ID: <CAMj1kXE0mCPSKLyNUkLZXLntX-=aCGKdn5b3Zgme3PbyYFgFdg@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Define PTE_SHIFT
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 10:21, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 3/7/25 14:37, Ryan Roberts wrote:
> > On 07/03/2025 05:08, Anshuman Khandual wrote:
> >> Address bytes shifted with a single 64 bit page table entry (any page table
> >> level) has been always hard coded as 3 (aka 2^3 = 8). Although intuitive it
> >> is not very readable or easy to reason about. Besides it is going to change
> >> with D128, where each 128 bit page table entry will shift address bytes by
> >> 4 (aka 2^4 = 16) instead.
> >>
> >> Let's just formalise this address bytes shift value into a new macro called
> >> PTE_SHIFT establishing a logical abstraction, thus improving readability as
> >> well. This does not cause any functional change.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> >> Cc: Alexander Potapenko <glider@google.com>
> >> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> >> Cc: Dmitry Vyukov <dvyukov@google.com>
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: kasan-dev@googlegroups.com
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >
> >
> > +1 for PTDESC_ORDER
>
> Alright.
>

Agreed.

> >
> > Implementation looks good to me so:
> >
> > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>

With PTDESC_ORDER used throughout,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

