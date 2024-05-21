Return-Path: <linux-kernel+bounces-185178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E238CB19B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C64B1F22461
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7299C1487ED;
	Tue, 21 May 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpiFqFJ4"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235E18036
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306347; cv=none; b=N64nmQPBT1wgUTsvc19XCg56QQtoc+W7L/tUnJM59V4TLCfHXGnqiO8j3pqHoO6ceg6EN5Qfqa2HFvBxIQVzQUq4VTpKWB1M/WDnTVIvK20m9jSts6py6glpJRmlmIEhz91NOttDgD23rv6z95ZdQii4bxZp2TK3lq8la/T/aN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306347; c=relaxed/simple;
	bh=zEAewd0WHCRD6ZIvbc+29IjNVR5duGnthNQq9uGxhvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZBLl1wqpkj+379RnxglAiCO8Nx4jKaIkfSxtkctJIMNfZ+IVYAuXX/vmW5CAuso/D04KE5WQWAHV0QdxAlLQOtMqTsyYWYz4orsC6i3W8jcoCdbX7QM76Xj66m1EnUo0Wt7uPa7TEhfbtnK918hSeuU4dzPeuaTKu3FPWqWdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpiFqFJ4; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: adilger@dilger.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716306342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsqhayekR/OGOZBD4jALsLmjWK5JaY20mUwZwJqidv0=;
	b=jpiFqFJ4H36nzY2+tVgQHTb6bad1hxmNle8Cn+2NNFnqipMUY99NgQFPIVoqXG5gaMrT5h
	bT+ikor75yvQ6OIKfWs9A0R4gbkuP0EO5EnPNofXf+zsYBqTNzerRjP16jQCZQzAvUnmW/
	/cbVRgiwufZYcryJyquLNkWWg63Xwes=
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tytso@mit.edu
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: jack@suse.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [RFC PATCH 1/2] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Tue, 21 May 2024 16:45:34 +0100
Message-ID: <20240521154535.12911-2-luis.henriques@linux.dev>
In-Reply-To: <20240521154535.12911-1-luis.henriques@linux.dev>
References: <20240521154535.12911-1-luis.henriques@linux.dev>
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

This patch fixes the issue by simply re-enqueuing the inode from the MAIN
into the STAGING queue.

This bug was found using fstest generic/047.  This test creates several 32k
bytes files, sync'ing each of them after it's creation, and then shutting
down the filesystem.  Some data may be loss in this operation; for example a
file may have it's size truncated to zero.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/fast_commit.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..337b5289cf11 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -396,12 +396,19 @@ static int ext4_fc_track_template(
 		return ret;
 
 	spin_lock(&sbi->s_fc_lock);
-	if (list_empty(&EXT4_I(inode)->i_fc_list))
-		list_add_tail(&EXT4_I(inode)->i_fc_list,
-				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
-				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
-				&sbi->s_fc_q[FC_Q_STAGING] :
-				&sbi->s_fc_q[FC_Q_MAIN]);
+	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
+	    sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
+		if (list_empty(&EXT4_I(inode)->i_fc_list))
+			list_add_tail(&EXT4_I(inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_STAGING]);
+		else
+			list_move_tail(&EXT4_I(inode)->i_fc_list,
+				       &sbi->s_fc_q[FC_Q_STAGING]);
+	} else {
+		if (list_empty(&EXT4_I(inode)->i_fc_list))
+			list_add_tail(&EXT4_I(inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_MAIN]);
+	}
 	spin_unlock(&sbi->s_fc_lock);
 
 	return ret;

