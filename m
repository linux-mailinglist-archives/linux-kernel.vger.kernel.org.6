Return-Path: <linux-kernel+bounces-411937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5EB9D0180
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627DC284C5C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534097E9;
	Sun, 17 Nov 2024 00:04:46 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF4638C
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731801886; cv=none; b=LXcAcneAGC0Dn0faMjAyRqpQ7Pa14XB3NYlFH59L2LPSgejYJ3uWszRFO0vR0+xNd+RUo6F5SHvmutc2miq8fv/IN8AULjpX++v2sI/99vOaVEtF3lTdfN67Zxa9pYzlaqWSnI4ZHqY8NCPksvyK/yQjlqVMo53ttCWc8VBxysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731801886; c=relaxed/simple;
	bh=i6b/yIsSvZb4T2a7FoaH1/7TqIKGkgnZWaavWoFrOLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTDRdTPTYM6/x9GunGsZ37f0IbGC3r1bd9JIXnw1CR6Sm6J8DpUKtmxvBCW0zTPCwUSBdc/eSX/Hr0b7GjoNMl9DMVV3q4DtwexlQRJ6bvLoBbxeKPTHfh5X9dWzrHkMHICXk69lJJSGRSQZLEb3/tJatHSMV9nEStR7UjoDsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.242])
	by sina.com (10.185.250.21) with ESMTP
	id 6739327800001260; Sun, 17 Nov 2024 08:02:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8350033408272
X-SMAIL-UIID: F732DA9C15834E2389E48CB1747C11F5-20241117-080204-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in sk_skb_reason_drop
Date: Sun, 17 Nov 2024 08:01:54 +0800
Message-Id: <20241117000154.1285-1-hdanton@sina.com>
In-Reply-To: <6738e539.050a0220.e1c64.0002.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 Nov 2024 10:32:25 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    a58f00ed24b8 net: sched: cls_api: improve the error messag..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f481a7980000

#syz test

--- x/net/ipv4/route.c
+++ y/net/ipv4/route.c
@@ -2478,7 +2478,7 @@ ip_route_input_rcu(struct sk_buff *skb,
 		int our = 0;
 
 		if (!in_dev)
-			return -EINVAL;
+			return reason;
 		our = ip_check_mc_rcu(in_dev, daddr, saddr,
 				      ip_hdr(skb)->protocol);
 
--

