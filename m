Return-Path: <linux-kernel+bounces-260155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC21193A3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B0C284549
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F184157489;
	Tue, 23 Jul 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bE0rY3bE"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E71581EA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749470; cv=none; b=Xhc0zaZJzeOXmutbaMuhgaDHPQjo/D2Jw0EaEyzmMNBiNbdv3BUAmYXccINiNPYp3llxLpg8R+k6GZNPNBoyF2NeBPfScDpWfjHn4eC+Dm+5cWrkrxQKNHa9FmrK7kmjwyYTMW9YdV0OSFZ5459DlsTV7aU+mrICiMhMxcT88Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749470; c=relaxed/simple;
	bh=mC9XUkBEmBGvQ/1v65xdhYwMOgTCWbf0qM7hQ/txwzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sbx5WAYvoHtaJj3LwvGPFpztDXYYX36Pxn+gnepQ3veS2q632I7hAsqCRrDYFQ/MbhSv/z+n/znSUIPN8BueIjVj4btADA8e7FAa00Gvb5rc7NNHUEJlJJtvki/ZZMIhlABcTGeR2jt9h1SoZU4mRzs3LeTXQw/8ZvgjcfppSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bE0rY3bE; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721749467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLM9/Us9GCDfVvEc9yizXeEQrxaXeLzRCwS/pBXR42I=;
	b=bE0rY3bEQPbvprDH30aWtRSCx3PF2dIxxdkd9Rc5qdQgqiO95s2iSaQiKlpwKTJrdmil96
	zUag3JFIgATjM2j61KRDkRkDo/nh3erZlkjQ3LCcOBFMUWkFeFAyE1slhSE5NDB7ON6f8Q
	5Y9263u4h4EV7o5RFcnbiaoK7m5UUgA=
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
Subject: [PATCH 4/4] ext4: fix incorrect tid assumption in ext4_fc_mark_ineligible()
Date: Tue, 23 Jul 2024 16:44:02 +0100
Message-ID: <20240723154402.21125-5-luis.henriques@linux.dev>
In-Reply-To: <20240723154402.21125-1-luis.henriques@linux.dev>
References: <20240723154402.21125-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Function jbd2_journal_shrink_checkpoint_list() assumes that '0' is not a
valid value for transaction IDs, which is incorrect.

Furthermore, the sbi->s_fc_ineligible_tid handling also makes the same
assumption by being initialised to '0'.  Fortunately, the sb flag
EXT4_MF_FC_INELIGIBLE can be used to check whether sbi->s_fc_ineligible_tid
has been previously set instead of comparing it with '0'.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/fast_commit.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..3e0793cfea38 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -339,22 +339,29 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	tid_t tid;
+	bool has_transaction = true;
+	bool is_ineligible;
 
 	if (ext4_fc_disabled(sb))
 		return;
 
-	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	if (handle && !IS_ERR(handle))
 		tid = handle->h_transaction->t_tid;
 	else {
 		read_lock(&sbi->s_journal->j_state_lock);
-		tid = sbi->s_journal->j_running_transaction ?
-				sbi->s_journal->j_running_transaction->t_tid : 0;
+		if (sbi->s_journal->j_running_transaction)
+			tid = sbi->s_journal->j_running_transaction->t_tid;
+		else
+			has_transaction = false;
 		read_unlock(&sbi->s_journal->j_state_lock);
 	}
 	spin_lock(&sbi->s_fc_lock);
-	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
+	is_ineligible = ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
+	if (has_transaction &&
+	    ((!is_ineligible) ||
+	     (is_ineligible && tid_gt(tid, sbi->s_fc_ineligible_tid))))
 		sbi->s_fc_ineligible_tid = tid;
+	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	spin_unlock(&sbi->s_fc_lock);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
 	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;

