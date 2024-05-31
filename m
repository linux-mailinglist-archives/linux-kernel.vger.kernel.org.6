Return-Path: <linux-kernel+bounces-196177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A18D587D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F74F1F26247
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDF174E3D;
	Fri, 31 May 2024 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dthSPucG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813F6BFCA
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717121084; cv=none; b=WAgOn/NYYsfVJ3tn3kc5Gs7eIiIwHQPG3QmuuHyX/sl6wTXr3klgEp+M/P/UhaCYXhGfE5naSX650WEbxiaDWViBhoJf9BAq2VzjwIQKKeA2k05n+vrN+ZMwMGDF8zQ7mWR6KnMWb93FL71D+piMcQacyABuSmaGXEJsP5OFexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717121084; c=relaxed/simple;
	bh=xiHCzmsgzj4m4XKxXeex3wTFqjckwvLq3FtWszdZ62Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtGm7SgPZUDkF0RbiE6cTYveBoxNreeOCiXn+gkukZ/pBb3tlFp/IEasshIq3HgokVLuShNyib+h7agCTvTFN/XrHxaqQIQ8gbIJhDf8cAjUin4v+bkUD/IwKCsDe4Cq677K7KRbfqcosgNWOmN+eXdh72vSdTPojVQUI+c4TL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dthSPucG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA47C2BBFC;
	Fri, 31 May 2024 02:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717121083;
	bh=xiHCzmsgzj4m4XKxXeex3wTFqjckwvLq3FtWszdZ62Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dthSPucGRUGL+6aw3Cr9cas3+DxkbhNyIyN1/PH7mmiV73/90OJCM8/nxI+/tnvxw
	 Y7KARKaNKWujrvoiX3d0RRZ1nY9I3oZoYBNVMVkbNiMoEB6P2xCESQ/QixPp8VUS/1
	 2osBAfjnU93cvJlFi6EupaA2yAK2aVC1R1mzvL+n4ZG3K9XhWiqENwehdEgJi2jN9p
	 QRCp/uG7q3tq2qOpneBkwdFNgYiITg+oq2hN5C5FHCOdXPxfm3kGjjWFnQv/ezxL3X
	 IvIjBG1lZYMBH5Yjv9LojBqBMCTUzzBD6Rg3OHaF5FWgoS7A4Cs2aBknhqLG0V2ske
	 g9vcTww1K2bKg==
Message-ID: <0a4b5b40-1532-44a4-a4d6-601ceced20a4@kernel.org>
Date: Fri, 31 May 2024 10:04:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
 <1d67715b-5f88-4940-969d-e098fd80ae2a@kernel.org>
 <CAHJ8P3LXYWQ+bLZHPn_5FLu3oi83ei8C9ZCzAXwa9oBdEKVDNA@mail.gmail.com>
 <CAHJ8P3+ro9YsU7jZWeAfiUh9uNFEj_=Wiaf2YRLVLBD5_9fM0g@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3+ro9YsU7jZWeAfiUh9uNFEj_=Wiaf2YRLVLBD5_9fM0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/5/30 17:49, Zhiguo Niu wrote:
> On Mon, May 27, 2024 at 12:07 PM Zhiguo Niu <niuzhiguo84@gmail.com> wrote:
>>
>> On Mon, May 27, 2024 at 11:49 AM Chao Yu <chao@kernel.org> wrote:
>>>
>>> On 2024/5/20 19:36, Zhiguo Niu wrote:
>>>> Now atgc can be enabled based on the following conditions:
>>>> -ATGC mount option is set
>>>> -elapsed_time is more than atgc_age_threshold already
>>>> but these conditions are check when umounted->mounted device again.
>>>> If the device has not be umounted->mounted for a long time, atgc can
>>>> not work even the above conditions met.
>>>
>>> Zhiguo, I didn't get it, can you please explain more about this issue?
>>>
>>> Thanks,
>> Hi Chao,
>>
>> At present, the point of atgc enale is checked during the mount
>> process. What I mean is that if a device has not been rebooted
>> (re-mounted) for a long time, even if the above two conditions are
>> met(ATGC mount option is set, and the device has been powered on long
>> enough， more than atgc default threshold ), atgc cannot be dynamically
>> enabled.
>>
>> If the user is used to not restarting the phone after turning it on,
>> it will be difficult to use atgc.
>> thanks!
> Hi Chao,
> Do you have any suggestions or comments on this?

Zhiguo,

I remember that atgc can not be enabled at runtime due to some reasons, but
I need some time to recall and check the details...

Thanks,

> thanks！
> 
>>>
>>>>
>>>> It is better to enable atgc dynamiclly when user change atgc_age_threshold
>>>> meanwhile this vale is less than elapsed_time and ATGC mount option is on.
>>>>
>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>> ---
>>>>    fs/f2fs/f2fs.h    |  1 +
>>>>    fs/f2fs/segment.c |  9 ++++-----
>>>>    fs/f2fs/sysfs.c   | 16 ++++++++++++++++
>>>>    3 files changed, 21 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 1974b6a..e441d2d 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
>>>>    void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
>>>>    void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
>>>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
>>>>    int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>>>                                        unsigned int start, unsigned int end);
>>>>    int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 71dc8042..44923d4 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
>>>>        return ret;
>>>>    }
>>>>
>>>> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>>>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>>>>    {
>>>>        struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
>>>>        int ret = 0;
>>>>
>>>> -     if (!sbi->am.atgc_enabled)
>>>> -             return 0;
>>>> -
>>>>        f2fs_down_read(&SM_I(sbi)->curseg_lock);
>>>>
>>>>        mutex_lock(&curseg->curseg_mutex);
>>>> @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>>>>    }
>>>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
>>>>    {
>>>> -     return __f2fs_init_atgc_curseg(sbi);
>>>> +     if (!sbi->am.atgc_enabled)
>>>> +             return 0;
>>>> +     return f2fs_init_atgc_curseg(sbi);
>>>>    }
>>>>
>>>>    static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>>> index 09d3ecf..72676c5 100644
>>>> --- a/fs/f2fs/sysfs.c
>>>> +++ b/fs/f2fs/sysfs.c
>>>> @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>>>                return count;
>>>>        }
>>>>
>>>> +     if (!strcmp(a->attr.name, "atgc_age_threshold")) {
>>>> +             if (t < 0)
>>>> +                     return -EINVAL;
>>>> +             sbi->am.age_threshold = t;
>>>> +             if (sbi->am.atgc_enabled)
>>>> +                     return count;
>>>> +
>>>> +             if (test_opt(sbi, ATGC) &&
>>>> +                     le64_to_cpu(sbi->ckpt->elapsed_time) >= t) {
>>>> +                     if (f2fs_init_atgc_curseg(sbi))
>>>> +                             return -EINVAL;
>>>> +                     sbi->am.atgc_enabled = true;
>>>> +             }
>>>> +             return count;
>>>> +     }
>>>> +
>>>>        if (!strcmp(a->attr.name, "gc_segment_mode")) {
>>>>                if (t < MAX_GC_MODE)
>>>>                        sbi->gc_segment_mode = t;

