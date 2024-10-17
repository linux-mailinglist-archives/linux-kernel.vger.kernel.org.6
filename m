Return-Path: <linux-kernel+bounces-370128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459AC9A280A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F561C210DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA16F1DF727;
	Thu, 17 Oct 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s7EPobrd"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF71DEFFC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181378; cv=none; b=B04RIgtcmzA8LdBWhy8WKn3VmRwMaVwrd2ljnfEX+OHA9htNEVNpkuxhm7YzrZxTAFUw6KufPjIvV+U+xkW56nuzfAa795NQ5IGfOryn8McZi5xharsCL+x4PDACVoLivKqTQ3dx1Wv95uPL46zmNdVt4rmf1o7Fq6M5fW9nlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181378; c=relaxed/simple;
	bh=aBCWh4+6xpajwVCaRJAIX1B+U4kZl3oZfiDiv9KHUwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mue0hq4r+FrgY16z4hoZsPaIwWFEMJRpxKLY+gVEib1CKqV2usYP6xwSQeh9ajU6GmxgrVoIURdwH0Em6vc/alqeZERvLs63QOLD9b7c3gY5VqWZEmEhPKY28K0YvZWLvDRX4Oi+iJDEkLQIhtw68tLjrejVrjwZMHdceCafTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s7EPobrd; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Oct 2024 16:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729181370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsU2+hsDP1JpASWksnLZSchRN7kDdrA2+jWf+1Q+v4c=;
	b=s7EPobrdGTdJjE6vOEu1ImAGAdHmLOxhf62tWT+WGH0YyZaSo7wT8ZEgve2WUzQi0/mqIi
	AYsSR1KnzbjJ3ctQlIdOoX3w8oj7Fi05sglLqgW2vgc0dcY6GlCPZRp37D1l5malRGnnfP
	1zsVPsRLT/PeIsFjknO2y5TBJNC/ge8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Michal Hocko <mhocko@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 03/57] mm/memcontrol: Fix seq_buf size to save
 memory when PAGE_SIZE is large
Message-ID: <ZxE2seZNaPNFapZO@google.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014105912.3207374-3-ryan.roberts@arm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 11:58:10AM +0100, Ryan Roberts wrote:
> Previously the seq_buf used for accumulating the memory.stat output was
> sized at PAGE_SIZE. But the amount of output is invariant to PAGE_SIZE;
> If 4K is enough on a 4K page system, then it should also be enough on a
> 64K page system, so we can save 60K om the static buffer used in
> mem_cgroup_print_oom_meminfo(). Let's make it so.
> 
> This also has the beneficial side effect of removing a place in the code
> that assumed PAGE_SIZE is a compile-time constant. So this helps our
> quest towards supporting boot-time page size selection.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

