Return-Path: <linux-kernel+bounces-565349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60326A6665B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A9F1895526
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD61552FD;
	Tue, 18 Mar 2025 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kjirrNrI"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7EA4A1C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742265545; cv=none; b=m+k046477aKEArHInrgg5sd1L2xH/2DsfAoQRivdxR3i6wQbhzccRJEWavA/Vne0v2vD97YkV8b3nrdZ6lPoLnj+sqQ/yduC95ZxYsNkpAUhN31xjc7z/iBYgfqXkNWrSMFgjPQqSeY9DA+ISzwSDhYgThiyPOL4O3hQ2HgUwME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742265545; c=relaxed/simple;
	bh=7EOmIwerDRmveeBbz9ATHBP2PnwksMcJRl9Cq+hpL+4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bE1UXGH5oyJjyHobeiKyH/wFp/fBK6ODVaXunvJ0V3BqHD2LGr9WNZa5XDCmXb+A9qbvDr3/49Ho7oV6basgCycRlZ+1ztQ0+XnY5ZIDHqj0PP8lLA2QLXySovetTDaKqZGtO6otL3+I44zgEhwsDFuTCqbkQc+YQbmY/SRLHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kjirrNrI; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742265529; bh=50aLX1zq5ZHgm8H+oBWXhj21BKnvV4DBPtVvxTgCZcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjirrNrICwB2UlgCCGSd/ucyMSchelqj31X3+Rb2zKxmFWWlyc/0rFuBye5HIhaEr
	 YvOhUmS4lpS5XUfN1KVwFh7luIOX0Szzx3PjOYV8ymh6Ny/lzkN/d2FJIX6jJ5iJRn
	 jNJxtvXKZn5CTZ2lZ/Z4ieYlokKUdDPx8avb8HfQ=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 694AB6A9; Tue, 18 Mar 2025 10:26:20 +0800
X-QQ-mid: xmsmtpt1742264780telvdxbzz
Message-ID: <tencent_F403B22448977EF77586CAF362E375A96D05@qq.com>
X-QQ-XMAILINFO: MD2XmhJtctJJ2/xjT2I/ddW/h0aTIVwq01DF/nzLkoYwkgOvkjb8rFraCiMuhE
	 AMHSDzti1e4f49hbtgUnoJbG9RBowuHGI8SrVSIiCuO3njEgL2pHAguVU7Wdb2mTWbrxsyHUjMpK
	 DHjiZG6bAtXVkZZo9WwW3yMnkAYYw+FJHPM7/x9NL89hzobql4+EH96PKBv5IwoF4JTG7LYEKfiY
	 p3HpwawYycgm02BZIfyodutoMlhj0VH03weIAdH+jLtB/egwOf6aFFll1iJdbbtUGK1SGmw5CBBj
	 jR1TBWuZgkQ7QPgdlet4VZ6mYSyVmpSHxXUFQitkVhkv3BY/cF65aQPW/navKZofAQYEk7RmTyiY
	 l2vTQMyNjCtipNZr8oEX1Y5uwBo+AbRx1c57YOyp1FjzAwwUPmiF7v5vwT4pm4hFGFmPAwmimRIf
	 c1fQqFLDuGs5KDNUIIA2SWMyub9OS/Q0f3WZRVOnPUMHhrKcer3mzfgo+rKq1pgincW7HeKQT7Bx
	 xcZnjK+q2QynRkiEuQSyqvPHUiunwNJvv1b3mjTQsKs2wR3GyN/Thil/D5O1d+N5YSTZP+6tdh3P
	 w5ejyJqDUQtG4WbuIjfEZvp/JNw+PQKgooWdKoAZIyFLvImQKRHMM6zaVtkny/UMgGDXscmn1qqg
	 /EVDcsV4jbKML13xDBNLy7EiNTY0c6DeHzm+/9YYZj3hKcheawHekWJxWEZnMH53TmbXoi9xJRAz
	 9iZwbyfqFckl4s8pcILxjVLjf1cldmDa+7W6J3nXCU2Ctcs4FknhZwDxHubJK6iZLdFQUV/MDnmN
	 1ykKuDmqvL3BLe4ZFHi505DwcF3PM+izMyutJgxFie/Exdp1TC87d/Ec6StMRhnNbwgEOBP0NIEg
	 46OuoyY5cDhb6j97wsFHYlcVbdpTM8Oekxj4kO+ofD9nuHC3EQ7LQLjP+edMpCUq9mRP9IlO1zTa
	 pWMAdFxrYWD3UVZgpwSInYfdSBMrES
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] INFO: trying to register non-static key in cfg80211_dev_free
Date: Tue, 18 Mar 2025 10:26:21 +0800
X-OQ-MSGID: <20250318022620.3061237-2-eadavis@qq.com>
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
index 828e29872633..ceb768925b85 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -546,6 +546,9 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->mgmt_registrations_update_wk,
 		  cfg80211_mgmt_registrations_update_wk);
 	spin_lock_init(&rdev->mgmt_registrations_lock);
+	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
+	INIT_LIST_HEAD(&rdev->wiphy_work_list);
+	spin_lock_init(&rdev->wiphy_work_lock);
 
 #ifdef CONFIG_CFG80211_DEFAULT_PS
 	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
@@ -563,9 +566,6 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		return NULL;
 	}
 
-	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
-	INIT_LIST_HEAD(&rdev->wiphy_work_list);
-	spin_lock_init(&rdev->wiphy_work_lock);
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);


