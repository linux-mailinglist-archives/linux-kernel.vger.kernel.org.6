Return-Path: <linux-kernel+bounces-512171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C6A33516
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03643188ADF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3035967;
	Thu, 13 Feb 2025 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA331jt9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D5184F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412053; cv=none; b=uuKfnJBpBRMq3A4qke0WQhFTBLASU/bPZ2G3PfoBN7qQ9ualVsBBRQ15bh5mhOf3VSY2838x7pBK7jCJ0j4Jo1798HTTuYN8/W0d4QMvJYQAX2LIZ5w/2Enq4p5MSY5bUA2WUgFeeC6xz/KxMhfvUR2HbBp9qFv7qtvBk1bOMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412053; c=relaxed/simple;
	bh=i+aNMjx3f4xLDQq1iZy53Xav0/SNZ98Rv14350OTH1k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nGeDQflHg2o1MxI4L4xzUdwXcwQkBEtoVuW/4djvvMlKksU+dks8axLZugWhi+jrugsZJgvIeoXgJZZbFFOcksNbpQqEzBMOoAO2/DQoP5cQ2TESD40cN/Nzhovuj10/zgWku1T/iJLbqoo+UIT7B2y7STeRvWpZ+ZW6S2KVlOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA331jt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7643C4CEDF;
	Thu, 13 Feb 2025 02:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739412052;
	bh=i+aNMjx3f4xLDQq1iZy53Xav0/SNZ98Rv14350OTH1k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DA331jt9ZL+V7DrMQ+SQRrgGrus7xFu4aC4G/oLcnkd97yxVW8s6YEkLvMtpmxXMo
	 RhNBFFsyoDsgqIz9pHvtfcr1qudbQq+MMqKY5G7Ep6E/1IO7MdxAfw81aAyslQrSzG
	 ZAazCs4QLmn+iRSU/LDCwMHPniy7hE3WWfEDSl4258mQRNoe8gvrcZlhCkYZx9X+r9
	 fLr2eBK8uWFeS7RiInvWEvNiizxjbdUCmu8vuzBMy7RaPfuoUbDRK8v+0P7cwp3yh7
	 I/68E5iixzoihDwDB8eoVR+P6L7cWygaBE1riF0fYJbuGoiW2ue5sugoZq6XBTJCW5
	 //ZdfKb8BuSBA==
Message-ID: <d8be79a2-9470-45b7-9df1-b571f2219c30@kernel.org>
Date: Thu, 13 Feb 2025 10:00:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Leo Stone <leocstone@gmail.com>,
 syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] f2fs: add check for deleted inode
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250212072742.977248-1-chao@kernel.org>
 <Z6zQoyNp5td-Wgd1@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Z6zQoyNp5td-Wgd1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 00:47, Jaegeuk Kim wrote:
> On 02/12, Chao Yu wrote:
>> From: Leo Stone <leocstone@gmail.com>
>>
>> The syzbot reproducer mounts a f2fs image, then tries to unlink an
>> existing file. However, the unlinked file already has a link count of 0
>> when it is read for the first time in do_read_inode().
>>
>> Add a check to sanity_check_inode() for i_nlink == 0.
>>
>> [Chao Yu: rebase the code and fix orphan inode recovery issue]
>> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
>> Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
>> Signed-off-by: Leo Stone <leocstone@gmail.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/checkpoint.c | 4 ++++
>>  fs/f2fs/f2fs.h       | 1 +
>>  fs/f2fs/inode.c      | 6 ++++++
>>  3 files changed, 11 insertions(+)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index bd890738b94d..ada2c548645c 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -751,6 +751,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>  	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
>>  		f2fs_info(sbi, "orphan cleanup on readonly fs");
>>  
>> +	set_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
> 
> What about using SBI_POR_DOING?

SBI_POR_DOING will cover most flow of f2fs_fill_super(), I think we can add a
separated flag just covering f2fs_recover_orphan_inodes(), so that we can allow
iget() of root_inode and all inodes during roll-forward recovery to do sanity
check nlink w/ zero. What do you think?

Thanks,

> 
>> +
>>  	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
>>  	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
>>  
>> @@ -778,9 +780,11 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>  		}
>>  		f2fs_put_page(page, 1);
>>  	}
>> +
>>  	/* clear Orphan Flag */
>>  	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
>>  out:
>> +	clear_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
>>  	set_sbi_flag(sbi, SBI_IS_RECOVERED);
>>  
>>  	return err;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 05879c6dc4d6..1c75081c0c14 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1322,6 +1322,7 @@ enum {
>>  	SBI_IS_CLOSE,				/* specify unmounting */
>>  	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
>>  	SBI_POR_DOING,				/* recovery is doing or not */
>> +	SBI_ORPHAN_RECOVERY,			/* orphan inodes recovery is doing */
>>  	SBI_NEED_SB_WRITE,			/* need to recover superblock */
>>  	SBI_NEED_CP,				/* need to checkpoint */
>>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index d6ad7810df69..02f1b69d03d8 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>>  		}
>>  	}
>>  
>> +	if (inode->i_nlink == 0 && !is_sbi_flag_set(sbi, SBI_ORPHAN_RECOVERY)) {
>> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
>> +			  __func__, inode->i_ino);
>> +		return false;
>> +	}
>> +
>>  	return true;
>>  }
>>  
>> -- 
>> 2.48.1.502.g6dc24dfdaf-goog


