Return-Path: <linux-kernel+bounces-262754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7F93CC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE78282303
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A2FEDB;
	Fri, 26 Jul 2024 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofMW0sDd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9D37E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956016; cv=none; b=D78Mh04PmFV971VmvqumXai+AEdIPMCD95fFd6sbhwvrX7bCn5/8K90mUDfSrL4rVBvUbD59Ft4AwI2+2+3t2HK/m82cbL/4teZcDejizjBBe7WSTw8f7LSBHM+OGhUKxSi5Xu+etBQgYQqDErlZCH7zjxu7C81rZs+n4HFcFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956016; c=relaxed/simple;
	bh=IbKbKcOeVqGJZe9WNNAvQn9N7nJIqkoELDjo9ILDPzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTIXEI5tyCBHMVGHG0MxoxR4KRzevZnQo/iqOq1/abO/UikIIaJvCw4np4ts1Bl02xgz8rljTuPgs00Tb8ovjuKb4HZ7ZtTsvchDMKpqycVzWNMLVxprMw0U6H4bG5jVaXxkN87QNm5cmvWgTl122KWz9epn7CdBemcNlb3tetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofMW0sDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C3EC116B1;
	Fri, 26 Jul 2024 01:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721956016;
	bh=IbKbKcOeVqGJZe9WNNAvQn9N7nJIqkoELDjo9ILDPzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ofMW0sDdlBiiwD7C05wAaJT0Q/0uosF4Brk/XMN2/U4p9/TkfdS7SEuLJQxGmf9kB
	 moqBh9jctQj+fdTYX2Bp+Y9viqUTrurFV3fZZLHewTzVEHOeiKWvMQJd+xhxVVbCNV
	 bBamCEp5kAiJSeZZN7xevRDDDJqdg0IPHHrBXdEp8dBT2OT31lRtrdAmiHgr+aUSN4
	 cS3UKgBqRdf45g0EHgVneb+SHmyqYO9ldK7tnUuKv7hN2qTKRZA6KOjP1JtUHnNguS
	 MUeYz+TfGnfDzPLffjubDWgA05jeXfE3Zdq44dmkZ+fEjk2N6T7GfrUSswSaASDx61
	 zSW4ZB8l1A//Q==
Message-ID: <ef08e1e5-94af-4944-aaed-37705360bcd6@kernel.org>
Date: Fri, 26 Jul 2024 09:06:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] f2fs: atomic: fix to truncate pagecache before
 on-disk metadata truncation
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240625031351.3586955-1-chao@kernel.org>
 <20240625031351.3586955-3-chao@kernel.org> <ZqK7eC9W9HVweTOJ@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZqK7eC9W9HVweTOJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/26 4:54, Jaegeuk Kim wrote:
> On 06/25, Chao Yu wrote:
>> We should always truncate pagecache while truncating on-disk data.
>>
>> Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/file.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 2203904383a6..0355cb054521 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -2185,6 +2185,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>>   		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
>>   	} else {
>>   		/* Reuse the already created COW inode */
>> +		truncate_setsize(inode, 0);
> 
> 		fi->cow_inode?

Oh, yes, let me fix this.

Thanks,

> 
>>   		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
>>   		if (ret) {
>>   			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>> -- 
>> 2.40.1

