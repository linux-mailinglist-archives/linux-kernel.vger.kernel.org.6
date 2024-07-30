Return-Path: <linux-kernel+bounces-266629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B25819403B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E847BB209B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD96C121;
	Tue, 30 Jul 2024 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU8Pzlbd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6884BA38
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302950; cv=none; b=fPYgNrU7rR/4c5GtK8cl4BH9YaKiHbVN1e1rAnfogNQb8JRZv/ZyWVzeivatg8BXtHJuGP4ecnSuma7e0YOapyGZbdrs201MIl+XCOxbpGFUW2eTOuPMzA1QJr9SeLjL1Rs+gjAu8gcaiJTjKua3VqlCcvcb9ewTUSJHJrLoZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302950; c=relaxed/simple;
	bh=SWevj4/qgCUH1+QbmoMRBMPrM/3GHdlPzbTfv0k9mxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBb9YllojzPXmtlrOyiTw3u0yXqx5ydgBpx/jKQ1T/DOlpykl4B9fjsR2z9JLF4kuD9YPSrkmcOW7aS8MAtHhPJhAlZAWs2MtH65fAyBDe/mygoff7NWe/lsVjah/PynlM7sqJXhR7k6dRxH/UeewG0Ii2SybQxKu/0OP3FW158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU8Pzlbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7315BC32786;
	Tue, 30 Jul 2024 01:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722302950;
	bh=SWevj4/qgCUH1+QbmoMRBMPrM/3GHdlPzbTfv0k9mxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iU8PzlbdFeEhLqVIe6Mviswx8UZKjjL4QQKWafLgIfBMp0+ri9Z7PnVcAXs+fHfnJ
	 N8t14OHuR3+KWaVm37O/cyT8GMe3RkRE7PYfMbRRR1TRJv0Xvq8Tj20GgWuLaTdBu0
	 Fabh3ODiv4VRdMak3yMTF6xcvfA9cp3udc2P1M5k3hKmRg3qXlCFEbspfAMG/YqPm9
	 FbEATWZlWIoIX3DSqqh3YHugGwgYUAqyy+t+29OYbskIQGpN13FXo/VTTC4WTHBxOp
	 uM0Cs7hpHTHYJoAGO9+GpNGDiWsRlPC5h64YZus+wTkppkOmmRJPZ3G5YJEtCfjzTf
	 EBtTiGjrm2zpA==
Message-ID: <9e6c0e72-a175-4432-bada-564464698c3f@kernel.org>
Date: Tue, 30 Jul 2024 09:29:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] f2fs: atomic: fix to truncate pagecache before
 on-disk metadata truncation
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240726012204.1306174-1-chao@kernel.org>
 <ZqfCwDcg7nvJPenf@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZqfCwDcg7nvJPenf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/30 0:26, Jaegeuk Kim wrote:
> On 07/26, Chao Yu wrote:
>> We should always truncate pagecache while truncating on-disk data.
>>
>> Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - fix to use cow_inode instead of inode
>>   fs/f2fs/file.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 6c62f76474d1..54886ddcb8ab 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -2202,6 +2202,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>>   		F2FS_I(fi->cow_inode)->atomic_inode = inode;
>>   	} else {
>>   		/* Reuse the already created COW inode */
>> +		truncate_setsize(fi->cow_inode, 0);
> 
> What if the below truncation failed?

What about just dropping page cache and do not set isize to 0?

Thanks,

> 
>>   		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
>>   		if (ret) {
>>   			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>> -- 
>> 2.40.1

