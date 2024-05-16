Return-Path: <linux-kernel+bounces-181608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1818C7E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334EAB21BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CE1586C2;
	Thu, 16 May 2024 22:29:08 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC433FE4
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898548; cv=none; b=n1B+o52jX3Lw13gDoNW41f8No4F4tAUqJnGhjGJzp12o4K+wpfZmamddNz3+d+iSk9+3zkzRmo9xKUQ1eOFj2W2/H0TX2lHSD8812LISK1m5Ks1Dnblyx7UJzKRzA7UCV9zdWbVDETg2LuRzLDr/eUcMLUhd8n/AygtzTFvu7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898548; c=relaxed/simple;
	bh=ppWI4H1aSVqkxdG98CVqMb0ZYVfGm15mh0KBOlSo97M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZPkXEUSsbXZwYP3Mo7KQD0tIpgQ1zqA/Df+mWXmZpMVzbQ3wIUf2ePLaUEfkYZcrWiHlW3K21UFocRbBur/lrUV22B501ujVfqgOrEoXI5jXu71wfF2MGNK85M/XOp++OL0YSJmjn/DmMr9NRCpdpsaqDcSI/2GS5aJD7JZyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.72])
	by sina.com (10.75.12.45) with ESMTP
	id 664688A400005AE1; Thu, 17 May 2024 06:28:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 52501131458013
X-SMAIL-UIID: 27D5EC259CBA42D7BB4AF85E2E35DB3D-20240517-062854-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (6)
Date: Fri, 17 May 2024 06:28:43 +0800
Message-Id: <20240516222843.1500-1-hdanton@sina.com>
In-Reply-To: <000000000000051b2d06189716c3@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 May 2024 12:17:28 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    75fa778d74b7 Add linux-next specific files for 20240510
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151d9c78980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  75fa778d74b7

--- x/drivers/media/rc/imon.c
+++ y/drivers/media/rc/imon.c
@@ -1758,6 +1758,7 @@ static void usb_rx_callback_intf0(struct
 
 	switch (urb->status) {
 	case -ENOENT:		/* usbcore unlink successful! */
+	case -EPROTO:
 		return;
 
 	case -ESHUTDOWN:	/* transport endpoint was shut down */
--

