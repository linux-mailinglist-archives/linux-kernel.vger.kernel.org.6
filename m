Return-Path: <linux-kernel+bounces-537201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84CA4891B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A44F3A659B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCB521ABA0;
	Thu, 27 Feb 2025 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="A/xZo4V/"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C488270054
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684996; cv=none; b=rMqgn56jFdkgwfNxHbyPA1vMAK/1qZ83rLRBj4WrHfxE14w3ewp+IBGy9LMYTS/LXob7ngXtUaLP6h/3yBJPsYR5Q8fVHidu9DtcPDZsdz0t3apaP05TDqCxzVJuYZ1LeJxVSVEI/EukMpEJ1fP467ChjIX8NQsvzyRcI+91WJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684996; c=relaxed/simple;
	bh=C1F7JIZ/rZmbx5zaNECv2NVjL/z3kn7zYTE6VZysw1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EayoeEcTgT1s9ykDlWpRP3BCfayJzARoi5YQi5PiLgxmMgoqAOc0ea8+G3+CxHsc5W1htrjPKSuyjfwnL8mJ08zmvNu7EBnho1ANS3+wF6KLRzqA+YOJxexVmAMQwW8ZbV7kwDM+IHhvKnuAIVEB+aOS4NupPGWraw4hDGSJHuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=A/xZo4V/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0ba89dda9so139114785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740684992; x=1741289792; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qQGmvDxGhjhQGrQCPpUIPeeAlhy/ylNJXmNHALKC5Q=;
        b=A/xZo4V/tbkqrfLC8b+E+fT3dooVMvXD4aKRwFOXnT2VW6smW3AXOWo8gjcjouznpN
         kEYZtvg1/uGFZGq1A1egZZla0dymKXvD5PZOK6MOcDZi68vgeb9t04nADU5MTN6m3hR1
         63DW8H5pOJvkixddA5xeyIyBz1aCKrB8/bLnpX7Qczp4C/ZnPynEP2ltAUjmrcpD/tFr
         lRP51BF4YrNzuZWHqX+s5UOdF0u3pw8gmaQzkQp9sW82z0TRC+ibmQ06fWV5ASJyJQYi
         h7LpUmG87JtB+eht3vueuIk6Q8AO+oxbMlT4stiddA3lm3DZ1sWzZjIVG01yjEN1n3Mi
         YNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684992; x=1741289792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qQGmvDxGhjhQGrQCPpUIPeeAlhy/ylNJXmNHALKC5Q=;
        b=nkvXiG9FLOZqGsVG2CaU3Ha5+But6N0zjuscqM02zATouK8XXCUvmasiud9aWHkFTV
         l0+IyJ62LtEXbUmj0qT22fIiSyBh6gLdCec3UzaLUl5zlZt2dphUoGlb3+GUdGg+s6Kt
         5zCZBBBQYv/HLsiY9AIfCL1hCdXvLHnWdOnqMKyxRa8tc2phX4utHn3HYcFmfnLd+qmL
         D7Muk4NKEYSsiLp0Xpf0pLcrc0ZZvcwndDngK+iTmD+0kGYQcPxpHoyoJejCv0iDFZhu
         GadtAmVxLRoF8G+WoZ1AnufIF6rlXo5qfK538mdpoP9pJ0gEhmz4FMmXrflB5kBsCAgN
         xmFA==
X-Forwarded-Encrypted: i=1; AJvYcCXLQtiww4HtnVXrLNbocDbqGhKVqPvZlbcwooFG00tNhvK+MUKOAyrfX/8YQNClyyFKQMigG7Y/ycgCn2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKpqA1KX8pPhJAKeorvctMtkYwDvC1TZsBjjgNj9eHIIiNc0I
	gt9Ukt9gzO+Pk92AvvSXxcas0UFP0tJgezlmRGDmVo5JKtMBrGtTp8xzbhvAC1I=
X-Gm-Gg: ASbGncsLrGEFVteUwqbyBlbBp1sBEuvnYZI4ICf0wDR4aq/uMnxAnsny3xYywDhgFpA
	elpQhdx4q8Ecbr3qkIJUj6Igr9UuceyuC0OCiF3r7nNcKUKbZtHyh0E4KvpAhMXI1XfcvNhXzo/
	Yi/oA6aNsDIH1Ri9Tw+eSWXMYk8gelc+GLXywiB0hwalWHMGyUK0x4UjAtSV4B3KzKzAqyOnFva
	gk0O9+aoExkq4gt6xSWYw9NLzkiIfi6tnlrK1ICQrQs98UtD/ajuv9r8HGyvIdC/qAGBUhGxB9V
	8hcPU8Qj/esHuaX7+A7B+FcB
X-Google-Smtp-Source: AGHT+IEJhvb4x+uuyGVxu9aNvL9XmFgdQgjMcKRWIm6G4rB2pS6X0O2WlZ7omF+icm6hJ3XTVEd+xg==
X-Received: by 2002:a05:620a:178e:b0:7c0:a0fd:7b2c with SMTP id af79cd13be357-7c39c4bea6bmr74185785a.22.1740684992142;
        Thu, 27 Feb 2025 11:36:32 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c378dadf9dsm142215285a.111.2025.02.27.11.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 11:36:31 -0800 (PST)
Date: Thu, 27 Feb 2025 14:36:27 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Frank van der Linden <fvdl@google.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, joao.m.martins@oracle.com,
	roman.gushchin@linux.dev
Subject: Re: [PATCH v4 10/27] mm/sparse: allow for alternate vmemmap section
 init at boot
