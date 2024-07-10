Return-Path: <linux-kernel+bounces-247423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F7B92CF51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278FB1F218C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E7919248D;
	Wed, 10 Jul 2024 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tTXOGWaZ"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1018FC62
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607558; cv=none; b=FKlZlEmmYpqmO7VvXFGlFEdJfjEMt5SjNyr1IH5HrXpK0CqzUc4KCdLlArQfqjJE4gfmg+ah94fD/eYYpbE6F2gWt7fuixvy/uNtYAoL2AJHloVF/jkLtk5oDr5UaKE1k+4z3mdxPr+RY4CwKN962e5tEaA3U5BGnscbEyDyclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607558; c=relaxed/simple;
	bh=zNypG+r5+gLMdO4RKsYS8V9W8oiyk45RElwRH893UTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1DwYVC3CciJW2IdmtGRO6XpM9UCEmrYy8aLtvcuqXftSFHtcz42Nhgz9K5WTvMqHR79bOYxVD5vdst58u3yLOY8Vzov1/kQ8wBb44y8o8VsRAYE+6BgYW151JcKwOS+NZXN7dHrSC0CXEpxELVYQKQtbexpBD2PkBbi94uzv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tTXOGWaZ; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720607553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSEnUFPjapuSjePp2fpwABu+h70moQNK81dxmI54eXE=;
	b=tTXOGWaZb43uR2IeiH4xIZ037YKrJ9CMaqsjSOWTKoOuzy26OSR+nPL+OmyhqGCLt0WNE0
	qDhwnOtwilaFPtP/JKAVf+RGjVsX3M6m4TaQTu83ChXYkssdUoQifRJjeHK2ItTE/cIYIo
	dtnMadV9e4DqQMKATy5ROd7N/z8PLWI=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>,  Jan Kara <jack@suse.cz>,  Harshad
 Shirwadkar <harshadshirwadkar@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: fix fast commit inode enqueueing during a
 full journal commit
