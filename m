Return-Path: <linux-kernel+bounces-202136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302578FC82B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517481C20B0F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C618FC6B;
	Wed,  5 Jun 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="heq3kTCg"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7641946CB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580566; cv=none; b=CikN/IlsrhXKscdoVyoH0+EMsV7DrCWXte7RFKTKhjPzZGwfNIOTB5xAG6yRVX/pAHuiV8P1jPsjpzaa7XJx/P8BQkWSZo1LitDqjpcbPuL+XXksWbdjVINye1bD9KeD8miQaC0BA7bPHEoQlISV49CCMQDVK7xSjv0Em3sg1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580566; c=relaxed/simple;
	bh=reWmc9PmoXH+7zE7T6+aX+Zbm95Zvw2YL7N2SCV20nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAYL8L+0AHE3gAY7oohbw5owtnO0TGPFlHDuhq3CidP4RCdLa4Qiq19S3FU/gPNribI/SrUpPn2dStParmTMHZvmbblE6CBEg224SmmK34lpBvHSqpoSArviVFZxYn9N7BqVjPqtFl5Qy/olEF3GL189vvxBUFaCaHyQ014UXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=heq3kTCg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=reWmc9PmoXH+7zE7T6+aX+Zbm95Zvw2YL7N2SCV20nw=; b=heq3kTCgOEIFTmPsaBFIeEarXI
	0VAejkD0gKynNnV5qvc6DzFyql0mIZs6OuMjmgYg9K9XT0CzSsGBqKnGzqzhqTLzGRcRkJA4cCuv9
	xQUxnppoBWTKaAgJB50nFa/GW4dgK2DNaKx9crALaohEl8ZL/Jqih99yidcHoE+qYaFDmmDrsYwIK
	izajTImOHUcVZfO5mh2J9qCUJXRHzxBfqcU+PHbn6gsefDVFubLkzVMAd4JQoIWMAocwXoIO863GN
	/cU87TTHzHlnSGkRnhSCSTv9Mrw6xe9MzVz35Ah5KaKNyqieFkjKVPwYKJ+x497zk10GTLnw3gjv4
	aYEze/Ig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEnA7-0000000FlsF-3gWb;
	Wed, 05 Jun 2024 09:42:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D33C30068B; Wed,  5 Jun 2024 11:42:31 +0200 (CEST)
Date: Wed, 5 Jun 2024 11:42:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240605094231.GR26599@noisy.programming.kicks-ass.net>
References: <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
 <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
 <20240604101107.GO26599@noisy.programming.kicks-ass.net>
 <24e09046-74ee-4ebb-ac1a-bdc84568e825@arm.com>
 <20240604191220.GP40213@noisy.programming.kicks-ass.net>
 <20240605072225.GR12673@noisy.programming.kicks-ass.net>
 <7b26df23-4977-4fad-8721-137a23932b6e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b26df23-4977-4fad-8721-137a23932b6e@arm.com>

On Wed, Jun 05, 2024 at 10:14:47AM +0100, Luis Machado wrote:
> ... thanks for the patch! The above seems to do it for me. I can see
> more reasonable energy use with the eevdf-complete series. Still a
> bit higher. Might be noise, we'll see.

W00t!!!

Let me write a decent Changelog and stuff it in the git tree along with
all the other bits.

Thanks for all the testing.

