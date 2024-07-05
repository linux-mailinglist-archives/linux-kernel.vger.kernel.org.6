Return-Path: <linux-kernel+bounces-241870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7069928078
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69195284783
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B721B806;
	Fri,  5 Jul 2024 02:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="M+Bdeuq9"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855C45C07
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147089; cv=none; b=sGD1HxuntnK/7HNfYe4OBC14nu/onZTMe8JbBc539+g4m9WtP5b6Yu58Ie+LhO/hj3y2Dl4QZhAe3+FlIE9s26aI6e3ckHby5PJv8GojafXtp/iYQafKXjthGiL5HqVr0iarqE0s3ikIbf5LKqf9AyOqMQa1qwryk/qTtZd61vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147089; c=relaxed/simple;
	bh=EiUsjHRGV+CmXkYgd4nm9b/6HTSZKdNoOGkKIGlBrPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwwIlpVvz8pSBWTfrSpqek2xNgJh3h2k55l/7A+WOxTkOSQc4T73qWijrmEtWfcGOm5r1TIDnyrtbTKIAFyEpaVM5OQk21/9xgcITMcDp5w9m+6NJjFFa/NEf24+kFIDZxzki8aCmvw/vpVAlDBYJla6B1uj+GLekYiVlJCsK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=M+Bdeuq9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C3CE40C8C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720147083;
	bh=giOuHUYB8wMySa0UyWvQdDBmX9/kmwZ2Xcw9Co/IFF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=M+Bdeuq9DJmweeVn63suUNU5GiFDJi2rDoumZEsfoyMl6xrH+SEdbf+4hF0MazyGC
	 okm230cf+BwsXgK3JE3LzwP85RFxtWo7GJqVjS/emAfV/Zq21zJlGXV6ZtJHKTLRqo
	 yJ5S+p2gq7TR3Z3Q1QfRUM4VMuxMNP4jOzagSIfNKXJyhnbd27Pq7a58qDGNvhpFca
	 WqndjpAHc1Uv99tld9Y+IO2ZhP2br5Um0uMo2Fz4oX4U85Ly3BusAcCfwt3W/fmSU6
	 UIon9n5vtolRlAZ4fwMOu64jHq/AomuWsoVkH97IAb0PKjJ5oldjQ19CBy+f7klw1l
	 URzhjNGDF0sQA==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c969c4a90cso1197962a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720147081; x=1720751881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giOuHUYB8wMySa0UyWvQdDBmX9/kmwZ2Xcw9Co/IFF0=;
        b=Vg7jmd+Iraow8Zp10nZQCnS8fgkW9wPe3/OUUsq0zPyCC3lt+p57ohzTbGbW8kXrv7
         zHO2Fve6JoNEK2CQ4P0aIMjuBoKjlv1/j2QkhhOCCM/QT/9+zVTIQzsgX2R8URrRKyoc
         5L8Wdn1eqP+/fL7/e+ssX6qVvqSRt2ZHep0wPgBdXfgxcNJHjOO7BCHcb40TckPElKTh
         yUkXy9jbbfJR/YkQoBZpcDzSoUK+2Zh3eI6jnnoTWMDTYOHQmsF3ncgw9nYTGiqz5szr
         psIHk0ky/8dtcVKbkJbcruwhA/jqRcJCRO8xiL4rAogrzbBJP9MG6bmgXgHCFRLof6AS
         8vNA==
X-Forwarded-Encrypted: i=1; AJvYcCXDNz214iz0e2v1f09ye/aoSJMATen1yxDDpW6f91EgGfUzNr/0I4k+WZtIoUb4YVc6jYBVABSu0DLez9cVIsElvcZnf6Ln825GUH+U
X-Gm-Message-State: AOJu0YwTFtNDhaFVbr67g3zqAndzRVRBJ79ZI96eBmuPIOSg+tp22+8k
	D22U33itpHKsYgh6068vjH5Gh3CbitHZ0JGdNF9zfJNrQynujAbYLmKNiHPBJb28ZJ+oy/rh62v
	7ihZ8hzRoPjgIhEdoUX5XwNxq6IL7If+2lZb1LjJ36D4HIaw74Z8YusKC1vbOPHggrEO9aUmyTN
	fZaQ==
X-Received: by 2002:a17:90b:d8b:b0:2c3:40b7:1f6d with SMTP id 98e67ed59e1d1-2c99c32bb92mr2891183a91.0.1720147081363;
        Thu, 04 Jul 2024 19:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7odhywr3x+omb6miX/bRdJpFgq99cmMPkm57azjTm6SAhOCuNgPBP9pLJxVuxosgSvnM5w==
