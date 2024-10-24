Return-Path: <linux-kernel+bounces-379929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4430D9AE5F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1D61F25D85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC41D89E3;
	Thu, 24 Oct 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB7YmSqa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519251B392A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776069; cv=none; b=o81lOaX2wBFjX4rkzMJUTop52x2zAZD0M/M96+T/CMESj98pkJhilvDHL/Y7MTWePla8dG6dX9JPH2Ej+mFqrmoegGWOtUUl3q2ZTJgz42+K2YLlxuY/bcVgUGO8OrTd8rfKiRLs4bLeB2mDeKVWTCNsAYwjJzouH5yUEOloJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776069; c=relaxed/simple;
	bh=e4IrghhwsHkxR0OyKbORiHFfT4EMU5qRE0ljkJ5jEes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBx+yagVNP9q6zsSlUQprFXM31QexuDlFHL6j2gqXoaj1WE85pTVzAREg3BriW9UTfvJP8Vq1CQKP0eriH+CJHUGMtUMUX9QKbpjDHCG4YaksfsDHFFej4YGPic9o1ANz5TGQ32aSD+/aj2vMDJTOb4kkkoNB2ElGHjUxKZ5khQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB7YmSqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0753FC4CEC7;
	Thu, 24 Oct 2024 13:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729776068;
	bh=e4IrghhwsHkxR0OyKbORiHFfT4EMU5qRE0ljkJ5jEes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vB7YmSqaDXohGnpgcjhdOkXb3IFfDJR5uzxgtSmMIcdsuyMCeJDK2ZtMmSgRwUZSz
	 ML+8qCaCTydwfvT8/Lrbm3FCRd+cGzNoe9DDZw+vRKew7kHzuU0I/1EDQkRfL/DZ/M
	 900SIJ5ZBkZEMXEw8sZj8bbOOOuv47hjWjDbe38Getqzdcx6vqGqEswr3tttey2L4f
	 W+wa9JKtfMBOFgMhupzVvaa3ZoLvS0JlvrEDGlpZOojTmQ009+iMhEfjqSvCa5rOB2
	 kY1kaz/WuIS4LbV98R93J4aTDHVFoFlMRTn5HunXmp6+0mwC21jzDSyoxKbRvtVb4+
	 +iZbwxa2sIoBw==
Date: Thu, 24 Oct 2024 14:21:02 +0100
From: Will Deacon <will@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
	Catalin Marinas <catalin.marinas@arm.com>, david@redhat.com,
	hughd@google.com, willy@infradead.org, mgorman@suse.de,
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 5/7] mm: pgtable: try to reclaim empty PTE page in
 madvise(MADV_DONTNEED)
Message-ID: <20241024132101.GJ30704@willie-the-truck>
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
 <6c7fe15b0434a08a287c400869f9ba434e1a8fa3.1729157502.git.zhengqi.arch@bytedance.com>
 <CAG48ez3MLMXZvkbPGZ4He2+tnOSHYxA68Sa1Hd_70-3a8K++=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3MLMXZvkbPGZ4He2+tnOSHYxA68Sa1Hd_70-3a8K++=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 17, 2024 at 08:43:43PM +0200, Jann Horn wrote:
> +arm64 maintainers in case they have opinions on the break-before-make aspects

Thanks, Jann.

> On Thu, Oct 17, 2024 at 11:48 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > +void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
> > +                    struct mmu_gather *tlb)
> > +{
> > +       pmd_t pmdval;
> > +       spinlock_t *pml, *ptl;
> > +       pte_t *start_pte, *pte;
> > +       int i;
> > +
> > +       start_pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &ptl);
> > +       if (!start_pte)
> > +               return;
> > +
> > +       pml = pmd_lock(mm, pmd);
> > +       if (ptl != pml)
> > +               spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> > +
> > +       if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd))))
> > +               goto out_ptl;
> > +
> > +       /* Check if it is empty PTE page */
> > +       for (i = 0, pte = start_pte; i < PTRS_PER_PTE; i++, pte++) {
> > +               if (!pte_none(ptep_get(pte)))
> > +                       goto out_ptl;
> > +       }
> > +       pte_unmap(start_pte);
> > +
> > +       pmd_clear(pmd);
> > +
> > +       if (ptl != pml)
> > +               spin_unlock(ptl);
> > +       spin_unlock(pml);
> 
> At this point, you have cleared the PMD and dropped the locks
> protecting against concurrency, but have not yet done a TLB flush. If
> another thread concurrently repopulates the PMD at this point, can we
> get incoherent TLB state in a way that violates the arm64
> break-before-make rule?

Sounds like it, yes, unless there's something that constrains the new
PMD value to be some function of what it was in the first place?

Will

