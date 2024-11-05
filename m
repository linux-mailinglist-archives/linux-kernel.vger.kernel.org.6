Return-Path: <linux-kernel+bounces-396701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9629BD0D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0AA1C20D78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE0A7DA93;
	Tue,  5 Nov 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="REuFJmXL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305B7D3F4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821275; cv=none; b=KoH7TxSDI4mVjnUsD2Ql2KtWIg6mBWtbzH3CZTISySkUGh6vRsldWEhLWfiP7gso8JmaV0HTXqQgK+AYYWOpUlL8OhxN7KhByVRHoFFyLMmP5sv+h1pyuyHisH0DF0bnRLcYeGPpgtBEyp0Pz+Ou9r5+UdtzSKcHZZWbvjtT2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821275; c=relaxed/simple;
	bh=X8Tn2kfEz/8sQ8qe6hl0sZCPND4hV+hzMBpsCFo6Lgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+wXGhnqsu+oZ/YXDKzTPKiY0HUR07VGOsuBnKZXTo3+UwQOskd7ThSMYFXCBYu3i6+boD9ibbyk/k4OXhxKkZZLDmos3cGvHUuroVrw0yz/4ZZsbGlXcLuBZPsC9TRswRr1D45duTfwMK87DLG41F9qq2HT1jBK8ewLQnx+HK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=REuFJmXL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UPHw2IiDaWM/l4GsTAEfiswduoyNvvNd/EA3DH7veLY=; b=REuFJmXLaI3NKZGwq5OEvAl7i9
	/PID4INtijbyyGTEaEyHIdtyl25s8Ljb7QOj6YUmKeqaCTCrbYImnMGt/btruBs6ACrTTzvXRlhKr
	nplynN2h7BDOUGcnGZdgv+D/gx4tXMyf/no0VRs+1yXVYE4aqgLZNNl1EpZnoNQtrKh1cv+biD1Fk
	mhKXcgwkhXsdGp7sJ4IjlontecOqgzXcm4tFJT8zu4LCPMLUlA+lLO1RdHDfI6hOjf8PwbNx7tIWb
	R4p329LF5N3J44GbwktzJMV6Jl0f5hfNsa7P7sQvgBJIOPLPU7PkW7Ih7K12tqx9gGCYlPS5+czkb
	ymWIALkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Lg9-0000000HSOs-1XAv;
	Tue, 05 Nov 2024 15:41:13 +0000
Date: Tue, 5 Nov 2024 07:41:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	alexei.starovoitov@gmail.com, ebiggers@kernel.org,
	samitolvanen@google.com, kees@kernel.org
Subject: Re: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Message-ID: <Zyo8mdoQOXa9kiBv@infradead.org>
References: <20241105113901.348320374@infradead.org>
 <20241105114521.852053765@infradead.org>
 <Zyoood0ooSbpultV@infradead.org>
 <20241105142720.GG10375@noisy.programming.kicks-ass.net>
 <ZyosbEMNzMU6fOe_@infradead.org>
 <20241105145842.GH10375@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105145842.GH10375@noisy.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 05, 2024 at 03:58:42PM +0100, Peter Zijlstra wrote:
> > bounded number of functions that are used as either default methods
> > or as ready made callbacks.  Everything else has no business being
> > called indirectly.  While disallowing this might be a bit of work,
> > I think it would be a great security improvement.
> 
> Well, we don't disagree. But since most of the EXPORT'ed functions are
> done in C, we need something that works there too.

Yes, absolutely.  In fact I doubt there are more than a handful of
assembly exports that are valid targets for indirect calls.


