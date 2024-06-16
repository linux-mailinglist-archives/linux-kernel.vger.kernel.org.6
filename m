Return-Path: <linux-kernel+bounces-216231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF517909CEB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C861C20A04
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F7186E47;
	Sun, 16 Jun 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iepyZUp9"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CAC16C693
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718532910; cv=none; b=hJHVKDaTl7UcCQNlQ+OYkILGvWD8j0CFSybtz3G8mfWDLGGZt8pDDUrUwZzxeENG/HFeaERa8jeBQQ85j8bc2cnbGZU62C5ig3843K1O2gCfr7j2YCJ1dGUPEtCFgQQ9GdVOT3l+38gPkUkgSAdtN/qISUJdwpXsPPpO2px1we8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718532910; c=relaxed/simple;
	bh=LCdGacQwPFIfe/ZlFMMdJTaKa5bQS8OLvSOiKyjGQ3w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JwuKE3siWlsyVH1NoLXQZYzxqei+vHnG1GNuoHEwFSiv2j9+WRCyJPyINQ+8sPSJfSEG4V0gfXs6cN8fYqpHi+D0enND1fnBy5Pgk3TsoF7TnF3Z9AUBFpE9+EX6g8DoUo7kizK//CnMqlD+qFDJsDis6ehD9yim8W9WDz1SdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iepyZUp9; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718532894; bh=nQAQUGvxdV9799RXPsMU4zrVkbRhR+J4U2lakqMxzic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iepyZUp9ISsvWhBfJVEWhVGqof58VWpXdE+wa8Yt+GZnO6fPaA2Abis40TKeHhWSL
	 Bjg/n6pVjycMshnQ1mMsFYQlAFGstbp7OFsFYAY8QwdO6w0f+YfEak5i+BaDIL7Ls4
	 hvuz9hURFSV+12ApAgF9eembG7nds8+bA4jNSU4E=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 3B520074; Sun, 16 Jun 2024 18:14:53 +0800
X-QQ-mid: xmsmtpt1718532893tfkc8v2op
Message-ID: <tencent_6816BAF4BB5133319E881BB64B071B662508@qq.com>
X-QQ-XMAILINFO: NJ/+omVLhVgaX/PYGcCq99TJv+z6+PzM4rN26h3RbGB+eJj7UkdTJNGJKVd97g
	 Qk6CDt4bctnkAkHiJPEVpdSTz+/wNCrExE28OLRYKGhjxKtwj63kFvxFkRNBArqDj+h3RqLqrYvG
	 hwec2DFAcq3XvcQc+y/diUx+5+yX+pmls49z4qMrD+5dLnjBlqyAR9UTODT9wuYPFvbI2jfTdCtf
	 DI5ghPezwCXuZco0TAX+Bg/cn2ZZ59gCvvyCz9T6so/AS/yEJ3GYqdFRa/Wex5sUm/H+10zG1gOv
	 50cDK62TAZ78gVxjtJzUuv4h4cyCnl3dhjUQFm4NCdxzJpSIA/NWvVgqDpC0/NePIojSqiaxWaKc
	 8jkKjA0g81PwBdRohUqDu+5occSxXvDTEJKsFqMbdgoCIYX7QLgYb3eHkMj0kp8yPv/+kQKlpMGw
	 XWn3Uh0dWzyQFzc+ORYH+tAJOFb5hJQHj1Swf+HVXT5DyM2LNFtRkQHwt3XwZ9syVIGjaaxbnnnJ
	 XU/H0MVFSDMgCDHrP3RjgUN7kBi46YipyCFUrS21R1trIEb/RQB/mVXYUNg4WsXb0PkBaP56dRno
	 qCFMdRn+aK9FvraMFtenv2UlWkZAR7Aw+FR3GMQLRACo1D/pI3EbRpqd9Su0tWYKEiKa5FMQREcQ
	 UrvuoINAIjmHJnV3qs18nOHArhJwQO3VzvROKNj3Mu46GOY3lKhO8IWWj4+IB+T5f3bxi480Pvy5
	 u3F/Tgv4Zm8pb8/trsnwvlZ4Rs9oOjkVOpT4gADo4Lgdn7lhj2Tq67s150A2b2JE5CgWJZ6vzVv2
	 JThT9v+TZEIj8aIvgVjX+35GgLlLVD51PDIKAMrnc56itzAzNs3F2A+MzRP28sYoJxAxYytbF27m
	 8mapIxAUaiF6KyrJfwcXY5K4v0+QVB57hid+mhtQCcAyXHW+uR8SimSl905Gt6aG1OGT9S0ANa
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_del
Date: Sun, 16 Jun 2024 18:14:53 +0800
X-OQ-MSGID: <20240616101452.407029-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000bf4687061269eb1b@google.com>
References: <000000000000bf4687061269eb1b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test wrn

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 603c04e27c3e

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a487f9df8145..4130d64d9a80 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6893,6 +6893,9 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 		bis = hci_conn_hash_lookup_handle(hdev, handle);
 		if (!bis) {
+                        if (handle > HCI_CONN_HANDLE_MAX)
+                               continue;
+
 			bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
 					   HCI_ROLE_SLAVE, handle);
 			if (IS_ERR(bis))


