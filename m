Return-Path: <linux-kernel+bounces-412654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B29D0C09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AE3284F17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEC618FDD8;
	Mon, 18 Nov 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VG07oOjc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753522083
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922870; cv=none; b=UTwmm79cYLuZ3V5NZP+HPaDcEVtnWK6202EUHph1ogJ8yZli03WS2aJgw88zbIrUokGmjWSwu2TPsEjDSnquRbzcxcSE3HZyBIPJSZDUfxGnhzNvoXmQLUhBepDYLkaTu06UHEFcJ7u9M1H1MX6L1WlnIv0oZfJ1CZTs5i29cxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922870; c=relaxed/simple;
	bh=wtVw1/bYuTsNGxnHQ3aG2SHkoqtIshGNLA6gyXSnoqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+sBkLaF4Xht9t3pXEsifEDazQ5bVfDChQuB5NG7hmyL00/oCSrLiZ/kRcJrL3f02dYsEqIhIs/gaVEu6qWWA1/FssLpy96GrS9kb313D+zEIE/LIr3J5HgC2B4NXvbOIi9vXaJOkhIGLlezD6s8s7aQcxcLNsj5zxiVmskbJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VG07oOjc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wtVw1/bYuTsNGxnHQ3aG2SHkoqtIshGNLA6gyXSnoqE=; b=VG07oOjcsDEzhY+D+YQcdILeSz
	rOKT/llv5S2e+On1Fl8zeNV77wvCKofA1bssZLLZNh3CW2paOW10nTzAGJt18W29+EjqdLOeMeDbv
	+SrITeTPob+ewJSCEBOTazAQLcudQ4rNm1GOD1ZHKNuusiSsjkMJ7PZBKct1m5RTRpbXBdJZ6rUNv
	saddjXJr6wxZaMSva0QgrKspZZAeSoofRTBov9d5ip+yux0JDtqtmqmRlLmEPtnuw9XMk5u2Ckrug
	FMWbwu4HnifSZNZ+dlvQDz1UVWUIvQT6Mc3+JUnCHK95O6Ci1fDDyTbdoEkCVwWya1eH2OOUPEHDy
	WMRfnOkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCyFg-00000000D3Y-2PPe;
	Mon, 18 Nov 2024 09:41:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 37DAC30049D; Mon, 18 Nov 2024 10:41:00 +0100 (CET)
Date: Mon, 18 Nov 2024 10:41:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] sched_ext: Manage the validity of scx_rq_clock
Message-ID: <20241118094100.GG39245@noisy.programming.kicks-ass.net>
References: <20241116160126.29454-1-changwoo@igalia.com>
 <20241116160126.29454-3-changwoo@igalia.com>
 <20241116193235.GQ22801@noisy.programming.kicks-ass.net>
 <494b8851-ba5b-4205-bea0-dc504c2ffa33@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494b8851-ba5b-4205-bea0-dc504c2ffa33@igalia.com>

On Mon, Nov 18, 2024 at 12:46:32AM +0900, Changwoo Min wrote:

> The main reason to keep the second copy (rq->scx.clock) is that
> a BPF scheduler can call scx_bpf_clock_get_ns() at almost any
> time in any context, including any of sched_ext operations, BPF
> timer callbacks, BPF syscalls, kprobes, and so on.

If it's going to be a BPF wide thing, why is it presented as part of
sched_ext ? That makes no sense.

> Another approach would be to extend struct sched_clock_data (in
> kernel/sched/clock.c) to store the update flag
> (SCX_RQ_CLK_UPDATED). This would be the best regarding the number
> of cache line accesses. However, that would be an overkill since
> now sched_clock_data stores the sched_ext-specific data.
> I thought it would be better to keep sched_ext specific data in
> one place, struct scx_rq, for managibility.

What's the purpose of that flag? Why can't BPF use sched_clock_local()
and call it a day?

Do note that kernel/sched/clock.c is very much x86 specific (it was
briefly used by ia64 since their 'TSC' was of equal quality).

Growing sched_clock_data shouldn't be a problem, it's only 24 bytes, so
we have plenty free bytes there.

