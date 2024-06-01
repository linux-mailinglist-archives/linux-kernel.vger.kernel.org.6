Return-Path: <linux-kernel+bounces-197782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91CC8D6F15
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C691F2465A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F314E2C1;
	Sat,  1 Jun 2024 09:07:31 +0000 (UTC)
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB941CFBE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717232851; cv=none; b=h3jzgFXJkkqQo095gYWZxO7/1bR72xbIEDNIz4bT5C0ThvMIWFWh4CXMLWZsKDzTMPkATtYpfioy10AB3V13U0HjZcooQqOSkm3+fP7seVAJHAq7pbNERzfPWSEEdo20W+QaRjCS4BoGwDc1lk9T02tVbTFzA3+RB3ruy6zJyt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717232851; c=relaxed/simple;
	bh=8mispSm5LAS1dd6YXjvy47vFNymtXBnRasSceVyclCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4hde41HUMvXIcO/JqvlwNukqLNFMGo7poSeaLwS1zGIGWkGQHbpU11WxgsSGyh6Kb8pjvyblzCivIKJJPX7FsDjnM17SmU0WjMC0DAH4ABJRo+R0+ZQO/zfwy3hNGH265Dlhiy68a95xuBYCv3jZVcNJH7te47ba2rLUVGXg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.165])
	by sina.com (10.185.250.21) with ESMTP
	id 665AE4C00000105E; Sat, 1 Jun 2024 17:07:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8807393408336
X-SMAIL-UIID: 8CE89FD4BCE94F99AD68A663130A9332-20240601-170714-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+54594368fbd5a4f1754a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in kcompactd (2)
Date: Sat,  1 Jun 2024 17:07:02 +0800
Message-Id: <20240601090702.3550-1-hdanton@sina.com>
In-Reply-To: <0000000000002304860619cb8aa1@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 31 May 2024 20:17:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    2bfcfd584ff5 Merge tag 'pmdomain-v6.10-rc1' of git://git.k..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17314572980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/mac80211/main.c
+++ y/net/mac80211/main.c
@@ -427,9 +427,12 @@ static void ieee80211_tasklet_handler(st
 {
 	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
 	struct sk_buff *skb;
+	unsigned int loop = 0;
 
 	while ((skb = skb_dequeue(&local->skb_queue)) ||
 	       (skb = skb_dequeue(&local->skb_queue_unreliable))) {
+		if (++loop == 64)
+			return;
 		switch (skb->pkt_type) {
 		case IEEE80211_RX_MSG:
 			/* Clear skb->pkt_type in order to not confuse kernel
--

