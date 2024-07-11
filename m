Return-Path: <linux-kernel+bounces-249420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AA092EB74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3611F2301C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C0D16C846;
	Thu, 11 Jul 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MjJqPRfD"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9B16C6B4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710993; cv=none; b=Hm2ny/SBb9I+RCM+Gxqag/C43ude0ULALSqYRQP2JQE1WfmquJzihN2R3rLu4oN4zSkaxldhR+2W16ecml3DWha4r1AV5Xy+6qaX2MSn41qDepBxiV7sy+ouZXjqzKsnQ01s3ZqxnpQz+MOmqkf5My9NeY9+/x18neAz46xfcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710993; c=relaxed/simple;
	bh=LhJTv7sa2bew21QBfznrhV4rLeCwa7ZUuHSlsJK/oNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7F259vUPe5ApEb0seq5jX+OPmVpJIEbIvI/z5GXs1igcFglSl39MccZNKNWYi0k+P8C5gchIG+isFPKk2HH1oJILvkq0YYg4n47I6Frb2NhqSORrkdFzuAcovXiOfWIq/UZtQh5Muh7sxgJDhum8NmWe3UxiHQUUZbqmDoKh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MjJqPRfD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: wangjianjian3@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720710988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+hPdFzcJCaGClxKYXlJ8xqqt+mdGgJQ+c9tW+0Y7B4=;
	b=MjJqPRfDmpL6dWEBGgoI8FYSUXqvp2i05xN3cVTQ63yzHtl9HFJtRKQiOWRiEHP0e4aBp1
	D8rbutJr2wSTMMTPyfuaqisMGQKrwrgVHK9wmqbULXWHAtgnCLidAmZKShMQfruMU8AWk1
	++Usjs9KV+1Tc1wn7kIP6Fd/FuQbr/Q=
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,  Jan
 Kara <jack@suse.cz>,  Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
  <linux-ext4@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] ext4: fix fast commit inode enqueueing during a full
 journal commit
In-Reply-To: <4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com> (wangjianjian's
	message of "Thu, 11 Jul 2024 21:32:55 +0800")
References: <20240711083520.6751-1-luis.henriques@linux.dev>
	<4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
Date: Thu, 11 Jul 2024 16:16:18 +0100
Message-ID: <878qy8nem5.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 11 2024, wangjianjian (C) wrote:

> On 2024/7/11 16:35, Luis Henriques (SUSE) wrote:
>> When a full journal commit is on-going, any fast commit has to be enqueu=
ed
>> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueue=
ing
>> is done only once, i.e. if an inode is already queued in a previous fast
>> commit entry it won't be enqueued again.  However, if a full commit star=
ts
>> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs=
 to
>> be done into FC_Q_STAGING.  And this is not being done in function
>> ext4_fc_track_template().
>> This patch fixes the issue by re-enqueuing an inode into the STAGING que=
ue
>> during the fast commit clean-up callback if it has a tid (i_sync_tid)
>> greater than the one being handled.  The STAGING queue will then be spli=
ced
>> back into MAIN.
>> This bug was found using fstest generic/047.  This test creates several =
32k
>> bytes files, sync'ing each of them after it's creation, and then shutting
>> down the filesystem.  Some data may be loss in this operation; for examp=
le a
>> file may have it's size truncated to zero.
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>> Hi!
>> v4 of this patch enqueues the inode into STAGING *only* if the current t=
id
>> is non-zero.  It will be zero when doing an fc commit, and this would me=
an
>> to always re-enqueue the inode.  This fixes the regressions caught by Ted
>> in v3 with fstests generic/472 generic/496 generic/643.
>> Also, since 2nd patch of v3 has already been merged, I've rebased this p=
atch
>> to be applied on top of it.
>>   fs/ext4/fast_commit.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>> index 3926a05eceee..facbc8dbbaa2 100644
>> --- a/fs/ext4/fast_commit.c
>> +++ b/fs/ext4/fast_commit.c
>> @@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t *journal, i=
nt full, tid_t tid)
>>   				       EXT4_STATE_FC_COMMITTING);
>>   		if (tid_geq(tid, iter->i_sync_tid))
>>   			ext4_fc_reset_inode(&iter->vfs_inode);
>> +		} else if (tid) {
>> +			/*
>> +			 * If the tid is valid (i.e. non-zero) re-enqueue the
> one quick question about tid, if one disk is using long time and its tid =
  get
> wrapped to 0, is it a valid seq? I don't find code handling this situatio=
n.

Hmm... OK.  So, to answer to your question, the 'tid' is expected to wrap.
That's why we use:

	if (tid_geq(tid, iter->i_sync_tid))

instead of:

	if (tid >=3D iter->i_sync_tid)

(The second patch in v3 actually fixed a few places where the tid_*()
helpers weren't being used.)

But your question shows me that my patch is wrong as '0' may actually be a
valid 'tid' value.

Cheers,
--=20
Lu=C3=ADs

>> +			 * inode into STAGING, which will then be splice back
>> +			 * into MAIN
>> +			 */
>> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
>> +				      &sbi->s_fc_q[FC_Q_STAGING]);
>> +		}
>> +
>>   		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
>>   		smp_mb();
>>   #if (BITS_PER_LONG < 64)
>>=20
> --=20
> Regards
>


