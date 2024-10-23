Return-Path: <linux-kernel+bounces-377224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C979ABB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824FB1C210DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423DA49620;
	Wed, 23 Oct 2024 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="hve83jYf"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16E22615
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650587; cv=none; b=QHT32p/1YtketmWESVfq7VJnlH0Ge9a500j8udSKIQ9fwe2g2QpMBlAg2QFmHsU3uLBm9j5v78J/CkX3qZd0ISywRzdp5tHuo2ULPviu499Z04D0UJm462JMfsyXF9iyJJpvx9FzHYu7l1dnhUMjiDUmUI0GyP2wS5e/CAUmXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650587; c=relaxed/simple;
	bh=+qDKiWzI86Y8bcFyisq++tmVL+kI9BxOdLZRsUy/agY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iENpnZo7kplXr3B3vy4h3Nzxs04cWazA3KOL4SEwWm7ot+y5a2RqJ8y6zKukQREd4RtYSQH0L+7l0G+uAQk1WC7kCLCJK/RPT+WLLz4zofpMP03ai2fhAKrxhMvIQIhKK5AD/DYUKg4xYDERvOOUQQ2QIekU1F73t4gg3pk004A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=hve83jYf; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729650582;
	bh=LVtT3dbjYqdKh/T94XNPQzLasLotD+NBYrIWiSYWxzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hve83jYft0cbN0TtQyEhuIu+d9QuwMCB9YhTuZsaBLLryxgslSKKV0YLEMn67zb8m
	 Y+hqKogMZCb281mGwf6KGJr1YMnvYCDEJA+APHSF91Uqajkovlh/58DznvPYYX2P47
	 V01xyHDDxR5gD8gfjPPmawSOPFc83tq/TT3X678HIQ4F9ct8X3JVBBoJusPUqEEg/q
	 jrY72sR8wuwHlAj4qWxuvsT4NSaV6zEMy8dXF2zHivZIK63F6l0w1ylRfzXOgbpDhe
	 7QcKXJDEHRcSYgtX+P2SzCvak4PLuSrR2f69wOGII5TrlLXBHEM/izpfIdMAWTQthY
	 6wFHFRQRCf6pA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XYCg949ssz4w2K;
	Wed, 23 Oct 2024 13:29:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Christian Loehle
 <christian.loehle@arm.com>
Cc: x86@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Ingo
 Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: Make ASYM_PACKING compile-time arch config
In-Reply-To: <e7d7a3d8-4b4a-47ff-8d69-a4c2e75d6818@linux.ibm.com>
References: <32c0aed9-bae1-4273-938d-36acb420eb56@arm.com>
 <e7d7a3d8-4b4a-47ff-8d69-a4c2e75d6818@linux.ibm.com>
Date: Wed, 23 Oct 2024 13:29:42 +1100
Message-ID: <87ldyf3621.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> On 10/18/24 03:16, Christian Loehle wrote:
>> Only x86 and Power7 set SD_ASYM_PACKING at boot-time depending on the
>
> Power10 on Shared Processor LPAR also enables that.
>
>> system. All other platforms don't make use of asym-packing anyway,
>> so introduce auxiliary ARCH_HAS_SCHED_ASYM_PACKING and guard all the
>> related logic behind that so it isn't compiled when not needed.
>> 
>> On arm64 this reduces
>> size kernel/sched/fair.o
>>     text	   data	    bss	    dec	    hex	filename
>>    74120	   4097	     88	  78305	  131e1	kernel/sched/fair.o
>> to
>> size kernel/sched/fair.o
>>     text	   data	    bss	    dec	    hex	filename
>>    72896	   4065	     88	  77049	  12cf9	kernel/sched/fair.o
>> 
>> Most of that is on the load-balance hot-path, in particular
>> need_active_balance() reduces from 141 to 84 instructions.
>
> This patch sprinkes #ifdef across the code. IMHO it makes the code 
> difficult to read.

Yes, strong agree on that.

It should be possible to clean that up for the most part with some
static inline helpers with stubs for the disabled case, in the usual
kernel style.

Also Christian please Cc linuxppc-dev@lists.ozlabs.org on v2.

cheers

