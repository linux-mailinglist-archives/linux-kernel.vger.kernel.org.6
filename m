Return-Path: <linux-kernel+bounces-245313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DEE92B112
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1788EB2195C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B2414A615;
	Tue,  9 Jul 2024 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRE+d3Xl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C712E1ED
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510207; cv=none; b=aUG6WLY8pSGVBbNR5uP4lIqEQUuTINBLIrulGkXT3Iws/PnOjUZAQBqBBcwqnuSroLrTxwc/ol64TVtwVht6OfeTwi5rwOATZLmpNJ073gYzZfYMP6gPRG9CvqfkmWG1vFMDjg0oMC4OPdrAbtnYfq9LJz0gRSCTriflfakwwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510207; c=relaxed/simple;
	bh=rkGdISl1TzaGlVjcUH75AT1mx83zo4QoyWsZghmO6kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un8RVrtEOQUUtNxp+Kwm//XNVXuyj2y0g6ZAqKz2F0sbigktYKgR9cOf/tH2XprjsybZ6ePBH5pEbLIiBu9bQsb/TitQGFIyVmOrteZxEnR/vv+csFoLMO7RqoyybKWZeeN2oCy/FhXGsuDFcvmcCxoQWz5c/E1lzPGX8geHHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRE+d3Xl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf1SJ2E+/uax9z6UEQf/5sMYVREavkk6eWR+f8aQSYQ=;
	b=BRE+d3XlrkWWKJO1Hg/pDBHfnvKMZdk5REJ/Ugy9LNUXeyEikJSmPnnhPEl79lme9ovkp0
	0nq29rnXlriL/Utw3kGGNn7t2k80vM/u+wZXYHovqXXhgwMc9s72PljF1Te+zJO91+ZDOZ
	XroaBe/Gmflur/ocV8UmBRH8MjLbWLk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-PxbebiXXOoOkbkGujZZMJw-1; Tue, 09 Jul 2024 03:30:01 -0400
X-MC-Unique: PxbebiXXOoOkbkGujZZMJw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-426679bc120so14996195e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510200; x=1721115000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qf1SJ2E+/uax9z6UEQf/5sMYVREavkk6eWR+f8aQSYQ=;
        b=TJF51RTe2y1veixndsten7/amFNo4ieyTbSDWRkbIv66xpGGCKhEFjX/1NPe5Poe5Z
         EU+7Asovy+FpGVDq+FuFJrodvgOsGSg+OcCWEeKTeHNFvCCDWB2OrFprOW23nom/D5Tv
         OicmtDcW05F6Tcs09XRiEgh4Z6Dzem867rpo0hG5+7ZzA01bTre0XXwHymgkj1+CexUw
         S2bGq7V8s0S6HWeqJB+0UYigI8SkeXPLbCosE5MJD+yr7hl/VbbY3YMTukdIJ5yWxOmI
         8DpX/9I0PG47sBQJc34mO9ObTeP22ullvYLmMGefpCnT6HondUHt6MYK0UYo316BFlRv
         lYjg==
X-Forwarded-Encrypted: i=1; AJvYcCV0FD1mLcL9zBWt/mqjFkAuV34XihwfvEoodM780NcWJl41U7bwvAC+P1l/8ENoemWM8De9ySaVsPkAXaG6e0OGK6jXsXy1mQ+oFYXw
X-Gm-Message-State: AOJu0YwncMbeggmXiWxgE365Rw71MIe4FbgJDTmo7BCtoZ0eqSXKKrR1
	YReTh57MvurTiAaLbsgPcUR/z9d4ZWl5QEOc/QkruLI/DTxkePz5Y+3mPXW6M8fyBFxDDRPzRMs
	gXF3bdfFUTGwX79wLDkYjSVloRpc4uS9AIimfHyf7JwM3tlozMv1lT+0QywFlpQ==
X-Received: by 2002:a05:600c:2050:b0:426:67df:31e6 with SMTP id 5b1f17b1804b1-426707d7909mr10604415e9.17.1720510200737;
        Tue, 09 Jul 2024 00:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpJtl1o2CUuA4S9TQMHL2oQCj3OVqdwuS+zuGDVYd3GErt7tbo1ZmxdMnlHKCK0a6RkQCxyQ==
X-Received: by 2002:a05:600c:2050:b0:426:67df:31e6 with SMTP id 5b1f17b1804b1-426707d7909mr10604285e9.17.1720510200358;
        Tue, 09 Jul 2024 00:30:00 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.67.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89133sm1712183f8f.54.2024.07.09.00.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:29:59 -0700 (PDT)
Date: Tue, 9 Jul 2024 09:29:57 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Ingo Molnar <mingo@kernel.org>,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: sched: Update MAINTAINERS
Message-ID: <Zozm9Q7it5c_f6UC@jlelli-thinkpadt14gen4.remote.csb>
References: <20240708075752.GF11386@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.21.2407081038350.38148@angie.orcam.me.uk>
 <20240708095520.GI11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708095520.GI11386@noisy.programming.kicks-ass.net>

Hi Peter,

On 08/07/24 11:55, Peter Zijlstra wrote:
> On Mon, Jul 08, 2024 at 10:47:18AM +0100, Maciej W. Rozycki wrote:
> > On Mon, 8 Jul 2024, Peter Zijlstra wrote:
> > 
> > >   Thank you for having been our friend!
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -19929,7 +19929,6 @@ R:	Dietmar Eggemann <dietmar.eggemann@ar
> > >  R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
> > >  R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
> > >  R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
> > > -R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
> > 
> >  I think perhaps a CREDITS entry would be due rather than just dropping 
> > from MAINTAINERS.
> 
> Ah, I was not aware of that file. Yes we can add a few lines there.
> 
> Thank you for the suggestion.
> 
> ---
> diff --git a/CREDITS b/CREDITS
> index 1a1a54555e11..a58066be6d73 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -271,6 +271,9 @@ D: Driver for WaveFront soundcards (Turtle Beach Maui, Tropez, Tropez+)
>  D: Various bugfixes and changes to sound drivers
>  S: USA
>  
> +N: Daniel Bristot de Oliveira
> +D: Scheduler contributions, notably: SCHED_DEADLINE
> +
>  N: Carlos Henrique Bauer
>  E: chbauer@acm.org
>  E: bauer@atlas.unisinos.br

For both, with great sadness,

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thank you Daniel for everything you have done and for just having been
our friend, yes.

Best,
Juri


