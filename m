Return-Path: <linux-kernel+bounces-181578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F188C7DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443531C215E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092A3157E9E;
	Thu, 16 May 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LAL413as"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B415CB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892745; cv=none; b=rSQLnfssFU9dVC3JJF+kj+xI/j1kUnWeb0dFTtv5Xb7oU49qRK/3cgbXgxhPHNmnm4YXmpZM/FhX45Gjr0lt9eFaTRgRCI8zfBOMmuQHTVWtbFpnVT/fX86nchb/OqpaezwcOfNtaZDLpXdzlnz8/78WCXXh1UpOnIa3HfnUeFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892745; c=relaxed/simple;
	bh=tVODxaTXe1VJWK72M3wkpqVogEldieF3m7bSsMs8jIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNVpk1ksJnWYqqU85id2A4vh8zQjIuBjvv5CHjXfOW90NHmkp4sZep/PF1bYDVGHdKqRBJZ8yzbWUMHhzNhLRAeZVMsKNF8v7NuxIZsLKgH5HOUFL0MqKDkFKVAObl3yBceb2bvSiXh6m/AKsV0dbggIOz1kJ190QstTa4+/FXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LAL413as; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (99-196-128-135.cust.exede.net [99.196.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44GKpaRr012754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 16:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715892707; bh=SOtluD1PaXHX4aLfHVPP7s3eptH002zErJfg39HNDSk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LAL413asy4CTYAoR3vtKjzRUe9/Y5ZKBHnX4D7QBrLySjGcmNL/TA6b/3nF4L7OW6
	 auGZzHOYkeWzK33jCS14SqF32HnyLSwxPfpglAASB8vbXfv7A2zObdTAjV2nzCq0gk
	 m3CWrF5/sUKerMQeqpL1UlyPsZg2cRQOfjRfMox85NiCHzApmIyP4rbralHvruTPzb
	 s9EMU8horV31wPgD29MyYcikq36S0G1/t/YZk4eJPIO63PqEU2KOY7H6gWiWbv8Vwt
	 CspH+ti7/1rz0YO7O8w8MOiyu1S1gXy7FSoB+hB49nwfI7z+rpRsp4dnDz6sPrhubc
	 eVS++1v7+PG0A==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id F15DF3403E6; Thu, 16 May 2024 14:51:34 -0600 (MDT)
Date: Thu, 16 May 2024 14:51:34 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: Justin Stitt <justinstitt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240516205134.GC287325@mit.edu>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net>
 <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
 <20240516140951.GK22557@noisy.programming.kicks-ass.net>
 <CAFhGd8qCCCrccQ2z5bjBD5YcMWHkym9aVz_qYkyyj662XEeHvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8qCCCrccQ2z5bjBD5YcMWHkym9aVz_qYkyyj662XEeHvA@mail.gmail.com>

On Thu, May 16, 2024 at 12:48:47PM -0700, Justin Stitt wrote:
> 
> It is incredibly important that the exact opposite approach is taken;
> we need to be annotating (or adding type qualifiers to) the _expected_
> overflow cases. The omniscience required to go and properly annotate
> all the spots that will cause problems would suggest that we should
> just fix the bug outright. If only it was that easy.

It certainly isn't easy, yes.  But the problem is when you dump a huge
amount of work and pain onto kernel developers, when they haven't
signed up for it, when they don't necessarily have the time to do all
of the work themselves, and when their corporate overlords won't given
them the headcount to handle unfunded mandates which folks who are
looking for a bright new wonderful future --- don't be surprised if
kernel developers push back hard.

One of the big problems that we've seen with many of these security
initiatives is that the teams create these unfunded mandates get their
performance reviews based on how many "bug reports" that they file,
regardless of whether they are real problems or not.  This has been a
problem with syzkaller, and with clusterfuzz.  Let's not make this
problem worse with new and fancy sanitizers, please.

Unfortunately, I don't get funding from my employer to clear these
kinds of reports, so when I do the work, it happens on the weekends or
late at night, on my own time, which is probably why I am so grumpy
about this.  Whether you call this "sharpening our focus", or "year of
efficiency", or pick your corporate buzzwords, it really doesn't
matter.  The important thing is that the figure of merit must NOT be
"how many security bugs that are found", but how much bullsh*t noise
do these security features create, and how do you decrease overhead by
upstream developers to deal with the fuzzing/ubsan/security tools
find.

Cheers,

						- Ted

