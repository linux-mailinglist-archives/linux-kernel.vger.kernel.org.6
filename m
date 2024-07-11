Return-Path: <linux-kernel+bounces-248835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F53E92E284
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDCD289FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0E155325;
	Thu, 11 Jul 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HDcbounX"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADE84DFF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686934; cv=none; b=mA485MW/1XuhcweYd5qITA8NRXfJFu7hlVDUc9NXjhqOq/Wr36BagC5CJ3z4v5QIpyZxNMhvtAHpZZCIS+c1BO860AsIN/vRLzFJt0mNHXDKvEPe4H7/aYTlhmx7Tj/A98UMvTQOlGI6fXXrBfd/tDzKKt7Rq4OcULROnS8vVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686934; c=relaxed/simple;
	bh=9WaGRIRa+CuZVB3aj959sFu6enuiqwvP41svFu0Wzlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLculluGiLezt33KOuSz+k5XwZtAL6QRTydzmtHmROQlk8JL/qhewtZhL2JLUQOeIEi03ixsNiqeMnKJ9507nPEQxtEomLGFzseRM69zr9eC7khRcX+V7y8yJ4Fu12hRBQz/yNufYH2lUTfrIH0ANHjYTZNdqU8HCs4V1GR5JGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HDcbounX; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720686929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xav/vnLrQtAUlJK7pKq3AAhH8e2fERWCjHvfS/fkmdA=;
	b=HDcbounXUexQMgdMw/uq3GC6NqsRgDa2QzCpg43UINoZ06oDSwR5203aYdbY/ODIniixyj
	GBiyRXJrPg5r03vR+NB8v6nsyepv1LK2tMiu7xQ6SWhe/zfHuqeo21V3m0U3/QPZWy4tNW
	qLIViWIS6zUH6/PoocenosDVGGxFBPM=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v4] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Thu, 11 Jul 2024 09:35:20 +0100
Message-ID: <20240711083520.6751-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a full journal commit is on-going, any fast commit has to be enqueued
into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
is done only once, i.e. if an inode is already queued in a previous fast
commit entry it won't be enqueued again.  However, if a full commit starts
_after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
be done into FC_Q_STAGING.  And this is not being done in function
ext4_fc_track_template().

This patch fixes the issue by re-enqueuing an inode into the STAGING queue
during the fast commit clean-up callback if it has a tid (i_sync_tid)
greater than the one being handled.  The STAGING queue will then be spliced
back into MAIN.

This bug was found using fstest generic/047.  This test creates several 32k
bytes files, sync'ing each of them after it's creation, and then shutting
down the filesystem.  Some data may be loss in this operation; for example a
file may have it's size truncated to zero.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
Hi!

v4 of this patch enqueues the inode into STAGING *only* if the current tid
is non-zero.  It will be zero when doing an fc commit, and this would mean
to always re-enqueue the inode.  This fixes the regressions caught by Ted
in v3 with fstests generic/472 generic/496 generic/643.

Also, since 2nd patch of v3 has already been merged, I've rebased this patch
to be applied on top of it.

 fs/ext4/fast_commit.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..facbc8dbbaa2 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 				       EXT4_STATE_FC_COMMITTING);
 		if (tid_geq(tid, iter->i_sync_tid))
 			ext4_fc_reset_inode(&iter->vfs_inode);
+		} else if (tid) {
+			/*
+			 * If the tid is valid (i.e. non-zero) re-enqueue the
+			 * inode into STAGING, which will then be splice back
+			 * into MAIN
+			 */
+			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_STAGING]);
+		}
+
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
 #if (BITS_PER_LONG < 64)

