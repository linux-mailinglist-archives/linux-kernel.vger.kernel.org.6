Return-Path: <linux-kernel+bounces-515966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A1A36B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129B81711FD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4581B7BAEC;
	Sat, 15 Feb 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W7aDMuB1"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7CDDA8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585350; cv=none; b=fexkHvEhA3hu5EkwuiGdmXDNse9FdtnEzjFQSdgZc2YXGW4QeVRuOqkKMRAscO0uiV+uxJBYhPCv9u+vmurtmsYp5q26+12rZZsaWYVcWhHUfAKemPGFbCchUKq+c6bveH67CXKdPXu5glUUl5zZuyMRh959+CuRh8EtUwcCfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585350; c=relaxed/simple;
	bh=E4OYdfaIiYC8Qjp1Y6DzTMvKsgVQ7c7a1Hru7VLrKWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaF0s6WYibt4OqvQOrlY5Nz4JZs5NpniH37evBV8igJzJGevxF/n7svWNH3AlLqLV/2P5nrZXlPUIJo4PQp8KegemMMBxHIJVlhOtGdUEyjmoIsATIVOVl3cGQp+nw+OV7RQI4ttfNvLHwNhrg0jS/My1KCZYN3wuAfUZdeu1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W7aDMuB1; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 15 Feb 2025 02:08:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739585346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xo2P5E0/M5KD94XnehsexSIOx+TwWuT6jmlBnTmKr1U=;
	b=W7aDMuB1A2dThwnDfWQmN/GuOK5BptsezXaBoE3Sths+AlpeoMgxTO8F/FVWJ5jKkCGS9D
	nifQjL5HdpIVWVXzjPBRSHuuxibZgglj2rNZQTZ1ISRJpDQkBygg3/DbVgsClFgnTiDJVI
	HtUpw2eZphXN1fG7hYfobPnWAi9sWgY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: Re: [PATCH v11 06/12] x86/mm: use INVLPGB for kernel TLB flushes
Message-ID: <Z6_3O75TzANMFrKN@google.com>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-7-riel@surriel.com>
 <ab55a809-e0d2-4364-84ce-917a40ee299a@intel.com>
 <20250214194013.GA2198@noisy.programming.kicks-ass.net>
 <c42c314c-3c1b-4e4a-803a-ecf31685d4cc@intel.com>
 <3e26626aa1c01aaa5d1e7b42d3ffbd632c3264fb.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e26626aa1c01aaa5d1e7b42d3ffbd632c3264fb.camel@surriel.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 14, 2025 at 08:25:51PM -0500, Rik van Riel wrote:
> On Fri, 2025-02-14 at 11:55 -0800, Dave Hansen wrote:
> > 
> > Fair enough. If we don't have a better name, we can at least do:
> > 
> > 	if (new_bad_name()) {
> > 		new_thing();
> > 	} else {
> > 		old_thing();
> > 	}
> > 
> > My real heartburn is with:
> > 
> > 	if (new_bad_name()) {
> > 		new_thing();
> > 	} else if (need_thing_1()) {
> > 		old_thing1();
> > 	} else {
> > 		old_thing2();
> > 	}
> > 
> > Where new and old are logically squished together.
> > 
> Do we want to group this code by history, or
> by function?
> 
> I would argue that new_thing() and old_thing1()
> are closer to each other functionally (they both
> do remote TLB invalidation) than they are to 
> old_thing2(), which does local-only invalidation.
> 
> I can organize the code however people want,
> but I would like a second opinion on this idea :)

IIUC the discussion is about:

	if (broadcast_kernel_range_flush(info))
       		; /* Fall through. */
	else if (info->end == TLB_FLUSH_ALL)
		on_each_cpu(do_flush_tlb_all, NULL, 1);
	else
		on_each_cpu(do_kernel_range_flush, info, 1);

In this case I agree with Dave. old_thing1() and old_thing2() are both
sending IPIs, the difference is that old_thing1() is doing a full flush
while old_thing2() is doing a range flush. Not sure why you mentioned
that old_thing2() does local invalidation.

broadcast_kernel_range_flush() also decides between full and range
flushes internally. So the main difference between 'new' and 'old' here
is using the broadcast flush vs the IPI flush.

So I think what Dave wants (and I agree) is:
	if (!broadcast_kernel_range_flush(info))
		ipi_kernel_range_flush(info)

Where ipi_kernel_range_flush() contains old_thing1() and oldthing2().

> -- 
> All Rights Reversed.
> 

