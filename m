Return-Path: <linux-kernel+bounces-430132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8DD9E2CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85249162962
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ECB1FECCC;
	Tue,  3 Dec 2024 20:07:49 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1482500A8;
	Tue,  3 Dec 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256469; cv=none; b=Aeyf9g1WNpi65jCP3ZwINLf+SaruoTw/qd70sXGGupWs/yIWM80iFuUg+CkIpSKcke5xUPQuJokofbJO8f2cmHDnoSuhbd1nJZh83E+psK+wMONzCBdgNu+LNHw8R4q/OjypIXxVlNy0Q9pL5f9sMAS53NRw9MZJrX1b+rpba7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256469; c=relaxed/simple;
	bh=f027OcR8lh83IxYKfrwTCjHNd1MkG5MpSRUfAB5UyWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NvvvlGTthlYxXToW/jZljuc5X9KIJkvc2fPUyVhTjHQ/Tlad+7g8wCWJPpFBRGizc2MGxA2auTvKB39Aqu6H25R/zaL6aeDRXVEqgV8/y/BJs2WBbRGC3IbJmxZ5GKiR2IFN6k+H7LezfqypnbqssK03cpTIUYTTFm8ZwY8BvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIZBI-000000001vl-3lqn;
	Tue, 03 Dec 2024 15:07:36 -0500
Message-ID: <cc6d6e0be9b4fb61228f42ad82a057f60a1c1e12.camel@surriel.com>
Subject: Re: [PATCH v2] x86,mm: only trim the mm_cpumask once a second
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@intel.com>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar
	 <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter
 Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Date: Tue, 03 Dec 2024 15:07:36 -0500
In-Reply-To: <5544716d-31be-40c6-a289-030220e518de@intel.com>
References: <202411282207.6bd28eae-lkp@intel.com>
	 <20241202202213.26a79ed6@fangorn>
	 <5dcb4050-f0f3-43d6-b4b1-42fa305a0fba@efficios.com>
	 <20241203144845.7093ea1a@fangorn>
	 <5544716d-31be-40c6-a289-030220e518de@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Tue, 2024-12-03 at 12:05 -0800, Dave Hansen wrote:
> On 12/3/24 11:48, Rik van Riel wrote:
> > Sending TLB flush IPIs to CPUs that are in the mm_cpumask, but no
> > longer running the program causes a regression in the will-it-scale
> > tlbflush2 test. This test is contrived, but a large regression here
> > might cause a small regression in some real world workload.
>=20
> The patch seems OK in theory, but this explanation doesn't sit right
> with me.
>=20
> Most of the will-it-scale tests including tlbflush2 have long-lived
> CPU-bound threads. They shouldn't schedule out much at all during the
> benchmark. I don't see how they could drive a significant increase in
> IPIs to cause a 10%+ regression.
>=20
> I'd much prefer that we understand the regression in detail before
> throwing more code at fixing it.
>=20
The tlb_flush2 threaded test does not only madvise in a
loop, but also mmap and munmap from inside every thread.

This should create massive contention on the mmap_lock,
resulting in threads going to sleep while waiting in
mmap and munmap.

https://github.com/antonblanchard/will-it-scale/blob/master/tests/tlb_flush=
2.c

--=20
All Rights Reversed.