Message-ID: <20250227193627.GC115948@cmpxchg.org>
References: <20250218181656.207178-1-fvdl@google.com>
 <20250218181656.207178-11-fvdl@google.com>
 <20250226180900.GA1042@cmpxchg.org>
 <CAPTztWaXZE=y4HBd7ZYW-1pTDrwxO3OBbwNJyu9vpuy22xx16A@mail.gmail.com>
 <20250227172014.GB115948@cmpxchg.org>
 <CAPTztWYgZ=fwOWv-sKs-wXHCqhPbmJm6qkrDqE+_0c1nUwWM3A@mail.gmail.com>
 <CAPTztWbv+SsK_AtxUw_dTE1FurYe6P6x39gL97o3pvk2_rx4Xw@mail.gmail.com>
 <CAPTztWZEWkYAk8FGTBESYQizHhCBd2PUYRwKf1Y3poKXqooP_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWZEWkYAk8FGTBESYQizHhCBd2PUYRwKf1Y3poKXqooP_Q@mail.gmail.com>

On Thu, Feb 27, 2025 at 10:03:04AM -0800, Frank van der Linden wrote:
> On Thu, Feb 27, 2025 at 9:56 AM Frank van der Linden <fvdl@google.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 9:32 AM Frank van der Linden <fvdl@google.com> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 9:20 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Thu, Feb 27, 2025 at 08:47:18AM -0800, Frank van der Linden wrote:
> > > > > On Wed, Feb 26, 2025 at 10:09 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > >
> > > > > > On Tue, Feb 18, 2025 at 06:16:38PM +0000, Frank van der Linden wrote:
> > > > > > > @@ -489,6 +489,14 @@ config SPARSEMEM_VMEMMAP
> > > > > > >         SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
> > > > > > >         pfn_to_page and page_to_pfn operations.  This is the most
> > > > > > >         efficient option when sufficient kernel resources are available.
> > > > > > > +
> > > > > > > +config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> > > > > > > +     bool
> > > > > > > +
> > > > > > > +config SPARSEMEM_VMEMMAP_PREINIT
> > > > > > > +     bool "Early init of sparse memory virtual memmap"
> > > > > > > +     depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> > > > > > > +     default y
> > > > > >
> > > > > > oldconfig just prompted me on this, but it's not clear to me what it
> > > > > > does. Not even after skimming the changelog of the patch to be honest.
> > > > > >
> > > > > > Can you please add a help text that explains the user-visible effects
> > > > > > of the toggle, as well as guidance as to who might care to change it?
> > > > >
> > > > > Hi Johannes,
> > > > >
> > > > > Thanks for your comment. How's this:
> > > >
> > > > Thanks for the quick reply!
> > > >
> > > > > Enables subsystems to pre-initialize memmap in their own way,
> > > > > allowing for memory savings during boot. The HugeTLB code uses
> > > > > this to initialize memmap for bootmem allocated gigantic hugepages
> > > > > in a way that is done by HUGETLB_PAGE_OPTIMIZE_VMEMMAP. This
> > > > > means saving this memory right away, instead of allocating it
> > > > > first and then freeing it later. Not allocating these pages
> > > > > at all during boot allows for specifying a bigger number of
> > > > > hugepages on the kernel commandline on larger systems.
> > > >
> > > > That makes sense.
> > > >
> > > > But if it's infra code for a hugetlb feature, it should either be
> > > > something that HUGETLB_PAGE_OPTIMIZE_VMEMMAP pulls in automatically,
> > > > or at least be a hugetlb-specific option that pulls it in.
> > > >
> > > > Keep in mind that not everybody enables HUGETLBFS. In fact, hugetlb is
> > > > default N. It's moot to ask users whether they want to enable infra
> > > > code for a feature they aren't using, and default to Y no less. You're
> > > > regressing innocent bystanders doing this.
> > >
> > > The main reason that I added a separate config was:
> > >
> > > 1) I could see other subsystems use this.
> > > 2) The number of section flags is limited, so I wanted to put the one
> > > I added inside an option instead of always using it.

Yeah, an *internal* config symbol make sense, so that the sparse flag
and the code generation are gated on whether there is an actual user.

I'm just proposing to make it invisible and let
HUGETLB_PAGE_OPTIMIZE_VMEMMAP (and future users) select/depend on it.

> > > If especially 2) is not a concern or can be solved differently, I'll
> > > be happy to remove the option. I don't particularly like having it,
> > > but I didn't see a better way.
> > >
> > > Let me think of a way to clean this up a little, and suggestions are
> > > welcome, of course.
> > >
> > > - Frank
> >
> > I'll just do:
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 64d420e3c475..fb9831927a08 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -286,6 +286,7 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >         def_bool HUGETLB_PAGE
> >         depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> >         depends on SPARSEMEM_VMEMMAP
> > +       select SPARSEMEM_VMEMMAP_PREINIT
> >
> >  config HUGETLB_PMD_PAGE_TABLE_SHARING
> >         def_bool HUGETLB_PAGE
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index f984dd928ce7..44b52f8e5296 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -496,7 +496,6 @@ config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> >  config SPARSEMEM_VMEMMAP_PREINIT
> >         bool "Early init of sparse memory virtual memmap"
> >         depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> > -       default y
> >
> > Does that seem ok? I'll send an mm-unstable follow-up patch.
> >
> 
> Wait, that's actually not correct. Anyway, I'll stop spamming - I'll
> do it along these lines but properly, and will send a follow-up patch.

If you remove the prompt after "bool" it becomes an internal symbol
that you can then pull in as needed.

I agree that unconditionally consuming the sparse flag would be
unfortunate, but consuming it when HUGETLB_PAGE_OPTIMIZE_VMEMMAP is
enabled is fine, right? Seems like a specialized enough config.

Thanks!

