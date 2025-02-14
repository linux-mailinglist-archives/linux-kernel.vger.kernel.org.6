Return-Path: <linux-kernel+bounces-515563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2E2A36647
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748D3189491A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21F1ACEA7;
	Fri, 14 Feb 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DqzfktW1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE519885F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562036; cv=none; b=Zh8ZR8TCHwfsWUVE9JhSkjJJ2DagOAiwpsXxGxX/GXhNTC/sp0cSK/hpLM66uO5wW8zO8+F1PvvvaLCyLG23enchtisW/3mlUX16ld/PXBFxp2v4kG3zVaTEkJEwbmnCJIvIuaFZR7yUskDdTnsbPuA9qdKmSLTtebSepMkiq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562036; c=relaxed/simple;
	bh=CLNyWRLRR0TxhfQiuWIX8skkWZhoFf9zdlE08L2nypo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpZhPyU0WRkfiSSeW5TnHJ3Ke/xSsIyeXripCVwGCX3CPlHuaSyMZt+FBG3rg0sLK7pVKUlm05N6cTOPK4E6F2H/1obHgMDr5nrxHv/gdYwaq20zbV/jBSOEzg9dXB4pMBE15uyQUsVg2LCUS0W8ozwzymP3QNuCmm8b9zZAGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DqzfktW1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eqiE9L7mCaip0lLhGTwvwdcmTFtEKa29N3mX3PLMV+c=; b=DqzfktW1MqBRQ28nEtrzP5lMHk
	P4TJIxLOiuSNWGSmyFsJr7oJIMHCtUHHtm49no8wgpKxIbXTtqYpLjcXJQMhu7vKnqXyeRZv3VA4/
	o/QLMAjWxrhLLs7RTtOWbVhBxY7V8oR9QGQqLkNizBO9t0l44ZW5L9FgObrp83aIg3e+m6LQ6HVi/
	1bRPEFr49h9uZ/uFu4hJ3dJrdoZh4lBU+ftGY5/89QjHPndV/saRAimh5BVo84KOwVDiE1SWqcGRR
	Nqt1Fa0xi7k8uA/Um+yJiWZEG6waOK6WrulmU4/7EmBT6bq4ZuSx7nG2I1aZORtO8WLKte7lc1/0j
	Zypcd8Xw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tj1Xq-0000000Bxl1-3LJf;
	Fri, 14 Feb 2025 19:40:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D70763002F0; Fri, 14 Feb 2025 20:40:13 +0100 (CET)
Date: Fri, 14 Feb 2025 20:40:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: Re: [PATCH v11 06/12] x86/mm: use INVLPGB for kernel TLB flushes
Message-ID: <20250214194013.GA2198@noisy.programming.kicks-ass.net>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-7-riel@surriel.com>
 <ab55a809-e0d2-4364-84ce-917a40ee299a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab55a809-e0d2-4364-84ce-917a40ee299a@intel.com>

On Fri, Feb 14, 2025 at 10:35:40AM -0800, Dave Hansen wrote:
> On 2/13/25 08:13, Rik van Riel wrote:
> > -	if (info->end == TLB_FLUSH_ALL)
> > +	if (broadcast_kernel_range_flush(info))
> > +		; /* Fall through. */
> > +	else if (info->end == TLB_FLUSH_ALL)
> >  		on_each_cpu(do_flush_tlb_all, NULL, 1);
> >  	else
> >  		on_each_cpu(do_kernel_range_flush, info, 1);
> 
> We've got to find a better name for broadcast_kernel_range_flush().
> Because IPIs are broadcast too. The naming makes it confusing. Why would
> be broadcast, and then start trying IPIs that are also broadcast?

IIRC the more general name is indeed broadcast tlbi; as in other
architectures use this naming to mean this very thing too.

But yes, I see the confusion, but I don't think changing the naming
really helps a lot here :-/

