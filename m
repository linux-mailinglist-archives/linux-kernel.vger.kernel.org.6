Return-Path: <linux-kernel+bounces-291359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9481956131
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35975B216DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE3036B17;
	Mon, 19 Aug 2024 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NKBNUsRG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACB38384
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035251; cv=none; b=O0mYuWbVdQ2uwDWg7bxa/CxCUGyIln2alKo26UQvEILIH8HCUtYTAs5priOgWGwCy9ZU2dBbCow9QcnDpRJkaQPDo1k5pIQYBuG3MCET2TYRsALBgEDNEBrobgKDCrQtjNezfTkzK6ED4rC4cRLs095AFFsEKZmLAif/g78P+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035251; c=relaxed/simple;
	bh=m8vhVFrXVR342rluGvz0IWZNr0LOtnv5NV+3/+iOcFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuZraziVvxVW6/LIzEsoZawsMFaEg7jkZIjpWKzsdUCZPCs2BD/PCOnebqVydb4k4SAp5dearVhzV5kwRuyP6jRX8aXL/SGvsAJmcnDHjIAPoL5/aO1kkASWXYKqij2AqocSUyJDSbOshRNzslQIhvXeemWBzvDTtx06VQm+JVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NKBNUsRG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso24687625e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724035246; x=1724640046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rrz0NLJQUicJg05dix/G7IvIXq0lc24IX6wpTx/j2h8=;
        b=NKBNUsRGO7lTQSGgXMZCp4x3NyYzzDf8fI3u3ciMK/ufh9axTyLavg5ZLLMtvYmIZC
         2KymDMk3bjbDBI2OmrCDpGWISmylrgX3vQwdo0f7+iQgOwQIXQpJqPSqvbIotWAynVSQ
         ZIJHQQjl8kIp69jbn5hhZBhvwYZvIizydpYGAAULH8rcwqwoBEP7sMfY3+EW2hoLUnum
         1Y2PP1ty4aIC10Qrpbk7Ax6p3K1UyCCzyN1qO1xA8n19vz5qdMOEHA85ZdZAsBx9S+M5
         1WmeZjOlD5DL5Bdyg9hOqdhq52P0pJYo8GFyXelFfX4G3AXLkTGlMOkIKdu4AVauPrwx
         u4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724035246; x=1724640046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rrz0NLJQUicJg05dix/G7IvIXq0lc24IX6wpTx/j2h8=;
        b=I7dHRLd8pVGoYFeibfJUokjDqB8rNB5H4FbRBg4vgoIRjjsDQocZc2gYcLRmIcp7Qy
         5+2KZxXdzm1Z2ZOGKizq7M4B+sM58Vdf2jgu9JmxKma+yvhvolGY1xrk7GVReT8uoS5F
         ck8UtGyLIuKCmk6kn+eqO3WhLX5Q08WqLAKoexdI34EfKo9q4j7UdVZIRWgNHkvifTij
         0p2vP7UZUGBDquUeqLlGMdDdtyBC/ODtZtfgYgwCF7FaRyQWsmQfex3ps5RqFuaQcSpw
         Mqgw6nCjBdKBhefhRKiG2sfqfrsHH37RW36KRVxU31IcekHg7+/TxTIMHf42m/c7Xa/X
         N1rg==
X-Forwarded-Encrypted: i=1; AJvYcCXZdCJKTDWyfL2bss54YNacjtvzjQbpEZo9cUTGLcC/sO7b+VvPKWMgQCaFZMxjsWaP8Lss37JS7QCVPOjlQWfd/2E9rbzkQrxQXmPy
X-Gm-Message-State: AOJu0Yxeup0iPQCHbmoFiDiL6440pSAZzMNrn0J5INUqXOV4fSZJ/MAZ
	zWADeQ5Jd7T5S4d62d9XqczOiVgbkJ6ZP0+NaWUmt+Iq+0aQ2BsZkwyXPF249t0=
