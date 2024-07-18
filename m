Return-Path: <linux-kernel+bounces-256837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB193710F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72CBB21591
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4F0146A63;
	Thu, 18 Jul 2024 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MtDJgCeA"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D861146599
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721344797; cv=none; b=QpuvlEmlC1h60WnijbinitjWoLV8TRCjPlDs57b6hz/SohttfFOU2AHHpJ6k4K66+4xXRPsh9OCSF8lcPHdKunThS1U7GodmkkMl1fX6e04BVAgbAlDHZNojUSu7iZqRa6mLMR6whuQOFXBSsPX5aFKEW9hZhi1FpcT74/99sEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721344797; c=relaxed/simple;
	bh=/8T4PAISqcESgB5019gqovV4B7u+0FLU2jNEhDiyOuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtragcD80FPCbVpKEPRdKC+DfQT1FecnlNU0+6800yEqFnc6PFSYBvd2shBm7cz9vvBBQfZeRqH39Dyy4c6ugm5id/I7HRuUgEKF2uAzBy2gRQKsyCscD8Z7ZfLFTMazHLKs7CaTNSI0zwb3iYFeal0ohrFMkeMGUCRZaz5MTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MtDJgCeA; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: pasha.tatashin@soleen.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721344793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOtxshDQKvEp2cqRUuCoshYKYABr2QosoOtr17LvFVU=;
	b=MtDJgCeAW0oSsSYJNnn4q4Gf1asfEn1tIFvjuIol1BkJT74qI6ix1bkMpy3bmOistNC1pn
	oMFryEg1mlkEOgmFBnQ0sD0GawsTJDfiCJDlZzju81Edly7s15Xce/QfWYubCc8TFuirUz
	xaJTBxmJKD2Ul0eRNS250pUKYSJePMM=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: jpoimboe@kernel.org
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: peterz@infradead.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: surenb@google.com
X-Envelope-To: lizhijian@fujitsu.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: ziy@nvidia.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
Date: Thu, 18 Jul 2024 16:19:44 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
Message-ID: <dz2ryasq3bbshlayah4dja3esvpwu5hzftgaapzbmjf42n7gzk@qs4wfnuuixtu>
References: <20240530170259.852088-1-pasha.tatashin@soleen.com>
 <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
 <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com>
 <i66bzhgnbql7bvuteqttpijml3ze3nngxapv32k7paqv25c5th@wd37oaastkvz>
 <usfcwyq76np42s5b2rpzgjrvvtdpwakaum7ayy4zumaa73ke3u@txbukb2464bl>
 <CA+CK2bBm4COW+jZifyjFEyJNcW1cAXWYzCpuO81jL3YziKxfRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBm4COW+jZifyjFEyJNcW1cAXWYzCpuO81jL3YziKxfRw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Pasha,

On Wed, Jul 17, 2024 at 12:50:00PM GMT, Pasha Tatashin wrote:
> On Wed, Jun 12, 2024 at 2:50 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
[...]
> > >
> > > One more question: Is there any concern in making
> > > CONFIG_DEBUG_STACK_USAGE not a debug feature i.e. enable in default
> > > kernels instead of just debug kernels?
> 
> We enabled it in Google ProdKernel. There is some overhead when
> threads are exiting, because we are looking for the first non-zero
> byte, but that is minimal. We haven't observed any performance impact
> on our fleet.
>

So, you would support making CONFIG_DEBUG_STACK_USAGE enabled by
default, right?

