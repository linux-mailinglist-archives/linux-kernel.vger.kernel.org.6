Return-Path: <linux-kernel+bounces-322780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B5972DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841A2287164
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB647189B9C;
	Tue, 10 Sep 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uza0g3hD"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F39188CAD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960739; cv=none; b=qgiu4VStyJUcpT6njf4X2NGNRPAMw3ybrMs34ndMNo9nd5qWUcS524NV4LeDYgBk1/OI4Pd4twO5w5q8VAddr3mPaWd11bI9kFSSmt4IB1vg5o4hFK3x0QynBZ3SiT2xRKjixoir1I7wSqXbBv3dJdW14cuQcgadrOQeTMW4cpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960739; c=relaxed/simple;
	bh=NLWKnCIg+o8uYWaLO5ievKLkddLxQwnpuVIJ5uk+2q0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tzQKr1rGpoUqODQ1cHoUoUTez0oF1k2FV8cKiF4KoAwRL0puxFklIbUR05Rf0N/p/j3mZszVZ9isv9x4eI2xpDXq0iSyZRETneUCOnYPCO4F8xwmqxO2U0p+bdhIhHg+OVxJKVPhxuXnzSN4l6gd0SZdHhqA1CpK065YI1yhoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uza0g3hD; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725960731; bh=8RABSgggzu/2cmB3fJi7czlxJ2Rzu4SS/+kE49C9gAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uza0g3hDRvKt2eUkDS3Kk3YZU41DGE9HUIo8cjw73aiJz8p1spe6v4GydgOKmP8IM
	 L3MPN+Q5Siyx+n95ZXQJKSFAW498xsvAy+5TLmOJpCYQ+TkxCGoa+g7kN2YjxbdIsz
	 S4zxhYLu144eLCffNfMjTsF3sh7gBoCl6tqslT34=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 80A0FA99; Tue, 10 Sep 2024 17:32:10 +0800
X-QQ-mid: xmsmtpt1725960730tp335xwlu
Message-ID: <tencent_39E577CF66F23C93361697B036464B627409@qq.com>
X-QQ-XMAILINFO: NJ/+omVLhVga0va2TCxEoHAhlGFRF7zdoH2BvV3DBR3VaO/TtwkvEQ6siMve9f
	 CjMyyG3hW8VlJJlWNT62pHdPbpZTJM4Y1pBU9F6ZEXcvC+QNI6dkqn+ONEEOQjoBWC1/BhYccsbw
	 f3y4SPQ/aRQuzz3nAtvlwo7LZ5f07zanQCR3Cf2kbE+pnzY5YiADrN39tkWXIzXyCu9XHNe/s/q6
	 fa/ACoc60p5WxcKDCr20mME0FlTKQ9L4NV2dnOVHJMIS5Z5sAIeWK/NTVx9zTj2pw0Q1Z88fuKGJ
	 D2P2zM/gdHm5QL7BZTzdmSmJxJdJ3anDpCOMAbOTKeCtSWkUxQzUw2FDWMybjpo6bVDtROdjRHP9
	 EkmQfknYCTEPwKcPmDIanERou5N3eAX5k16zyndos8hjE3NBOPiv23B+YJzF5Fpn+Ur2aZG6I9ME
	 aj18+rfLsDemRtJhOJyDJ3WSzMM82iL1oIdsR0wVwB3nTS0b0rhIdeDPhQQ2R67u2BENWPieF/HJ
	 O3Sm1MAbASBjwfn67hOTavjQKm5Vhvgl+D+stoPiH2qxxmtyyHhTY7wbnsBvrSqVrKoz/wHj2mRo
	 mYOndc4dOCaxFYTA++EiR7REx2RvHCXnxZJ8c1eGVdv4jA+r9pLNUEczco9Fm+tvsedtr65bo+q1
	 zR9333ZlSA74VZ0UNYkM4uSGKVHCqF3I1KPDhQGEBfjPSvsIJGR4xtZx4wsdIVojhUkwqEybv+lq
	 2v5uyFjQ4iP3DRzaMdmGu2wVEBqeFCNSqruKOWotYu9KqiOmGklzZeMUKQFsjCkPbEhJojBSq2TK
	 HqxKjC1IVNa0FGspMfITQsslowlToSa//enZF8J1NJf/H4dIcZjMcJpCVzb9Tjf4F/mZJ0OlSTpU
	 wxet1bmsHFF/8E8RjWJ/4n6mdFsSHsy4QlOibjt5h9ycrIDa2cvS6mfMmrvyS5QARN3e3azV5B7/
	 xJHB7w8Ds=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
Date: Tue, 10 Sep 2024 17:32:10 +0800
X-OQ-MSGID: <20240910093209.2595635-2-eadavis@qq.com>
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
index 3e4ad801786f..f195b577c367 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -331,15 +331,21 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
 
 	return entry;
 }
@@ -1430,7 +1436,6 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		list_del(&entry->list);
 		kfree(entry);
 		return true;
 	}


