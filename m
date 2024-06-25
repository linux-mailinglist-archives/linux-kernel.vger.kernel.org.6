Return-Path: <linux-kernel+bounces-228385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37948915F20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AA81F2253D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48E146593;
	Tue, 25 Jun 2024 06:56:00 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364D143C67
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298560; cv=none; b=W4J1l9W7eLJgdnXs0hHotp5F0PSj9aVoJwEkXxc5G5WIn/dJPKwe36VeHG50qWiocK9XHzNWglClHr59x/U3aN5b/vxcJGXOZuT//zJ2a779RanQ9TgSKnpJDrP7TnGt+OGY9Oy6tgz9rrC4EgwrrtDtJS6vpj0Okima7+FMxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298560; c=relaxed/simple;
	bh=Mw7v8IPSnvlwJ/fCk6herWniYwKtXRsPaJ9V8iamQBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn2uvvShyVqqFO6WoVzBbjmxJ0ZKw9KrDtRHYQrXKdlDiqs/plUNnDpJbap6MhZSjXvZbdxua3IQLkeYFvwL/1XJ0q2PnK9tj6P1hQVFhwtEnrGyiP4sX4v1koI7tk+AMnfHeNMJfsf/czd7Q8sY7QHlH/psERxalrd0GZlEsRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4W7Zmc04ZFzYlPjR;
	Tue, 25 Jun 2024 14:34:08 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Tue, 25 Jun
 2024 14:36:11 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Tue, 25 Jun
 2024 14:36:11 +0800
From: wangzijie <wangzijie1@honor.com>
To: <chao@kernel.org>
CC: <bintian.wang@honor.com>, <jaegeuk@kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<wangzijie1@honor.com>, <zhiguo.niu@unisoc.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: reduce expensive checkpoint trigger frequency
Date: Tue, 25 Jun 2024 14:36:11 +0800
Message-ID: <20240625063611.816629-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <874174e3-79ba-452d-afff-615fe0bc8d0d@kernel.org>
References: <874174e3-79ba-452d-afff-615fe0bc8d0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)

>On 2024/6/25 10:14, wangzijie wrote:
>>> We may trigger high frequent checkpoint for below case:
>>> 1. mkdir /mnt/dir1; set dir1 encrypted
>>> 2. touch /mnt/file1; fsync /mnt/file1
>>> 3. mkdir /mnt/dir2; set dir2 encrypted
>>> 4. touch /mnt/file2; fsync /mnt/file2
>>> ...
>>>
>>> Although, newly created dir and file are not related, due to
>>> commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will
>>> trigger checkpoint whenever fsync() comes after a new encrypted dir
>>> created.
>>>
>>> In order to avoid such condition, let's record an entry including
>>> directory's ino into global cache when we initialize encryption policy
>>> in a checkpointed directory, and then only trigger checkpoint() when
>>> target file's parent has non-persisted encryption policy, for the case
>>> its parent is not checkpointed, need_do_checkpoint() has cover that
>>> by verifying it with f2fs_is_checkpointed_node().
>>>
>>> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> Reported-by: Yunlei He <heyunlei@hihonor.com>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>> v3:
>>> - Recently, Zhiguo Niu reported the same issue, so I repost this
>>> patch for comments.
>>>   fs/f2fs/f2fs.h              |  2 ++
>>>   fs/f2fs/file.c              |  3 +++
>>>   fs/f2fs/xattr.c             | 16 ++++++++++++++--
>>>   include/trace/events/f2fs.h |  3 ++-
>>>   4 files changed, 21 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index e2e0ca45f881..0094a8c85f4a 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -279,6 +279,7 @@ enum {
>>>   	APPEND_INO,		/* for append ino list */
>>>   	UPDATE_INO,		/* for update ino list */
>>>   	TRANS_DIR_INO,		/* for transactions dir ino list */
>>> +	ENC_DIR_INO,		/* for encrypted dir ino list */
>>>   	FLUSH_INO,		/* for multiple device flushing */
>>>   	MAX_INO_ENTRY,		/* max. list */
>>>   };
>>> @@ -1147,6 +1148,7 @@ enum cp_reason_type {
>>>   	CP_FASTBOOT_MODE,
>>>   	CP_SPEC_LOG_NUM,
>>>   	CP_RECOVER_DIR,
>>> +	CP_ENC_DIR,
>>>   };
>>>   
>>>   enum iostat_type {
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 8198afb5fb9c..18b33b1f0c83 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -218,6 +218,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>>>   		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>>>   							TRANS_DIR_INO))
>>>   		cp_reason = CP_RECOVER_DIR;
>>> +	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>>> +							ENC_DIR_INO))
>>> +		cp_reason = CP_ENC_DIR;
>>>   
>>>   	return cp_reason;
>>>   }
>>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>>> index f290fe9327c4..cbd1b88297fe 100644
>>> --- a/fs/f2fs/xattr.c
>>> +++ b/fs/f2fs/xattr.c
>>> @@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>>>   			const char *name, const void *value, size_t size,
>>>   			struct page *ipage, int flags)
>>>   {
>>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>   	struct f2fs_xattr_entry *here, *last;
>>>   	void *base_addr, *last_base_addr;
>>>   	int found, newsize;
>>> @@ -772,8 +773,19 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>>>   	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
>>>   			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
>>>   		f2fs_set_encrypted_inode(inode);
>>> -	if (S_ISDIR(inode->i_mode))
>>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
>>> +
>>> +	if (S_ISDIR(inode->i_mode)) {
>>> +		/*
>>> +		 * In restrict mode, fsync() always tries triggering checkpoint
>>> +		 * for all metadata consistency, in other mode, it only triggers
>>> +		 * checkpoint when parent's encryption metadata updates.
>>> +		 */
>>> +		if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
>>> +			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
>>> +		else if (IS_ENCRYPTED(inode) &&
>>> +			f2fs_is_checkpointed_node(sbi, inode->i_ino))
>>> +			f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
>>> +	}
>>>   
>>>   same:
>>>   	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
>>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>>> index 7ed0fc430dc6..48f2e399e184 100644
>>> --- a/include/trace/events/f2fs.h
>>> +++ b/include/trace/events/f2fs.h
>>> @@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
>>>   		{ CP_NODE_NEED_CP,	"node needs cp" },		\
>>>   		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
>>>   		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
>>> -		{ CP_RECOVER_DIR,	"dir needs recovery" })
>>> +		{ CP_RECOVER_DIR,	"dir needs recovery" },		\
>>> +		{ CP_ENC_DIR,		"persist encryption policy" })
>>>   
>>>   #define show_shutdown_mode(type)					\
>>>   	__print_symbolic(type,						\
>>> -- 
>>> 2.40.1
>> 
>> Hi, Chao
>> I noticed the discussion about patch v2, Jaegeuk mentioned no encryption case:
>> 1) parent is checkpointed
>> 2) set_xattr(dir) w/ new xnid
>> 3) create(file)
>> 4) fsync(file)
>> We will not trigger checkpoint() after this change.
>> So, how about adding a rule in need_do_checkpoint? We can judge if the parent has xnid
>> being checkpointed or not, if not we can still trigger checkpoint() and keep the same
>> behavior before this change.
>
>Hi wangzijie,
>
>It may cause performance overhead to get parent's xnid by parent ino,
>so I prefer to tag ENC_DIR_INO for the inode if its parent's xnid is
>not checkpointed, it that fine to you?
>
>Thanks,

Yes, I've also met this reported problem. Thank you for your reply.

