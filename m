Return-Path: <linux-kernel+bounces-576631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1003A7120F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679C8171D90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3DC1A2630;
	Wed, 26 Mar 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lNGrwlPF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q/6W+0Qe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F02629D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976475; cv=none; b=SF8ZLg3eUn5wKB5eFoDrbIgpoas8JgtZ+8+YoalIZoHwvELxxggTlOP1bM4GPU2mfFN9KCBWeEXW96jJ+9M4U/JyBhpp9OWiAJvQIkoOe+CHQg5euJznPcj5YiFlY3TNh9LnEV1vCDMq+xwHEWsjmROfBZi4GOfhTIm1RiBR7L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976475; c=relaxed/simple;
	bh=UxBS92GQ45LUnanF/bFoFizTZVD0tvd6G70vV86NyLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ntpj/KiVWu56hRv4TT9COdl2nrSPk/uTf3K8PzOl0JIQl7VJ5jUnm3tW2MipTOhZ8CxU3ZnypPJwuhzNBDlyEBhtAAeKj4gVMkdHfH3sV8+hndOmikyRUGDUw/Mhl7hwzfzuGLx8gki9xVm2/3Pdbvqv/SZFacAg3W4WFjxlLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lNGrwlPF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q/6W+0Qe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742976472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETk2UupwFvvVpDyiifSQD52EUhmJaQXXMm0OcMJCSE4=;
	b=lNGrwlPFgQZUCpVYeTMO1I7ez+L1MaaNktpucTkooQXGmpzCDqWbcshAM0lRUNVs/Vn72N
	JcLSjT+JdZs9c7zqZQTDElt8cLElb7FV71NAcnZO5GCWqSgtbv0Fr08OKDikxC3qCYjjYY
	PSmal4RSJzEXBoeEBfEIwyY3x2fDf9a9T+bjyF46VMkVMsjnn6RCV7AcrkVoxY7ljRkMQg
	K63kPxVwSgBhtOGJDWttBGcpbY06Cxvt5T/3FjY7garJ25USmLM9+6w1kzUrj+UbA+xJK5
	fsi0Czd/bxReuM8NiWMozFBlMQtYmE4GJSP6YKvubjWL+KKA4S2qpRT19S2zbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742976472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETk2UupwFvvVpDyiifSQD52EUhmJaQXXMm0OcMJCSE4=;
	b=q/6W+0QeGFX1m3u5F50e3Wlrm25vjxKbCARTI72limhwint5vZ+C/xQ3gf4jGZAjJTWhQB
	FJrs6CrtG2KHCmBg==
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Dumazet <edumazet@google.com>, Benjamin Segall
 <bsegall@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 oliver.sang@intel.com
Subject: Re: [tip:timers/core] [posix]  1535cb8028:
  stress-ng.epoll.ops_per_sec 36.2% regression
In-Reply-To: <202503241406.5c9cb80a-lkp@intel.com>
References: <202503241406.5c9cb80a-lkp@intel.com>
Date: Wed, 26 Mar 2025 09:07:51 +0100
Message-ID: <87pli4z02w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 24 2025 at 14:39, kernel test robot wrote:
> kernel test robot noticed a 36.2% regression of stress-ng.epoll.ops_per_sec on:
>
> commit: 1535cb80286e6fbc834f075039f85274538543c7 ("posix-timers: Improve hash table performance")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/core
>
> testcase: stress-ng
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
>
> 	nr_threads: 100%
> 	testtime: 60s
> 	test: epoll
> 	cpufreq_governor: performance
>
>
> In addition to that, the commit also has significant impact on the following tests:
>
> +------------------+---------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.epoll.ops_per_sec 124.9% improvement                       |
> | test machine     | 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory |
> | test parameters  | cpufreq_governor=performance                                                    |
> |                  | nr_threads=100%                                                                 |
> |                  | test=epoll                                                                      |
> |                  | testtime=60s                                                                    |
> +------------------+---------------------------------------------------------------------------------+

How on earth can this commit result in both a 36% regression and a 25%
improvement with the same test?

Unfortunately I can't reproduce any of it. I checked the epoll test
source and it uses a posix timer, but that commit makes the hash less
contended so there is zero explanation.

Thanks,

        tglx

