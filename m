Return-Path: <linux-kernel+bounces-234609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C84D91C89F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A65828443F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6280624;
	Fri, 28 Jun 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HHP/PC/5"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCB7FBC8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611685; cv=none; b=Xr3rsVG24kN9Vo4NIuPch0yX4XjM5eT8SVEC3xgATzY/hS1zfZJhF7DDlGPfTUCQEaakGbkP/wRTrzWoTadEB/UhiCIvrH/JsoIo3NcnS8zILPRrceEp5KhGU9VK++Mw3Cmj6gRFDeuW9vifCj20Ae+tfU8yWi7RvMxbtsmtCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611685; c=relaxed/simple;
	bh=TGvo+a6f4OwAqTrR83PiQ4jeHm3RYoSxZ+9vEAFvZTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0uDSE+8oyWJqKu7GwzFu8Dk6ADU7PbcJQ08OHrBFLRQE0noPPi4NP5bzzquIpxpSahwxu/RuKCXCWzv+1bAkEd4wYApgrIM82+iIj43JiJEuM2QzoFykzW/z+d9JzSkIUaqs46sw1PLT9D4TDwmcD/ly6lRX7em53vb4vUvo0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HHP/PC/5; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d55c0fadd2so674016b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719611683; x=1720216483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBQ4Vt8YZaFIa7TCOgWzEZMv01w4sy4WGgeO9kvYN28=;
        b=HHP/PC/5CnOxd5ZCRb/hvspeHuip5EBMEXTJeeEDzH8SZeOZn77IDs6Y8pauMYEDYk
         46DWMejOyxl7a7qG5jhXLey8x+ZojN8AQo89XQ42UlTl1qzaiW7pP2vHoF1eyoxVkedZ
         cSZgvmdQcz1E2uPzZhExu3Tr/lIvsAeIqWSJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719611683; x=1720216483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBQ4Vt8YZaFIa7TCOgWzEZMv01w4sy4WGgeO9kvYN28=;
        b=EIIVAjsbn8LYQ23Y2MpJkWHj4ERN1NgqIu8dEawUUEDLKb728Tf5yiKhfP1wR1/bs1
         oik+OFVpm2G8nRUKLCERL0/cTbm55dKEakT1SqLJGUEHUzRoqUG5KSqw+Rwnj+g8XjPF
         Sl+exg8RTmXZVBr89r+SqUO6KaCAN7ot/VuEF2xyjErON8QuhVSR5iarDniDh19S3q/C
         FwYIgwAE3nIxVrBKrbKKyNmV4h4n2sMaNLn680kZVmCQVewQwqSpoCAx2hkc4sOPak6y
         HDZdgm7+gUUyVUSlKvhQ22Yi55UgR423Wg0GPRO/GP/1TyTsPYJW5Nhj/DP/I+xQ2JyG
         t2rg==
X-Forwarded-Encrypted: i=1; AJvYcCUW5eBPnBkhGvy7yRHj3jsopfh0PBKktXe3r+HltT/s6n3EVXv50A8KECUe0cp+BTfFiF4hBpdrbed18n2p5XrD4duTi32EdfVSS+TU
X-Gm-Message-State: AOJu0Yx0+HjC4v93mC6ooWSy3isS3U229tLnKwEfH5KYKHYoO9BRDiIF
	md+/5Q3yI2PT0BVmbcRqVwI4v+YD2ppAQ72eA5ghTEm0j+x4qv5lajehZfyfDA==
X-Google-Smtp-Source: AGHT+IG5QB9QymSNge2lSP8tQ09Z9iZf39eOzwcXOmu1PctYSoNH3piWISKaZ0+sDlp9F/LsUG1r9g==
X-Received: by 2002:a05:6808:10c3:b0:3d6:2e85:5c34 with SMTP id 5614622812f47-3d62e855f8amr5491956b6e.38.1719611682665;
        Fri, 28 Jun 2024 14:54:42 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:1b4:b5a4:6157:e38f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7084d7061a0sm1855023b3a.219.2024.06.28.14.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 14:54:42 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:54:40 -0700
