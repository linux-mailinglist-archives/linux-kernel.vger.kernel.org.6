Return-Path: <linux-kernel+bounces-219658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A5B90D628
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72922867A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A17D139CF6;
	Tue, 18 Jun 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxlk5Xnt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DD2139C1;
	Tue, 18 Jun 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722050; cv=none; b=ULBw8YYt3pmftiRH9XytWXfdtpjw+1TKnm7K6tK2rIvYnDGknWP5F9QGIcYFP5JCsi4UdWFuaC/H32NkHe/CdvSnVJN9Pdof0lNhXhzVCRG3FJcfwEZv19daK3EMMNhno45ofTYjUFB21dyXK2WYJBNyZORqnk6dJ/0xrfMuE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722050; c=relaxed/simple;
	bh=myu6xZvuOueiOeI/zuBpHoigAXpFoMmCHfmmMU2esHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWHKZkn/aL5AXPOamQ5Duc/lWqoiSQzWG22b8aXABoqI4otXDPFXuCFA38glyCLF4OUnbfa6nan7X7eeQCsHQFCyZiVVU2wORUwRejV1g7Gnh+hR4hoXJYRD6f3G8i66lEAxphlGF7J57iha7epku5+KLBRWwnBK0fYNudmjjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hxlk5Xnt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OtT3nVi9iMcyV1QuTZeqb4wNAUsd0ByuA1faKCP5kQU=; b=hxlk5Xnt9tliDr6NBa2dxOeael
	XHxh4CnBhElen4Xxx47JR8TxIUDiNd8t+XrEWc1XYtPx+hoCnGAgdXY5qHwvBEWO//rpvwGg8t4CI
	xr6mSgAXsJCckOgdh/yEDgLptZ1i5qUxZBF5psZvx+6uQzaZnTNhLNrH2dWXGOWadwF3dlCZfrW59
	00r301h9v4+LRhYx2TeJ7OAl1mg6/UI0JQatdW4hi2vkgBAv7VgSdTo2LH2Gta3qeTNh45JKG1U6X
	UTYI16Lt7gkdtYLQjxCUKx1ms27GgePBoXkHOnw3FbpNPYlIwEShAyH5/Sp/7uQ2D4YLfOV89dW45
	1KvUDjrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJa7J-00000003SfV-1AlH;
	Tue, 18 Jun 2024 14:47:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 62E90300886; Tue, 18 Jun 2024 16:47:24 +0200 (CEST)
Date: Tue, 18 Jun 2024 16:47:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:x86/alternatives 14/14] arch/x86/kvm/kvm.o: warning:
 objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
Message-ID: <20240618144724.GG31592@noisy.programming.kicks-ass.net>
References: <202406141648.jO9qNGLa-lkp@intel.com>
 <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>
 <20240618104234.GF31592@noisy.programming.kicks-ass.net>
 <ZnGYsdiOYjLJBX1n@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnGYsdiOYjLJBX1n@google.com>

On Tue, Jun 18, 2024 at 07:24:49AM -0700, Sean Christopherson wrote:
> On Tue, Jun 18, 2024, Peter Zijlstra wrote:

> > Also, notably, this patch:
> > 
> >   https://lkml.kernel.org/r/20231204093732.323101886@infradead.org
> > 
> > cures things.
> 
> Speaking of that series, do you need/want any help pushing it along?  I ran into
> build issues[*] and didn't have the cycles to fully figure things out at the time.

Right, saw that. Life caught up with me for a bit and now I'm struggling
with this giant backlog of things.

That is to say, if you have cycles for this, then please. Otherwise,
I'll get to it eventually.




