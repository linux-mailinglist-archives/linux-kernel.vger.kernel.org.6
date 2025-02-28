Return-Path: <linux-kernel+bounces-539325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FCA4A33C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CA8189D470
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C7276D35;
	Fri, 28 Feb 2025 19:56:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367426F444
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772589; cv=none; b=owjHic1SMNogx0TP0DT108rTCrd5f72MqucO/xgFBXjDatrND1dkDiZ6oe8E+xXow0RmS883rdHIip4IE0X4T3hwXuk6z+11qxe+O0z8GkIH30l8wj/OdkHBRC8ESn2Tf35ggovbbf3jyzjghiu4XtF1SLuqsDS4gj7Ru842v8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772589; c=relaxed/simple;
	bh=iXDSENzuCzYM8NWg9kgThbDP2nj0ZqpJsVwn8iRcgVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3LgeTQSnrIrJmW/GSZ0KvobYnqwlZuIMY4QC+hT6K1rkB0RUfMLETQd0P9MBCKNFrpckKfiz8rPXAWbAM76/F4x0wM7SKSxiWlvrr8nPSSqvn97iKUwAYn+XIVayYCGQalrtB+UvlQdMHS5eDS8cWA/6YVxaeGejDOGBRX/CpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98797176A;
	Fri, 28 Feb 2025 11:56:42 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD4833F5A1;
	Fri, 28 Feb 2025 11:56:21 -0800 (PST)
Message-ID: <f73883af-64ed-4a89-a417-20b7b823a70d@arm.com>
Date: Fri, 28 Feb 2025 19:56:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/42] x86/resctrl: Move RFTYPE flags to be managed by
 resctrl
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-28-james.morse@arm.com>
 <5424ecd1-6a6b-4ed9-87cb-845036c23fb8@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <5424ecd1-6a6b-4ed9-87cb-845036c23fb8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 01:17, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> resctrl_file_fflags_init() is called from the architecture specific code
>> to make the 'thread_throttle_mode' file visible. The architecture specific
>> code has already set the membw.throttle_mode in the rdt_resource.
>>
>> This forces the RFTYPE flags used by resctrl to be exposed to the
>> architecture specific code.
>>
>> This doesn't need to be specific to the architecture, the throttle_mode
>> can be used by resctrl to determine if the 'thread_throttle_mode' file
>> should be visible. This allows the RFTYPE flags to be private to resctrl.
>>
>> Add thread_throttle_mode_init(), and use it to call
>> resctrl_file_fflags_init()  from resctrl_setup(). This avoids
> 
> "  from resctrl_setup()" -> " from resctrl_init()" ?

Ugh, thanks!


>> publishing an extra function between the architecture and filesystem
>> code.

> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James

