Return-Path: <linux-kernel+bounces-539307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A39DA4A31B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0970B189B48A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34D230BF9;
	Fri, 28 Feb 2025 19:53:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D491B87FB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772429; cv=none; b=TKz+iunWhDK0wViVffTgYjwHOS0bEpBe0ZJUe9pnmLskOU/hFQ9W2XeUGEDlSwtaslATdN8Gfqnx+ouxwAwktCz1ngRxWPt94GZHSxrRSbKETCoNRQV0RwiMI4Epo7pv7j/qDYyE/xX+pSKCAPZd6k4rKSa/JY8yVBXhPdYS9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772429; c=relaxed/simple;
	bh=PF38+lYkgCSxvhiEXcCFV/amL2wPUnXVoXPrH82JEFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXp2zFM2UO5YKooe3hS0PQSNYTDLft8uH8pnDsj7oiX0WmkrrE1NpKVYprwHorRr+d9SGEnY4NzrZFAJHQfYzRwmPL3hqalhn2C8g+B+2wSScybXt3boLjpp273dSh4mINoaPJ3l0rq3yiI6tVFLpey++CFQj3eRPri9iaYHnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C7ED150C;
	Fri, 28 Feb 2025 11:54:02 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5343F5A1;
	Fri, 28 Feb 2025 11:53:39 -0800 (PST)
Message-ID: <714f450b-e9ee-415e-a63e-59e8b1e45091@arm.com>
Date: Fri, 28 Feb 2025 19:53:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 39/42] x86/resctrl: Split trace.h
To: Fenghua Yu <fenghuay@nvidia.com>, x86@kernel.org,
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
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-40-james.morse@arm.com>
 <dc055425-9db5-40ba-b9aa-fb95e49e883f@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <dc055425-9db5-40ba-b9aa-fb95e49e883f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fenghua,

On 27/02/2025 23:16, Fenghua Yu wrote:
> On 2/7/25 10:18, James Morse wrote:
>> trace.h contains all the tracepoints. After the move to /fs/resctrl, some
>> of these will be left behind. All the pseudo_lock tracepoints remain part
>> of the architecture. The lone tracepoint in monitor.c moves to /fs/resctrl.
>>
>> Split trace.h so that each C file includes a different trace header file.
>> This means the trace header files are not modified when they are moved.

> Since this patch itself doesn't cause the errors when W=1 and doesn't appear any issue to me,
> 
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks!

James

