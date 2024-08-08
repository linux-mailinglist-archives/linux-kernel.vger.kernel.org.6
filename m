Return-Path: <linux-kernel+bounces-279291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C6494BB73
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0670B22596
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D718C34D;
	Thu,  8 Aug 2024 10:38:26 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71D18A926
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113506; cv=none; b=b7cOLBD0K842GhizCJ1SIoYFG0+BQLgSN4AO08ycZhjun5zUB3MyKr1cclyTQeIxQMD5D9NrKk6ldMgzTE6QWJgwZIvNCdOifvE8dUAukLY0Ex2JGUmrV8w7jYB3MIhXMAbh9j72TlVWdkYwXINqOlEq8eEzFjBQKL9v9WenpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113506; c=relaxed/simple;
	bh=kODzgVI1TluZZIddHpBvW0ElTZwEdXb/qgX3yNC7Awk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NgrfFcOnKuD/pNB+b4oT59xc2syvHClSDgu430x7NOO5VYorR4UgGki46SvWaeJcXB1ng9BBFYfxTvzZ54sV1VTrcESGHtuS6QPqZuCzXOfZzejPd/qFmBArnWj87I4yFa7Rj7DUJA0Iw3+Zwp9StPW6+oj8P8MFAJHzpgI/TxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.75])
	by sina.com (10.185.250.21) with ESMTP
	id 66B4A00A000050AB; Thu, 8 Aug 2024 18:38:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8245633408333
X-SMAIL-UIID: D51D29BBBD6740BABCD5E7D8CCCA9FD9-20240808-183805-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pm?] INFO: trying to register non-static key in netdev_unregister_kobject
Date: Thu,  8 Aug 2024 18:37:54 +0800
Message-Id: <20240808103754.2783-1-hdanton@sina.com>
In-Reply-To: <000000000000795a2506196e7cd5@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 05:16:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    e67572cd2204 Linux 6.9-rc6
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13274a87180000

#syz test upstream  master

--- x/net/bluetooth/hci_core.c
+++ y/net/bluetooth/hci_core.c
@@ -2598,7 +2598,7 @@ int hci_register_dev(struct hci_dev *hde
 	if (!IS_ERR_OR_NULL(bt_debugfs))
 		hdev->debugfs = debugfs_create_dir(hdev->name, bt_debugfs);
 
-	error = device_add(&hdev->dev);
+	error = device_register(&hdev->dev);
 	if (error < 0)
 		goto err_wqueue;
 
--

