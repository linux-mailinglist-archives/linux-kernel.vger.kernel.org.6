Return-Path: <linux-kernel+bounces-445681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D09F19A0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6477D1887BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3445B1B218D;
	Fri, 13 Dec 2024 23:08:53 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5E1AED5C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131331; cv=none; b=YJthkM32/tGZ3fCLW497ZlvQxGOeyLlm5AjTvMHmU8Sy71/ml6DEX8v/D6tzRlRhjMktFahNAWhE2Jh9Dx9SIVJVdmlrSui2w8eKIgkcBSW+P6Bp+UK0sI4sVj8nl9VAObsEiBHukI1yayJRkUAFw5mWVC1J/94mfCfl3r57FH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131331; c=relaxed/simple;
	bh=574geqgrCvxBHE53U1Huo+MbTMWwGYYgbCRZYx76LBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPndcyy10eHGVNGFxbygweDcaxpWvdwkXOwsjjmj7ZXaTMuS5V9B8NaZWI5GcAAGRY55b77eJVtHlj6TO7SqXv4i8ioeOxfC4LZRwhpN2m04oTphScCdPJ5JuD0jfswlciVh0zFdiAs4zaHoOID9HFSPt1eI2pSiZiDGSyLeXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.238])
	by sina.com (10.185.250.23) with ESMTP
	id 675CBE6E00003624; Fri, 14 Dec 2024 07:08:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 512638913054
X-SMAIL-UIID: 3BE65FF4A60141BE9018ABCAC0CE0B48-20241214-070836-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
Cc: edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
Date: Sat, 14 Dec 2024 07:08:20 +0800
Message-Id: <20241213230820.1957-1-hdanton@sina.com>
In-Reply-To: <675b61aa.050a0220.599f4.00bb.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Dec 2024 14:20:26 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117844f8580000

Test fix (https://patchwork.kernel.org/project/netdevbpf/patch/20241212222247.724674-1-edumazet@google.com/ )

#syz test

--- x/drivers/net/tun.c
+++ y/drivers/net/tun.c
@@ -1485,7 +1485,7 @@ static struct sk_buff *tun_napi_alloc_fr
 	skb->truesize += skb->data_len;
 
 	for (i = 1; i < it->nr_segs; i++) {
-		const struct iovec *iov = iter_iov(it);
+		const struct iovec *iov = iter_iov(it) + i;
 		size_t fragsz = iov->iov_len;
 		struct page *page;
 		void *frag;
--

