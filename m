Return-Path: <linux-kernel+bounces-393568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 059069BA26F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95059B22420
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D471AA793;
	Sat,  2 Nov 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="m0Pttq71"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F734EB50
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730579489; cv=none; b=q+Gsv2zVYDZBhZDgORCDcyHiP13qzPiKv+kKXTLoJxAx4d8ZqQo9f0CvTZ4n0WhgYw0teORl+u+uifzY67OyrxH7ryyQ7vv4mW9LwQNApoPCFDaiDRS8/jpH5hwXb2e92GVlXvsPfZLLY925Xto0V2SFwKovk8SRCTEbEIq7TYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730579489; c=relaxed/simple;
	bh=HxPvFyzHJnjW6PKpoVstgjDtOxyC+Ga8VaX6QK0Gufo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfqVxqcib9tv/HGa8xPuZbXtxr+q24jh/okEDgVJ5SzPZrpRN1hkQT9YcgdEB+67Voa/jDtdLM9w4KuHJxPjDe0ouYOOJB+wUmsHvq2WNBZDTsix3RCQdQcBWzoHKNK8oKfnf8BVdR2E0YKhsrYpeqIYXCzOJwYqxGo9wVDUiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=m0Pttq71; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 03D401770FE; Sat,  2 Nov 2024 20:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730579486; bh=HxPvFyzHJnjW6PKpoVstgjDtOxyC+Ga8VaX6QK0Gufo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0Pttq716LR9r0OVP02Yj5HvCAzwWj74eqT/vM/OLybfl35WcU/ENnuxn73J50bNS
	 G5mje34CBJEgtUtaSYCI+Wc0ViGC3tq3mq9hRlpraVUGvuZLGs+ZRUT3Zcfc1p0GAJ
	 brjuYwJE73jz9f4f8icqYIMO2cs2VvH0b8xM0v+Ev1w9wKW590V8/Z+pZuHvUYMtWN
	 JWDah9EV3ex9ahSsXIUu3i/6+Uon3t0DJDJF1HPXGlypFLX7EKsfNiO488kSXrEZRc
	 Iwy78sACAN9KPAclYSla0VXLkKdw0I/01hKg0Qj9sJyRM+KeMhe94m7f+Vr7UTyACY
	 rx5r6K25D1mqw==
Date: Sat, 2 Nov 2024 20:31:25 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Doug Anderson <dianders@chromium.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix incomplete usage help of md, mds and btc
 commands
Message-ID: <20241102203125.GA51629@lichtman.org>
References: <20241031204041.GA27585@lichtman.org>
 <CAD=FV=XY-mH2FxnnMsA99jQ2ZCcd=psTn+VJ4R9h9htK-f2ihw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XY-mH2FxnnMsA99jQ2ZCcd=psTn+VJ4R9h9htK-f2ihw@mail.gmail.com>

On Fri, Nov 01, 2024 at 08:42:43AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Oct 31, 2024 at 1:40 PM Nir Lichtman <nir@lichtman.org> wrote:
> >
> > Fix kdb usage help to document some currently missing CLI commands options
> >
> > Signed-off-by: Nir Lichtman <nir@lichtman.org>
> > ---
> >  kernel/debug/kdb/kdb_main.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Some of this is a bit similar to what I tried to do at :
> 
> https://lore.kernel.org/r/20240617173426.2.I5621f286f5131c84ac71a212508ba1467ac443f2@changeid
> 
> ...but that series kinda fell on the floor because my end goal was to
> try to get it so I could access IO memory and Daniel pointed out that
> what I was doing was unsafe. The earlier patches in the series are
> overall good cleanups, though. If you're interested feel free to
> iterate on any of them.

Interesting, I'll take a look at that.

> 
> 
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index f5f7d7fb5936..0bdffb17b163 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -2667,7 +2667,7 @@ EXPORT_SYMBOL_GPL(kdb_unregister);
> >  static kdbtab_t maintab[] = {
> >         {       .name = "md",
> >                 .func = kdb_md,
> > -               .usage = "<vaddr>",
> > +               .usage = "<vaddr> [lines] [radix]",
> 
> In my patch, I said:
> 
> .usage = "<vaddr> [<lines> [<radix>]]",
> 
> ...so I had the <> characters and nested the []. I think that the <>
> is supposed to signify that you're not supposed to write the text
> "lines" but that it's a variable.

Sounds reasonable, just used the [lines] as it is currently in the help of
the dmesg command but the reasoning you point out makes sense.

> 
> 
> >                 .help = "Display Memory Contents, also mdWcN, e.g. md8c1",
> >                 .minlen = 1,
> >                 .flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> > @@ -2686,7 +2686,7 @@ static kdbtab_t maintab[] = {
> >         },
> >         {       .name = "mds",
> >                 .func = kdb_md,
> > -               .usage = "<vaddr>",
> > +               .usage = "<vaddr> [lines] [radix]",
> 
> From my prior research, "mds" doesn't support <radix>. However, some
> of the other "md" commands that you didn't modify do support
> lines/radix. Let me know if I got that wrong.

"mds" does support radix, I'll check and make sure about the other variants.

Thanks,
Nir

