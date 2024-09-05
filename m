Return-Path: <linux-kernel+bounces-317951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C15CC96E5E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFCD1C23563
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1111AAE1A;
	Thu,  5 Sep 2024 22:51:27 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B711474CF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576687; cv=none; b=ExpkQFAizUWuwnUZM/m5tVVf6DkWaxGUWt23+CrNEUW1yLmZ62s2YJ9z04YLrn4H32D5BFN3jqcTmlz8XdJbJck0so1kOyjO5sK2wUJyLS7OwC5n7n5ISYj0gLQuTiUcDnL/YPE1+Z6PLHvTYjrl8rZMPmikj5e9Ku4z3NAAoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576687; c=relaxed/simple;
	bh=LqlIGOS5olucDvh3XtJsmB8LAMM807SqpWDQDL81P/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJ1e/IdGd4eqGHbVvSq2WNCU7UwPfDyhafcbPN/hGrelum5cREHn/mzkpK0xu0As0XaZ1tl5pHI1RheHPzxQlF4HwEaqQcZVOb7udkm8/OOxuGGXh0sqwp+WHw0w+os2+1HQiqoc/K7+AvGQz6l+eY5cWQ8PlGXDk26cLmAErSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.67])
	by sina.com (10.185.250.22) with ESMTP
	id 66DA35BF000002E4; Thu, 6 Sep 2024 06:50:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8813587602596
X-SMAIL-UIID: 4CD3F9AA85E44671B5792593DBFA19B1-20240906-065041-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Fri,  6 Sep 2024 06:50:30 +0800
Message-Id: <20240905225030.2026-1-hdanton@sina.com>
In-Reply-To: <00000000000083b05a06214c9ddc@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 04 Sep 2024 08:13:24 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fbdaffe41adc Merge branch 'am-qt2025-phy-rust'
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d3fc53980000

#syz test

--- x/net/unix/af_unix.c
+++ y/net/unix/af_unix.c
@@ -2634,6 +2634,7 @@ static int unix_stream_recv_urg(struct u
 	if (!(state->flags & MSG_PEEK))
 		WRITE_ONCE(u->oob_skb, NULL);
 
+	__skb_unlink(oob_skb, &sk->sk_receive_queue);
 	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
--

