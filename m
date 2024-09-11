Return-Path: <linux-kernel+bounces-325349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB09797583F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE87F1C22F80
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2BB1AED31;
	Wed, 11 Sep 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="H/6NBs0R"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD81AE864
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071814; cv=none; b=aAeBO4Li/hSEUypOkvQ9SpXDPJRLpXFXZePIQEMRHbjSZIJjPi/U09z25ayCmRLU4SjNAqAlSNwWyLLEsS4Dov6S2+x3/bIzWD0DHAH+dA70RFB9/0zk+XurznHuTi/9nVWN3IuibDfGRDuPi8vbuwcMl0bKM1vo22eb2Ff8Efc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071814; c=relaxed/simple;
	bh=bmnetQMbTu9hnH0bwUNDYDayE3gIdFC+cuiYFhpzl6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=deSddvhFh0pWWZoJDQ5ns6pEplQaSVRxl0LWHKX/KkUlkJ3xSHt7M4BBqo8vW1QvQ4QEbvaep3WtdUu+aNvHXSMireIo3etuVEiDTs32ciFClF4dS2UA73IMPUnN55hqQbY1Y0d466qd7p6c3fnc4IMFIkKJLWqKbCWzIk9dNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=H/6NBs0R; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202409111623279d9c3aec61b7b05868
        for <linux-kernel@vger.kernel.org>;
        Wed, 11 Sep 2024 18:23:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7ZUSL9956dMTKl4lPB2nJCaF8a0We09ZgJjxtb1B5Vc=;
 b=H/6NBs0R54sg0eiFuEVwndwNsW9dIT3HjAukgPWPFCL7xIZVR1ISXkwoqwGHWd+beGa9MP
 3dq3q24r3e9vrjdZD3y4oGVwyKyU/jgN66fKyJ/NB5JWEiNS+p7NEPPeeUYXoniXXIgty0Tz
 ME3OW8jvApyseHuutT7Y5v4K7CsaZ7V3p4CYOFFgh8GxIm9GOWw7cIMIszK1bzABlvH4bwoQ
 FHr+TJy3GIXpUHpLa7Gh6b+h8iKRpgFVutDQv3zUiKu/rFFOrCQzjXjd1GQ85BrgEJAEy8Xn
 F/sZWxmwC7eXfCGmecwjcUjRSLjGiejwdTxq+71eknO87QOAT/wkMqyA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: stable@vger.kernel.org,
	asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 6.1 2/2] io_uring/io-wq: inherit cpuset of cgroup in io worker
Date: Wed, 11 Sep 2024 18:23:16 +0200
Message-Id: <20240911162316.516725-3-felix.moessbauer@siemens.com>
In-Reply-To: <20240911162316.516725-1-felix.moessbauer@siemens.com>
References: <20240911162316.516725-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

commit 84eacf177faa605853c58e5b1c0d9544b88c16fd upstream.

The io worker threads are userland threads that just never exit to the
userland. By that, they are also assigned to a cgroup (the group of the
creating task).

When creating a new io worker, this worker should inherit the cpuset
of the cgroup.

Fixes: da64d6db3bd3 ("io_uring: One wqe per wq")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 io_uring/io-wq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index c74bcc8d2f06..04265bf8d319 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1157,6 +1157,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 {
 	int ret, node, i;
 	struct io_wq *wq;
+	cpumask_var_t allowed_mask;
 
 	if (WARN_ON_ONCE(!data->free_work || !data->do_work))
 		return ERR_PTR(-EINVAL);
@@ -1176,6 +1177,9 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	wq->do_work = data->do_work;
 
 	ret = -ENOMEM;
+	if (!alloc_cpumask_var(&allowed_mask, GFP_KERNEL))
+		goto err;
+	cpuset_cpus_allowed(current, allowed_mask);
 	for_each_node(node) {
 		struct io_wqe *wqe;
 		int alloc_node = node;
@@ -1188,7 +1192,8 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 		wq->wqes[node] = wqe;
 		if (!alloc_cpumask_var(&wqe->cpu_mask, GFP_KERNEL))
 			goto err;
-		cpumask_copy(wqe->cpu_mask, cpumask_of_node(node));
+		if (!cpumask_and(wqe->cpu_mask, cpumask_of_node(node), allowed_mask))
+			cpumask_copy(wqe->cpu_mask, allowed_mask);
 		wqe->node = alloc_node;
 		wqe->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 		wqe->acct[IO_WQ_ACCT_UNBOUND].max_workers =
@@ -1222,6 +1227,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 		free_cpumask_var(wq->wqes[node]->cpu_mask);
 		kfree(wq->wqes[node]);
 	}
+	free_cpumask_var(allowed_mask);
 err_wq:
 	kfree(wq);
 	return ERR_PTR(ret);
-- 
2.39.2


