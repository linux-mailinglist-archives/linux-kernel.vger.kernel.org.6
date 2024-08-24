Return-Path: <linux-kernel+bounces-299998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FE295DD67
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648202834FE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEFD156242;
	Sat, 24 Aug 2024 10:39:31 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA864A
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724495971; cv=none; b=EZYGfiLN0pQwpq9H4juieRjxJ7ng7BjP2QGIvn8RgaVjv4lupyIbJUo0MrllHlp7S6EfP+TagdQh/tEpbMIU0vSbi81kWjr6Y6mdqNdxad+zfg2+q0yyQx6SBFDeaw0+hDK1LS0+HAhzjIBDj7EhYMByeFe58r2mg6bSah0At+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724495971; c=relaxed/simple;
	bh=2jiFQhCb7JrwB0zl4u5zvO9/sBWiMugJAVbVzdI2Hlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNSLFRS7eT9vjvYxXcQQUWbvpLjC8vDxnHsTrVZya/yn7eUE+bWqWPm5q5IWMKD/LtxoU8diIsXLes5TH9vSfKcdCYou5+htHRtc51uy9trtF2XgN5C51DMuDpGhAzajsxqM4sn/9zcIyEZMx9+aUEz4ntpKHndQIMTBLKPsF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.5])
	by sina.com (10.185.250.24) with ESMTP
	id 66C9B83100007901; Sat, 24 Aug 2024 18:38:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 27793510748239
X-SMAIL-UIID: 36D6A1D80CA14C55B17D80E4F21E215B-20240824-183847-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
Date: Sat, 24 Aug 2024 18:38:32 +0800
Message-Id: <20240824103832.1203-1-hdanton@sina.com>
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
@@ -179,7 +179,7 @@ static void sock_map_del_link(struct soc
 			sk_psock_stop_verdict(sk, psock);
 
 		if (psock->psock_update_sk_prot)
-			psock->psock_update_sk_prot(sk, psock, false);
+			psock->psock_update_sk_prot(sk, psock, true);
 		write_unlock_bh(&sk->sk_callback_lock);
 	}
 }
--

