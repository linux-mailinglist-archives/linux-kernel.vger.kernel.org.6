Return-Path: <linux-kernel+bounces-336237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2CF97F0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAB91C21846
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4D1A2653;
	Mon, 23 Sep 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O57nAeSi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36D1A2642
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118034; cv=none; b=SptwxNSwg9Ax1JjVlgmS8izYW3FxWs7rGmhe5mGQUSGUoThK5HtWK6Yl4iRPmhKFuV3n6wYQxA4P46fHeCnmzf8hk3NFf3NF+G2DCfbkRpI1xgu/6DwJsUscaPIY+JNBytcu2BoZ6MiGa4D6czJwz/811ApucFClDyD5MVNmpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118034; c=relaxed/simple;
	bh=Su/yg57sFOy/yP91wgcbJpFG1wSITs/4plvNEri0/1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqXx2gEXXE1QyX3Z54JpekJGu9mXN0tPzbkDHzlVWAuEnEM0YLW/eCHzSSaMk8EH4dSZyvr7dvfYqprR3rUJb7JOGBR1EEbsZ1Nm9Ze855TSMqfbzZET0rC4hSDuXSAsnJJGRSwb1nSTRn1w5qhZVGQdeLm5ckEc4EN2XUSucC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O57nAeSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52ADC4CEC5;
	Mon, 23 Sep 2024 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118034;
	bh=Su/yg57sFOy/yP91wgcbJpFG1wSITs/4plvNEri0/1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O57nAeSiLYnkmrp3Bd7TLz3kiX80b3IY709bONEq2WeveQfcaZvqs5iEfCNeoA4tf
	 K05emfzQ+MqWZVxKzYcjDHTXdBMXwJf6jVhqXubaBqoe3tth0u7IfeaqUrKrwV29Bc
	 KyTB3QzX1WnLODVGciNqSJp0h3dBgIVljP4wjupjRyqfKmF7eDh1NN/CY+JvOfMGQe
	 57XAV8/vDdh838+oTdhpgQTvq9ym7S9Yy59j1+RpHPm1tMhTiGASzo/7oG+DaE2PIA
	 IyIBi0Lo+fA9unT8w7iwngYZ9gBol8e/jWX9NCSVwvBxF/2G5e2aGZd7gszZ0g/Lqa
	 ymSqh0wElaYbw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	aboorvad@linux.ibm.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/8] sched_ext: Relocate check_hotplug_seq() call in scx_ops_enable()
Date: Mon, 23 Sep 2024 08:59:28 -1000
Message-ID: <20240923190020.1446325-2-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923190020.1446325-1-tj@kernel.org>
References: <20240923190020.1446325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_hotplug_seq() is used to detect CPU hotplug event which occurred while
the BPF scheduler is being loaded so that initialization can be retried if
CPU hotplug events take place before the CPU hotplug callbacks are online.

As such, the best place to call it is in the same cpu_read_lock() section
that enables the CPU hotplug ops. Currently, it is called in the next
cpus_read_lock() block in scx_ops_enable(). The side effect of this
placement is a small window in which hotplug sequence detection can trigger
unnecessarily, which isn't critical.

Move check_hotplug_seq() invocation to the same cpus_read_lock() block as
the hotplug operation enablement to close the window and get the invocation
out of the way for planned locking updates.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c09e3dc38c34..95ed822fa563 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5005,6 +5005,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		if (((void (**)(void))ops)[i])
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
 
+	check_hotplug_seq(ops);
 	cpus_read_unlock();
 
 	ret = validate_ops(ops);
@@ -5053,8 +5054,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	cpus_read_lock();
 	scx_cgroup_lock();
 
-	check_hotplug_seq(ops);
-
 	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
 		if (((void (**)(void))ops)[i])
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
-- 
2.46.0


