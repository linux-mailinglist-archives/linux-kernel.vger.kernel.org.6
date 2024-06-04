Return-Path: <linux-kernel+bounces-200476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3058FB09B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF42F1C20BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5165F14533F;
	Tue,  4 Jun 2024 10:55:27 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D79144D00
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498526; cv=none; b=fRVhpX5uPZWJ0F2otRfCen4OEgMubpZsU856g4v+3KpQyckiaBQBaLsvNCNz+lEFKV/WbMVBGrSSHYWxwYHvL19AUjfgi4CAVL6z3IU2oEpH1tWwQQYaJtk17Vr7LJgHyyc/6qf82I1HBdaOLrUC6/LMhwDgUQX2G1gSgr9Tlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498526; c=relaxed/simple;
	bh=wV5Cq68GjGdP5oijvBuOZFA7zgkjpyxF8ip/BZcMOw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0lECyVWShMx1aqqcf2+an49dNc6aMWjf4XR2kb8kXJgSphGRBPGGSx3qMNLqjs2cRzonW8ViqZaInbQFJ1y+Ls9AwmqClsvlwZ7v/qTYBpVvDHxS5kx3ivVTusw+P54Bn+AKk/0HLTQ4Xb2g9H6HWkVSMqeYg3HNsX0o3+isF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.129])
	by sina.com (10.185.250.21) with ESMTP
	id 665EF28900003DE7; Tue, 4 Jun 2024 18:55:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3986503408482
X-SMAIL-UIID: 0DC135B6AE7141AE9B325C5C6B26B03A-20240604-185508-1
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
Date: Tue,  4 Jun 2024 18:54:56 +0800
Message-Id: <20240604105456.1668-1-hdanton@sina.com>
In-Reply-To: <20240604080958.GL3884@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org> <ZljyqODpCD0_5-YD@slm.duckdns.org> <20240531034851.GF3884@unreal> <Zl4jPImmEeRuYQjz@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 4 Jun 2024 11:09:58 +0300 Leon Romanovsky <leon@kernel.org>
> On Mon, Jun 03, 2024 at 10:10:36AM -1000, Tejun Heo wrote:
> > 
> > And KASAN is reporting use-after-free on a completely unrelated VFS object.
> > I can't tell for sure from the logs alone but lockdep_register_key()
> > iterates entries in the hashtable trying to find whether the key is a
> > duplicate and it could be that that walk is triggering the use-after-free
> > warning. If so, it doesn't really have much to do with workqueue. The
> > corruption happened elsewhere and workqueue just happens to traverse the
> > hashtable afterwards.
> 
> The problem is that revert of commit 643445531829
> ("workqueue: Fix UAF report by KASAN in pwq_release_workfn()")
> fixed these use-after-free reports.
> 
Given revert makes sense,

	if (alloc_and_link_pwqs(wq) < 0)
		goto err_unreg_lockdep;

err_unreg_lockdep:
	wq_unregister_lockdep(wq);
	wq_free_lockdep(wq);
err_free_wq:
	free_workqueue_attrs(wq->unbound_attrs);
	kfree(wq);	<-- freed
	return NULL;

the difference 643445531829 makes is double free.

	alloc_and_link_pwqs(struct workqueue_struct *wq)
	if (ret)
		kthread_flush_worker(pwq_release_worker);
		  pwq_release_workfn()
		  if (is_last) {
			wq_unregister_lockdep(wq);
			call_rcu(&wq->rcu, rcu_free_wq); <-- freed again
		  }

