Return-Path: <linux-kernel+bounces-276010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD9948D32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD07AB27046
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A381C0DCB;
	Tue,  6 Aug 2024 10:51:31 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2181BF321
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941491; cv=none; b=ohmNTmV9cQddi4LIqQoZBsV46XmcWnH4nQcIgLE1Aoub4jVzxD/G+Vp11SkZjWT/NfXFNBLatH3FujTYp2E7+PjpbIN5BorVJfTxr9nFDfjtbOVXHKAyin73t0iYXmQqXLhA30QuZ2BjLns/OQfEUWv8ryjnLb9fMjAMJ5Pu5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941491; c=relaxed/simple;
	bh=L6P0WM96BT2R/yUyebIyUQxfqH2zTRgeQYUDZbf/FVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FM/FT6k0pbcw65XxxVmcxskC8UbPDLrlAiSCA41AO0wT1oNPVXrIFEvvT9btiZnu5Ywa78TnwBYcFy4jGkPF1psy6jigKut56tjpes4Pqcw/FOFYxdDvKL5muhLEZEKHG7z6awLQQiLIMEZYhcfF8QFQq33AoXCPBIVaTn+8neM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.152])
	by sina.com (10.185.250.23) with ESMTP
	id 66B2002200005C93; Tue, 6 Aug 2024 18:51:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6483658913460
X-SMAIL-UIID: 9C35B8A56B804044962FFA33CC185E40-20240806-185117-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5a1281566cc25c9881e0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_xtp_rx_cts
Date: Tue,  6 Aug 2024 18:51:06 +0800
Message-Id: <20240806105106.2667-1-hdanton@sina.com>
In-Reply-To: <000000000000b5bde0061ef65fc8@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Aug 2024 14:29:36 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    743ff02152bc ethtool: Don't check for NULL info in prepare..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162bd19d980000

#syz test net-next  743ff02152bc

--- x/net/can/j1939/transport.c
+++ y/net/can/j1939/transport.c
@@ -1505,6 +1505,7 @@ static struct j1939_session *j1939_sessi
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
+	skb_get(skb);
 	skb_queue_tail(&session->skb_queue, skb);
 
 	skcb = j1939_skb_to_cb(skb);
--

