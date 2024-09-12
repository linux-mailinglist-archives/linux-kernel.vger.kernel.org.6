Return-Path: <linux-kernel+bounces-326524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23616976975
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17C31F24674
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417921AC89B;
	Thu, 12 Sep 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="fl1tdyzg"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D461A7043
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145119; cv=none; b=UotsVI4BpUyLWMMaJM7TuAe4vcLTDRGg0UXy1d1Nd+h1wpTcsWop2fMkzJEx9nfMFq1b9FLN7P7fGpZKeECFUf123odctGVmsAWqRr82ruv1Bi+j0Y+Unhahz/77AnXjJ53rp4ClW6VZV191/AL9Vy1ExQfUhMy3be2TW9SRpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145119; c=relaxed/simple;
	bh=WAX9zBgT/ePwUQVRkdB31aTxYaGU/9I9RdjFGsuZ66g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogzxta66g/ISFdKZQ5wgQH19KmXZy7k5V8baZ2ioSeA4jS1TsgXvSvNLn9T+8/Au5DLCgDFJ7sUrauUKq+ACCxRUVsnteOazNLUlC3ftGg+NlUX9khdM+uPA1SOMhKrdkIQ+YGnGwWSzMi0M5ZC2N5RtOBieIG6mlAALThASKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=fl1tdyzg; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=b0JcLg+FvqvhI5XxOg4W8fqlcwDhYaH4HTWZzM1i2MQ=;
	b=fl1tdyzgiTBcecRgInX6ECo5TMLnbROWrbJIy8Flm5yD+QfNgzLzsEqHLyvv4V
	SOH/Pf0MDup5qvR/aXyhas1qDY2oGvfQAlotghrab6uWMy7xS9ha04crYASMWDWZ
	e09q6/lWovmOG0o1D5uNM7EFUBpx0nRQWwawbjF9gh/kc=
Received: from [192.168.109.86] (unknown [123.149.251.227])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3X18n4uJmHfJRAA--.48236S2;
	Thu, 12 Sep 2024 20:44:53 +0800 (CST)
Message-ID: <e77a06ff-0f67-456f-9a1d-34570e9b7509@126.com>
Date: Thu, 12 Sep 2024 20:44:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] udf: return EIO when ftrunctate access beyond end of
 device
To: Jan Kara <jack@suse.cz>, Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Cc: jack@suse.com, linux-kernel@vger.kernel.org
References: <20240912061652.980443-1-zhaomengmeng@kylinos.cn>
 <20240912111235.6nr3wuqvktecy3vh@quack3>
From: Zhao Mengmeng <zhaomzhao@126.com>
In-Reply-To: <20240912111235.6nr3wuqvktecy3vh@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3X18n4uJmHfJRAA--.48236S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw13tF18XF4rGw1rurWruFg_yoW7AFW7pr
	ykKF92krW8JFy7Ga1Ivr1rAr48KFZxCF48Wr4xtryvkF1rKr15WF1UtryUWws8Cr1kCa4a
	qF1Utay0kw17CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8jjDUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbi6AlYd2bi1XqovwAAsy

