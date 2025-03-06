Return-Path: <linux-kernel+bounces-549668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A00A5553E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D243AD0E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3245A270048;
	Thu,  6 Mar 2025 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHYvcsys"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390041DE4EC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286542; cv=none; b=Wswj8nxjhMXdAcI0sjhml2dORTPQ3U+Y0AX4AdhnRVQ3syq/fSbCsMMOb0LjIs1agY99FysN7cHx2sMfUxBEsYUiWIS9u82NlfiCls9+WBBHqJou5W6C4EZ8KM845CvPUUnNK7fKb4tI1F1QEkN0gF9tgpCXqAxw8/zQtFF5by8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286542; c=relaxed/simple;
	bh=JDnHebyoCcnBx+cDCq/zkG7+g+ESLfON7ldIRucKy8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDDdPyePr0XRpY9LfymPVT5UZtC7xOP0CE2YFTL+J3symV/6SnhUhylnddLDLTSAIugZKSmTcDJFkmPjA2WZC8vepRkzoz24wwX+eybZth7hOdzBpZEZ4CNxHAKOK1ocJoKi0e1PGCkm41T/dT4Y+GvRwsVR0F9mpFHQJSz7Z0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eHYvcsys; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=71birkROPl9yB++m29FkJfW455fBG18HUHqmbtdCA+A=; b=eHYvcsyslBQNgH+z6Zyr8371c8
	0RVewtqIv1nDnUN3e6nGgPG/MkyvcPQtWExVcHFSmGj0LLR9+BVnI/SMOSXd0opaTyNxjnNpCg5sn
	tZnRYCtOHTEU5shDwIqinECpZNuQnhFyCvQ2h6IInUrSWJarjtkMd9kNycQeU1YaGVmgyvir1cXtd
	6d1AHUHZSQ3wsxfJUshwOq7DP6R9F4lfNxCu/iqFsf+KGhNavd6D7CGCSur/oD1mGXWjLmRnBYT5+
	DgzMIuaKEu1e02W11zpnZ0Jh+mvPaKuvSHcV20VMmGS1gcx0PsWdr2k1C8CgD+ljnvVTsUab1JidW
	1yWdZJvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGAc-0000000B60f-1WkZ;
	Thu, 06 Mar 2025 18:42:10 +0000
Date: Thu, 6 Mar 2025 18:42:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, AneeshKumar.KizhakeVeetil@arm.com,
	Hasan.Maruf@amd.com, Jonathan.Cameron@huawei.com,
	Michael.Day@amd.com, akpm@linux-foundation.org,
	dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
	hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
	jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
	kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
	liam.howlett@oracle.com, mgorman@techsingularity.net,
	mingo@redhat.com, nadav.amit@gmail.com, nphamcs@gmail.com,
	peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com,
	rientjes@google.com, rppt@kernel.org, shivankg@amd.com,
	shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz,
	weixugc@google.com, ying.huang@linux.alibaba.com, ziy@nvidia.com,
	dave@stgolabs.net, yuanchu@google.com, hyeonggon.yoo@sk.com
Subject: Re: [RFC PATCH 1/4] mm: migrate: Allow misplaced migration without
 VMA too
Message-ID: <Z8nsgr46eVH7W7SJ@casper.infradead.org>
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-2-bharata@amd.com>
 <Z8naQNirs4HfTX0O@gourry-fedora-PF4VCD3F>
 <Z8nfPlJu8kxUvB8m@casper.infradead.org>
 <Z8nnPYldSXs5TYND@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nnPYldSXs5TYND@gourry-fedora-PF4VCD3F>

On Thu, Mar 06, 2025 at 01:19:41PM -0500, Gregory Price wrote:
> On Thu, Mar 06, 2025 at 05:45:34PM +0000, Matthew Wilcox wrote:
> > On Thu, Mar 06, 2025 at 12:24:16PM -0500, Gregory Price wrote:
> > > we may also need this:
> > > https://lore.kernel.org/linux-mm/20250107000346.1338481-4-gourry@gourry.net/
> > > 
> > > May be worth just pulling these ahead to avoid conflict.
> > 
> > Or not putting them in at all because this whole thing is a magnificent
> > waste of time?
> 
> Divorced from the tiering mechanisms, is making misplaced migration able
> to migrate unmapped pages not generally useful?

The only thing I can think of is if you have a process or set of
processes on node A calling read() and the file is cached on node B.
But in order to decide if the page is on the wrong node, you'd need
to track a lot of information about which nodes the page is being
accessed from.  Which is probably why we've never bothered to do it.

This is not a large patch for you to carry as part of your patchset.
There's nothing intrinsically wrong with it; it just has no users in
mainline and no real prospect of any being added soon.

