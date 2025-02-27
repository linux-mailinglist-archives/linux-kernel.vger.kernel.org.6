Return-Path: <linux-kernel+bounces-537029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F2A48732
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD857168402
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A31F180C;
	Thu, 27 Feb 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3hvxkS5"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F51EB5DA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679401; cv=none; b=iMRehm3+MfPhazSO01XWaOKEyEsN4752bkcyEvPAAvLfXkpkWsfzLo4R1Ck8DO0AZ9H+fCr5QCjgTcaHvHdT5rHL7bWrC5wflaQHyArbVrRmjyZ6+TdkpVZiWYhy5nTw0UWRwVqrnRN6/21GwdApzPW+ntae5oqT1NHx5DshIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679401; c=relaxed/simple;
	bh=aXJyi4Wx3R0JAPV8NfjdhwzQdKUokhc4CiIXFDDd35I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hS6i2lLg7fHX9EhDfGr4niywbo/AwyQPNYXfrhw1COQfY8o7w+KdNJGWJ9WDL7N+Md0va/eBf+dtbBN4WecA4cYz1qqyVKB2VaMMCDb93Ce/OZRbJFHj2iAmjhTFQ7x2IK0GcQdeCgqM7tb1QXxJgFTFs6MLJvMgYGeJXCjL86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3hvxkS5; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471fbfe8b89so16991cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740679396; x=1741284196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r36xY43iw45fgW7xbcfzK7x9eAnBCMHKjbDFGDY1hmA=;
        b=h3hvxkS5axl1H7+Kx3yyBmUJw4ghMhvLVxairVRNogL3tyO0wqqFwINXexAn8dsWOy
         jrVwfYSLYfRH1e6T2vVPbPrclZ72bqFNs6Af7mN+33XcmNGMzH2CmrZFBCmddbYmbFRX
         VelSTEjoI1R2iqDhxzvM2cY/H9wsOb2M8AwuaqKvFr3xug1pFCrQygBuQUzhQAhbysUG
         aPVYjFPddunmvCMjGp7pcHMtM/FJ/vnBcr/WFhKObLeGZ7LgwX+dyRrxr+nEU/KJkh8Y
         Vb/nETRF/F9MCxbGmVf2hpZ7cvl43dEPakSrH/gkJD2uhHj1d6NAzZT0zNE2O6nWfEoh
         lO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740679396; x=1741284196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r36xY43iw45fgW7xbcfzK7x9eAnBCMHKjbDFGDY1hmA=;
        b=nxfM4vFjACOsHRpdVPrMwxiUC1aOXGgxEm8EKfFCOEsC1/didEzww2UOg8afmmteUG
         5rqxZ7ZpFaO0G6jR+26aCEPzwTSky6dv6M0Mas7UjUusDoVIWvBQ/wTO5M4ftfWN6jL/
         jnrlSIfwnEiGf3+jATNSQZFNc7OP0NqlOt3jrRXqBrFYXAkLUGaMV8p++pgsawNrKwoP
         NYZUEXrfRMAn+OExHROrEptsAxFeI/3ZgeZMAUgpEfmZAzpq/DTwY7w9hzrlsy31nQ+G
         W6wcBpZmoSZorapzBCztY2HNjCTmi2Vi3VmssbQ+LnjMbmWe7LVqZoMTCck14/huAS6d
         H42Q==
X-Forwarded-Encrypted: i=1; AJvYcCWF5qigtH6p80zh+du+MJ/X6/UTLI5hqzKboohohAldfRh2RIYJLISqvJzerAG5S5XVHDNIAj7x2pIsujs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKoI12UB+oIzzOYAsJGAKRmJ5LJbXp30g8xwMqupDDSgkUmZty
	/L1vvfJ/vYxNR/1gWOOPxq/CHViaQ7jcVEhmo7yuY14SB3HvztqW7e7JH3n5lhDcycQBwnhwBRO
	npKQY2mO9NCr2AIc3n4mTtL5x76qjL9hQB/p2
X-Gm-Gg: ASbGncuG42dN6buNNKNhK8LCDsN0jfYFgUSViQ96w0FGxbS1NvGCUOh/jvg7GgGJOzI
	E5Lggg5lM/BZjGXdYaDgk5BuQ+G+xO2RVYdMweqxtWByZ9QH2u/wAgX+07fol4WU/ZUTCRcbYAe
	JWx3YL
X-Google-Smtp-Source: AGHT+IH1WMMA/3uqqJEGl4Gx6/wQ5va9s9OLY0x0xxcXVM4AeIevuwH7yEXb+VEN8j9a5QKiDZanXiTCGVNjwIjTvhQ=
X-Received: by 2002:ac8:7f02:0:b0:471:f8af:3231 with SMTP id
 d75a77b69052e-474bbe36183mr70881cf.19.1740679396201; Thu, 27 Feb 2025
 10:03:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com> <20250218181656.207178-11-fvdl@google.com>
 <20250226180900.GA1042@cmpxchg.org> <CAPTztWaXZE=y4HBd7ZYW-1pTDrwxO3OBbwNJyu9vpuy22xx16A@mail.gmail.com>
 <20250227172014.GB115948@cmpxchg.org> <CAPTztWYgZ=fwOWv-sKs-wXHCqhPbmJm6qkrDqE+_0c1nUwWM3A@mail.gmail.com>
 <CAPTztWbv+SsK_AtxUw_dTE1FurYe6P6x39gL97o3pvk2_rx4Xw@mail.gmail.com>
