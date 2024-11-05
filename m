Return-Path: <linux-kernel+bounces-395976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253A9BC61A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B442B1C219FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66EF1DC185;
	Tue,  5 Nov 2024 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM9Lk7Dh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DED41A8E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789771; cv=none; b=k+bKhV0dHxtqa1za/0fDrRXfI3BQ0jXX/LAF7ESShabF0MwPwRb0fo9gBPqGGE6SIbn7w/Woy8djNHjXEoZ5Qy9uGTTl+gXtbPlB3qgdgQceZil6C7doeSFmAbj56LW2o2HLxgSKchEkQ4DcHFg/d0nxwxRPd8xU1le+BXyGLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789771; c=relaxed/simple;
	bh=Fo2fibcWfMKMCUazhkZYgaohA7hDQkPM3279WGFliLc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ACk7mwFn7J1NRcdU7vft6N6QbkzsddZwjn02eRe/D8SJH9UDLJaL/i0FIYHd5XCyy3PmGhVKas12ZG7EeR2adszCBSA9Us+QQViEnD8T9gcFkb04OVzLiK5SXdYfTQH8PJ+dhxTWH2Ma7kkRdVSQvzqQAH93/aaS76cSgv545L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM9Lk7Dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D61C4CECF;
	Tue,  5 Nov 2024 06:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730789770;
	bh=Fo2fibcWfMKMCUazhkZYgaohA7hDQkPM3279WGFliLc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kM9Lk7Dhj3ZoWuqoKi1anVPXa2e0He9hAkpFvwOh69eU1ErvxLGilSSedBlKgGgIw
	 2CrjdyJK/24JV/atfF3CHvYOOBj5st1/rEo7bkFdXadBok1uUSLzDhTWVaHBgl8/w/
	 tcQR1jlT9pKlu/yKGaFguZrfmYREeWY2S9DC6q0HcXnSswh0R9hV2S91tq2HRbTBe/
	 25eW2EWDtOLyhl3zmWVJ+HY76SJnLk93V/g8lS8m4xss0ZJaZ9sqoZoiiDI0csmPxD
	 gI9Xzqx5rUEWAuM7zq5HJ3fdgb26A8A9bdCSBQXfLYRy4ltAKKRQWg+1+66qcFAX9u
	 aydpS2I3b/bLw==
Message-ID: <fe8f262c-1b18-47e8-8133-06663835b551@kernel.org>
Date: Tue, 5 Nov 2024 14:56:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
 <888aaf87-1363-4c1f-bd95-d119c72d7b30@kernel.org>
 <CAHJ8P3J+8xEwNL3S6JoR=E0_RczgwvHAGp8jZs5GZESza6n9LQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3J+8xEwNL3S6JoR=E0_RczgwvHAGp8jZs5GZESza6n9LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/5 12:02, Zhiguo Niu wrote:
> Chao Yu <chao@kernel.org> 于2024年11月5日周二 11:15写道：
>>
>> On 2024/11/4 9:56, Zhiguo Niu wrote:
>>> If user give a file size as "length" parameter for fiemap
>>> operations, but if this size is non-block size aligned,
>>> it will show 2 segments fiemap results even this whole file
>>> is contiguous on disk, such as the following results:
>>>
>>>    ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>> Fiemap: offset = 0 len = 19034
>>>           logical addr.    physical addr.   length           flags
>>> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
>>> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
>>>
>>> after this patch:
>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>> Fiemap: offset = 0 len = 19034
>>>       logical addr.    physical addr.   length           flags
>>> 0    0000000000000000 00000000315f3000 0000000000005000 00001001
>>
>> Hi Zhiguo,
>>
>> Any testcase to reproduce this bug? w/o this patch, it looks output
>> from fiemap looks fine?
>>
>> f2fs_io fiemap 0 19034 file
>> Fiemap: offset = 0 len = 19034
>>          logical addr.    physical addr.   length           flags
>> 0       0000000000000000 0000000004401000 0000000000005000 00001001
>>
> Hi Chao,
> Sorry I didn't write clearly enough about the test case, and i put the
> note below the ""Singed-off" tag.
> let me describe it again， f2fs_io fiemap has been modified by me for
> testing in my local, and  the length parameter
> is the real file size of the file, not the block numer. because user
> also pass the real file size to fiemap ioctl.
> so with the new f2fs_io fiemap, a contiguous file on disk may be shown
> 2 segments if the length is not block size alinged.
> such as:
> 
> ums9632_1h10:/data # ls -l ylog/ap/analyzer.py
> -rw-rw-rw- 1 root system 19006 2008-01-01 00:00 ylog/ap/analyzer.py
> ums9632_1h10:/data # ./f2fs_io fiemap 0 19006 ylog/ap/analyzer.py
> Fiemap: offset = 0 len = 19006
>          logical addr.    physical addr.   length           flags
> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> 
> but if we pass a length that is block size alinged, it will show one
> whole segment in fiemap log.
> ums9632_1h10:/data # ./f2fs_io fiemap 0 20480 ylog/ap/analyzer.py
> Fiemap: offset = 0 len = 20480
>          logical addr.    physical addr.   length           flags
> 0       0000000000000000 0000000020baa000 0000000000005000 00001001
> Thanks.

Oh, I can reproduce it w/ xfs_io, thanks for your explanation.

xfs_io file -c "fiemap -v 0 19006"
file:
  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
    0: [0..31]:         139272..139303      32 0x1000
    1: [32..39]:        139304..139311       8 0x1001
xfs_io file -c "fiemap -v 0 20480"
file:
  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
    0: [0..39]:         139272..139311      40 0x1001

Thanks,

>> Thanks,
>>
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>> V2: correct commit msg according to Chao's questions
>>> f2fs_io has been modified for testing, the length for fiemap is
>>> real file size, not block number
>>> ---
>>>    fs/f2fs/data.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 306b86b0..9fc229d 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>                        goto out;
>>>        }
>>>
>>> -     if (bytes_to_blks(inode, len) == 0)
>>> -             len = blks_to_bytes(inode, 1);
>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
>>> +             len = round_up(len, blks_to_bytes(inode, 1));
>>>
>>>        start_blk = bytes_to_blks(inode, start);
>>>        last_blk = bytes_to_blks(inode, start + len - 1);
>>


