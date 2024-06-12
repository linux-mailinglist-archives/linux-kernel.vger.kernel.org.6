Return-Path: <linux-kernel+bounces-212119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A39F905B76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC481F23BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3C47F4B;
	Wed, 12 Jun 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cIShlX4O"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E892F3B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218225; cv=none; b=BO/jfpnswGJUNRXMKYwCDs8vxJLN/L6CFRNz3L2cqv2G4whnVwBQ8ITQ8PVPASTJCYATXDk3k5uvcthLyfUYYOS4WESKYn/qf4gPlnEyvY2IuZxRqH1nRXc4iIJYfvc1hkKQsm3I2CXEGAAFtXDhhCfWWhWAO036QmT8JTmt62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218225; c=relaxed/simple;
	bh=+DpokvkbGTafsw4G2Qe3lR3ISLbnIvGu/+tYnnQAXlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/xzHJjX3ctzhTMx0blRPao1QVfWMxsKRPk7HqmpZry6iW0PPKj/UbkSy4AANRpdrGn62Psd1T9E0kmJZ2cvjdRxu8enNDpkXucgl/D0/qW1bu2xXg3ZpEDQ9yHsrXglVJgmJVHgmD1cAI/T0HsmGK58Tlfla3YSbpe5NYwUWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cIShlX4O; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: pasha.tatashin@soleen.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718218220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAHOcp7dGNkmdIJVuztV1Y8vonlu6XpX0HLfB7078Ao=;
	b=cIShlX4OOzhvDdrRaYtiTXEPRe4xMyDNEhViio/6YFoVpTThDaYaWuJGHVt5ljPhEVJ+pY
	h+1Qw/KgNNdmw9OOr9CPhhrQK2oxtZ/3Ga9+c9TgA5kBhtpworD0vFjVPkLnHxy1wa5WQs
	9wxrmW8ucvCEA/+dJkw1CY+gN5ZL6Uw=
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
Date: Wed, 12 Jun 2024 11:50:15 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
Message-ID: <usfcwyq76np42s5b2rpzgjrvvtdpwakaum7ayy4zumaa73ke3u@txbukb2464bl>
References: <20240530170259.852088-1-pasha.tatashin@soleen.com>
 <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
 <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com>
 <i66bzhgnbql7bvuteqttpijml3ze3nngxapv32k7paqv25c5th@wd37oaastkvz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i66bzhgnbql7bvuteqttpijml3ze3nngxapv32k7paqv25c5th@wd37oaastkvz>
X-Migadu-Flow: FLOW_OUT


Hi Pasha, I think you might have missed the questions I had below. Your
response would really be appreciated.

On Fri, May 31, 2024 at 03:42:34PM GMT, Shakeel Butt wrote:
> On Thu, May 30, 2024 at 08:14:17PM GMT, Pasha Tatashin wrote:
> > Hi Shakeel,
> > 
> > > Couple of questions:
> > >
> > > 1. In future with your on-demand kstack allocation feature, will these
> > > metrics still be useful? (I think so but I want to know your take)
> > 
> > It depends on how on-demand allocation is implemented. On hardware
> > that supports faults on kernel stacks,
> 
> Which hardware supports faults on kernel stacks and which do not?
> 
> > we will have other metrics that
> > show the total number of pages allocated for stacks.
> 
> Don't we already have a metric for that i.e. KernelStack in meminfo
> which is in kB unit?
> 
> One more question: Is there any concern in making
> CONFIG_DEBUG_STACK_USAGE not a debug feature i.e. enable in default
> kernels instead of just debug kernels?
> 
> thanks,
> Shakeel
> 

