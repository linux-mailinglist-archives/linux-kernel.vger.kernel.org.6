Return-Path: <linux-kernel+bounces-246684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE56692C52C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE9A1F22D16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9B6187862;
	Tue,  9 Jul 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxztfWph"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6AF185637
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559412; cv=none; b=oM3AJS5GU45wXEBYSj+qRmSvHMqro5bsh6ho/tSgzIUwbB4Vy8xQHvyhHFWanFfSSlcBhN3fxNsA25E2i7i/93m9dMbm//ft7VgSbXe6pcD5aXG0Vcsh0qVzO0k1eS2eOFtgnvpR9QUL2+GiqghT6mB3wZf1/8ehANHAd5OeGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559412; c=relaxed/simple;
	bh=9bENMZby6l85ThHwdXqT4/M6rVTNwOP2nEEwRxQl2Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAbhgNqu7xB17H21x7eD5xHZCM6Ok7B5U3DK/GZMPw6e4ky2aOkcwor0O4BGXkPsEZzOegEYAsgg4h6tnwZP2fb9xGE//GSuO/GBzHCB0GLariKRsnyDzVzd/8Uip/cCwPfzeXdZs7Ty2vZYHBqywb5Qi2awR6VT7zARfAi9b3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxztfWph; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b3c0a00f2so1460443b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720559410; x=1721164210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oninqgQHKQLJeVm7TYTo0kPRWYyybK0zDurELufxBMQ=;
        b=dxztfWphd6djsIePtqjhyLixE9dHhrc3xe8VZLaTew8UNq0plttrh2ZXp1NxHoqhUk
         /wvmUChDuNsIBcYiBkG5ycq5I/xeqSv7kUtBq5Dkonmm0Y080BStX4R1Y4V1fC6/AsnX
         iTQT6rE06P9VLQtLRp5J6C5IhuDWdHug/2wv11ud747qgeSRzwQ0vQ8PWjE3jV2tzKwN
         bEuKZqX6LrfXFCTFNBiqsMYamAYF+vUiZ9gzRaJpU6q04ZCsuLE5YS2Uu/JZnfIpfMr3
         tQ/8wIXD5EhMFlfxevVDhLPvAe/QgcpeKPnyA8yR5kCMvHfmfxg6/iwqEhgawUQingz9
         gqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559410; x=1721164210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oninqgQHKQLJeVm7TYTo0kPRWYyybK0zDurELufxBMQ=;
        b=NuqI2c+ajZQz10Od3hQ6v38gl8wp75ljoOTchPbr2CWbvwN085tK0nOlPyaW4U9AT/
         b2ARemgoM6neAIQ6LmL16Butt8IUc40/ztlQvIrm+kE9Xf/5iGZ+jTnh4WPrnCT39N0h
         FvWRCVr8PRraKqdcaXHsw17+ZqxlKgKQDQfRVUvQKm4QORuDrbiukndNHA4uCZKa+Odk
         xKbStp2wdKvMKGpgHsOqD2FBBVyRx5jKGIdc2skg3x9TJrqPmApSJCwJIxVuzLWxFTaG
         KH7KI0bREKJqYA9/1dxWT+JZsQfES6Kj07s+sSHHIUj+GX7G8MVyOhOX8tt1iRxeGdoX
         7giQ==
X-Gm-Message-State: AOJu0YyaHwJaPlWNjY5+p05s3pR0HQVEFDCAPkyL4gn0MlV/Qk3Mk26v
	yJem+nvzsJ4dU9SpoPCxRA63/L4MeVEhz5tX+Eu5LmlXqlGdezGE
X-Google-Smtp-Source: AGHT+IGjFoRBq5moqF1/dsC/oVUvka7eJRNg155DQbX147mGI2kz5HdrusrWG024xFvos3/1o43Nqw==
X-Received: by 2002:a05:6a00:887:b0:706:b10c:548a with SMTP id d2e1a72fcca58-70b43626517mr4616038b3a.22.1720559410210;
        Tue, 09 Jul 2024 14:10:10 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438e538fsm2293218b3a.87.2024.07.09.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:10:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Make scx_bpf_reenqueue_local() skip tasks that are being migrated
Date: Tue,  9 Jul 2024 11:09:43 -1000
Message-ID: <20240709211001.1198145-3-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709211001.1198145-1-tj@kernel.org>
References: <20240709211001.1198145-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a running task is migrated to another CPU, the stop_task is used to
preempt the running task and migrate it. This, expectedly, invokes
ops.cpu_release(). If the BPF scheduler then calls
scx_bpf_reenqueue_local(), it re-enqueues all tasks on the local DSQ
including the task which is being migrated.

This creates an unnecessary re-enqueue of a task which is about to be
deactivated and re-activated for migration anyway. It can also cause
confusion for the BPF scheduler as scx_bpf_task_cpu() of the task and its
allowed CPUs may not agree while migration is pending.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 245254f7081d ("sched_ext: Implement sched_ext_ops.cpu_acquire/release()")
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0fabfe19327c..f4a7abcec793 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5646,6 +5646,20 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
 				 scx.dsq_list.node) {
+		/*
+		 * If @p is being migrated, @p's current CPU may not agree with
+		 * its allowed CPUs and the migration_cpu_stop is about to
+		 * deactivate and re-activate @p anyway. Skip re-enqueueing.
+		 *
+		 * While racing sched property changes may also dequeue and
+		 * re-enqueue a migrating task while its current CPU and allowed
+		 * CPUs disagree, they use %ENQUEUE_RESTORE which is bypassed to
+		 * the current local DSQ for running tasks and thus are not
+		 * visible to the BPF scheduler.
+		 */
+		if (p->migration_pending)
+			continue;
+
 		dispatch_dequeue(rq, p);
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
-- 
2.45.2


