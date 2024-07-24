Return-Path: <linux-kernel+bounces-261244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7F93B4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8146FB22F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E74C15F330;
	Wed, 24 Jul 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IGhhzLeB"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471215EFB6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837507; cv=none; b=W8FUzKnX67ys8OoGXsgenQpQ+/+4sPYzZiqkXDd01nBfCVcLMs/i7jFauyk1SRUFi0UZvR/gu8pMB8mt7N1N23X7501KJpCruhQpcvs43uqQWdYlwGCVKjZpfzk24iLMWC+hHXf+iX7+JR+TmCh4t6w/Ls5GUFhDoAsMNnSiu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837507; c=relaxed/simple;
	bh=2GrkRhx6WfzVuCpgridw5t0qCBlsL72XRCyejH/kB7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4VlkX7RWY5vIKvAtOCp/8VcgpGbONl2yxSWAwGem/822+WPUJAb+ZYN01s7EgAd5j0NG9eqYIlyfJHx2tHm5amh49QXT0HebzNZxMvTJpL6c64IsDVEKstUa1+PAPd4qFROVBhSDOfe3IfmQ6qZUU86GiSbz9NtaDQm8MlgFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IGhhzLeB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721837503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BDPm85vZLWwDNWMf6v7cx0P2QLlbAt6JaKMTa1F2O0=;
	b=IGhhzLeBZCT/nVsThapj9kAOFP2QUqLbbx4gYl8DoHfLvwpTopCySdpFuFp1Aew7UOH8ZZ
	yw8pQ9DsZ61AHJW2mK4nn/97L8x/v+oDYUWyY8XJ8huECHtkJ91259LO4agsMiSmcXkh3D
	p5adugCc/mRQ6uHoGahaw5wD0N5cUgo=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 4/4] ext4: fix incorrect tid assumption in ext4_fc_mark_ineligible()
Date: Wed, 24 Jul 2024 17:11:18 +0100
Message-ID: <20240724161119.13448-5-luis.henriques@linux.dev>
In-Reply-To: <20240724161119.13448-1-luis.henriques@linux.dev>
References: <20240724161119.13448-1-luis.henriques@linux.dev>
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..6f4c97bdb2d8 100644
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
+	    (!is_ineligible ||
+	     (is_ineligible && tid_gt(tid, sbi->s_fc_ineligible_tid))))
 		sbi->s_fc_ineligible_tid = tid;
+	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	spin_unlock(&sbi->s_fc_lock);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
 	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;

