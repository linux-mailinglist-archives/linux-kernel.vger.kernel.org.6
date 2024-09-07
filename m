Return-Path: <linux-kernel+bounces-319729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED524970172
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC56284A4A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20672157A55;
	Sat,  7 Sep 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="Hb3kfPTP"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F511537D8
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725703079; cv=none; b=bjykuEzXDjn23FbBj18JexVKDPZTGOnDhMm5SF0Z5vpI+i82fbQM04thjkF/rqhjhjxpUwwi6ubQG4BszC1EDVBWW5JUxaQmd5P3n2ga7cRgQbG3OmIdOf9vNePQX1OwrdKYmrEKUrUegOyjH/EkpAXxchoFFlHAVG5iKcRlzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725703079; c=relaxed/simple;
	bh=tiPTbHnY+2nOrmCHuGoFGkPY9sR170hFjDbw1sNgnGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gQCsGx0WXlhVI0Apgqzqjw7LM89pz6wubglyZSVplBalO0DiepDsHDFcSYmTqchc/LcidOD2SKStmn8alnJ1yI7YEmzDRxCa60tIfMI/MVxhvetC9M5Z2xjUDAlw+PTotGAl7bZgLQAoD6hXY09OjYlH3WcRpW6179aCNX+v1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=Hb3kfPTP; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202409070957472e955524895cd771ce
        for <linux-kernel@vger.kernel.org>;
        Sat, 07 Sep 2024 11:57:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=rWjk7kQaptgNGEKIjhDPXFTjIGNRskNMMtFtkoA3rk0=;
 b=Hb3kfPTP3gg6SFxXzyHjNq7h9IhGQd9/ycyaJ8T1A6sJrk8m+zi1/U4PBiUgmSmrhKRzYH
 9/IG4RBNor/QZ3ARzT1gXkjVt9yi84gho5Z8B/Z8vAxrujko2/HOV6sCRxB7Sybx2Jv2ddrc
 oBfyyxlRx15kInJrjswjJPTCfj6CAWjU+MIn5fFWNgUZMwB3nSjNkofR4ZjaCQfB1wdFK2XH
 zt0FtXRK/6YikULZp5mzWKSKpsoV0isztlBKVof32P/a81NFNM6ZxDevKDJKMqdgbq9965XH
 hlxM0hTxpEsxgtLn+CSkfblqTBHURrgiGIsOBNN3sTuVnK30kLuDQseQ==;
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
	stable@vger.kernel.org,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2 1/1] io_uring/sqpoll: inherit cpumask of creating process
Date: Sat,  7 Sep 2024 11:57:29 +0200
Message-Id: <20240907095729.27037-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

The submit queue polling threads are userland threads that just never
exit to the userland. In case the creating task is part of a cgroup
with the cpuset controller enabled, the poller should also stay within
that cpuset. This also holds, as the poller belongs to the same cgroup
as the task that started it.

With the current implementation, a process can "break out" of the
defined cpuset by creating sq pollers consuming CPU time on other CPUs,
which is especially problematic for realtime applications.

Part of this problem was fixed in a5fc1441 by dropping the
PF_NO_SETAFFINITY flag, but this only becomes effective after the first
modification of the cpuset (i.e. the pollers cpuset is correct after the
first update of the enclosing cgroups cpuset).

By inheriting the cpuset of the creating tasks, we ensure that the
poller is created with a cpumask that is a subset of the cgroups mask.
Inheriting the creators cpumask is reasonable, as other userland tasks
also inherit the mask.

Fixes: 37d1e2e3642e ("io_uring: move SQPOLL thread io-wq forked worker")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v1:

- do not set poller thread cpuset in non-pinning case, as the default is already
  correct (the mask is inherited from the parent).
- Remove incorrect term "kernel thread" from the commit message

I tested this without pinning, explicit pinning of the parent task and
non-all cgroup cpusets (and all combinations).

Best regards,
Felix Moessbauer
Siemens AG

 io_uring/sqpoll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 6ea21b503113..5a002fa1d953 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -231,8 +231,6 @@ static int io_sq_thread(void *data)
 
 	if (sqd->sq_cpu != -1)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
-	else
-		set_cpus_allowed_ptr(current, cpu_online_mask);
 
 	/*
 	 * Force audit context to get setup, in case we do prep side async
-- 
2.39.2


