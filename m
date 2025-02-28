Return-Path: <linux-kernel+bounces-539301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2AFA4A312
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A891170068
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A2276026;
	Fri, 28 Feb 2025 19:50:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA95275617
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772244; cv=none; b=lz6+Gt9Ek9Gsxy104c6sZ0bUJI63hBZz1oJEE7OGmafrP/LDrfMyD6B5v9/vHQsgmlyifGyQvMzaS8o/TJfO/wOBi7oGJH7splAN2gkWRCPDzF8xXMiqaUBrGPV4lTtdzCVoS+4vtlgyibHO6HQCJ62FWqnRaiyEXoaiPky7Crc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772244; c=relaxed/simple;
	bh=40Yr6/t3hDOT9SinsHto/KxTGV4v/KXAu83vWwWetCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4X65qcbtza7ENzuBzUWlaCAaTQQkH9PPy1Dtzx5UCALYby5UnPdTEQIxLtQPjfOztQNd5CpVW6zDlw3fwI8ty7msB26h4yVxWCbxrjwarJOXf1P78m279J+1L6sHuE0cqwqEnaXcyfrY1ctAF4sxG1ugHdXqrQXTalDGcJaOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 644E9150C;
	Fri, 28 Feb 2025 11:50:56 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5ABF3F5A1;
	Fri, 28 Feb 2025 11:50:36 -0800 (PST)
Message-ID: <63bbb8d0-e4cb-424b-9693-b8159e5414a8@arm.com>
Date: Fri, 28 Feb 2025 19:50:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/42] x86/resctrl: Use schema type to determine how to
 parse schema values
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
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-5-james.morse@arm.com>
 <e47db1dc-72cc-434f-bd07-4f0a1ffc6d36@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <e47db1dc-72cc-434f-bd07-4f0a1ffc6d36@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 19/02/2025 21:52, Reinette Chatre wrote:
> On 2/7/25 10:17 AM, James Morse wrote:
>> Resctrl's architecture code gets to specify a function pointer that is
>> used when parsing schema entries. This is expected to be one of two
>> helpers from the filesystem code.
>>
>> Setting this function pointer allows the architecture code to change
>> the ABI resctrl presents to user-space, and forces resctrl to expose
>> these helpers.
>>
>> Instead, add a schema format enum to choose which schema parser to
>> use. This allows the helpers to be made static and the structs used
>> for passing arguments moved out of shared headers.

>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 496ddcaa4ecf..aed231a6d30c 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -192,6 +191,16 @@ enum resctrl_scope {
>>  	RESCTRL_L3_NODE,
>>  };
>>  
>> +/**
>> + * enum resctrl_schema_fmt - The format user-space provides for a schema.
>> + * @RESCTRL_SCHEMA_BITMAP:	The schema is a bitmap in hex.
>> + * @RESCTRL_SCHEMA_RANGE:	The schema is a decimal number,
> 
> Nit: Please let sentence end with a period.

... me and my fat fingers ...


>> + */
>> +enum resctrl_schema_fmt {
>> +	RESCTRL_SCHEMA_BITMAP,
>> +	RESCTRL_SCHEMA_RANGE,
>> +};
>> +
>>  /**
>>   * struct rdt_resource - attributes of a resctrl resource
>>   * @rid:		The index of the resource


> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks!

James

