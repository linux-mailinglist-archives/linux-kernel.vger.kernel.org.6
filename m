Return-Path: <linux-kernel+bounces-517095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95347A37C09
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767227A31C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C91A76DA;
	Mon, 17 Feb 2025 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bRo03DxG"
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FF1A5B8C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776745; cv=none; b=MZwGmXeHpC1XrtXqIxUNk1GJE5nX5maw0dUUCXSVhqEPoQuDtZuDoSyPwcFRDjVK462KFc8YooRy+Z/QXQieiNZWvY+XSyDZyvu2csJn1SNgf2W3MRm+vr2qCvhIzF2flT+RMDOJzpeFtxoE78OZnAkMdc2ok2O1Vc6Ep2vX3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776745; c=relaxed/simple;
	bh=9SP3e+84PPazYbiy6XBKwEpLpUqLgr7OPIfv2oglgb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1E2/QtXBiafgLJNCIDbeS/Rud36jL1BSiIa0gNpavya3/bvthKFYCqdijDUZPfDBMFj0wDcQXnq1H5R+t4UFqX18pXZgDSDXapGEE//+4rAS28jt6oMiIG6SfAHkz6OqdXQecd0+Bjv2GmxwsLPJkkphA1zR4Not8eeCS37shY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bRo03DxG; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-8559d67a0ebso5235739f.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739776743; x=1740381543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/lIZdaULwllL9eB2jMZEZDqOXSYIw/jFwTSaiFKlq0=;
        b=bRo03DxGOageFCm61pZAVRBnpczBMh9TdRNS1ukuooGFCrJf7TAm7QdtjMMlEKX1W2
         j8ZT3JqD+QDH4hTE48rYLDuvYEfawOj5rZ+ODB8XcsCTpsVkKORlxyBa8MPAO4pyl4mX
         zyahPt7LkssDpO0M2jJGE82Cfr9Qf+vKGEeO8Q5h8QE2orb4t3Q8uIpOpqVLMwyrecYY
         dOWLE6G28YpvvNRxPdti4yk9bP0YzOH5neuSRS3kVfwsQiUW9u5YJGRZxgHDe7pwBDlD
         AEHURRpQ3tc9Dtylts0xxFh+BgYewKLcPLu5Xnj7dJfpKb5AWL+s+p6Yz+XgjHBTV9WD
         iU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776743; x=1740381543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/lIZdaULwllL9eB2jMZEZDqOXSYIw/jFwTSaiFKlq0=;
        b=n8+Kr9PNB0wn61GnakcQH0f0rsnwjTG/DCsdP0ZXTSCjlzYLB89+8JKPhhqqrG+avh
         4p+zy+hD0BNHW6ZhsNOWRgMEJW0EQSE/NmwQI8YSiJm1xVYw8+kAfxpr99OEOQ5HiG3c
         dGYmia1QaXTwa8taPyVR2lBkHgWheusIaGU9kHwBbMdvZkaR9Sc2Q+rU6X5tfrx5jwjO
         9Q5dJah+SIK2pDtO7h4FgWTZ5YV4t9NDnc38NLDk4QdEdHZtTZh3NTC608Gq1UAktjJ5
         zMwejKq+BUVZ/wOd4z2wvRIVMr3nZfCicMaXrQfsaEMRiUgteeF1OPjdGSddnap9fIuA
         TcGA==
X-Forwarded-Encrypted: i=1; AJvYcCUxwjvPZuGit5xrMmsS9xyc88TG/bS1/O1n92/wbxZrGaxRrbGc3auvS8P6n7kq5HYafPcGLihxF0dsgIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Mh502/Nq0qqknWMss5psQJ3iUOqdCjV3v0XAzd6a2kE7/z+1
	fM5Hjv8/Qzy4cdXv1E3RheDtDUBt1TCceIsjQKzwBAHUzuQFQkU46NokwQQHi7zp23W1IqCcsNF
	EJAjD/6OGUQVvszplw7wxZ02bR8O12VC2GyyzxF/8ERZxVM1b
X-Gm-Gg: ASbGncuzVq9zI24TmIG2Z8EqMEtLYnodYroIJSBUc5CmneE77tqzmAF9/mqKsPz0+hC
	JoNBqFUH6zcX91as2+MlOrgEJW0Ve2OE90E6l/pqsRDBR2uiWbFoo3p9Y4s/+69oLfVIp6cs0hK
	6mEf2VnV+Jy3n3n9kSK7fYsTy+k+jOXJPNVxLniy/xiY8wG7vND3YUaBwQ7UeX6Y4krbH8B2ajb
	/t1d6pITQqF7dmMW+zoqv6CBoakAPFWeo9niFH8XV8FqneAXTQKsD/1zVMSZWHEuoAGZM8Rz6I1
	GThN7IKcwnWgAbuwZmV9kLRQ
