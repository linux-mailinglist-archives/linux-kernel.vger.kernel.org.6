Return-Path: <linux-kernel+bounces-510445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD840A31CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E8B167D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E91DA60D;
	Wed, 12 Feb 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8dvQxm5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA8271839
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331535; cv=none; b=FFH9XntJjPHLofBDv0K1R+XXdYySeJY4V4spThuaueF5ns0zFuUP5PVEm64AcSLvcAqZ3JPiwXoaz54nwAG9hKZZ5KR3LAKfCxxzG5iYY+Fel3QDdpqlragxtMWhD8MDAntFfQHZxErMmNz5LupgJ5u7syWDfezIPamZwvD2c9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331535; c=relaxed/simple;
	bh=husLCFSe8peHA3aELneo6doulef1zDxM3wWdqYQuZcg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EuyHrTgYRoLgWV2nl7yMl2xaIGtqjdspqR3BMR0c0RqYnW6YUegGR6IhNI13FjInzPUHLUcVPFx5fetWIWjnmFU6LNQKM2Oy5+AeoJ1/8oU9XBpyRFeC/tYvB9p54qWoOoZBa88zSQ1Aa76gs0A/htO1YeAYIGSQrfNoKZIgdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8dvQxm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A6FC4CEDF;
	Wed, 12 Feb 2025 03:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739331535;
	bh=husLCFSe8peHA3aELneo6doulef1zDxM3wWdqYQuZcg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=f8dvQxm5x75pnbI5BtYQER8KefmGrkXAnH7csOEZsCQIDTi5gya1apXC109NnuyO5
	 V4NzWhDE3FngD7ElDipJ3fHo/15xDiUlqThBlvbMLQCtTc1EHigiKKn50op5pZrSVB
	 TnMzqEsh8QRPB0coXdhtXV3ao8y8rS+/La8MB0Ya1CZPuDQO3Px11WpKBSNUDUs84K
	 /td7tRCLeAjRxrtlEwdfrjWER4K8MUFKlM1wb5kPKjZiq2vL7TuugkeQ85zYNDTwd/
	 rwe0dUZOIFtsMrZguFFNd9Avdh3sHObIJjRRobllVXD1M5j6cnXiCOJu6bHHcaMhII
	 fgGuGv8U2gcGQ==
Message-ID: <983c13f7-7b27-43c5-ad9e-20c24aa7b3fc@kernel.org>
Date: Wed, 12 Feb 2025 11:38:52 +0800
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
Subject: Re: [PATCH v3 RESEND] f2fs: add check for deleted inode
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250211071725.457343-1-chao@kernel.org>
 <Z6wUaT91OnABzNfQ@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Z6wUaT91OnABzNfQ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 11:24, Jaegeuk Kim wrote:
> On 02/11, Chao Yu wrote:
>> From: Leo Stone <leocstone@gmail.com>
>>
>> The syzbot reproducer mounts a f2fs image, then tries to unlink an
>> existing file. However, the unlinked file already has a link count of 0
>> when it is read for the first time in do_read_inode().
>>
>> Add a check to sanity_check_inode() for i_nlink == 0.
>>
>> [Chao Yu: rebase the code]
>> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
>> Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
>> Signed-off-by: Leo Stone <leocstone@gmail.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> - no logic change, just rebase the code to last dev-test branch
>>  fs/f2fs/inode.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index d6ad7810df69..543fb942bec1 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>>  		}
>>  	}
>>  
>> +	if (inode->i_nlink == 0) {
>> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
>> +			  __func__, inode->i_ino);
>> +		return false;
>> +	}
> 
> This gives a wrong EFSCORRUPTED when recoverying orphan inodes.

Correct, I noticed that it may fail generic/417, let me fix this.

Thanks,

> 
> f2fs_recover_orphan_inodes
> -> f2fs_iget_retry
>  -> orphan inode can have i_nlink = 0.
> 
>> +
>>  	return true;
>>  }
>>  
>> -- 
>> 2.48.1.502.g6dc24dfdaf-goog


