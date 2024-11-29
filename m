Return-Path: <linux-kernel+bounces-413402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A389D18B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4FEB21F56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F311E4926;
	Mon, 18 Nov 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AYrP8LJZ"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B721E2312
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957084; cv=none; b=unrkyvMQEQy0NvZwI5W5p5IklZvBUbxyJ0zd4jC+orcc6D7vYtRK5LIS25lrJvHf3Yb7qMAnzMi0yCnH8FQIDLLD22UAmH5Mou7LTJJHtCuTI4rIJ6YFQaYQBcXGhutsnzw7jVb/nFf2g6MXZM0oj/VnytT7Q88jhGANCuuN2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957084; c=relaxed/simple;
	bh=rnXfYxw96o9uGMVvCmLOhoWSMw2XpArfsXz+kgsdKfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrmLT1nzDwrBLWLcxQ3hpc1Mtkiads8JyIgZjCBvy4AJdbbZURaOF+h64TIQ/6Cck+iiDFTiLlU92sFP/zKHxlZ0QTsE0gj8c7VTOt3tDe5v3o/cjmYnpEjVJKWP9EsxGoQfSgxZrBJqbEi8dFY0U51x61u681R28fueOChEmf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AYrP8LJZ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Nov 2024 19:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731957075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9bdmC8O0mZuSc1d3ov6kK3zAXL6Ki/uwfsmjx15YrI=;
	b=AYrP8LJZV2AGKUOMf90n+zfu8+d1nAItkyc8LsvyQowiseGlvnGU+zD0Dt3EY5ONppo0Xe
	7EQ2qFFx9REbsv7WMGmtRD9WY6WsnDyciUXEOiytFTesKekvLLsR6l9Zigv/WrtKF4v9QS
	EpMbWvpMZO6tUGBRzZI402Evm3OZ0oc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
	jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com,
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com,
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com,
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
	oleg@redhat.com, tandersen@netflix.com, rientjes@google.com,
	gthelen@google.com
Subject: Re: [RFCv1 0/6] Page Detective
Message-ID: <ZzuRSZc8HX9Zu0dE@google.com>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Nov 16, 2024 at 05:59:16PM +0000, Pasha Tatashin wrote:
> Page Detective is a new kernel debugging tool that provides detailed
> information about the usage and mapping of physical memory pages.
> 
> It is often known that a particular page is corrupted, but it is hard to
> extract more information about such a page from live system. Examples
> are:
> 
> - Checksum failure during live migration
> - Filesystem journal failure
> - dump_page warnings on the console log
> - Unexcpected segfaults
> 
> Page Detective helps to extract more information from the kernel, so it
> can be used by developers to root cause the associated problem.
> 
> It operates through the Linux debugfs interface, with two files: "virt"
> and "phys".
> 
> The "virt" file takes a virtual address and PID and outputs information
> about the corresponding page.
> 
> The "phys" file takes a physical address and outputs information about
> that page.
> 
> The output is presented via kernel log messages (can be accessed with
> dmesg), and includes information such as the page's reference count,
> mapping, flags, and memory cgroup. It also shows whether the page is
> mapped in the kernel page table, and if so, how many times.

This looks questionable both from the security and convenience points of view.
Given the request-response nature of the interface, the output can be
provided using a "normal" seq-based pseudo-file.

But I have a more generic question:
doesn't it make sense to implement it as a set of drgn scripts instead
of kernel code? This provides more flexibility, is safer (even if it's buggy,
you won't crash the host) and should be at least in theory equally
powerful.

Thanks!

