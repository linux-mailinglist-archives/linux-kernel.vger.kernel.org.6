Return-Path: <linux-kernel+bounces-375546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA03A9A972C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56014B213D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506213A416;
	Tue, 22 Oct 2024 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOuXkH+2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C413957B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568358; cv=none; b=HwtWaKGYEiUXNHwCNKLU5xowa1xbhZqcqXIMFrupYyEchM++O5Cx9JSwcmmqOe26nVJDLtPMWtknSpY66YEI5nv+OEy5BaY6NzH8uVbPQ6gJhec0qhapc6iPUfr0aSZ0ToqnC21e37euD4ZeZD/Tc+Prbt1ChVuWWN1U/tRj+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568358; c=relaxed/simple;
	bh=twcUz9QMvzx653qiRwcIDwO6wbHQwi/ZtZTaDK0o7Wk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NL3ec/Z4m+njNruY8EkgpT+CovblrQXjPMfs8jT/mUKMEhVap9exGPrRQYzRZhnB4HC8faqaW761gHeJqqYzytyifb25GDhf3apMYuhzgD5e882u95q6lkRkCsGGUn+MG09a7WsHItCGKmexM4JkgNMxify4HEHaFwBD3wyUgvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOuXkH+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E60C4CEC3;
	Tue, 22 Oct 2024 03:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729568358;
	bh=twcUz9QMvzx653qiRwcIDwO6wbHQwi/ZtZTaDK0o7Wk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YOuXkH+2610ZQJxUDwsiWwuSgAKYRREp1l1xzh1il6VSixDlOCX00zy8uWKlSSg94
	 ym+oBv6kg+O8j7suxj3MJbU0BlABNVsrF66M2tjDRCBrpkZ6NlNYcCAE5uq9gZftUl
	 WgT5ipM++RxShCjbNwi3LrtVdWVoqe24hvnx0SD7eROsXINinXU1F3ifguurKryZTe
	 KWZg7w5ywS5Fyz29YFD/MTob6iCPqK8W5MyABcDm7zmZFuHFXVKDOs0jz+gOaCwDsF
	 sSO/O5l5DZq8I4xn7Sir48bOA8AiTPAObE14f7X/g3YlR1xdUmA0d0lBdoVbfSt8Oa
	 IIgeB23wDDe+w==
Message-ID: <febd8e72-acf6-4f33-9a49-4f09f4b5a25a@kernel.org>
Date: Tue, 22 Oct 2024 11:39:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] f2fs: modify f2fs_is_checkpoint_ready logic to allow more
 data to be written with the CP disable
To: =?UTF-8?B?6Z+p5qOL?= <hanqi@vivo.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <20241009102745.1390935-1-hanqi@vivo.com>
 <3fdd8fdd-8b80-4989-8cfd-78051bd85936@kernel.org>
 <7450a770-22cf-45e4-bc92-1812d1295eec@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <7450a770-22cf-45e4-bc92-1812d1295eec@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/22 11:14, 韩棋 wrote:
> 在 2024/10/22 10:53, Chao Yu 写道:
>> On 2024/10/9 18:27, Qi Han wrote:
>>> When the free segment is used up during CP disable, many write or
>>> ioctl operations will get ENOSPC error codes, even if there are
>>> still many blocks available. We can reproduce it in the following
>>> steps:
>>>
>>> dd if=/dev/zero of=f2fs.img bs=1M count=55
>>> mkfs.f2fs -f f2fs.img
>>> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
>>> cd f2fs_dir
>>> dd if=/dev/zero of=bigfile bs=1M count=50
>>> sync
>>> rm bigfile
>>> i=1; while [[ $i -lt 10000000 ]]; do (file_name=./file$i; dd \
>>> if=/dev/random of=$file_name bs=1M count=0); i=$((i+1)); done
>>> stat -f ./
>>>
>>> In f2fs_need_SSR() function, it is allowed to use SSR to allocate
>>> blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
>>> can we judge the number of invalid blocks when free segment is not
>>> enough, and return ENOSPC only if the number of invalid blocks is
>>> also not enough?
>>>
>>> Signed-off-by: Qi Han <hanqi@vivo.com>
>>> ---
>>>    fs/f2fs/segment.h | 21 +++++++++++++++++++++
>>>    1 file changed, 21 insertions(+)
>>>
>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>> index 71adb4a43bec..9bf0cf3a6a31 100644
>>> --- a/fs/f2fs/segment.h
>>> +++ b/fs/f2fs/segment.h
>>> @@ -637,12 +637,33 @@ static inline bool has_enough_free_secs(struct
>>> f2fs_sb_info *sbi,
>>>        return !has_not_enough_free_secs(sbi, freed, needed);
>>>    }
>>>    +static inline bool has_enough_available_blocks(struct f2fs_sb_info
>>> *sbi)
>>> +{
>>> +    unsigned int total_free_blocks = sbi->user_block_count -
>>> +                    valid_user_blocks(sbi) -
>>> +                    sbi->current_reserved_blocks;
>>> +
>>> +    if (total_free_blocks <= sbi->unusable_block_count)
>>> +        total_free_blocks = 0;
>>> +    else
>>> +        total_free_blocks -= sbi->unusable_block_count;
>>> +
>>> +    if (total_free_blocks > F2FS_OPTION(sbi).root_reserved_blocks)
>>> +        total_free_blocks -= F2FS_OPTION(sbi).root_reserved_blocks;
>>> +    else
>>> +        total_free_blocks = 0;
>>> +
>>> +    return (total_free_blocks > 0) ? true : false;
>>
>> Can you please reuse get_available_block_count() as much as possible?
>> and cover it w/ stat_lock?
>>
>> Thanks,
> 
> Thank you for your suggestion. I will send the v2 version patch later.

BTW, it looks your testcase won't create sparse available space in
segment for following reuse by SSR, can you please update your
testcase?

Thanks,

> 
>>
>>> +}
>>> +
>>>    static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
>>>    {
>>>        if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>>>            return true;
>>>        if (likely(has_enough_free_secs(sbi, 0, 0)))
>>>            return true;
>>> +    if (likely(has_enough_available_blocks(sbi)))
>>> +        return true;
>>>        return false;
>>>    }
>>
>>
> 


