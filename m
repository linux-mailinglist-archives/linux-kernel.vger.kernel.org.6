Return-Path: <linux-kernel+bounces-419080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A629D6939
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3B3281E87
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5B192D87;
	Sat, 23 Nov 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OxWxbiDC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E523098E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732367988; cv=none; b=XXoWBV5VYLa2NrBXCGvn9cyUaZy+tav8aptnPayhafdnkGbP5mpbWuOfxI+tgCDNSbR6+TOI0QfxvBylGVI5TkRERYpcmtfllWbBoTGmoq/axYYm7bfpv9/gYeoE2dCAI86hrmI9bqW/tq9A/Wxh7QjB6I8f3VXzRZ07PaC4dz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732367988; c=relaxed/simple;
	bh=NOpPhsvTPpJiyYwIvSbiGeu0Ok9leHgyJr4LdMTTwzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG8ncMPwrfOQrJOG9+HmG5t5fekieXCcIdSeIsG1Teh5JTdNmtidsPYM/Ehvuml441533w1k0QpMkfCJAjjl1ykN6iDYwF0BtvYkXLSKvHRrJZIivFJqT4EOR1UUPFfUV7vAaydoqInKG5kd4QMbCY+XHPdc6LGDHLJCAO2YaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OxWxbiDC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8hSaDByv+7EJLIUIjLtEvKlB8zd6vWZZ/oxIztq/51k=; b=OxWxbiDC9hqWB7Ays54xyH++QE
	UikzAIuL3aDmc1CDiP/9ZVs6n/mx1u2/ft1OTM17iaP0P9loyZ2KUUbw00mg33+S+C18KcRB/M59A
	wYCt7T/A8FkIfTbBypvIlR/rnjQYa1ZK2woDvBNaDt6OIql0rugSkNea0Tk6jm3yzKNiMZEPSSYx0
	z4I7v+uaYJ2RNXN9oKz07lncS4MNp32TYPU0zIJQjcJ6ltpm+aekeSzwkmsa/33n/DVUQGatTs74r
	xKFz9SX3l1PWnPtan6AC8N/LQoOgCoKeCsnPW1BgEYC6WtdagwNOzbCPhKF29JEVKdXZcCiIImcPA
	AxJGxNfg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEq35-00000009FL6-0KAS;
	Sat, 23 Nov 2024 13:19:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DE0BD30068B; Sat, 23 Nov 2024 14:19:43 +0100 (CET)
Date: Sat, 23 Nov 2024 14:19:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] objtool: Collect all annotations in objtool.h
Message-ID: <20241123131943.GD24774@noisy.programming.kicks-ass.net>
References: <20241122121016.372005127@infradead.org>
 <20241122121556.560621502@infradead.org>
 <20241122175445.tx3edadmof76yegs@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122175445.tx3edadmof76yegs@jpoimboe>

On Fri, Nov 22, 2024 at 09:54:45AM -0800, Josh Poimboeuf wrote:
> On Fri, Nov 22, 2024 at 01:10:25PM +0100, Peter Zijlstra wrote:
> > +#ifndef __ASSEMBLY__
> > +/*
> > + * Annotate away the various 'relocation to !ENDBR` complaints; knowing that
> > + * these relocations will never be used for indirect calls.
> > + */
> > +#define ANNOTATE_NOENDBR		ASM_ANNOTATE(ANNOTYPE_NOENDBR)
> > +/*
> > + * This should be used immediately before an indirect jump/call. It tells
> > + * objtool the subsequent indirect jump/call is vouched safe for retpoline
> > + * builds.
> > + */
> > +#define ANNOTATE_RETPOLINE_SAFE		ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
> > +/*
> > + * objtool annotation to ignore the alternatives and only consider the original
> > + * instruction(s).
> > + */
> > +#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
> 
> This is a good start, though it would be really nice to have them *all*
> together:
> 
>   - move ANNOTATE_INTRA_FUNCTION_CALL down next to those ^
> 
>   - similarly, create ANNOTATE_UNRET_BEGIN and just do
> 
>       #define VALIDATE_UNRET_BEGIN ANNOTATE_UNRET_BEGIN
>     
>     since the VALIDATE_* syntax is more descriptive.

Done these two.

>   - create ANNOTATE_INSTR_BEGIN and ANNOTATE_INSTR_END, and then do
>     
>       #define instrumentation_begin() ANNOTATE_INSTR_BEGIN
> 
>     to keep the existing syntax.  Then instrumentation.h is no longer
>     needed.  The nice comment there can go above ANNOTATE_INSTR_BEGIN.

Let me noodle a bit with this one, its a bit different from the rest.

> BTW, is there a reason .discard.[un]reachable weren't converted over?

Completely forgot/missed them. Let me add a patch.

