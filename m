Return-Path: <linux-kernel+bounces-391551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC69B8885
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7341C21C6E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4531D1A28C;
	Fri,  1 Nov 2024 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/cFd9w0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E63CF73
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424766; cv=none; b=TJxyDLLBJRx81Xfy7Bgs1M3H6G1bTuFkP1D4xkKG2mG/4OAj+pwdOhTxi7FsyWKXMzUhUcKgLKPjiR4oUh5zhWOuq/TWXcF4bvyRasQp+GdJ6KrmfUaJNz9xkhWTcvkeu/fkIl6Z7Rxlfby8XCSWNfhj4rbbUrPGlXlfqH5FuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424766; c=relaxed/simple;
	bh=SBC0caSq81doMxaPvuniaANq63JDI6nXuvCDka/o8gE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MQv8YjkYayR3wfy5n+anNrH9qsTs0aXAn28Cyp7fUzdFV2W0EDa7dTlW/33eME6qKb0MvsQ7oYyFFikErlry5/IHNmMQwZ1Uh9mBB/JOc17VzJ0CdFZUEDMCVtQA8MrH7AC867BBp81uoHIAGLedoumnb3aPtJ/UysoFWrZtwe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/cFd9w0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE83BC4CED0;
	Fri,  1 Nov 2024 01:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730424766;
	bh=SBC0caSq81doMxaPvuniaANq63JDI6nXuvCDka/o8gE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=i/cFd9w0U3d+b3wCiVfriTqudh10cBtwQ6SzBVuQKD/jAHacgrVPaFMk/zKAb8XHL
	 Gy9dJxH9XXNlQ8ELRnG3LRxrl4TepjYOAgX62T+vwzLHruweMDHbjXJf1xGaMk7Vms
	 lOwJL54I3iXkrcZmiog7YgAe0/FVdFKLBbHPE9CnvoFH86hlHBQCSmXwKhroLqSU7D
	 7GtNyAniFWQLgngCn4tmu6ygRh9hUSI1znWxseQaoouwJDfZAi9skGUpnGPvNb3lK/
	 5BeVmc21hWlw3Ce4+zye+Hk+rY9vbi+yjo3hiPcVhLFo2Jy7NLkY5UvwXtpMfg88ZF
	 WRm6ybIp816xA==
Message-ID: <fede8a9b-8532-4d63-a4db-b52ed088d6f8@kernel.org>
Date: Fri, 1 Nov 2024 09:32:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH] f2fs: fix to map blocks correctly for direct read
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241031102200.440407-1-chao@kernel.org>
 <ZyQtcbtzpixFd6Zs@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZyQtcbtzpixFd6Zs@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/1 9:22, Jaegeuk Kim wrote:
> On 10/31, Chao Yu wrote:
>> f2fs_map_blocks() supports to map continuous holes or preallocated
>> address, we should avoid setting F2FS_MAP_MAPPED for these cases
>> only, otherwise, it may fail f2fs_iomap_begin(), and make direct
>> write fallbacking to use buffered IO and flush, result in performance
>> regression.
> 
> Is this fixing direct write or read?

Direct write.

> 
>>
>> Fixes: 9f0f6bf42714 ("f2fs: support to map continuous holes or preallocated address")
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202409122103.e45aa13b-oliver.sang@intel.com
>> Cc: Cyril Hrubis <chrubis@suse.cz>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/data.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 306b86b0595d..38b85160c6bd 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1676,7 +1676,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>   		/* reserved delalloc block should be mapped for fiemap. */
>>   		if (blkaddr == NEW_ADDR)
>>   			map->m_flags |= F2FS_MAP_DELALLOC;
>> -		if (flag != F2FS_GET_BLOCK_DIO || !is_hole)
>> +		/*
>> +		 * f2fs_map_blocks() supports to map continuous holes or
>> +		 * preallocated address, don't set F2FS_MAP_MAPPED for these
>> +		 * cases only.
>> +		 */
>> +		if (flag != F2FS_GET_BLOCK_DIO || map->m_may_create || !is_hole)
> 
> So, this is adding map->m_may_create, which is for writes?

map->m_may_create is added for write path, w/o this condition, f2fs_map_blocks()
may missed to tag F2FS_MAP_MAPPED, result in that f2fs_iomap_begin() will return
-ENOTBLK.

Am I missing someting?

Thanks,

> 
>>   			map->m_flags |= F2FS_MAP_MAPPED;
>>   
>>   		map->m_pblk = blkaddr;
>> -- 
>> 2.40.1