From: Brian Norris <briannorris@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] Makefile: add comment to discourage tools/* addition for
 kernel builds
Message-ID: <Zn8xIO9aIXjxn8kZ@google.com>
References: <20240619062145.3967720-1-masahiroy@kernel.org>
 <ZnSkmmpCY2Aj5VpU@google.com>
 <CAK7LNASZi3A_BzFACOvZhwByHaVon-Cd5H++uygsv4m_fhDOyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASZi3A_BzFACOvZhwByHaVon-Cd5H++uygsv4m_fhDOyQ@mail.gmail.com>

Hi Masahiro,

On Thu, Jun 27, 2024 at 04:02:46AM +0900, Masahiro Yamada wrote:
> > (Side note: I hope I haven't placed undue burden on you; I understood
> > you don't maintain tools/ and that it didn't use Kbuild. I only "poked"
> > you because the original bug report I was replying to had you and
> > linux-kbuild on CC already. And I appreciate your engagement, even if
> > the bugs are due to intentional forking.)
> 
> I did not mean to express my complaint particularly with the previous thread.

Great!

> It is not the first time that the tools/ build issue arose.
> 
> 
> I will drop the references to the threads.

That's not necessary, IMO. I'm not offended at all by any link to my
post. Links are useful, to add color to the problems involved. I was
just hoping to clarify that I never hoped Kbuild folks to solve
non-Kbuild problems.

> See commit ea01fa9f63aef, which did not get Ack from any Kbuild
> maintainer, and caused subsequent troubles, and the benefit
> of which I still do not understand.

Benefit: if I'm reading right, you've explained it yourself below?
Without this commit, it'd be harder to integrate the non-Kbuild objtool
into the Kbuild system.

But I see that it has a lot more downsides and rough edges too.

> Supporting "make tools/perf" in addition to "make -C tools perf"
> only saved a few characters to type.
> 
> 
> So, the problem remains, unless I revert ea01fa9f63aef.
> 
> I decided to not care about it too much, as long as
> such tools are not used during the kernel build.
> 
> I am really worried about objtool and resolve_btfids,
> as these two are used for building the kernel.

And of course, we ($JOB) have 2 build-flake bugs open, one for each of
those...

> >   for all sorts of kept-in-the-kernel-tree host tools? Is the
> >   recommendation to "use Kbuild" or to "avoid putting your tool in
> >   tools/*"? Is it possible (recommended?) to plumb Kbuild stuff into
> >   tools/, even if other parts won't migrate?
> 
> 
> I do not know.
> 
> They are different build systems with different designs.
> 
> Kbuild always works in the top of the output directory.
> Kbuild changes the working directory at most once if O= is given,
> but otherwise, it never changes the working directory during the build.
> 
> 
> The tools/ build system changes the working directory every time
> it invokes a new Make, and compiles the tool in its source directory.
> 
> 
> I do not know if all tools want to Kbuild.
> (the same applied to kselftest)

Yeah, from what I've tried to read off old threads, there are competing
design goals. objtool folks claimed they want to be as self-contained as
possible, with a local 'make' target, and relatively easy ability to
pull their tree out for independent usage outside the kernel.

> I think I can convert objtool and resolve_btfids to the Kbuild way.

That would make sense to me. I suspect that vastly more people build the
kernel, compared to those that want to use these tools/
independently of the kernel build. And the rough edges between them
cause real trouble.

> > As is, I can't tell if this is telling people to avoid adding new stuff
> > to tools/ entirely, or just to only add to tools/ if you're able to
> > remain completely isolated from the rest of the kernel build -- as soon
> > as you want to play some part in the Kbuild-covered part of the tree,
> > you need to use Kbuild.
> 
> 
> See the code in the top Makefile.
> 
> 'prepare' depends on tools/objtool and tools/bpf/resolve_btfids.
> 
> If other tools are not prerequisites of 'scripts',
> Kbuild will not compile them.

Sure. So I surmise you're choosing more of my latter -- that it's OK to
use tools/ if you don't want to integrate in the top-level build.

Sounds good to me.

> Nicolas suggested a link to Documentation/kbuild/makefiles.rst
> 
> We can combine the two.
> 
> 
> # The tools build system is not a part of Kbuild and tends to introduce
> # its own unique issues. If you need to integrate a new tool into Kbuild,
> # please consider locating that tool outside the tools/ tree and using the
> # standard Kbuild "hostprogs" syntax instead of adding a new tools/* entry
> # here. See Documentation/kbuild/makefiles.rst for details.

Looks good, thanks! Repeated:

Reviewed-by: Brian Norris <briannorris@chromium.org>

