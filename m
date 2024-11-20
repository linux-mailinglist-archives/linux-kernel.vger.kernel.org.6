Return-Path: <linux-kernel+bounces-416363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0362C9D43D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6A62838FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D9B1BD9C0;
	Wed, 20 Nov 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="muyCQ5Sv"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BBD156F4C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732140707; cv=none; b=kzBlG9rbsTrr+rugHPuyTP7h6EiVoImgd73OavzrsiioIPODTSeIjSpcgqgfdDdCXj+l7NPJmKs45ilHMt/32GjAMZwsEzX2qS1a/xUL3+7iq8GjSu517ODcSeeXPIgLY4JB2HvpSUHsaSUTX/5uanXnPEheVsv4Ib/+VHzd42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732140707; c=relaxed/simple;
	bh=flOiYGt195SLimf0XkUvOxyiVoNGhxwAQteRYWh57YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpnEI1rJfWiuH0vMMcN3fJ8adT1sundRjcTEv8WrVQHNT+9UjVDHcdy3mJNNg7sjZTa9x4n1LVddj+nJ+cnviHDt+03/DkdggzTyc8TdtEaAU8L1y2H1j89wq5SQwMXVf/JHsE48wIS4fo778dwVCTNUIH9bLWWLpjhMS4B2S94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=muyCQ5Sv; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 14:11:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732140703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COBxTjW3FQRNbm+V4f5LJnh+ZCFl+4BIkeAIgUb9g3M=;
	b=muyCQ5Sv4ldgnI29QCvVCu2Z7msGkwZwMcUGO7tdMtW6aM5qiOVGgMJ2VMQ3zaqacZ+ec0
	3DEk8lnkKJb8I/dxqKRfm+wM6fbvx7jbj1RyHu2jTIkG8E9PLPc/LywmMtq5AU33VatB2F
	Fv16zzFFeOMq4LjcP8+/ZrrUuVIupdk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, oleg@redhat.com, 
	dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v4 1/5] mm: introduce vma_start_read_locked{_nested}
 helpers
Message-ID: <buetlvpqqkclvvceoqby3wzbmj2mg7ic42t3txgud44mf5eptj@tknatu4mmwq7>
References: <20241120000826.335387-1-surenb@google.com>
 <20241120000826.335387-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120000826.335387-2-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 19, 2024 at 04:08:22PM -0800, Suren Baghdasaryan wrote:
> Introduce helper functions which can be used to read-lock a VMA when
> holding mmap_lock for read. Replace direct accesses to vma->vm_lock
> with these new helpers.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

