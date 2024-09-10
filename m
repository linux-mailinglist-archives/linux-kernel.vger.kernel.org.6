Return-Path: <linux-kernel+bounces-323386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB85973C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6B61C243A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8F71A01C3;
	Tue, 10 Sep 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="Ik78f7wt"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1532191F9B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983155; cv=none; b=J96jK6lCpy6dWiATHLo43UdXjZjU7JL4XdIU2Vl1S1J47Bj4WQwGs5lzoGxlE5GocqMqSdwMsQxbzEwHJnGMzZ8HxWjvrNGmI2+bLTDTf1UFtCoYSXdixLZNp6zX3DcVeQl3qIJSkVrjSYsEm+xH8wKN5pO8EDWiRUPMxMs0P6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983155; c=relaxed/simple;
	bh=XfiVCwa2jWEk1M2MkT7rHET2smIjIcH+WkT+Wy9VZlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGr0DJ/QYZjV9WO1C0RtR3BjuopF17bX8AEuN04iaWcXor+fGoSuUGXIsGZR29ehTC0dijUUy1twD5+YGlB262peuyJuB7kxxum4nMxMAIR4hGEncXTkzAdW0uUwd4t0rMuvMxbI35jCWSIoHuauabJSZaQHyuOZO5ZIEviPaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=Ik78f7wt; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024091015454942d4547f196d13fe5d
        for <linux-kernel@vger.kernel.org>;
        Tue, 10 Sep 2024 17:45:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Pv5z/hfaIXxpRwvFKBnqkGUSEgP+MIm2v5ejiY+wuV0=;
 b=Ik78f7wtiBD0rOCSY3FlwmeymJPjjk6l2dJN2ffdzCk3EfXxPugoMsw9Wzt4y4+JCowQ+E
 1JB58XpIGdhdQ7/hvwlwJ8pPayTY5ev6JqjHQoD/1/3zixJXe6O7dybaSAi8z/iyWUN5fuaw
 OokSQXEtJ6n7DMLwF4slJPl4y52UR/aYnp+WEo/xcfzMhQmluYGpIgvdB1bupCCu5Dxv3/sl
 HBO4wgDl8TpwOcSsD1gAevl2MJDDpSRdzHF31lShi0YdFoDfEb6umsrvbfgGeG3TykjDuZkx
 0uoswQbfVjjuFA5venFb5/IstkdXC5D20KsiOGSgALp+JJgUiRZVqNTA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2 2/2] io_uring/io-wq: limit io poller cpuset to ambient one
Date: Tue, 10 Sep 2024 17:45:35 +0200
Message-Id: <20240910154535.140587-3-felix.moessbauer@siemens.com>
In-Reply-To: <20240910154535.140587-1-felix.moessbauer@siemens.com>
References: <20240910154535.140587-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

The io worker threads are userland threads that just never exit to the
userland. By that, they are also assigned to a cgroup (the group of the
creating task).

When creating a new io worker, this worker should inherit the cpuset
of the cgroup.

Fixes: da64d6db3bd3 ("io_uring: One wqe per wq")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 io_uring/io-wq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index c7055a8895d7..a38f36b68060 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1168,7 +1168,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 	if (!alloc_cpumask_var(&wq->cpu_mask, GFP_KERNEL))
 		goto err;
-	cpumask_copy(wq->cpu_mask, cpu_possible_mask);
+	cpuset_cpus_allowed(data->task, wq->cpu_mask);
 	wq->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 	wq->acct[IO_WQ_ACCT_UNBOUND].max_workers =
 				task_rlimit(current, RLIMIT_NPROC);
-- 
2.39.2


