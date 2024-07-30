Return-Path: <linux-kernel+bounces-267283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23FB940F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C2F1F27766
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824019EEC8;
	Tue, 30 Jul 2024 10:32:01 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AB19E7F2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335520; cv=none; b=kwhXeICU+yS9oZU5iXfsFarrPNhPdp24JWg1pwNas46TDTWOxqfasiB2pTLjTpCr+WDtLiRNM0zYN9FH7BJgd67dz+y7P3LmA2yrPnIkAgPEi0MjPNZdzjolbqiAEMr9w9tMO/f4Hix+CnBos7M/VBOazXMAYVuWEQEyEtXfe/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335520; c=relaxed/simple;
	bh=fHagWOwq4NW10fYxjt4TKFsUQTKtXPpkpWNC+7lN75I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CdQIguzuSIhXJKaTX5GJA3k0iw6rLGcBY9ClgR1qy3D4+kluQ15BaeL5WTTvIqtn1aJt6D6JUAoWZk+xYgx2tai3HeJqsASaC1qdJXtsP6X6J63RWjN7cgNvn3TySTv3fr/dvgRyNGxjdME1PeGNLZZzhpCsltjfZ1EYsEgJ2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.37])
	by sina.com (10.185.250.23) with ESMTP
	id 66A8BED1000035C3; Tue, 30 Jul 2024 18:22:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5479958913416
X-SMAIL-UIID: B41EF79B58854A399F9EF1DA04D1DA37-20240730-182212-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
Date: Tue, 30 Jul 2024 18:22:00 +0800
Message-Id: <20240730102200.2312-1-hdanton@sina.com>
In-Reply-To: <000000000000e9a538061e64cae7@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jul 2024 08:48:30 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    dc1c8034e31b minmax: simplify min()/max()/clamp() implemen..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1022b573980000

#syz test upstream  dc1c8034e31b

--- x/kernel/workqueue.c
+++ y/kernel/workqueue.c
@@ -2679,7 +2679,8 @@ static void worker_attach_to_pool(struct
 		worker->flags |= WORKER_UNBOUND;
 	} else {
 		WARN_ON_ONCE(pool->flags & POOL_BH);
-		kthread_set_per_cpu(worker->task, pool->cpu);
+		if (!worker->rescue_wq)
+			kthread_set_per_cpu(worker->task, pool->cpu);
 	}
 
 	if (worker->rescue_wq)
--

