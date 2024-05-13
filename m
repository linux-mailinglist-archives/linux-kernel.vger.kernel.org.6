Return-Path: <linux-kernel+bounces-178154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435708C49C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D216BB21235
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3E684DE3;
	Mon, 13 May 2024 22:54:30 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1C84D3E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640869; cv=none; b=R++vPpUrZDUs8ppxRMn99OBsqf5kaO3K4gqeEZppEiCx74OL8Czb2jQQwkDtY3dFsCeUAa0pdyxQLpA2HFWKgdAxK9Bgx6zLZkTHkcRn+yw9wF3QLhyLkIlOj6ZALYda78/NrxHgKlZwvmab/fdo1upWsndqF7wel7Q4GGFFCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640869; c=relaxed/simple;
	bh=XAh+3+CTGGVkYISHkmm739KJkfOQWMn8Cnd1CdYSj9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8I4o5HgM08m9uyUWQnDYpLNsry3VLRQVgBJETO8XHqn/EUcBGpMzv4Ii+lmMYC4uzY2/Rt7AGc7NYM/tWqTK6oaNSyuC90uTF5LpjymljBcOtVqQ3uP1d8nncoYPOvLfmR14mpQFvsZyISDbmbi4AVk87TSyxQHkOhgjox3UZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.104])
	by sina.com (172.16.235.24) with ESMTP
	id 66429A1B00003C20; Mon, 14 May 2024 06:54:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 97074945089598
X-SMAIL-UIID: 552A54332FBE4E46BB076C39E75AF36F-20240514-065421-1
From: Hillf Danton <hdanton@sina.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
Date: Tue, 14 May 2024 06:54:09 +0800
Message-Id: <20240513225409.3025-1-hdanton@sina.com>
In-Reply-To: <CAEkJfYPxWBfEnuKeCGEsscVTYy8MrNxCJwdbxS=c2-B0H+HfTA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 May 2024 20:57:44 +0800 Sam Sun <samsun1006219@gmail.com>
> 
> I am happy to help testing patches. As

Thanks.

> for repro, I have a C repro available, but it is too long so that I
> attached it to the first email. Should I just paste repro with bug
> report?

Yes.

> I applied this patch and tried using the C repro, but it still crashed
> with the same task hang kernel dump log.

Oh low-hanging pear is sour, and try again seeing if there is missing
wakeup due to wake batch.

--- x/lib/sbitmap.c
+++ y/lib/sbitmap.c
@@ -579,6 +579,8 @@ void sbitmap_queue_wake_up(struct sbitma
 	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
 	unsigned int wakeups;
 
+	__sbitmap_queue_wake_up(sbq, nr);
+
 	if (!atomic_read(&sbq->ws_active))
 		return;
 
--

