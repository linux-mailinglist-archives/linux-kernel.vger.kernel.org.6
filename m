Return-Path: <linux-kernel+bounces-329997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADBD97984A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAF2281805
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71AB1C9ED4;
	Sun, 15 Sep 2024 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="WGJ6ZMT/"
Received: from mail.rosa.ru (mail.rosa.ru [176.109.80.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF4D2F5
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.80.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426699; cv=none; b=jOU57CiBUgGiMq5sG84An220GKgVLaajNvZidOzOftOFU94qiHWhuEmkSGMlIAF3qBDxk5yi+IV4PGGU5gS5yLM6XGVZ8T3TrVE9thoZsZdp1VgKFeER8cYP5SzXnzPdIW21kd+872q5++Qqm0HUaESb5xttqm6EBOVh81fe/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426699; c=relaxed/simple;
	bh=W3jIRmwrGcjhPDGnoBZqvqw9C02ofyasiBJsd8e+bvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bvbygoA/UVSR4Uo14NTJMLzZ2HFQuSmCZFFWIL7KsnPF1U9qZRJ80bLEt7jpHrU28d/6kEglHH28llyDuw2wRVxp1OtUazkYcLii2uXrW6sOdVsfbC8Er+EfMlZ4TmmU5CHKd3KAG3ahQN2RZl4WXqjbJSpMKsw3V7sgk8b4+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=WGJ6ZMT/; arc=none smtp.client-ip=176.109.80.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=rosa.ru; s=mail;
	bh=W3jIRmwrGcjhPDGnoBZqvqw9C02ofyasiBJsd8e+bvc=;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
	b=WGJ6ZMT/yxYRDtOzr4zbxwwTdAf3q9qEW2e3h/LnNeqkh1KO2JUBUwLbI84UoSvyrfhlreF14EP
	uHvPWhhbAxUGGDI8soEC1hdwyL5tZoYLnlUcgYLsuZkalm9YUdjUjiroqe363ArmRqhtEvLpXkK11
	aeqgLgeVU1r/Ojt2IU8=
Received: from [194.9.26.89] (account m.arhipov@rosa.ru HELO localhost.localdomain)
  by mail.rosa.ru (CommuniGate Pro SMTP 6.4.1j)
  with ESMTPSA id 130334; Sun, 15 Sep 2024 21:58:12 +0300
From: Mikhail Arkhipov <m.arhipov@rosa.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Arkhipov <m.arhipov@rosa.ru>,
	Lynn Lei <lynnl.yet@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] staging: wlan-ng: Fix potential double free in skb_ether_to_p80211
Date: Sun, 15 Sep 2024 21:58:04 +0300
Message-Id: <20240915185804.83811-1-m.arhipov@rosa.ru>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a potential double free of the p80211_wep->data pointer in the
skb_ether_to_p80211 function. When encryption fails, the function frees
p80211_wep->data but does not set the pointer to NULL, leading to the
possibility of double freeing the memory if the caller attempts to
free it again (calling function in p80211netdev.c (line 385) attempts
to free this memory again using kfree_sensitive at line 432)

Set p80211_wep->data to NULL after freeing it to ensure that further
attempts to free this pointer are safely handled, preventing a
double free error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b5956dd26f84 ("drivers/staging/wlan-ng/p80211conv.c: fixed a
 potential memory leak")
Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>
---
 drivers/staging/wlan-ng/p80211conv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
index 0ff5fda81b05..b2e224e1e33f 100644
--- a/drivers/staging/wlan-ng/p80211conv.c
+++ b/drivers/staging/wlan-ng/p80211conv.c
@@ -215,6 +215,7 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
 				    "Host en-WEP failed, dropping frame (%d).\n",
 				    foo);
 			kfree(p80211_wep->data);
+			p80211_wep->data = NULL;
 			return 2;
 		}
 		fc |= cpu_to_le16(WLAN_SET_FC_ISWEP(1));
-- 
2.39.3 (Apple Git-146)


