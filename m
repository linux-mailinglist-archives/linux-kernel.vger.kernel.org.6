Return-Path: <linux-kernel+bounces-261242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080693B49B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07BA1F21485
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72515ECEC;
	Wed, 24 Jul 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cY3YlNw9"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973A15CD64
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837501; cv=none; b=SB47bCmeFHvkd0fTx8VbaTTa91rWHcyUXJtGwp3xlTavV2/BKeWypW6aiLR88umPouuY1RYEXHpTWhh5PO0wznQQyN22BVYuY8GFCHXReVC6H2Wy54wD47xKb7DLb6BssDFT2JKafuM6wgE8diS9SKIvgn7pA+llRSFalPVkLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837501; c=relaxed/simple;
	bh=XNU5/E4zdzC94Iu4FvOqTnR4trcc+NhY6NVcKsOyMss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGnFptSe8kKnGmI9YWgm3mj2NY1DOYqZuJaSx7F/0Zk2qlPhkzve98FRmOL7onueIQxVtW+uMzAS/SqGwIJCLlm/Gpy8DlHdN2RqGaDCLqreSIZ0GaIHL8cUr+OAwN1r0RrceEhvvjbKoAEmbe99BaOJCSlOivtEZdrISQOOnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cY3YlNw9; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721837497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZmav71urZq/ZgwyknRPqraCbvKvJwCQ9JJcFnXkdgg=;
	b=cY3YlNw9/9Fcrc4naM7we1Zt9llXu0RP1S9VrADP9lr+oei0a2o3ygQ9l4am2/2V6jQOt9
	o2em28p37RUbybri4xyMUbEPbkt8i6BOnW6H/ZM7JSMzUNN+mjQvHY2D+9qqWThzVBREjK
	Nl13yijOY+5ButHmdl7lKJK/RlPApFY=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 2/4] ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
Date: Wed, 24 Jul 2024 17:11:16 +0100
Message-ID: <20240724161119.13448-3-luis.henriques@linux.dev>
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

Function __jbd2_log_wait_for_space() assumes that '0' is not a valid value
for transaction IDs, which is incorrect.  Don't assume that and invoke
jbd2_log_wait_commit() if the journal had a committing transaction instead.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 951f78634adf..77bc522e6821 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -79,9 +79,12 @@ __releases(&journal->j_state_lock)
 		if (space_left < nblocks) {
 			int chkpt = journal->j_checkpoint_transactions != NULL;
 			tid_t tid = 0;
+			bool has_transaction = false;
 
-			if (journal->j_committing_transaction)
+			if (journal->j_committing_transaction) {
 				tid = journal->j_committing_transaction->t_tid;
+				has_transaction = true;
+			}
 			spin_unlock(&journal->j_list_lock);
 			write_unlock(&journal->j_state_lock);
 			if (chkpt) {
@@ -89,7 +92,7 @@ __releases(&journal->j_state_lock)
 			} else if (jbd2_cleanup_journal_tail(journal) == 0) {
 				/* We were able to recover space; yay! */
 				;
-			} else if (tid) {
+			} else if (has_transaction) {
 				/*
 				 * jbd2_journal_commit_transaction() may want
 				 * to take the checkpoint_mutex if JBD2_FLUSHED