In-Reply-To: <CAPTztWbv+SsK_AtxUw_dTE1FurYe6P6x39gL97o3pvk2_rx4Xw@mail.gmail.com>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 27 Feb 2025 10:03:04 -0800
X-Gm-Features: AQ5f1JrPBa0uNQITihglYJKMGmza9l9OemfEMOfYjelco8ii8Fc1hRBhjks-3Ck
Message-ID: <CAPTztWZEWkYAk8FGTBESYQizHhCBd2PUYRwKf1Y3poKXqooP_Q@mail.gmail.com>
Subject: Re: [PATCH v4 10/27] mm/sparse: allow for alternate vmemmap section
 init at boot
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	joao.m.martins@oracle.com, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:56=E2=80=AFAM Frank van der Linden <fvdl@google.c=
om> wrote:
>
> On Thu, Feb 27, 2025 at 9:32=E2=80=AFAM Frank van der Linden <fvdl@google=
.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 9:20=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 08:47:18AM -0800, Frank van der Linden wrote:
> > > > On Wed, Feb 26, 2025 at 10:09=E2=80=AFAM Johannes Weiner <hannes@cm=
pxchg.org> wrote:
> > > > >
> > > > > On Tue, Feb 18, 2025 at 06:16:38PM +0000, Frank van der Linden wr=
ote:
> > > > > > @@ -489,6 +489,14 @@ config SPARSEMEM_VMEMMAP
> > > > > >         SPARSEMEM_VMEMMAP uses a virtually mapped memmap to opt=
imise
> > > > > >         pfn_to_page and page_to_pfn operations.  This is the mo=
st
> > > > > >         efficient option when sufficient kernel resources are a=
vailable.
> > > > > > +
> > > > > > +config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> > > > > > +     bool
> > > > > > +
> > > > > > +config SPARSEMEM_VMEMMAP_PREINIT
> > > > > > +     bool "Early init of sparse memory virtual memmap"
> > > > > > +     depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMM=
AP_PREINIT
> > > > > > +     default y
> > > > >
> > > > > oldconfig just prompted me on this, but it's not clear to me what=
 it
> > > > > does. Not even after skimming the changelog of the patch to be ho=
nest.
> > > > >
> > > > > Can you please add a help text that explains the user-visible eff=
ects
> > > > > of the toggle, as well as guidance as to who might care to change=
 it?
> > > >
> > > > Hi Johannes,
> > > >
> > > > Thanks for your comment. How's this:
> > >
> > > Thanks for the quick reply!
> > >
> > > > Enables subsystems to pre-initialize memmap in their own way,
> > > > allowing for memory savings during boot. The HugeTLB code uses
> > > > this to initialize memmap for bootmem allocated gigantic hugepages
> > > > in a way that is done by HUGETLB_PAGE_OPTIMIZE_VMEMMAP. This
> > > > means saving this memory right away, instead of allocating it
> > > > first and then freeing it later. Not allocating these pages
> > > > at all during boot allows for specifying a bigger number of
> > > > hugepages on the kernel commandline on larger systems.
> > >
> > > That makes sense.
> > >
> > > But if it's infra code for a hugetlb feature, it should either be
> > > something that HUGETLB_PAGE_OPTIMIZE_VMEMMAP pulls in automatically,
> > > or at least be a hugetlb-specific option that pulls it in.
> > >
> > > Keep in mind that not everybody enables HUGETLBFS. In fact, hugetlb i=
s
> > > default N. It's moot to ask users whether they want to enable infra
> > > code for a feature they aren't using, and default to Y no less. You'r=
e
> > > regressing innocent bystanders doing this.
> >
> > The main reason that I added a separate config was:
> >
> > 1) I could see other subsystems use this.
> > 2) The number of section flags is limited, so I wanted to put the one
> > I added inside an option instead of always using it.
> >
> > If especially 2) is not a concern or can be solved differently, I'll
> > be happy to remove the option. I don't particularly like having it,
> > but I didn't see a better way.
> >
> > Let me think of a way to clean this up a little, and suggestions are
> > welcome, of course.
> >
> > - Frank
>
> I'll just do:
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 64d420e3c475..fb9831927a08 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -286,6 +286,7 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>         def_bool HUGETLB_PAGE
>         depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>         depends on SPARSEMEM_VMEMMAP
> +       select SPARSEMEM_VMEMMAP_PREINIT
>
>  config HUGETLB_PMD_PAGE_TABLE_SHARING
>         def_bool HUGETLB_PAGE
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f984dd928ce7..44b52f8e5296 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -496,7 +496,6 @@ config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
>  config SPARSEMEM_VMEMMAP_PREINIT
>         bool "Early init of sparse memory virtual memmap"
>         depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP_PREIN=
IT
> -       default y
>
> Does that seem ok? I'll send an mm-unstable follow-up patch.
>

Wait, that's actually not correct. Anyway, I'll stop spamming - I'll
do it along these lines but properly, and will send a follow-up patch.

- Frank

