Return-Path: <linux-kernel+bounces-418917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB79D6728
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 03:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008E816167C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9AC273F9;
	Sat, 23 Nov 2024 02:11:26 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10145B65C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732327886; cv=none; b=IVaZBHVtUt5ynFxUC1wqVMrNiaWNCLZxdsPIKJLjdWlKULYC0TdEcbAXMr56B/BjcjY2dyd+ANNSrM9AJAJnsh31iEjVDjP9JqbyhDvh8s+1N8/XRycPq1GtUO0CHSlQQvsIRjhTgiSFlZ+5zIyXUJaDjqm3dEBnN0cYxtQcjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732327886; c=relaxed/simple;
	bh=EdkY2juaWpaHC8G/FBzvE+YbdGnxI7UhvdMJeUfE0lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thaZKojiLMVGlo4XHpNALcITTze1ySScltwl1dwKXeg2SAULoZfW3sVAbMzGs2lIrS6BMSL6GWG8Lxu/Zq6D8KIKmssDdOux5XHe59jxADpnCXk8jb0HK6jkFlfBdEPvYBTc6AkTuLRgKJ/wnPNclvFusMnyCcxGT3jim92pjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.81])
	by sina.com (10.185.250.22) with ESMTP
	id 674139BC00005610; Sat, 23 Nov 2024 10:11:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6729347602679
X-SMAIL-UIID: F61EAEE274244FB68DCC85EC9D31020D-20241123-101112-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] WARNING in enqueue_dl_entity
Date: Sat, 23 Nov 2024 10:10:58 +0800
Message-Id: <20241123021058.1381-1-hdanton@sina.com>
In-Reply-To: <67410a37.050a0220.363a1b.0150.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Nov 2024 14:48:23 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    28eb75e178d3 Merge tag 'drm-next-2024-11-21' of https://gi..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1016fec0580000

#syz test upstream master

--- x/kernel/sched/fair.c
+++ y/kernel/sched/fair.c
@@ -7151,8 +7151,11 @@ static int dequeue_entities(struct rq *r
 			idle_h_nr_running = h_nr_running;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_throttled(cfs_rq)) {
+			if (rq_h_nr_running && !rq->cfs.h_nr_running)
+				dl_server_stop(&rq->fair_server);
 			return 0;
+		}
 	}
 
 	sub_nr_running(rq, h_nr_running);
--

