Return-Path: <linux-kernel+bounces-202241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928368FC9E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B431628645D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D28192B75;
	Wed,  5 Jun 2024 11:11:26 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7761922F5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585885; cv=none; b=CWYksWT9C6pz0J78p4Qc3d8ZvOC4FwC0OmArDQBrqswetsSso/P4sRB1Hst55R7xJkcB19mXqExXECABdGjntEXtxYXWyqaHyximeDMEylrzgyA1jqjmeNhUWws50j/PGrKAduuMfkT01WhfP9/hv94fNYxDTCp+MYKEH9CEWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585885; c=relaxed/simple;
	bh=LSDCL93k5vWQ4ROYGbGIImcnUT3CyHzsNKfiQrNTl9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oc44S0vPdkJn2nP3uzm1cOW/fUuNxgY3xElgpB03xVXNwpn9WGW4h8UAmHAwxZPPdAjnYIkspulmygdB2WzE6s02IUGMWPoaQWQz55g6Pc3KLMOebVcNxV4JmWqlF7EE1OqkQk7vfTVVHoUgB5SCw3BZDrFkNAofqkzF85jeIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.2])
	by sina.com (172.16.235.25) with ESMTP
	id 666047C800003AB0; Wed, 5 Jun 2024 19:11:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 29600134210358
X-SMAIL-UIID: F6B7F59F33754DBFA004D0AA4633AF65-20240605-191109-1
From: Hillf Danton <hdanton@sina.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep worning
Date: Wed,  5 Jun 2024 19:10:55 +0800
Message-Id: <20240605111055.1843-1-hdanton@sina.com>
In-Reply-To: <20240604185804.GT3884@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org> <ZljyqODpCD0_5-YD@slm.duckdns.org> <20240531034851.GF3884@unreal> <Zl4jPImmEeRuYQjz@slm.duckdns.org> <20240604105456.1668-1-hdanton@sina.com> <20240604113834.GO3884@unreal> <Zl9BOaPDsQBc8hSL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 4 Jun 2024 21:58:04 +0300 Leon Romanovsky <leon@kernel.org>
> On Tue, Jun 04, 2024 at 06:30:49AM -1000, Tejun Heo wrote:
> > On Tue, Jun 04, 2024 at 02:38:34PM +0300, Leon Romanovsky wrote:
> > > Thanks, it is very rare situation where call to flush/drain queue
> > > (in our case kthread_flush_worker) in the middle of the allocation
> > > flow can be correct. I can't remember any such case.
> > >
> > > So even we don't fully understand the root cause, the reimplementation
> > > is still valid and improves existing code.
> > 
> > It's not valid. pwq release is async and while wq free in the error path
> > isn't. The flush is there so that we finish the async part before
> > synchronize error handling. The patch you posted will can lead to double
> > free after a pwq allocation failure. We can make the error path synchronous
> > but the pwq free path should be updated first so that it stays synchronous
> > in the error path. Note that it *needs* to be asynchronous in non-error
> > paths, so it's going to be a bit subtle one way or the other.
> 
> But at that point, we didn't add newly created WQ to any list which will execute
> that asynchronous release. Did I miss something?
> 
Maybe it is more subtle than thought, but not difficult to make the wq
allocation path sync. See if the patch could survive your test.

--- x/include/linux/workqueue.h
+++ y/include/linux/workqueue.h
@@ -402,6 +402,7 @@ enum wq_flags {
 	 */
 	WQ_POWER_EFFICIENT	= 1 << 7,
 
+	__WQ_INITIALIZING 	= 1 << 14, /* internal: workqueue is initializing */
 	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
--- x/kernel/workqueue.c
+++ y/kernel/workqueue.c
@@ -5080,6 +5080,8 @@ static void pwq_release_workfn(struct kt
 	 * is gonna access it anymore.  Schedule RCU free.
 	 */
 	if (is_last) {
+		if (wq->flags & __WQ_INITIALIZING)
+			return;
 		wq_unregister_lockdep(wq);
 		call_rcu(&wq->rcu, rcu_free_wq);
 	}
@@ -5714,8 +5716,10 @@ struct workqueue_struct *alloc_workqueue
 			goto err_unreg_lockdep;
 	}
 
+	wq->flags |= __WQ_INITIALIZING;
 	if (alloc_and_link_pwqs(wq) < 0)
 		goto err_free_node_nr_active;
+	wq->flags &= ~__WQ_INITIALIZING;
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
--

