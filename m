Return-Path: <linux-kernel+bounces-428150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1909E0ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0851632C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1301DDA3E;
	Mon,  2 Dec 2024 18:13:02 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E11DDC37;
	Mon,  2 Dec 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163181; cv=none; b=GsT7/L/lyInjG6Qoc7vLcwAZceR4ZoWb0P7w2AYpOIsgbsVtnV+nyGlrA8/EjhEilp8X6A9vaWxalRBK3yomA+7lk0RCrDIJjuy9JE7yehbEFU1LZZu9xzmYzksaMRbmtv/xiKvop4o8iLLDT1nD0L2pfOL5k8ZE5kg8NuPAtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163181; c=relaxed/simple;
	bh=I4ZvUmkhKhe+ozjF1y6BcfEPFCwqisJ0O6LrGfuu6cc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P73qNz5/biw7BAqWwJADzmm4/DZHaqtVT9qfrxL0Ptqde6cuGPw3gs4B3bJofbztnfURDMDtlDQT9hUHpTmCZOGoOIiP7f2M3c54nvS62ZFkLgLpaz9gluy3IKQBI66S4wV7gjttYIcixHPDKPFMNfg70vS3ahm4JO2eHyCQJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIAsG-000000004ix-3Aog;
	Mon, 02 Dec 2024 13:10:20 -0500
Message-ID: <23808da41421f3d95b65a2346ea7591631af322d.camel@surriel.com>
Subject: Re: [tip:x86/mm] [x86/mm/tlb] 209954cbc7:
 will-it-scale.per_thread_ops 13.2% regression
From: Rik van Riel <riel@surriel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
	 <peterz@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar
	 <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>
Date: Mon, 02 Dec 2024 13:10:20 -0500
In-Reply-To: <9b3bd9b0-fd5b-4239-8ee4-ebabd0667b4b@efficios.com>
References: <202411282207.6bd28eae-lkp@intel.com>
	 <Z0jIsYsuo_9w16tK@localhost.localdomain>
	 <8bf303a222ba27f3a86b357db58ee3df3fa7f82e.camel@surriel.com>
	 <9b3bd9b0-fd5b-4239-8ee4-ebabd0667b4b@efficios.com>
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

On Mon, 2024-12-02 at 11:30 -0500, Mathieu Desnoyers wrote:
>=20
> Or we just build a per-cpu mm_cpumask from per-CPU state
> every time we want to use the mm_cpumask. But AFAIU this
> is going to be a tradeoff between:
>=20
> - Overhead of context switch at scale
>=20
> =C2=A0=C2=A0 vs
>=20
> - Overhead of TLB flush
>=20
>=20
> So I guess what we end up doing really depends which scenario we
> consider
> most frequent.
>=20
I think that is going to be more workload dependent than
anything else.

If you're doing a kernel compile, or running a bunch of
shell scripts and simple Unix commands, you are dealing
mostly with single threaded programs, where not sending
IPIs is the best thing to do.

If you're running a long-lived, heavily multithreaded
program, you will benefit from reducing the context
switch overhead more than anything else.

Both seem like equally valid use cases.

I'm playing around with a patch now that builds on
my previous patches, but only trims the mm_cpumask
once a second.

Hopefully that can give us a reasonable medium between
the two.

--=20
All Rights Reversed.