On 2024/9/12 19:12, Jan Kara wrote:
> On Thu 12-09-24 14:16:52, Zhao Mengmeng wrote:
>> syzbot reports a udf slab-out-of-bounds as blow:
>>
>> loop0: rw=0, sector=117, nr_sectors = 1 limit=0
>> syz-executor135: attempt to access beyond end of device
>> loop0: rw=0, sector=117, nr_sectors = 1 limit=0
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in udf_get_filelongad+0x167/0x1b0 fs/udf/directory.c:526
>> Read of size 4 at addr ffff888012113f30 by task syz-executor135/5106
>>
>> CPU: 0 UID: 0 PID: 5106 Comm: syz-executor135 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:93 [inline]
>>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>>  print_address_description mm/kasan/report.c:377 [inline]
>>  print_report+0x169/0x550 mm/kasan/report.c:488
>>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>>  udf_get_filelongad+0x167/0x1b0 fs/udf/directory.c:526
>>  udf_current_aext+0x435/0x9e0 fs/udf/inode.c:2235
>>  udf_next_aext+0x8c/0x4a0 fs/udf/inode.c:2171
>>  udf_extend_file fs/udf/inode.c:677 [inline]
>>  udf_setsize+0xa8a/0x1280 fs/udf/inode.c:1265
>>  udf_setattr+0x3c7/0x5d0 fs/udf/file.c:236
>>  notify_change+0xbca/0xe90 fs/attr.c:503
>>  do_truncate fs/open.c:65 [inline]
>>  do_ftruncate+0x46b/0x590 fs/open.c:181
>>  do_sys_ftruncate fs/open.c:199 [inline]
>>  __do_sys_ftruncate fs/open.c:207 [inline]
>>  __se_sys_ftruncate fs/open.c:205 [inline]
>>  __x64_sys_ftruncate+0x95/0xf0 fs/open.c:205
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f13639ac249
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fff0302d508 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f13639ac249
>> RDX: 00007f13639ac249 RSI: 0000008002007ffb RDI: 0000000000000005
>> RBP: 00000000000013f1 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff0302d550
>> R13: 00007fff0302d630 R14: 431bde82d7b634db R15: 00007f13639f501d
>>
>> The root cause is:
>>   udf_extend_file
>>     ->inode_bmap       --> etype == -1 and epos.bh == NULL
>>      -> udf_next_aext  --> return -1 because reading block failed
>>        -> sb_read --> return NULL because access beyond end of device
>>
>> Under this, etype == -1, epos.bh == NULL, epos.offset is 24, which is
>> less than sizeof(struct extentedFileEntry), aka 216. As a result,
>> it skipped the epos.bh check and goes into udf_next_aext(). Since the
>> epos.offset is illegal, udf_get_filelongad's first argument ptr,
>> 	ptr = iinfo->i_data + epos->offset -
>> 		udf_file_entry_alloc_offset(inode) +
>> 		iinfo->i_lenEAttr;
>> points to some buffer before iinfo->i_data, which triggeres KASAN's
>> warnning.
>>
>> The fix is to add addition check on etype, epos.bh and epos.offset,
>> when ftruncate accesses beyound end of device, just return EIO and failed.
>>
>> Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
>> Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
>> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> Thanks for the analysis and the patch! I agree this will fix the problem
> for the particular syzbot reproducer but I think a proper solution needs a
> bit more. I think we need udf_current_aext() and udf_next_aext() to
> differentiate between error and "hit EOF" - I think they can take pointer
> to etype to store the extent type and just return 0 on success, <0 on
> error. Then inode_bmap() can do the same and udf_extend_file() can properly
> detect errors and bail out without resorting to checking for particular
> offsets and assuming internal behavior of these functions. Will you be
> interested in looking into this?
>
> 								Honza
>
>
>> ---
>>  fs/udf/inode.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
>> index 4726a4d014b6..66f73f728dae 100644
>> --- a/fs/udf/inode.c
>> +++ b/fs/udf/inode.c
>> @@ -660,6 +660,16 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
>>  	udf_discard_prealloc(inode);
>>  
>>  	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
>> +
>> +	/*
>> +	 * when ftruncate attempt to access beyond end of device, sb_read will
>> +	 * fail with epos.bh be null and return etype be -1, just return EIO.
>> +	 */
>> +	if (etype == -1 && !epos.bh && epos.offset == sizeof(struct allocExtDesc)) {
>> +		err = -EIO;
>> +		goto out;
>> +	}
>> +
>>  	within_last_ext = (etype != -1);
>>  	/* We don't expect extents past EOF... */
>>  	WARN_ON_ONCE(within_last_ext &&
>> -- 
>> 2.43.0
>>
Thanks for the review!  You suggestion is great and I am glad to have a try.
ps: I am new on udf module, so this may takes some time, wishes finishing it ASAP.:)


