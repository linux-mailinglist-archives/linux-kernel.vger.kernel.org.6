Return-Path: <linux-kernel+bounces-521278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67216A3BAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B831885AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417713DBB1;
	Wed, 19 Feb 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ju1mW0h0"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C802F41
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958743; cv=none; b=TaucyCDQHnmp9ygQBb7TCgaPqbhkuJ36hSdmN5WE2hB5C4DgYtfM4E+R196sUQGy4+1aS0Nm97UJsxbnTrAOsROI6UxFa6uqrS/VxqYciCGc9Y3pFjGON4/ea5X9B+YtFfpRfuuAPZt2q0lyUyLZa7vMBuIBQ5pIXXDuCmEDxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958743; c=relaxed/simple;
	bh=XZ2lwBwo85teQOgmVlOEnNBWSzEzPPKbTZLLoPLLVvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7gPzG77SEvuIIk/S6sg4P2lNWoeCSKIgw70vHYaBR/mlEaezjNP6Y4M4x8cE4682AdlTLFvu56l9cfQ4j1tw59RxVZmeVPUXf4waB0uVY0sSCzy3L71rt+0TSlHhVFgB5R9zA5Ku8Fw5MkSTdn+wbrGhdlIHXzdFBUd9+6Tl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ju1mW0h0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zd81wZXoRTT549uNVsj2b3Gw/cAxcfAyDt+g9BxgFq4=; b=Ju1mW0h0rjBMofkvR2jLb3lHZM
	hUB8+9zibpcWLj1zTNqTcU5PuMkAfBL+Jw8zcvjo/Y4IuUamvtD0xu9Kz/CEuurAZbCvC9+TOcKUC
	5AOf09WF/UGgYXx0bXg3/2kRZwubIqOPsCh7OtQ5+8xdwCCkmLaMgby3/2amf6w/VvRQftoglilgS
	JuD2aMpnbEgQL680CplzJ9rg+E0d+ngcT/moDggaO38kgdIdFVVBr1QuZnfOEYKM7ax8fxM3aGdr5
	rsiYeKeTZQJeM7+ahwcv5So0/lOC73ELYB4N9di/4891DpcfoB/zoQUh3LcZMMaAappAEUK1ziZ8+
	rUaP945Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkgkc-000000027rj-1xTC;
	Wed, 19 Feb 2025 09:52:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 68DCE300783; Wed, 19 Feb 2025 10:52:17 +0100 (CET)
Date: Wed, 19 Feb 2025 10:52:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] objtool: Use idiomatic section name for relocatable
 rodata under PIE
Message-ID: <20250219095217.GD34567@noisy.programming.kicks-ass.net>
References: <20250218092538.1903204-2-ardb+git@google.com>
 <20250218173827.vk4gplulq3pjdnn6@jpoimboe>
 <CAMj1kXHqS=fTOa13LHqs1bqxy-EeD0xNUGxJA4xK=bKya+XBwA@mail.gmail.com>
 <20250218183108.anuqoojsgkjxwfai@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218183108.anuqoojsgkjxwfai@jpoimboe>

On Tue, Feb 18, 2025 at 10:31:08AM -0800, Josh Poimboeuf wrote:

> > Fair enough. But better to drop the previous patch from the objtool tree then.
> 
> I think we can do that... Peter?

Let me see if git wants to co-operate :-)

I think I managed to zap the top commit of tip/objtool/urgent.

