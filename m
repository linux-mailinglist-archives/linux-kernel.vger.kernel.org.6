Return-Path: <linux-kernel+bounces-260152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA593A3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4321C22E30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D715747A;
	Tue, 23 Jul 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kN81NMho"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293DB157490
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749461; cv=none; b=njN4VmkGsAHFvhlljs9uFSM4ARweY6w++YxesahIqDi3YWaMFd+8AkbIro1bR1UZUQ7MQ/6UOpg9XJO4kCmguNx6lB9P7zd55fs0je9wuZtOi7G6EG9vPPgPJD2BNfWVQCH6fE19lwbK45swtj68faeKXNl79mcoHrXtBTulNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749461; c=relaxed/simple;
	bh=3eT0Gfc/14vPUoa72UnAIh2nn5fg5CtRzqZF8RYE0Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkCXBy5kMLy2cbm9DCH0PIa6+0EowYm/TS0VXOUcOfi87WLvZQdV7YSCgqidCZKBA+n2SeyRBkmIB6P2nrOQq/LnWiYOxHUpBWExj/boQp0uNBOEeytOKhBLIv5sJwyRuKAG9IfwfQ8iwvUfSpOmlllsUbZ0l2ZWrijIO/WQhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kN81NMho; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721749457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kj4K3o8rgfDCBIGFPzvFnxTYJ7DeqVnEbJfP9Rg/3p4=;
	b=kN81NMhoRmlGyAmyKv6MPFGph515OOtn8gvG4f9PrGTzTA+sFAcErv618iJA4nDn5AEoK5
	WU+xoDzUr5oWDNl+yxy5Ch0jNm7ZUjt7JKguh6+191kyMnJUX2+b5VwdOqE3jpOMbrkRu6
	u15FHEhMS40UgW8IyCOZQ5GYPoJTRIE=
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
Subject: [PATCH 1/4] ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
Date: Tue, 23 Jul 2024 16:43:59 +0100
Message-ID: <20240723154402.21125-2-luis.henriques@linux.dev>
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

Function ext4_wait_for_tail_page_commit() assumes that '0' is not a valid
value for transaction IDs, which is incorrect.  Don't assume that and invoke
jbd2_log_wait_commit() if the journal had a committing transaction instead.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/inode.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..e65fc2086701 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5279,8 +5279,9 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 {
 	unsigned offset;
 	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
-	tid_t commit_tid = 0;
+	tid_t commit_tid;
 	int ret;
+	bool has_transaction = false;
 
 	offset = inode->i_size & (PAGE_SIZE - 1);
 	/*
@@ -5305,12 +5306,13 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 		folio_put(folio);
 		if (ret != -EBUSY)
 			return;
-		commit_tid = 0;
 		read_lock(&journal->j_state_lock);
-		if (journal->j_committing_transaction)
+		if (journal->j_committing_transaction) {
 			commit_tid = journal->j_committing_transaction->t_tid;
+			has_transaction = true;
+		}
 		read_unlock(&journal->j_state_lock);
-		if (commit_tid)
+		if (has_transaction)
 			jbd2_log_wait_commit(journal, commit_tid);
 	}
 }

