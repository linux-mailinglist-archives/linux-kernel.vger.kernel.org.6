Return-Path: <linux-kernel+bounces-300209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F25F95E067
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 01:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1AE8B21713
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 23:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA671442EA;
	Sat, 24 Aug 2024 23:35:13 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD639FE5
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724542512; cv=none; b=gqHT8/QHpyBwy7O6DgM84ND+acD4ROXS0z/PW6732ohlStu/RIBUtQ6l0WPLAY2w0PLyN5/Rv7hZT9O62f8sJQBSJk05dRYaTBwCMlyeutnfMZDicMttq/gOAoJEG3mp9DwHKlvIy/0Sh7clKkjl/eI6UyCPLBqloR2nSbFZPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724542512; c=relaxed/simple;
	bh=5yGyyrxDbSeBEeboQTLoVs9lTi87xvam8ezjSPMWMhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDKoSPrPhryyeO/NqHtYKVsaZsiTVcCl0+PPKCPXuzMRwoi71Hb3es2EDuREn6KdwcXdcoX4CIr4UN1PyJInB32TBB384fi2CFjz8zjfjbL8R5L/RmnTMfnJo61Ak0WeoWbaca+VHnPcDe5IN7TEhWSWdTLV31KWy7T0/7amCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.51])
	by sina.com (10.185.250.23) with ESMTP
	id 66CA6E1E00001AD0; Sat, 25 Aug 2024 07:34:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 452158913416
X-SMAIL-UIID: CE8E8F43DDA24BADA05A715485F7CEF1-20240825-073458-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
Date: Sun, 25 Aug 2024 07:34:45 +0800
Message-Id: <20240824233445.1324-1-hdanton@sina.com>
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
@@ -196,7 +196,7 @@ static void sock_map_unref(struct sock *
 
 static int sock_map_init_proto(struct sock *sk, struct sk_psock *psock)
 {
-	if (!sk->sk_prot->psock_update_sk_prot)
+	if (!sk->sk_prot->psock_update_sk_prot || psock->saved_close == sock_map_close)
 		return -EINVAL;
 	psock->psock_update_sk_prot = sk->sk_prot->psock_update_sk_prot;
 	return sk->sk_prot->psock_update_sk_prot(sk, psock, false);
--

