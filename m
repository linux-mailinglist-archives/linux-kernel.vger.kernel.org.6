Return-Path: <linux-kernel+bounces-344467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262B498AA16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E91C21321
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A0194ACB;
	Mon, 30 Sep 2024 16:42:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168F1946A9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714562; cv=none; b=unB/WYnwyVlVxwVbmHxeXQMLDOZQSOZrIL8SQ8sc0mObG1/fbxk/SB71CAtIpegXDO9dy1qkwgGWcLBcJfFdJPmFikCoS1cQR3akzh9OaHpr30igIJK0lxbiWxfc+0E6BuceEXPDgmnfzfwHJXKQ1i17gzkySP3OpCr5SNH0uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714562; c=relaxed/simple;
	bh=dIvU3lUB+vKhLJlKYFDQKG4kLUMrt5J6kADrQOy7dYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kl70PdyhI1I/OLeI4GHDgzvA5SrlXmdvUjm0CzbqZWHZIz9wctuBu1ZnIj1w1iuRjHqillkrdGNAuwa453UpfdtVJpjFE4fHfU8csABgjpwX0mIQhXTC3RVp48QnJMu3jEsXUFjDVtd7VZuPv7Qr+3JWbdzXkFpCa2x6ZRfZtk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B15DA7;
	Mon, 30 Sep 2024 09:43:09 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 013C93F71A;
	Mon, 30 Sep 2024 09:42:34 -0700 (PDT)
Message-ID: <e3c8709a-e9df-44fb-bb78-ede6fb44c758@arm.com>
Date: Mon, 30 Sep 2024 17:42:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/39] x86/resctrl: Move monitor exit work to a resctrl
 exit call
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-16-james.morse@arm.com>
 <c4807d24-10ea-4baf-8477-4d876deff4c1@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <c4807d24-10ea-4baf-8477-4d876deff4c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 14/08/2024 05:01, Reinette Chatre wrote:
> On 8/2/24 10:28 AM, James Morse wrote:
>> rdt_put_mon_l3_config() is called via the architecture's
>> resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
>> and closid_num_dirty_rmid[] arrays. In reality this code is marked
>> __exit, and is removed by the linker as resctrl can't be built
>> as a module.
>>
>> To separate the filesystem and architecture parts of resctrl,
>> this free()ing work needs to be triggered by the filesystem,
>> as these structures belong to the filesystem code.
>>
>> Rename rdt_put_mon_l3_config() resctrl_mon_resource_exit()
>> and call it from resctrl_exit(). The kfree() is currently
>> dependent on r->mon_capable.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
>> ---
>> Changes since v3:
>>   * Moved r->mon_capable check under the lock.
>>   * Dropped references to resctrl_mon_resource_init() from the commit message.
>>   * Fixed more resctrl typos,
>>
>> Changes since v2:
>>   * Dropped __exit as needed in the next patch.
> 
> Is this still relevant? It is unclear to me why __exit is dropped here.

resctrl_init() in the next patch wants to call resctrl_mon_resource_exit() as part of its
cleanup. This trips the mismatched section checks as the __exit code is discarded at link
time because you can't build resctrl as a module.

I'll opt for the churnier version that removes the exit markers in the next patch.


Thanks,

James

