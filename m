Return-Path: <linux-kernel+bounces-549508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A93A55358
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A856618975E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808C21481E;
	Thu,  6 Mar 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Io/iSVav"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51625A35E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283147; cv=none; b=q5pwmb9sw4w0n6e0CFkBv5nnfrpYxRCVTWEaWxGC44G9KQsYUYKzdCE8jXR0I53GgTrAxw5KQeZG1EOwJrRStVcaUwS8zfQS1VnQy1GvRuv37TMTq81nIaiWeuR3DIx1nuu1kMcaE+yy5sQlqUjsqarG5TcpFX0ClN9K3O1pvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283147; c=relaxed/simple;
	bh=y4M5ynrGMyWZMdUdelT3YznOA5+eCD4PkFDDx8U/srE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4uAOhe6M0pGx4PwYjp9+OEKHjpPBRux1CRx6k+O+xK3otI5mOLVZeNwX9vsNQRFZjsPTt8V1nnsWGwmANeRXOsH09tCNGuhExupPWspy3D+6bQutznr3aZ3M01Bhki0acxWkUPSF0+HMO28i3liUslHq4441oP+Lelxld2Rx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Io/iSVav; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9d9NpVxantETeGmL2S6sYCKYZHWuzJYRDFAMqz+Hxio=; b=Io/iSVaveAQ3kSlHzXEB9ZC6Wd
	Rj1IzSIxG2945NJZgFWX3zmR/tUBt3gm989dO6f8VLT2z7x5nKJxZMHghMTqHYdrWg8RDDWLDuIxN
	lXVxDWqivRWRYyD2IaZd4+wqDPcpQiZ5VGlunLatRDVh6aPhbaF3I1AFor+6M6eROTlTLnFjLX3/o
	McactVWsCfLe7GzNq45rLKXI61IvP9qJrhB8KMT/STxsJyjsWjkYkFw+YcaFjeZnk94/1cWbXesXv
	ZlfKjxEr5gyrLbjUIUB+CHbxbDkgfmP2XUGE6J+vTdiu3y0KtZbuHtii8xfQmfGuwle7sie8pr5Kv
	G1Cj9H7w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqFHq-0000000B1wN-1Esf;
	Thu, 06 Mar 2025 17:45:34 +0000
Date: Thu, 6 Mar 2025 17:45:34 +0000
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
Message-ID: <Z8nfPlJu8kxUvB8m@casper.infradead.org>
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-2-bharata@amd.com>
 <Z8naQNirs4HfTX0O@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8naQNirs4HfTX0O@gourry-fedora-PF4VCD3F>

On Thu, Mar 06, 2025 at 12:24:16PM -0500, Gregory Price wrote:
> On Thu, Mar 06, 2025 at 11:15:29AM +0530, Bharata B Rao wrote:
> > migrate_misplaced_folio_prepare() can be called from a
> > context where VMA isn't available. Allow the migration
> > to work from such contexts too.
> > 
> > Signed-off-by: Bharata B Rao <bharata@amd.com>
> 
> I have a similar patch in the unmapped pagecache RFC
> 
> we may also need this:
> https://lore.kernel.org/linux-mm/20250107000346.1338481-4-gourry@gourry.net/
> 
> May be worth just pulling these ahead to avoid conflict.

Or not putting them in at all because this whole thing is a magnificent
waste of time?