In-Reply-To: <877cdusk75.fsf@brahms.olymp> (Luis Henriques's message of "Tue,
	09 Jul 2024 15:39:58 +0100")
References: <20240529092030.9557-1-luis.henriques@linux.dev>
	<20240529092030.9557-2-luis.henriques@linux.dev>
	<20240709035911.GB10452@mit.edu> <877cdusk75.fsf@brahms.olymp>
Date: Wed, 10 Jul 2024 11:32:21 +0100
Message-ID: <87y169a66i.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 09 2024, Luis Henriques wrote:

> On Mon, Jul 08 2024, Theodore Ts'o wrote:
>
>> On Wed, May 29, 2024 at 10:20:29AM +0100, Luis Henriques (SUSE) wrote:
>>> When a full journal commit is on-going, any fast commit has to be enque=
ued
>>> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueu=
eing
>>> is done only once, i.e. if an inode is already queued in a previous fast
>>> commit entry it won't be enqueued again.  However, if a full commit sta=
rts
>>> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit need=
s to
>>> be done into FC_Q_STAGING.  And this is not being done in function
>>> ext4_fc_track_template().
>>>=20
>>> This patch fixes the issue by re-enqueuing an inode into the STAGING qu=
eue
>>> during the fast commit clean-up callback if it has a tid (i_sync_tid)
>>> greater than the one being handled.  The STAGING queue will then be spl=
iced
>>> back into MAIN.
>>>=20
>>> This bug was found using fstest generic/047.  This test creates several=
 32k
>>> bytes files, sync'ing each of them after it's creation, and then shutti=
ng
>>> down the filesystem.  Some data may be loss in this operation; for exam=
ple a
>>> file may have it's size truncated to zero.
>>>=20
>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>
>> This patch is causing a regression for the test generic/472
>> generic/496 generic/643 if fast_commit is enabled.  So using the
>> ext4/adv or ext4/fast_commit configuration, e.g:
>>
>> % kvm-xfstests  -c ext4/fast_commit  generic/472 generic/496 generic/643
>>
>> For all of these test, the failures seem to involve the swapon command
>> erroring out:
>>
>>     --- tests/generic/496.out   2024-06-13 18:57:39.000000000 -0400
>>     +++ /results/ext4/results-fast_commit/generic/496.out.bad   2024-07-=
08 23:46:39.720
>>     @@ -1,3 +1,4 @@
>>      QA output created by 496
>>      fallocate swap
>>      mixed swap
>>     +swapon: Invalid argument
>>     ...
>>
>> but it's unclear why this patch would affect swapon.
>
> OK, that's... embarrassing.  I should have caught these failures :-(
>
>> I've never been able to see generic/047 failure in any of my ext4/dev
>> testing, nor in any of my daily fs-next CI testing.  So for that
>> reason, I'm going to drop this patch from my tree.
>
> There's nothing special about my test environment.  I can reproduce the
> generic/047 failure (although not 100% of the times) by running it
> manually in a virtme-ng test environment, using MKFS_OPTIONS=3D"-O fast_c=
ommit".
> Here's what I see when running it:
>
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 virtme-ng 6.10.0-rc7+ #269 SMP PREEMPT_DYNA=
MIC Tue Jul  9 14:24:22 WEST 2024
> MKFS_OPTIONS  -- -F -O fast_commit /dev/vdb1
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdb1 /tmp/mnt/scratch
>
> generic/047 162s ... - output mismatch (see [...]/testing/xfstests-dev/re=
sults//generic/047.out.bad)
>     --- tests/generic/047.out   2021-01-11 12:08:14.972458324 +0000
>     +++ [...]/testing/xfstests-dev/results//generic/047.out.bad   2024-07=
-09 14:28:36.626435948 +0100
>     @@ -1 +1,2 @@
>      QA output created by 047
>     +file /tmp/mnt/scratch/944 has incorrect size - fsync failed
>     ...
>     (Run 'diff -u [...]/testing/xfstests-dev/tests/generic/047.out [...]/=
testing/xfstests-dev/results//generic/047.out.bad'  to see the entire diff)
> Ran: generic/047
> Failures: generic/047
> Failed 1 of 1 tests
>
>> The second patch in this series appears to be independent at least
>> from a logical perspective --- although a minor change is needed to
>> resolve a merge conflict after dropping this change.
>>
>> Luis, Harshad, could you look in this failure and then resubmit once
>> it's been fixed?  Thanks!!  Also, Luis, can you give more details
>> about the generic/047 failure that you had seen?  Is it one of those
>> flaky tests where you need to run the test dozens or hundreds of time
>> to see the failure?
>
>
> So, I've done some quick tests, but I'll need some more time to dig into
> it.  And this is what I _think_ it's happening:
>
> When activating a swap file, the kernel forces an fsync, calling
> ext4_sync_file() which will then call ext4_fc_commit() and, eventually,
> the ext4_fc_cleanup().
>
> With this patch an inode may be re-enqueued into the STAGING queue and
> then spliced back into MAIN; and that's exactly what I see happening.
>
> Later, still on the swap activation path, ext4_set_iomap() will be called
> and will do this:
>
> 	if (ext4_inode_datasync_dirty(inode) ||
> 	    offset + length > i_size_read(inode))
> 		iomap->flags |=3D IOMAP_F_DIRTY;
>
> 'ext4_inode_datasync_dirty()' will be true because '->i_fc_list' is not
> empty.  And that's why the swapoff will fail.
>
> Anyway, I'll try to figure out what's missing here (or what's wrong with
> my patch).

I believe I found the issue with the patch.  The ext4_fc_cleanup()
callback can be invoked in three different situations:

1) when there's a full commit
2) when there's a fc commit but with fallback to full commit
3) when there's a fc commit

For both 1) and 2) the cleanup callback will get a real 'tid' value;
however, for the regular fc commit 3) the 'tid' will be 0.  And for those
cases the inode should not be enqueued back in enqueued into STAGING.  See
below an updated diff with this fix.

Does this make sense?  I'll run a few more tests before sending a v4.

Cheers
--=20
Lu=C3=ADs

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..86d33741452a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1282,8 +1282,17 @@ static void ext4_fc_cleanup(journal_t *journal, int =
full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		if (iter->i_sync_tid <=3D tid)
+		if (iter->i_sync_tid <=3D tid) {
 			ext4_fc_reset_inode(&iter->vfs_inode);
+		} else if (tid) {
+			/*
+			 * re-enqueue inode into STAGING, which later will be
+			 * splice back into MAIN
+			 */
+			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_STAGING]);
+		}
+
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
 #if (BITS_PER_LONG < 64)

