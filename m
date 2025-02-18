Return-Path: <linux-kernel+bounces-518700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E5A3936F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79CB3A5DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4626D1AF0B7;
	Tue, 18 Feb 2025 06:32:20 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6BB749C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739860339; cv=none; b=iEkctIuY5Qfm5qVgFPBl7suRofrYsgHgCJWs9nlAotE4P1HRXMqIEoBnSu0SllhHXCglnPzgZ1CmJAy8vvwFJadosQxwt9D/pv6ybO/B+VA1oNpHh/v/PeYjk48LewiYdDj12Y99Uoeh9UBZNPKAO4xRwU7R0WCpB6KrpqguE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739860339; c=relaxed/simple;
	bh=WT7w8bFwZhB+KgEXOB3NJAN9/Qu6niA3TAHTM9bdoDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OvFfhWYS+rept3Gw/EDmA2YYmgMdLRpVfDHqejiFVNc0U66KnVHWmjG8YqlaF44RVeliNRJXYMKww1HnotU1TW8PYNuSguF+fAY8eajPx7YKov1afkpKTcbPOrH27xMDjahQQHb1dLuTG8pF98zN9QdSSYMAfqjlQUcDOmxtSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YxqT72Cwtzpk55;
	Tue, 18 Feb 2025 14:32:43 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id AFE741400DD;
	Tue, 18 Feb 2025 14:32:12 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 14:32:11 +0800
Message-ID: <f1be34f0-fed8-0256-fbb3-a1cce42d786b@huawei.com>
Date: Tue, 18 Feb 2025 14:32:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mpam mpam/snapshot/v6.14-rc1 3/5] arm_mpam: Provide
 conversion method for new closid/rmid pairs
Content-Language: en-US
To: Dave Martin <Dave.Martin@arm.com>
CC: <james.morse@arm.com>, <bobo.shaobowang@huawei.com>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250217031852.2014939-1-zengheng4@huawei.com>
 <20250217031852.2014939-4-zengheng4@huawei.com>
 <d7069933-903e-9e1e-d7a4-5a6a9fa53064@huawei.com>
 <Z7M7R8uf4g2C68cO@e133380.arm.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Z7M7R8uf4g2C68cO@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi,

On 2025/2/17 21:36, Dave Martin wrote:
> Hi,
> 
> On Mon, Feb 17, 2025 at 02:18:44PM +0800, Zeng Heng wrote:
>> Hi Martin,
>>
>> On 2025/2/17 11:18, Zeng Heng wrote:
>>> The MPAM driver statically assigns all reqPARTIDs to respective intPARTIDs.
>>> For the new rmid allocation strategy, it will check if there is an
>>> available rmid of any reqPARTID which belongs to the input closid, not just
>>> the rmids belonging to the closid.
>>>
>>> For a mixture of MSCs system, for MSCs that do not support narrow-partid,
>>> we use the PARTIDs exceeding the number of closids as reqPARTIDs for
>>> expanding the monitoring groups.
>>>
>>> In order to keep the existing resctrl API interface, the rmid contains both
>>> req_idx and PMG information instead of PMG only under the MPAM driver. The
>>> req_idx represents the req_idx-th sub-monitoring group under the control
>>> group. The new rmid would be like:
>>>
>>>       rmid = (req_idx << shift | pmg).
>>>
>>
>> To consider future compatibility with dynamically allocated reqpartid,
>> should I refactor the rmid?
>>
>> Instead of defining rmid.req_idx, we could place the entire reqpartid
>> directly within rmid. In This way, the allocation of reqpartid will no
>> longer be constrained by the static allocation of closid, facilitating
>> future compatibility with dynamic allocation mechanisms.
>>
>> In this case, it needs to refactor the resctrl_arch_rmid_idx_encode()
>> and resctrl_arch_rmid_idx_decode(), and we can simplify
>> closid_rmid2reqpartid() to rmid2reqpartid().
>>
>> What are your thoughts on this idea? Thank you in advance for your
>> reply.
>>
>> Best regards,
>> Zeng Heng
> 
> Does this mean that the RMID must be expanded to cover all possible
> (reqPARTID, PMG) combinations?
> 
> A single reqPARTID cannot be allocated to two different resctrl control
> groups at the same time, even though a PMG value can be reused across
> multiple control groups -- so it sounds like your proposal would
> require changes in the resctrl core code as well as possibly requiring
> a larger rmid_ptrs table.
> 
> But I might have misunderstood what you are proposing here...
> 
> Can you illustrate with one or two examples?
> 

Yes, as you have written. It might be worth trying this approach:
rmid = (reqpartid, pmg).

But to avoid the reuse of rmid across multiple control groups, we will
check the incoming closid in resctrl_arch_rmid_idx_encode() to prevent
rmid from being reallocated by resctrl_find_free_rmid().

We don't need a larger rmid_ptrs table, nor do we need to modify the
existing resctrl common code by continuing with the current static
allocation method.

Below are the implementations of several key functions for reference:

~~~
u32 rmid2reqpartid(u32 rmid)
{
	u8 pmg_shift = fls(mpam_pmg_max);

	WARN_ON_ONCE(pmg_shift > 8);

	return rmid >> pmg_shift;
}

/*
  * If the closid and rmid do not match upon inspection,
  * immediately return an invalid idx value.
  */
u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
{
	u32 reqpartid = rmid2reqpartid(rmid);
	u32 intpartid = req2intpartid(reqpartid);

	if (cdp_enabled)
		intpartid >>= 1;

	if (closid != intpartid)
		return U32_MAX;

	return rmid;
}

void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
{
	u32 reqpartid = rmid2reqpartid(idx);
	u32 intpartid = req2intpartid(reqpartid);

	if (rmid)
		*rmid = idx;
	if (closid) {
		if (cdp_enabled)
			intpartid >>= 1;
		*closid = intpartid;
	}
}
~~~

Best regards,
Zeng Heng





