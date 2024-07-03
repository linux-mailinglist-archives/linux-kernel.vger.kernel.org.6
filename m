Return-Path: <linux-kernel+bounces-239735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2749264A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA341C208DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85240181B9C;
	Wed,  3 Jul 2024 15:16:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9667180A92
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019786; cv=none; b=HVj7a0p5Bv3l0xxg+aQ46OKAg2gr2vBX5PMPEHMXoTDETGFaRlTuYMSDgomxCwm3bBDRL3xKigtWgJRm2EJDD266oJD7x3hk0X9FCyTGzu1XzZ/lyp1iA7xROiMeb++8pYAw2XmJNrpKIpqGFAxvhScNKNTKjkwHLfHfdZyK8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019786; c=relaxed/simple;
	bh=823t3ZG9vkcftcwqMBGfKjM5kAW55T7HJ5obY8rbJts=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PgRyRWefdUR2FVqRqzbBZXFvhvEAgBrF43675OWSo0UPxsaF8NFU/ZsqYe7GzsPsA3SurDE9BQWeoB3vkVDyeY4We6kKyOk4Y4AVAIvIeBNlNniGmtbGIw/KolrFV+rgbWJnPGqLODVU6iFP9frqNzZsVbXWpBgq0QKc/vTNzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f61fca8c40so572842939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019784; x=1720624584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1I6KYKQLxxIUvJsrKHo+sk76c12VVzV5Ztu8InShbo=;
        b=oJREwl4NEk/hqvNPXIYPZpFW+Nbzs15Sds6FTX/jR12gD0NopksIKzsZT3oMxhr07c
         0Xkuu9628/Esfo23M4Wa/KDiTTthW4xoTx+fGCprADpp15s5UBw1g/GNucMJ2jrtHErq
         Dm6DI5BfYAeG90Qu2j//WytLjC7LcgEw2Liaq8goHIm0Ur+VwLbuWjSpuKGLFlk6sVNW
         EvWIDoWG+YqeC7XTXIgVrFTyZPy/u8MkLgVjeoZ3GaftUUAiCgPIg8tveA9IXfNkPhPz
         VuEq2ah1ayxd5ND6uiyLg3wImfS9PEkryuMlXR4JEvJ72W8tYka/hP+bpsNpouJMGTNf
         Ns3A==
X-Gm-Message-State: AOJu0YzntXyaimWsQzBGSrXVZf/eGXrtzJ3MBPUhOXYZ6JbAjErmLt9y
	KhIlF/i0eFtjrXHGfDfp1uXeNY/7U3k9s4vJ7mFUXB0AjIz84gNU7q0AYfNHgfBnH8ZI0RHs7uq
	UbXuV0PnLl43qWiZhvGPIQR0+4hZ7F/2v2ZNtNNd+oXQwzs6acOlAk6k=
X-Google-Smtp-Source: AGHT+IE0gCGp9tmC8Q5+tEtrQAXBwMnfJYBie2SKXEkREjuacYegch52h+5Q3iHDc+IyekP0WQ1/X7uySUwoGYMZAJvkMQLC4sLJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f8a:b0:7eb:75e9:8f2b with SMTP id
 ca18e2360f4ac-7f62ee6461bmr93474539f.2.1720019783958; Wed, 03 Jul 2024
 08:16:23 -0700 (PDT)
Date: Wed, 03 Jul 2024 08:16:23 -0700
In-Reply-To: <00000000000024894706196d697f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ad3d1061c5950f0@google.com>
Subject: Re: [syzbot] [syzbot] [wireless?] WARNING in __cfg80211_connect_result
 (2)
From: syzbot <syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [wireless?] WARNING in __cfg80211_connect_result (2)
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


