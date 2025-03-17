Return-Path: <linux-kernel+bounces-564158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC96A64EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B261B170C11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CADC23A563;
	Mon, 17 Mar 2025 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wXT873LF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="43KRfg33";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wXT873LF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="43KRfg33"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9E18C002
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214787; cv=none; b=Fi0dKv0udCbsedO0QBwTQsRsxt7XPSjn5tI1gHKM4u6/IgMdr0uuiMndUmxki2zTd2Y0jtohe1UgBKULnF+odwA8WgY6LcK+InCW7HFRtM1CUcDbvpmmFoN8vIcyTZwmjL2Aqbzisbn9jmlmjGk9j5Dc+vWJuYugBvtLPy/fJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214787; c=relaxed/simple;
	bh=P+YoDSdqDvrq1tETf6z4vkTYi1i4G7JrGe1IOvzPqdo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t8b1Q/wEtbM+GyGZLr8JQPl1vPM+e138PCjOn9aP7DAJsFGCxCP21w6uroK4bIo4VTVKw9YYQmgwAF4HtOXDHPXqgYI4MJDBdQq3FmyeEH8T2m4bYIsHqnR8oCQ4yB4DBPySy6pBlqT0ZeLe8wmaVmvpYKhPLJpq8Su4qxq0YG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wXT873LF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=43KRfg33; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wXT873LF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=43KRfg33; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BDCF21B47;
	Mon, 17 Mar 2025 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742214784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycHquCnIY5AaDYBOlHhXiAT5JfebgNBVE4+4dfz5mxI=;
	b=wXT873LFxwgyrWKzBqQuhYXOJ/0/frtA8KzY5ce4oE56iK1DjrYSTM9yvM0b+ljPPn56AG
	6UkdJGNkEWO2Rw8fb3311TsjlLSj/dD635m34FFnmD86LJh7Tx4Wb9IZsO0K2lAk81IbTg
	YLC6aD43QrwxYEzlwICieWLSR0f1yE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742214784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycHquCnIY5AaDYBOlHhXiAT5JfebgNBVE4+4dfz5mxI=;
	b=43KRfg331pTG/BwO7yGXqhbo9OMvW72NwdpZXVpfk+JMAZbu480M2l4K4HaAXpbJ8EXeqm
	MA0NjV1jqJySSRAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742214784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycHquCnIY5AaDYBOlHhXiAT5JfebgNBVE4+4dfz5mxI=;
	b=wXT873LFxwgyrWKzBqQuhYXOJ/0/frtA8KzY5ce4oE56iK1DjrYSTM9yvM0b+ljPPn56AG
	6UkdJGNkEWO2Rw8fb3311TsjlLSj/dD635m34FFnmD86LJh7Tx4Wb9IZsO0K2lAk81IbTg
	YLC6aD43QrwxYEzlwICieWLSR0f1yE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742214784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycHquCnIY5AaDYBOlHhXiAT5JfebgNBVE4+4dfz5mxI=;
	b=43KRfg331pTG/BwO7yGXqhbo9OMvW72NwdpZXVpfk+JMAZbu480M2l4K4HaAXpbJ8EXeqm
	MA0NjV1jqJySSRAA==
Date: Mon, 17 Mar 2025 13:33:04 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, 
    linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 06/13] objtool: Remove --unret dependency on --rethunk
In-Reply-To: <naxuqdzhtcbtq7jdc3wiee2fawjzozhhfiztldin7bnl2mhk4h@eimhmkrc6kgs>
Message-ID: <alpine.LSU.2.21.2503171332120.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <c6f5635784a28ed4b10ac4307b1858e015e6eff0.1741975349.git.jpoimboe@kernel.org> <20250314193848.GE36322@noisy.programming.kicks-ass.net> <naxuqdzhtcbtq7jdc3wiee2fawjzozhhfiztldin7bnl2mhk4h@eimhmkrc6kgs>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi,

On Fri, 14 Mar 2025, Josh Poimboeuf wrote:

> On Fri, Mar 14, 2025 at 08:38:48PM +0100, Peter Zijlstra wrote:
> > On Fri, Mar 14, 2025 at 12:29:04PM -0700, Josh Poimboeuf wrote:
> > > With unret validation enabled and IBT/LTO disabled, objtool runs on TUs
> > > with --rethunk and on vmlinux.o with --unret.  So this dependency isn't
> > > valid as they don't always run on the same object.
> > > 
> > > This error never triggered before because --unret is always coupled with
> > > --noinstr, so the first conditional in opts_valid() returns early due to
> > > opts.noinstr being true.
> > > 
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > ---
> > >  tools/objtool/builtin-check.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> > > index 387d56a7f5fb..c7275cf7641b 100644
> > > --- a/tools/objtool/builtin-check.c
> > > +++ b/tools/objtool/builtin-check.c
> > > @@ -151,11 +151,6 @@ static bool opts_valid(void)
> > >  		return true;
> > >  	}
> > >  
> > > -	if (opts.unret && !opts.rethunk) {
> > > -		ERROR("--unret requires --rethunk");
> > > -		return false;
> > > -	}
> > 
> > But but but, the whole UNTRAIN_RET stuff relies on return thunks. Even
> > though objtool can do that VALUDATE_UNRET_BEGIN -> VALIDATE_UNRET_END
> > check without there being return thunks, it simply doesn't make sense.
> 
> That's at least enforced by kconfig dependencies as
> MITIGATION_UNRET_ENTRY depends on MITIGATION_RETHUNK.

could you add it to the changelog, please? My future self would definitely 
welcome it.

Miroslav

