Return-Path: <linux-kernel+bounces-267691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B3941469
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802B5285276
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EF91A254E;
	Tue, 30 Jul 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APhoxjyX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031921974FE;
	Tue, 30 Jul 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349948; cv=none; b=WSPfWFeQ1K6qEJ6NKNlM6pHuR7GJbb1r584mrndXLiqgjvn/P2vCfNR/gAb5KYToSVSdvxFdLAFFMT0ou6eLA1cOAlyxALdDrK2w5z3AtN+22ukm2uhf00+eC3FXb+WCNcPG/2Hbc7+TA8k+1K3m2xpuNCDPmjypDzIe/19F8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349948; c=relaxed/simple;
	bh=+j4R5RoszZQrj25E4WFcSoCqS39W7IfpQDj+BrchEnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs8zMY5IxBekh9PHuodxuQDqiZnINHATM0NQZvR/LaGvpGdIPoto7kgdmFjviWksS32b2CPHdSTYgvT/Iq956R/ONFQ6qGRgrV9BqZds+qJ1gdjmam/xSNiRvkshMJv2WRpcB5Y0UmbLWzPUne/L0yHSS03Q0lcNwHrHuxdSnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APhoxjyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04DBC32782;
	Tue, 30 Jul 2024 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722349947;
	bh=+j4R5RoszZQrj25E4WFcSoCqS39W7IfpQDj+BrchEnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APhoxjyXBcQaSHoDLpSBG95xMCA8HtFHOS/tMTPaW8kEhRrD9GiLM6/G3ZP4zlDVc
	 5mL25FjCiET/oFIcsvSubRCN1HTeMVB9RtO9XvF9XhbhhLGDB78bwwz2KstOeATE2I
	 zOqdUgcsPeP+E7NSs1KPTXZmh7b6FhXjfGxTPniTC5M9q/YRHx7hg2fV6fsw8yk3Qh
	 d/FGM9S7x/iROKN26sK3St5itFXVIhRCCiWUe3wMQCLhIJwiBb9C5JDyIgVVu2fXH5
	 uYBU/VdInqGpfU1CoAVaXcZGLkRmT59XD8Qvv//yJcvimDPmGSw4PbJLpuWPQ1Cigi
	 QRki53DuJDYIg==
Date: Tue, 30 Jul 2024 16:32:19 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mhocko@kernel.org, mpe@ellerman.id.au,
	chandan.babu@oracle.com, christian.koenig@amd.com, maz@kernel.org,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>,
	kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <Zqj5cyBCSu8bxsLJ@pollux>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-2-dakr@kernel.org>
 <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz>
 <ZqQBjjtPXeErPsva@cassiopeiae>
 <ZqfomPVr7PadY8Et@cassiopeiae>
 <ZqhDXkFNaN_Cx11e@cassiopeiae>
 <44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz>
 <ZqjnR4Wxzf-ciUGW@pollux>
 <d0234a41-811e-40a7-b239-e51b35862adc@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0234a41-811e-40a7-b239-e51b35862adc@suse.cz>

On Tue, Jul 30, 2024 at 03:58:25PM +0200, Vlastimil Babka wrote:
> On 7/30/24 3:14 PM, Danilo Krummrich wrote:
> > On Tue, Jul 30, 2024 at 02:15:34PM +0200, Vlastimil Babka wrote:
> >> On 7/30/24 3:35 AM, Danilo Krummrich wrote:
> >>> On Mon, Jul 29, 2024 at 09:08:16PM +0200, Danilo Krummrich wrote:
> >>>> On Fri, Jul 26, 2024 at 10:05:47PM +0200, Danilo Krummrich wrote:
> >>>>> On Fri, Jul 26, 2024 at 04:37:43PM +0200, Vlastimil Babka wrote:
> >>>>>> On 7/22/24 6:29 PM, Danilo Krummrich wrote:
> >>>>>>> Implement vrealloc() analogous to krealloc().
> >>>>>>>
> >>>>>>> Currently, krealloc() requires the caller to pass the size of the
> >>>>>>> previous memory allocation, which, instead, should be self-contained.
> >>>>>>>
> >>>>>>> We attempt to fix this in a subsequent patch which, in order to do so,
> >>>>>>> requires vrealloc().
> >>>>>>>
> >>>>>>> Besides that, we need realloc() functions for kernel allocators in Rust
> >>>>>>> too. With `Vec` or `KVec` respectively, potentially growing (and
> >>>>>>> shrinking) data structures are rather common.
> >>>>>>>
> >>>>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >>>>>>
> >>>>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>>>>>
> >>>>>>> --- a/mm/vmalloc.c
> >>>>>>> +++ b/mm/vmalloc.c
> >>>>>>> @@ -4037,6 +4037,65 @@ void *vzalloc_node_noprof(unsigned long size, int node)
> >>>>>>>  }
> >>>>>>>  EXPORT_SYMBOL(vzalloc_node_noprof);
> >>>>>>>  
> >>>>>>> +/**
> >>>>>>> + * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> >>>>>>> + * @p: object to reallocate memory for
> >>>>>>> + * @size: the size to reallocate
> >>>>>>> + * @flags: the flags for the page level allocator
> >>>>>>> + *
> >>>>>>> + * The contents of the object pointed to are preserved up to the lesser of the
> >>>>>>> + * new and old size (__GFP_ZERO flag is effectively ignored).
> >>>>>>
> >>>>>> Well, technically not correct as we don't shrink. Get 8 pages, kvrealloc to
> >>>>>> 4 pages, kvrealloc back to 8 and the last 4 are not zeroed. But it's not
> >>>>>> new, kvrealloc() did the same before patch 2/2.
> >>>>>
> >>>>> Taking it (too) literal, it's not wrong. The contents of the object pointed to
> >>>>> are indeed preserved up to the lesser of the new and old size. It's just that
> >>>>> the rest may be "preserved" as well.
> >>>>>
> >>>>> I work on implementing shrink and grow for vrealloc(). In the meantime I think
> >>>>> we could probably just memset() spare memory to zero.
> >>>>
> >>>> Probably, this was a bad idea. Even with shrinking implemented we'd need to
> >>>> memset() potential spare memory of the last page to zero, when new_size <
> >>>> old_size.
> >>>>
> >>>> Analogously, the same would be true for krealloc() buckets. That's probably not
> >>>> worth it.
> >>
> >> I think it could remove unexpected bad surprises with the API so why not
> >> do it.
> > 
> > We'd either need to do it *every* time we shrink an allocation on spec, or we
> > only do it when shrinking with __GFP_ZERO flag set, which might be a bit
> > counter-intuitive.
> 
> I don't think it is that much counterintuitive.
> 
> > If we do it, I'd probably vote for the latter semantics. While it sounds more
> > error prone, it's less wasteful and enough to cover the most common case where
> > the actual *realloc() call is always with the same parameters, but a changing
> > size.
> 
> Yeah. Or with hardening enabled (init_on_alloc) it could be done always.
> 

Ok, sounds good. Will go with that then.

