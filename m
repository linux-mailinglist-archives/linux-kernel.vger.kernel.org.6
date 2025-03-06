Return-Path: <linux-kernel+bounces-549659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B192DA55525
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E327A3013
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D2269CE8;
	Thu,  6 Mar 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tihWoKJk"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686B19D08F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286211; cv=none; b=K8mhLJw5Q31ypHkzU2ACkVgmNYa/oqiqWb9PDoCzYU/dPGICCDwzk5GVyGvJKb2Nssgafo9SdS82aVDHWQbkYm4JC9nOPq537wfWiffYsy8vBMXhkHvjBIeoFgkV89kHU4ticVJk8pcv+AeuQc9dcHBnNx+FfA17hFMBJ9HRNLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286211; c=relaxed/simple;
	bh=F8HSoTxH7lldxI3hFvtBam04mhaXXGxE8bruvAyGD3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzaG9HTXFboBY6KsuFwk+mn81Oakg0ufj3uN6VAmM4EMuUuaTAFBG0kFCY8bYQPM/k6e+4HsCY5da6P0uAPwkTiw+9FqX7GZyvUnvWvKwnR+l7CuDUGeHXLQWjLe4Zg5+IM5oZ4ohGWJvDZfesT20iqHXFrXMFFB21ICXx1Wgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tihWoKJk; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 10:36:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741286206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTrvcYuWv98a/9y4WDIA5ThVkMXYAekoySFFoVpWazk=;
	b=tihWoKJkQ9Q1ELVW++LJ9SzRj2GlkPkOb4s6ScdPen4NrbHbEWT3v0O8Sgn2aSuL09IsTY
	frtCpzz6Q1C7O2exgB9OeJj3iw4r9tyfIS/hjT4tLDZJfWCQBAk4KKeLpwDLwX634PV2Dx
	C/wZrjviTTfOYO4ORwtRur/sI9aDZP8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 12/16] mm/madvise: batch tlb flushes for
 process_madvise(MADV_DONTNEED[_LOCKED])
Message-ID: <qloyhszjm4v44lfocb5wjnmmylz4n7co2v6iqbxz335i3ybsru@arcmuuiwahkh>
References: <20250305181611.54484-1-sj@kernel.org>
 <20250305181611.54484-13-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181611.54484-13-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 10:16:07AM -0800, SeongJae Park wrote:
> MADV_DONTNEED[_LOCKED] internal logic can be invoked with batched tlb
> flushes.  Update vector_madvise(), which is called for
> process_madvise(), to use that in the way, by passing an mmu_gather
> object that it initializes before starting the internal works, and
> flushing the gathered tlb entries at once after all the internal works
> are done.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Please squash 12, 13 and 14 patches.

