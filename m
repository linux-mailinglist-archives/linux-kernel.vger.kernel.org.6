Return-Path: <linux-kernel+bounces-520575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A018AA3ABAE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C7016A27D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640281D6DB1;
	Tue, 18 Feb 2025 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJ43UKLF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84E1C5486
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917856; cv=none; b=qeUjkoYmUa+UqmAC+r+puQbRnR7O1soYrkfJ24ZKsdCNYVL7Zte7BB+qGgz3/0cZ71BzLBDf28HQO0BPXxoFWDoG2c+VIWCcujeXlxzoV0E/gqg4yxgvt0gKRZ0qY6ID9zLCzMlohSMAksFv8N7pyPR+4DbzbtXuwBSFySZSC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917856; c=relaxed/simple;
	bh=vTKkGR8ZdZGqAkzB2lWAsSnBuVOllK+eX7+5jzIfI/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbE/m0DzbnaoaQCSq/vGh5rwokqmmBf4Z7+LoeEJIznAh7pwJsjDv7VS651J8gWbnli93+q3fFBQOE7zLGWPYyDmS4lJdzsX8/mLi3U4VQKah0fsXQmcc2SJ0RWa6QSmXModqUjhPr4Urb89+kK9YjmrBM9Xng3YD4NNeSFrxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJ43UKLF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739917853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++ZZtSfrzrR+I5/WlbD0caKDizF6oFHBUKKBB5cjYzQ=;
	b=TJ43UKLFyr3xI1vFZ9xFR5zmg7kYaQns6U538d5WVgzyWKo62URgFNkApGByICzzoUNCC/
	znTrLxbF6fG5/BgU6k9tkarJq635tYNEyEZCNhooPuwHDfmD3hbu4fLm61GEsxW98uguTp
	lb7hH+5rVDnElBqbo268am8I8gUkT3I=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ZNQ5f8JYMJSLJEqr2M-btA-1; Tue, 18 Feb 2025 17:30:52 -0500
X-MC-Unique: ZNQ5f8JYMJSLJEqr2M-btA-1
X-Mimecast-MFC-AGG-ID: ZNQ5f8JYMJSLJEqr2M-btA_1739917852
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e53bf9e60e4so6276759276.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739917852; x=1740522652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++ZZtSfrzrR+I5/WlbD0caKDizF6oFHBUKKBB5cjYzQ=;
        b=TGzhCdrrZsLCXyssouiBGuBOTq1z3W97X+TpnWa50xFwprQxtbQP8PEjBEWu93N/iF
         UjstPWZ1HttE2wQ6b4ctqZnbrmRfkGgTz8bLE6/68u8tBbsFMa+DdakF1DcQ9BFP//uI
         oprdqgtjmcsy0Oqr3v6wxedIHgjWCDw2s5W17XOt+uuKOM+ohxJ6G8LyEIFcr9VRmgjc
         v9kkVGpPdatvIDMwvBdcTbUciL5gWUtyDcvsN2dY0qOrcAfusSWWUMByCWe6DoRAQXzj
         +pCQFBzwtNJ/6U8wf1l2S512I6+PNe3SDLtPpn8tpPMtYvNL360/nInxcDgRs90xf8p2
         d60g==
X-Gm-Message-State: AOJu0YzHSk176xPt5xpgUEeyesuK16l4Z/D9AbDJruY8oM9zmmvmJAgW
	m9ld3kySXmMaGTEe8YNP9t9hpmDVQ3OmyNYjGGrqNWxkf+L2Z2MfLPknbFtJKntHvsAUMqLU01r
	TqADXss18nNKxUfdxHtRYE1xYOABqm9ArPmfXHhBc1blH1aulgt2UcEgtOvcmGhjbWLrhly3UFw
	5gJaMElP59+J5ZNd+hrOywcfFO2Yd3TKIgnAFS
X-Gm-Gg: ASbGncsUIlsxJj/TCftVmswb0ImgQJ/+oPrpy/H48cbvk0EdfRR7mK/4TbuZhW17NUJ
	KtPIqGqn2pkFZdb/XKewe76oAW9KsO31tLyg73e/E5IiAk7ylw29xV/I8l+IQy6wd/ZRAnNNXos
	E=
X-Received: by 2002:a05:6902:12ce:b0:e57:4167:477d with SMTP id 3f1490d57ef6-e5e0a07f57fmr1423373276.2.1739917852062;
        Tue, 18 Feb 2025 14:30:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXOggV0aGa9dhi71CcQznSGrcLr72fkVHEEod12dqEeXtyy//O3EWuT2LzXWxrsj2Oqd1NZ6yma04BBYypOMU=
X-Received: by 2002:a05:6902:12ce:b0:e57:4167:477d with SMTP id
 3f1490d57ef6-e5e0a07f57fmr1423292276.2.1739917851593; Tue, 18 Feb 2025
 14:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <8a37f99b-f207-4688-bc90-7f8e6900e29d@arm.com>
In-Reply-To: <8a37f99b-f207-4688-bc90-7f8e6900e29d@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 18 Feb 2025 15:30:25 -0700
X-Gm-Features: AWEUYZnX2s298UT6JFBa2HNyK13qmxR8KP3hyR_dufgpxOdwX7jib87hqYzN1Ro
Message-ID: <CAA1CXcDHCesahmZs21rVP=xai9C=-TpK_7=_8DMqxGJRJzyKSA@mail.gmail.com>
Subject: Re: [RFC v2 0/9] khugepaged: mTHP support
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, willy@infradead.org, kirill.shutemov@linux.intel.com, 
	david@redhat.com, aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, usamaarif642@gmail.com, audra@redhat.com, 
	akpm@linux-foundation.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 9:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/02/2025 00:30, Nico Pache wrote:
