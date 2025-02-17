Return-Path: <linux-kernel+bounces-518260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE56A38C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A492A1893649
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130B237160;
	Mon, 17 Feb 2025 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+AbFQgW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B537167DAC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820688; cv=none; b=snX1pdwn7VFMFOGH5PWn+FHT5GI+PUXLPy+OG+gJsNTt/3Cb9kXc96vYgBMW8UWnyGtCgPh7kcl4ZdLhaMblLhJtl6tGzwb5d7etNk3vi4MGqus+3PVUImn4UZletZZp4IUgEsNmVZ28KG3dqUZ/sJKXD9GXfG0juzcRvmN6dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820688; c=relaxed/simple;
	bh=x6hERZPuvEmfCqwjlTvlO6TY6uNufA0NZpWRreTwNxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox9z2cLmblv2szkwg3Ru3zKMIvgSJDpd/jlNE6DUbE38O8FpHHMsj3BozABE8aRxEVq0CiXHkMYjX1s1zVP0lYWSAThjVNOk9DVwCcogchjMtMUbPHh6ptTPMywJHfYebuB2vzfvOL0urysFJ47PaqFQaLDdZdGremP8E9GcY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+AbFQgW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739820683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NX4hyJJY5LUfgHjXwSqyXtyBfsL13pYnI0Mr0EfX7HY=;
	b=V+AbFQgWhCQWMgfiMIMxDSdyUxLr4XoC+A67a87pNqVNVGc1W3K+cby3Y3Vj/P7viBQIDn
	mi13R0WTQTOpSAfYhIiVeg7KkwQLDl5Ze8ifyHU081uV7yByBrTDHI6859juKd9ZWTr99C
	LCFGGzUoLdUaLgvCrtigvMjHf4/Ctck=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-GkNigE2qMi6C3_a8TgsnrA-1; Mon, 17 Feb 2025 14:31:22 -0500
X-MC-Unique: GkNigE2qMi6C3_a8TgsnrA-1
X-Mimecast-MFC-AGG-ID: GkNigE2qMi6C3_a8TgsnrA_1739820682
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e02fff66a83so5333003276.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820682; x=1740425482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX4hyJJY5LUfgHjXwSqyXtyBfsL13pYnI0Mr0EfX7HY=;
        b=BHAwgfS5NsJ72i5F89wRzdSzHUxf9m2W2T3l0UzXNqh12ymFRSHrAV5j5G8uQDgVxg
         Zt/mFzfDkP9xswhb4lzc/Remc+1IDevSGd9ZlqX975Skn8UbY7CPrlrm4PpFrHJGRhz5
         eLrLKN5Qk7DHJRQjeo6dGYql7j78q1y66MM8PZ+eUjd43skXEk+kLxiI1grqhwlvj9IW
         HRm/eb4TiJMhBNhmnyxOVLjhu1b5+3RLrtqAJATw4Z46oCv5wiQ0PHOddH6UswGKymQO
         x+nIMFYXG+2J3pzvAtbsrltWdnJp2LBuaVGk5wBuiu6Hu3sP1eY/Ov9yOibGX+g9QB0X
         SC2A==
X-Gm-Message-State: AOJu0Yy5mVnYgK5/37fA+PfIZdDbp60tcFeF39YqoMiHKFbMX/Rvnurt
	l/5hE5VzlqthSPMfLYFm4xmanwOalpkM7h/y6oZ3U3vOvz7RbSDsVUXhuVdGvfcS1yMLXyNIw2b
	clYaW1RvfUELjAeuO/ctSrgFpBZ1G1Tnc1wNTWimO0MvV9RUBbVq2vu4S4Cx0rliGkgbHND/fp4
	Q53cuFAIK4G9AgfU1VK6A2pVUp7DfnVLWBiAC6
X-Gm-Gg: ASbGnctR1B6sPBGhkVoz3FLFUSElVqldkcwhD6DGh2SJq3V4VAc0k4oyP9UsczvEa7E
	+le+fTJbwqCFRmfWTq5e+4YeM4j92UP1qaYE4gG+SCFUGqP/O+Xv6nuz4eD4nMzz6ZagksYGezE
	M=
X-Received: by 2002:a05:6902:3486:b0:e5a:e6eb:d44f with SMTP id 3f1490d57ef6-e5dc900e998mr8015126276.6.1739820682091;
        Mon, 17 Feb 2025 11:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcDB0O4ITkNRkvRI81tFyLe3JFpMxEjsoT5YAFRkQrsXxl/3FtA6FECS+cW2MojiNPdBeyZA0rbetrrR9AAYw=
X-Received: by 2002:a05:6902:3486:b0:e5a:e6eb:d44f with SMTP id
 3f1490d57ef6-e5dc900e998mr8015078276.6.1739820681801; Mon, 17 Feb 2025
 11:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211004054.222931-1-npache@redhat.com> <20250211004054.222931-3-npache@redhat.com>
 <c408c854-134b-4758-931f-e6e3b7a58213@gmail.com>
