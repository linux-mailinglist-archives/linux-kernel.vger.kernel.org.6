Return-Path: <linux-kernel+bounces-313036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FA969F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDC2B234BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F08C06;
	Tue,  3 Sep 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WIG4FBEC"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BD23D7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371036; cv=none; b=Uma2rHfW0m4t9413nsMO4HHETSbMdn07sUZrnAMz2Q3Ne4mRRIdHN/0vsgJ9OiGhLM8CV3q4ISMpaO8DY5WK3QQrQgmQxKACCnu//rUcUuM7V/eT3QyBYmh6Z/j0+PoR1P3+WDvi65D2R040Q/BF9vG6EPtWzuK0FWvbPdnI9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371036; c=relaxed/simple;
	bh=+pqOGg4pQ4qs9ZMOPxqh+vA5YNuDXXKbfLs3hsZagP0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=k5XXo4cJQwdH+27PEyjAIGkFUM+k26nL2ppwVERstmktC7bh6Yw7s4cMOwJpk8+02xvHrBxYrLHBskJy5IDELO6qS1nvxNDIFKf+01P+BU1rXlRSQfwZf31oEU0S5um0nxnXseUHB2aMXkSXwW5m7mbtCAQTiQMUk854fJJI3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WIG4FBEC; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725371019; bh=2NJTEyts/NQDpch/bFLi7Gp9V0Rynb/PKTiIKeP8wtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WIG4FBEClGckMAvVmFswoRbiQD4DkdhigER17hhzP4B/mw07/Mtxua16EGsZmggeO
	 T5ImkiANAEdQKDhWmpF57zeWYBLY4n23LN340fF3qy/t+r57Q9HnNN/WZchTHq4Bxm
	 JzlFPNIPun2OZKV1HOfmiQPTMyN9gbLaY0CSvC6U=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id AE5B32CC; Tue, 03 Sep 2024 21:43:37 +0800
X-QQ-mid: xmsmtpt1725371017t3usvf8ce
Message-ID: <tencent_91E82C456D9496A8EADAEDE6CEC479926D0A@qq.com>
X-QQ-XMAILINFO: OW4JKxETGMY20iCPhHAzGdXp55m36UK7MQOBgp9sMqbHvmFoxnz+C1Q74DKYlx
	 NR1OFFuNxQSQAIr6+EnZQc/Q2/SnS7D7hglT6UMFYdxMro8v86jJql2Xbk4Q6X+ZMeB/RQ/wJmwf
	 29riklRynTWcMkd7pf+UynK6eF3Ie0JErMlpE33Rs7BUhDAFB236YgSAe0/esxSU3HOTkvrGdlHs
	 xHY2c5cGCbJEB2fkCZ4WB1rBuDmM4EZaNYKNnA0Lrg1YcPr/2ngNizsuynSGbLfsZjzC10LoR8KJ
	 TZLT4UuRleDmRerwLd5o68L/oWVGJerpRoQE6WDlOVrxJlYufi4oCyTmwwkZc6LEOH0tCZAMBexb
	 lJEPgTjwknCO7hWvSHuaJ55flxeBMPJELkaXbGcJ5bIcvRd/lf47Nvw8M1ueWO1IdCcIz6kcR196
	 ThmwKmVIAtUjA3FCO5ZyH+uORYjDXZhADej3ZA/HHHLcPBgtd20AgO4eULlA3ZpR1++7DQkzdX2Y
	 fN9sh43MaLWpe6YBL3n3n+ReLGaT7tYHcqxvibp5Dzw1Va+8GbhS4wBwc89d91b/vYGHqmgxil4B
	 QPxo24abzNdj44ifK8dfjMWB3cVemw1tU/wAHr0sXhRgVo35fArWWIs9kDmCdTonyLr+Dftl6VIB
	 UykxGdDrqftJikvK264zHOLUrJZ7Zil90nVpXtAAHMhcfdkWO+UCayLsJPZOR/eoJZzOSihYwaVC
	 nkpTxloXGnMZRET+yzTPFlpjhv75E+sKD0omKgOJ/A0eNrH0MEnQF1JVbk5fbXqJJw4cML318GNa
	 S6y49Edkcf24utiACAxdK4DrOKYWCTPt2Oe3Aw4Ypthoo2gC5Fk4Eor0Mg4ajGDCRCRrQ0veYHLl
	 YJrWOD4sk/H+YmtmSG61o69p3N3Whv4OYMM2s+kVan+uZERdd28QqCBAO3DWshdg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
Date: Tue,  3 Sep 2024 21:43:38 +0800
X-OQ-MSGID: <20240903134337.3254059-2-eadavis@qq.com>
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
index 3e4ad801786f..d28bf0c9ad66 100644
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
 


