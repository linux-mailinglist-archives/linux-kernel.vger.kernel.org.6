Return-Path: <linux-kernel+bounces-396606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B659BCF61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3E2285041
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7C414A91;
	Tue,  5 Nov 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MGEkDjAH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85D1D88D4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817134; cv=none; b=tF5i4AufvVwUTLl/GN+o2/RnGF0OHi5Xcxf3LdvMnZP+RYGbB9Yfb0WZCxo92Vynk+1hmwFj+03sutrFdQJdwhRNyB5d/2sviKRPanwnS4QKlXBnHZqh4jCBbRZeBnI0AA73AzVjApuP8N/KuQa8exOecOKSr4LyOgFLUNPg3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817134; c=relaxed/simple;
	bh=OT6Ao99YyqdYA3LDUaUA99/DRS6BskIbMZP02iWqdAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfqTdkXgY+58JKPXYOXylCgN3m0F4YscTHoRTTCwGyHoOEro4sH5cfw/cTJwEh+VLP+SMqFLDD2P6WXsJ5A64MWvB5Gid9OYdoR+AEk6pHYEFZ1IW2OQi3Go9pONaq6TP7c5yH6xtzsdrVu09RG1oR4nKN5QxTZF9ttfyGNuDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MGEkDjAH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sQylJ4ZOQbI60fiEegukCbq2jv1FBBl6Nkf+RPhmi9c=; b=MGEkDjAHofG7t4YwBITHSB3zu/
	+E6Z01s4JFiIYhubYlRBfYtVGqZEwdH6OxMpZyPfZi4wY+CBAbIN8/WRj3jlqiEpc2zW/AhDC+y8G
	7hyoYk8j3+cwpJ0dIkAWzst0KSywKHrm24vjyFp/Ch1+ZhfDlu7f8evGD6FrNBKpA4831FijvkdjF
	JzSPGsSMPulRV/T2n3W4FYz6jBdJIUJO5GbfHXiqJAi+zHFmagl91G+ZWnA/je/qF3SlrIQX1HGsz
	lT6DUpebCwyRGmBaXpxN2Y3lmJZsSu/0FJ7qPpCX5XRMI9qowK7sOXuoexjG7lQq+9FnKv8BwkS7T
	8dEq5vgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8KbM-0000000HHAJ-2Fao;
	Tue, 05 Nov 2024 14:32:12 +0000
Date: Tue, 5 Nov 2024 06:32:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	alexei.starovoitov@gmail.com, ebiggers@kernel.org,
	samitolvanen@google.com, kees@kernel.org
Subject: Re: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Message-ID: <ZyosbEMNzMU6fOe_@infradead.org>
References: <20241105113901.348320374@infradead.org>
 <20241105114521.852053765@infradead.org>
 <Zyoood0ooSbpultV@infradead.org>
 <20241105142720.GG10375@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105142720.GG10375@noisy.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 05, 2024 at 03:27:20PM +0100, Peter Zijlstra wrote:
> > I don't think that is the case at all.  The is a relatively small number
> > of exported symbols that are called indirectly.  I'd much rather mark
> > those explicitly.
> 
> I'm not claiming they have their address taken -- just saying that
> traditionally this has always been a valid thing to do.
> 
> Anyway, I raised this point last time, and I think back then the
> consensus was to explicitly mark those you should not be able to call.

Who came to that consensus?  There really is just a relatively well
bounded number of functions that are used as either default methods
or as ready made callbacks.  Everything else has no business being
called indirectly.  While disallowing this might be a bit of work,
I think it would be a great security improvement.