In-Reply-To: <c408c854-134b-4758-931f-e6e3b7a58213@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 12:30:56 -0700
X-Gm-Features: AWEUYZkouadz-BzwdaTEV-k94b6IIL2-QD_uUEVTO5Cso96xfXhx8WXXPjrCpeI
Message-ID: <CAA1CXcDVdmVEQ+NMC6JZNCVqtkUKLs=L3aQaYtKMSP9N3HAM3w@mail.gmail.com>
Subject: Re: [RFC v2 2/5] mm: document transparent_hugepage=defer usage
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org, 
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, willy@infradead.org, kirill.shutemov@linux.intel.com, 
	david@redhat.com, aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, audra@redhat.com, akpm@linux-foundation.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de, 
	baolin.wang@linux.alibaba.com, corbet@lwn.net, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:04=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 11/02/2025 00:40, Nico Pache wrote:
> > The new transparent_hugepage=3Ddefer option allows for a more conservat=
ive
> > approach to THPs. Document its usage in the transhuge admin-guide.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  Documentation/admin-guide/mm/transhuge.rst | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index dff8d5985f0f..b3b18573bbb4 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -88,8 +88,9 @@ In certain cases when hugepages are enabled system wi=
de, application
> >  may end up allocating more memory resources. An application may mmap a
> >  large region but only touch 1 byte of it, in that case a 2M page might
> >  be allocated instead of a 4k page for no good. This is why it's
> > -possible to disable hugepages system-wide and to only have them inside
> > -MADV_HUGEPAGE madvise regions.
> > +possible to disable hugepages system-wide, only have them inside
> > +MADV_HUGEPAGE madvise regions, or defer them away from the page fault
> > +handler to khugepaged.
> >
> >  Embedded systems should enable hugepages only inside madvise regions
> >  to eliminate any risk of wasting any precious byte of memory and to
> > @@ -99,6 +100,15 @@ Applications that gets a lot of benefit from hugepa=
ges and that don't
> >  risk to lose memory by using hugepages, should use
> >  madvise(MADV_HUGEPAGE) on their critical mmapped regions.
> >
> > +Applications that would like to benefit from THPs but would still like=
 a
> > +more memory conservative approach can choose 'defer'. This avoids
> > +inserting THPs at the page fault handler unless they are MADV_HUGEPAGE=
.
> > +Khugepaged will then scan the mappings for potential collapses into PM=
D
> > +sized pages. Admins using this the 'defer' setting should consider
> > +tweaking khugepaged/max_ptes_none. The current default of 511 may
> > +aggressively collapse your PTEs into PMDs. Lower this value to conserv=
e
> > +more memory (ie. max_ptes_none=3D64).
> > +
>
> maybe remove the "(ie. max_ptes_none=3D64)", its appearing as a recommend=
ation for
> the value, but it might not be optimal for different workloads.
>
> >  .. _thp_sysfs:
> >
> >  sysfs
> > @@ -136,6 +146,7 @@ The top-level setting (for use with "inherit") can =
be set by issuing
> >  one of the following commands::
> >
> >       echo always >/sys/kernel/mm/transparent_hugepage/enabled
> > +     echo defer >/sys/kernel/mm/transparent_hugepage/enabled
> >       echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> >       echo never >/sys/kernel/mm/transparent_hugepage/enabled
> >
> > @@ -274,7 +285,8 @@ of small pages into one large page::
> >  A higher value leads to use additional memory for programs.
> >  A lower value leads to gain less thp performance. Value of
> >  max_ptes_none can waste cpu time very little, you can
> > -ignore it.
> > +ignore it. Consider lowering this value when using
> > +``transparent_hugepage=3Ddefer``
>
> lowering this value even with thp=3Dalways makes sense, as there might be=
 cases
> when pf might not give a THP, but a VMA becomes eligable to scan via khug=
epaged
> later? I would remove this line.

Perhaps I should be more clear or create a different section for it.
The point was that defer was created to prevent internal fragmentation
and leave khugepaged to determine when a THP was "useful" (less
wasteful). But to achieve this less waste we should also not be using
the default.

Ideally I would want to change "always" to ignore max_ptes_none (acts
as max_ptes_none=3D511), and change the max_ptes_none default to 64 or
128. But that's a separate discussion that I didn't want detracting
from these postings.

>
> >
> >  ``max_ptes_swap`` specifies how many pages can be brought in from
> >  swap when collapsing a group of pages into a transparent huge page::
> > @@ -299,8 +311,8 @@ Boot parameters
> >
> >  You can change the sysfs boot time default for the top-level "enabled"
> >  control by passing the parameter ``transparent_hugepage=3Dalways`` or
> > -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever``=
 to the
> > -kernel command line.
> > +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Ddefer``=
 or
> > +``transparent_hugepage=3Dnever`` to the kernel command line.
> >
> >  Alternatively, each supported anonymous THP size can be controlled by
> >  passing ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size=
>[KMG]:<state>``,
>


