Return-Path: <linux-kernel+bounces-556086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869F8A5C0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CDB16E18E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9225A338;
	Tue, 11 Mar 2025 12:16:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE9D256C7B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695381; cv=none; b=duFXj3vt1T9iY63JYWbIhEmTzLARiC+W3OJeN1ZArpfJZkNScfV4JW/GRU4/PzcrUL1tR2+lnffPKaFzlqYT6jY4EcUHnJuRqFKs7/pLEZqSEikETxdS9iM3HhxhrqC5gc1Bpi0tIbUSZL7YGs9Tf4n5mTkrUKXwM1lUMA9qYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695381; c=relaxed/simple;
	bh=4E4NoPyd1Ub/ueGYWUZs7KKEzoEeAJ7K9hKV7Ejfseg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM6Kk5j+OXPd+NDsNL3E8kGKS0k4+ZQeFBsD9+Z1LrFYFComkOvnMKY0knHEagj6MslB+PSZvB0wXScD+rvRIPwcmm2vmHpWMGE9I6MjH9XKJxt+wUPzswHrLXStewKLpaWealAfU13l4jugo8ELXJA6yA0en3aczrsapPqEiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9E291762;
	Tue, 11 Mar 2025 05:16:30 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971583F673;
	Tue, 11 Mar 2025 05:16:13 -0700 (PDT)
Message-ID: <d0ef7c36-0edb-484e-8069-065a16895df0@arm.com>
Date: Tue, 11 Mar 2025 12:16:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Peter Newman <peternewman@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com,
 amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <CALPaoCjpdJB6GPk13GGHoA-UBgEpPdSMrqonThYObfkS9P7w+g@mail.gmail.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCjpdJB6GPk13GGHoA-UBgEpPdSMrqonThYObfkS9P7w+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peter,

On 03/03/2025 10:14, Peter Newman wrote:
> On Fri, Feb 28, 2025 at 8:59 PM James Morse <james.morse@arm.com> wrote:
>>
>> Changes since v6?:
>>  * All the excitement is in patch 37, turns out there are two rmdir() paths
>>    that don't join up.
>> The last eight patches are new:
>>  * The python script has been replaced with the patch that it generates, see
>>    the bare branch below if you want to regenerate it.
>>  * There have been comments on the followup to the generated patch, those are
>>    included here - I suggest they be squashed into the generated patch.
>>  * This version includes some checkpatch linting from Dave.
>>
>> ---
>> This series renames functions and moves code around. With the
>> exception of invalid configurations for the configurable-events, there should
>> be no changes in behaviour caused by this series. It is now possible for
>> throttle_mode to report 'undefined', but no known platform will do this.
>>
>> The driving pattern is to make things like struct rdtgroup private to resctrl.
>> Features like pseudo-lock aren't going to work on arm64, the ability to disable
>> it at compile time is added.
>>
>> After this, I can start posting the MPAM driver to make use of resctrl on arm64.
>> (What's MPAM? See the cover letter of the first series. [1])
>>
>> This series is based on v6.14-rc3 and can be retrieved from:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7
>> or for those who want to regnerate the patch that moves all the code:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare

> I applied the series successfully and ran through my usual assortment
> of container management-oriented testcases on the following
> implementations:

> * AMD EPYC 7B12 64-Core Processor

Great! This is something I've not managed to get my hands on.


> * Intel(R) Xeon(R) Gold 6268CL CPU @ 2.80GHz
> 
> Everything looked good.
> 
> Tested-by: Peter Newman <peternewman@google.com>

Thanks!

James

