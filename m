Return-Path: <linux-kernel+bounces-255264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B98D4933E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA741C20E36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29B2179A3;
	Wed, 17 Jul 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FvViwRNj"
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980B180A8D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225263; cv=none; b=sGEsOy20z6j4d/Wa6Dnel24oWS6UVZgKHji8p2FmVqx7pfmQmmmwVE6U+iV4FeIfjoVIhnSkCnyPsVLSOWhaAMypYgoWJC10AiYBjL9F9nJ5Sd7rl2soF6fomF/fjwG3CQlnLHMi0vt2WFbEk7y7kBoL8mzOq5ytLrzbe+HA4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225263; c=relaxed/simple;
	bh=AqCrMHZBXwRtgtHbnOQAodBSHRjR5Q5zKah1DXMJkAk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qyb+l61iy+AOsGgC8g1Az8NtH44J2HLAMxEOYwMwpl/KTKp1FobTx6aGaEopCEv+9REx3w7TkcIVG5SVAnyEZjutX1K2PxjSUDwZiaVpqwtVSEgvtPgohXxjFUhBYkq0jR9bLxSEDOdP6jNKzQPahmT2D7izLqcqRGAUozK3Gx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FvViwRNj; arc=none smtp.client-ip=203.205.251.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721225253; bh=hVyJqvtIEF/m5oTTsZxWCsNvVWrQ/+CiGoh7OG2yugU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvViwRNjmWb0g/bdgC7UyeeQ6eYVGDOKecb1+que8mz+Fx5tWvTSPQvnAtlbJu0L/
	 qgRhlRrnz6Po3H0egLnIG2joDu0va5CtNlQd+YFmJ/AHrcQYSEJ3XOY3vDQ95VAVYI
	 GuLqeWkrAlGksnXDHcHeNgiG4u4sFs/Gdn5qFhww=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 1DF03245; Wed, 17 Jul 2024 22:07:31 +0800
X-QQ-mid: xmsmtpt1721225251to9dmle2m
Message-ID: <tencent_BBBACDEC79E66D882D916D6C9434E896EC0A@qq.com>
X-QQ-XMAILINFO: NWOHIAASQnT+vEOUm4bzfN6+4qQmIkl2FL9RYswPTa+P7xj0IOOQKtW2MGtxq2
	 n2td4bgypzJWkQ37nnl1C134e9NglxZN6AJBAhvlvzyCN/o4nSgtTnf71q9xBDrqXblAn678s2SF
	 Lgnbci7yI3IhOcBD8rcYh1Wv2AV97yR+FSs5xhY0BbGjZEOaerfu9HfBBg4zUA0wStSjojVwr2cu
	 vu/NFCOjWLkQkGH96RgJXZK3oLYNIERVaPYVCT0Ol9tSYfwcqtQZiUGVxZFu2M6xfhwhTyzuSdZS
	 w8QUSJCBBHueoBf5GEOHcGMIbIwaj/yFDfw4Tsev0eUbK+g8szrxcdTusmxQlvmOOg9prK+MiB2V
	 MGY4ndsCEYx5CYUkBqP7YREeTuNOvDA8NmLZ5GoPaG+niKGrzpUASsq4ld9jLArofxU/scUVRtH8
	 /2O80CnFIjQNW5/matji8FHfCD3KBswH/4NH6+WOllQ6XLFpCTSNnSvyozLKVCw/qzjrY3qb1qas
	 rkkpVEdQQqGhUT2wBvN1nlNuHJ7VwsZ/nbkHTlBWs7zIYOygXj7dRVrNPdw12drpUW9VPYCAVmwD
	 NZoWPWvsfpcnGsbmRXLHowfDrAcWb73ROaVEGr1vK/CKK2oKEovtKiL6RD9/forAIiEZsqCzSJmi
	 nnl14rt94aKWdMk9JXEo+8wg/Bc3FOjT3pXBA9SSQJ8ibG4J50q4bZ5qMV81mUzepqLlnClLZHEk
	 JTmfrORFRs2MuS0s67aCYWLhtvjaSkrUQYnU7OezYlxztRq5NScSb2gdu1RGnTOZc9FfIaRN2BZH
	 GDZ8P7SQGhC030M4f+MAroEJZvyRabFIksQUUrwpKL56UHzGhZO0KFhUZKnLkYvqM2kCA2XfgURK
	 SZn8bWklzNf/UmXN5GNZXQc0eom/WyDCQcMdoaMkqvFiuXnkDBbuodvVCYpDCIAfYhHWfzYSXmox
	 IUq3fKzv3U80LsaX6O7A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
Date: Wed, 17 Jul 2024 22:07:26 +0800
X-OQ-MSGID: <20240717140725.762126-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000005c6453061d53bc0f@google.com>
References: <0000000000005c6453061d53bc0f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

before remove debugfs_dir set reference pointer to NULL

#syz test: linux-next 58f9416d413a

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index fe868b521622..5e0f909d4c76 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -113,13 +113,9 @@ void drv_remove_interface(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
-
-	/* Remove driver debugfs entries */
-	ieee80211_debugfs_recreate_netdev(sdata, sdata->vif.valid_links);
-
 	trace_drv_remove_interface(local, sdata);
 	local->ops->remove_interface(&local->hw, &sdata->vif);
+	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
 	trace_drv_return_void(local);
 }
 


