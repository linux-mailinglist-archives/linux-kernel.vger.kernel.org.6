Return-Path: <linux-kernel+bounces-209950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521F0903D47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3781F24FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB317E44C;
	Tue, 11 Jun 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2Yfa9KS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F417CA1D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112378; cv=none; b=qVnaRjHqh0MSuKgOHQrdMbTb9reWycMNaUwZiZAPh0vzN/KDBSLd3rg/H6F/E7QyGeWlbx/m6I6Dn9IQCgRcghY27tIdKq0dy+H4purKcFhYkMqQbc4eW6G3cinL3Qk2pdyNhXnsRG85KvOiQ+SC2fH2T7OlSr1qLIlWmPkcViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112378; c=relaxed/simple;
	bh=ajXBz2ktbB1pyarbdNgc0OYhAYmvu8ktAdBboXko+64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLM2bfoXtB0i9UC4xDiWfkxKe2pU1ZG8A+Yd9siwZC+xy6XaH3F0KUVBT4mF8RqEwUnRepLS6ci8qL8Yt77uoWHL5gGj9SgdAxe6lSacDculDb4DEqHRT8s9R6P0ODNbjAlKYqMZ71BigIdUVJV85RpWstGtCLHAUoYo28H476E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S2Yfa9KS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WvNhp+Fkus5gZ4B/gqjVnlOIUixgCRQNYsydZIjO7mI=; b=S2Yfa9KSJEpQ5cREEQUiyIfCMI
	AQ64vGntshyatBw0QbiAOEUdttu3MV5mSrJZDH8oGmasviTjulLFZsqfBpMXqLXue+6l1PELg0CiJ
	mcoIKakqsl0vU1UnyO263SLgVOFXe89qRTpuxnj/8ajBW6BucT0dOvnMz3pti+vxNDDsuJXL4euo2
	d+gndTEN7XRJ0YSX1o1C2m3XIc0PjX57b8HREmJotCCPJzmDJWQBzvccCG8u4qSEuvkf0fxmAyV6o
	8h+OzLuqAeodcRJYvY2N9oAekRITUmAaHh2iTuEv/TRsAvhvUy1OlQos+IXXB2bljW4EWnmzC+xrx
	87ZyZcUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH1Vp-0000000BOlI-38uH;
	Tue, 11 Jun 2024 13:26:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 27C2C302792; Tue, 11 Jun 2024 15:26:09 +0200 (CEST)
Date: Tue, 11 Jun 2024 15:26:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [PATCH v1 00/14] x86/alternatives: Nest them
Message-ID: <20240611132609.GH8774@noisy.programming.kicks-ass.net>
References: <20240607111701.8366-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607111701.8366-1-bp@kernel.org>

On Fri, Jun 07, 2024 at 01:16:47PM +0200, Borislav Petkov wrote:

> Borislav Petkov (AMD) (13):
>   x86/alternative: Zap alternative_ternary()
>   x86/alternative: Convert alternative()
>   x86/alternative: Convert alternative_2()
>   x86/alternative: Convert alternative_input()
>   x86/alternative: Convert alternative_io()
>   x86/alternative: Convert alternative_call()
>   x86/alternative: Convert alternative_call_2()
>   x86/alternative: Convert ALTERNATIVE_TERNARY()
>   x86/alternative: Convert ALTERNATIVE_3()
>   x86/alternative: Convert the asm ALTERNATIVE() macro
>   x86/alternative: Convert the asm ALTERNATIVE_2() macro
>   x86/alternative: Convert the asm ALTERNATIVE_3() macro
>   x86/alternative: Replace the old macros
> 
> Peter Zijlstra (1):
>   x86/alternatives: Add nested alternatives macros
> 
>  arch/x86/include/asm/alternative.h | 225 +++++++++--------------------
>  arch/x86/kernel/alternative.c      |  20 ++-
>  arch/x86/kernel/fpu/xstate.h       |  14 +-
>  tools/objtool/arch/x86/special.c   |  23 +++
>  tools/objtool/special.c            |  16 +-
>  5 files changed, 125 insertions(+), 173 deletions(-)

The whole back and forth with the n_foo things ia weird, but sure, have
at.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

