Return-Path: <linux-kernel+bounces-324149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F208497486E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CC9288A32
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1F92BAEF;
	Wed, 11 Sep 2024 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8bR7mv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D68224CF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023987; cv=none; b=d5dHkmwAlvbvhiTPflZz5pQ4mOihSJMIKLHS3bwBXt/kg9vvdRTzvWT7LNebhzwVuCFK9jftS6lfoDXauRVEnMi0uisDrXKPZTdiCDnW9CfZ29iY6pOXy25o74LtfaSUmOohpoZuvF7NHGZST2YtBfK59KL5FGszNDfIhTEDegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023987; c=relaxed/simple;
	bh=ta0cFIxUrVPGw1Tmjosf+SAT1/5RHdhMnYyT7R228b4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ttvQlwNoxv7ouTzWG/0A5Ph2TZbwZh45RGwdZSQh1i/bV8nBP5SIAzuMsZG3Ma0nfPOy/YzwfTb0GnLZO2fVDyroNKNJ6sRm/KeLhqTOSkES+YNjHS7VXR4uHte/uIfD37YPcExL8MkACaQT26WrbDi+B5XqTEVQpmDn0YYGQpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8bR7mv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE57C4CEC3;
	Wed, 11 Sep 2024 03:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726023987;
	bh=ta0cFIxUrVPGw1Tmjosf+SAT1/5RHdhMnYyT7R228b4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=r8bR7mv7IBeFSZZw43d/cTlxDeOIVvFOqHu8zm9TvTUtzJRdjSTcLWNRkgKefYMKm
	 DO8GVMgRK1No87sOciBl+/gdgtE8lktLNfyEgIev4xJA41DQ3k2Kfts0Nfb5ZIA7ER
	 7KbowNJ9wmWjrKg6q+Oo4LcsgFuNdP5rmjAHpycEFvbpWZ1hNSuJdB1mFi8cSpnlhH
	 CJS5Oj49VQHEoITQFokdmDjedUWI80GQDMHCt2sdNucrgKbBvgzfB+Zcnmlj8Uk+O9
	 DEAIrXwJC4TBjIRVjIAKEa4GYdzmzpwWTGq+pBWCHJionkvLkEe5uqgQH/IpcGkILR
	 aGKxi2YE37g6w==
Message-ID: <44f5168e-3931-438e-8a85-3866f797f9b6@kernel.org>
Date: Wed, 11 Sep 2024 11:06:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to tag STATX_DIOALIGN only if inode
 support dio
To: Eric Biggers <ebiggers@kernel.org>
References: <20240910125753.80502-1-chao@kernel.org>
 <20240910170600.GB2642@sol.localdomain>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240910170600.GB2642@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/11 1:06, Eric Biggers wrote:
> On Tue, Sep 10, 2024 at 08:57:53PM +0800, Chao Yu via Linux-f2fs-devel wrote:
>> After commit 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
>> inode"), f2fs starts to force using buffered IO on inline_data inode.
>>
>> And also, it will cause f2fs_getattr() returning invalid zeroed value on
>> .dio_mem_align and .dio_offset_align fields, however, STATX_DIOALIGN flag
>> was been tagged. User may use zeroed .stx_dio_offset_align value
>> since STATX_DIOALIGN was been tagged, then it causes a deadloop during
>> generic/465 test due to below logic:
>>
>> align=stx_dio_offset_align(it equals to zero)
>> page_size=4096
>> while [ $align -le $page_size ]; do
>> 	echo "$AIO_TEST -a $align -d $testfile.$align" >> $seqres.full
>> 	$AIO_TEST -a $align -d $testfile.$align 2>&1 | tee -a $seqres.full
>> 	align=$((align * 2))
>> done
>>
>> Quoted from description of statx manual:
>>
>> " If  a  filesystem  does  not support a field or if it has an
>>    unrepresentable value (for instance, a file with an exotic type),
>>    then the mask bit corresponding to that field will be cleared in
>>    stx_mask even if the user asked for it and a dummy value will be
>>    filled in for compatibility purposes if one is available (e.g.,
>>    a dummy UID and GID may be specified to mount under some
>>    circumstances)."
>>
>> We should not set STATX_DIOALIGN flag in kstat.stx_mask if inode
>> does not support DIO, so that it can indicate related fields contain
>> dummy value, and avoid following incorrect use of them.
>>
>> Fixes: c8c02272a9f7 ("f2fs: support STATX_DIOALIGN")
> 
> When claiming to be Fixing a commit, please make sure to Cc the author of that
> commit.

No problem, will make sure they were Cced.

> 
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/file.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 99903eafa7fe..f0b8b77e93ba 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -906,14 +906,11 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
>>   	 * f2fs sometimes supports DIO reads but not DIO writes.  STATX_DIOALIGN
>>   	 * cannot represent that, so in that case we report no DIO support.
>>   	 */
>> -	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
>> -		unsigned int bsize = i_blocksize(inode);
>> -
>> +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode) &&
>> +				!f2fs_force_buffered_io(inode, WRITE)) {
>> +		stat->dio_mem_align = F2FS_BLKSIZE;
>> +		stat->dio_offset_align = F2FS_BLKSIZE;
>>   		stat->result_mask |= STATX_DIOALIGN;
>> -		if (!f2fs_force_buffered_io(inode, WRITE)) {
>> -			stat->dio_mem_align = bsize;
>> -			stat->dio_offset_align = bsize;
>> -		}
>>   	}
>>   
>>   	flags = fi->i_flags;
> 
> No, this patch is wrong and the existing code is correct.  The cases are:

Yes, you're right, thanks for pointing out this!

> 
>      STATX_DIOALIGN set and stx_dio_*_align nonzero:
>          File supports DIO.
> 
>      STATX_DIOALIGN set and stx_dio_*_align zero:
>          File doesn't support DIO.
> 
>      STATX_DIOALIGN unset:
>          Filesystem doesn't support STATX_DIOALIGN, so it's unknown whether the
>          file supports DIO or not.

Above description is clear to me.

> 
> Please see the statx(2) manual page which explains this too.

However, below manual seems not very clear about explaining what does it
mean about STATX_DIOALIGN is set or not? At least not so clear like above
description.

        stx_dio_mem_align
               The alignment (in bytes) required for user memory buffers for direct I/O (O_DIRECT) on this file, or 0 if direct I/O is not supported on this file.

               STATX_DIOALIGN (stx_dio_mem_align and stx_dio_offset_align) is supported on block devices since Linux 6.1.  The support on regular files varies by filesystem; it is supported by ext4, f2fs, and xfs since  Linux
               6.1.

        stx_dio_offset_align
               The  alignment  (in  bytes)  required  for  file  offsets  and  I/O  segment  lengths  for  direct  I/O  (O_DIRECT)  on this file, or 0 if direct I/O is not supported on this file.  This will only be nonzero if
               stx_dio_mem_align is nonzero, and vice versa.

Thanks,

> 
> - Eric


