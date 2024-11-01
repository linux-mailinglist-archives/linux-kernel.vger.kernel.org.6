Return-Path: <linux-kernel+bounces-392760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A39B97CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB411F2131D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA47B1CDA2F;
	Fri,  1 Nov 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="V0bIjAFx"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEA13AD05
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486551; cv=none; b=QhLQZhjPgILGHPav4KpwtpZpZIrdqACk+f7WXqb93IUXv6yC7USt12s8qlV8xQvBHh6RvF2zb9DX1IVlpulZ7Towa4qeeAn3G4UzDoyRJdMlIsuBJXkyLEoFpqN8PvF4xrO6Hj6WmXUZ+0A0QxwRmxRGu2EyiBE5V1Yxoa4QYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486551; c=relaxed/simple;
	bh=HisETPZ7/4XpVnNzLz04dlXQEaup4n8C1uRrnmDa+O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyUwEAcPVV8yxjR/L4/8J4wiNI/O+sVeNPO9ws4zk0lmbT50KEWNjT1jpZxPDRZqKLaanaD+KDwmEUNpM2YEDtUqbf+JctFYWImn8IfuXd1FV1Syn94U+S41iS1/eCup4nVqPoPVHRG+M8avfqgb0SahmghZnEB3JuVsGd8EsAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=V0bIjAFx; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 5E2441770C1; Fri,  1 Nov 2024 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730486548; bh=HisETPZ7/4XpVnNzLz04dlXQEaup4n8C1uRrnmDa+O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0bIjAFxKO+e0T5ujGJdU12J6UCn5I69bfzDQvfAAHs4SWyPzMAgAUA0W++siRjqq
	 L/jIR9zNdXhbJoqt98VIQC419AQ/KDT6WDrhUVCjpZT2/FCOIB9cA/f9OVyPrFUpMP
	 yQ1P2qZN+DIU5EordV512uZ2zMC78eO7jQI3zlMVWY8FMkEG6GSzJ42sEdFCQYTNGO
	 hqqHV2+jL2kR+WMgj9A6TCHbThrSExxNIoIHixJhl0W55Vb197zicj8og09G60bAli
	 Blzfpj3oDgWOYVMmBVMWvKGvqg6E4yJ7jqtJtT2W8/YATu0BdT1lsID0N0IhY52nh8
	 CLHA0jrMgBWLw==
Date: Fri, 1 Nov 2024 18:42:28 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>
Subject: Re: [for-next][PATCH 03/11] kdb: Replace the use of simple_strto
 with safer kstrto in kdb_main
Message-ID: <20241101184228.GA38763@lichtman.org>
References: <20241101103647.011707614@goodmis.org>
 <20241101103707.290109005@goodmis.org>
 <CAD=FV=Uha5xwZJtdqirJtv27ZUBz7OP5oEnYg56v2i2mn0TrLw@mail.gmail.com>
 <20241101103128.46faf14d@gandalf.local.home>
 <20241101182204.GA752705@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101182204.GA752705@aspen.lan>

On Fri, Nov 01, 2024 at 06:22:04PM +0000, Daniel Thompson wrote:
> On Fri, Nov 01, 2024 at 10:31:28AM -0400, Steven Rostedt wrote:
> > On Fri, 1 Nov 2024 07:21:05 -0700
> > Doug Anderson <dianders@chromium.org> wrote:
> >
> > > FWIW, I personally have no objection to this patch and patch #3/3 in
> > > Nir's series (#5/11 in your email thread) going through the ftrace
> > > tree, I'm not actually the maintainer of kdb/kgdb. I'm a reviewer and
> > > I try my best to help, but officially you should probably have Daniel
> > > Thompson's Ack for them. ...or at least make sure he's CCed here
> > > saying that you've picked them up.
> > >
> > > I've added him to the conversation here.
> >
> > Sure, I can even drop this patch if need be. Thanks for adding Daniel to
> > the Cc. I probably should have run these patches through get maintainers to
> > make sure everyone was accounted for.
> 
> 
> I presume the tracing tree is involved because one of them changes the
> kdb ftrace command? Are there dependencies between that and other
> patches in the seriesm?

I assume that is the reason, I just used the same recipient list that
the original author of the patch series used a couple of months ago.
The patch series is mostly around migrating to usage of better string
to int conversion functions, so technically each change is not really
dependant on the others.

BTW, Thanks for the reviews Doug and for applying Steven.

Nir.

> 
> 
> Daniel.

