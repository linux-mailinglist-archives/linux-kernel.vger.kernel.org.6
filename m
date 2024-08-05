Return-Path: <linux-kernel+bounces-274440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26E947819
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBDB1F22872
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E58C1509B6;
	Mon,  5 Aug 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nVA1FpuX"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC33BB48
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849344; cv=none; b=u/G+EdmoA6cB/vUydjrI11mPhKneyBd/r8QqJV9D3mw0DeP+feLHlOfPP3MSB49SGaZt4BtQdmUYjIONy0ucvqoT+8QSSCDWwBq6JgeFocOCqhHwcbiq77Pg/I1fam8v5Bgw6cMuwsiUK9xZGRigCZlVfGMTkZRtqBbaG6qXkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849344; c=relaxed/simple;
	bh=6tLNsPqRPfQQnNIGHohMzXJbUdiVp+3CXoFbYrO67tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKyLHniAhnJTrslAnE5hlAwDqh7GsdLXyvrRdTkMKyo37QRVIAqzIGsYSGPAaMgIo9dZVZb+dTwBhab/CJsR3Dy51U1VP0QBjcOjuzuHZdgdzx7RMtrBfFxy+y/whwfE4LyuP8RKM3eACq8hqSb4rV/yUiolZWeKSkuiG2ANwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nVA1FpuX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NCu8y4Lo09ahmjQF/OJlLXMp2GfKKpTVq/Oxvzptb6Y=; b=nVA1FpuXKsM+ALKK7h7AScNZ0E
	ySp8qk0tvixYCPQgF01dJ6ieE6ff0v32TSpfk7rBSggT52FT5WSXahvn5XtHy08AwEf0CsoQy7NXX
	WelPxmKj3J707bWOXOTEtjFu6eqQdlGIKguwoXY4zfN1YTbxU0BhQKfAKK7MKPISwRHbida2dFgKn
	HvEXsv9zRTQRv8cCHkgtirW8KDWBrL3Xfv7B9xfTcbke3OLSfn1uC5acgjJYvzCw1AdKKUezP+S+U
	r5fbohHHBTMqZh7abnKq+I18avN+mc9gOyvJJxfm0mdu1xRlUBaWyM+2coK6v+MN5mO21Ur5o5qik
	1BkEO8tA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1satoW-00000006DSA-2OjZ;
	Mon, 05 Aug 2024 09:15:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2F76330049D; Mon,  5 Aug 2024 11:15:36 +0200 (CEST)
Date: Mon, 5 Aug 2024 11:15:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
Message-ID: <20240805091536.GJ37996@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net>
 <20240802184350.GA12673@noisy.programming.kicks-ass.net>
 <20240802185023.GB12673@noisy.programming.kicks-ass.net>
 <20240802191123.GC12673@noisy.programming.kicks-ass.net>
 <20240803103202.GD12673@noisy.programming.kicks-ass.net>
 <CAM9d7cgNZQrJk7-TnMgqvCMpkYkcpBT78Ts_5oTsAzNB9gp+_w@mail.gmail.com>
 <CAM9d7ch=-cp-wxLUXf1=EizAeHMG_zneSqp0owdbKp__K0ZeCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ch=-cp-wxLUXf1=EizAeHMG_zneSqp0owdbKp__K0ZeCw@mail.gmail.com>

On Sun, Aug 04, 2024 at 11:39:18PM -0700, Namhyung Kim wrote:
> On Sat, Aug 3, 2024 at 10:08 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sat, Aug 3, 2024 at 3:32 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Aug 02, 2024 at 09:11:23PM +0200, Peter Zijlstra wrote:
> > >
> > > > But I'll have to continue staring at this later.
> > >
> > > OK, I have the below, which boots and seems able to do:
> > >
> > >   perf stat -ae power/energy-pkg/ -- sleep 1
> > >
> > > and
> > >
> > >   perf top
> > >
> > > also still works, so it must be perfect, right, right?
> >
> > I really hope so. :)  I'll test it over the weekend.
> 
> I found a failing test about the context time - it complained about
> difference in enabled vs running time of a software event.

Yeah, it's that ctx_scheD_out(EVENT_TIME) thing, that's really needed.

I'll make those changes go away when I split it all up.

