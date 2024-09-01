Return-Path: <linux-kernel+bounces-310196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634596761A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C1D1C20D98
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B6B152532;
	Sun,  1 Sep 2024 11:16:34 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C22BAEA
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725189394; cv=none; b=ico+tm0f+jsI0jVywKhgbgxbwYvsggcCPP4JTSMNtdcP98gfhuLHh/Mqd2EmPV62NChNo5nowq9m1nXhlZFAifxoAFmuKIxw8KA12KAW9wEfWVRDkXwzAJeyP1HJOb5hv1Br6O3wZPGDekRE/WzMVLq+Tf50Gto7ejmAnsFVBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725189394; c=relaxed/simple;
	bh=afKCMEf+KZeJ2VGM/rwC3WE7YvSJ7N97XlnLn4TjjmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpeE4ZUS6EEUCnOeUfrbGbFbfzqmsK4tXu8605Vtg+BoXh9198mUIu4l60Tcvei7BSy8itZZW3JgmjzkUalvN55z1ndjz53SOgWkyUxcOzbqcTl9qYmoo3gtVrbhiFx+Zrn5+l6Zye2zJoLUDIlTNBZ314nUZFD2xijHG7lniMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.10])
	by sina.com (10.185.250.24) with ESMTP
	id 66D44C72000041E5; Sun, 1 Sep 2024 19:13:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 45131210748391
X-SMAIL-UIID: 87D31D67A9AA40D18CE32A77568B52DB-20240901-191358-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_recv_frame
Date: Sun,  1 Sep 2024 19:13:46 +0800
Message-Id: <20240901111346.1560-1-hdanton@sina.com>
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
@@ -6826,6 +6826,7 @@ static void l2cap_recv_frame(struct l2ca
 		break;
 
 	case L2CAP_CID_CONN_LESS:
+		*((__le16 *) skb->data) = 0;
 		psm = get_unaligned((__le16 *) skb->data);
 		skb_pull(skb, L2CAP_PSMLEN_SIZE);
 		l2cap_conless_channel(conn, psm, skb);
--

