Return-Path: <linux-kernel+bounces-512063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458CA33393
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DDB188B588
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AA263C83;
	Wed, 12 Feb 2025 23:41:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F307262179
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403675; cv=none; b=ALzoiZ22606jUS3SbRCkzc6+JhGHKnYVvMbidZdqEZd8Br8D80M6SixaOmEbDScgq2n3ulyUGNLJZDCspuXMmtCAfTSeRsNUgPer/AaBEUia8nVUq+JRgFVa7UkkL/sNP6JWsteXJUFYUsBn3w4HbCQUaJVsozNT4kdXUphQRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403675; c=relaxed/simple;
	bh=jKvW+82hHxkw6UcR8TfyB5ic8aMwwtnzQbAsWuRh3jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skEtsod2/+CjEfHyL9ukSbmu/W7JxFwRIZvYuSc+NRjbaDGvxyLpJ+rKsWo908QD53HvmcXAEwTwRMtof6fxZkoSarX1vRFS77YyG7E6sOx+Yr9i7bb+Wc4OEXVeLTo7W0kNXpEnmgHFlIE0AUvTGMyJZ/V+jncp/mtSi6/9an0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1818C4CEDF;
	Wed, 12 Feb 2025 23:41:14 +0000 (UTC)
Date: Wed, 12 Feb 2025 15:41:12 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] compiler: remove stringification from __ADDRESSABLE_ASM()
Message-ID: <20250212234112.3i54fmgthakuxghf@jpoimboe>
References: <561c52d6-9728-4dfc-a629-353dc2488c8b@suse.com>
 <20250212233242.pnzazr3lxu3f6p6e@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212233242.pnzazr3lxu3f6p6e@jpoimboe>

On Wed, Feb 12, 2025 at 03:32:44PM -0800, Josh Poimboeuf wrote:
> > I think that __ADDRESSABLE_ASM{,_STR}() better would have a separate
> > comment, as that presently kind of shared with {_,}__ADDRESSABLE() isn't
> > really applicable to assembly code.
> > 
> > Is data allocation actually necessary in __ADDRESSABLE_ASM()? Aiui the
> > sole goal is to have sym in the symbol table. That could be achieved by
> > a simple .global (or e.g. .hidden) directive.
> 
> Hm, yes, but isn't that a bug?  It shouldn't be defining the symbol, as
> that will already be defined elsewhere.  So it would link to the local
> symbol instead of the actual static key defined in another object.
> 
> Even worse, the local symbol gets discarded during linking?  Not sure
> how that works without a linker error...

Oh, I forgot how my patch worked.  __ADDRESSABLE_ASM is defining a
pointer to the symbol, not defining the symbol itself.  So forget all
that :-)

But yes, using .global with STATIC_CALL_KEY() sounds like a much easier
way.

-- 
Josh

