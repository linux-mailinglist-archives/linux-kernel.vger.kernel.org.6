Return-Path: <linux-kernel+bounces-562039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C950AA61B10
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C8C17F255
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D22200119;
	Fri, 14 Mar 2025 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEjCLyNP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EBC1FDA6B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981956; cv=none; b=VMV8sx/0K0+fRPEAvPvNOkC4jFfG8C0h0qymWLB8BU5bnrWK3RXcakcc6uTn0oCKQmePhxzeX+USS+9xuQflv1tFvstsqnbuAGO+PDohOUYCSxZ3fP0xj7eqX1XhNd7P/4LP5sYpg1X6yaveZVCknvQdp6MNB45tqgmQA+ExX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981956; c=relaxed/simple;
	bh=SNxQZPpn8eghGhC1SM5t9zzHdc2GMHnEhLsIrqSDMu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7t7fGrAjDFrzJMEIAyLm/Ej8Pe5yKgiPK2RgMsug7JoC/3A2lbWS8tj124A6NhAXtPnSqoY1vTRqJ3+fFnzz2IhErNaEEUKQu3k2I0LICkrmf+/ByJsYAMFeQ+C2GnbFwDOKvxXJyPqChLr/vler26RkhEp4uE9jSQvUYjd2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEjCLyNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6867FC4CEE3;
	Fri, 14 Mar 2025 19:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741981955;
	bh=SNxQZPpn8eghGhC1SM5t9zzHdc2GMHnEhLsIrqSDMu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEjCLyNP/OUvIakglKK/a6rjryc2nkl0AdXHX+WXAUeghFMN7KqdJM41hL2/TnKxj
	 jA7Qnusv3e6ll0sOMmr2dJF37kX/vJ3/s+yRC2uAt47s1ynu7JESpD1aV3CeJQyHMA
	 HsE8IRJvgBdtkhUtAnxDdg4/4x0kvGjWAgj1CsYytDjRP2kUvchrl5uUlk3r3N97PT
	 sKsgKN2cNZWDHLhH0T1/wpT1DWCM8oQyk4QXFaXfZKHmR55o2VSiMhgjXK+spPMCJp
	 o8s/mLIaMU5aYTmhCFvVp1TaJilX96uaWQItTbiAp04tY/TW9NdXAdn0BfnlbVqqxm
	 r7dtDrf8Qsyig==
Date: Fri, 14 Mar 2025 12:52:32 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 06/13] objtool: Remove --unret dependency on --rethunk
Message-ID: <naxuqdzhtcbtq7jdc3wiee2fawjzozhhfiztldin7bnl2mhk4h@eimhmkrc6kgs>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <c6f5635784a28ed4b10ac4307b1858e015e6eff0.1741975349.git.jpoimboe@kernel.org>
 <20250314193848.GE36322@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314193848.GE36322@noisy.programming.kicks-ass.net>

On Fri, Mar 14, 2025 at 08:38:48PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 14, 2025 at 12:29:04PM -0700, Josh Poimboeuf wrote:
> > With unret validation enabled and IBT/LTO disabled, objtool runs on TUs
> > with --rethunk and on vmlinux.o with --unret.  So this dependency isn't
> > valid as they don't always run on the same object.
> > 
> > This error never triggered before because --unret is always coupled with
> > --noinstr, so the first conditional in opts_valid() returns early due to
> > opts.noinstr being true.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  tools/objtool/builtin-check.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> > index 387d56a7f5fb..c7275cf7641b 100644
> > --- a/tools/objtool/builtin-check.c
> > +++ b/tools/objtool/builtin-check.c
> > @@ -151,11 +151,6 @@ static bool opts_valid(void)
> >  		return true;
> >  	}
> >  
> > -	if (opts.unret && !opts.rethunk) {
> > -		ERROR("--unret requires --rethunk");
> > -		return false;
> > -	}
> 
> But but but, the whole UNTRAIN_RET stuff relies on return thunks. Even
> though objtool can do that VALUDATE_UNRET_BEGIN -> VALIDATE_UNRET_END
> check without there being return thunks, it simply doesn't make sense.

That's at least enforced by kconfig dependencies as
MITIGATION_UNRET_ENTRY depends on MITIGATION_RETHUNK.

If you wanted to enforce it on the objtool level, we might need to do
some makefile acrobatics to defer --rethunk to vmlinux link time for the
above mentioned case.

-- 
Josh