X-Google-Smtp-Source: AGHT+IFmspdvwMqwmo9Ic5vcbstKN1DL+FAbVNevL9CSgdJK6lu5bk2Az58mcvHOy5eaTMPPofayKyIj+Bmv
X-Received: by 2002:a05:6602:6408:b0:855:6fa2:c324 with SMTP id ca18e2360f4ac-8557a0ce310mr872509839f.4.1739776737129;
        Sun, 16 Feb 2025 23:18:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4ed282a0d77sm547484173.54.2025.02.16.23.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:18:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8E1E334035D;
	Mon, 17 Feb 2025 00:18:55 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 84744E56BB7; Mon, 17 Feb 2025 00:18:55 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 17 Feb 2025 00:18:45 -0700
Subject: [PATCH net-next v4 2/3] net, treewide: define and use
 MAC_ADDR_STR_LEN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-netconsole-v4-2-0c681cef71f1@purestorage.com>
References: <20250217-netconsole-v4-0-0c681cef71f1@purestorage.com>
In-Reply-To: <20250217-netconsole-v4-0-0c681cef71f1@purestorage.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
X-Mailer: b4 0.14.2

There are a few places in the tree which compute the length of the
string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
constant for this and use it where relevant. No functionality changes
are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
---
 drivers/net/netconsole.c           | 2 +-
 drivers/nvmem/brcm_nvram.c         | 2 +-
 drivers/nvmem/layouts/u-boot-env.c | 2 +-
 include/linux/if_ether.h           | 3 +++
 lib/net_utils.c                    | 4 +---
 net/mac80211/debugfs_sta.c         | 7 ++++---
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f77eddf221850fe2778cd479e49c91ad695aba3c..12699831e3c9fdbafd4862a339aea4ef04cf522b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -721,7 +721,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
 	if (!mac_pton(buf, remote_mac))
 		goto out_unlock;
-	if (buf[3 * ETH_ALEN - 1] && buf[3 * ETH_ALEN - 1] != '\n')
+	if (buf[MAC_ADDR_STR_LEN] && buf[MAC_ADDR_STR_LEN] != '\n')
 		goto out_unlock;
 	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
 
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index b810df727b446b1762a1851750f743e0de6e8788..b4cf245fb2467d281111001bb7ed8db5993a09b2 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -100,7 +100,7 @@ static int brcm_nvram_read_post_process_macaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_STR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
index 731e6f4f12b2bf28e4547d128954a095545ad461..436426d4e8f910b51b92f88acddfbb40d374587a 100644
--- a/drivers/nvmem/layouts/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -37,7 +37,7 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_STR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 8a9792a6427ad9cf58b50c79cbfe185615800dcb..61b7335aa037c7232a0caa45572043057c02dde3 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -19,6 +19,9 @@
 #include <linux/skbuff.h>
 #include <uapi/linux/if_ether.h>
 
+/* XX:XX:XX:XX:XX:XX */
+#define MAC_ADDR_STR_LEN (3 * ETH_ALEN - 1)
+
 static inline struct ethhdr *eth_hdr(const struct sk_buff *skb)
 {
 	return (struct ethhdr *)skb_mac_header(skb);
diff --git a/lib/net_utils.c b/lib/net_utils.c
index 42bb0473fb22f977409f7a6792bb1340f4e911c3..215cda672fee1b5a029c2b61529c6813c0edab11 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -7,11 +7,9 @@
 
 bool mac_pton(const char *s, u8 *mac)
 {
-	size_t maxlen = 3 * ETH_ALEN - 1;
 	int i;
 
-	/* XX:XX:XX:XX:XX:XX */
-	if (strnlen(s, maxlen) < maxlen)
+	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
 		return false;
 
 	/* Don't dirty result unless string is valid MAC. */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index a67a9d3160086ac492d77092a0c8a74d2384b28c..a8948f4d983e5edee45d90ad267582657ed38e38 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -457,11 +457,12 @@ static ssize_t link_sta_addr_read(struct file *file, char __user *userbuf,
 				  size_t count, loff_t *ppos)
 {
 	struct link_sta_info *link_sta = file->private_data;
-	u8 mac[3 * ETH_ALEN + 1];
+	u8 mac[MAC_ADDR_STR_LEN + 2];
 
 	snprintf(mac, sizeof(mac), "%pM\n", link_sta->pub->addr);
 
-	return simple_read_from_buffer(userbuf, count, ppos, mac, 3 * ETH_ALEN);
+	return simple_read_from_buffer(userbuf, count, ppos, mac,
+				       MAC_ADDR_STR_LEN + 1);
 }
 
 LINK_STA_OPS(addr);
@@ -1240,7 +1241,7 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 	struct ieee80211_local *local = sta->local;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct dentry *stations_dir = sta->sdata->debugfs.subdir_stations;
-	u8 mac[3*ETH_ALEN];
+	u8 mac[MAC_ADDR_STR_LEN + 1];
 
 	if (!stations_dir)
 		return;

-- 
2.34.1


