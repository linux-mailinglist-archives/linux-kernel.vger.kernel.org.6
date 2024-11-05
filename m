Return-Path: <linux-kernel+bounces-396639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1D9BCFE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD1F1C21D16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24591D9669;
	Tue,  5 Nov 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g+5WkUDX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A6EAD2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818729; cv=none; b=nYm2W655eCsqBsUrCfuEBRBcSyhj17GOtKlCqJuTBdlAeSA7aXEH7JMb97+2zSkOYZAfloU58Spmp7XKpDC79BfTTEhbf6JFkbjSQprV2ysgx8eVv8aZ76ddr+wA01ocENXwNZ2kTU5AvhegvA+Olr4RXv5VWc+StX6f2o3fjc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818729; c=relaxed/simple;
	bh=Hv7X4Pv/qq+CwCdbzZHu43YPCjtqRnj2aNP/cDUQofU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEzIfdMKq/Z/1W322PJVbBLOqNxpURRNAe7cBK5fQMB7fmU1M1ePK0TAZmkP8BWUuonPeOdhgRh0OMdGwqGyjdTlsUeM2BcZB/Xj+MV9dA7r30qVCEP+Wo+fUQL3Saxx4MBAT3nLZQ8cXcb/OXMMlLLwiG5XWaqb6/zKEWKvTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g+5WkUDX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mABFtAsESAZDExgqIHV5Dzkm5oWJamvGbf10+eVa9HM=; b=g+5WkUDX+GtwyMt8mFbcj3R+QA
	Uv62obxXctnWcwl632Jn8fvUQ8aPeuvCJ3/AOpDxXwFWmfX3QMVlCZHlGMUAAe2++WVOpv8ChqME/
	FNYHpHVBNgPYvJlrd/zdF7ReKXguTqiEna4s2zXiIl73+eSHjTAq9h8VmtWjp6JGB8zfUx/UFUEGu
	oMv3hkxdk3VzMGQ8Xo82Mld9UbseRnWm9ROvPHHdqzz8T+p/+0aUNpwYX80P7WQLieST/QPVzmYpQ
	cZdh4COFSxwVNVIqZ1ijemAE/Oq9RL/Mckhxmj1ZYqtLK3z6yQd55YAJILG/qJc0bHsU9jqiwnMID
	fNVaRfdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8L10-000000039d5-3eFH;
	Tue, 05 Nov 2024 14:58:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E143C30042E; Tue,  5 Nov 2024 15:58:42 +0100 (CET)
Date: Tue, 5 Nov 2024 15:58:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	alexei.starovoitov@gmail.com, ebiggers@kernel.org,
	samitolvanen@google.com, kees@kernel.org
Subject: Re: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Message-ID: <20241105145842.GH10375@noisy.programming.kicks-ass.net>
References: <20241105113901.348320374@infradead.org>
 <20241105114521.852053765@infradead.org>
 <Zyoood0ooSbpultV@infradead.org>
 <20241105142720.GG10375@noisy.programming.kicks-ass.net>
 <ZyosbEMNzMU6fOe_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyosbEMNzMU6fOe_@infradead.org>

On Tue, Nov 05, 2024 at 06:32:12AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 05, 2024 at 03:27:20PM +0100, Peter Zijlstra wrote:
> > > I don't think that is the case at all.  The is a relatively small number
> > > of exported symbols that are called indirectly.  I'd much rather mark
> > > those explicitly.
> > 
> > I'm not claiming they have their address taken -- just saying that
> > traditionally this has always been a valid thing to do.
> > 
> > Anyway, I raised this point last time, and I think back then the
> > consensus was to explicitly mark those you should not be able to call.
> 
> Who came to that consensus?  There really is just a relatively well

The people who found that thread.

> bounded number of functions that are used as either default methods
> or as ready made callbacks.  Everything else has no business being
> called indirectly.  While disallowing this might be a bit of work,
> I think it would be a great security improvement.

Well, we don't disagree. But since most of the EXPORT'ed functions are
done in C, we need something that works there too.

I think the idea was that we add EXPORT_SYMBOL{,_GPL}_SEALED() and go
convert everything over to that.

Anyway, 0-day just informed me that this patch has a wee build issue :-/
That robot always waits until after you post to tell you.

