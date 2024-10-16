Return-Path: <linux-kernel+bounces-367107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6899FEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3781F254C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A010143736;
	Wed, 16 Oct 2024 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DiSS+nCS"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5416131A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044636; cv=none; b=p9hUJA71WMjxK0fdINbtookS7d4cCe5AFoQRwLs/ntGCBexm/7JKWjUIqUnHrqWBOxQMZcCI2zveojp2jCeZjAcM/AVmcOSNnCs26WBudq0yjtJnARiCcxYQGXWN6/VOAhhd8dWWwBzim6zoaTgOQ2XHSFkX8IRppIhBOUrJ8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044636; c=relaxed/simple;
	bh=fH4e5DvEzI0rPsvGK/scsRU3xTSLf0G7mGM3X9bECcg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gDojVoNhMSEUs81l7TkXn0sAbwiEqqGhWl12AjhivP6buGGcypiUF60CVAWq9o8g658OzF0fy2Ou4+VLqyN+eBor/lu+5GQd86pwEsxSTsq4D8r6XJbUjl3eZ2chjMKYSqsvFKLcabcdjyQ2LnzDANZs16/KPdu7As6URTqBMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DiSS+nCS; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729044626; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=59o4zg4/+vknWX2oHOy0m/Pxhuo7md0FwMtv/iOOqNs=;
	b=DiSS+nCSjXoNT9RAIRm+PPUP8jeve0xVSAOq6kTyJCy3WNUipRQ7P3Y4UErAEaj3UVxOq+sWm7r5okr3LlDK4qIMbLcMbDXErPFLuoTiyPFcx3KFImDzjMYlDwMNmYCtpYO6IyxIfN6NqW0q6WcO4q4ycn1QLZyIpguba0yTnzA=
Received: from 30.221.129.144(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WHFG8.T_1729044625 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 10:10:26 +0800
Message-ID: <5e1fb5ab-1b37-4153-bd67-c6f66b4af411@linux.alibaba.com>
Date: Wed, 16 Oct 2024 10:10:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] ocfs2: add a sanity check for i_size
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <431f1d14-ba07-4903-ab02-b4628e0f1973@linux.alibaba.com>
 <tencent_C8EA75F1764366383C3F373A972436904A09@qq.com>
 <8947c80d-9fed-4269-8a56-080d4afa782b@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <8947c80d-9fed-4269-8a56-080d4afa782b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/24 10:06 AM, Joseph Qi wrote:
> 
> 
> On 10/14/24 7:47 PM, Edward Adam Davis wrote:
>> Syzbot reported a BUG in ocfs2_read_virt_blocks.
>> ------------[ cut here ]------------
>> kernel BUG at fs/ocfs2/extent_map.c:971!
>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>> CPU: 1 UID: 0 PID: 5221 Comm: syz-executor117 Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>> RIP: 0010:ocfs2_read_virt_blocks+0xaa3/0xb20 fs/ocfs2/extent_map.c:971
>> Code: 8b 54 24 30 8b 4c 24 1c 4c 8b 44 24 38 45 89 e1 ff 74 24 48 e8 7e 0a 0c 00 48 83 c4 08 eb 25 e8 43 d2 34 08 e8 ee d1 0c fe 90 <0f> 0b e8 e6 d1 0c fe 4c 89 e8 45 89 e5 49 89 c4 e9 01 f7 ff ff e8
>> RSP: 0018:ffffc90002e2e820 EFLAGS: 00010293
>> RAX: ffffffff83881432 RBX: 0000000000000000 RCX: ffff88802d3e9e00
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: ffffc90002e2e9f0 R08: ffffffff83880eae R09: 1ffffffff203781d
>> R10: dffffc0000000000 R11: fffffbfff203781e R12: ffff8880764d8878
>> R13: 0000000000000000 R14: 0000000000000000 R15: 1ffff920005c5d18
>> FS:  000055557cd55380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00005628fd41e058 CR3: 000000002d2e6000 CR4: 00000000003526f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  ocfs2_read_dir_block+0x106/0x5c0 fs/ocfs2/dir.c:508
>>  ocfs2_find_dir_space_el fs/ocfs2/dir.c:3427 [inline]           // status = ocfs2_read_dir_block(dir, 0, &bh, 0);
> 
> As I replied before, the comment behind seems unneeded.
> 
>>  ocfs2_prepare_dir_for_insert+0x3f2/0x5c60 fs/ocfs2/dir.c:4274
>>  ocfs2_mknod+0xcaf/0x2b40 fs/ocfs2/namei.c:292
>>  ocfs2_create+0x1ab/0x480 fs/ocfs2/namei.c:672
>>  lookup_open fs/namei.c:3595 [inline]
>>  open_last_lookups fs/namei.c:3694 [inline]
>>  path_openat+0x1c03/0x3590 fs/namei.c:3930
>>  do_filp_open+0x235/0x490 fs/namei.c:3960
>>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
>>  do_sys_open fs/open.c:1430 [inline]
>>  __do_sys_openat fs/open.c:1446 [inline]
>>  __se_sys_openat fs/open.c:1441 [inline]
>>  __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> In this path, v_block(0), flags(0), and nr(1) are fixed values that are
>> hard coded, so if i_size is 0, the bug will be triggered.
>>
> 
> This is not a proper commit log.
> You have to convert to the user scenario, but not simply list the
> parameters value that cause the issue.
> 
>> Reported-and-tested-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=797d4829dafe3f11dce7
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>> V1 -> V2: keep rc to 0 when falgs contains READHEAD
>> V2 -> V3: check i_size only and alert subject and comments
>>
>>  fs/ocfs2/extent_map.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> #syz test
>>

BTW, please don't mix syzbot test command into the formal patch.

>> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
>> index f7672472fa82..29d27a70dbdd 100644
>> --- a/fs/ocfs2/extent_map.c
>> +++ b/fs/ocfs2/extent_map.c
>> @@ -961,13 +961,17 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
>>  	int rc = 0;
>>  	u64 p_block, p_count;
>>  	int i, count, done = 0;
>> +	loff_t i_size = i_size_read(inode);
>>  
>>  	trace_ocfs2_read_virt_blocks(
>>  	     inode, (unsigned long long)v_block, nr, bhs, flags,
>>  	     validate);
>>  
>> +	if (!i_size)
>> +		return -EINVAL;
>> +
> 
> Take a more consideration, inode size 0 doesn't mean it has no blocks,
> since we have a case that fallocate with KEEP_SIZE.
> Could you please check inode->i_blocks in above coredump?
> 
> Thanks,
> Joseph
> 
>>  	if (((v_block + nr - 1) << inode->i_sb->s_blocksize_bits) >=
>> -	    i_size_read(inode)) {
>> +	    i_size) {
>>  		BUG_ON(!(flags & OCFS2_BH_READAHEAD));
>>  		goto out;
>>  	}
> 


