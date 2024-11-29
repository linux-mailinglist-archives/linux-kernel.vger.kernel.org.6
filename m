Return-Path: <linux-kernel+bounces-425204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF4F9DBED6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C79B2098F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585FB14F9EE;
	Fri, 29 Nov 2024 03:04:05 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4183C3C;
	Fri, 29 Nov 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732849445; cv=none; b=YB80IkRN80xW/Ui647vL4BwxDZyfgQ6wq0l/GBuIAXeW0OIVBj4KYAmo2Rw8DFuAPbYzlt66pf6dy87FzdOpqruQq7TRc7deWL1w3hq6IS5jBtlpG74bR07R6XntvZWIEuT2MLQIzZwxq2eFnqltSWUx0eWr+widB0EYKGo6tcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732849445; c=relaxed/simple;
	bh=Xnq/eXLQkxollHZUAR8q67I4XuzB0nLNIfP//RYZGuk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meKF67JBGdE8xs9N8lMvom9+GjM/YRYMezgSBAHvCrCvTJfUXqQv7HIyACbRjaGkKvQT4x+CIuLI2+UdAjAcWYZiRGUVVxnHBW3repDl4Iw5LmY+tVRqsnfVO0+Wz5uDNec+ELURjlcZRduSUHPb7gMlrrhhruUdQtNsCPDELMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tGr7g-000000008C3-2tqt;
	Thu, 28 Nov 2024 21:52:48 -0500
Message-ID: <8bf303a222ba27f3a86b357db58ee3df3fa7f82e.camel@surriel.com>
Subject: Re: [tip:x86/mm] [x86/mm/tlb]  209954cbc7: 
 will-it-scale.per_thread_ops 13.2% regression
From: Rik van Riel <riel@surriel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
	 <peterz@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar
	 <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>
Date: Thu, 28 Nov 2024 21:52:48 -0500
In-Reply-To: <Z0jIsYsuo_9w16tK@localhost.localdomain>
References: <202411282207.6bd28eae-lkp@intel.com>
	 <Z0jIsYsuo_9w16tK@localhost.localdomain>
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

On Thu, 2024-11-28 at 14:46 -0500, Mathieu Desnoyers wrote:
>=20
> I suspect you could use a similar per-cpu data structure per-mm
> to keep track of the pending TLB flush mask, and update it simply
> with
> load/store to per-CPU data rather than have to cacheline-bounce all
> over
> the place due to frequent mm_cpumask atomic updates.
>=20
> Then you get all the benefits without introducing a window where
> useless
> TLB flush IPIs get triggered.
>=20
> Of course it's slightly less compact in terms of memory footprint
> than a
> cpumask, but you gain a lot by removing cache line bouncing on this
> frequent context switch code path.
>=20
> Thoughts ?

The first thought that comes to mind is that we already
have a per-CPU variable indicating which is the currently
loaded mm on that CPU.

We could probably just skip sending IPIs to CPUs that do
not have the mm_struct currently loaded.

This can race against switch_mm_irqs_off() on a CPU
switching to that mm simultaneously with the TLB flush,
which should be fine because that CPU cannot load TLB
entries from previously cleared page tables.

However, it does mean we cannot safely clear bits
out of the mm_cpumask, because a race between clearing
the bit on one CPU, and setting it on another would not
be something we could easily catch at all, unless we
can figure out some clever memory ordering thing there.

--=20
All Rights Reversed.

