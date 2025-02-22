Return-Path: <linux-kernel+bounces-526866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BAFA4049A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C5770034B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CE8176AA1;
	Sat, 22 Feb 2025 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fRxmczDB"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155B6EB7C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186905; cv=none; b=drqFC5URY+efHUoeHZbJnsqmaZXnbxVWAP1R4v5Tj89XlFi9UlD0llDkaRcATtFYI3tD5n0JCMcP5KkmNej9AFJAMojovN95TZvTfxuc3Hhvc9Ugx/vxUyamZX31YlFM8AE/yJX37mlwe5fIOcbD3jRgy6PPM8qnsPoNcZjmJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186905; c=relaxed/simple;
	bh=TPWuOImPRSC9MwImwntFIeHXk4Pf6QUB3oN2qov63yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyMZ48rJRc1hHjmDBLDVOSyndT0t3Uq2cDkLvwG/tOQUI2aVBq/J0M0mFEpf5BFw9yfARKMXFmYIReMRhLvwRoaJdLPVbAMtCuTz0adL125HlgAZ2UzueeE1am5UXxU2hibma7MeJbdUg5TfSE1aNOHq94iEzRh8DlUjHm9pd40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fRxmczDB; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 17:14:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740186898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8bS+nAWlMORon3vhEwOEVhwRQZHO7ei+DFVxKeC/qhc=;
	b=fRxmczDBXOnSwC+37m0BW4zglLQOOzgMDptqeMp+TOaguueh6Z6ps0I+K08h0axE8Gzfwl
	I4tCoai+aN9c9Wf0iMXkRMw++AGl/CMlLaM0oC7sEtL0w7oFT3jAenZYm02f0DpJZkyOB/
	EBJ4I2CWQm6CTSSj9hB/GII9F3SZY60=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>, sj@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>, Byungchul Park <byungchul@sk.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	akpm@linux-foundation.org, ying.huang@intel.com, vernhao@tencent.com, 
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org, david@redhat.com, 
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <6cdstauw4b64gpi6xxmuumuzvkgtjpczienh7neogqjlarqilv@eujvenmk2uyh>
References: <20250220052027.58847-1-byungchul@sk.com>
 <8accbd91-ca59-43f8-b190-7e1ac3df5e11@intel.com>
 <fc94c383-5788-43c8-beb3-2fd76acae7bd@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc94c383-5788-43c8-beb3-2fd76acae7bd@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 04:29:51PM +0100, Vlastimil Babka wrote:
> On 2/20/25 16:15, Dave Hansen wrote:
> > On 2/19/25 21:20, Byungchul Park wrote:
> >> I'm posting the latest version so that anyone can try luf mechanism if
> >> wanted by any chance.  However, I tagged RFC again because there are
> >> still issues that should be resolved to merge to mainline:
> > 
> > I don't see anything fundamentally different here from the last 11
> > versions. I think the entire approach is dangerous and basically makes
> > things impossible to debug. It's not clear that some of the failure
> > scenarios that I've brought up in the past have actually been fixed.
> 
> Yes, and it's still an invasive change to the buddy allocator.
> IIRC at Plumbers the opinion in the audience was that there might be ways to
> improve the batching on unmap to reduce the flushes without such an invasive
> and potentially dangerous change? Has that been investigated?
> 

I know SJ (CCed) is working on making TLB flush batching work for
process_madvise().


