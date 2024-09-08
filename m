Return-Path: <linux-kernel+bounces-319971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E897048B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 02:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFEC282DCC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0642599;
	Sun,  8 Sep 2024 00:02:28 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B6181
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725753747; cv=none; b=bpcZm7ltFKi9eMBC4P2phT8OGftVLfssd5ykj54j8CctfVil0ltqVgGtxztTWPIf9cMws6aDhAFKTQv06wT9SvqwrPO/xAtMglfWwdYxpwn7VyLcBcxhmlrXZl+pxY8NUka0kAqv+KkgoDPtrw/btw/fTVw0t3MPZtKzWTNfHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725753747; c=relaxed/simple;
	bh=+M6BdLDj3AUe+9DxS/8OlgvMvVbgyf161kYayyy1MIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EK5ViVci2V7SGtht41nG1SzIZGSgD5GuZLwzvMjSdkIZH/x5ifyaUKZnPWa+MsWtKiBYuVt0pPvYXHQJ3pgiT6TqqhTn+FHk02BicDAH5s0lPWo0lt8heQQcBEbQJYNnUztbsuuIidqmDPV5Cd8zgZPQnR7cHp1WSwY+hY6yQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.196])
	by sina.com (10.185.250.23) with ESMTP
	id 66DCE98100007AC2; Sun, 8 Sep 2024 08:02:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9057018913218
X-SMAIL-UIID: 032757920145445C9B5DD950A011CC35-20240908-080211-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 08:01:59 +0800
Message-Id: <20240908000159.2217-1-hdanton@sina.com>
In-Reply-To: <0000000000004a130a0621888811@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 07 Sep 2024 07:42:26 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    788220eee30d Merge tag 'pm-6.11-rc7' of git://git.kernel.o..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1304189f980000

#syz test

--- l/net/bluetooth/l2cap_core.c
+++ c/net/bluetooth/l2cap_core.c
@@ -1797,6 +1797,7 @@ static void l2cap_conn_del(struct hci_co
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
+	cancel_work_sync(&hcon->hdev->rx_work);
 	hcon->l2cap_data = NULL;
 	conn->hchan = NULL;
 	l2cap_conn_put(conn);
--

