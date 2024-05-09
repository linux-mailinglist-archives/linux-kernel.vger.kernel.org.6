Return-Path: <linux-kernel+bounces-174069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E18C09E9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F101F229B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CD513BC1B;
	Thu,  9 May 2024 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOTE8orV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92B13A87A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715222961; cv=none; b=jDI/7pwl0O9hn9fL7mndPJClNZ8RaWQEZY2mu+nPhzs9SropKJhT4dLXYdLIew9ATwKiHXHivi9TBTXBfqpeyF0ZbAcL/w3cipW+mcyHiNABedhMed2E/JDshBDvgSk95f+4u5jY7867MEAvQ7GfFBtdBMhDY0oIrSwRlDKbTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715222961; c=relaxed/simple;
	bh=v7wln2xpQLVVAxH/uG3eYmTTj+iPQmXfVO6dtLtvARw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRnf7Hg6bqRyCdjT4+3zIRne+n625PDM3nDmylX4QFQO+B9rmarwGSuAhWrVrH9CxPUZ+L589va3TWuRKtoa1mhRmz9+hSL+mr1/Szv7KeUpul6G4eeIu2lJuo6/TRtqAqH/C63YMDYUs1FY6DF5x00/5acjk3y5pT3XyJu7KAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOTE8orV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49456C113CC;
	Thu,  9 May 2024 02:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715222961;
	bh=v7wln2xpQLVVAxH/uG3eYmTTj+iPQmXfVO6dtLtvARw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JOTE8orVPVO0pCaSPeWTSsOdhR4mLpnMOIHDMxxhPdf3yy8pCiRU5lDJd0hY7J00x
	 Mx/UE3VXLWkUz/2M8t2YCeaQ5aSqDIlfshMCOk5hVeCHCO0/yt1zM8JTeTR/bs7t16
	 s5z6deoWppPqD5D5F3DLCDiYzW1J1a6dksLxqwNklJdIebFq/DElmARk1U/3kDJEem
	 la5mdOUaf2panlFP+qGx0dMcoMZC7wyOM9FV8ZF24i4KVougPzhz6oFeDCTFY6+gHj
	 eWQj5oLv/tSRwewkqqZWGsP7VgC7AIkylDeNnNZz46aBZBAXroenoBWLD8EQ7o5N4z
	 JKT3ruOfBBo2A==
Message-ID: <32e097e6-67f1-4f06-bad0-0c7b3afb46f0@kernel.org>
Date: Thu, 9 May 2024 10:49:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] f2fs: fix to add missing iput() in gc_data_segment()
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240506103313.773503-1-chao@kernel.org>
 <20240506103313.773503-2-chao@kernel.org> <Zjwc5QGJfm6XXzOX@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zjwc5QGJfm6XXzOX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/9 8:46, Jaegeuk Kim wrote:
> On 05/06, Chao Yu wrote:
>> During gc_data_segment(), if inode state is abnormal, it missed to call
>> iput(), fix it.
>>
>> Fixes: 132e3209789c ("f2fs: remove false alarm on iget failure during GC")
>> Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/gc.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 8852814dab7f..e86c7f01539a 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>   			int err;
>>   
>>   			inode = f2fs_iget(sb, dni.ino);
>> -			if (IS_ERR(inode) || is_bad_inode(inode) ||
>> -					special_file(inode->i_mode))
>> +			if (IS_ERR(inode))
>>   				continue;
>>   
>> +			if (is_bad_inode(inode) ||
>> +					special_file(inode->i_mode)) {
>> +				iput(inode);
> 
> iget_failed() called iput()?

It looks the bad inode was referenced in this context, it needs to be iput()ed
here.

The bad inode was made in other thread, please check description in commit
b73e52824c89 ("f2fs: reposition unlock_new_inode to prevent accessing invalid
inode").

Thanks,

> 
> 
>> +				continue;
>> +			}
>> +
>>   			err = f2fs_gc_pinned_control(inode, gc_type, segno);
>>   			if (err == -EAGAIN) {
>>   				iput(inode);
>> -- 
>> 2.40.1

