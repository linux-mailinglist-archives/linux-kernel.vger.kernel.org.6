Return-Path: <linux-kernel+bounces-337910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F0F9850F5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEF61F22C92
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC29C1487DC;
	Wed, 25 Sep 2024 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTQZP6+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3E148301
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727231453; cv=none; b=o/6jubC6IoZEKGtNB5E5p6BzhXGpnGs/d483Xfe0ZPoaL6tpLTuS/Fni8pJgXAw8Eqqh5mL45Rc7/dv01IzxlgRXjgV/iM45EvdC7G7icjf/BbmYt8tsCIj3bJXFbfkoEQWNKd7S+as+s03xMO/MShgdfLZs2wSEyIa/dirpLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727231453; c=relaxed/simple;
	bh=X1iP4x+Vd/7mY8fUwi7Ju0cN4C2hV31GJfoI2x8Ueos=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tySj86V04R2lXR1+eI+8nq6PXFe7ss/bg0MicGF4hud4kVcgTkAT1nq7guOzpEqfOmOXb3PGmXnGYSBZGcd4QBHYQwFrbreWOf6UqkarNfSxWS2EObYObxVQVXmkHCLkICw2TwsMQEgy5c/2C0kzsq2il5Nz5ZPYuKjegD9xXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTQZP6+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F49C4CEC4;
	Wed, 25 Sep 2024 02:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727231452;
	bh=X1iP4x+Vd/7mY8fUwi7Ju0cN4C2hV31GJfoI2x8Ueos=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=eTQZP6+eefXLaTV7lu3GJx+7buCMp0j4i04nVqImCNM6x1f9rkBaVrPosbFa5zdu1
	 pE1BoUDzwTrSqsCy9Z1exgm8EOKPHjCo2t6EOb/pjDDpgwyXgDkujdLNASw/lDpAW0
	 i8AA7JNyhpB2d8Y9KAH0fiHXDEfZ5LK1r5n/wIhDrnHYczhxrsqyuuv189yQ9Ax2V+
	 KqBWip5+xiuOh3rdokj/U8YNC5mUr8lh93sYo9YbsAnk72RcIIiAdur8NHMDiJ3yIq
	 VltlBgiyyt1PCInqggM75tj0T1kparssYQZmYQssVQcC+vtCy1zAlC0OqQjFvbNluS
	 dc6H+ulEqY9Jw==
Message-ID: <381e24e1-a41b-487d-a894-a3aae19d9a5a@kernel.org>
Date: Wed, 25 Sep 2024 10:30:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: device alias: add sanity check for
 device alias inode
To: Daeho Jeong <daeho43@gmail.com>
References: <20240924023007.2471817-1-chao@kernel.org>
 <CACOAw_y_csdZmj26C8bXNVxRirq2XBYpiFXN2EnJTTdPr6BmAQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_y_csdZmj26C8bXNVxRirq2XBYpiFXN2EnJTTdPr6BmAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/25 4:38, Daeho Jeong wrote:
> On Mon, Sep 23, 2024 at 7:32 PM Chao Yu via Linux-f2fs-devel
> <linux-f2fs-devel@lists.sourceforge.net> wrote:
>>
>> Do sanity check for extent info of device alias inode, in order to
>> avoid unexpected error caused by fuzz test.
>>
>> Cc: Daeho Jeong <daehojeong@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>
>> To Daeho and Jaegeuk,
>>
>> Merge this into initial patch or merge it separately is both fine
>> to me.
> 
> I am going to merge this into my one. Thanks~!
> 
>>
>>   fs/f2fs/extent_cache.c | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>> index 0c8a705faa8b..5bf9e4c2b49c 100644
>> --- a/fs/f2fs/extent_cache.c
>> +++ b/fs/f2fs/extent_cache.c
>> @@ -24,6 +24,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
>>          struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>          struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
>>          struct extent_info ei;
>> +       int devi;
>>
>>          get_read_extent_info(&ei, i_ext);
>>
>> @@ -38,7 +39,36 @@ bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
>>                            ei.blk, ei.fofs, ei.len);
>>                  return false;
>>          }
>> -       return true;
>> +
>> +       if (!IS_DEVICE_ALIASING(inode))
>> +               return true;
>> +
>> +       for (devi = 0; devi < sbi->s_ndevs; devi++) {
>> +               if (FDEV(devi).start_blk != ei.blk ||
>> +                       FDEV(devi).end_blk != ei.blk + ei.len)
> 
> ei.blk + ei.len -> ei.blk + ei.len - 1?

Yes, thanks for the correcting.

Thanks,

> 
>> +                       continue;
>> +
>> +               if (devi == 0) {
>> +                       f2fs_warn(sbi,
>> +                               "%s: inode (ino=%lx) is an alias of meta device",
>> +                               __func__, inode->i_ino);
>> +                       return false;
>> +               }
>> +
>> +               if (bdev_is_zoned(FDEV(devi).bdev)) {
>> +                       f2fs_warn(sbi,
>> +                               "%s: device alias inode (ino=%lx)'s extent info "
>> +                               "[%u, %u, %u] maps to zoned block device",
>> +                               __func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
>> +                       return false;
>> +               }
>> +               return true;
>> +       }
>> +
>> +       f2fs_warn(sbi, "%s: device alias inode (ino=%lx)'s extent info "
>> +                       "[%u, %u, %u] is inconsistent w/ any devices",
>> +                       __func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
>> +       return false;
>>   }
>>
>>   static void __set_extent_info(struct extent_info *ei,
>> --
>> 2.40.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


