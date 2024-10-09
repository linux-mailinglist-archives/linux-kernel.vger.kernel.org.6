Return-Path: <linux-kernel+bounces-356477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2289961A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAEE1C21A47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3512D18756D;
	Wed,  9 Oct 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nIiQyS/w"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35050161313
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460789; cv=none; b=Cycaw0DFWn8XTqBghHcScVT3u29fUq+3Mzb/JBZpH+ramD0ecbImuPCcnubC1xWZV5WokaL4GVCMHJdQ3rWhMGW+hLd5SQTJEJzEFkLZnGbXrQzTUCSWBHYEeKwSzQBLGHkDnQ2xezJ4EdmU25lSp85ltDWtU/eoRnKwJ6Eq1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460789; c=relaxed/simple;
	bh=NtkkC9cKU1K+qVn9JLh2QDpPskRJX9/onIMcTZpR/4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2xLi5In6rf62mpwsjZ352GICy/pWOBmyypH7J/xBa3MBEcE+DEpbZJXs1QkGXznIUppcRJPtTwpt3f6UmjNZeC2UyFeB9l36rxgjUFQhlovfjBB7Ftg0ZMbExGAqZwZ1ElTMyEFCC9aBaGKmWoqGo4h5X9FzQKIC7LWhFIg1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nIiQyS/w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c9WmE5c7tLHVrpCuyh/YSp61LyOD2QR9c/D3p4uyZWA=; b=nIiQyS/wTdP+r7h27/m6FGr/zN
	5aERAKz1SZQmcXLQliL4InHMTn0TTtozBb02QBxlIjerVvNgPhpCl0Jp60HexwC9ckp6Lb04PV8vD
	zeFgCqJ9FKI4hNIuCGIy99jpZnrPy/KvfyAeLy+Q+tAui7w/MgyCw/r51kzrSN1LQQ6m17Pq5Xg2+
	jmGjRRfE6dHppGzg0V5C42RF8F9rLEJm0Q6ReiVImzb5MbKO/i5a+303Cta3PkHmuqSgBNr2FqwSM
	iEjnGiK5TmPBcSQuzz38s/7CXRgdlRUaJjh/1LG5ebzDIeP2ylx5VspCWKwRB5uR8EwHIURRpiLIS
	NbTNvaLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syRbg-00000004KOi-2Y03;
	Wed, 09 Oct 2024 07:59:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BCC1A3004AF; Wed,  9 Oct 2024 09:59:40 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:59:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bp@alien8.de, david.kaplan@amd.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC][PATCH 2/2] x86: Clean up default rethunk warning
Message-ID: <20241009075940.GI17263@noisy.programming.kicks-ass.net>
References: <20241007083210.043925135@infradead.org>
 <20241007083844.119369498@infradead.org>
 <20241007173345.yokak3mlnqpsuxty@treble>
 <20241008072502.GC14587@noisy.programming.kicks-ass.net>
 <20241008164514.ky7ybaoitytvbwlp@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008164514.ky7ybaoitytvbwlp@treble>

On Tue, Oct 08, 2024 at 09:45:14AM -0700, Josh Poimboeuf wrote:
> On Tue, Oct 08, 2024 at 09:25:02AM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 07, 2024 at 10:33:45AM -0700, Josh Poimboeuf wrote:
> > > On Mon, Oct 07, 2024 at 10:32:12AM +0200, Peter Zijlstra wrote:
> > > > Replace the funny __warn_thunk thing with a more regular
> > > > WARN_ON_ONCE(), and simplify the ifdeffery.
> > > > 
> > > > Notably this avoids RET from having recursive RETs (once from the
> > > > thunk and once from the C function) -- recursive RET makes my head
> > > > hurt for no good reason.
> > > 
> > > This could use an explanation for why the ifdefs can be removed and why
> > > the alternative can be removed.
> > 
> > The alternative is in the WARN_ONCE now.
> 
> Ah, sneaky... It should really be called WARN_ONCE_AFTER_ALTERNATIVES or
> something.

Yeah, I suppose it should.

