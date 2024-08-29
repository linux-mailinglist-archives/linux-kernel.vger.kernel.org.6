Return-Path: <linux-kernel+bounces-306310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DFA963D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE101F2136C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B5F184549;
	Thu, 29 Aug 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BckY9+6b"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D31487D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916668; cv=none; b=jaQIWmuSdc5KgC0WJ2fTQCepNx0S8sqS/zu7XA69PfxddBdV9sYhichRwXg/b7NJ5l4PqHXl2bbKbmppZ+R1jf7Z/dd76wIhLTZn1VZmKU3Vq7sT+vDbUQzXFsJpnrF1dutM/HNt7CS9EaSr2lWDaxEpeFBu5gXZuS2LJ+Jj5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916668; c=relaxed/simple;
	bh=mMOJIMocwyAMu1GNRjMOw6CMcu5kZ7sLkVWXH9K5LOM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EfjuQjjG5xXgiICyvu6Kw8rrP3/X2a8m5xQnN63JC5YjX8ilG/DMTalWCTAlM7GkIIWMg0Vuz9eTuPxYeZjNISgmZyIEyTA8CzPvY3h5z4V8Hd8i5KlEo4TIAr+8nZnmbFgwedkMQvrNQD5McMr/xVYG+UMR/0bGZejX/mEbqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BckY9+6b; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724916664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzy7EyrlX+BzOPBD0uMQ8N6l4HwDeloVfYpRJzPTRgE=;
	b=BckY9+6bvyxbg2ieSc5wtrZHrNS+aAr5eMJ9rmRtFrw5YEvqcz/MKiyV8DGGwUFsh04SAK
	4/4S9HrxdWnaS/9Eo4dclcCjs/j+JbU1OscQ+AaFfC/EKe+gEMbbNqr9PKYcYIiaMcm51E
	2YSQmc3pLSUSL4niBe3OfUYw629o6gs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 06/14] mm: handle_pte_fault() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <5acabedfae7ded01b075960b4a91f2e15b4d76b5.1724310149.git.zhengqi.arch@bytedance.com>
Date: Thu, 29 Aug 2024 15:30:26 +0800
Cc: David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>,
 vishal.moola@gmail.com,
 peterx@redhat.com,
 ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F8142C5-9579-4F5A-B654-62E1E3183F0E@linux.dev>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <5acabedfae7ded01b075960b4a91f2e15b4d76b5.1724310149.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 22, 2024, at 15:13, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
> In handle_pte_fault(), we may modify the vmf->pte after acquiring the
> vmf->ptl, so convert it to using pte_offset_map_rw_nolock(). But since =
we
> will do the pte_same() check, so there is no need to get pmdval to do
> pmd_same() check, just pass a dummy variable to it.
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

A nit below.

> ---
> mm/memory.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/memory.c b/mm/memory.c
> index 93c0c25433d02..7b6071a0e21e2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5499,14 +5499,22 @@ static vm_fault_t handle_pte_fault(struct =
vm_fault *vmf)
> 		vmf->pte =3D NULL;
> 		vmf->flags &=3D ~FAULT_FLAG_ORIG_PTE_VALID;
> 	} else {
> + 		pmd_t dummy_pmdval;
> +
> 	/*
> 	 * A regular pmd is established and it can't morph into a huge
> 	 * pmd by anon khugepaged, since that takes mmap_lock in write
> 	 * mode; but shmem or file collapse to THP could still morph
> 	 * it into a huge pmd: just retry later if so.
> +	 *
> +	 * Use the maywrite version to indicate that vmf->pte will be

Not "will be", should be "may be".

> +	 * modified, but since we will use pte_same() to detect the
> +	 * change of the pte entry, there is no need to get pmdval, so
> +	 * just pass a dummy variable to it.
> 	 */
> - 	vmf->pte =3D pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
> -					 vmf->address, &vmf->ptl);
> +	vmf->pte =3D pte_offset_map_rw_nolock(vmf->vma->vm_mm, vmf->pmd,
> +					    vmf->address, &dummy_pmdval,
> +					    &vmf->ptl);
> 	if (unlikely(!vmf->pte))
> 		return 0;
> 	vmf->orig_pte =3D ptep_get_lockless(vmf->pte);
> --=20
> 2.20.1
>=20


