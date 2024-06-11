Return-Path: <linux-kernel+bounces-210416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424D904367
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3D41F26778
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642006EB46;
	Tue, 11 Jun 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BlNTob1J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF74376E9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130092; cv=none; b=ftBTvaL6FNbYJWjzpEldzRWrGsihSQIrhNAw5JOcFacZqd3CodjuhDONSvTQj6TYBfcJ7opMfYXnS9kTR3t6qtxYmeSz5V7L25rAAbcLvWpN5qkx2HGxgHi0mdTRjk0SrHbw5Tw/7Wjvs2nDkqp3d2H4gPsLZVrmFhECh6/oBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130092; c=relaxed/simple;
	bh=IkeeZ4IP+hn989ZtzVm7fErRBzJnQu7C1x3BhsI6GKc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X1oicA/Oe3fDj0iO4yzxJ8aQpRRl0ETWyWXSQbL1G6XWIM5g/owYFvZtTvE4AjnWhV6y46EYklg5kSpuQruETbs5yfChdTMIIxqV7x4Z519ew4LtSzi3YBtDX49Dg0wb6ktP3tCPHjdJQqlUbuuNCKvsKxAioabmXHWCK41wF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BlNTob1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06C0C2BD10;
	Tue, 11 Jun 2024 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718130091;
	bh=IkeeZ4IP+hn989ZtzVm7fErRBzJnQu7C1x3BhsI6GKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BlNTob1J/lh6sEaQcarMkth5pJXdUNvMvpAXR956QDl9Hddm0WQTfBbC7EQUos6Pw
	 Ca2No0QrbKNf2IDtvcnHn4FIv8OqEb++geeQRTHTUZVkYhX+yllpAu2YFJjmMsdm7b
	 g8NccKFLc+kKiWDh86dv33DsjU91FT1o3ftfLKDw=
Date: Tue, 11 Jun 2024 11:21:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Bresticker <abrestic@rivosinc.com>, David Hildenbrand
 <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
Message-Id: <20240611112131.25925b8ee5198668b88de35f@linux-foundation.org>
In-Reply-To: <ZmiRcUYxrZ5NQQX8@casper.infradead.org>
References: <20240611153216.2794513-1-abrestic@rivosinc.com>
	<ZmiRcUYxrZ5NQQX8@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 19:03:29 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Jun 11, 2024 at 08:32:16AM -0700, Andrew Bresticker wrote:
> > -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> > +	if (folio_order(folio) != HPAGE_PMD_ORDER)
> >  		return ret;
> > +	page = &folio->page;
> 
> This works today, but in about six months time it's going to be a pain.
> 
> +	page = folio_page(folio, 0);
> 
> is the one which works today and in the future.

I was wondering about that.

hp2:/usr/src/25> fgrep "&folio->page" mm/*.c | wc -l
84
hp2:/usr/src/25> fgrep "folio_page(" mm/*.c | wc -l 
35

Should these all be converted?  What's the general rule here?

