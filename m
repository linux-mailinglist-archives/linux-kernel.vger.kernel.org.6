Return-Path: <linux-kernel+bounces-240812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69092731C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9822822EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F21AB902;
	Thu,  4 Jul 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK5kdrdb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13613B29D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085550; cv=none; b=Rq3rDcv3NHvx4JB1C7Wr5xGGMzYwsJH/xDIprckP67J/dng8CfqGpwlWFIfQ/EYBFDmS6EhRAxyA7M7vP52TTWnlJt7Fh6PwuRx3QseEn8+/fvstwL9cDjbJqwGy8WseSs7LpNLaPMlYWFAd9FTJNcOur33rd9Aa169GLKY2JDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085550; c=relaxed/simple;
	bh=/UU6dlcInhejLosomtZUum1OVKmIQu5j7w157Dwp7As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqiVjnc6tEqv7e6ZxyGZMmxhvxqtslSzE20KsNj5sQuCFSXBYjws8i+ybzqVmIn+arJbeSgF9Lj6U2uetPa92i04kScRV/hqgro0nLAUbE0SSz9+99Tki8eYXcmRTp5fS4br40C0H+Qi4Cj/yY3f4kNPsws28jpt3tJXPouWZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK5kdrdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BEEC4AF0D;
	Thu,  4 Jul 2024 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720085550;
	bh=/UU6dlcInhejLosomtZUum1OVKmIQu5j7w157Dwp7As=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BK5kdrdbNdTvEC7iAaYKdBelQ26rM8ln0nP1Beo6FBfcBBlUkQzyplzsA/kCs234z
	 RclB0PwQecPq0a9dM7XO/T4YpogaujgDKJZ+SdGnvb6L69fTd0/LVTgjum/T8jQf4b
	 6vKeF+OaBZ5ivLzqGghecpxgjHdL/ozvFaZrcMDb8sN+QLT3eBytlvI4ySxfovx29p
	 fEgTiPSo0YlI7ellIUlzpJC7JcfIBCkdqYwls6iBzJPZ/I1SdY52ChA07vYsTpWdz1
	 CbfZoCnrFKby6N6Q2cbZXMhJYjZ+nFbyA+dKK6gtsPrYSW4ufsOYAZcflZLqkmEdLM
	 dVuRoB3E10jCA==
Message-ID: <5c312ebb-a202-45e5-a82b-7b7c3f080d67@kernel.org>
Date: Thu, 4 Jul 2024 17:32:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (2) [PATCH] f2fs: fix null reference error when checking end of
 zone
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Seokhwan Kim <sukka.kim@samsung.com>,
 Dongjin Kim <dongjin_.kim@samsung.com>,
 Yonggil Song <yonggil.song@samsung.com>,
 Jaeyoon Choi <j_yoon.choi@samsung.com>, Nayeon Kim
 <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
References: <460c4708-3ec6-4fbc-8f6c-7f8e5f901061@kernel.org>
 <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
 <CGME20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
 <20240704075521epcms2p49cc9985b6624e4e1129907e883fbc1d9@epcms2p4>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240704075521epcms2p49cc9985b6624e4e1129907e883fbc1d9@epcms2p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/4 15:55, Daejun Park wrote:
> Hi Chao Yu,
>>   
>> --------- Original Message ---------
>> Sender : Chao Yu <chao@kernel.org>
>> Date : 2024-07-04 16:16 (GMT+9)
>> Title : Re: [PATCH] f2fs: fix null reference error when checking end of zone
>>   
>> On 2024/7/4 9:01, Daejun Park wrote:
>>> This patch fixes a potentially null pointer being accessed by
>>> is_end_zone_blkaddr() that checks the last block of a zone
>>> when f2fs is mounted as a single device.
>>
>> blkzoned feature depends on multiple device feature? One regular
>> device and one seq-zone device?
> 
> According to mkfs.f2fs, if there are a sufficient number of
> conventional zones, a single zoned device can be used.

Correct.

Anyway, the code looks clean.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Daejun
> 
>>
>> Thanks,
>>
>>>
>>> Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
>>> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
>>> ---
>>>    fs/f2fs/data.c 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index b6dcb3bcaef7..1aa7eefa659c 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -925,6 +925,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>>>    #ifdef CONFIG_BLK_DEV_ZONED
>>>    static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
>>>    {
>>> +        struct block_device *bdev = sbi->sb->s_bdev;
>>>             int devi = 0;
>>>   
>>>             if (f2fs_is_multi_device(sbi)) {
>>> @@ -935,8 +936,9 @@ static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
>>>                             return false;
>>>                     }
>>>                     blkaddr -= FDEV(devi).start_blk;
>>> +                bdev = FDEV(devi).bdev;
>>>             }
>>> -        return bdev_is_zoned(FDEV(devi).bdev) &&
>>> +        return bdev_is_zoned(bdev) &&
>>>                     f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
>>>                     (blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
>>>    }

