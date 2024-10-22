Return-Path: <linux-kernel+bounces-375425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133EC9A95C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCA81C2165B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E9612D773;
	Tue, 22 Oct 2024 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0Jv4LiE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C71E51D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562340; cv=none; b=o//7Cbkk252M871i6ocmP3YrdSifRpQyp8/3TLvzdigJX4njUCjdiebg7nYCL6lsU/mZMIp8X+Fx0w8mOMntYd7cv4spVIfDeXL8dINYmN0F3rn6ZtFrY4B4A8L++na8vOpy6dR4ckJPiXYID51FvPW62ph1WVmxnshjF84KJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562340; c=relaxed/simple;
	bh=5JBcgBS0Caog8coGUL3oyDLpj9i7eIkov9z/5+mVrbs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CRPiS4UJBVwu7cgzo+twt8dMqhp9XXoZ31uyFLpyAo6VmkCv70fEGJ7N5WK3ELupYk/J00HJ4D07/29d6Qv3hb1EN7oTAxy07uvqbP3WCyq8E3M7Ue3HyXh8tQRUBjePkd8o3v1Z9X/rZs6qiZVNgRnZoovKQ5S3w1GnhOoVDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0Jv4LiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B31C4CEC3;
	Tue, 22 Oct 2024 01:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729562340;
	bh=5JBcgBS0Caog8coGUL3oyDLpj9i7eIkov9z/5+mVrbs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=s0Jv4LiEo4Yn41QmFQj5x5mFJ8GOiIlnTChDcBDxvEk0Lb+g6uA3pLDBmd+RqAbPE
	 UR5c47GJL8crC7ATtGo3xm/5P49M2YklXi0jwvwNTLo5yBO7BFOiyBfW8oT05miJhk
	 spYmv9DRvOMzvQP7s5KKmgO+Oag1oz9ztuvBHK3MwvlHtgHfwpNTMHwuOvkN73ItBn
	 TVoEqFL3HUaCSqkOc9VlRjXBDQl9maUp3axWgmEUFjFltCZnoxf4j0F2HQcL1j+r+J
	 4IYtrFj0BrGR8TWqfz7RaKsnFpE8wMwxhTSIiOsLoRs4dMjfv1KSb5C2Kfqo1ce4tL
	 +Cdo/Xoi9KWiQ==
Message-ID: <24535167-5f6f-48b9-a1c3-f59ec4af5944@kernel.org>
Date: Tue, 22 Oct 2024 09:58:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] f2fs: zone: allow IPU for regular file in regular
 block device
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241018062638.2619214-1-chao@kernel.org>
 <20241018062638.2619214-2-chao@kernel.org> <ZxbhUUuKx_zaWAx4@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZxbhUUuKx_zaWAx4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 7:18, Jaegeuk Kim wrote:
> On 10/18, Chao Yu wrote:
>> blkzoned feature enables lfs mode by default, for data updates from
>> regular file, it only allow to use OPU, this patch changes to allow
>> to use IPU if regular file's data block locates in regular block
>> device, if data block locates in zoned block device, it still uses
>> OPU.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/data.c | 12 ++++++++++--
>>   fs/f2fs/f2fs.h |  5 +++++
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 949b6bb957c7..c6d0e4aa12e3 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2648,8 +2648,16 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>>   		return false;
>>   	if (fio && is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>>   		return true;
>> -	if (f2fs_lfs_mode(sbi))
>> -		return true;
>> +	if (f2fs_lfs_mode(sbi)) {
>> +		/* no regular block device in mainarea */
>> +		if (!f2fs_blkzoned_has_regular_section(sbi))
>> +			return true;
>> +		/* blkaddr locates in sequential zone */
>> +		if (fio && __is_valid_data_blkaddr(fio->old_blkaddr) &&
>> +			GET_SEGNO(sbi, fio->old_blkaddr) >=
>> +					sbi->first_zoned_segno)
> 
> What if there's another regular device beyond zoned partition?

With above logic, it will trigger OPU if data locates in regular device
which is beyond zoned partition.

> I prefer to keep the entire area as lfs mode to simplify the performance.

Oh, what do you think of introducing another option mode=hybrid? so that
we can provide an option to allow LFS/IPU/SSR in regular device beside
we limit LFS mode in zoned device.

> Do we really need IPU on conventional partition? Why not asking to use
> file pinning, if someone needs IPU?

One concern is size of pinned file should be multiple of section, pined file
will cost too much space if section size is large. Another problem is flow of
third-party applications can not be controlled by us, so it's not possible
to execute pinfile & falloc after file creation.

Thanks,

> 
>> +			return true;
>> +	}
>>   	if (S_ISDIR(inode->i_mode))
>>   		return true;
>>   	if (IS_NOQUOTA(inode))
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 55bcd411257a..6781b4fab43f 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4790,6 +4790,11 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
>>   	f2fs_invalidate_compress_page(sbi, blkaddr);
>>   }
>>   
>> +static inline bool f2fs_blkzoned_has_regular_section(struct f2fs_sb_info *sbi)
>> +{
>> +	return f2fs_sb_has_blkzoned(sbi) && sbi->first_zoned_segno;
>> +}
>> +
>>   #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
>>   #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
>>   
>> -- 
>> 2.40.1


