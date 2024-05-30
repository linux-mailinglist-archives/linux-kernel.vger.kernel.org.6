Return-Path: <linux-kernel+bounces-195962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD88D54ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F3D1F250C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D12182D25;
	Thu, 30 May 2024 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VCVj+QGd"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74AB1F947
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717106229; cv=none; b=oSFrNhjXe+gos3VzRPQlrrrSRTD7ZXZ9fqtKOmSj9cN7Aui0vmsExx1NEsIgpMmI1QOz9ezGY1/WGOUWbnMbF5Hqg9qAP1baS1qV8AQH2NO2T0Nz1BeP7m+eAfapDf2OEtO+MTFMzkgJrG+MIOHPtUwhfnuTEiNjSHo5zwLoBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717106229; c=relaxed/simple;
	bh=hr/YEqqjVNkr4VGpdws92cwmcxBvGnhMVTaetzhcBHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDT5tH4gSCSQVClnTX9O/xBWVXRBgaFYF+VO6PCHlrkyL8myHyES+HCXSSdRXeUqXuSXHhlmDXClgEz1r6NAqr0hMc6wa/rZkW616Hf5j9Oi2ruSmVabQiqGMzhh2HkkEkgrb0aZKN1dahZ7v8Ub2OaSLZljQpRsmJUjb0rUQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VCVj+QGd; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: pasha.tatashin@soleen.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717106221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vUVw2k/TRVjir+kYWNyPhgdXmenTsS4haD6uSDw11g=;
	b=VCVj+QGdkLubGb31rdV+qzMmQJjacwDnq9OF4HDCPPFZqa7CKGS5NBrVJqz4yk3xZ8hDnf
	pQPh7u8vSj0K/yemTrKl3qXU2HqPpAfxn4pl8a6hpz/Dt2nVRFhi9tQ7q5Omokj7i606qH
	+LAKslGWOQG7cg4sBU193b18qJ0sPZg=
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
Date: Thu, 30 May 2024 14:56:56 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
Message-ID: <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
References: <20240530170259.852088-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530170259.852088-1-pasha.tatashin@soleen.com>
X-Migadu-Flow: FLOW_OUT

Hi Pasha,

On Thu, May 30, 2024 at 05:02:59PM GMT, Pasha Tatashin wrote:
> Provide a kernel stack usage histogram to aid in optimizing kernel stack
> sizes and minimizing memory waste in large-scale environments. The
> histogram divides stack usage into power-of-two buckets and reports the
> results in /proc/vmstat. This information is especially valuable in
> environments with millions of machines, where even small optimizations
> can have a significant impact.
> 
> The histogram data is presented in /proc/vmstat with entries like
> "kstack_1k", "kstack_2k", and so on, indicating the number of threads
> that exited with stack usage falling within each respective bucket.
> 
> Example outputs:
> Intel:
> $ grep kstack /proc/vmstat
> kstack_1k 3
> kstack_2k 188
> kstack_4k 11391
> kstack_8k 243
> kstack_16k 0
> 
> ARM with 64K page_size:
> $ grep kstack /proc/vmstat
> kstack_1k 1
> kstack_2k 340
> kstack_4k 25212
> kstack_8k 1659
> kstack_16k 0
> kstack_32k 0
> kstack_64k 0
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Couple of questions:

1. In future with your on-demand kstack allocation feature, will these
metrics still be useful? (I think so but I want to know your take)

2. With on-demand kstack allocation, the stack_not_used() needs to be
changed to not cause the allocation, right?

3. Does the histogram get updated on exit only? What about long running
kernel threads whose will never exit?

thanks,
Shakeel

