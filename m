Return-Path: <linux-kernel+bounces-312213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2779693A1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87185281940
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DA1CFEAA;
	Tue,  3 Sep 2024 06:26:40 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69CA5F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725344799; cv=none; b=tIDYn3VY7j7BFZbKf1aNbcjQnimo8g7x+ujOPuGulPrwDmEJcCK+gXu5PUj+McNL3uIOxFo9TUmJRxHWtyMLW1i/O0ofphwstuxi16CuiDvFQKxAgPaSm/yivBUScl0dyxR1cNGnv4q+ekoM0iQpEOupUDHLEGhdRspt8gRXnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725344799; c=relaxed/simple;
	bh=ayf8JTB8NyIqXFvyJm8O4YskZpoAxeoLWgd9+JbZzTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLJ9GnRtlwjIpqAeZEE38l1bMU9Qt9TOplJqkBmsQykn3cODFVovn4DKfz9t1NJXS2GA2ukKnvl7H4Qmb21SKTW7DxRihnZ3mr0ffHzHBU5vgCNclI8Mkxr9HKgLTdHDOR7v22y/UdAMT16xF1HJWnCo8A70uX/aU50A2UDSBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4WyZpp1dLYzYl1nc;
	Tue,  3 Sep 2024 14:05:06 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 14:07:06 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 14:07:06 +0800
From: wangzijie <wangzijie1@honor.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
CC: <chao@kernel.org>, <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
	<wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: don't set SBI_QUOTA_NEED_REPAIR flag if receive SIGKILL
Date: Tue, 3 Sep 2024 14:06:58 +0800
Message-ID: <20240903060658.1780002-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <52ced02d-728b-4e3b-9079-73efd91c90e3@kernel.org>
References: <52ced02d-728b-4e3b-9079-73efd91c90e3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
Reply-To: Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a011.hihonor.com
 (10.68.31.243)

From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

>On 2024/8/27 14:22, wangzijie wrote:
>> Thread A
>> -dquot_initialize
>>   -dqget
>>    -f2fs_dquot_acquire
>>     -v2_read_dquot
>>      -qtree_read_dquot
>>       -find_tree_dqentry
>>        -f2fs_quota_read
>>         -read_cache_page_gfp
>>          -do_read_cache_folio
>>           -fiemap_read_folio
>>            -folio_wait_locked_killable
>>             -receive SIGKILL : return -EINTR
>>         -set SBI_QUOTA_NEED_REPAIR
>>     -set SBI_QUOTA_NEED_REPAIR
>> 
>> When calling read_cache_page_gfp in quota read, thread may receive SIGKILL and
>> set SBI_QUOTA_NEED_REPAIR, should we set SBI_QUOTA_NEED_REPAIR in this error path?
>
>f2fs_quota_read() can be called in a lot of contexts, can we just ignore -EINTR
>for f2fs_dquot_initialize() case?
>
>Thanks,

Yes, in many contexts f2fs_quota_read() can be called and may return -EINTR, we need to 
ignore this errno for more cases. If we need to do so, I will check it and resend patch.
Or do you have other suggestions to avoid unnecessary SBI_QUOTA_NEED_REPAIR flag set?

Thank you for review.

>> 
>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>> ---
>>   fs/f2fs/inode.c | 3 ++-
>>   fs/f2fs/super.c | 6 +++---
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index ed629dabb..2af98e2b7 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -837,8 +837,9 @@ void f2fs_evict_inode(struct inode *inode)
>>   
>>   	err = f2fs_dquot_initialize(inode);
>>   	if (err) {
>> +		if (err != -EINTR)
>> +			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>   		err = 0;
>> -		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>   	}
>>   
>>   	f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 1f1b3647a..f99a36ff3 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2650,8 +2650,8 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>>   			if (PTR_ERR(page) == -ENOMEM) {
>>   				memalloc_retry_wait(GFP_NOFS);
>>   				goto repeat;
>> -			}
>> -			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>> +			} else if (PTR_ERR(page) != -EINTR)
>> +				set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>   			return PTR_ERR(page);
>>   		}
>>   
>> @@ -3070,7 +3070,7 @@ static int f2fs_dquot_acquire(struct dquot *dquot)
>>   
>>   	f2fs_down_read(&sbi->quota_sem);
>>   	ret = dquot_acquire(dquot);
>> -	if (ret < 0)
>> +	if (ret < 0 && ret != -EINTR)
>>   		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>   	f2fs_up_read(&sbi->quota_sem);
>>   	return ret;