X-Received: by 2002:a17:90b:d8b:b0:2c3:40b7:1f6d with SMTP id 98e67ed59e1d1-2c99c32bb92mr2891172a91.0.1720147080991;
        Thu, 04 Jul 2024 19:38:00 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a81e503sm2268029a91.0.2024.07.04.19.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:38:00 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: johannes@sipsolutions.net,
	kvalo@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	en-wei.wu@canonical.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rickywu0421@gmail.com,
	syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com
Subject: [PATCH v2] wifi: virt_wifi: avoid reporting connection success with wrong SSID
Date: Fri,  5 Jul 2024 10:37:56 +0800
Message-ID: <20240705023756.10954-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user issues a connection with a different SSID than the one
virt_wifi has advertised, the __cfg80211_connect_result() will
trigger the warning: WARN_ON(bss_not_found).

The issue is because the connection code in virt_wifi does not
check the SSID from user space (it only checks the BSSID), and
virt_wifi will call cfg80211_connect_result() with WLAN_STATUS_SUCCESS
even if the SSID is different from the one virt_wifi has advertised.
Eventually cfg80211 won't be able to find the cfg80211_bss and generate
the warning.

Fixed it by checking the SSID (from user space) in the connection code.

Fixes: c7cdba31ed8b ("mac80211-next: rtnetlink wifi simulation device")
Reported-by: syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
Changes in v2:
	- adjust coding style
	- remove unnecessary debug message
---

 drivers/net/wireless/virtual/virt_wifi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 6a84ec58d618..d2271a7644a0 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -136,6 +136,8 @@ static struct ieee80211_supported_band band_5ghz = {
 /* Assigned at module init. Guaranteed locally-administered and unicast. */
 static u8 fake_router_bssid[ETH_ALEN] __ro_after_init = {};
 
+#define VIRT_WIFI_SSID "VirtWifi"
+
 static void virt_wifi_inform_bss(struct wiphy *wiphy)
 {
 	u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
@@ -146,8 +148,8 @@ static void virt_wifi_inform_bss(struct wiphy *wiphy)
 		u8 ssid[8];
 	} __packed ssid = {
 		.tag = WLAN_EID_SSID,
-		.len = 8,
-		.ssid = "VirtWifi",
+		.len = strlen(VIRT_WIFI_SSID),
+		.ssid = VIRT_WIFI_SSID,
 	};
 
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
@@ -213,6 +215,8 @@ struct virt_wifi_netdev_priv {
 	struct net_device *upperdev;
 	u32 tx_packets;
 	u32 tx_failed;
+	u32 connect_requested_ssid_len;
+	u8 connect_requested_ssid[IEEE80211_MAX_SSID_LEN];
 	u8 connect_requested_bss[ETH_ALEN];
 	bool is_up;
 	bool is_connected;
@@ -229,6 +233,12 @@ static int virt_wifi_connect(struct wiphy *wiphy, struct net_device *netdev,
 	if (priv->being_deleted || !priv->is_up)
 		return -EBUSY;
 
+	if (!sme->ssid)
+		return -EINVAL;
+
+	priv->connect_requested_ssid_len = sme->ssid_len;
+	memcpy(priv->connect_requested_ssid, sme->ssid, sme->ssid_len);
+
 	could_schedule = schedule_delayed_work(&priv->connect, HZ * 2);
 	if (!could_schedule)
 		return -EBUSY;
@@ -252,12 +262,15 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 		container_of(work, struct virt_wifi_netdev_priv, connect.work);
 	u8 *requested_bss = priv->connect_requested_bss;
 	bool right_addr = ether_addr_equal(requested_bss, fake_router_bssid);
+	bool right_ssid = priv->connect_requested_ssid_len == strlen(VIRT_WIFI_SSID) &&
+			  !memcmp(priv->connect_requested_ssid, VIRT_WIFI_SSID,
+				  priv->connect_requested_ssid_len);
 	u16 status = WLAN_STATUS_SUCCESS;
 
 	if (is_zero_ether_addr(requested_bss))
 		requested_bss = NULL;
 
-	if (!priv->is_up || (requested_bss && !right_addr))
+	if (!priv->is_up || (requested_bss && !right_addr) || !right_ssid)
 		status = WLAN_STATUS_UNSPECIFIED_FAILURE;
 	else
 		priv->is_connected = true;
-- 
2.43.0


