Return-Path: <linux-kernel+bounces-280116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F82C94C602
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38CCB21D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561BD158DB1;
	Thu,  8 Aug 2024 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hj+U/9Pv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D68827
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150429; cv=none; b=TDX5mDA2lvcwl9ZgRhfPd9KhSguaBZr87r8AOeOg72MOIOJ8c+aVzRvRsgMd+NgM/lUXaGbB0EuQ+E2MeTCDPfpg5ZPbEdHtdBDHdojZoTrz0G+aYoLQMQi/ykjrloxPbwNd75CMcyrlMXgnKQMPuGnXRZ+ZIQKTaKp4RV3RXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150429; c=relaxed/simple;
	bh=xJsuAMiqX6PDluABpIlHFXHrP0PUV/hZC5wmgPkWc7I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C7Q2RgpLZQ8DljI2LYCHvmuIY2e8z11N7CcM0M2vLGMBYOkJPA21zwAV8pBVTePl1N1oUWpufcR6p5Tn7iCjQIE22tCCzZ8ywbBlDW2KAqH4BX83kNF/9rt7Qtuf2Fpl+G842TTqpCZuAY5jAK6wJCA53Uygyyc9W/NtfaUbfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hj+U/9Pv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be2c7c34dso2123846276.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723150427; x=1723755227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3DNew47uCbNnaotC/0KTs39vQgR1XVr/tOdVB7ndHsg=;
        b=Hj+U/9PvciRmqjM2W0LuohjfLYEtqknD5wOoxzPY02SjYgZimU3uMqEqCdDDZc333A
         HFSvIXZ0gglJTVyXqswhTrudToSApdI3skPKXozPV9NJrMtFAEvstakw4lj9WLRjSxT1
         ThxU086ZPVl2p//ia/u8iiyH2mARX7DUIlF1cbp73N0FnL8JcSFsQ6gKwMVnqEqRraVV
         wfqCiLwDg2mP5Ag5wdIazap3Gs0cKhob+H+zOZJUz6E/UrJApdLMIqKQkXtLtFhR1uty
         bH35HPMDd86FqjFWWXs5EviRHq3mR/gHvB2v5WiJevWgZvcBM+LMDR3WGg/szxJPEqxf
         UqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150427; x=1723755227;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DNew47uCbNnaotC/0KTs39vQgR1XVr/tOdVB7ndHsg=;
        b=sKRn8w0NmFoJPutjJjb1xtiPfSQIZtQthQoGVC4IQR6gz/53pOJ8ujbYzCXDoZX+MS
         ddDcTUudpmDIcXWU3qA9d/iL+QQ8hFVhqWwBMuZnKpfbLignUuSIv8gnJUz5y8Uc/Lly
         ZnnByHewxrGsYOR6CHgvnjPYM78x9SdboY89V0324GL/CthcqfudTCJ2zhDxbTsthNiU
         yk+QA51z8uC2f1KhM3n4iXTXGsxAq51gc1r1Zs/8ygJVgKZ6QwryWfn8RDaSmMBFY835
         QVLkYw1cql+vz9ujUDazMDp0VJ1fKq+ZCHg1DjKC0HDkwPuVbiZwSg9eJaPi/3Z3TotM
         er5w==
X-Forwarded-Encrypted: i=1; AJvYcCVoP/Mr/CtboQPO50Zz7UMMFlKBN1vj8PR0NmIplx0o9F2EtwxV93ni3EjwDVn77ovegHiFyydVeyNK3NCwNlQhqb61wN7L/ksM2Dma
X-Gm-Message-State: AOJu0YzRR/4RJWvJr23uGsn4vNX33aV2aq1yNjRZhhiG0NPdGrLZgTZ3
	36HGeLRn2QQwuFMx1zF90dWAOSzmBnY2hxxPqqnih/iUuP3zFTzLlJF1c0+8IOrTiNeH5mAdf5B
	7OMbKaFvUg3zb1yMrqw6zTw==
X-Google-Smtp-Source: AGHT+IEoJ6BCALcT50f5V0KRsOPquWHqbVALqQPucltBo7uFjkokM6shwJg6eaVF4BDiT7+q4esT2e/l1D/M+hjCDg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:ab6c:0:b0:e03:31ec:8a24 with SMTP
 id 3f1490d57ef6-e0e9db832cemr10895276.8.1723150426708; Thu, 08 Aug 2024
 13:53:46 -0700 (PDT)
Date: Thu,  8 Aug 2024 20:53:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240808205345.2141858-1-almasrymina@google.com>
Subject: [PATCH net-next v1] ethtool: refactor checking max channels
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Currently ethtool_set_channel calls separate functions to check whether
the new channel number violates rss configuration or flow steering
configuration.

Very soon we need to check whether the new channel number violates
memory provider configuration as well.

To do all 3 checks cleanly, add a wrapper around
ethtool_get_max_rxnfc_channel() and ethtool_get_max_rxfh_channel(),
which does both checks. We can later extend this wrapper to add the
memory provider check in one place.

Note that in the current code, we put a descriptive genl error message
when we run into issues. To preserve the error message, we pass the
genl_info* to the common helper. The ioctl calls can pass NULL instead.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/ethtool/channels.c | 20 ++++----------------
 net/ethtool/common.c   | 32 ++++++++++++++++++++++++++++++--
 net/ethtool/common.h   |  7 +++++--
 net/ethtool/ioctl.c    | 13 +++----------
 4 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index cee188da54f85..ca4f80282448b 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -114,8 +114,7 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct net_device *dev = req_info->dev;
 	struct ethtool_channels channels = {};
 	struct nlattr **tb = info->attrs;
