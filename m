Return-Path: <linux-kernel+bounces-228686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DCB916564
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E321281FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304D1494A8;
	Tue, 25 Jun 2024 10:40:41 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0CD11CBD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312041; cv=none; b=OUfd6dx69mvosQP47CQZcY2hg/xsBM6Rv3FYe87CJh2+uAyQv1ejBxPgh2PXMzsI0JO+9QUUoYYUXTMGJD7ina6yuZEao7fRRogMVYJhCZpVntzpiKK3ZldME82GyXcx7AVIXyh90+5LkOmvlOeUsI168Yys0r/N1WGCbiQK+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312041; c=relaxed/simple;
	bh=dKfAK8plA4IahhHvqwTPlagtmVUVjKb28291j0EsxqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZCZzEfiHvWHgbxAFf61B8yNb9/EjNgoX4fvXQe0/5Cn2ign9xSBRL4tM838hTAtS8i2YvMyrJ0b6MclBLib/WJ9e1Lx3rQl29o5+zhWqWJuC9ryaj8tP4OQadTlsxbhmeKTGeBGEvYQB09SqQHsIQ9n0UrcXwocJtM7zD7hILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.32])
	by sina.com (10.185.250.21) with ESMTP
	id 667A9E95000009D0; Tue, 25 Jun 2024 18:40:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1686863408362
X-SMAIL-UIID: 47D335CAE67D4931B159B6E06EAA91C5-20240625-184024-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot+f115fcf7e49b2ebc902d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sk_skb_reason_drop
Date: Tue, 25 Jun 2024 18:40:12 +0800
Message-Id: <20240625104012.2056-1-hdanton@sina.com>
In-Reply-To: <000000000000387998061ba467ac@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  2ccbdf43d5e7

--- x/net/bluetooth/hci_request.c
+++ h/net/bluetooth/hci_request.c
@@ -160,6 +160,8 @@ int __hci_req_sync(struct hci_dev *hdev,
 
 	if (err == -ERESTARTSYS)
 		return -EINTR;
+	if (!err)
+		return -ETIMEDOUT;
 
 	switch (hdev->req_status) {
 	case HCI_REQ_DONE:
--

