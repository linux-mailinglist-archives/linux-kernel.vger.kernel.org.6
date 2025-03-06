Return-Path: <linux-kernel+bounces-549704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0775AA5562F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579061896996
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379E26D5A7;
	Thu,  6 Mar 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS5DCNrz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BAC25A652
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288149; cv=none; b=Rx+WeXFMkoMdqe56arT9A3HexgdBCp8dY0QqpMVEzrhYOoyRp/Mbxdef+fSKAkAf+J+09Wr8Obf6ztCQV8ArzHYwGgGiCmkelB/EK/lVrvK4Ag7ymJHgv3MCmhVPSSvi0JRdWZ/SDpqQypb4+iN22thHfTNmx1zKUSg3r+r4jcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288149; c=relaxed/simple;
	bh=g8O+Y+hUe0dXdskx73ule0fZiAy+9KERaeSyIOO+cVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sK3YJ+Zx+7oHBUk7BnRlfHfCza4zyXakcDkQUXb5E1FH15MOHWErJl47euWPU/9ImpkrLbgRpuLmQlSCIN3U4ZxMwUcGs/VDwvyKLzMDJ+L6HfznuqCQPyiqLbwIRArl8uo8hZMfvKIYuhblWaim+2WRjRXWJ1OiDJwr2pqvKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS5DCNrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE94EC4CEE4;
	Thu,  6 Mar 2025 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288148;
	bh=g8O+Y+hUe0dXdskx73ule0fZiAy+9KERaeSyIOO+cVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tS5DCNrz3UQrB6+6NwbFRXMQqxfZ1Hzy3qQNRblgCtzqc7k/fmtB0eFe+cWwX1kRg
	 mMlMzoB5E7Dcp9VLrV/MFhzApUDboOq3HCDrNaZI6nbTyc6LsheE9eViYk4BqY2m96
	 PPrMdPf9LcXJNut36fnGgbbT3O0XucNN9L9LzMekvkJEOcZ7J6CeWq2Hh+gr4rYKbi
	 Z2NW+EqrSftQpY/hGBtR0wW9LuNZoRijBEwz0MaXZcWp89/F1QnCz/6jTfSkrYGunF
	 VONz3BPL24AWZuWAQV0mHkDT24HpN+VADfrUavgsmNF7cjkhkhU9JcyiOusnp816iR
	 CmXGkEKZ6MU5A==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 09/16] mm/memory: split non-tlb flushing part from zap_page_range_single()
Date: Thu,  6 Mar 2025 11:09:04 -0800
Message-ID: <20250306190905.842447-1-sj@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <7rnj5pt7uaftvvf6sqge4vowvcht7n4cqb4hxh3o6kzxtqumqi@p7ugsoqh6iiz>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 6 Mar 2025 10:45:01 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Mar 05, 2025 at 10:16:04AM -0800, SeongJae Park wrote:
> > Some of zap_page_range_single() callers such as [process_]madvise() with
> > MADV_DONEED[_LOCKED] cannot batch tlb flushes because
> > zap_page_range_single() does tlb flushing for each invocation.  Split
> > out core part of zap_page_range_single() except mmu_gather object
> > initialization and gathered tlb entries flushing part for such batched
> > tlb flushing usage.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/memory.c | 36 ++++++++++++++++++++++--------------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index a838c8c44bfd..aadb2844c701 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2011,38 +2011,46 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> >  	mmu_notifier_invalidate_range_end(&range);
> >  }
> >  
> > -/**
> > - * zap_page_range_single - remove user pages in a given range
> > - * @vma: vm_area_struct holding the applicable pages
> > - * @address: starting address of pages to zap
> > - * @size: number of bytes to zap
> > - * @details: details of shared cache invalidation
> > - *
> > - * The range must fit into one VMA.
> > - */
> > -void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> > +static void unmap_vma_single(struct mmu_gather *tlb,
> > +		struct vm_area_struct *vma, unsigned long address,
> >  		unsigned long size, struct zap_details *details)
> >  {
> 
> Please add kerneldoc for this function and explicitly specify that tlb
> can not be NULL. Maybe do that in the patch where you make it
> non-static.

Thank you for this nice suggestion, I will do so in the next version.


Thanks,
SJ

