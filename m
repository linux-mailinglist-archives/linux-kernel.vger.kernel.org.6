Return-Path: <linux-kernel+bounces-318454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 021ED96EE40
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBA51C23E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C4C158205;
	Fri,  6 Sep 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cUKj6cPG"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D274157E61
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611756; cv=none; b=NkTY5Dl9bkyA6kTlypqlpRLyKy8rEGLTlwvXG1uh0VpfPpsrtmeKoocQLRUNHLoAx/KGrvtUKblXQY+iW0DDXcJqtOg9ur2oFT3DKPg2kA34PWvhE/MCWEC8wAnL8j1JHG1lan41kuNaXUJ7wT9jFNI+IbNERnjEu84glfYCCs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611756; c=relaxed/simple;
	bh=Irx+AQmziroxRWyKsmV+SElbML9JN2dy2x0SgSNGYPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQm2+EFNh2WknBs2HzsV25dDFmBTYiqIy9x6fYFO9dQKO4yn1qu98DwRdIe3dwqgX7YxgoADcEL6LoT/53K+m6EJoBwOqhX/4754CpyyKJk7F5ZulqId/E+OgpoplJ84wARTVEK1rnzIaSxhk48Fh0oR8VijlmYGn6GSExsPolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cUKj6cPG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 87B683F1C9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725611746;
	bh=jhxGmar4EXNf7Y04HpgrnCqVtVf5QNilwPtcgT0I+cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=cUKj6cPGQ9cPHMrgLx/YlS8AgjBqq+7JTsm+D/MXBB3VZfeC0dtQFfhcxi/qrMXUm
	 UelCQck2D+0bw4fHLkFDJxMQaT6/WqpDR6GejFPKV9rCiIp/mWHjM5dq9wmzo0vaDa
	 4tfja1p4POvWSnNo0H+Fs0mtjagP+8Edyok4yDOUKnDG/T6czUHww+P1XlWIVCTvSo
	 eVaUl8dGL8OTF0xCtP+HXDkeBNIGk5y/DWywMrLNrEEGEOFN7QlHzg6UbaitqenU63
	 8V2IAd+7AJSvRYhp4WVP8e2VfzlhfjV1VnITVn18Iq6IaOn4EOfYvdor1iVFGEr6q7
	 itMrjK4Q4nzNQ==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3db2adc6c81so1728574b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 01:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725611745; x=1726216545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhxGmar4EXNf7Y04HpgrnCqVtVf5QNilwPtcgT0I+cM=;
        b=VIA93c197q8Crl6hFalpwecHWETzuS5zabNEqjJkNH7NQErrd3++CmLeE3/uBiUWkY
         Mc0UpFd02ZurQjoYQlQGRPg+bIO/u7KKLGyTeqmyUcfK6NSt8/6aU19tbBlZgmdV5jdW
         c81k2MGgj7YBPNt3iZCf0rhD0jdH7e6XC3alx+BCGc9J3mcOKYSqjsObyYe6Mu77wdag
         siZJBN/zlSpH34cveRGYpigdWBFGn6o2rBVDqpsuhcXq1Z99inAPnPP9kyrsv31e+qTH
         3m8NptyPf9WRWrOtG8/MLXwhTmC+tSSpLzNWAJchi++9MfFgO6gdTs45f7JVzEl3ICpR
         ssow==
X-Forwarded-Encrypted: i=1; AJvYcCWhhTp2E7UfnM4LE3t7OwpiTG736TUCD1FBZnGuDVGgZGZ0G2v3rTZd713k7GOsGPeLXUFpk+fot6mMl9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKKh++W64MFmVLzcjNhsCqD6vrRySDxgN6zVw+PARBy1aTXR9
	f4B9Vx9t8lfTdbwF2ajivgiGdfCV6S6t57/LkBzHe9F/kAHJj/A2BMDkLvyyGf4uqf3PSd/6rw0
	v9uj8/wXmJBONR8a85UWKTf5DbznF4uM7SaDa+KKTuoSP7x4P0pfpkwhRdrckP2HiiRe2F8qgpK
	+CcQ==
X-Received: by 2002:a05:6870:b50b:b0:277:f2a6:8f94 with SMTP id 586e51a60fabf-277f2a69146mr19584960fac.33.1725611745406;
        Fri, 06 Sep 2024 01:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiLRsMmv/PLA56SlySQ3oOgBfxaiT0CMeZlq2NAXqxhw9PPAqSg+KkCbEcSBNlNImx1ZpdEg==
X-Received: by 2002:a05:6870:b50b:b0:277:f2a6:8f94 with SMTP id 586e51a60fabf-277f2a69146mr19584947fac.33.1725611745102;
        Fri, 06 Sep 2024 01:35:45 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd852efsm4525137a12.8.2024.09.06.01.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:35:44 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kuan-ying.lee@canonical.com,
	kai.heng.feng@canonical.com,
	en-wei.wu@canonical.com
Subject: [PATCH net] r8169: correct the reset timing of RTL8125 for link-change event
Date: Fri,  6 Sep 2024 16:35:39 +0800
Message-ID: <20240906083539.154019-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 621735f59064 ("r8169: fix rare issue with broken rx after
link-down on RTL8125") set a reset work for RTL8125 in
r8169_phylink_handler() to avoid the MAC from locking up, this
makes the connection broken after unplugging then re-plugging the
Ethernet cable.

This is because the commit mistakenly put the reset work in the
link-down path rather than the link-up path (The commit message says
it should be put in the link-up path).

Moving the reset work from the link-down path to the link-up path fixes
the issue. Also, remove the unnecessary enum member.

Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3507c2e28110..632e661fc74b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
 enum rtl_flag {
 	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_RESET_PENDING,
-	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
 	RTL_FLAG_TASK_TX_TIMEOUT,
 	RTL_FLAG_MAX
 };
@@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work)
 reset:
 		rtl_reset_work(tp);
 		netif_wake_queue(tp->dev);
-	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
-		rtl_reset_work(tp);
 	}
 out_unlock:
 	rtnl_unlock();
@@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	if (netif_carrier_ok(ndev)) {
 		rtl_link_chg_patch(tp);
 		pm_request_resume(d);
-		netif_wake_queue(tp->dev);
-	} else {
+
 		/* In few cases rx is broken after link-down otherwise */
 		if (rtl_is_8125(tp))
-			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
+			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
+		else
+			netif_wake_queue(tp->dev);
+	} else {
 		pm_runtime_idle(d);
 	}
 
-- 
2.43.0


