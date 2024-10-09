Return-Path: <linux-kernel+bounces-357324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BC4996FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FFB22156
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07551A0BF2;
	Wed,  9 Oct 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GxOpOsCK"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC0119995D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487514; cv=none; b=WKnC8DeGdX8XHoZo4w0IiDy+JSm0zpwmOJc7HW2GNs+7Bwubw5kdwmSQfvi/juY0XtuedZGHdSEV6mtNWNcL7kt83o0UsCly80Q7gE7WM3v1W0cCD1w/3Niy+IEBV/eVeWogHtfohSwzvEpChwmMWGf7YYeJTvgVZf1uMKrvifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487514; c=relaxed/simple;
	bh=QENbgIvXk3wyj3McRWNnfwWPHAA9ZzPsTv3Bb2wR3WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE+gdgiXBOkks40v6tqNW5pkiTDtNTANGs5W99UybBJR59bCPQ+fOd4L4mRsw8lMf2NKXQi1zbOaSnvOdPSeOkadQ9IJaesB5NHeEpYKVqhQ1L+uEd4EqbGTTa6VWrA9T6BVoiUyt11ESHTEltMg+euMCpNtC1vEdFoIgUp+F2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GxOpOsCK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kiH7BYdNDBsNBr7QSc0XYJTo5y7rZJTPwYxCfSUiGAk=; b=GxOpOsCK8n75l4Vkfce5QuZ4ex
	TpMQ7R1QgH9VB/9lykIKxdl1Z1zqx1HDTQq30Hy9H1oFp97TJ3YkyFfXa/9NC3WxLnC8bU+52Q7hc
	PtIplB8p0mDdLk/PP/cuBTnbvGSRw4NxFcEcVZB5Hc52ZXaqJlN6wUW3Pvtfykihh317suQ7U3AnS
	Y4Oo8hOuAnpofveazeK3djv/QdHKmbTzqauu616GjmFvOGxDoc/SUED/7oYsL/B87fq1jQJM2ZgIa
	5WJQTNxejpsrlZP797Z+ko3BcoYxHtKB/xmeBJr0AtiIM/2cBbRCKjnTLQvVvgeXNAjUa4Zofnv/e
	xVwBJHow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syYYi-00000004z9v-0wsL;
	Wed, 09 Oct 2024 15:25:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9111F30057A; Wed,  9 Oct 2024 17:25:03 +0200 (CEST)
Date: Wed, 9 Oct 2024 17:25:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 04/14] objtool/x86: Add .tail_call_sites
Message-ID: <20241009152503.GR17263@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194924.730517860@infradead.org>
 <20240927234247.tm4zsho6wdc5gmby@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927234247.tm4zsho6wdc5gmby@treble>

On Fri, Sep 27, 2024 at 04:42:47PM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 27, 2024 at 09:49:00PM +0200, Peter Zijlstra wrote:
> > @@ -893,7 +893,6 @@ static int create_cfi_sections(struct ob
> >  
> >  	sec = find_section_by_name(file->elf, ".cfi_sites");
> >  	if (sec) {
> > -		INIT_LIST_HEAD(&file->call_list);
> 
> Hm, why exactly are we re-initing the list head anyway in these
> boilerplate create_*_sections() functions?  I'm guessing that backfired
> here.  I can't figure out a reason why we'd doing that anyway.

Yeah, I can't remember where that came from, nor why I removed this
particular one :/

> I'm also wondering why we made these boilerplate function names plural
> "sections" when they only create a single section :-)

Because elf_create_section_pair() creates two section_s_, right?

