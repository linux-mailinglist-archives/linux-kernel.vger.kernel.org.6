Return-Path: <linux-kernel+bounces-556723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46373A5CDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66F9189E9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1D2620F9;
	Tue, 11 Mar 2025 18:33:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4285260373
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718014; cv=none; b=I+AsTyV8knp0ufo2aB1oAn2Ci84RcD3nzR4PTrGqMFy+po6+U4L/KmEm62qRSS1RFRDsQW0Nb+ESshFW6fOfp31fZ9OeY2LjsoWulsn/+UHzSjXXAo/2M8j+XYxIpZi/yQI+n4M03Zii95R7mX6gghdEdldwkVJEr1ij8Ql3VDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718014; c=relaxed/simple;
	bh=2Ed75qd5KiL5AresZo+nkero+T7NYsFxnCsnq3hMB8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvlY27PnANjBMVB473ISwuN+N9m4EXPELZmLbiowfdYftAXjNPI7DZJLGCKWkGtoqVJPKgSbGf8bN3K87o7i2qrt8pSb3KgscXF06NweXjX6QhnZQd488HuF3zBm4a9/ERL7ICtWErL8tUy3fRSIlQsPcSchxPxagHqm50p73xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9091A1688;
	Tue, 11 Mar 2025 11:33:42 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20EDE3F694;
	Tue, 11 Mar 2025 11:33:25 -0700 (PDT)
Message-ID: <2a5947c1-b493-430a-9383-33eb8f1e76af@arm.com>
Date: Tue, 11 Mar 2025 18:33:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Amit Singh Tomar <amitsinght@marvell.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <5436632b-cdc8-4a55-8766-0cc2aec0b807@marvell.com>
 <5f3171e0-d96e-47ea-92d7-0a3e3e3f8147@marvell.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <5f3171e0-d96e-47ea-92d7-0a3e3e3f8147@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Amit,

On 07/03/2025 13:50, Amit Singh Tomar wrote:
> On 3/7/2025 3:57 PM, Amit Singh Tomar wrote:
>> Changes since v6?:
>>
>>>   * All the excitement is in patch 37, turns out there are two rmdir() paths
>>>     that don't join up.
>>> The last eight patches are new:
>>>   * The python script has been replaced with the patch that it generates, see
>>>     the bare branch below if you want to regenerate it.
>>>   * There have been comments on the followup to the generated patch, those are
>>>     included here - I suggest they be squashed into the generated patch.
>>>   * This version includes some checkpatch linting from Dave.
>>>
>>> ---
>>> This series renames functions and moves code around. With the
>>> exception of invalid configurations for the configurable-events, there should
>>> be no changes in behaviour caused by this series. It is now possible for
>>> throttle_mode to report 'undefined', but no known platform will do this.
>>>
>>> The driving pattern is to make things like struct rdtgroup private to resctrl.
>>> Features like pseudo-lock aren't going to work on arm64, the ability to disable
>>> it at compile time is added.
>>>
>>> After this, I can start posting the MPAM driver to make use of resctrl on arm64.
>>> (What's MPAM? See the cover letter of the first series. [1])
>>>
>>> This series is based on v6.14-rc3 and can be retrieved from:
>>> https://urldefense.proofpoint.com/v2/url?
>>> u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_morse_linux.git&d=DwIDAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=nuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=34Q-cAJD41LWUgU21FvoSkXHOM-uSrOs2a1vEwaxrNE&e= <https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_morse_linux.git&d=DwIDAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=nuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=34Q-cAJD41LWUgU21FvoSkXHOM-uSrOs2a1vEwaxrNE&e=> mpam/move_to_fs/v7
>>> or for those who want to regnerate the patch that moves all the code:
>>
>> After rebasing mpam/snapshot/v6.14-rc1 on top of this series,

Hmmm - right, because this series doesn't contain the python script that generates
patch-45, so git can't know that all the code is the same.


>> Tested a few MPAM
>> controls, including Cache Portion Partitioning and Memory Bandwidth Partitioning, on
>> Marvell CN10K ARM64 platform, and It looks good.

Thanks!


>> For this patch-set:
>> Tested-by: amitsinght@marvell.com
> Realized I used an incorrect format for the Tested-by tag, correcting it now
> 
> Tested-by: Amit Singh Tomar <amitsinght@marvell.com>

I'll add an '# arm64' suffix on that as that's what got tested.


Thanks,

Jaems

