Return-Path: <linux-kernel+bounces-192273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7765E8D1AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193A21F23975
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0716D9A5;
	Tue, 28 May 2024 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxZlZLnQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30B73445
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898668; cv=none; b=tRaO4YuxRvrMjsl4pDPK8H9PmilpIGb3Ffm+xlfX34VIM1EbFfmTYQl/v3OKnilajNIRiwTOMYcRNRKnOPHQncUcgXnjEuvEMML8zhlHaSz+xyXSoSCuEqua4nBCLlRa4XvgiOGG3MpgG1/XsgMNW/BIaOmrMWqiRxagGgg45Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898668; c=relaxed/simple;
	bh=thkilVwsc5+/E9dlNQwbhLVQMP7WluQzYZN1Agek5fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDvpnAli/oArNUdrADeZ6sWL0qCaeKohdK78/AFJeU6ARmiirp7wd4z0joWRhfhob9qXav9rB+uKI4G0EDQr69r9Isqnlhf4NKak/7BwvwhDww234jPNXJmL/HFXP4LLNVGoAaSGmvUW6STGztyTfS1+Ls7UlJgT6xKIqEx7mnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxZlZLnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734E1C3277B;
	Tue, 28 May 2024 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898668;
	bh=thkilVwsc5+/E9dlNQwbhLVQMP7WluQzYZN1Agek5fQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JxZlZLnQbVOpdyxPuOOShDwTA4njtQfdwSDyyflpNIedLQrbkISnZw+mGdd7xaLs2
	 MRkcRaBHEZ50sWtM4TDJJt97DCar+id3e2VZaCwDIQUcvJis0NnrQlPgJsLG0R7+ed
	 Q1WE9NRXZK48cbv4giKbZZMnlREq2wuNwjt49QE1D7H0OZhX/4PPWkddxUkEmpgpc6
	 W8HsypC+AdPzAgnFk3Alwevyiadlfqsg/KHcX17V+dKZdJrours3NKSjybkFIs5uB1
	 Pot20RdxIv3++zqAyGGpcPqgl09Avvaz5Klij/GhBg+uNn8QVRnxFZFEFOMcFTd6ga
	 BMyfUBrESx7Xw==
Message-ID: <800ceb7a-7c48-442b-912c-d55c6a1aaacb@kernel.org>
Date: Tue, 28 May 2024 14:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memcg: simple cleanup of stats update functions
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240420232505.2768428-1-shakeel.butt@linux.dev>
 <20240527152200.P1rU7FaG@linutronix.de>
 <86006806-4ffc-4330-ab4b-29215ab2c98c@kernel.org>
 <n6zstrcbqp7fqpennqf3qgt2nuc2tdrnsc5dmoawyke3zn3xcm@6uirkotvrhe6>
 <20240528075623.oFcU1JLj@linutronix.de>
 <69c0e008-ddde-4a38-b856-b765dc2b9745@kernel.org>
 <20240528101906.ts4NjHvU@linutronix.de>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240528101906.ts4NjHvU@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 12:19 PM, Sebastian Andrzej Siewior wrote:
> On 2024-05-28 10:10:50 [+0200], Vlastimil Babka (SUSE) wrote:
>> > I don't mind sending a patch. I'm just not sure if the lock is the right
>> > thing to do. However it should ensure that interrupts are disabled on
>> > !RT for the sake of the counter update (if observed in IRQ context).
>> 
>> Looks like some places there use VM_WARN_ON_IRQS_ENABLED() that's turned off
>> for PREEMPT_RT, so maybe that's what should replace the current
>> lockdep_assert, perhaps together with
>> lockdep_assert_held(this_cpu_ptr(&memcg_stock.stock_lock));
>> 
>> But also __mod_memcg_lruvec_state() already has that VM_WARN_ON.
> 
> This "VM_WARN_ON_IRQS_ENABLED" is the initial assert for "interrupts
> must be disabled while change the counter".
> You want to replace it with lockdep? Part of its requirement was that it
> yells with lockdep disabled.

No I meant the other way around, that we'de use VM_WARN_ON_IRQS_ENABLED
instead of the current lockdep_assert() that doesn't work on RT.

> Currently I am leaning towards removing the
> lockdep_assert_irqs_disabled() from __mod_objcg_mlstate(). Nothing but
> the counter need it and they have their own check. So?

Yeah that might be sufficient.

> Sebastian


