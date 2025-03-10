Return-Path: <linux-kernel+bounces-554505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B23A598EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E22A16E707
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D9E2417F0;
	Mon, 10 Mar 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKphSPUp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECB22E3FD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618427; cv=none; b=pHyrxEnYDi22eXmYYuxER1vAf7ozncQkCr3f0whkE6HHsA74aC5sVOlR9mBVgwzQHRpgxej4Z6MesxWHCQQ6w7nG1pkq4c0H8OEAdr0/uupNX08zVWQmyACoAh+PMPUthiGUNCeB6VX0o72hENEhvy6vT2mxTZd7e4k1CinGijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618427; c=relaxed/simple;
	bh=T1byhSalovt7F0xxmtayn6l/TfDh3IOHsRewKjBKIg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2cGS7jt+BNnPJY3MdnJQsglbMcn+Zik3XYoikzlERIcneOCj0KvNVOMBtLNR2jKtv53T6oSCtXZYQc3BSWL2b2UDxOA41WvGFjXsCGQEgrM3CMlNmkUvuawUlCu8rjsBl5nNGxEWfLX08NhI+q0Soiz1ShOKqI77A/ZGOOOVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKphSPUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9641C4CEFB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741618426;
	bh=T1byhSalovt7F0xxmtayn6l/TfDh3IOHsRewKjBKIg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZKphSPUpGt95pJpeccEaOTEtz9kvATosH3Kr/iI0APAJl4R/FVJt3k84YD75CTrEj
	 Exyk6jg0wY3lblauy1wzOzohn1qi/jOxU+jDbOxAewZhiYv0adygg68E/0gSLGiaxf
	 s62Zq1tnTJitd3msn2+YHms85hnUi02DVhQ00MM5tA8VNL4nQ8mqDKfwusqbo9ZyUw
	 k1Dx82S+DjzJpn8eiTEy2VwdSzALs4hE3q5N9ltFsbxGh6ld5wkACJff3N/HwsHaam
	 5t7IOCK/xiJdoI9qdzhXVytqO20pfYqjk0Bzw9evwli6++ttrMNbYJ20ADS5GBDL3F
	 iIieqsBGdQIYg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3061513d353so49540861fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:53:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUweN40fsg9wizAWGKaMCu6islAn3Qg12Fz/1EJszz3gAL4BYugjSU6x20EKpnfl8WA7Yw7uQYujjZveZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NXj9JLyTNCbvDZ6DvQP06Eekdw+0/JvtQ5NpTAM20lNy6vDQ
	uNTgLl9bgrTJ+62T25z7eLfS53/VXmAYNH+p+eJiQz7qvntl6qARloA+OFeN144lOopvdLyp4U5
	lTDfk5HFS7PujngKxGNug5KdvGWc=
X-Google-Smtp-Source: AGHT+IF1apSFV9m/ZWzifv+rgyg/saybyP5bff0NLLFQfEO9U3hAtgBsLVs2WNCdeMj08oliaCsK1IuFOe4HwIdg+1Y=
X-Received: by 2002:a2e:9859:0:b0:30b:c5e7:6e61 with SMTP id
 38308e7fff4ca-30bf4535f34mr39347611fa.20.1741618424923; Mon, 10 Mar 2025
 07:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310062812.216031-1-anshuman.khandual@arm.com>
 <Z87FFqV03Pd0-NXl@J2N7QTR9R3.cambridge.arm.com> <b1fb982a-4936-4c18-aaad-3e8e8f61bccc@arm.com>
 <Z876UI5-xGRHl4td@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Z876UI5-xGRHl4td@J2N7QTR9R3.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Mar 2025 15:53:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEZ86C8bouLt+xNkNr+L9AvCSQ2SZeJpLMtyvGo-8h6gw@mail.gmail.com>
X-Gm-Features: AQ5f1Jr2rr6S3G8y4c5Ng2bpMQK5K8uitjzKua2mpJvGbKtVr89KWYpuQht0eG4
Message-ID: <CAMj1kXEZ86C8bouLt+xNkNr+L9AvCSQ2SZeJpLMtyvGo-8h6gw@mail.gmail.com>
Subject: Re: [PATCH V2] arm64/mm: Create level specific section mappings in map_range()
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 15:42, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Mar 10, 2025 at 01:48:53PM +0000, Ryan Roberts wrote:
> > On 10/03/2025 10:55, Mark Rutland wrote:
> > > On Mon, Mar 10, 2025 at 11:58:12AM +0530, Anshuman Khandual wrote:
> > >> Currently PMD section mapping mask i.e PMD_TYPE_SECT is used while creating
> > >> section mapping at all page table levels except the last level. This works
> > >> fine as the section mapping masks are exactly the same (0x1UL) for all page
> > >> table levels.
> > >>
> > >> This will change in the future with D128 page tables that have unique skip
> > >> level values (SKL) required for creating section mapping at different page
> > >> table levels. Hence use page table level specific section mapping macros
> > >> instead of the common PMD_TYPE_SECT. While here also ensure that a section
> > >> mapping is only created on page table levels which could support that on a
> > >> given page size configuration otherwise fall back to create table entries.
> > >>
> > >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> > >> Cc: Will Deacon <will@kernel.org>
> > >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> > >> Cc: Ard Biesheuvel <ardb@kernel.org>
> > >> Cc: linux-kernel@vger.kernel.org
> > >> Cc: linux-arm-kernel@lists.infradead.org
> > >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > >> ---
> > >> This patch applies on v6.14-rc6
> > >>
> > >> Changes in V2:
> > >>
> > >> - Dropped PGD_TYPE_SECT macro and its instance from map_range()
> > >> - Create table entries on levels where section mapping is not possible
> > >
> > > On the last version, there was talk of an extant bug:
> > >
> > >   https://lore.kernel.org/all/5f1b36e2-6455-44d9-97b0-253aefd5024f@arm.com/
> > >
> > > ... did that turn out to not be the case?
> >
> > In the absence of Ard (or anyone else) telling me it's not a bug, then I'll
> > continue to assert that it is a bug, and should have a Fixes tag, and Cc stable.
>
> Ok -- can we please have a description of the bug, and a fix
> specifically for that, before we try to reshape this for D128?
>
> IIUC the problem is that for a sufficiently large (and aligned) extent
> of physical memory, we might try to create a block mapping larger than
> the HW supports?
>

Yes. However, this code is only called to map the kernel, the DTB and
the ID map code and data pages, and so it seems unlikely that we'll
hit this bug in practice.

Nonetheless, it is a shortcoming that we should address to avoid
future surprises.

> With that in mind, my earlier comment about LPA2 and blocks at level-0
> is particularly relevant...
>

Indeed - at the higher levels, there is quite some variation between
page sizes, LPA2 vs !LPA2 etc in which level is the highest at which
block mappings are supported.

But given the context where this code is used, I'd prefer to simply
map everything down to level 2 or higher (for 64-bit descriptors)
rather than add elaborate rules for all these combinations that are
never exercised in practice. The net result should be identical.

...
>
> Though TBH, maybe it makes more sense to split this up into separate
> levels (as with the code in arch/arm64/mm/mmu.c) and handle each level
> explicitly with a separate function. That way each level's check can be
> handled within that level's function, and we can use the right types,
> etc. It feels like that might be better for D128 in future?
>

I have a slight inclination towards having a separate routine for
D128, but I can easily be persuaded otherwise.

