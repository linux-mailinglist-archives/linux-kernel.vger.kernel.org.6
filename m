Return-Path: <linux-kernel+bounces-250489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE592F86A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAC0B22289
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07841494BC;
	Fri, 12 Jul 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XPrGjomU"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F791459E3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778000; cv=none; b=uY9xeUIGlevTjCJ6Mt1Bdq2cFu/Ljhbp2fAJ8UuVPbijKVCdcDDEnQ2Yo3UasusgqCfnpxhbZ0ZsnzaRjI3DWKm0uoT4Njl9whnIsJ6EHPGhNG9HtZFgcxaAnal0KJy1K+dLtANMrsO7f8YwGqtqio85xDo4Ve+dmeEhUP80ymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778000; c=relaxed/simple;
	bh=fGqiR3p2twEgtGIGqX8CX2k7VlpahxZtzaoWMggY8kw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UjZTkYH4H41GwI45dWs5aevNmm7lADivGTUWQVbijNaketTjYZqN9q3W7GjLXyS5U1+8dXmmdvOZlnb5yN6B93UO3je3d0ymBBx7rFnqcJ14UYA53CTOHWXzGPfWo9wRw/6jxxrf2R0FfUA6QzdVtLKf4V3yDjlU/MqJM4iZnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XPrGjomU; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: adilger@dilger.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720777994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=420HDkg/RbN0mlADGGoKNBBDxwvgvCBrqnNYOxwbTVc=;
	b=XPrGjomUdpQXr8zzgWOyfZg9XSmmiI8C7K193g3xRpQJmNn0jFmIfRAQVwf+/srxGfZ5D5
	UcopNtbfhdANN/+cvHNdZQZJWGjY95hpE46Smx6mO3v2Ra6SCHcNSGRrCbrKEaQrhMRRdg
	L1LDZD5DwGQZVTwLA6vLAF4dGTyWd6U=
X-Envelope-To: wangjianjian0@foxmail.com
X-Envelope-To: wangjianjian3@huawei.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Cc:  Wang Jianjian <wangjianjian0@foxmail.com>,  "wangjianjian (C)"
 <wangjianjian3@huawei.com>,  Theodore Ts'o <tytso@mit.edu>,  Jan Kara
 <jack@suse.cz>,  Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: [RFC PATCH] jbd2: make '0' an invalid transaction sequence
In-Reply-To: <87ed7znf8n.fsf@linux.dev> (Luis Henriques's message of "Fri, 12
	Jul 2024 10:15:04 +0100")
References: <20240711083520.6751-1-luis.henriques@linux.dev>
	<4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
	<878qy8nem5.fsf@brahms.olymp>
	<tencent_CF3DC37BEB2026CB2F68408A2B62314E0C08@qq.com>
	<A90C7898-B704-4B2A-BFE6-4A32050763F0@dilger.ca>
	<87ed7znf8n.fsf@linux.dev>
Date: Fri, 12 Jul 2024 10:53:02 +0100
Message-ID: <87wmlrkkch.fsf_-_@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Since there's code (in fast-commit) that already handles a '0' tid as a
special case, it's better to ensure that jbd2 never sets it to that value
when journal->j_transaction_sequence increment wraps.

Suggested-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/jbd2/transaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 66513c18ca29..4dbdd37349c3 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -84,6 +84,8 @@ static void jbd2_get_transaction(journal_t *journal,
 	transaction->t_state = T_RUNNING;
 	transaction->t_start_time = ktime_get();
 	transaction->t_tid = journal->j_transaction_sequence++;
+	if (unlikely(transaction->t_tid == 0))
+		transaction->t_tid = journal->j_transaction_sequence++;
 	transaction->t_expires = jiffies + journal->j_commit_interval;
 	atomic_set(&transaction->t_updates, 0);
 	atomic_set(&transaction->t_outstanding_credits,