-	u32 err_attr, max_rxfh_in_use;
-	u64 max_rxnfc_in_use;
+	u32 err_attr;
 	int ret;
 
 	dev->ethtool_ops->get_channels(dev, &channels);
@@ -166,20 +165,9 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	/* ensure the new Rx count fits within the configured Rx flow
-	 * indirection table/rxnfc settings
-	 */
-	if (ethtool_get_max_rxnfc_channel(dev, &max_rxnfc_in_use))
-		max_rxnfc_in_use = 0;
-	max_rxfh_in_use = ethtool_get_max_rxfh_channel(dev);
-	if (channels.combined_count + channels.rx_count <= max_rxfh_in_use) {
-		GENL_SET_ERR_MSG_FMT(info, "requested channel counts are too low for existing indirection table (%d)", max_rxfh_in_use);
-		return -EINVAL;
-	}
-	if (channels.combined_count + channels.rx_count <= max_rxnfc_in_use) {
-		GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing ntuple filter settings");
-		return -EINVAL;
-	}
+	ret = ethtool_check_max_channel(dev, channels, info);
+	if (ret)
+		return ret;
 
 	/* Disabling channels, query zero-copy AF_XDP sockets */
 	from_channel = channels.combined_count +
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 07032babd1b69..718ba62dec44c 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -6,6 +6,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/ptp_clock_kernel.h>
 
+#include "netlink.h"
 #include "common.h"
 
 const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
@@ -539,7 +540,7 @@ static int ethtool_get_rxnfc_rule_count(struct net_device *dev)
 	return info.rule_cnt;
 }
 
-int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
+static int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxnfc *info;
@@ -609,7 +610,7 @@ static u32 ethtool_get_max_rss_ctx_channel(struct net_device *dev)
 	return max_ring;
 }
 
-u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
+static u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
 {
 	struct ethtool_rxfh_param rxfh = {};
 	u32 dev_size, current_max;
@@ -650,6 +651,33 @@ u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
 	return current_max;
 }
 
+int ethtool_check_max_channel(struct net_device *dev,
+			      struct ethtool_channels channels,
+			      struct genl_info *info)
+{
+	u64 max_rxnfc_in_use;
+	u32 max_rxfh_in_use;
+
+	/* ensure the new Rx count fits within the configured Rx flow
+	 * indirection table/rxnfc settings
+	 */
+	if (ethtool_get_max_rxnfc_channel(dev, &max_rxnfc_in_use))
+		max_rxnfc_in_use = 0;
+	max_rxfh_in_use = ethtool_get_max_rxfh_channel(dev);
+	if (channels.combined_count + channels.rx_count <= max_rxfh_in_use) {
+		if (info)
+			GENL_SET_ERR_MSG_FMT(info, "requested channel counts are too low for existing indirection table (%d)", max_rxfh_in_use);
+		return -EINVAL;
+	}
+	if (channels.combined_count + channels.rx_count <= max_rxnfc_in_use) {
+		if (info)
+			GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing ntuple filter settings");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int ethtool_check_ops(const struct ethtool_ops *ops)
 {
 	if (WARN_ON(ops->set_coalesce && !ops->supported_coalesce_params))
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 863806fcf01ae..d55d5201b085d 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -20,6 +20,8 @@ struct link_mode_info {
 	u8				duplex;
 };
 
+struct genl_info;
+
 extern const char
 netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN];
 extern const char
@@ -42,8 +44,9 @@ int __ethtool_get_link(struct net_device *dev);
 bool convert_legacy_settings_to_link_ksettings(
 	struct ethtool_link_ksettings *link_ksettings,
 	const struct ethtool_cmd *legacy_settings);
-u32 ethtool_get_max_rxfh_channel(struct net_device *dev);
-int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max);
+int ethtool_check_max_channel(struct net_device *dev,
+			      struct ethtool_channels channels,
+			      struct genl_info *info);
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
 
 extern const struct ethtool_phy_ops *ethtool_phy_ops;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 8ca13208d240f..62de3b1bdbff3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2065,8 +2065,6 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 {
 	struct ethtool_channels channels, curr = { .cmd = ETHTOOL_GCHANNELS };
 	u16 from_channel, to_channel;
-	u64 max_rxnfc_in_use;
-	u32 max_rxfh_in_use;
 	unsigned int i;
 	int ret;
 
@@ -2096,14 +2094,9 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 	    (!channels.rx_count || !channels.tx_count))
 		return -EINVAL;
 
-	/* ensure the new Rx count fits within the configured Rx flow
-	 * indirection table/rxnfc settings */
-	if (ethtool_get_max_rxnfc_channel(dev, &max_rxnfc_in_use))
-		max_rxnfc_in_use = 0;
-	max_rxfh_in_use = ethtool_get_max_rxfh_channel(dev);
-	if (channels.combined_count + channels.rx_count <=
-	    max_t(u64, max_rxnfc_in_use, max_rxfh_in_use))
-		return -EINVAL;
+	ret = ethtool_check_max_channel(dev, channels, NULL);
+	if (ret)
+		return ret;
 
 	/* Disabling channels, query zero-copy AF_XDP sockets */
 	from_channel = channels.combined_count +
-- 
2.46.0.76.ge559c4bf1a-goog


