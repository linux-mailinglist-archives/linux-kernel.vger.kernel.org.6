Return-Path: <linux-kernel+bounces-299940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2EB95DC94
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B8F7B21A4B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389171547CC;
	Sat, 24 Aug 2024 07:43:41 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD71DA5E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724485420; cv=none; b=dKZGulLYgk7tCcAmRrCkp4BkpBjMKUgI0K8nEpyCX2cBYy3QIh7qY6OV00jnzJ9c5LNNljKtOBWiM5OhGobl8yvWWXTWhTcW0GaZdTHgkRKwU0/09DAmSPW2An/Dyy55JwwYsS7mJZQl5gQLz1L+uaHg+31xr4+UDBa7AdcpFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724485420; c=relaxed/simple;
	bh=zASjSV6Nkl5RL+yRI0kI6F8olqzuBSPiXnCxf8gHgiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1z5MWWG4XChNTW2cZ5A0c4KZLNIQqvnR2si2bmy2xjQDV0JdO6KQQfp4/QAV2wkMIcK+iRcOkSGrO1R5ZAPIrU7vyC7UJSU3Ts54viHgzqwqbINrB4Qm40BfA5QJ3IV+KiaUpKTqZUmLOUSx5p39WO7si0Om1GjNSFvstE4VS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.5])
	by sina.com (10.185.250.22) with ESMTP
	id 66C98F1200005279; Sat, 24 Aug 2024 15:43:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5482087602703
X-SMAIL-UIID: 3D07A5BD4D19486E95E74C6B6096762D-20240824-154321-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
Date: Sat, 24 Aug 2024 15:43:05 +0800
Message-Id: <20240824074305.1131-1-hdanton@sina.com>
In-Reply-To: <0000000000001187a706204582bb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 22 Aug 2024 06:19:27 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    d785ed945de6 net: wwan: t7xx: PCIe reset rescan
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12378c33980000

#syz test net-next  d785ed945de6

--- x/net/core/sock_map.c
+++ y/net/core/sock_map.c
@@ -209,7 +209,7 @@ static struct sk_psock *sock_map_psock_g
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock) {
-		if (sk->sk_prot->close != sock_map_close) {
+		if (sk->sk_prot->close == sock_map_close) {
 			psock = ERR_PTR(-EBUSY);
 			goto out;
 		}
--

