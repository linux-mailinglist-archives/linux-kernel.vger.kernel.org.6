Return-Path: <linux-kernel+bounces-240451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803C0926DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36225281C00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45D17C73;
	Thu,  4 Jul 2024 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NjmfXILg"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4469182D8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062198; cv=none; b=iXNTbirD7BN+dLNDyvtVx03j5VD4Pk+Xrl8qc/Ncg07CBI+fYcqvZXfoW8dz0Zdn+whMOoEA4A0RflDHrIloc4ahc3tJ5ghZRcDlqOCdDJ795yn0LcHXC18KAwhxewANJgIBizdravdJ13m6HGK1XIHsBImWQcwd1LNPlXqm9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062198; c=relaxed/simple;
	bh=eAbd92YIK2R+VcrvjPqGGg4NCF+Faq0RSo7WGEIPKk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZnOmktvFvXP349OJE32vv5nElgppvhH3LivE/R9bramg9iXhTr7XmAGd/uz+h9CkZTy8708Wg0dNf8lk9Tl55s42Qi/5S4EhwQ3/ZIW/OJqRyR61ER1TIIDLbfJ8PEBDrFrUbnwNHFo3KeDvpDn0bpt8hESlyCB5lVWQ1L378w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NjmfXILg; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AF6BD3F183
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720062193;
	bh=ohrBX0V1iHxcURIO9c2jyrcgYuEKd6isy0JKLA+gdFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=NjmfXILg+iIGXF3zlmlLZMH9tEhH/mDcaO6F3QihHfqbgbR1RKUzcYi89hG2v5Iyo
	 iGFZHBR1kSPDhevfcLZ7tizpXZRnmwsSGqxeY8nvDHvKqvC89GRdXOgYcAja1oMATg
	 73ky1idQFLQ+V4dJP2uhLtGt+WAk8vbSGyYSJ1Fk13NCMJpKyUSvmOYj7vKGzHnSVe
	 2Un/fjErUTA0ZwVfKabd26Ul8KFPyHMuraIOhhlsvCiys5G5iToUlyPHc41uXrGPfY
	 VjZS46pSMImXxi2VNw1XS6LpGqw1Ai3o+spkSGWZFyi3YPDM5w1xPi2H6anlUIZnZv
	 MnaX+zimpXYIg==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c96f6bed83so216494a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062192; x=1720666992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohrBX0V1iHxcURIO9c2jyrcgYuEKd6isy0JKLA+gdFE=;
        b=KsNwlxMEDB2xexyM8a31QCOBcSiQs5wh6B0dt24JXPQJI0FmgDggZlIJl8cJxs84OO
         jgzs17TBOCGCd9gIa19gBS9u4EvMKCxqUuM38RMP9HmQ4zxAsYO0qhhfkUXRaLeH1EES
         xi9G/c2CoxxVF5VV99SBzmzb4n9XSqsLD3Al/5kqVG7A5N2sBjSw7DXN8iYVMBDCSZbq
         j7A8Aj0vR/onCZzKSbCeM5RjabNEbCka8Dwy3AgckdxAIb4FmPUtr4yvyeHba39axnnb
         Lyd+OZsew8mHHh/MlNxsABxg1KfaYKzOwG4K7MUcJPkD/qJtpjnXP2Ptx27QUhNhsnNj
         KDHg==
X-Forwarded-Encrypted: i=1; AJvYcCXp8e18PegksnTi9KEgIufH8K8NicLfpmq0mHW3veHk9I9prgptMqUwbXcPgJdZW2LwBzp3/F2rqybRSIVUaynW/3UL+XYXeYwyFduU
X-Gm-Message-State: AOJu0YwLFfdERuYmUQFldqKdMGYVttw0OZZvC2z7WPDmcUyalCk0Ra4l
	qsGZ7vqHI5tmtSt6AmyR+Fg6Bbd3M+w1hveYCbpVHEmm6N087/JdPHEfGE3FCv5XMoyH1HyhlNK
	aWHcm/+Bz81Dt7zj+weuU2Rv3bjUSSIj+EKnZrou5FxzDzTzTJr7MamHZ9ftkEI+L/f5J1lyNHj
	qKzg==
X-Received: by 2002:a17:902:724b:b0:1f7:124:b820 with SMTP id d9443c01a7336-1fb33f0a61amr2494685ad.50.1720062192159;
        Wed, 03 Jul 2024 20:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMEWUcskLLci8Rsep6v8yYezpc9Xezgy2DUGtZT7vj7K6+huCRlRjsCNdkhNYXQSR//GZHNQ==
X-Received: by 2002:a17:902:724b:b0:1f7:124:b820 with SMTP id d9443c01a7336-1fb33f0a61amr2494145ad.50.1720062189756;
        Wed, 03 Jul 2024 20:03:09 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15967f2sm110803655ad.260.2024.07.03.20.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 20:03:09 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: kvalo@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	en-wei.wu@canonical.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rickywu0421@gmail.com,
	syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com
Subject: [PATCH] wifi: virt_wifi: avoid reporting connection success with wrong SSID
Date: Thu,  4 Jul 2024 11:03:04 +0800
Message-ID: <20240704030304.16213-1-en-wei.wu@canonical.com>
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
 drivers/net/wireless/virtual/virt_wifi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 6a84ec58d618..86a8f74be654 100644
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
-- 
2.43.0


