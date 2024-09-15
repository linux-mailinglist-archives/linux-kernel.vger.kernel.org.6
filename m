Return-Path: <linux-kernel+bounces-329823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D897966A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BD62827EC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C21C57A8;
	Sun, 15 Sep 2024 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfQRL87G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9D1C578F
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726398686; cv=none; b=NNZWBzSFxHNlzEI1FaYgOGrV8AYKNHwNtaTcyWLh9v4ybUSR+9qQXv/goexh6coWWoXxlbAlZOhiWIHioX6/886gsD2z8ilHgJDVq0CK0eaflk/Y/mbUqHL1MbT43STbGdI1nmxZ4U37+1/PEE+1YesBeOTEacUJE+S6C2IjS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726398686; c=relaxed/simple;
	bh=4/g887YGfPYAHyWs/NWbBAFJc55zHbIhKoE//wgF5vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz1s+vpZq56rsK5SdpcjAMFyclIVmMLp+tcKYIMn1gmoPELM28k5kHyVShAcTW60XIyAl7nCqzLcagzJ9187CWqLpO3xPn5TsomKmkAFqa9troEawhjEH4sg0YomCkzxLCK74MVoH4wlbCsbHnmrFh9z65jWZXhn+H8OpzFYVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfQRL87G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726398684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNvhOEpWa+WgXm7ScMKYLhJj9zxz0J165YKRpsScurU=;
	b=EfQRL87G91buImoXnfJu5Z97AoG7pSL2f5/EWE5G3tExVfxCN7RRPssODSPhy+ozh1Rj5f
	XbYSUto+MF2uu6uQwCkoG3pGucWCEFCoQ+4D3nTf8kVjKIHy6QnqQpA+18hgGuzqdt/bCe
	xvvT1HdWdiEcTnGaLT6v8EeXRefDVm0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-HxnAlHyDN3O-69G5y_TNnQ-1; Sun, 15 Sep 2024 07:11:22 -0400
X-MC-Unique: HxnAlHyDN3O-69G5y_TNnQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-717dfdd7c72so4325954b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 04:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726398681; x=1727003481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNvhOEpWa+WgXm7ScMKYLhJj9zxz0J165YKRpsScurU=;
        b=Obsf6MatSJGiNPijB0gU3SBO8cEuyD8H6pR9D/YY2tJyAR/Rj5ev0KM17dxCixWAG5
         lHzCSs9P7lABLuZYjRsgUV1iNmgVxEeiv29Z0+tNDc2kWR7QQarO9aSFhqJC+teO6H30
         QhiCJkOtcrkxxkNRdsuIh0fGyliL9z8uS/cpl0qH+bJ5tVuXpzRSgREbQQNc/vtpCJGu
         06AHs4Cb+8brrN/ay5r9xoEA8TuhNbrEeyqCAC/h6thiywNOusL3epZj07c3YCm8avyA
         pndiv+E/L4PTI3s+zN6rxcC1fq9ndWocASSuvhxUd94BHLAFlzD69syZJifVFKEBp3ky
         RZZA==
X-Forwarded-Encrypted: i=1; AJvYcCVKl+1esNpR2JFEQYy2intjBho7mWteqIr5MvStgBiYt+UNJzMDvRyl+00LBmwg+iOi44J3ZdJO1cluL3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/CjcJWbw881GWcfgBNgxnpUrjnlFhwEbl96zWtxXYct426Kh
	D7r+Vs4P8KTuWBoYpBrw7uWH9TqUpHE7nCb6oxNtuo6iuIqhma1G5BaUiNpMYE5fBP/gqZCRx6y
	l+yX9zUHKlTdDZUzHR1dpXpFlixmatOHIXV/JDMsWHNJ7Fys4V0LT0IqArzE8Fw==
X-Received: by 2002:a05:6a00:cc8:b0:710:6e83:cd5e with SMTP id d2e1a72fcca58-719366c41f9mr15101427b3a.0.1726398681380;
        Sun, 15 Sep 2024 04:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkFC3ox3k9XnXOpQDj+eZjiShD47i/J6YW0fVP/iI64Bht3XO3ZBlbuzRnWoqFD5CzrX3s1Q==
X-Received: by 2002:a05:6a00:cc8:b0:710:6e83:cd5e with SMTP id d2e1a72fcca58-719366c41f9mr15101374b3a.0.1726398680885;
        Sun, 15 Sep 2024 04:11:20 -0700 (PDT)
Received: from treble ([143.110.226.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab49d4sm2062405b3a.45.2024.09.15.04.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 04:11:20 -0700 (PDT)
Date: Sun, 15 Sep 2024 13:11:11 +0200
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20240915111111.taq3sb5xzqamhb7f@treble>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <20240914081246.1e07090c@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914081246.1e07090c@rorschach.local.home>

On Sat, Sep 14, 2024 at 08:12:46AM -0400, Steven Rostedt wrote:
> I think the unwinder should have an interface itself that provides the
> deferred unwinding, instead of having all the tracers to implement
> their own.
> 
> The user space unwinder (regardless of sframe or not) should provide a
> way to say "I want a user space stack trace for here, but don't do it
> yet. Just give me a cookie and then call my callback function with the
> stack and cookie before going back to user space".

We (Steven, Mathieu and I) have been discussing this at GNU Cauldron and
I think we're in basic agreement on this.

I think the biggest tweak we decided on is that the context id (aka
"cookie") would be percpu.  Its initial value is (cpuid << 48).  It gets
incremented for every entry from user space.

> That is, we should have an interface like:
> 
> typedef void (unwinder_callback_t)(struct user_space_stack *, u64 cookie);

> struct unwinder_client {
> 	struct list_head	list;
> 	unwinder_callback_t	callback;

I assume we want to allow tracers to pick sframes or FP (or auto).  If
so we would need to add a user_unwind_type enum to this struct.

Then the question is, what to do if tracer A wants sframe and tracer B
wants FP?  I'm thinking it's fine to allow that.  I assume the "multiple
tracers unwinding user space" case isn't realistic so any extra overhead
from these cases is the user's fault?

The unwinder would need two sets of callbacks and task work functions:
one for sframe, one for FP.

The tracer would need to pass its &my_unwinder struct to
unwinder_trigger() so the unwinder knows which task work function to
activate.


I thinking we also need a 'max_entries' field.  No need to keep
unwinding if we've already reached the tracer's max.  If there are
multiple callbacks then we'd have to get the max of the maxes, but
that's easy enough.


Mathieu had requested passing an opaque void * from the NMI to the
callback, but I don't think that's possible with this scheme since the
unwinder wouldn't know which callback to give it to.  Instead the tracer
would have to keep track of its own data associated with the given
cookie.

-- 
Josh


