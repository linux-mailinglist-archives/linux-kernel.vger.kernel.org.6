Return-Path: <linux-kernel+bounces-278038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3091A94A9E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4430A1C20FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711F6BFD4;
	Wed,  7 Aug 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OmfU7dYI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B34EB45
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040286; cv=none; b=uZvXO87mRk53PRLbC9jC99e+5ec5xJqWYsxqLDElI52V+4wnV2CxTIeQH52yBNuxjMbU1ha8PW4sXmuv9ASe4tkwQYWoCnBJVVtXuhPjHw5ew8I4v25H0uQPI+EhSF8swZ5K7bE7Ksw6Yo8beuvA9peEI8pwR9ygVHdncaaSqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040286; c=relaxed/simple;
	bh=6OLHSMpgGyPMhK6o+Xp+JrNQ5JAEc8sF6mB+N2XNOKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYL9K8zFbKKsfYumNNzZunlYVU1+6tZFZ7rdSwZpK5UXeno5RH0D0/mqz1i01PXiyzQsKwu7ZP0aP+LAmKe4sPoqJmebg2bAKoVEXXY21WnXMA6dFpSbycrEYwb1c4LbwPAwyQ7nV8t+AcZp9lbBG6iUcWR1sCZh4PQPYLxgl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OmfU7dYI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZAqHRLErDkYBIO/iExxKn9TkNBODCU99rDyYm28Tn80=; b=OmfU7dYISjxJ3i73JVJB+JUzvp
	qR1D0CHJkf1WeY2ecsyZih6dtYU0G2Mn79bfdagz0qN8Nh2w5ZPmDt56WOgEpydN882reSW7tjooQ
	GwTA9yM2qyyEqvq4GVye11plvyNZ/haogn8xb1HJ3R9ikfi38bxPAGjgS7Tt1wLyxk3u4p5E2KL9G
	X6ZNssg2nrZniIW5ROf3+gfY3H/Uxp06sqIin5TM0mxFDS9uUNuC0+vvX9E+kjiZYZevVBRAXdm5B
	09q6g3KTeWSnZh6F+Az7SboTrASXeYAlcStffcLh2bkfUwKrDtR0SAErmIqk1XwcTeiK4s8eCMN2G
	U8Xf7jcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbhUI-00000007Sc2-1qQS;
	Wed, 07 Aug 2024 14:18:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3729430033D; Wed,  7 Aug 2024 16:18:01 +0200 (CEST)
Date: Wed, 7 Aug 2024 16:18:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: new objtool warnings with gcc-14
Message-ID: <20240807141801.GB31338@noisy.programming.kicks-ass.net>
References: <ea203f8e-8dd4-46f6-ada5-a2bf5ea8185e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea203f8e-8dd4-46f6-ada5-a2bf5ea8185e@app.fastmail.com>

On Wed, Aug 07, 2024 at 03:56:45PM +0200, Arnd Bergmann wrote:
> I see some objtool warnings with gcc-14.2.0 that I don't show
> up on gcc-14.1 or older:
> 
> vmlinux.o: warning: objtool: adis16260_write_raw() falls through to next function adxrs290_read_avail()
> vmlinux.o: warning: objtool: adis16400_write_raw() falls through to next function adis16400_show_flash_count()
> vmlinux.o: warning: objtool: x86_init_dev_msi_info+0x61: relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
> vmlinux.o: warning: objtool: rza1_irqc_probe+0x257: relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
> vmlinux.o: warning: objtool: .export_symbol+0x5908: data relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
> vmlinux.o: warning: objtool: .export_symbol+0x35b18: data relocation to !ENDBR: stpcpy+0x0

https://gcc.gnu.org/PR116174

As such, I've been blissfully ignoring all GCC-14 issues.

