Return-Path: <linux-kernel+bounces-300023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC2095DDAB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750D51F22332
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58A1714A4;
	Sat, 24 Aug 2024 11:57:32 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87401547E0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724500652; cv=none; b=fc0eOrBYcHGed9nruNNuDavVWN2jhN7eqGeF2/eiFTRBPpYFp7kTGRNVd72kWocNGmqoexSL82nvqNV/fPkGgaCe5iryWqwqcyItvvYOqwEzM5sfcL5+ddMwQhTHEZHNMV4x1DvktXoWjRzbpqRT1opKbjs/fqIYws33hGoRqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724500652; c=relaxed/simple;
	bh=yFc8ZTwH9bDo5a9CHzIWQZ5taQz7Ws1ODdCrZGBcVrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpV2PW6Aa2243sSzWXv24iXKAgpHDTSqwgO/pKrBF728DVA94Dllf5LROUXqveyZ1xdgLhEkTa9mjfnGWte64SeDfk1COPtHjtdiPzlk4UJehh3IEiX+78YR9MgWh4NXr2Nuf0fUTVP5iV6PZh4QdHoagg+qzkkbiGT/Fglee2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.5])
	by sina.com (10.185.250.22) with ESMTP
	id 66C9CA9B000056CF; Sat, 24 Aug 2024 19:57:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3403197602803
X-SMAIL-UIID: E77C233EDA874F0B97C18D0BD5A5A6FA-20240824-195717-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
Date: Sat, 24 Aug 2024 19:57:05 +0800
Message-Id: <20240824115705.1267-1-hdanton@sina.com>
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
@@ -178,8 +178,10 @@ static void sock_map_del_link(struct soc
 		if (verdict_stop)
 			sk_psock_stop_verdict(sk, psock);
 
-		if (psock->psock_update_sk_prot)
+		if (psock->psock_update_sk_prot) {
 			psock->psock_update_sk_prot(sk, psock, false);
+			WARN_ON_ONCE(sk->sk_prot->close == sock_map_close);
+		}
 		write_unlock_bh(&sk->sk_callback_lock);
 	}
 }
@@ -196,10 +198,13 @@ static void sock_map_unref(struct sock *
 
 static int sock_map_init_proto(struct sock *sk, struct sk_psock *psock)
 {
+	int rc;
 	if (!sk->sk_prot->psock_update_sk_prot)
 		return -EINVAL;
 	psock->psock_update_sk_prot = sk->sk_prot->psock_update_sk_prot;
-	return sk->sk_prot->psock_update_sk_prot(sk, psock, false);
+	rc = sk->sk_prot->psock_update_sk_prot(sk, psock, false);
+	WARN_ON_ONCE(sk->sk_prot->close == sock_map_close);
+	return rc;
 }
 
 static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
--

