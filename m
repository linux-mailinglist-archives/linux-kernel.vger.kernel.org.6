Return-Path: <linux-kernel+bounces-537019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00824A4871C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F11188A72C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7D1EB5FE;
	Thu, 27 Feb 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBmYMHMm"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2E1E51EC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678980; cv=none; b=dTKVi0gJuF7ovcrPIxk2MP5yQZUD6oQxnGqrdxxFhqlr/9jWCVy00yUGbm7cZmB2DhkHRNhVs8jyhLgJex+UfMn53GqrCWp17EKsrUhl0wbP98VB5DBsYbDlehAcPYex+Mn/f4jZulBHGXl0sLAykA9GVAICgQJvmiAgDqADs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678980; c=relaxed/simple;
	bh=BW0N+XroGzAC2aSLYgKGbfNiqGvY/di0pt3t+bNk9Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPxRgcUpL3lZKExZDVR68u+cjiXtGfK08c7T4llDxFDANIV84HFj3lo2ybXGTyn1AWabb1dfbB86sorYGYoF8Ug40qNueerupN4P0WET3LbiBQtKhoFbGSLY89AxvBUbyUUhJT9Dldxkdm8phAWzQsEZqrPMJotFluIYr1nzw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBmYMHMm; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471f1dd5b80so3771cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740678977; x=1741283777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9d3ie4HxJSBse0wdOCV6qSonqjqCosACOR6Iw/hvOY=;
        b=rBmYMHMmngUbzfvi0jA+N/xbFJaBsusA1yEQmnEdJvuuoQKOmTjVIige6hwOjMKNcE
         y/NkYHpK4TOAcc0FG9GLCSdrEssdfaD0JIgrhIUeSuuANQ4nutd4wqYpIbZHIMb3eZbU
         zJk5s+J17UWYNqildTEEZFVF5L4kyWvtsGPbrD0sCu9LIdtjMQA4ITo2IHroFEJZhxzc
         Bezdu4fvNNg0Cjtb6eZN7o8eFpfFZlA3e4E9/7y+67vH1sSrmPaimVDuZbcjXeHMOFsI
         BIku1Hsty+Gu6D/LAV1voeGPxD41wLUS7EmeGwVuT2BkA2F+fB/ifxci8cITquK6p8DN
         xGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740678977; x=1741283777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9d3ie4HxJSBse0wdOCV6qSonqjqCosACOR6Iw/hvOY=;
        b=PzxcZM9uh4TdfzbSgkioevZXCheMvRyyYvUF30QBVbHazvMAo0EG+j77zGQCKzXHXw
         F/biaSoWrjZnbGYWX5fZFH7u45tUZBvJujzUI+ecYl6tXQQakPWUR3DiBmVVCMP4fhIT
         kOaT8K98pRR6qP6+nqqBrlG/i96xn2e8rMYh/edYz69klM/339LcDXP0TzVt3eyZtwBy
         cXXenNeP8tYb8QiPIRgGzwCigpqiI0xb5G2axqJlSlxEGH7A/rNE0+s10zcX2QzqczQ7
         RDPl4NfEdj9RLNvCJ01N36wLIXAMjv2YmayjNUI146KoxHGktixlChhigIsdlo/f8lpr
         zkgA==
X-Forwarded-Encrypted: i=1; AJvYcCVAEzq++Kya6C1meD3Dm9GYftUm2oCxk49dO3EnRHw8k1gFMN2+JV8U8Zlg+Pb5+FU6x1cH7jOQ7yjliE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7tzx2YCdAOG72hMf3HuAWPEVx0FdU/O4WDePXgHBGsfmZQTX
	sHgB4yHqt5GuWYbvjE8tzatzB6IPvquwD19080YtcuYyJzo1bLLWg7yT4rPhy9uvEaYgBstHJBP
	AYRJK245fhlkFo3jM/8mIOcWM1kgXkHDEt0Mk
X-Gm-Gg: ASbGncs0Kd+SG8KlKb2M386rohT761yp+FXc7sOOmDv813+sTFx+WmeLUvQ0IR8Hvx1
	aiM5rMP9iWYrFPwODFYan8MmLek+BEambYjtR5aVeDM56m1Z+o+4cXvTayqZaWy8vdUh1u79ECn
	7//MX/
X-Google-Smtp-Source: AGHT+IG+L20TESuHV8MCRDMpu3SQ2JPXYfo/HYNWO4fcfwaf+g/hyqXyUiSJyrdKH6KMgxz3ez9hLH5wTgOyJDmpByQ=
X-Received: by 2002:a05:622a:1822:b0:463:95e2:71f8 with SMTP id
 d75a77b69052e-474bbdeb033mr41601cf.15.1740678977178; Thu, 27 Feb 2025
 09:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com> <20250218181656.207178-11-fvdl@google.com>
 <20250226180900.GA1042@cmpxchg.org> <CAPTztWaXZE=y4HBd7ZYW-1pTDrwxO3OBbwNJyu9vpuy22xx16A@mail.gmail.com>
 <20250227172014.GB115948@cmpxchg.org> <CAPTztWYgZ=fwOWv-sKs-wXHCqhPbmJm6qkrDqE+_0c1nUwWM3A@mail.gmail.com>
