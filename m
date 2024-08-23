Return-Path: <linux-kernel+bounces-299639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2657D95D7FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27F41F2378A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0235B1C6F61;
	Fri, 23 Aug 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dJRc/eOC"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED818CC0F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445970; cv=none; b=RF7g62neN1aIPP6QvgPSGmzkzHhg+M71J6dEtiEGStzPXuzxkR6cQePUHo98z8tRWQwlHNTu5VbxyLRKfrY1JOxDGsgqod/WbGvXON3xOLZNrf6pU9CwMinM5um7L6UxBV4pFBdqGtJD+7/EFusd4rDXbHIr2bB8SC3dlKjLbFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445970; c=relaxed/simple;
	bh=X2gM6OVm8Jjt+ccz7Yt5cwcMf1v+J3gbJelrXenxu8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMhahdeU3d61PrU37yquz2fijsDkpPMnWIU8H/0mES7ApsDkQIFIB4/kOw+B4ZUsRoXQqTKpOnFXxaUjaIMU/ruMuArmcCe5FThGQciWpHBNoEfqd9Emgytl3WTEwpsdW/j8HPLs3xxm02ugv/uuBsN16DJf/gTSHesz2kgJRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dJRc/eOC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724445965;
	bh=X2gM6OVm8Jjt+ccz7Yt5cwcMf1v+J3gbJelrXenxu8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dJRc/eOCTLDhH4k1gY8L++VMuxkMcpmT0zbpRaXYpfGJkaSbl3VlsycBy/MhACM54
	 C+fuHGbfR0fMuN49fwUXXNa8+ew42rdhLZseNPcMXWhdxr4052rKCiHfjfw1/sJAGc
	 tDseI5K5csezlAn3WnwwW2Tm/2roxl16Lh7QNY5wQuSXgMr8R8Qe2lcMGjwFx25kPu
	 lJmgY3NU6Oc0O8W/VljP3Tzla7fSeNiDF8UgbryjcOGXfUKko3xACsFLRzzxjx0+5f
	 Ti9osi+YKiLm3Hn+7P8pJcWzWwdOzPhD3do0A5ryrsU6c6/6bTLQ3v1hGLR09WEkis
	 fyMTG3ieWVPhA==
Received: from [IPV6:2606:6d00:100:4000:b243:804e:3bbd:91c9] (unknown [IPv6:2606:6d00:100:4000:b243:804e:3bbd:91c9])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WrBtP4vl9z1HtS;
	Fri, 23 Aug 2024 16:46:05 -0400 (EDT)
Message-ID: <67dde65a-75fa-4c34-a8a7-02260c394bf2@efficios.com>
Date: Fri, 23 Aug 2024 16:45:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/6] sched: NUMA-aware per-memory-map concurrency
 IDs
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
 <20240823185946.418340-5-mathieu.desnoyers@efficios.com>
 <ZsjtuTsKuS1k1RK_@yury-ThinkPad>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZsjtuTsKuS1k1RK_@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-23 22:14, Yury Norov wrote:
> On Fri, Aug 23, 2024 at 02:59:44PM -0400, Mathieu Desnoyers wrote:
>> The issue addressed by this change is the non-locality of NUMA accesses
>> to data structures indexed by concurrency IDs: for example, in a
>> scenario where a process has two threads, and they periodically run one
>> after the other on different NUMA nodes, each will be assigned mm_cid=0.
>> As a consequence, they will end up accessing the same pages, and thus at
>> least one of the threads will need to perform remote NUMA accesses,
>> which is inefficient.
>>
>> That being said, the same issue theoretically exists due to false
>> sharing of cache lines by threads running on after another on different
> 
> running one after another you mean?

Yes, you are correct. I will fix this typo for the next round,

Thanks,

Mathieu

> 
>> cores/CPUs within a single NUMA node, but the extent of the performance
>> impact is lesser than remote NUMA accesses.
>>
>> Solve this by making the rseq concurrency ID (mm_cid) NUMA-aware. On
>> NUMA systems, when a NUMA-aware concurrency ID is observed by user-space
>> to be associated with a NUMA node, guarantee that it never changes NUMA
>> node unless either a kernel-level NUMA configuration change happens, or
>> scheduler migrations end up migrating tasks across NUMA nodes.
>>
>> There is a tradeoff between NUMA locality and compactness of the
>> concurrency ID allocation. Favor compactness over NUMA locality when
>> the scheduler migrates tasks across NUMA nodes, as this does not cause
>> the frequent remote NUMA accesses behavior. This is done by limiting the
>> concurrency ID range to minimum between the number of threads belonging
>> to the process and the number of allowed CPUs.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Ben Segall <bsegall@google.com>
>> ---
>> Changes since v0:
>> - Rename "notandnot" to "nor".

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


