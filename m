Return-Path: <linux-kernel+bounces-231838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A65919EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A9E283415
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964B200B7;
	Thu, 27 Jun 2024 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="kqBF9kgi"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811D1CF92
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467792; cv=none; b=XW8HiWuoZRxLSjCZ9EL/sPdW4Gz7exnQrBzFbDndIsw2PSIdt+b76OxgO0gCReTBGEkG2vuEam2WjyF+rErzYLKY6Oj7N/I+/0C04B/ZWocgoQoy26N8Jit1iH7FftNepiwkbNU/Emm7uc3LOcaECS81QavXQ2jc0ADll0c8f4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467792; c=relaxed/simple;
	bh=8vvzGrantwuL/R2xQkGqHE8tIOmWmXBDuID/+0TaR6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MgwvN5RkOnYXC2Mc+sd3Zi+R/fbqBllkPODAY8HyFMEFHzQPjCCyu6+541pXp2NfqXI1q11C7xmNBRZaRZV+6vaffi5nKBYcgPs6RcCT6OY0YuNHPxbMQgjjsp3s2UhS2Gr2BySGQkdK+YMUGpbdm65MpyTcNkUMKXNDH6Xwtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=kqBF9kgi; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719467780;
	bh=7+E8f8lXa7CASz+mW2GaykJblb4nLV4NYfpWy3l4hGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kqBF9kgi5cqdeBlAr1/IgHISmLAtFKFIBQHkpbDHH63ZsjvAlvldROB8LWkDeqn8g
	 YfwTKOvGsF8g55svs/byqL1bF5z/Hyno7KxxPCMY0dw6sAW03vd5+BDUnRpsZpjiKk
	 zi8Zd6gX/Mqtc3VyDKN2Z2nH/xSk49fi2d+Iartmt71NNpHjrLS5hUm5v8AvXSf2C8
	 oR+e7tP9Hwjw23fSg92mA9ulpkMIW9N2ROTqVzYQuIGcgm37SmWe7EzbpT3taU2Cmk
	 G1+ksUVGrIMjC6YSlBh0P1lf83unHpw793+DORRmYEBAxchD5s7u3qurRX1hGOIEGL
	 v+i4DffwBlhKQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W8nr335sHz4w2M;
	Thu, 27 Jun 2024 15:56:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ankur Arora <ankur.a.arora@oracle.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
 peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
 rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
 joel@joelfernandes.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, LKML
 <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
In-Reply-To: <87msn785f0.fsf@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
 <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
 <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
 <871q4td59k.fsf@oracle.com>
 <14d4584d-a087-4674-9e2b-810e96078b3a@linux.ibm.com>
 <87msn785f0.fsf@oracle.com>
Date: Thu, 27 Jun 2024 15:56:18 +1000
Message-ID: <87sewzkjy5.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ankur Arora <ankur.a.arora@oracle.com> writes:
> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
>> ...
>> This was the patch which I tried to make it per cpu for powerpc: It boots and runs workload.
>> Implemented a simpler one instead of folding need resched into preempt count. By hacky way avoided
>> tif_need_resched calls as didnt affect the throughput. Hence kept it simple. Below is the patch
>> for reference. It didn't help fix the regression unless I implemented it wrongly.
>>
>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>> index 1d58da946739..374642288061 100644
>> --- a/arch/powerpc/include/asm/paca.h
>> +++ b/arch/powerpc/include/asm/paca.h
>> @@ -268,6 +268,7 @@ struct paca_struct {
>>  	u16 slb_save_cache_ptr;
>>  #endif
>>  #endif /* CONFIG_PPC_BOOK3S_64 */
>> +	int preempt_count;
>
> I don't know powerpc at all. But, would this cacheline be hotter
> than current_thread_info()::preempt_count?
>
>>  #ifdef CONFIG_STACKPROTECTOR
>>  	unsigned long canary;
>>  #endif

Assuming stack protector is enabled (it is in defconfig), that cache
line should quite be hot, because the canary is loaded as part of the
epilogue of many functions.

Putting preempt_count in the paca also means it's a single load/store to
access the value, just paca (in r13) + static offset. With the
preempt_count in thread_info it's two loads, one to load current from
the paca and then another to get the preempt_count.

It could be worthwhile to move preempt_count into the paca, but I'm not
convinced preempt_count is accessed enough for it to be a major
performance issue.

cheers

