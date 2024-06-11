Return-Path: <linux-kernel+bounces-209164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54283902E14
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FA8B21ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A2A945;
	Tue, 11 Jun 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XJ+EAXeo"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2022D1FA3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718070844; cv=none; b=UkCq8ctL2sREG/XzljKBl8UJk3sxYoWS0UsP+PjzduLEysuUyV9wCRR+dPtBoC3DCoxSRea2F6IcQ27JZAnkkhpcZgHk9VU+r6T3pH4yON2ReiDjMLZ9WbtL78Vkk5YVXgizA/WpWVshD4f3Ei2g9Z1I5ED9ONydwJ9GP682xkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718070844; c=relaxed/simple;
	bh=k4Y7kkz0aoKWT82c3g+PFok6O4oS9oOG5rUGQKeerPY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MPu+qfbovCbQ8BEDJWGk6JDuyR+PROmdOwVEormYccOL2qkik17jAiJrSTkVKVYXqsoKuOwSZ+nO+QWCJFiK8Du3t2CdVk0rDVw3Ro1aJzVxeF4zcNmSsG2ydPW2awkky90BigetP8CJ1ACEA2HZ+5y9pGkYipTEngDTpbgMRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XJ+EAXeo; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718070831; bh=ZRrGuQhe88/DLxfIY3t6CcASDCJaj4Bk8hzkccUEo8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XJ+EAXeoawQUP1uSdU3iJHVFB0SjDY+WQ4UnzUXWHV82am6D7px3QLPTM5EMOK71l
	 KcPkTsEIbUFRoJTs1lc4yrh+Jw0UG586Bov4Zi4AW/Oc8pUPzJdDREeiDaotb4Q18P
	 2mHnlJzGs8P0zCBkjgLtjzV4DPlWKGP6wFCPBgPM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id BEF9F2AF; Tue, 11 Jun 2024 09:47:47 +0800
X-QQ-mid: xmsmtpt1718070467t2kj68biw
Message-ID: <tencent_8136A297D436844B76745177E567363C7309@qq.com>
X-QQ-XMAILINFO: MmCmH9jyqHC2dpe6Ni381Gyl9I1nBf5k8smlKi6yBD4PvRNvsIUW/zOTWhdGDM
	 7KGrlTiowHdwQi07I/eIm4Irt1oJeKNh4wXDTQG1jrMF+lTuip/fJ+QR779u0BJkxuLrpOXwt/wM
	 H+nlbfZWVNFKOQLGGYe6Q/o1PBSNPz5Ll16POtUTUKGNPYkJQiwfOMLmlFZFGdBsq2x/RaeFuFEU
	 nqPUx2gklJ2UurSe98xu5gHNj3GUmeW5hJi0/1TFrMOsNY2B6ywfUWL+Gp+s5JTo/fe2SRu6LUBu
	 lN+EL8iMN/siRn4RX9geqoeNKobrVF2hzt9fdsvRDjvxv12+gN2px6Shf3RrFiPGfrscc9WBP6l1
	 QAlgKIAeD+trxToASye5HCU5A3QVv+vTmCyDj6LUFmEx3yvfWCSZsMVTx8TnsU9liddl6WPGmopG
	 U0i5HYdEf1fUH/TAXXt8D0CPAREsXn+HknekPdnLc1dgVxx7X9I8jVEM71prqvIgHnOnpzIHxyMm
	 iCE+7qy0SVymGg+MwtgQvejm3jov0M3l+iU4zB6M/dhtVVKJFtKXzeIkDcd6SXAWeIjqDOBvjmDa
	 +y91gsRNQJWztJDhnk/TFPb5euKDwjUwxqy/YFllgaiewhnKsNBzKgfhuSetJGH2OfkhajZTMzO9
	 PvPtokKClkKmq6ZIvrbRoEPU1d3odzTGMYvyI5qdv3D/hZO5e9eb3EVP8up25YVvRT1N0u6YyDDw
	 AFKZWdWt9CI4q8k/LB9evvPVrsQdzBpUMRDmqWxk3T+ksqDgOno02zQ8UpPsAPiC2dgZh6G62GsK
	 3BRsbCw4n+qyT+BSwTe9udKw2Esw/8Ln+W12NVUrWfKP2F29zAmEHLzJjs6420HOI0bJHyjODMbz
	 fsxpWVbxPMt6Fogk6cOED4vRpoJPvve40AxjWE2ne7HMv+0+XoxPfxf3WMyNFEpQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Tue, 11 Jun 2024 09:47:48 +0800
X-OQ-MSGID: <20240611014747.1389085-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b0906d061a468b93@google.com>
References: <000000000000b0906d061a468b93@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr defref in l2cap_sock_recv_cb

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cc8ed4d0a848

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6db60946c627..68b57ef01c7d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1506,7 +1506,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	err = __sock_queue_rcv_skb(sk, skb);
 
+	sock_hold(sk);
 	l2cap_publish_rx_avail(chan);
+	sock_put(sk);
 
 	/* For ERTM and LE, handle a skb that doesn't fit into the recv
 	 * buffer.  This is important to do because the data frames


