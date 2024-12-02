Return-Path: <linux-kernel+bounces-427289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62C9DFF29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC52C163D43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699301FC7EB;
	Mon,  2 Dec 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5Mg05+B"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A21FC10B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733136073; cv=none; b=CieJdxriwSqbZ/siQG0ymHSH7FrhfYyskoa/zYNTi95BPw3BTH1OqdMWi0qkBonAu1aDOMe5yI0vdymT4v+YDPm+s2aUKZ/fE8ZruefGjv6e5gXMsIZrILvcqDyeDR9/unI5dBU+D6CK29KsYh2btRG/HI8oNws9isnEwupJpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733136073; c=relaxed/simple;
	bh=Lw9Xn/1SaXcPFKlc6YFdOSgthDnfhMSJkkx9BnXjW6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErRVmW+IreRQ+7mTHBx1WQklIWN10X1bbfnxas+PM9+tfcQpT0Q8QIA1gBXHbF0UGV9wxpZRru+GZYfxKqVBrTTGbIivkP8rMDezUnQFD1kn8vMSRtctrp1CxH9HvwC33QmyG/AA7hq3hJ+4MgI9cCvuDXP+bG47JlbhoL6aeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A5Mg05+B; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QYPY8BessWoJaaQeFxMazrHm0J9/jmuGmCGbmcw0+1w=; b=A5Mg05+BZD0VyG9uwusQLvf05x
	jVN70N0+Xu2PdK4o1mGxUBPwhn2uU20KEWBaRCcGVxcQQwBK56Qld1p1fN38wCc1t83k4LTwzRgRo
	+I1j5YpqklhrKXsoAVTPnCQUx31+/GhCl9sCZJ1OvonJ9NSQjxyxmAWN5a4R0SsgMU8yy1g/m7aSH
	JkWpoFr1S/QiBFMKviY93wxrJLF6GJzBwnv+DTsWbF+Eos8KB1LUPz24FhktgRNGKApZDMUiNNUzw
	+YY8o8LcCB76k8xXktpmuGH9crC49PwmA+eq9m4eqZj/JfoTJA2NqTRaMbkjFciN0xVFPcdDM5m0V
	KXVY8dMg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI3rU-000000029cp-0U0U;
	Mon, 02 Dec 2024 10:41:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB48B300402; Mon,  2 Dec 2024 11:41:03 +0100 (CET)
Date: Mon, 2 Dec 2024 11:41:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw
Subject: Re: [RFC PATCH] sched: Fix integer overflow issue of cpu weight delta
Message-ID: <20241202104103.GN24400@noisy.programming.kicks-ass.net>
References: <20241202101344.97081-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202101344.97081-1-richard120310@gmail.com>

On Mon, Dec 02, 2024 at 06:13:44PM +0800, I Hsin Cheng wrote:

> I think there's one point to concern, do we have a fixed range of
> "tg_weight()" ? 

kernel/sched/fair.c:__sched_group_set_shares()

  shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));

  if (tg->shares == shares)
  	return 0;

  tg->shares = shares;

