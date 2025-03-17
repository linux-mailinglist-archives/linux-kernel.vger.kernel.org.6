Return-Path: <linux-kernel+bounces-563444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB5FA641EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B07A3319
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC2E219A94;
	Mon, 17 Mar 2025 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNE9lSrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE1A1B0401
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193742; cv=none; b=dy+jqP94hxW1AWpHkxc9ABjvv2JgT+NvisOWv+ZpeOgwaoQUO8vgOzlnr8Qg4WdHE89fM3jp4gpY6VylfsA4zE3ySjAd0pI+9IhOvt9fGvfL6h/QiGScsKVqKZkuJ+YiH7+atT0MC8WtiwnHmH+A9SoynWlGjI8AvZb6CW+0Q3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193742; c=relaxed/simple;
	bh=FuS8Av9mTTAznTxqWO7qBNNd49jKIqF6PQ5eAuT/Yv8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aGMCscd8eRgwhbXRKfuAAVeeHP091Ry6RCsGhfmCPEJKVfDco3rAzQZBiBXTKPAdZzROortz4gyF37w6mVBgBYsEb1aL+mUHKDxgpfNz4eEVBXt8JKdO/UPCNOpKxI050uC6HP1BKX3BY0FW9k7HH0biuIjsJyZnIoowfOrZ2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNE9lSrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C464C4CEE3;
	Mon, 17 Mar 2025 06:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742193742;
	bh=FuS8Av9mTTAznTxqWO7qBNNd49jKIqF6PQ5eAuT/Yv8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oNE9lSrJI67ImxHG55W0LD2RLYScUWXTrqRCcKIXq6kQqwFfGG7g1+zDQ4xVc+tXn
	 fB/E+fw2RZuoZgaxMIbSKARV+7hLdK4uTnpujfNQtiykpE7AbJo0KG+Wj6/5CXBxPc
	 mZscr9XXyDM+Du5DSnM7aI5B0jgEZAJxE0EcjkuXlnWIP9gKtTc4siw+Mvh9KMYbFw
	 03OwP1+YmrtPI4U3oC5jmGAPZllBJdaSWUJ7nMifFDS4WIoyEN2+8u+Q9iixdJLUUO
	 IZVqfmILNXmJxK6p9M6q4SqVZO6bvFAirmgW2e6HlfPMzchWG0X5krY4DSYncgr94J
	 rndBIs/7EXyrQ==
Message-ID: <1dd3b2a6-5431-4a2a-bccb-2a3672f5d1bd@kernel.org>
Date: Mon, 17 Mar 2025 14:42:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
 <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
 <04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org>
 <18767765-53b5-4e78-b50d-9305fe1cb2d0@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <18767765-53b5-4e78-b50d-9305fe1cb2d0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/17/25 14:15, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/3/17 14:03, Chao Yu wrote:
>> On 3/17/25 01:17, Gao Xiang wrote:
>>> Hi Chao,
>>>
> 
> ...
> 
>>>
>>> Previously, it was useful before Z_EROFS_LCLUSTER_TYPE_HEAD2 was
>>> introduced, but the `default:` case is already deadcode now.
>>
>> Xiang, thanks for the explanation.
>>
>> So seems it can happen when mounting last image w/ old kernel which can not
>> support newly introduced Z_EROFS_LCLUSTER_TYPE_* type, then it makes sense to
>> return EOPNOTSUPP.
> 
> Yeah.
> 
>>
>>>
>>>>
>>>> Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
>>>> then we can treat m->type as reliable variable later.
>>>>
>>>>       advise = le16_to_cpu(di->di_advise);
>>>>       m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>>>>       if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>>
>>> It's always false here.
>>
>> So, what do you think of this?
>>
>>  From af584b2eacd468f145e9ee31ccdeedb7355d5afd Mon Sep 17 00:00:00 2001
>> From: Chao Yu <chao@kernel.org>
>> Date: Mon, 17 Mar 2025 13:57:55 +0800
>> Subject: [PATCH] erofs: remove dead codes for cleanup
>>
>> z_erofs_extent_lookback() and z_erofs_get_extent_decompressedlen() tries
>> to do sanity check on m->type, however their caller z_erofs_map_blocks_fo()
>> has already checked that, so let's remove those dead codes.
> 
> z_erofs_extent_lookback() will (lookback) read new lcn in
> z_erofs_load_lcluster_from_disk() so it won't be covered by
> the original z_erofs_map_blocks_fo().

Xiang,

Oh, I see, changed here:

- z_erofs_extent_lookback
 - z_erofs_load_lcluster_from_disk
  - z_erofs_load_full_lcluster
  : m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
 - z_erofs_load_compact_lcluster
 : m->type = type;

> 
> I think this check can be resolved in
> z_erofs_load_lcluster_from_disk() instead but maybe address
> for the next cycle? since there are already enough features
> for this cycle and I have to make sure no major issues....

Yeah, it's fine to check the cleanup later, let's keep focusing
on improving patches in dev now.

Thanks,

> 
> Thanks,
> Gao Xiang
> 


