Return-Path: <linux-kernel+bounces-257333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C39378AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BBDBB2166A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC12142642;
	Fri, 19 Jul 2024 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Thh1EKgD"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E813AD22
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396604; cv=none; b=Dfxp2pyjVxFivCFroQCCT8D71/Dbx1OkCA7u7w55Xa7VQJLrsBgBesfmgKYtDbXfJNSUQzwFLCr/tlbNWJo/HTDEiHORaOO5FfTrBqFYbXzcfPsV06xdHk5C7qCLq2oxXq3rLdwBzSTzcK2IksK8Z/dgFAGakQcz4gQsvLy2B1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396604; c=relaxed/simple;
	bh=+5+Q8ThIlOkhqEyPRPk3HF6rOn92RUacwDGe8+mYcto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHl9Zso6cmPAfsDhrC+weC5AxsSFsj1Xv9QtKNA9KwVZ5wUjdI5SdBmLdJIhndKNM6ivIwzBuMsqKqAk7lHMKRJLjfEAwfX04SwZGKE0aR/2hAALQd0rIQ5EPGvjKjoTH1QWapBhSZ8dd0ARwm0t5wcJcfagH9VZBmGsWPDYfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Thh1EKgD; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1721396592;
	bh=+5+Q8ThIlOkhqEyPRPk3HF6rOn92RUacwDGe8+mYcto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Thh1EKgD8vdL4PopTFx6syiCfCoJv91dVMDNFdH5pjIRqdrejWMCGbsrXCgAcBQPR
	 AHVeEvXsMuzuLCQ25HgJxRumVll4bMaCcv3YjfPjzXp9Fq2A08hLk+jWNXAdVYJiKo
	 BSWIh5iDKuwG3atRS5FA2D5mfs4zSbunh4Gdo69oqnp/Lg4NLlQfEqTEIQ7LT5Nel8
	 AzLfVu/i1N2KMiNqeKvtADVRCDrSgtwkCCiAcr4d3iAyag6x02Z7xWeyXdQb1qj2qh
	 lexSUWCvu9RTWtYOnY2Tm+kqH9oV4KoYcuufyqk5uoAFijqhEOrrjV18icPATdrR0B
	 f6P5lmuLJWYtA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WQW8c4Lsmz1D2x;
	Fri, 19 Jul 2024 09:43:12 -0400 (EDT)
Date: Fri, 19 Jul 2024 09:43:11 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [GIT PULL] ftrace: Rewrite of function graph to allow multiple
 users
Message-ID: <ZpptbxWtKrxlNpan@localhost.localdomain>
References: <20240716162714.48febeaf@rorschach.local.home>
 <CAHk-=wiJwzMR6mZ8=Mc4bhCA3qRdwo_7NEHU80mSWoaMLTFjqw@mail.gmail.com>
 <20240718172937.2fb3e91c@rorschach.local.home>
 <CAHk-=wgQx-BiPQLe0rHLpvn1j89B8EgYPLvw0hGC-AUvF-uE1w@mail.gmail.com>
 <20240718185547.551f7dc8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718185547.551f7dc8@gandalf.local.home>

On 18-Jul-2024 06:55:47 PM, Steven Rostedt wrote:
> On Thu, 18 Jul 2024 14:54:11 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Thu, 18 Jul 2024 at 14:29, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > Basically, it's just to show who owns the copyright.  
> > 
> > .. but since basically nobody else does that, it's worthless.
> > 
> > You'd have to go back to the email address and date range *anyway* for
> > everybody else, so you doing it adds no value - and everybody doing it
> > would be just hugely annoying.
> > 
> > End result: unless there's some actual company policy, please just
> > don't do this. Because your "copyright" excuse is clearly just empty
> > words.
> 
> It was also a way to give credit to the ones that pay me. But whatever.
> I've been doing this since 2013, not sure why it is now such an annoyance.
> Was it just because patches that have been living in my repo since I was at
> VMware finally made it forward so that both companies showed up in one pull
> request? Or has this always been an annoyance?
> 
> I'll remove it, but it just feels wrong to me, as I'm no longer giving
> credit to the one funding my work, and I have no plans on switching to my
> google email.
> 
> Note, I have commits with it already, so this change will only happen for
> new code.

There appears to be three sets of constraints here:

1) The code author/maintainer wishes to use an email address that stays
   valid across employers (name@kernel.org is another example of this),
   which is a way to stay reliably reachable over his entire career,

2) The employer requires attribution for tracking copyright ownership.
   This is typically done by requiring employees to use their corporate
   email address for code submissions, which is incompatible with (1).

3) Adding the employer in the form "First Last (Employer)" as a
   work-around creates separate author entries in the git shortlog.

I see a few possible solutions there:

- We can teach git to know about this "First Last (Employer)" formatting
  and combine duplicates.

- We can move the employer attribution to the email address instead,
  e.g.: name.corp@kernel.org or name+corp@kernel.org (or whatever we
  figure out looks OK).

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