> > The following series provides khugepaged and madvise collapse with the
> > capability to collapse regions to mTHPs.
> >
> > To achieve this we generalize the khugepaged functions to no longer dep=
end
> > on PMD_ORDER. Then during the PMD scan, we keep track of chunks of page=
s
> > (defined by MTHP_MIN_ORDER) that are utilized. This info is tracked
> > using a bitmap. After the PMD scan is done, we do binary recursion on t=
he
> > bitmap to find the optimal mTHP sizes for the PMD range. The restrictio=
n
> > on max_ptes_none is removed during the scan, to make sure we account fo=
r
> > the whole PMD range. max_ptes_none will be scaled by the attempted coll=
apse
> > order to determine how full a THP must be to be eligible. If a mTHP col=
lapse
> > is attempted, but contains swapped out, or shared pages, we dont perfor=
m the
> > collapse.
> >
> > With the default max_ptes_none=3D511, the code should keep its most of =
its
> > original behavior. To exercise mTHP collapse we need to set max_ptes_no=
ne<=3D255.
> > With max_ptes_none > HPAGE_PMD_NR/2 you will experience collapse "creep=
" and
>
> nit: I think you mean "max_ptes_none >=3D HPAGE_PMD_NR/2" (greater or *eq=
ual*)?
> This is making my head hurt, but I *think* I agree with you that if
> max_ptes_none is less than half of the number of ptes in a pmd, then cree=
p
> doesn't happen.
Haha yea the compressed bitmap does not make the math super easy to
follow, but i'm glad we arrived at the same conclusion :)
>
> To make sure I've understood;
>
>  - to collapse to 16K, you would need >=3D3 out of 4 PTEs to be present
>  - to collapse to 32K, you would need >=3D5 out of 8 PTEs to be present
>  - to collapse to 64K, you would need >=3D9 out of 16 PTEs to be present
>  - ...
>
> So if we start with 3 present PTEs in a 16K area, we collapse to 16K and =
now
> have 4 PTEs in a 32K area which is insufficient to collapse to 32K.
>
> Sounds good to me!
Great! Another easy way to think about it is, with max_ptes_none =3D
HPAGE_PMD_NR/2, a collapse will double the size, and we only need half
for it to collapse again. Each size is 2x the last, so if we hit one
collapse, it will be eligible again next round.
>
> > constantly promote mTHPs to the next available size.
> >
> > Patch 1:     Some refactoring to combine madvise_collapse and khugepage=
d
> > Patch 2:     Refactor/rename hpage_collapse
> > Patch 3-5:   Generalize khugepaged functions for arbitrary orders
> > Patch 6-9:   The mTHP patches
> >
> > ---------
> >  Testing
> > ---------
> > - Built for x86_64, aarch64, ppc64le, and s390x
> > - selftests mm
> > - I created a test script that I used to push khugepaged to its limits =
while
> >    monitoring a number of stats and tracepoints. The code is available
> >    here[1] (Run in legacy mode for these changes and set mthp sizes to =
inherit)
> >    The summary from my testings was that there was no significant regre=
ssion
> >    noticed through this test. In some cases my changes had better colla=
pse
> >    latencies, and was able to scan more pages in the same amount of tim=
e/work,
> >    but for the most part the results were consistant.
> > - redis testing. I tested these changes along with my defer changes
> >   (see followup post for more details).
> > - some basic testing on 64k page size.
> > - lots of general use. These changes have been running in my VM for som=
e time.
> >
> > Changes since V1 [2]:
> > - Minor bug fixes discovered during review and testing
> > - removed dynamic allocations for bitmaps, and made them stack based
> > - Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
> > - Updated trace events to include collapsing order info.
> > - Scaled max_ptes_none by order rather than scaling to a 0-100 scale.
> > - No longer require a chunk to be fully utilized before setting the bit=
. Use
> >    the same max_ptes_none scaling principle to achieve this.
> > - Skip mTHP collapse that requires swapin or shared handling. This help=
s prevent
> >    some of the "creep" that was discovered in v1.
> >
> > [1] - https://gitlab.com/npache/khugepaged_mthp_test
> > [2] - https://lore.kernel.org/lkml/20250108233128.14484-1-npache@redhat=
.com/
> >
> > Nico Pache (9):
> >   introduce khugepaged_collapse_single_pmd to unify khugepaged and
> >     madvise_collapse
> >   khugepaged: rename hpage_collapse_* to khugepaged_*
> >   khugepaged: generalize hugepage_vma_revalidate for mTHP support
> >   khugepaged: generalize alloc_charge_folio for mTHP support
> >   khugepaged: generalize __collapse_huge_page_* for mTHP support
> >   khugepaged: introduce khugepaged_scan_bitmap for mTHP support
> >   khugepaged: add mTHP support
> >   khugepaged: improve tracepoints for mTHP orders
> >   khugepaged: skip collapsing mTHP to smaller orders
> >
> >  include/linux/khugepaged.h         |   4 +
> >  include/trace/events/huge_memory.h |  34 ++-
> >  mm/khugepaged.c                    | 422 +++++++++++++++++++----------
> >  3 files changed, 306 insertions(+), 154 deletions(-)
> >
>


