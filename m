Return-Path: <linux-kernel+bounces-298735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C995CAC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BCE1F27953
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A518732C;
	Fri, 23 Aug 2024 10:47:56 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C713D521
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410075; cv=none; b=AM2vfuctcrUQTL5k9T9Op39bagJnq1zS0lAcgfUZ1TeZP15ebaukQSqtl1YcAkGH8RORLB7Z72utEoX+ml2Dc2fPtxqa0Q9zpOYm3KzHX9X8jhz7zVpjuQv+/cIN6JK0OmJpKY8iJqaDyG71EdORkXv/XUYFg+eDMim4L7+owzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410075; c=relaxed/simple;
	bh=A6J6xiZNRrhZETYydZWupvyBJa6I7vgoXv22YjBvF8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pMwyDSh6oKvfKDZKpuS57bE+S/KBngMKUgG5UqcwTliDLYbT8qMgwoEKDRjJh0/Z/UDRDqlgHJmY97XnK+gny3vrnf3+KHQh4HdDpcm5rbE0OykL2TUYgzIjXWxxCyU8zIy1kaUBzrIvx+E75FTe0jsa1WC9VH2aST8LUc0Z3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.110])
	by sina.com (10.185.250.24) with ESMTP
	id 66C868C700006DAA; Fri, 23 Aug 2024 18:47:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 65793210748370
X-SMAIL-UIID: 7DE4C8CABFD44079994B26527591E8FF-20240823-184737-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
Date: Fri, 23 Aug 2024 18:47:26 +0800
Message-Id: <20240823104726.1055-1-hdanton@sina.com>
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

--- x/net/core/skmsg.c
+++ y/net/core/skmsg.c
@@ -728,6 +728,7 @@ struct sk_psock *sk_psock_init(struct so
 	psock->saved_unhash = prot->unhash;
 	psock->saved_destroy = prot->destroy;
 	psock->saved_close = prot->close;
+	BUG_ON(psock->saved_close == sock_map_close);
 	psock->saved_write_space = sk->sk_write_space;
 
 	INIT_LIST_HEAD(&psock->link);
--

