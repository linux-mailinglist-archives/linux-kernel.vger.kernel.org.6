Return-Path: <linux-kernel+bounces-377595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C729AC108
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B2A1F21517
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CEA156F3F;
	Wed, 23 Oct 2024 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf2bOZz8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27113B5B3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670821; cv=none; b=lzchGs6tc5keL04AuQYL2hz7lmb1KHqITVBzoVbfXyywDcOUf34oc98djsw918uH4wrqmxWK5TbWIt3TpIcAnIXtGvK+XXh6OdwhWpaoeH0TwQWAEfOt2hWsxJZ3UfU6iCSlaDdV1V7BBle+uHmQxxCgusRvXAtDxMvYXu7laSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670821; c=relaxed/simple;
	bh=BrPGJSsFR50m0x0nz9fvVLzKZkp6YxV1ErfJzYmZ32s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qaCA8mi1uvbSf2bs8JYb2SZ7AM28KIve5R221jiG3acQwOI2o03psVu0ydihZ10fCjDMjonbxYsnhaBwMy0h68ViAtVudQWnr2RLQAV/mnszXo5pryohXXbdwNq4nY1o5ir9xIE4S4L1UXjnFXdw0ljcl/NK/5p/EWf2BoWdKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf2bOZz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4021EC4CEC6;
	Wed, 23 Oct 2024 08:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729670820;
	bh=BrPGJSsFR50m0x0nz9fvVLzKZkp6YxV1ErfJzYmZ32s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Bf2bOZz8gcBBmuaYLP5SenDfzWYS+PXK540NcmOit7X+g/AwHLyB/nVXp6dkqDVT9
	 3H2x5Y2HGhhF6paAqBlWY2lkaeHgALajXGNdLGbl3U6tSs5l7MsDiVlJ6+2TypKXMN
	 njj2HaEhRLKsQAHkvVyI0wh3Chy/K5J5aaebaY3pps+DB5mWbQ6FoCJOgugDjroAsk
	 HHAp0OtcDTygmbFU3xVDCL5pYIE+EYCfgjrpNJ+nUHySNVyC2SEDaACoQTMfpeRcFf
	 MsmVu8h+eqAK5FhsEbzs2aYtriWl+3ydsxy5uBzwAKdSypSzI9muEna7Kwr0iULI14
	 chRyPSRqFIU6g==
Message-ID: <12559def-2ca2-4e4d-851c-6ae906b6a2d7@kernel.org>
Date: Wed, 23 Oct 2024 16:06:56 +0800
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: Re: [PATCH v3] f2fs: modify f2fs_is_checkpoint_ready logic to allow
 more data to be written with the CP disable
To: =?UTF-8?B?6Z+p5qOL?= <hanqi@vivo.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <20241023025945.1817457-1-hanqi@vivo.com>
 <9825b1c1-9d24-48d1-a807-d1e6e25c4157@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <9825b1c1-9d24-48d1-a807-d1e6e25c4157@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/23 15:40, 韩棋 wrote:
> 在 2024/10/23 10:59, Qi Han 写道:
>> When the free segment is used up during CP disable, many write or
>> ioctl operations will get ENOSPC error codes, even if there are
>> still many blocks available. We can reproduce it in the following
>> steps:
>>
>> dd if=/dev/zero of=f2fs.img bs=1M count=65
>> mkfs.f2fs -f f2fs.img
>> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
>> cd f2fs_dir
>> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; dd \
>> if=/dev/random of=$file_name bs=1M count=2); i=$((i+1)); done
>> sync
>> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; truncate \
>> -s 1K $file_name); i=$((i+1)); done
>> sync
>> dd if=/dev/zero of=./file bs=1M count=20
>>
>> In f2fs_need_SSR() function, it is allowed to use SSR to allocate
>> blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
>> can we judge the number of invalid blocks when free segment is not
>> enough, and return ENOSPC only if the number of invalid blocks is
>> also not enough?
>>
>> Signed-off-by: Qi Han <hanqi@vivo.com>
>> ---
>>    fs/f2fs/segment.h | 17 +++++++++++++++++
>>    1 file changed, 17 insertions(+)
>>
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 71adb4a43bec..20b568eaa95e 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -637,12 +637,29 @@ static inline bool has_enough_free_secs(struct f2fs_sb_info *sbi,
>>    	return !has_not_enough_free_secs(sbi, freed, needed);
>>    }
>>    
>> +static inline bool has_enough_free_blks(struct f2fs_sb_info *sbi)
>> +{
>> +	unsigned int total_free_blocks = 0;
>> +	unsigned int avail_user_block_count;



>> +
>> +	spin_lock(&sbi->stat_lock);
>> +
>> +	avail_user_block_count = get_available_block_count(sbi, NULL, true);
>> +	total_free_blocks = avail_user_block_count - (unsigned int)valid_user_blocks(sbi);
>> +
>> +	spin_unlock(&sbi->stat_lock);
>> +
>> +	return total_free_blocks > 0;
>> +}
>> +
>>    static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
>>    {
>>    	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>>    		return true;
>>    	if (likely(has_enough_free_secs(sbi, 0, 0)))
>>    		return true;
> 
> Hi, Chao,
> 
> After Zhiguo's reminder, I just saw your previous patch:
> f2fs: fix to account dirty data in __get_secs_required(),
> the current modification may still return true if the segment
> is found to be insufficient when LFS and CP is closed, should
> I add the LFS mode restriction here?

Hi Qi,

I guess so, I think we need to add a lfs_mode check condition in
has_enough_free_blks(), otherwise this patch will trigger system
panic w/ below testcase:

https://lore.kernel.org/fstests/20241015025106.3203676-1-chao@kernel.org/

Thanks,

> 
> Thanks.
> 
>> +	if (likely(has_enough_free_blks(sbi)))
>> +		return true;
>>    	return false;
>>    }
>>    
> 