X-Google-Smtp-Source: AGHT+IHaOf4V6+FrjoW2AFVYnVzlxHKwV4FXAIAcNpqtq7OzHYCEUgI4btoqvPqnzDkmrS1JQRVq6A==
X-Received: by 2002:adf:ce0a:0:b0:36b:c65c:661e with SMTP id ffacd0b85a97d-37186c09a03mr7527730f8f.13.1724035246141;
        Sun, 18 Aug 2024 19:40:46 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3dc9bcdd4sm3066033a91.1.2024.08.18.19.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 19:40:45 -0700 (PDT)
Message-ID: <ed71901d-bf43-4b81-88ea-0dac7207c5c5@suse.com>
Date: Mon, 19 Aug 2024 10:40:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix unexpected zeroing of virtual disk
To: Joseph Qi <joseph.qi@linux.alibaba.com>, Chi Zhiling
 <chizhiling@163.com>, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 starzhangzsd@gmail.com, Chi Zhiling <chizhiling@kylinos.cn>,
 Shida Zhang <zhangshida@kylinos.cn>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>
References: <20240815092141.1223238-1-chizhiling@163.com>
 <432954d5-3b8e-42f7-8c06-1a489281129e@suse.com>
 <333c0334-112e-4ac2-9ec2-c81fe73458bc@linux.alibaba.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <333c0334-112e-4ac2-9ec2-c81fe73458bc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry, I just realized I posted the wrong tag "Signed-off-by: Heming Zhao ...".
The correct should be Reviewed-by: Heming Zhao <heming.zhao@suse.com>.

On 8/19/24 10:32, Joseph Qi wrote:
> Looks good.
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 
> BTW, ocfs2 hasn't been tested thoroughly under 64k page, so I'm afraid
> there are other bugs when running ocfs2 under 64k page.
> 
> On 8/18/24 6:31 PM, Heming Zhao wrote:
>> On 8/15/24 17:21, Chi Zhiling wrote:
>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>
>>> In a guest virtual machine, we found that there is unexpected data
>>> zeroing problem detected occassionly:
>>>
>>> XFS (vdb): Mounting V5 Filesystem
>>> XFS (vdb): Ending clean mount
>>> XFS (vdb): Metadata CRC error detected at xfs_refcountbt_read_verify+0x2c/0xf0, xfs_refcountbt block 0x200028
>>> XFS (vdb): Unmount and run xfs_repair
>>> XFS (vdb): First 128 bytes of corrupted metadata buffer:
>>> 00000000e0cd2f5e: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000000cafd57f5: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000000d0298d7d: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000000f0698484: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000000adb789a7: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 000000005292b878: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000000885b4700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> 00000000fd4b4df7: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> XFS (vdb): metadata I/O error in "xfs_trans_read_buf_map" at daddr 0x200028 len 8 error 74
>>> XFS (vdb): Error -117 recovering leftover CoW allocations.
>>> XFS (vdb): xfs_do_force_shutdown(0x8) called from line 994 of file fs/xfs/xfs_mount.c.  Return address = 000000003a53523a
>>> XFS (vdb): Corruption of in-memory data detected.  Shutting down filesystem
>>> XFS (vdb): Please umount the filesystem and rectify the problem(s)
>>>
>>> It turns out that the root cause is from the physical host machine.
>>> More specifically, it is caused by the ocfs2.
>>>
>>> when the page_size is 64k, the block should advance by 16 each time
>>> instead of 1.
>>> This will lead to a wrong mapping from the page to the disk, which
>>> will zero some adjacent part of the disk.
>>>
>>> Suggested-by: Shida Zhang <zhangshida@kylinos.cn>
>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>> ---
>>>    fs/ocfs2/aops.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
>>> index d6c985cc6353..1fea43c33b6b 100644
>>> --- a/fs/ocfs2/aops.c
>>> +++ b/fs/ocfs2/aops.c
>>> @@ -1187,7 +1187,7 @@ static int ocfs2_write_cluster(struct address_space *mapping,
>>>              /* This is the direct io target page. */
>>>            if (wc->w_pages[i] == NULL) {
>>> -            p_blkno++;
>>> +            p_blkno += (1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits));
>>>                continue;
>>>            }
>>>    
>>
>> Looks good to me.
>> Signed-off-by: Heming Zhao <heming.zhao@suse.com>


