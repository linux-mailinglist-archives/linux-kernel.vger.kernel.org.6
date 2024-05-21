Return-Path: <linux-kernel+bounces-185177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97088CB199
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662081F2128D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C95147C99;
	Tue, 21 May 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FhBESG7+"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659518E1C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306346; cv=none; b=jDc9p/OVhHLTwg4zNVh565XzRTfZOG8ahKYOpd3Nb9pAQV/p+xB0w4ei7AToUyCOvSOpo3BNfpnlcDs7GicK5vpmI2zj7u6S558wv/ilH+7MXMEiJuRJd8ROMp28UouKb2txprN7L4pQrks2Nk1AFHBDGoTW1K5khO9axikTRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306346; c=relaxed/simple;
	bh=VCqHvca1+tEFlZyUswqtYOjRe1WSqx+94tESfnQNFpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaxSzR10EgDYJ7ufhnqTtF/CVKfTS9MpVmterDNvcLA2bpGnQc4b+La+IEOVI3cCnd5Fg7cOIE3rZbxO5i5+qDW2gQlENcniZTD8me8rm+NriaKwLRLm5/dY6B8OytqWtxPz1YSrnsGDSfvLgQcnxx07Aa6PD3BtUAdMcDTmTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FhBESG7+; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jack@suse.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716306342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jizdrh7qFsyQUbpJOd4DGt8jMXMJUYqkogii65S0bU=;
	b=FhBESG7+EvSkcBMvLFS1hqfsQkaVWwhDx7FtDWOQWAUowX6BNi3g2+zkuKIMy44VfI03fI
	TQ4RJTQk5QzB9h3385J9sEe24J5L8MgCY/DNnsj901cUtWRR9J0fURDEuId4HdzLY8HZ8s
	clY/Df20c/d777D/mM3JEKONHVCoYIg=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tytso@mit.edu
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: adilger@dilger.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [RFC PATCH 2/2] jbd2: reset fast commit offset only after fs cleanup is done
Date: Tue, 21 May 2024 16:45:35 +0100
Message-ID: <20240521154535.12911-3-luis.henriques@linux.dev>
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

When doing a journal commit, the fast journal offset (journal->j_fc_off) is
set to zero too early in the process.  Since ext4 filesystem calls function
jbd2_fc_release_bufs() in its j_fc_cleanup_callback (ext4_fc_cleanup()),
that call will be a no-op exactly because the offset is zero.

Move the fast commit offset further down in the journal commit code, until
it's mostly done, immediately before clearing the on-going commit flags.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/jbd2/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 75ea4e9a5cab..88b834c7c9c9 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -435,7 +435,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 			commit_transaction->t_tid);
 
 	write_lock(&journal->j_state_lock);
-	journal->j_fc_off = 0;
 	J_ASSERT(commit_transaction->t_state == T_RUNNING);
 	commit_transaction->t_state = T_LOCKED;
 
@@ -1133,6 +1132,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		  journal->j_commit_sequence, journal->j_tail_sequence);
 
 	write_lock(&journal->j_state_lock);
+	journal->j_fc_off = 0;
 	journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
 	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	spin_lock(&journal->j_list_lock);

