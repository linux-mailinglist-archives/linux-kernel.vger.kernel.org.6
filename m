Return-Path: <linux-kernel+bounces-246692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FB592C53B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAC8282BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D418563B;
	Tue,  9 Jul 2024 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiIMBd+J"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC83153505
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560104; cv=none; b=HSoUNqEa9ag+sgok7r2hpDwoK8xcjdlmj/r9p2ucYQFj+qsijhCB5k3wYzTJbfpnJT9WpjJdkO3yRyrtR1kAOA8lxHKKqlc0VozuY2tgjiD79rMnljd530w2y9nHh0tR1u11WOY5yDW6QWe5ftdfe+pcZX1F7rDWMWYhUzPv1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560104; c=relaxed/simple;
	bh=KQfK54Bg7KMGAfENXtcbbEG1E1YcGN7n7bX83wXkiv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=od3t5j+Sohn8qSxtIemKeeHY1xkYZtyy8FQfhykPi9U0v0mGMrgWAny6w+l9qbh9UU8UEWdubSJMHdXZHgcz/xY/3PcHceXpzzX2NmAqAnqLtuJnsSF3t96K8O+x2al1BPma4JghEWYJ0qLtVoaPPZXZkiOvuGZMz0c2XkJtMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiIMBd+J; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-70df2135426so2922091a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560103; x=1721164903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p8+OUwz6P3bJPyRQdZ3BvD+pGPe37Xw3SqFN/IyBjo=;
        b=eiIMBd+JDXXTahABgyZGk/CQXb5niATw21BujFui2T+yQ7dAl0jldCwNKkkVnoBCXM
         M2Qq+SyQhfTTnzb9XLJcq7xgQ5RhR2wYlJNd6FctWnfChuRIhqztdRIpn8sIVyLqr25v
         OIgvovXH5xxZKEsimV10KsoUEtP4u29bXCgckiOo/ssXLWWMG5TLcpu5Xidp9TQMjRRz
         oEzNIQB1Att9XnlzAC1RmqDRrrFN3C06+3DfNy2ddwD5di7CQoCPNAbaSTTVrrTyCgDl
         XgHa3suqosAOtMNNIgEWGfatpESR2E5gIfQzLEY/fKWRa14oPk1oq4FCkjq1NcScXiiG
         EsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560103; x=1721164903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6p8+OUwz6P3bJPyRQdZ3BvD+pGPe37Xw3SqFN/IyBjo=;
        b=e4PQcN0dqLYWFx2HLVAo9bo9LfLrLAXCMhQoCdtI8NkmkB9i9/KW1NjQiuv/mJ9jym
         BjB6BLJR9SOwuyX3Yu35aqdOUZXTQXsgCoivfxTbKRhe9BBPgU7ZfURVEldC+ycjvlb2
         HXoLkKQR52bC7wFvHEDELFcZAoZZVhQ3QszUO0Q9BA9KV3zrg9eeuqmgvuJMqZTGoFXS
         6g37SOEd1izvsjccqew0V60Abzwjmu0nAVA3Vuc9yV1xv3wZHVi/LEsKXwMnTw+onoZ9
         2zv+e2VLEAkHG2Gu2WGPokmjFJwyq9dzPWp3kkKnbdSceMi+2w5pyP6q2Tz9gN8tei18
         frVQ==
X-Gm-Message-State: AOJu0YxP6dxBt05jaclvUHayrp43N4RIMNL9aDWOacATLtBSD8PlXwVZ
	OU0n+2qqZ6PI4rBbQy7jsLA8VLOgv19C1NTgI5nnKxE/m1S8zgKk
X-Google-Smtp-Source: AGHT+IHmS38Jx3lgdcwpDEtkchRrYteHZrn8U0487NXcKkwsQNHItnHBjF/k9gE5ZWhryH84Qdzorw==
X-Received: by 2002:a05:6a20:734b:b0:1be:caf6:66e5 with SMTP id adf61e73a8af0-1c29820d407mr4183360637.6.1720560102710;
        Tue, 09 Jul 2024 14:21:42 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c6217sm2305763b3a.48.2024.07.09.14.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:21:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	righi.andrea@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] sched: Move struct balance_callback definition upward
Date: Tue,  9 Jul 2024 11:21:07 -1000
Message-ID: <20240709212137.1199269-2-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709212137.1199269-1-tj@kernel.org>
References: <20240709212137.1199269-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move struct balance_callback definition upward so that it's visible to
class-specific rq struct definitions. This will be used to embed a struct
balance_callback in struct scx_rq.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/sched.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04184e87ba7c..86314a17f1c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -615,6 +615,11 @@ do {									\
 # define u64_u32_load(var)		u64_u32_load_copy(var, var##_copy)
 # define u64_u32_store(var, val)	u64_u32_store_copy(var, var##_copy, val)
 
+struct balance_callback {
+	struct balance_callback *next;
+	void (*func)(struct rq *rq);
+};
+
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
@@ -1054,11 +1059,6 @@ struct uclamp_rq {
 DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
-struct balance_callback {
-	struct balance_callback *next;
-	void (*func)(struct rq *rq);
-};
-
 /*
  * This is the main, per-CPU runqueue data structure.
  *
-- 
2.45.2


