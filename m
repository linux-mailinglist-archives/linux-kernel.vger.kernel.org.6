Return-Path: <linux-kernel+bounces-382980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607929B15CA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E3283331
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147DB1632F4;
	Sat, 26 Oct 2024 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hreNoY2j"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12641C69
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927122; cv=none; b=nyeytXBv1pPe0dKXoHn9gqb9iunTmPd357SoBKHnmrxKoWlBYLuzSAK18Nv4/+MJgyvXLxacl6m8r3U+IdofIZJqlMPZW0YNqVF1xg5k4Ft8zeMJcddYfRSzJ8u8BhGYSMqS/oYSOzXEJn6OQCZ3PConq5dKJ2yTwxKh1V+ajyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927122; c=relaxed/simple;
	bh=v2F+Uwd+rnv1ZRUutl24enNLFXscfELx6NJ45+JHoBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns9Jyaer2odQR3x7flp1h9ZVAQ1XXyDh/NyBWfsR6s9dcmhAbEVBENc+67uGDevSftbepJ5HwPbvTwMm2umIX/9q0tco3h3rsRwmORe44mHJJXQD6+KryTALswaWP0uJH5LDvbuo9zhLitAYsOrFUYUpqyiO0Jk9ne+1EnSzk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hreNoY2j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Q63a86k5XYwmdbNhaw0GHv41+nXV1YLAOj1DLRqmdQ=; b=hreNoY2jR1OmC5rKp94TtgkktK
	Je/YokfXSzVtH4r3KQaGyDKqtn7z7bPMLAizpejFI17cmGeeOXxFD6W5vLWtX8XTxsVGui4rJO+bg
	XyHW1FEM+uqcSvrgUg39nVwiEKY6p6Cdl89NvZbATXUkNPImq6EcQQBDpWsVJm6k7EYCBr02ZTFHn
	JNydnDNH99ksxcSj9sguPhBi5rBVLEI6oddJYEuOrs7mCAMCowm4BLUim+AlOOpXogvIAn/7J5IV4
	kHsVWMl3Lo4M0wUM3n65MoKd6meHhfTa5aShRR/lnVz1oFOckQZRxXA6qktjwqN33VJRj9wbVEUfE
	fpgcb8aA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4b41-000000062vB-22C4;
	Sat, 26 Oct 2024 07:18:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 52934300777; Sat, 26 Oct 2024 09:18:21 +0200 (CEST)
Date: Sat, 26 Oct 2024 09:18:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, void@manifault.com,
	vincent.guittot@linaro.org, juri.lelli@redhat.com, mingo@redhat.com,
	bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
	vschneid@redhat.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Pass correct scheduling policy to
 __setscheduler_class
Message-ID: <20241026071821.GS33184@noisy.programming.kicks-ass.net>
References: <20241025185020.277143-1-aboorvad@linux.ibm.com>
 <ZxvxR32TQ1UIVLtS@slm.duckdns.org>
 <20241026065247.GG9767@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026065247.GG9767@noisy.programming.kicks-ass.net>

On Sat, Oct 26, 2024 at 08:52:48AM +0200, Peter Zijlstra wrote:

> > Peter, do you want me to route this patch or would tip be better?
> 
> Once I've figured out what the word soup means and reverse engineerd
> what it actually does I'll probably take it :/
> 
> That Changelog is horrible

I've rewritten the Changelog and stuck the patch in queue/sched/urgent
and will move it to tip/sched/urgent on monday or so -- it's too late to
make Sunday's -rc.


