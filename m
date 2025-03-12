Return-Path: <linux-kernel+bounces-558359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC50EA5E4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F813AE9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E1525A35B;
	Wed, 12 Mar 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FtyPwsMV"
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A91F09A1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809122; cv=none; b=csBdl7WcHjVHxWkUzP9qXg5UA6l6favY+l8CBQPWshRP/7TCzEsa0p5RhtLXmZC7J15xFJumt8nNPhv8DxNysjrNsIBp+27AliOOeLUwvZtwP6FTbxN4mNgabHtWcRKT96fn7Q3OVOl/l2wrdfJnFyrIE1Wfzbmtr7xyV4JJ9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809122; c=relaxed/simple;
	bh=DCiRCv2YP+zAqkYxz2M9tKKS8ND4+qlaQKA6qe1QI1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REJQVPeMAGrT/JHxR9AvH95t4apdfyDUE6jWVZjWGy9lypocXQFHmtpKKNXNpmWWhgE+JNhjFnTpsBp89LHnVNjVUyfoB97Otqvlg5+TxnGR0d6qhKTen4c0hTAArg+VAPaPf88RTmgbP94B8JCb67xDVQQnjSTXv3qJHbeaacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FtyPwsMV; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6dd01781b56so3412416d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741809118; x=1742413918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYRtGetn5eI0U7XLCVsTKGE5sj4vx1TXbmWxNemKl/g=;
        b=FtyPwsMVxUtJKMg0Bbkw7FsO7KhCpAuW9XDc2+HIu/BIqjXpkfoH8B/oR9IoYRi8pO
         e7NPIA/lzNRNnezRHwFqIUZqD7bcMa9PLq2Itl2NjVT+qUSv3FFVYw7RL9vsx7nly1l8
         U3j36hgHhn7b/hcPSmgOfaIuA/rHnn77haXtW+zOS8C195TqutXlvZqG8RWv12WxwrxX
         TxICz/Ver9d1Ru3WWBfuxhku91huMNvA4fsCiv2uSbs919Un2VDlRayz6MKK2lbYVd39
         TnS7qWUvq39odP8u1WymUKtZmGohwHcDt7ULU5TJIHk+HUmPSXl5gc/cadZz+SeecXpj
         qVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809118; x=1742413918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYRtGetn5eI0U7XLCVsTKGE5sj4vx1TXbmWxNemKl/g=;
        b=svfoSxhAj98TS61skmECYoPGyhMEv3VG8rbMhyJpGj8e004W0gw3RZ9LdNAKf71fEt
         LlZjnQmzHNPRmGPUtoEII49IcwET5PEt+Q8lVXCAiMBs9rMFffQchvDBSXKKZBAqgfbx
         dMuMD/BD3Ie/fNolTDZDPVuPsbdBn4fyRkvrUS1F5nbF/GihfqzCLvrWBkRNvYDFwA9l
         u+Wa3tMRFpJTFgUaSAOCzw2qNr8qcHNRePO48uuaPqS1qHzu00OtVfEmWqASBioae8Hl
         xqL0XYojvjRr9v4OMi9pE9XSY2sTw86WCKd50lBBedOu1UT8aG1hZcvyOV8AYhrBidVv
         MTVw==
X-Forwarded-Encrypted: i=1; AJvYcCVVRiLxDUl40AC5J8xgsjgA70uaGwF0pDp6/0jhe1Com6pj4N37WDUPtKooMrxOZd6guqSTY0wWQ6vHnYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXUAvvwcJkQAbAntSP6jU7hgiRCxHfXU/X8oEhuDyBnTOKR1c
	VgfR2gpyD1huc8lHZ+qQVVbr2AofQMeHhzIb9cf4pHQzil4zqIbEPVFWgMdsy8yge9tO9icrh/C
	wrSRIP7EAs+kwP61dfk8GULvmurDXoVaB9Vqp560sz++9Qkak
X-Gm-Gg: ASbGnctyMr6djAoB9pFTURAfPWKPVCrazF2q4HFsTtgEKATnWudTKtACbJMjDoSp3MR
	fey++FG5Djv8t/6IXHPlAWqLyqFHLu7tpLFrZl6jx6pi3vN6Fl+wQwVFhDKMd7YDgOKTrkJ3CHS
	7PwZ9jI3kPSKgJsZlzOB2vccvAUhKrJX31azfbcCcoBg5cLhGweied6hDJK2ZYwBjWy5DNcauid
	QJbZXurA1VoQrrrXOPJ19p384ghrVVvMFuBhWBMQSyz+IikIE5L/+d3NgOfht0pPTNPF2joSUI8
	aJtqv467vu8SmokQKqxqUFMpdzaNvmdLvqc=
X-Google-Smtp-Source: AGHT+IEpd1n+zzrnYjXjt4Wcq2+V1OtkThON8chLUhDq12vQ6C1Wi7nzCRD/w3CyyorQpZG20KFdLxUKaqOq
X-Received: by 2002:a05:6214:212b:b0:6e8:ff23:66d6 with SMTP id 6a1803df08f44-6e9005aef8emr294464566d6.9.1741809118314;
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e8f70a4f7esm5309096d6.33.2025.03.12.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3EF593403C7;
	Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 32A87E400CB; Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 12 Mar 2025 13:51:46 -0600
Subject: [PATCH net-next v6 1/2] net, treewide: define and use
 MAC_ADDR_STR_LEN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-netconsole-v6-1-3437933e79b8@purestorage.com>
References: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
In-Reply-To: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
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
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Simon Horman <horms@verge.net.au>
X-Mailer: b4 0.14.2

There are a few places in the tree which compute the length of the
string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
constant for this and use it where relevant. No functionality changes
are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@verge.net.au>
---
 drivers/net/netconsole.c           | 2 +-
 drivers/nvmem/brcm_nvram.c         | 2 +-
 drivers/nvmem/layouts/u-boot-env.c | 2 +-
 include/linux/if_ether.h           | 3 +++
 lib/net_utils.c                    | 4 +---
 net/mac80211/debugfs_sta.c         | 7 ++++---
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 098ea9eb02373d8bb6c8b9fd6e75a89cc4743dbc..43757b5c021698977040ad1cb0f355d59cd8ae3f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -739,7 +739,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
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


