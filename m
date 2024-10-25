Return-Path: <linux-kernel+bounces-381191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E902B9AFBC5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A251C22597
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8C91CB9E5;
	Fri, 25 Oct 2024 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BPniCKKX"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66F19993F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843231; cv=none; b=F3yGSVSDpZf6qQ4e6dKzfiLShP6QGQvs+tOLzk/PauxEnJuYVyoMRJJUIvgZYlcqYQgnM9LNtRHKa77IWKqtD/S59IGz5kWrXPo+EMst37VC4oFBtQRc88zDIpssMZfcBVAFfH1ppfHLy0HdeYln6YxKWLNshmYqG3mMx0+Y1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843231; c=relaxed/simple;
	bh=iBxOH7v9wmDL38Byr8tIxELJ0VFEY68L013aapUcOOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryoBVzE3jEnmHnqwvyUrUwSQXEPGINOY6aG7OPpxJr8eIOsU7jT7RFLdBD+6tVAofP/ucHz+jEBuqi9Ci5rSY/H4Hq/KFCvKltH9hbiUNhgCgboRAz5LVcVFxHhDhB5Pe/53/fITLMJcTraLYenMb1I3JoeI7SCWRwmMECyND2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BPniCKKX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aQKtmDloPmGrB6RA+U3FqSYxbGrEs8q2+ndZxcMThL4=; b=BPniCKKXXGrAyJokVoicmL286N
	IceQjaa6vyZ1S67YFx0lrlG0P3hweWxPmBcPvfEH4SaWN8wEu6HYC27eONJ98DKyBtcv+vZ30BO/l
	9UNl4w2wod6vYlScCIHGxv0bh9hvg0ITKM9Qi2OX8xLJxUqR2j0vkt2MS0U77+Fbw6RyiKXO/VHWG
	uZ+OTbZsYATJ2zBakcJicN1hyk3tjP+3jHrVMbql4X9f/gdrfv2LhoyBuWJrOUotXJq4D/ettiu8Q
	Dtzg6LZjA6YxozwDCHkLIHP04GaQ+UTAmEBmAlPiNC5sjtiedNfSNd0F6satHrCx5yK218cvlti47
	o2BXBbDw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4FFD-00000008rCz-2CBk;
	Fri, 25 Oct 2024 08:00:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3031630083E; Fri, 25 Oct 2024 10:00:27 +0200 (CEST)
Date: Fri, 25 Oct 2024 10:00:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -tip] cleanup: Remove address space of returned pointer
Message-ID: <20241025080027.GR33184@noisy.programming.kicks-ass.net>
References: <20240819074124.143565-1-ubizjak@gmail.com>
 <20241018112259.GD36494@noisy.programming.kicks-ass.net>
 <CAFULd4bBaFWVZv=hERmHExn7ToJbJ6a+VCtZPQ3FvbPO=5EJCg@mail.gmail.com>
 <20241025074939.GC14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025074939.GC14555@noisy.programming.kicks-ass.net>

On Fri, Oct 25, 2024 at 09:49:39AM +0200, Peter Zijlstra wrote:

> Uhh.. damn. I thought I pushed things to tip, but instead I seem to have
> lost a bunch of patches.
> 
> Let me try and figure out what all went missing :/

Just this patch it seems.. I restored it and hopefully I'll not loose it
again.