In-Reply-To: <CAPTztWYgZ=fwOWv-sKs-wXHCqhPbmJm6qkrDqE+_0c1nUwWM3A@mail.gmail.com>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 27 Feb 2025 09:56:06 -0800
X-Gm-Features: AQ5f1Joff56kT27_uqAZcjxnL1wjjuEUlKCzhWDshJcD4bEQQTOr128v3euCuF0
Message-ID: <CAPTztWbv+SsK_AtxUw_dTE1FurYe6P6x39gL97o3pvk2_rx4Xw@mail.gmail.com>
Subject: Re: [PATCH v4 10/27] mm/sparse: allow for alternate vmemmap section
 init at boot
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	joao.m.martins@oracle.com, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:32=E2=80=AFAM Frank van der Linden <fvdl@google.c=
om> wrote:
>
> On Thu, Feb 27, 2025 at 9:20=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Thu, Feb 27, 2025 at 08:47:18AM -0800, Frank van der Linden wrote:
> > > On Wed, Feb 26, 2025 at 10:09=E2=80=AFAM Johannes Weiner <hannes@cmpx=
chg.org> wrote:
> > > >
> > > > On Tue, Feb 18, 2025 at 06:16:38PM +0000, Frank van der Linden wrot=
e:
> > > > > @@ -489,6 +489,14 @@ config SPARSEMEM_VMEMMAP
> > > > >         SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optim=
ise
> > > > >         pfn_to_page and page_to_pfn operations.  This is the most
> > > > >         efficient option when sufficient kernel resources are ava=
ilable.
> > > > > +
> > > > > +config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> > > > > +     bool
> > > > > +
> > > > > +config SPARSEMEM_VMEMMAP_PREINIT
> > > > > +     bool "Early init of sparse memory virtual memmap"
> > > > > +     depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP=
_PREINIT
> > > > > +     default y
> > > >
> > > > oldconfig just prompted me on this, but it's not clear to me what i=
t
> > > > does. Not even after skimming the changelog of the patch to be hone=
st.
> > > >
> > > > Can you please add a help text that explains the user-visible effec=
ts
> > > > of the toggle, as well as guidance as to who might care to change i=
t?
> > >
> > > Hi Johannes,
> > >
> > > Thanks for your comment. How's this:
> >
> > Thanks for the quick reply!
> >
> > > Enables subsystems to pre-initialize memmap in their own way,
> > > allowing for memory savings during boot. The HugeTLB code uses
> > > this to initialize memmap for bootmem allocated gigantic hugepages
> > > in a way that is done by HUGETLB_PAGE_OPTIMIZE_VMEMMAP. This
> > > means saving this memory right away, instead of allocating it
> > > first and then freeing it later. Not allocating these pages
> > > at all during boot allows for specifying a bigger number of
> > > hugepages on the kernel commandline on larger systems.
> >
> > That makes sense.
> >
> > But if it's infra code for a hugetlb feature, it should either be
> > something that HUGETLB_PAGE_OPTIMIZE_VMEMMAP pulls in automatically,
> > or at least be a hugetlb-specific option that pulls it in.
> >
> > Keep in mind that not everybody enables HUGETLBFS. In fact, hugetlb is
> > default N. It's moot to ask users whether they want to enable infra
> > code for a feature they aren't using, and default to Y no less. You're
> > regressing innocent bystanders doing this.
>
> The main reason that I added a separate config was:
>
> 1) I could see other subsystems use this.
> 2) The number of section flags is limited, so I wanted to put the one
> I added inside an option instead of always using it.
>
> If especially 2) is not a concern or can be solved differently, I'll
> be happy to remove the option. I don't particularly like having it,
> but I didn't see a better way.
>
> Let me think of a way to clean this up a little, and suggestions are
> welcome, of course.
>
> - Frank

I'll just do:

diff --git a/fs/Kconfig b/fs/Kconfig
index 64d420e3c475..fb9831927a08 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -286,6 +286,7 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
        def_bool HUGETLB_PAGE
        depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
        depends on SPARSEMEM_VMEMMAP
+       select SPARSEMEM_VMEMMAP_PREINIT

 config HUGETLB_PMD_PAGE_TABLE_SHARING
        def_bool HUGETLB_PAGE
diff --git a/mm/Kconfig b/mm/Kconfig
index f984dd928ce7..44b52f8e5296 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -496,7 +496,6 @@ config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
 config SPARSEMEM_VMEMMAP_PREINIT
        bool "Early init of sparse memory virtual memmap"
        depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
-       default y

Does that seem ok? I'll send an mm-unstable follow-up patch.

- Frank

