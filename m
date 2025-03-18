Return-Path: <linux-kernel+bounces-565334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF76A66611
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70BE189915D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0319189902;
	Tue, 18 Mar 2025 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Dq0RF1xa"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEFB15573A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263832; cv=none; b=AIaYSuzk4ILfXtKt+2WP5Ve2H7yl5zJByq9qeaC4q+7DKwJIj1Tsg0ABC81QZqVPcD+T6zvJivkBy410aUZDM2x0abrmRVNjxwxTa3BcyPOlULZ/QDulMDjMmSUSZlR3XKTo3MNb9Q0FG5M9SKKLyUU/IhpCt02jdJT+WhQICIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263832; c=relaxed/simple;
	bh=90DBI5YNp4rJum24NkptVTueHbYngQW0QPFQ4qoBBv0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qQ36sjQTUKwz+RJJwey3gvZlY/aQzNQhwab5byXvePgVGhpAnjpXCzKm+W8k0wPN02NfHKbe6JiSRUa77d3fQ7JEHIlbhsVgr4N2mzGU6hO253+QpbwpxFwXcLMCrJZhTemz0MwvtT/162f+jdloOpj/nh9n8uEOxr6PYhDCkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Dq0RF1xa; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742263811; bh=PWAg6wqR4aDaunrenpIwbqBjEpt1Xb0TgbEUFi9Zb+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dq0RF1xarjpFo8AeS/VVg+fhqaMqVuT/YRiOAf1Hh1qEED5hVLQ/9xaxA4EwRWjas
	 uKRjXPcPaBL51mYm1n/fVP7oZKjOoSWBjyjVVg0eGezpJdTlX/48XwpC0f854o9/7F
	 8KSJqSwuHwMWSoEitubkPU8nV7YeM3DQv8g6q+M0=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 75B28D4; Tue, 18 Mar 2025 10:01:53 +0800
X-QQ-mid: xmsmtpt1742263313t13o6kae3
Message-ID: <tencent_4C2A333C9EDB1B264B0E1B0425E2BACBBB08@qq.com>
X-QQ-XMAILINFO: MAcVqULX7QQ1SDpNTn6Eo0n9SFs52VrR+m6f1NwBJjtKusl13a4eD4GHwJg1zX
	 Jhv9YgzU0xSOxDcxDg6BK/wRW56AuKJBwNMep+h/fMAHTZLN4965Dx6o9AEc6XRwaTky8kJJXfsX
	 XdBNsj2EChUAMCvbVuTmipGi2RdCY31cehenyscMFfxK+x5iTbWhFikP19lWaFQ+gmIv/UFuxxAK
	 XlrJ8okgze9WC/h5pwc6js+xe5SGoeSaIWgQClvTXbYZz5UtGGqcRaENxpPKz2nrkjxi3xn+qvy1
	 wPD3/8PjQAd/GflAZGdWAeO92if5Fi2pta5pSSp+VHs6OoGwcGffkq3bhilxhfrwQN9tHQwNdMLU
	 otMrTETk95ILzoke0p+Ed8CRXYzkP4F1EpdBxVEgm8o5NqPqZ4OoAyyCn2bvaYPhjUpD4edRV6gJ
	 c4tRpxjDXtPn8zOZzjJpns9YqjO7j6AhDUmsi7K7+gJvREo3h7cVSg847gbHTvddfUcnDQu7KwSM
	 xK74hrtSQNKxkrWNhDVH9HjmwaRzekM01v3TuMlknO13X4lmyhV2IKG7qhvv/fscP3CCy1Q67+qi
	 51UhziqAXr9xRFs9TIf+q0yyKPSTtsL+iq09ZqCPwXWek+0Vuc0hgva3zceXNmemGqiBEU/nObUm
	 56l2RmxyCr7G+NVwkTrG2ryYDTFRo142hsdcL2AEUEKAeJfI03/oVZiG9XDRsjFNWDoHCJaAfcUA
	 YTLQk9sg9ti1nS8SW4Ey0SJINlRbMFpPb/nVM9XrVh8aZUitkLfoQmDXiLiHCUcQmYCIlxdSZuNj
	 KrulKUEnu2qrlUl4fR9SwJ37BI4+MyY8tyWQNV9xezaESs7PpKv0sZOswQLBN6s9kTuynI/ZxUkN
	 hIDtyCD9TwMmK4quvf/aIWNp3xllkSa0flE7kzmZXC
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] INFO: trying to register non-static key in cfg80211_dev_free
Date: Tue, 18 Mar 2025 10:01:54 +0800
X-OQ-MSGID: <20250318020153.3042145-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d8804b.050a0220.2ca2c6.006b.GAE@google.com>
References: <67d8804b.050a0220.2ca2c6.006b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 828e29872633..df3ea9ee3ee9 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1193,10 +1193,12 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 	struct cfg80211_beacon_registration *reg, *treg;
 	unsigned long flags;
 
-	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
-	WARN_ON(!list_empty(&rdev->wiphy_work_list));
-	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
-	cancel_work_sync(&rdev->wiphy_work);
+	if (!rdev->wiphy.rfkill) {
+		spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+		WARN_ON(!list_empty(&rdev->wiphy_work_list));
+		spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+		cancel_work_sync(&rdev->wiphy_work);
+	}
 
 	rfkill_destroy(rdev->wiphy.rfkill);
 	list_for_each_entry_safe(reg, treg, &rdev->beacon_registrations, list) {


