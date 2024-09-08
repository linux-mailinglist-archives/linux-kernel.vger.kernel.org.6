Return-Path: <linux-kernel+bounces-320309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E999708B0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7A91F210B9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED7175D5A;
	Sun,  8 Sep 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UcrojUoR"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A7175D59
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811742; cv=none; b=fpM4EQCsatcqIUymeJnpJXQirPhs/N0F3gEpT6fSAGvzgGBQRxWDYBAnOqRP/tsFlIJArivcBFjZhP+zrn0HuET+GPyOZ/sSRqs4Z2vo5OgdCiViDBxkBaWxFzb+Tjb+xR6uhzkw4h4toNF+2ZxwixIgTkvEIefn3o+q0X0Wbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811742; c=relaxed/simple;
	bh=xROhpCG/UFEqyPlPHFBjL+Ei3IMKFCnsu+i2mJFrfH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLnHUmarV2MIhiiPuna+vv8ldcGuwsCgt2EmCkgHhgJHGB5GwjYZVYYWHmoEKQ+plb8DHEhMIBXvbbsIy5VxRFfMqup5DWBMiXGyZy/hwOgbR8fkzKWEJNOsL8U8MRvej5Hs8KRCque9+ZinVRU8kVNhzTrKRjLbZOg2S5hMqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UcrojUoR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718d606726cso1645547b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811740; x=1726416540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjuOdM76RGp3MQYm8FNYFfW8Ad8/c/uFJG5zKSZKRs4=;
        b=UcrojUoR47QsbVddSVJXoRJrwtGmBnePKrStMsH5hZI8pzuMaxIoZhPO8V3Y8fI5TT
         YqFbLq716nPBXKUdU7UZRj8zOEJhLMNA8AzO8bDNtd4nbt0dQL+b/XPAUky4rvcC/DJ+
         8oMzgdGQC2bLGf94bXRiZr21yNk3WQdQsgmAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811740; x=1726416540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjuOdM76RGp3MQYm8FNYFfW8Ad8/c/uFJG5zKSZKRs4=;
        b=rsu2VD+kCWOe19BNgzTCqVH6bF2u8B3Yu/0mb6sA6veU/t1zQ1buOjLrj66AlMa4W6
         2vjEbARm+OdLxJzfEBAaqEDedzOto1nJ3FGa7vWARVFRHBv+oqtW1iSgXnxe1Nlww+MI
         rYk33jcPw8TnfkE19yFIm8z16/aTDt90RgrtFZasNttg9BCyy5SQVU2XcZQvIMAKM5RH
         fOfyF1RYurL3p5wHkl4L8mWTrROz6YMxVEdUMlqS06cl3Koq7toTy5k1F8NB7hwj2VfL
         sEz8tTjCPQiu4x8OoD7Ao3rdx+dUs5ZqAh9lv1iWHNiNofMI3d9DCg+6WkrHQc31Yzrj
         4D4A==
X-Forwarded-Encrypted: i=1; AJvYcCXl84cWXU3mB60wjSRPf+V7DyQUR9vdufVttk4roXXc92E1iey95NYYTsNAuzo8XEHSETlWxtPQNTFZMwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZliACI1QAnIqgDS0wdMAuEbxr8O7EPfaQgb1PNcQadSBLhGi
	atufo/p3kKL8AzeJa+GngKfy/isTVPcU3SkI1ymtz0TTFvZH6/iMxZwa4xwN8S8=
X-Google-Smtp-Source: AGHT+IFc2+MJ78cW07NMZFUPaJZvV2Tyokj10k8rhRH/L30+78xT+3ctMyGfzd0g5mcjr2mR8Wy2DQ==
X-Received: by 2002:a17:903:1ca:b0:205:80e7:dcc5 with SMTP id d9443c01a7336-206f0612c3fmr130641445ad.44.1725811740001;
        Sun, 08 Sep 2024 09:09:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:08:59 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 6/9] netdev-genl: Support setting per-NAPI config values
Date: Sun,  8 Sep 2024 16:06:40 +0000
Message-Id: <20240908160702.56618-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to set per-NAPI defer_hard_irqs and gro_flush_timeout.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 12 ++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 15 +++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 52 +++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 82 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 3034c480d0b4..7c0c25e5b808 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -642,6 +642,18 @@ operations:
             - rx-bytes
             - tx-packets
             - tx-bytes
+    -
+      name: napi-set
+      doc: Set configurable NAPI instance settings.
+      attribute-set: napi
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - index
+            - defer-hard-irqs
+            - gro-flush-timeout
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index fd02b5b3b081..4e6941b45f3e 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -189,6 +189,7 @@ enum {
 	NETDEV_CMD_QUEUE_GET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
+	NETDEV_CMD_NAPI_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8350a0afa9ec..209c56cf08f1 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -74,6 +74,14 @@ static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE
 	[NETDEV_A_QSTATS_SCOPE] = NLA_POLICY_MASK(NLA_UINT, 0x1),
 };
 
+/* NETDEV_CMD_NAPI_SET - set */
+static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
+	[NETDEV_A_NAPI_IFINDEX] = { .type = NLA_U32, },
+	[NETDEV_A_NAPI_INDEX] = { .type = NLA_U32, },
+	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = { .type = NLA_S32 },
+	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -151,6 +159,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_QSTATS_SCOPE,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_NAPI_SET,
+		.doit		= netdev_nl_napi_set_doit,
+		.policy		= netdev_napi_set_nl_policy,
+		.maxattr	= NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 4db40fd5b4a9..b70cb0f20acb 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -28,6 +28,7 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
 			       struct netlink_callback *cb);
 int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 68ec8265567d..fca1670706cc 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -303,6 +303,58 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+static int
+netdev_nl_napi_set_config(struct napi_storage *napi_storage, struct genl_info *info)
+{
+	u64 gro_flush_timeout = 0;
+	int defer = 0;
+
+	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
+		defer = nla_get_s32(info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]);
+		WRITE_ONCE(napi_storage->defer_hard_irqs, defer);
+	}
+
+	if (info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]) {
+		gro_flush_timeout = nla_get_uint(info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]);
+		WRITE_ONCE(napi_storage->gro_flush_timeout, gro_flush_timeout);
+	}
+
+	return 0;
+}
+
+int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct napi_storage *napi_storage;
+	struct net_device *netdev;
+	u32 ifindex;
+	u32 index;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_IFINDEX))
+		return -EINVAL;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_INDEX))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_NAPI_IFINDEX]);
+	index = nla_get_u32(info->attrs[NETDEV_A_NAPI_INDEX]);
+
+	rtnl_lock();
+
+	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	if (netdev) {
+		napi_storage = &netdev->napi_storage[index];
+		err = netdev_nl_napi_set_config(napi_storage, info);
+	} else {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_IFINDEX]);
+		err = -ENODEV;
+	}
+
+	rtnl_unlock();
+
+	return err;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index b088a34e9254..4c5bfbc85504 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -188,6 +188,7 @@ enum {
 	NETDEV_CMD_QUEUE_GET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
+	NETDEV_CMD_NAPI_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.25.1


