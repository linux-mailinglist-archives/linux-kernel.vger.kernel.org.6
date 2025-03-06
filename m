Return-Path: <linux-kernel+bounces-548637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BFA5475E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E423AC8F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF641FCFE6;
	Thu,  6 Mar 2025 10:10:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BC19DF49
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255831; cv=none; b=e8vagZCL1N5r9upvXsvoWLgx7MYGccLs+ACv6cnoOBzto//jIcd9q2GEusy4z9IBqBfpXcPLqX4jHyOel3RnF0rp4Pnzfw2YLTuceVtNwt4WmOXNinxzdvQAVviXqqsxQ52e69uJSWeZbCmov7DycDKzkftybpSQNqTTKBu5j3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255831; c=relaxed/simple;
	bh=STEeW40hCilZG5czbi9ItK8cU8w+m/WZbpcf3GzfD5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZFhNlUhnRAOFVvKZefcQCM8j/9kNKTI78vEDvB1KClvUVkU8kyEclez0vFWe23Pl9gkDrMStjFqo2SCsjyO3uAC7ZVhUZNs+CYbarsWa6T2E6Vz3lierdyEMAXvmdkb1J5BB6/uqrJmNdP5XEYVdKj2BvelVEhUdUm9y2d+Ls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C97DBFEC;
	Thu,  6 Mar 2025 02:10:42 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FDC53F66E;
	Thu,  6 Mar 2025 02:10:27 -0800 (PST)
Message-ID: <bf41cc53-6f12-483e-92ea-3a57880b0ac1@arm.com>
Date: Thu, 6 Mar 2025 11:10:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: Fix invalid pointer dereference in
 child_cfs_rq_on_list()
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, riel@surriel.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, odin@uged.al, linux-kernel@vger.kernel.org
References: <20250304170007.245261-1-aboorvad@linux.ibm.com>
 <CAKfTPtCJKkwFeMKUrD3o224Nz4N+1qjtq0LvL945k9tJ8t8h-g@mail.gmail.com>
 <f1bf21e6-4fd3-4f97-b28f-b0e8dc37ff91@arm.com>
 <172769aab6901361f992a4ca67dd5dd8864f43ba.camel@linux.ibm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <172769aab6901361f992a4ca67dd5dd8864f43ba.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 05:48, Aboorva Devarajan wrote:
> On Wed, 2025-03-05 at 10:23 +0100, Dietmar Eggemann wrote:
>> On 05/03/2025 09:21, Vincent Guittot wrote:
>>> On Tue, 4 Mar 2025 at 18:00, Aboorva Devarajan <aboorvad@linux.ibm.com> wrote:

[...]

>>>> A recent attempt to reorder fields in struct rq exposed this issue by
>>>> modifying memory offsets and affecting how pointer computations are
>>>> resolved. While the problem existed before, it was previously masked by
>>>> specific field arrangement. The reordering caused erroneous pointer
>>>> accesses, leading to a NULL dereference and a crash, as seen in the
>>
>> I'm running tip/sched/core on arm64 and I still only see the wrong
>> pointer for 'prev_cfs_rq->tg->parent' in the 'prev ==
>> &rq->leaf_cfs_rq_list' case?
>>
>> ...
>> cpu=5 prev_cfs_rq->tg=ffff00097efb63a0 parent=0000000000000010
>> cfs_rq->tg=ffff000802084000
>> ...
>>
> 
> Hi Dietmar,
> 
> Yes, you are right, I meant that we will still have invalid pointers and use it 
> silently in the vanilla kernel, but it won't always lead to a crash.
> 
> The crash in this specific case happens if `prev_cfs_rq->tg` points to a memory
> location that cannot be de-referenced. Otherwise, the function de-references and
> uses memory locations that are not valid but did not cause a visible failure so far.
> 
> Here are more details on what I meant by reordering the runqueue:
> 
> With the system and kernel configuration, I encountered the crash while trying
> to reorder the runqueue structure, here is the minimal change that caused the
> crash on top of v6.14-rc5 kernel:

Ah, OK. You changed the code locally. Somehow I thought you referred to
a change which is already in mainline (or tip/sched/core) and I was
wondering which one it would be.

[...]

> But looks like a patch similar to this is merged yesterday [1], so this can
> be ignored :)
> 
> 
> [1] https://lore.kernel.org/all/174119292742.14745.16827644501260146974.tip-bot2@tip-bot2/

Ah, OK, same idea though.

BTW, the:

 	} else {
 		prev = rq->tmp_alone_branch;
 	}

path is taken when dealing with CONFIG_CFS_BANDWIDTH and throttling
scenarios so this is important to cover as well.

