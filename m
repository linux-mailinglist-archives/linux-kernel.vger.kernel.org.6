Return-Path: <linux-kernel+bounces-239701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA17A926431
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066981C249A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4617C23B;
	Wed,  3 Jul 2024 15:01:59 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8F17625D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018918; cv=none; b=bGlgOqpZzJ1FolTlE4Q9e+LWMtZbr+AboGV0Yf15nSqfSqyX2ByG1kliMea7RbP+/0L6o+R6bpVk4eaT6ABj4XBTbjBiqW0iu+am7m+VXK6Od+jbIOxAhzl3Hu3Zf0WZ2hJG+g2A7sXzI314vkqWfqFFuBsc5Ryg84X0HB2fUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018918; c=relaxed/simple;
	bh=4+wjez4WSFHtXYfjAHeRHLFID4ldQeiSz67LfvFDSn4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RCXDsFJuXSEWmJu8AfvrLxByEZ5ryFoiY/FfOglWAUX3OEhJfdXgHjlslyU2hYkaMxrxa11tNlMVNRX1MJYh+aDuWhs/yH4nGbop5uDLzPBL6nbFYoIKn8kif7rQ1OQUvFdm7tW0vOsEvdm/1JOa7BovLJ8LnF59sxlWABy/+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so619771239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720018916; x=1720623716;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rymfEi9J37zZQ59PLyDCDyGgmYefNGdjQn8s1zisi0A=;
        b=d2c2GqXw79nc0YMXfKKs2e6m/4Wrp1AVeCgxTrp2QSlzFvRPMLp8m6yJhr+f6sPXHU
         jSqHtmqFPdVih83bl3gFBlILfwFTmBLIuXzLm1j5a8KNkM7xi/08DPlzA08Izo8BObSy
         c3Z5W3TbBwq+IJVqclfu2NtiqZ084UQximIu2sC9GFsOJW9m6FAXAtCLhnrryKuWxyEj
         6jxxxMNRsJ2jPZQLGDGX4MvcA//ngcSyDQECAl3q9I/8Uet75SRYgMy9xKRim3RWBjms
         ZxJuW5uiUyQ7HzoLgWDY3EcI31G2xytYxJ4EPyP7odl4oHJzo8ibsBSq2OtESijws1A7
         8CiQ==
X-Gm-Message-State: AOJu0YwGXeOYPdx/PfH0J4UjtRkZbYRND3XqvH8ImRDD7Q4HEiRoH3eO
	pCt770PPc/vBid07MKTn5QBjstbQcifP0NczNShWbc4xVFsyLcTKaJczMtvR4G9BBpTXz3FxNoS
	Ho9ClQdHt1wRBK2jJOOWaebkhUb9JSOOIj0cXoUH3yruC7cKsMgr+spM=
X-Google-Smtp-Source: AGHT+IEMsFR/OJPz1JhZujdBWAwIB6WHkFP2PkREMvE/DgPd0DweDUB1fZbLZEmQE3mzKZa7sd0m144THC2Dx08tvMB8UedQlVgQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2608:b0:4b9:ae81:23b5 with SMTP id
 8926c6da1cb9f-4bbb6e7c719mr1105090173.5.1720018916050; Wed, 03 Jul 2024
 08:01:56 -0700 (PDT)
Date: Wed, 03 Jul 2024 08:01:56 -0700
In-Reply-To: <00000000000024894706196d697f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f982f061c591c24@google.com>
Subject: Re: [syzbot] [syzbot] [wireless?] WARNING in __cfg80211_connect_result
From: syzbot <syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [wireless?] WARNING in __cfg80211_connect_result
Author: en-wei.wu@canonical.com

#syz test

--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -136,6 +136,9 @@ static struct ieee80211_supported_band band_5ghz = {
 /* Assigned at module init. Guaranteed locally-administered and unicast. */
 static u8 fake_router_bssid[ETH_ALEN] __ro_after_init = {};
 
+#define VIRT_WIFI_SSID_LEN 8
+#define VIRT_WIFI_SSID "VirtWifi"
+
 static void virt_wifi_inform_bss(struct wiphy *wiphy)
 {
 	u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
@@ -146,8 +149,8 @@ static void virt_wifi_inform_bss(struct wiphy *wiphy)
 		u8 ssid[8];
 	} __packed ssid = {
 		.tag = WLAN_EID_SSID,
-		.len = 8,
-		.ssid = "VirtWifi",
+		.len = VIRT_WIFI_SSID_LEN,
+		.ssid = VIRT_WIFI_SSID,
 	};
 
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
@@ -213,6 +216,8 @@ struct virt_wifi_netdev_priv {
 	struct net_device *upperdev;
 	u32 tx_packets;
 	u32 tx_failed;
+	u32 connect_requested_ssid_len;
+	u8 connect_requested_ssid[IEEE80211_MAX_SSID_LEN];
 	u8 connect_requested_bss[ETH_ALEN];
 	bool is_up;
 	bool is_connected;
@@ -224,11 +229,21 @@ static int virt_wifi_connect(struct wiphy *wiphy, struct net_device *netdev,
 			     struct cfg80211_connect_params *sme)
 {
 	struct virt_wifi_netdev_priv *priv = netdev_priv(netdev);
+	u32 ssid_len;
 	bool could_schedule;
 
 	if (priv->being_deleted || !priv->is_up)
 		return -EBUSY;
 
+	if (!sme->ssid) {
+		wiphy_err(wiphy, "invalid SSID\n");
+		return -EINVAL;
+	}
+
+	ssid_len = min_t(u32, sme->ssid_len, IEEE80211_MAX_SSID_LEN);
+	priv->connect_requested_ssid_len = ssid_len;
+	memcpy(priv->connect_requested_ssid, sme->ssid, ssid_len);
+
 	could_schedule = schedule_delayed_work(&priv->connect, HZ * 2);
 	if (!could_schedule)
 		return -EBUSY;
@@ -252,12 +267,15 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 		container_of(work, struct virt_wifi_netdev_priv, connect.work);
 	u8 *requested_bss = priv->connect_requested_bss;
 	bool right_addr = ether_addr_equal(requested_bss, fake_router_bssid);
+	bool right_ssid = (priv->connect_requested_ssid_len == VIRT_WIFI_SSID_LEN ?
+			  !memcmp(priv->connect_requested_ssid, VIRT_WIFI_SSID,
+				  priv->connect_requested_ssid_len) : false);
 	u16 status = WLAN_STATUS_SUCCESS;
 
 	if (is_zero_ether_addr(requested_bss))
 		requested_bss = NULL;
 
-	if (!priv->is_up || (requested_bss && !right_addr))
+	if (!priv->is_up || (requested_bss && !right_addr) || !right_ssid)
 		status = WLAN_STATUS_UNSPECIFIED_FAILURE;
 	else
 		priv->is_connected = true;


