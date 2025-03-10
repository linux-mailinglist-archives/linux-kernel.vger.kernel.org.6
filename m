Return-Path: <linux-kernel+bounces-555271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE202A5AE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981BA3AF29D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1D222173F;
	Mon, 10 Mar 2025 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FahTOd/L"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B11D5150
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649822; cv=none; b=givdNx7/Ju6k54y5xXG8roKKwfykAKWYDqyqmn5z+V/QC8RkWNHxZmYu4li/n1vvao72iF6Hkl6AnKCaakh1rJVr7k/wM45gSZDuoIwLu9nlwGz85CbfS05g0eOkhuZznYVxJLZJawrSI/yhzdscMHb247LbkOSYj2HSOTZr7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649822; c=relaxed/simple;
	bh=yaXAfsZ6AWNgCDILtd5Oo8n5jhAzf06bRIsRditpw28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIqB0DWt+2hemGjbuv6GRVknUr25ms0qd1XPmf+CukIg2IRqHGrWJ+n0poLc8L8oedyUj1ug6FUowAANQCD95rAvBxraCtly3fgfS2e/khzjfqnn9F55AWv3vJfZoIuK2Pp017soE9aXQQPtiK+IiiwHBfpQOxtMbJ2j4WTMcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FahTOd/L; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Mar 2025 23:36:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741649817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vxyaRDkfAYo8J4tkd+ufifnYsxY6w8PIGPQNKuIvjU=;
	b=FahTOd/L8bls0gAf5cWXU1nIYQSOUT9FglrPQ34c1DxeOkevHgBRHZFEhS/3s+PleG79Ne
	rj7NGMstLTlhEMipuhpdL0k40GMHQaRDqd79Vt1IfaAaQrQxjK6REebj11vfE+ZV8IbYhV
	A9IsHWuKWKt0cQWgfax+G2Y21udg7+0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/9] mm/madvise: batch tlb flushes for MADV_DONTNEED and
 MADV_FREE
Message-ID: <Z893lHkRWhHDuWUC@google.com>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310153921.47d390c637105e3ad6fc49c0@linux-foundation.org>
 <mecl3oimrbzeh3o2gaolmpqeyw7f7npme4zhpnzkqohrgxwotq@qssi4idgvftl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mecl3oimrbzeh3o2gaolmpqeyw7f7npme4zhpnzkqohrgxwotq@qssi4idgvftl>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 10, 2025 at 04:15:06PM -0700, Shakeel Butt wrote:
> On Mon, Mar 10, 2025 at 03:39:21PM -0700, Andrew Morton wrote:
> > On Mon, 10 Mar 2025 10:23:09 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > >  It is unclear if such use case
> > > is common and the inefficiency is significant. 
> > 
> > Well, we could conduct a survey,
> > 
> > Can you add some logging to detect when userspace performs such an
> > madvise() call, then run that kernel on some "typical" machines which
> > are running "typical" workloads?  That should give us a feeling for how
> > often userspace does this, and hence will help us understand the usefulness
> > of this patchset.
> 
> Just for the clarification, this patchset is very useful for the
> process_madvise() and the experiment results show that.

+1

Google carried an internal version for a vectorized madvise() which
was much faster than process_madvise() last time I measured it.
I hope SJ's patchset will (partially) address this difference,
which will hopefully allow to drop the internal implementation
for process_madvise.

