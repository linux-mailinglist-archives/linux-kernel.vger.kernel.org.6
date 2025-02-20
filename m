Return-Path: <linux-kernel+bounces-523576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A0A3D89F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C286189138D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D471F460F;
	Thu, 20 Feb 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tY1va3X1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA51EB5C1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050840; cv=none; b=Akvwytx+NiIFkXqrjKZZ6i7kGSbJME9ddsN8YXgQIXsWQgrtTF2Oo0wM0kSPGEkAF4MWWP9MqZFGqCRdG8ii+zKHtmEE8RQVIFt4dn5Gow+ZKjHH7cCWFB3vPt8npkGbk3OkW2gLPg/rH9Fo7wQoW3pcJgzkNj9ulqs72kVPwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050840; c=relaxed/simple;
	bh=ZrlRfrcBXh4uaH0Ud+OUgXEPg7k8eqGRpbqwRuRQEc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwmkqxOs7J6TMwnkqJGKuD2n1yXdkUaPT5kSmX8VLl9oz6mPpdYDa78n7cdUjLTUUSsP3xyV+YUyXhlcjZ/eP65SyU0bOWZ7Iz1IRVW8bgWyaiWDugTzRt6zzGDsBSp2CsFa1bHDTc8lKWsiE4J3FazvOCRcw4BgF94Jqsx3yzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tY1va3X1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xeieqahpS1+yJtpt/ipGZCcQwPWo1aVFI5tk9S0PZhU=; b=tY1va3X1uwaU2ZKt/+jqdSJUWY
	ePxCbX1xb3etkeFOzffue+f2+9pjNoExM+MWBJMC5zKckArxIWlkW3KeTVTTI64CBNpdQM7Fg1xwe
	PCelEW4LiNmaRyLcXB4diNP3iIlhtw9swOHnePPm3zgIhNvz5nxoMAi2bJ1qhyEg3gH1SJ68yi/aw
	zfJ26SgSUbYdW/lKSt/inDK5GaYlsWg1wkwoA6Z53xE/6P/MluNujtNn899N3+tDi+grYV5ko1MTa
	A52cgpnku0x9GcvfOZcbzEtL5uD/zG4FbSAHwvetzVl7R0HxniSiPNpDz7tg8hSfRQTuYR/YzVPuq
	hm/6smNA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tl4hz-00000009PWb-1Xh8;
	Thu, 20 Feb 2025 11:27:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5B7B300677; Thu, 20 Feb 2025 12:27:10 +0100 (CET)
Date: Thu, 20 Feb 2025 12:27:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, kees@kernel.org, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org, jmill@asu.edu
Subject: Re: [PATCH v3 00/10] x86/ibt: FineIBT-BHI
Message-ID: <20250220112710.GK34567@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219162107.880673196@infradead.org>

On Wed, Feb 19, 2025 at 05:21:07PM +0100, Peter Zijlstra wrote:
> Hi all!
> 
> Having landed much of the previous series in tip/x86/core, I was hoping for an
> easy time landing the final two patches.. alas.
> 
> This whole FineIBT SYSCALL pivot thing showed up, which got me to develop the
> paranoid FineIBT variant. And because testing I added a cfi=warn knob, and then
> I migrated bhi to an option etc..
> 
> Then just as I was to post this stuff, Scott out-nerds me with a whole new
> instruction sequence. Which got me to rework the entire pile once again, and
> it is now another 10 patches again :/
> 
> Anyway, be warned, Scott loves overlapping instructions.
> 
> This is tested with:
> 
>   cfi=fineibt,warn
>   cfi=fineibt,warn,paranoid
>   cfi=fineibt,warn,bhi
>   cfi=fineibt,warn,paranoid,bhi
>   cfi=fineibt,paranoid,bhi
> 
> Also note that LKDTM's CFI_FORWARD_PROTO test will do a double splat for
> paranoid in warn/permissive mode, since both the caller and callee hash check
> will fail.
> 
> Also available at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fineibt-bhi2

I've updated this tree with the latest version of the patches.

Notably, Kees, I've not taken your Reviewed-by tag for patches that saw
significant rework -- even when in response to your own feedback :)

(ud_type propagation is now gone)

I'll repost in a few days, to give people a chance to catch up.

