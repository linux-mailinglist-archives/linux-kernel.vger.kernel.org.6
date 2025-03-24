Return-Path: <linux-kernel+bounces-574219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A60BFA6E225
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3504A7A5058
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40E536124;
	Mon, 24 Mar 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9Ur08k8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555126463F;
	Mon, 24 Mar 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840320; cv=none; b=unLpOrPkrrnzxJiHK9heLDYvIsjFGWmb7xCnsDnjQdmhOXjifyJl0GdFd/ziDaz8ABPePAYVrM4N+cTN6MLQLiT+IppfWt07qprgt4iHGgwmPNeTO9bCQTzpfUWJAtV5SPfVCC6Pccjo8N/mPm7Wux1M6Dh4nV8LPzTxH4QoALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840320; c=relaxed/simple;
	bh=CvPtVrvhXjNToxQtztbHoatPZJDWgp/53NY9ElBqIcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxSr0z+aA8y6KsnpploqbYQtWuAGH7dxdgGRLOOs2x+gNKtN19B9EAOzki5ubzpiFu0BCrTtYdmPh9CDAY6CNeTZkDUwBpuvKLNfMa4aAFnGE0ZK03g5Cv+CQfKZ9XiAEb8PPiF3y2odjU8eLpTVRgmL5fPDJ8MLxuk0yjI1Qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9Ur08k8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1986DC4CEDD;
	Mon, 24 Mar 2025 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742840319;
	bh=CvPtVrvhXjNToxQtztbHoatPZJDWgp/53NY9ElBqIcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9Ur08k8fMZRkAAhCI2CxUvgZeupcT7GIrwX+p9fSpvfV3Ajb3FbMQVykY2lKtAQe
	 rcSRUeEGnf3/NMWyPQ0qugpcciD3AvqI+F+GniZhsF5a2Ryvk/XXb2nshNIIN+x5cR
	 JYlU5fpj2U7s/S3WdPrOsq+Y0apgFmjxkWh8sXtE1wxekMHk5W9Gzb05gDZS+Vgjfn
	 oho/ytmj/aLCNS2l7wFW8/VHiNHcb8DPqS3CMWOxTVqp1CjPVVhuNpZCOYebRtk4tZ
	 ZLlxV+n2Jb/jAlskHje+GtPWM7FPyNyourFaqabkHce71qm183YbuQjYPsdqdZX51N
	 JlOQHRHBYPBPw==
Date: Mon, 24 Mar 2025 14:18:34 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z-Gh-t9xB21UNGU2@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <20250321134629.GA252045@nvidia.com>
 <Z98Lmo50h5RboFXq@kernel.org>
 <Z+BZOKSpyPA1Pyu+@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+BZOKSpyPA1Pyu+@nvidia.com>

On Sun, Mar 23, 2025 at 03:55:52PM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 22, 2025 at 03:12:26PM -0400, Mike Rapoport wrote:
>  
> > > > +		page->private = order;
> > > 
> > > Can't just set the page order directly? Why use private?
> > 
> > Setting the order means recreating the folio the way prep_compound_page()
> > does. I think it's better to postpone it until the folio is requested. This
> > way it might run after SMP is enabled. 
> 
> I see, that makes sense, but also it could stil use page->order..

But there's no page->order :)
 
> > Besides, when we start allocating
> > folios separately from struct page, initializing it here would be a real
> > issue.
> 
> Yes, but also we wouldn't have page->private to make it work.. Somehow
> anything we want to carry over would have to become encoded in the
> memdesc directly.

This is a problem to solve in 2026 :)

The January update for State of Page [1] talks about 

	reasonable goal to shrink struct page to (approximately): 

	struct page {
	    unsigned long flags;
	    union {
	        struct list_head buddy_list;
	        struct list_head pcp_list;
	        struct {
	            unsigned long memdesc;
	            int _refcount;
	        };
	    };
	    union {
	        unsigned long private;
	        struct {
	            int _folio_mapcount;
	        };
	    };
	};
 
[1] https://lore.kernel.org/linux-mm/Z37pxbkHPbLYnDKn@casper.infradead.org/
 
> Jason

-- 
Sincerely yours,
Mike.

