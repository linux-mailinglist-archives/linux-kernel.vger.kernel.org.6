Return-Path: <linux-kernel+bounces-556495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D31A5CA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC747A55B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0425E833;
	Tue, 11 Mar 2025 16:18:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9FB32C8E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709892; cv=none; b=J+W2oNLa3tEMTymIMHcVjj5EUD6nx4bWJjV6BCaRQPxJQ3cCkcChD/UT4OQAyx4m9HI/JG4/rihzVsGaCMUI+X+FNts2kIUfybYviJpzMoPkmSiIqc1wt/m4vN7Rw8ZpIGavGSTT+wuLGNACqQ654VqZovkOLhWDTitX2Bd4Dlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709892; c=relaxed/simple;
	bh=M3oNNyikuJiqrPWwOjWDWDb8OBXjfC6fpC8/6GYut8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=do5DPtsCcSpHD+Ugnrc1XzJoA5uEuWZYVAzXZxyPk6+BBh3em8XFZGGl2qVuXTWzl6608xWOz5CmYNbhSbbzP7mSDaHxHIqXJRtBIdfS+bL+LOOMWqnYJwvO1IEwVJclFOxOWl7r1qfqXBv5rt5RRqwYlkjjcWFDIcXjt4nSnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448911516;
	Tue, 11 Mar 2025 09:18:21 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 346523F673;
	Tue, 11 Mar 2025 09:18:05 -0700 (PDT)
Message-ID: <b23402de-1123-42d7-8b49-5ce0c017818d@arm.com>
Date: Tue, 11 Mar 2025 16:18:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <7945ffca-6c2c-4baf-89e7-688681db29ca@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <7945ffca-6c2c-4baf-89e7-688681db29ca@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 10/03/2025 14:07, Moger, Babu wrote:
> On 2/28/25 13:58, James Morse wrote:
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


> Ran tests on couple of AMD systems.  Everything looks good.
> 
> Tested-by: Babu Moger <babu.moger@amd.com>

Thanks!

James

