Return-Path: <linux-kernel+bounces-254633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB969335A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFE5284451
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAE3B658;
	Wed, 17 Jul 2024 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wp2QaA0B"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DFAAD21
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721187054; cv=none; b=OJcq2S2jN5yyDQv6JP6CuLHUg4nwvK7klmcQAtt+WAps56e4ogyZE2PPZT/PblDgUUMCV/XIWgr21AdEPp1mBkA3JPVS/lSNFu0glpP8weW6iJV198W2RSS8y9Cpv9Yog++MZSmRogBBnT/9epeVcF9Bwtp+cLlP31Ma0jWjUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721187054; c=relaxed/simple;
	bh=NfOlG2vlmBkRe48uA/ZKIWngmGvdIHe53Jt+y7FEXoE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cKlA6ZGHAm+XNNAueaap1RfLkQP/U5ma97OdfzyOu9EWzlAYVZuF5aefSBgfU0Y6z8xaQ+33GVr+xXPsVrf8++HXTOlMnO4TXzxflZSx3+1SMxIbke5IQlA5WX7DxBvsuq75VzYTqTBrdOfhNhgrExct7UfuDp8SLPL+tjOuNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wp2QaA0B; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721187049; bh=BpawFWslhiT5rFQZMstnZ5yZjiV/VA6lRDiSLCKebEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wp2QaA0BZ5mCSC97ppaDXTHLlj72MP1el90W+M4a4H/Wl65ZEHo9l46YHtr9C0SsI
	 UEiCZGc3HVOqBV4iLcJIWzIPoTnLI7SgPGK6G72E0vujOyBA+46JYJQg6hyXLVDJR8
	 UQOOHB4ZuVykuV75iZsQLxdG/NfGszalYU5EO4b8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 6251983A; Wed, 17 Jul 2024 11:24:37 +0800
X-QQ-mid: xmsmtpt1721186677tk36pn0bc
Message-ID: <tencent_AAEF765567CA3DCF377696B436244B387509@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWfHhVPAy5cf+ng7YcREaXbstAPSsHLs197MFm71FStE1fNn5bdAa
	 Y1dH/I9m0AXIU+5T7RgzbsxMo6+st5fIICqquNF6R47foLbOJrsqRcsl0JjMak2rg28z/E8eCbma
	 dMPvCNInbc4mhxXOeY7B6oHJZEs06DJh6M02e4T2NHRFUEttmkd/1Z4DFGyw+R3HIop5upQdyByq
	 /iSCkA1UhjvZsDcy64cnH9DcULfZQpcSVJtTxZBxR/xR8Xn8EMhGyOJsRRalxOCAPxb4Xti/UqPA
	 emCFPGP1lm41dwFVpMrOrg1zEsld+f5Mvadb5dxdjtO8fidH6u+3s+33k2vou8pKFo4J2u0M8opW
	 ECosmCxBmY8np+EdMc6s1kWY6P5gqCSPXR9FWvovR6X4LnuFhIC15jnPkLXhdd1yVu86XBSg6Lro
	 FEt0YVEORsf14QS77aCQinYNIIzgmC1wc9BVKnibLB85Zsi3xIbUjdEZhJtVtO88amoSMOQOY8wh
	 aDQ1vtlr5uwQF9bUAvgDkjfXip6cy70sz2ROIjxMPsICciTer6W0Z0KCDP9RkpKOpzoqnAO8Ttid
	 RAqAypeZ1GPgKrrNcs4VdasvKfiXiWHlZAU8kzh142SM81KMXalvVRb6alOM2SYSbTP6ECUZ1Elv
	 YNoFWZnT6u3JTKAws7oKUq9RF5d1nBdZCEsrlV5wGAyDOULdFgI7yUPBBUxXgPUmghjW+SPWl7KO
	 4dBnfvOf9gIzqCGRvLMgaiPZ6lZ/YRZ5n0i1Ansm8W3KMnzcrbea9SLubmHslvHV1OZGDwsMhuQ+
	 h1+E/DueJmB2syEoE0a/0sWIWhhfXSoiH36zY643614VM0DjMJyWzIzOfIMLyFT/h2LcfyiUJcYT
	 U+6/zya8Q/oREaH35yU+PsbEkdyNjm5g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
Date: Wed, 17 Jul 2024 11:24:37 +0800
X-OQ-MSGID: <20240717032436.135950-2-eadavis@qq.com>
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

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 68596ef78b15..b9961edf6fa5 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -1019,8 +1019,10 @@ void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 	if (!sdata->vif.debugfs_dir)
 		return;
 
-	debugfs_remove_recursive(sdata->vif.debugfs_dir);
+	struct dentry *debugfs_dir = sdata->vif.debugfs_dir;
+
 	sdata->vif.debugfs_dir = NULL;
+	debugfs_remove_recursive(debugfs_dir);
 	sdata->debugfs.subdir_stations = NULL;
 }
 
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 1e9389c49a57..357f310ec75f 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -1284,6 +1284,11 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 
 void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 {
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+
+	if (!sdata->vif.debugfs_dir)
+		return;
+
 	debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
 }


