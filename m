Return-Path: <linux-kernel+bounces-524848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E1A3E7D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D52019C4DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C274B264F86;
	Thu, 20 Feb 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vo90Yjrx"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA9286280
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092031; cv=none; b=D5LX5TfDwQ+4+3DR7yqcPkPwNwqFVFhPRGiOMIKh4gvvFkntjmfhNikO0ruXgh3TkQOoxOAGESr09r3K0pC2pvHU5GQLunINj9xd1E8jRs3iNjCm9fKL+pMU78bDVflTCoihmTJ7iz7AJtVa8rUofQGpDcKwUSiM3hxVTx3OOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092031; c=relaxed/simple;
	bh=/KQXQg+N2b6wfsOi16xs6IO2FNE6aSbUT4AczuOM32s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se3EbIopz9nH6l01BFW8/o29SlaXSzp462EPYI8Ap3d678jR/xQfsiMOMw2f+rcz67CpWOsZQ8BanC3TcGNHUnMLgNKVaWCmDV6RE7hRo7EGwSUG2FR6uz5iyZx8UOCqNXs1xBy/N4PybPqukKzQoeo0YKQq5ZiMWoXOfq/WTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vo90Yjrx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 17:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740092025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dYTlYwWRTSP04TlrbbWePbu9bqv4xVJsVyBcl0fpGrU=;
	b=vo90YjrxgfoSKsGQYQffw+W5T5sQZqnSFmUv9wcUnaV3DATraojnqZhwPiwIyO+i0EBbMd
	QPyRxywhvosny+rO/iNYwNFFQnAyPvK+fyUlSizRZ7nBi/rTMzciicfYoGlwQ1XSKyQHKq
	JWATA4Ui/VDtX0wNADuTdJY5erICwwU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>, Hillf Danton <hdanton@sina.com>, 
	Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <ebna3dzn7aevgpzxjdb4vykmrheb7erqpdbos3ayl6tnimijpp@ibkvhcsa3pib>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
 <20250220114920.2383-1-hdanton@sina.com>
 <Z7c0BTteQoZKcSmJ@casper.infradead.org>
 <Z7dFuTkdQ7PmP7sY@home.goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dFuTkdQ7PmP7sY@home.goodmis.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 10:09:45AM -0500, Steven Rostedt wrote:
> On Thu, Feb 20, 2025 at 01:54:13PM +0000, Matthew Wilcox wrote:
> > On Thu, Feb 20, 2025 at 07:49:19PM +0800, Hillf Danton wrote:
> > > On Thu, 20 Feb 2025 20:09:35 +0900 Byungchul Park wrote:
> > > > Just in case that I don't understand what you meant and for better
> > > > understanding, can you provide a simple and problematic example from
> > > > the u-a-f?
> > > > 
> > > Tell us if it is illegal to commit rape without pregnancy in your home town?
> > 
> > Hillf, this is unacceptable language.  You need to apologise.
> 
> Agreed. WTF Hillf?  Where did that come from? Is this how you talk to your
> co-workers?
> 
> I'll tell you what would happen in my home town. If someone said
> that to a co-worker, they would likely be terminated.

I can't agree with the "this is a firing offence" approach.

We're a community, no one is employed by anyone else here; we work
together because we have to and we have to figure out how to get along.
We work via consensus, not appeals to authority.

However - language like that can _and has_ driven away valuable and
long standing members of our community, so people will feel strongly
about this.

Hillf, I'm going to share a story off list.

