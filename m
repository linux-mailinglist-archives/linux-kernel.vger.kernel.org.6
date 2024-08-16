Return-Path: <linux-kernel+bounces-289948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B3D954D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3621282F39
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379341BDAA0;
	Fri, 16 Aug 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KipCaYZq"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9321B8EA8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821936; cv=none; b=Dn5ls1w0rbFLhQ/qp500oDuoEPnpXxUQ7StmQXQLs31GilgXxp/elFVy/ucuLoYuTtgtv9VMADMNyhDHrqA8HLltw2ZClZvF5Z/MgeIFzrsIy0FhFJVJgRjaUM6J2JoL6L+DvG3QDXUQpt2xLj8RnK22YXh+0rebi3laCPi1D6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821936; c=relaxed/simple;
	bh=aBS448puOCLfZfdq/o3Me/oBWgsTW6EOTQ++9jhQTyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpNW4a1/V+xLOQ2JqHX3Upe1tcmJ9ijv4Hp/UxwMJlzYj3hLmwX5tTUww0bKhMUykTLllTk8ef4wZDuWdyOoL97BvBV+jiiNydZTsPMfACV/MWMxrmxkAfNydYxQXjyyRVM5n0LLCJt33dvCqMvPfxfsQZrnxvgQ/pMn3IAsOfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KipCaYZq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42816ca797fso15551535e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723821932; x=1724426732; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTUJbqayHrtVOvzwKnfAPewIumbIhGdXnQQAZNKKC+s=;
        b=KipCaYZqK1SLPdNuB4qm3cu6GvOFIvJNNTWxln8kWwg4u7/SoPhiZlUStlpOUATdpv
         nYf9sOAVAlblEkqJPbYjjS7nxx5ZKVLhYygAT4xnXb/JYXN1C49ttmhVMMi6JjulgREQ
         Y2RBL9GOd3Y2saVZguY/O4K1593wYfJSuM5pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723821932; x=1724426732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTUJbqayHrtVOvzwKnfAPewIumbIhGdXnQQAZNKKC+s=;
        b=tBLWYmi70KGEbUEZK/26/RTVKPKFtntx92/iMElxK899dQGHO2JgIT7O+ZqRwFhL8y
         mKCVjT84Gl39ZikDdm3z7p4oEphcihrXNAlpF7HYIZDbzeI5gc1KXkFTs/dBTSPrTMj9
         x6EiipGpfxPt6iazbmoFD2xB8tUTwb+/uhAPVIa+SWMTFVL8n6+gvd0DUk3jFfWdNOG0
         JftHXPEUAgCyhWuRVOxyzmLxnCzDDNzmRT/oDWhuaudMh34RCcjF28rpnFMrhpouCgfc
         MKWIegX3ajhvcWx/eDXrUKiLHMWJ2W5GLZB2IJzj0WW8Qb3iyMlU22ytjqFSJs4mUjuz
         sXkA==
X-Forwarded-Encrypted: i=1; AJvYcCU7LTXFH8mtrB7X47Em4BKiI7Qik1d2qUWLlpgRlTmGFXqG2iZSZqa6mU0/wNCZ0C1d44m3pww06Klyi13S/EmCiw6J+U6VXoFed4o9
X-Gm-Message-State: AOJu0YykwWWYRrKPPH+CwVcjODEWbzyhoqKK/57Gi3woZTzCl78z95ot
	0kt4FT4ueMsrwaBQVP1ZoZjEh+S5fjUJ+SgXkWG8NnL42uo4al4vyxPLJ/bU9yY=
X-Google-Smtp-Source: AGHT+IHq47iCJYMwKCbcJghfwhSS/voGTaFRKxK9fCt6bzpworCDB98kJXJSD/II9rrHQu0kxbDLYA==
X-Received: by 2002:a05:600c:4ecb:b0:427:ffa4:32d0 with SMTP id 5b1f17b1804b1-429ed7e4309mr20380495e9.28.1723821932332;
        Fri, 16 Aug 2024 08:25:32 -0700 (PDT)
