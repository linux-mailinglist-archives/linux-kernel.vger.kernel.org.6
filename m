Return-Path: <linux-kernel+bounces-448226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F99F9F3D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C1218890CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423E31D619F;
	Mon, 16 Dec 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H6U4LrpO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012C1D554;
	Mon, 16 Dec 2024 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386445; cv=none; b=lCEprAP0tJOQtQERCr9V9CPeqQj/0dQTg0ObyIaF6wxRTFrDpaYzR8yfuNhYnWAqEyb+fCgj1z4uo/mZUR8cAMNF/8WXaoI71n/PxZu+4bZROLJOFF8cQ/6sDKMfM668Hsy/SzgUI1I9IWs8eSwJcIem5Id3t9VXzXUpDKOCqWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386445; c=relaxed/simple;
	bh=5kLL1DLakkjZktlYV+gu3/YktJW7PsRxj1HvQAuhnuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgrtSHzqWKrJ1xAvM4COvz5zy1LEHG01atR8sUDnjjKJGDYw0BLkmLIMAMp+jxAR41Kn2V43LpzEpvS0p7PvygpeLl3uLMFQV/ioknh1qgQaXOYQwtzl7VLvnNBqd5DdWmIQCv24ov1T/TGmoxjoaUn0nrxAdqJT0320bJvcBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H6U4LrpO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WwOpWuV55ttk34xYcb1itv2pXV6N2/L1ZVzPXCDpyeQ=; b=H6U4LrpOIcLlnxGaP+ICfOph+/
	67LZWB1HlA/0l84tIudHNVmWaiG9IoA/dx8X7gT6kapc0itYO4wafCoI409mmqgnZ+r8jMbyf/JJo
	5Mlg0P+KsXL9VCF4SSZ5bWDmV+u3S13TrzRYeSqSo3ZfpADwfxqyz0pu4FljjG1XKKgB7UMQQTpY5
	AfzpMXJ3LXnt0Gp3c518vw/eLAlnL20YCJNw+szUqe2D5IynUHM5VQK8Reb05tkqgQvwOb0ovZ3k8
	ch+uCqGzeA0bg9uoVLrVQ2GQLZek+zx7J1jd50JWGsQQ9leCPqWsNPoADGMb40KQyLBUbLJcAE2d1
	3jGNzUOQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNJ8L-00000004wzD-1zLy;
	Mon, 16 Dec 2024 22:00:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2BD4230031E; Mon, 16 Dec 2024 23:00:08 +0100 (CET)
Date: Mon, 16 Dec 2024 23:00:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, lokeshgidra@google.com, minchan@google.com,
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, klarasmodin@gmail.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 10/16] mm: replace vm_lock and detached flag with a
 reference count
Message-ID: <20241216220007.GE9803@noisy.programming.kicks-ass.net>
References: <20241216192419.2970941-1-surenb@google.com>
 <20241216192419.2970941-11-surenb@google.com>
 <20241216211520.GB9803@noisy.programming.kicks-ass.net>
 <CAJuCfpHAZ4gwh14wi8M3jt8HPwwV_P9W29qzOXwypgUk72VBgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHAZ4gwh14wi8M3jt8HPwwV_P9W29qzOXwypgUk72VBgA@mail.gmail.com>

On Mon, Dec 16, 2024 at 01:53:06PM -0800, Suren Baghdasaryan wrote:

> > That is, should this not live in vma_iter_store*(), right before
> > mas_store_gfp() ?
> 
> Currently it's done right *after* mas_store_gfp() but I was debating
> with myself if it indeed should be *before* insertion into the tree...

The moment it goes into the tree it becomes visible to RCU lookups, it's
a bit weird to have them with !refcnt at that point, but I don't suppose
it harms.

