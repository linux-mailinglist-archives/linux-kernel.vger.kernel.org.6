Return-Path: <linux-kernel+bounces-344893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D5298AF58
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135CE1C20D33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2E185B75;
	Mon, 30 Sep 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0XgBC0u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19F7DA68
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732540; cv=none; b=ENnp27N5J0+2UtVvkRo4VodrIvp2NZdnuQVi75ZbcsUtwt8nkx/s0SunzLhNl1MOGJoeWpSOpbzWrYtATs/MQ8RkGszCXScQ6W412CYpdPtew91bffIKEnk+n67+faczYnSlbWcy5gHZQ23KeaF9YLL03nxNDJIiAefiJl36Bxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732540; c=relaxed/simple;
	bh=IHAUZN9wQ0EuPwq4w/2P0MZkG4Wh/BqQoZGVddP90KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lty+yVExTz2WUOfUt8L57qLluu8wrXv5vUb5IuggKvEyvfapnzE4kFa9oCMfNfUVDIlG35Htmr0pnjN7PwP/xuXH6qgATOvVuZ2A4pQOVnUHFkzmasCQo+IqrJS3ilJTYmqjPCeiQG967asGpaTwCtDb/KN6sVNWlf2vFOQ7zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0XgBC0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B811CC4CEC7;
	Mon, 30 Sep 2024 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732540;
	bh=IHAUZN9wQ0EuPwq4w/2P0MZkG4Wh/BqQoZGVddP90KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0XgBC0uNtFVDJRjE0fsxtZxc1eJu0D9ZP8mCQDa6FTeOCXE1NGZcjBDKawTfjzLR
	 RIgN2Px3Jz2fJLpG69PI1e9NSEpQGqPOkZ3k38a9HeIEY7nRjBsZg1rPE46ZGD6ckV
	 ozl7/NMJUuxdDXKAjlNYwgvBE7EA6vjBINPMAMGkeuqlNHk/jNXUASj7hEM2zAPL1F
	 +hRyGBM2/UyxR8KbPN2dU/OZ4liW9djyjdpVMAUrbOn0b2ss+JhW3Io72bCQi7ePjd
	 kjaP3Ucew9Tn/Ou/wlFwXolUmijjNNQhmXOfgW2mNiihQfBYl05hKG3H2sYC2ZP3HT
	 oltNbYSPFxuxA==
Date: Mon, 30 Sep 2024 14:42:18 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 01/14] x86/cfi: Wreck things...
Message-ID: <20240930214218.aysuqlecl6olflow@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194924.390462812@infradead.org>
 <20240927231527.em2a4cjbnpos6c4u@treble>
 <20240928133114.GE19439@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240928133114.GE19439@noisy.programming.kicks-ass.net>

On Sat, Sep 28, 2024 at 03:31:14PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 27, 2024 at 04:15:27PM -0700, Josh Poimboeuf wrote:
> > Even better, require exported+indirect-called symbols to use
> > EXPORT_SYMBOL_TYPED, otherwise they get sealed.  I suppose we'd need to
> > add some module-to-vmlinux ENDBR validation to make sure modules don't
> > get broken by this.
> 
> So I like this idea. but yeah, this is going to be a bit tricky to
> validate.

If Module.symvers had EXPORT_SYMBOL[_GPL][_TYPED], objtool could read
that to decide whether a given module indirect branch is allowed.

Objtool is going to be getting support for reading Module.symvers anyway
for klp-build so it should actually be pretty easy.

-- 
Josh