Received: from LQ3V64L9R2 (default-46-102-197-122.interdsl.co.uk. [46.102.197.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed65072asm25072915e9.13.2024.08.16.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:25:32 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:25:30 +0100
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Message-ID: <Zr9vavqD-QHD-JcG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <CAAywjhRsRYUHT0wdyPgqH82mmb9zUPspoitU0QPGYJTu+zL03A@mail.gmail.com>
 <d63dd3e8-c9e2-45d6-b240-0b91c827cc2f@uwaterloo.ca>
 <66bf61d4ed578_17ec4b294ba@willemb.c.googlers.com.notmuch>
 <66bf696788234_180e2829481@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66bf696788234_180e2829481@willemb.c.googlers.com.notmuch>

On Fri, Aug 16, 2024 at 10:59:51AM -0400, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Martin Karsten wrote:
> > > On 2024-08-14 15:53, Samiullah Khawaja wrote:
> > > > On Tue, Aug 13, 2024 at 6:19 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> > > >>
> > > >> On 2024-08-13 00:07, Stanislav Fomichev wrote:
> > > >>> On 08/12, Martin Karsten wrote:
> > > >>>> On 2024-08-12 21:54, Stanislav Fomichev wrote:
> > > >>>>> On 08/12, Martin Karsten wrote:
> > > >>>>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
> > > >>>>>>> On 08/12, Martin Karsten wrote:
> > > >>>>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
> > > >>>>>>>>> On 08/12, Joe Damato wrote:
> > > >>>>>>>>>> Greetings:
> > > 
> > > [snip]
> > > 
> > > >>>>>> Note that napi_suspend_irqs/napi_resume_irqs is needed even for the sake of
> > > >>>>>> an individual queue or application to make sure that IRQ suspension is
> > > >>>>>> enabled/disabled right away when the state of the system changes from busy
> > > >>>>>> to idle and back.
> > > >>>>>
> > > >>>>> Can we not handle everything in napi_busy_loop? If we can mark some napi
> > > >>>>> contexts as "explicitly polled by userspace with a larger defer timeout",
> > > >>>>> we should be able to do better compared to current NAPI_F_PREFER_BUSY_POLL
> > > >>>>> which is more like "this particular napi_poll call is user busy polling".
> > > >>>>
> > > >>>> Then either the application needs to be polling all the time (wasting cpu
> > > >>>> cycles) or latencies will be determined by the timeout.
> > > > But if I understand correctly, this means that if the application
> > > > thread that is supposed
> > > > to do napi busy polling gets busy doing work on the new data/events in
> > > > userspace, napi polling
> > > > will not be done until the suspend_timeout triggers? Do you dispatch
> > > > work to a separate worker
> > > > threads, in userspace, from the thread that is doing epoll_wait?
> > > 
> > > Yes, napi polling is suspended while the application is busy between 
> > > epoll_wait calls. That's where the benefits are coming from.
> > > 
> > > The consequences depend on the nature of the application and overall 
> > > preferences for the system. If there's a "dominant" application for a 
> > > number of queues and cores, the resulting latency for other background 
> > > applications using the same queues might not be a problem at all.
> > > 
> > > One other simple mitigation is limiting the number of events that each 
> > > epoll_wait call accepts. Note that this batch size also determines the 
> > > worst-case latency for the application in question, so there is a 
> > > natural incentive to keep it limited.
> > > 
> > > A more complex application design, like you suggest, might also be an 
> > > option.
> > > 
> > > >>>> Only when switching back and forth between polling and interrupts is it
> > > >>>> possible to get low latencies across a large spectrum of offered loads
> > > >>>> without burning cpu cycles at 100%.
> > > >>>
> > > >>> Ah, I see what you're saying, yes, you're right. In this case ignore my comment
> > > >>> about ep_suspend_napi_irqs/napi_resume_irqs.
> > > >>
> > > >> Thanks for probing and double-checking everything! Feedback is important
> > > >> for us to properly document our proposal.
> > > >>
> > > >>> Let's see how other people feel about per-dev irq_suspend_timeout. Properly
> > > >>> disabling napi during busy polling is super useful, but it would still
> > > >>> be nice to plumb irq_suspend_timeout via epoll context or have it set on
> > > >>> a per-napi basis imho.
> > > > I agree, this would allow each napi queue to tune itself based on
> > > > heuristics. But I think
> > > > doing it through epoll independent interface makes more sense as Stan
> > > > suggested earlier.
> > > 
> > > The question is whether to add a useful mechanism (one sysfs parameter 
> > > and a few lines of code) that is optional, but with demonstrable and 
> > > significant performance/efficiency improvements for an important class 
> > > of applications - or wait for an uncertain future?
> > 
> > The issue is that this one little change can never be removed, as it
> > becomes ABI.
> > 
> > Let's get the right API from the start.
> > 
> > Not sure that a global variable, or sysfs as API, is the right one.
> 
> Sorry per-device, not global.
> 
> My main concern is that it adds yet another user tunable integer, for
> which the right value is not obvious.

This is a feature for advanced users just like SO_INCOMING_NAPI_ID
and countless other features.

The value may not be obvious, but guidance (in the form of
documentation) can be provided.

> If the only goal is to safely reenable interrupts when the application
> stops calling epoll_wait, does this have to be user tunable?
> 
> Can it be either a single good enough constant, or derived from
> another tunable, like busypoll_read.

I believe you meant busy_read here, is that right?

At any rate:

  - I don't think a single constant is appropriate, just as it
    wasn't appropriate for the existing mechanism
    (napi_defer_hard_irqs/gro_flush_timeout), and

  - Deriving the value from a pre-existing parameter to preserve the
    ABI, like busy_read, makes using this more confusing for users
    and complicates the API significantly.

I agree we should get the API right from the start; that's why we've
submit this as an RFC ;)

We are happy to take suggestions from the community, but, IMHO,
re-using an existing parameter for a different purpose only in
certain circumstances (if I understand your suggestions) is a much
worse choice than adding a new tunable that clearly states its
intended singular purpose.

- Joe

