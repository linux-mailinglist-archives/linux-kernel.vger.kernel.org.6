Return-Path: <linux-kernel+bounces-576579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8386EA71159
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD118982F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEED199EAF;
	Wed, 26 Mar 2025 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVDU0bVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F22E3361
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973966; cv=none; b=tm2OHZ4Suqgale823YDAjsLyrF75ixBUMtKmC7gR6tVBwpUTtbgXiKOG5XcZd6PnlGyB/8NZ5cCFOQqYsC7QfCfJXaeBR7T1NFH/S3J8/w7YTBBgnIK01bLIOIDMMGNG0BS14S+Qed75cuxMmC0HvTTZx+pGqgfly5Y98ZoIaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973966; c=relaxed/simple;
	bh=ryLlFCUoYPsFHPn4Zxdg4J6+/YBPzj04xjSOUwX3IWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccuIOo8g2RLE9mkRpij+MEicv92+JZxAhZssHaHlxPKoMb9zm2i/vIXs8qa6489I9dd9I7bIkshsaO+zoF9xtqTB6Aqc7peQOk5lluAc7X/ZIS8qoCIR65cZtQ15S0ojev1TLD4PtoJ+QpAvZJmViPGc0TQFc9lIESO7wH337c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVDU0bVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621BEC4CEED;
	Wed, 26 Mar 2025 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742973965;
	bh=ryLlFCUoYPsFHPn4Zxdg4J6+/YBPzj04xjSOUwX3IWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVDU0bVGiDj69BKRyUOCOM6Ged/c5aWMuZIua29QL1/tqlrf4LPN5tDuaRFFpcC6x
	 8XSMzYdRoPOafj2KSCqGoV9QI/3G0B46DbKSO0nbzO8PkftZIY472daNBHj77OeERl
	 VetsjgNQgJPmGqMjDmkQXdf3xk2HWDSwkBXhM9FBB0qCXK3DZ/N9z4R5qQelFQH96s
	 8K4IgyCvmCr4R/i4+rAvCYhsohhxkD6CRy+IbmTYLWCZkVnwcsrTdnUxadH3plIyHm
	 BX1yVdzKi2JxX2gxDXd1+94mn8xnqud2qR33FrmVyXJQt1y5yG/APlaJmsbx+y5lii
	 dphrXzcBT7Pvg==
Date: Wed, 26 Mar 2025 08:26:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] objtool: Fix NULL printf() '%s' argument
Message-ID: <Z-OsCFQ_qUHjRVmV@gmail.com>
References: <a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org>
 <20250326151014.6a006c93@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326151014.6a006c93@canb.auug.org.au>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Josh,
> 
> On Tue, 25 Mar 2025 18:30:37 -0700 Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > It's probably not the best idea to pass a string pointer to printf()
> > right after confirming said pointer is NULL.  Fix the typo and use
> > argv[i] instead.
> > 
> > Fixes: c5995abe1547 ("objtool: Improve error handling")
> > Closes: https://lore.kernel.org/20250326103854.309e3c60@canb.auug.org.au
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  tools/objtool/builtin-check.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> > index 2bdff910430e..e364ab6345d3 100644
> > --- a/tools/objtool/builtin-check.c
> > +++ b/tools/objtool/builtin-check.c
> > @@ -238,7 +238,7 @@ static void save_argv(int argc, const char **argv)
> >  	for (int i = 0; i < argc; i++) {
> >  		orig_argv[i] = strdup(argv[i]);
> >  		if (!orig_argv[i]) {
> > -			WARN_GLIBC("strdup(%s)", orig_argv[i]);
> > +			WARN_GLIBC("strdup(%s)", argv[i]);
> >  			exit(1);
> >  		}
> >  	};
> > -- 
> > 2.48.1
> > 
> 
> Thanks.  I have applied this to the merge of the tip tree (which
> include the tip-fixes tree) in linux-next today.  It fixes the build
> failure for me.  I will apply it to the merge of the tip-fixes tree
> tomorrow unless it has already been applied by then.

Thanks, I've re-spun tip/urgent, so the next -next iteration ought to 
pick up the fix.

	Ingo

