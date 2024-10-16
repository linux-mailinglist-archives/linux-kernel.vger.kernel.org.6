Return-Path: <linux-kernel+bounces-368391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AB9A0F52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68592285000
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B771220F5BF;
	Wed, 16 Oct 2024 16:08:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF720E03D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094888; cv=none; b=TqI/33ZHfzarPrrzazVYmKcSadVHSkCGQ/X9dbyxU2tzyrAHCYflPTUOQEXaKlRVXV5fGkdnCaMSkdWATTWBpU9E/l5jJXVIr7xwgMalHTV/M+6I9V1KbcKzS7PNjNRvDcsJ49Vim7ZxCVTfBYgWJFL02dyD798peejg32Yr9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094888; c=relaxed/simple;
	bh=7OH6X9fld2kMyP6pTpcFyCrPl0K0mQXCFWEEjmoi7v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1pdqZdeLoc5yO2swNkkcsUAuJCQBC0FI0CODyHoJDzZ4HD/b4FWc+IqZG8NEgxBAFSsea5ChiUNMHOSLw3kUJCWpyBRsVx8BQ+9Mvu784vojeCZRfcQm02KKcuY6iguIlcNRQdDbGV6FihgEEPfIPgdXMzJohSBNxKI/Gv/SaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7CBCFEC;
	Wed, 16 Oct 2024 09:08:34 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB5203F71E;
	Wed, 16 Oct 2024 09:08:02 -0700 (PDT)
Message-ID: <4fe2408b-7435-41c2-a6b8-82cefeea50ed@arm.com>
Date: Wed, 16 Oct 2024 17:08:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 Donald Dutile <ddutile@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <1fd0dae8-b04a-42b9-9d6f-32100610ef76@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <1fd0dae8-b04a-42b9-9d6f-32100610ef76@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/10/2024 16:16, David Hildenbrand wrote:
>> Performance Testing
>> ===================
>>
>> I've run some limited performance benchmarks:
>>
>> First, a real-world benchmark that causes a lot of page table manipulation (and
>> therefore we would expect to see regression here if we are going to see it
>> anywhere); kernel compilation. It barely registers a change. Values are times,
>> so smaller is better. All relative to base-4k:
>>
>> |             |    kern |    kern |    user |    user |    real |    real |
>> | config      |    mean |   stdev |    mean |   stdev |    mean |   stdev |
>> |-------------|---------|---------|---------|---------|---------|---------|
>> | base-4k     |    0.0% |    1.1% |    0.0% |    0.3% |    0.0% |    0.3% |
>> | compile-4k  |   -0.2% |    1.1% |   -0.2% |    0.3% |   -0.1% |    0.3% |
>> | boot-4k     |    0.1% |    1.0% |   -0.3% |    0.2% |   -0.2% |    0.2% |
>>
>> The Speedometer JavaScript benchmark also shows no change. Values are runs per
>> min, so bigger is better. All relative to base-4k:
>>
>> | config      |    mean |   stdev |
>> |-------------|---------|---------|
>> | base-4k     |    0.0% |    0.8% |
>> | compile-4k  |    0.4% |    0.8% |
>> | boot-4k     |    0.0% |    0.9% |
>>
>> Finally, I've run some microbenchmarks known to stress page table manipulations
>> (originally from David Hildenbrand). The fork test maps/allocs 1G of anon
>> memory, then measures the cost of fork(). The munmap test maps/allocs 1G of anon
>> memory then measures the cost of munmap()ing it. The fork test is known to be
>> extremely sensitive to any changes that cause instructions to be aligned
>> differently in cachelines. When using this test for other changes, I've seen
>> double digit regressions for the slightest thing, so 12% regression on this test
>> is actually fairly good. This likely represents the extreme worst case for
>> regressions that will be observed across other microbenchmarks (famous last
>> words). Values are times, so smaller is better. All relative to base-4k:
>>
> 
> ... and here I am, worrying about much smaller degradation in these micro-
> benchmark ;) You're right, these are pure micro-benchmarks, and while 12% does
> sound like "much", even stupid compiler code movement can result in such changes
> in the fork() micro benchmark.
> 
> So I think this is just fine, and actually "surprisingly" small. And, there is
> even a way to statically compile a page size and not worry about that at all.
> 
> As discussed ahead of times, I consider this change very valuable. In RHEL, the
> biggest issue is actually the test matrix, that cannot really be reduced
> significantly ... but it will make shipping/packaging easier.
> 
> CCing Don, who did the separate 64k RHEL flavor kernel.
> 

Thanks, David! I'm planning to investigate and see if I can improve even on that
12%. I have a couple of ideas. But like you say, I don't think this should be a
blocker to moving forwards.


