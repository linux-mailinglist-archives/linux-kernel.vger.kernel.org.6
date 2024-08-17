Return-Path: <linux-kernel+bounces-290622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61012955663
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED37C1F217C2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240A0144306;
	Sat, 17 Aug 2024 08:37:46 +0000 (UTC)
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378A13CFA3
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883865; cv=none; b=Jl2d49MmDKnMZHdnhUnLb+vdpupR/Eo5AjW45Dgn+SstJoaFnA7GZktvDG1dvwtY6whuLiWEh5vkEMjbnwlKaio/iYEtMDmGGe1U4JxQpo3JDdYARNJ01jVzQjIFC/Ery4mg8rXgB3wPk2nTvNaheX8XBXBTtgQl92dX88W2lIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883865; c=relaxed/simple;
	bh=NDQKsQ8eKWXHjTivAPb0GszBtvgQ+oT+INZS4sF0kDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQGcVzaF3Nxb5G3YWbFBvTrm6gBDKS/TAKqtuNWCUKQPasFcRgyACJ5T2HHek1wY4rxzK+SacDb8H9aPacRg96nX+EznF4Dx166iZ5JB47bIZWjnx1slR3iL33UGcvgUZ6ApCIBpiwWIvH7sPNhrvhoZ0D7UNLzO4Uu40fsjQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.198])
	by sina.com (10.185.250.21) with ESMTP
	id 66C0600600004B66; Sat, 17 Aug 2024 16:32:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7982023408298
X-SMAIL-UIID: 03FC981F1F83465F8A513E410BE74758-20240817-163209-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [cgroups?] possible deadlock in task_rq_lock
Date: Sat, 17 Aug 2024 16:31:58 +0800
Message-Id: <20240817083158.2079-1-hdanton@sina.com>
In-Reply-To: <00000000000092ef86061fdb849b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 23:52:22 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142413c5980000

#syz test linux-next  367b5c3d53e5

--- x/kernel/sched/deadline.c
+++ y/kernel/sched/deadline.c
@@ -1498,6 +1498,9 @@ static void update_curr_dl_se(struct rq
 	 * starting a new period, pushing the activation.
 	 */
 	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
+		bool lock = rq != dl_se->rq;
+		struct rq_flags rf;
+		struct rq *__rq = dl_se->rq;
 		/*
 		 * If the server was previously activated - the starving condition
 		 * took place, it this point it went away because the fair scheduler
@@ -1508,7 +1511,11 @@ static void update_curr_dl_se(struct rq
 
 		hrtimer_try_to_cancel(&dl_se->dl_timer);
 
+		if (lock)
+			rq_lock(__rq, &rf);
 		replenish_dl_new_period(dl_se, dl_se->rq);
+		if (lock)
+			rq_unlock(__rq, &rf);
 
 		/*
 		 * Not being able to start the timer seems problematic. If it could not
--

