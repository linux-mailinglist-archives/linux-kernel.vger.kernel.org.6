Return-Path: <linux-kernel+bounces-342469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A37988F62
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792EC1C20D52
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD71885A6;
	Sat, 28 Sep 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fn+slwcQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1718756A
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727529822; cv=none; b=eaH3yuz/b+urFpJHM9J20s+XJneejUQYavy6sPI2UeDjyC+LjlohjMe3nXNMb3qQwH5WHp7pr1YoE6jSDICNKBSn51pJKgAWN+kMtBdfgWP/2A+DNm0zvfoeS9rAdRrJJ42IxrN2I+KWtH3wUwFfLEOJ/Q6VynEgSW9meTBODmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727529822; c=relaxed/simple;
	bh=PVLD29RbO0UyUBGRxzYsPB0550F+z/gI1Q9DWo2xvxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4yF75pHLwgTfS7+CNkd+QQCJjYVhVZtvX6NG2B9DAyfEcVXsedmi8BP3lDJ5KEHrShn3W1hBoCTqK2uLQL26Ln+o6w8F3DTj5K8ywV4M18cSSaQaJYDae4QNKhCxNEugKtuRxYp3MN/ATgNwP9TVbPQnJ8p0dueojW7OMfwHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fn+slwcQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3aUbnD47ohkQ5kQivXOzBFel1x/he7+AbsRAobhfigI=; b=Fn+slwcQglQ7Ac5V8+plHsPR0D
	M/oQbcqOSLeGD7SkD84aVtIrE/GgeIuE0p6UMxGgEKID+AupklG7sORb5XiCLMbP3zX23uxrLuMnt
	xLeyaUGO0drNtt2zcfk0jFiSqX+oIEFuqw1GdEDvDA/5p9Y+cWJnnTWXTeaBu2UcUTrp+eUDx1Z+7
	nGyhQPisUO+M2XTQ/2JhonCMTvZhKwybFOEewFOTLIZ7v3nHW1fUMUfGUuLbqsNlYgw5YBbSzwvJh
	9wTOvbud2t0jjkfxj1zx8KVIIxIaKpRMVx8a+r7TS245P5WumzR0zhT8lLGxM/3kyIJxhihRcYn3u
	LWw2je5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suXPz-0000000CLAO-2JCo;
	Sat, 28 Sep 2024 13:23:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BED1E300848; Sat, 28 Sep 2024 15:23:27 +0200 (CEST)
Date: Sat, 28 Sep 2024 15:23:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 13/14] x86: BHI stubs
Message-ID: <20240928132327.GD19439@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240928013736.tirg3rivjf2nb3am@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928013736.tirg3rivjf2nb3am@treble>

On Fri, Sep 27, 2024 at 06:37:36PM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
> > +static void *bhi_args_1(u8 args, void *addr)
> > +{
> > +	u8 bytes[5];
> > +
> > +	for (int i = 0; i < 6; i++) {
> > +		if (args != BIT(i))
> > +			continue;
> > +
> > +		bytes[0] = 0x2e;
> > +		memcpy(&bytes[1], &__bhi_args_6c1[i], 4);
> > +
> > +		text_poke_early(addr, bytes, 5);
> > +
> > +		return NULL;
> 
> I assume there's some good reason this doesn't return a pointer to the
> code like the others?

The 1 bit case is different in that it does in-place CMOVcc while the
others do a CALL to an external stub.

Not saying this is the best way to do it, but it's what I ended up with
back then.

