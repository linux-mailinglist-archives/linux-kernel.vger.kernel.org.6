Return-Path: <linux-kernel+bounces-219519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8240490D3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F08D1C24588
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06944145B31;
	Tue, 18 Jun 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GY4cMhf0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877332139C1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718984; cv=none; b=ujl+tgZ75TLcH6E1z3C/QhuRecMk1LhKo3e1UZELFn6+L2jMsLWX/T22LTRzLHe+nHVVJUpUP5UQPu4OEMaFWx0jwbxXtdcyrwenJo1D1zq0jfFx+k833gfDB/4L3ZzbURdUqaKEpNHBWzbfqYHlNK0nj1UZWU9h0hPA+pG5m5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718984; c=relaxed/simple;
	bh=VqH2eQTDNoYBHw8Jn7qo4L5OxF7XKQJhubfde02DcuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5bIE7GqxETiKPy6Bc12zXL+D8LzVFl/5ZE2Gg03FLDf1kUObc8dVum02GUHWRDlUJ19saXpIfGvZIjwDCEO51z1kU2TBccN1DHA/PMn66ayvH8LWn2LUli0y5WlRG/wLJ8wTWU+wNYFbLNjJo4NJrBWnZMgeywIHoVL+jjDmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GY4cMhf0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lEuFcQnmwhtasfme7zDAsF0ZpxSDVAlJ+wmfE89ObN8=; b=GY4cMhf0RVCfyOlgg+UnS/g7GT
	xw0c6Ysa5bVoz9c4M2L0zyfBcNUN70Z2NnJ/5g+RWiPOcMyxPkrGhamcysNW0So3OL21rraf8HAia
	+iDmgBIRq9ePoMvxQtHIfkFciPbQowSA0QFWhuqYxVjBsHyITyE57wIWsnjyjkuKH8nSeZjss+Bou
	X+/cp8tvHmSlf5fgeuFG23nluIQsm4o61tuJWjZuNjjSpA0IGc+UeFCIDlmKtbxi2MU2sVCWQ74pC
	rB3ukpDmbeeMXSId8SNrVnvTWeJYe1Ew98fMY/cOATyHFfobuos0w6Lbe1HgS3WfcrPTKRe1OUrlf
	8II4+P9w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJZJp-00000003PY1-24hx;
	Tue, 18 Jun 2024 13:56:17 +0000
Date: Tue, 18 Jun 2024 14:56:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/1] container_of: Document container_of_const() is
 preferred
Message-ID: <ZnGSAfh70wdFQE3x@casper.infradead.org>
References: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
 <2024061702-vexingly-hypocrisy-d93d@gregkh>
 <ZnFOrziVMDwtu1NA@kekkonen.localdomain>
 <2024061827-revival-handwrite-5eb0@gregkh>
 <ZnF06GjogseJut9q@kekkonen.localdomain>
 <2024061820-scrambled-playback-a73a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061820-scrambled-playback-a73a@gregkh>

On Tue, Jun 18, 2024 at 02:54:53PM +0200, Greg Kroah-Hartman wrote:
> > I didn't have any issues (apart from me misspelling function names ;)) with
> > GCC 12, neither in using container_of_const() in a static inline function
> > nor in using a static inline function as a _Generic() expression.
> 
> Really?  And how do you handle the pointer being either const or not,
> and propagating that back out as the return type?  I'd like to see your
> inline function please.

Here's how I did it for page_folio():

#define page_folio(p)           (_Generic((p),                          \
        const struct page *:    (const struct folio *)_compound_head(p), \
        struct page *:          (struct folio *)_compound_head(p)))

Is there something differently magic about container_of() that prevents
this trick from working?

