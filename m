Return-Path: <linux-kernel+bounces-298932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057595CD9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77CBCB22E83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9D186612;
	Fri, 23 Aug 2024 13:19:37 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81218562A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419177; cv=none; b=BxYgIxlTbmu/Kb0lhbV9CI75WKRVkVdA4gIsjWezAv0lg7A/qcFtfFVTZ5j+GokgzbPkqmGW+5BzELrRIq9epTToS9kcdkxQyzXyPpqD09YHFTWjDBKAq5m113Dx7CtxZNR9/EbqZOOmld9MDKpVE8hAozGXKgBvfYnvSxPQ6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419177; c=relaxed/simple;
	bh=3pyEt5xSZgBPIyzAzfpZidqgbBCrQQaze8p85zvwYgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlNYpUq+wYs/VZffd4yIXCkFeTwDWf+BtL7dmxUVkDPASwUrOAvsn/2SLXMrOTmAUOjakk55dT9uif1vAtC70yc3jwbbVszBN8CL8ENeoA5OKqTg0rcmsWrYtTwuXkOyPHefDv/kfPU3Y2vaTklvy1YIHffWQ6IKCa9XeVBe+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47ND83oS013063;
	Fri, 23 Aug 2024 08:08:24 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 47ND6LFc013001;
	Fri, 23 Aug 2024 08:06:21 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 23 Aug 2024 08:06:00 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Stan Johnson <userm57@yahoo.com>, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in kernel mode
Message-ID: <20240823130600.GI28254@gate.crashing.org>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu> <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de> <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com> <20240822053238.GA2028@lst.de> <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com>
User-Agent: Mutt/1.4.2.3i

Hi!

On Thu, Aug 22, 2024 at 06:39:33AM +0000, LEROY Christophe wrote:
> Le 22/08/2024 à 07:32, Christoph Hellwig a écrit :
> > On Thu, Aug 22, 2024 at 05:25:10AM +0000, LEROY Christophe wrote:
> >>> and this results in a call to dma_direct_allocation(), which has one
> >>> innocent looking memset():
> >>
> >>
> >> memset() can't be used on non-cached memory, memset_io() has to be used
> >> instead.
> > 
> > No, we use memset on uncached memory all the time.  Note that uncached
> > memory != __iomem memory, for which you DO have to use memset_io.
> > 
> 
> Then we have a subject here.
> 
> powerpc has a magic instruction 'dcbz' which clears a full cacheline in 
> one go. It is far more efficient than a loop to store zeros, and since 
> 2015 memset(0) has been implemented with that instruction (commit 
> 5b2a32e80634 ("powerpc/32: memset(0): use cacheable_memzero"))
> 
> But that instruction generates an alignment exception when used on 
> non-cached memory (whether it is RAM or not doesn't matter).

What does "uncached memory" even mean here?  Literally it would be
I=1 memory (uncachEABLE memory), but more likely you want M=0 memory
here ("non-memory memory", "not well-behaved memory", MMIO often).

M=0 memory shouldn't ever have memset done on it, that is insane.  And
I=1 memory should not have the same optimised routines used, since
those only make things slower still.

> It is then 
> emulated by the kernel but it of course leads to a serious performance 
> degradation, hence the warning added by commit cbe654c77961 ("powerpc: 
> warn on emulation of dcbz instruction in kernel mode"). Until now it 
> helped identify and fix use of memset() on IO memory.
> 
> But if memset() is expected to be used with non-cached RAM, then I don't 
> know what to do. Any suggestion ?

If memset() is expected to be used with M=0, you cannot do any serious
optimisations to it at all.  If memset() is expected to be used with I=1
it should use a separate code path for it, probably the caller should
make the distinction.


Segher

