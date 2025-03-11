Return-Path: <linux-kernel+bounces-556728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3434A5CDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F22517794B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B42620DD;
	Tue, 11 Mar 2025 18:38:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4158F2620C4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718333; cv=none; b=Nhd7PqB8x2gMZR/folcsMa3AIHRjKBjs6f8viWyxUlOivlLpTvDUnL89ZGAD+NjM4cxTsB19AG1o3G7yFe+wiBmV4ax103TWdClXqiVAfGWuKfq8kIHpqSY3XZ6HjA8Z/GVXxQZUeVUc06Hlo+YQffya5Ktqd4OXf1M83O4F7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718333; c=relaxed/simple;
	bh=cRxd+kYv8uXvO7znqc/eBgmvN0tN3M5PKxLgIPEXpiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLgb53tPIWUyMx7WA5A1Eqyge23+WGLyT4b6GDX2TQgoi5O4GkT6HP9b7pUTLx8z8NGUfQlguEJvjD7eQwUqVlYbOLXfa41FVcml3YiKd/tLtKk50ZrZi5fXnuGaUcGZCDmovxeFlsGIN5CQztD/XlwpGJfqdgOxrdDIEI6zGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784401515;
	Tue, 11 Mar 2025 11:39:02 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B1FC3F694;
	Tue, 11 Mar 2025 11:38:45 -0700 (PDT)
Message-ID: <09b9d760-0c9f-46f5-9784-5229e9023583@arm.com>
Date: Tue, 11 Mar 2025 18:38:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
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
 <20250310190915.GAZ8842wfIn043W56k@fat_crate.local>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250310190915.GAZ8842wfIn043W56k@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Boris,

On 10/03/2025 19:09, Borislav Petkov wrote:
> On Fri, Feb 28, 2025 at 07:58:24PM +0000, James Morse wrote:
>> Changes since v6?:
>>  * All the excitement is in patch 37, turns out there are two rmdir() paths
>>    that don't join up.
>> The last eight patches are new:
>>  * The python script has been replaced with the patch that it generates, see
>>    the bare branch below if you want to regenerate it.
>>  * There have been comments on the followup to the generated patch, those are
>>    included here - I suggest they be squashed into the generated patch.
>>  * This version includes some checkpatch linting from Dave.
> 
> So, Reinette says that 1-30 should be ready to go. Care to send them ASAP with
> all the review feedback addressed so that I can try to queue them,

Thanks - look out for a 'v8:for_boris'.


> we all test
> the branch this week and thus I can empty a considerable amount out of your
> bucket of patches...


Thanks!

James

