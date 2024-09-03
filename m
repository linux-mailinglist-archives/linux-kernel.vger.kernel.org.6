Return-Path: <linux-kernel+bounces-313040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96275969F67
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3BA1F24091
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1381CA6AD;
	Tue,  3 Sep 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xtyGCyxM"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0323C38
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371570; cv=none; b=biYQc3lzxh02hMZxo6D7DN4+WgzH+D+yy8uUj+tv8lG4QA1KKFmB+yPL40QuEbc04O5oWa8H3S7tAIFcXm+kC6wpH9wvucRs7B95i0NoY5pcT8n3NBL9mxnmCAARLvYZYVcwASoWlA+EJ0uNt/Zv7KMVK398qs0iCvokD8AE0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371570; c=relaxed/simple;
	bh=Qchee+0RNtaaELXAIfuBAUamxVkgobY8iONuLVQco5Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iwa7VN4ZCRyOT8/W8s7N0nKMCJivzMKGZY7RvBYhIoVVtbUtD1F7Om/Z6bzMLngF1Xo7iEzELcva3ZH4rou5Yi828E3napU3oSlwKONwl8GkBFrz1kNcACo7QSdcsArpWLpMaytJfz2aRAF+trtQR8M8HQgb7ZFTsVpqgYp0mHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xtyGCyxM; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725371557; bh=fevg39+RHWzdbFpNxIkdCNAZJyXH4MlrR18xlYxNMNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xtyGCyxMOGsWiAdrKIjW3awU46U66LrUvP/sqcloOLopOXuEr9sAaWpSoPRYqRREL
	 tavuCEnjxQAPMOFR7aN89p9ok0AsXiQH0G2T0l+1tJaygGxBHwHSSdCI55+5vmL0ab
	 nD20sw9a9HFSDQSlRQPZZS9pQ+I2gOIe4UPB01C0=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id D23B728B; Tue, 03 Sep 2024 21:52:35 +0800
X-QQ-mid: xmsmtpt1725371555txjam4d4v
Message-ID: <tencent_DF6D237A296523A8E45177687763C6C2B305@qq.com>
X-QQ-XMAILINFO: MeezYcwNx3ZfsgzWG2Bw9SnZRZPh/OQs3h2tH6+Wpdmb4NWzOfhqq1ew94I6dm
	 Cip4y2yW/BQvcNeoErjMDtp9sFe+dMn4r5DStc8XhciH4SqyoiWkNjC0622AaQ1byW4OjVmKbaot
	 sVFYqX7uAhLVDvtLXThZQlYr2mlzbWZYT8tVllfspkDbNglRgFL8V2OUHVPa5hQtvPiJyax0Zsqh
	 5KyPbL0juxfaTOHFbxGx6BHu5UDER6C1uFOH07cBDeIvKYTL17IVTBRRap/W/TkbzuRNVuH9R3KR
	 JkHbU/2I+HZVCvl3x6gjAHIq/QV1h4zSXwCYietbdnm2QFiwC6ACWGEbhp8Qc0r3V/XFTAQWv0rL
	 nfElCf/KoQuV9s8XDXAKOGxG8cU8+STs/USe6NUTuHiyxMH+OFP6v54ZRL7u6rP+RpW/fTRwV6OG
	 Vwcqc3J5eyd1J5nVOQ/ayp1ZmTdchrBCTyXzJHTeh7f5eLI64EII/sNJebMD1TMPohTOhXBGHL89
	 +H5S7owG9xQJMHlEufEZQgp3LZbwSZqhC99b4Q/fFwZFuJxdwIBQK6ni9lFg9aVzNwm0rWyjPYja
	 DEvvyQS/vi9P86wOUqo3/W35ehKZBGWba3kprYQCvLRRrCswhRfiY025kDakly/iySMTpKuGNEU+
	 sRWVzjnrcC/B0eSukuECBk9S1AneCMfE/gn+m/bSsmY7JtpUHMmT4OfPkGrU+1jvmBM5SH+HpLIk
	 YWROFEZQvkzCEwG1nOkXzNBVn013V8yF59H/VCGZhjIpLOGfDo4utkLFNDnMKesGITDuYcEg57R8
	 3AkVrlRBCWdAHwNXKt1oTXMqMI2Dc6rMtCP7WHiI+I1Ll0S+YLephXHCP+PZQzdI30UvO+rV47en
	 f/z9OVbSm20VRyiTyVOgxqjTUA0v3WG8RfF/S1JgLbxUfxG5HFHlr9eKHGWazyWSDlpJruv9y0
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
Date: Tue,  3 Sep 2024 21:52:36 +0800
X-OQ-MSGID: <20240903135235.3264061-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000b341bb062136d2d9@google.com>
References: <000000000000b341bb062136d2d9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

entry need to be protected by pm.lock.

#syz test

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..06a6846e316c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -336,11 +336,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id))
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-	spin_unlock_bh(&msk->pm.lock);
 
 	if (entry && (!check_id || entry->addr.id == addr->id))
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
+	spin_unlock_bh(&msk->pm.lock);
+
 	return entry;
 }
 
@@ -1637,6 +1638,7 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
 
+	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, rm_list, list) {
 		if (slist.nr < MPTCP_RM_IDS_MAX &&
 		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
@@ -1647,7 +1649,6 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 
-	spin_lock_bh(&msk->pm.lock);
 	if (alist.nr) {
 		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);


