Return-Path: <linux-kernel+bounces-252655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446C93166A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07D81C21774
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C7918EA8F;
	Mon, 15 Jul 2024 14:10:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423DF18EA8A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052636; cv=none; b=mv8X1mSPOe8E5b8zJmU0ffyGlRuDcjlCoBjfitclC0VtZgMCdoqGVPdf7tpbU4pO+4Jp8Q6I/QTzU3CpJwGKji6tJRd6Z2AYK77fPOagzTjAsFvrnffigSpZAQMWMO/XNnwZFCpLc1246VmKuYZfqRTgEiE+X+tU3NUjI3X1KIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052636; c=relaxed/simple;
	bh=hEt2+tulFHQ5OfcTM/fsDAzdpEf70Wr1pz+q3O5Oxq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzuzNa/HJ2EEY6Grk+qhnDbpiDkU2FgRu4G6D6x4en5wZxW1eTLS3yhskhYDonNGDbMc4rjpcBtwjZYix5lf0c6oAyyA+aFQSN13hGf4nCk4wDKKKHlzAdoSGiF8U3+W/mhQlNQUd43sIxPR+32XrH68+zlrke75SEe6vZD5u8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 819A2DA7;
	Mon, 15 Jul 2024 07:10:56 -0700 (PDT)
Received: from [10.57.77.136] (unknown [10.57.77.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C76F43F766;
	Mon, 15 Jul 2024 07:10:29 -0700 (PDT)
Message-ID: <96965a23-49ea-41f5-a4b0-9b5296dafe00@arm.com>
Date: Mon, 15 Jul 2024 15:10:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] mm: swap: mTHP swap allocator base on swap cluster
 order
Content-Language: en-GB
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>,
 "Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <ae6b4885-0590-4585-a1fd-39b64df2f902@arm.com>
 <CACePvbX99r8BNZTkax=KGBx-XYP6WLxZKez3qsi+FfreC2TwGg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CACePvbX99r8BNZTkax=KGBx-XYP6WLxZKez3qsi+FfreC2TwGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/07/2024 15:08, Chris Li wrote:
> On Thu, Jul 11, 2024 at 3:02 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>>> Kernel compile under tmpfs with cgroup memory.max = 2G.
>>> 12 core 24 hyperthreading, 32 jobs.
>>>
>>> HDD swap 3 runs average, 20G swap file:
>>>
>>> Without:
>>> user  4186.290
>>> system        421.743
>>> real  597.317
>>>
>>> With:
>>> user  4113.897
>>> system        413.123
>>> real  659.543
>>
>> If I've understood this correctly, this test is taking~10% longer in wall time?
> 
> Most likely due to the high variance in measurement and fewer
> measuring samples 3 vs 10. Most of that wall time is waiting for IO.
> It is likely just noise.

OK, that certainly makes sense, as long as you're sure its noise. The other
(unlikely) possibility is that somehow the HDD placement descisions are
changing, which increases waiting due to increased seek times.

> 
>> But your changes shouldn't affect HDD swap path? So what's the reason for this?
> 
> The change did affect HDD swap path in the sense that it did not need
> to check for si->cluster_info any more. A small gain there.
> 
> The wall clock time is more than double the SSD or zram. Which means
> most of the time the system is waiting for HDD IO to complete (wait is
> 98%) , there will be much higher variance for sure. At this point the
> wall clock we are measuring the wait mostly,  not the actual work. The
> system time is quicker, that is good.
> 
> I now have a dedicated machine to run the HDD swap now. The HDD is
> very very slow to swap. The point of the HDD test is being able to
> complete the run without OOM. Because of the high latency in HDD,
> there will be more memory pressure. It did catch some other bugs in my
> internal version of the patch.
> 
>> I'm hoping to review this properly next week. It would be great to get this in
>> sooner rather than later IMHO.
> 
> Thank you. This new code path is much easier to work with than the
> previous SSD and HDD mixed allocation path. I am able to implement the
> cluster reservation experiment in the new allocator much quicker.
> 
> Chris


