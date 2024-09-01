Return-Path: <linux-kernel+bounces-310158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3970E9675A6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3F71C20A79
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BE1448E1;
	Sun,  1 Sep 2024 09:05:05 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD582219F6
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725181504; cv=none; b=JA7nwI1T01hjDl4yT6vxfJs4/Wo3HqR4u5kBjCU42yAHMFEBtTwCAJZhUv5TTcXfhJXKilXgng9Y7tnleML98TEjYDDiY8B6qlTe+m6xRWZUJRcNTtQgk0JRkBLNB2o7J9R7BCZZpX+IwPvAsBvB/e/rqli3nhfenhL2o6EbPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725181504; c=relaxed/simple;
	bh=eXxBAkYNUWmhXHCnA8jZ/DIIgoU2cLu9AS4JGwXSoMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOx738sISFIVkeCtnJq4oXFwikF5DLqRFD6+0kLyUFVarkNbJbFvErn3ZXiHzggAB2EEp/VQ02gtHfpIQnWK+L/Dku07xgTSr2kok3rEW26hiq3u2z9eUkYCxfgR8SGU2gbIMTQaVw3Nu+mlU+/SyNKnfI+OFnhUViCUcTGrflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.10])
	by sina.com (10.185.250.21) with ESMTP
	id 66D42E09000012DD; Sun, 1 Sep 2024 17:04:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7048993408335
X-SMAIL-UIID: FAC59D2F4F594A308E2FDA37C00BA195-20240901-170411-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_recv_frame
Date: Sun,  1 Sep 2024 17:04:00 +0800
Message-Id: <20240901090400.1493-1-hdanton@sina.com>
In-Reply-To: <00000000000096680f062109ec63@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 01 Sep 2024 00:39:27 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    e8784b0aef62 Merge tag 'usb-6.11-rc6' of git://git.kernel...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dfdadb980000

#syz test upstream  e8784b0aef62

--- i/net/bluetooth/l2cap_core.c
+++ l/net/bluetooth/l2cap_core.c
@@ -1797,6 +1797,7 @@ static void l2cap_conn_del(struct hci_co
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
+	cancel_work_sync(&hcon->hdev->rx_work);
 	hcon->l2cap_data = NULL;
 	conn->hchan = NULL;
 	l2cap_conn_put(conn);
--

