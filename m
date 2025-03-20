Return-Path: <linux-kernel+bounces-569050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0DA69E05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1F87AB9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92321C07F6;
	Thu, 20 Mar 2025 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+WWTFeN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4794A78F5B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436045; cv=none; b=Dew3DmcYKnMKAJaOsJEQF5xzqAJwyjEGvvW2g1qWY4sjs3TqPnYyJ/8OJPM6BZsVFCdGig7Z/hHfE1iWdWk5naZJgZNvG9l5HXGpjBlNeKClusX7Ut+O2CcETUOdUzRhFIDo7vXhIQ8DVHwkYf9HRfL1FZutXYv6RtNDgBL3MEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436045; c=relaxed/simple;
	bh=IyWLQJNb4caB49fLITzeK6ff7hq1wlhcM9Uptvq3X9A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MYne0epKUlGqqmTNSlO4ZYw/XDih3x+S9YGldB+8FvzwHtKhGnPylePnZmt/qSLc4XaPz6TF9gWrGJbJiwIu3xmeaADpLfJ+rfgqyJOtpkLxnR1vTFCaHHTVOxwP5FufTwoKTDNHfH1UGtF2aT76/JT3Teb54QOCoMxvmE5sCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+WWTFeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE14C4CEE4;
	Thu, 20 Mar 2025 02:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742436044;
	bh=IyWLQJNb4caB49fLITzeK6ff7hq1wlhcM9Uptvq3X9A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=T+WWTFeNBzex9wTJRHZYIrsxY/OSgrmmJElQeh9bL2bhNYIVjfQ1HBDb8yuOPTYkP
	 MKD4zgFOKznl8h9f5PFYY/o73lLEJjx0FDpjTjNkbF7qgJNCQs/9Ve2hn3ichOeNbj
	 XTvMUG9AnGs7+t/KaL/gYqHNVjfrtu7bI5sY6K1WjlMz0T+RhCiBRuim6nPTR+xzu4
	 PSaZlIUkZ7G0Ar0N7TLwqOVSkpSqCp1N6rgvfB+VPhWfuvtjfBVdo/oOhqqRQVi7EQ
	 f9v7zAnzlOmfFM628m6DWcA4vLg0GCIvPQbXCCMKfFOglWw/SG1hY6W7Nuv+eWF/kw
	 YC8E2jdOpe1Eg==
Message-ID: <df129d6e-d598-4bc3-b147-c305f949e5eb@kernel.org>
Date: Thu, 20 Mar 2025 10:00:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add a proc entry show inject stats
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20250319120046.1784103-1-chao@kernel.org>
 <CAHJ8P3LPtYsOH9yQzk4ozXT_=ufzSBe+FtzymH4TaNdavcF6jw@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LPtYsOH9yQzk4ozXT_=ufzSBe+FtzymH4TaNdavcF6jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/20/25 09:16, Zhiguo Niu wrote:
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2025年3月19日周三 23:38写道：
>>
>> This patch adds a proc entry named inject_stats to show total injected
>> count for each fault type.
>>
>> cat /proc/fs/f2fs/<dev>/inject_stats
>> fault_type              injected_count
>> kmalloc                 0
>> kvmalloc                0
>> page alloc              0
>> page get                0
>> alloc bio(obsolete)     0
>> alloc nid               0
>> orphan                  0
>> no more block           0
>> too big dir depth       0
>> evict_inode fail        0
>> truncate fail           0
>> read IO error           0
>> checkpoint error        0
>> discard error           0
>> write IO error          0
>> slab alloc              0
>> dquot initialize        0
>> lock_op                 0
>> invalid blkaddr         0
>> inconsistent blkaddr    0
>> no free segment         0
>> inconsistent footer     0
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/f2fs.h  |  3 +++
>>  fs/f2fs/super.c |  1 +
>>  fs/f2fs/sysfs.c | 18 ++++++++++++++++++
>>  3 files changed, 22 insertions(+)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index f1576dc6ec67..986ee5b9326d 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -73,6 +73,8 @@ struct f2fs_fault_info {
>>         atomic_t inject_ops;
>>         int inject_rate;
>>         unsigned int inject_type;
>> +       /* Used to account total count of injection for each type */
>> +       unsigned int inject_count[FAULT_MAX];
>>  };
>>
>>  extern const char *f2fs_fault_name[FAULT_MAX];
>> @@ -1902,6 +1904,7 @@ static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type,
>>         atomic_inc(&ffi->inject_ops);
>>         if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
>>                 atomic_set(&ffi->inject_ops, 0);
>> +               ffi->inject_count[type]++;
>>                 f2fs_info_ratelimited(sbi, "inject %s in %s of %pS",
>>                                 f2fs_fault_name[type], func, parent_func);
>>                 return true;
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index f087b2b71c89..dfe0604ab558 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -47,6 +47,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
>>         [FAULT_KVMALLOC]                = "kvmalloc",
>>         [FAULT_PAGE_ALLOC]              = "page alloc",
>>         [FAULT_PAGE_GET]                = "page get",
>> +       [FAULT_ALLOC_BIO]               = "alloc bio(obsolete)",
>>         [FAULT_ALLOC_NID]               = "alloc nid",
>>         [FAULT_ORPHAN]                  = "orphan",
>>         [FAULT_BLOCK]                   = "no more block",
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index c69161366467..e87e89d2c023 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -1679,6 +1679,22 @@ static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
>>         return 0;
>>  }
>>
>> +static int __maybe_unused inject_stats_seq_show(struct seq_file *seq,
>> +                                               void *offset)
>> +{
>> +       struct super_block *sb = seq->private;
>> +       struct f2fs_sb_info *sbi = F2FS_SB(sb);
>> +       struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
>> +       int i;
>> +
>> +       seq_puts(seq, "fault_type               injected_count\n");
>> +
>> +       for (i = 0; i < FAULT_MAX; i++)
>> +               seq_printf(seq, "%-24s%-10u\n", f2fs_fault_name[i],
>> +                                               ffi->inject_count[i]);
>> +       return 0;
>> +}
>> +
> Hi Chao,
> Here should we need to use #ifdef CONFIG_F2FS_FAULT_INJECTION to avoid
> build error when
> CONFIG_F2FS_FAULT_INJECTION is not enabled?

Zhiguo,

Yeah, you're right, let me fix this. Thank you!

Thanks,

> thanks！
>>  int __init f2fs_init_sysfs(void)
>>  {
>>         int ret;
>> @@ -1770,6 +1786,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>>                                 discard_plist_seq_show, sb);
>>         proc_create_single_data("disk_map", 0444, sbi->s_proc,
>>                                 disk_map_seq_show, sb);
>> +       proc_create_single_data("inject_stats", 0444, sbi->s_proc,
>> +                               inject_stats_seq_show, sb);
>>         return 0;
>>  put_feature_list_kobj:
>>         kobject_put(&sbi->s_feature_list_kobj);
>> --
>> 2.48.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


