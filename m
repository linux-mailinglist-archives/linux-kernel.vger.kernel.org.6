Return-Path: <linux-kernel+bounces-326318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6565497667A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E942832AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716F19F43B;
	Thu, 12 Sep 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Vv81Zeca"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A01A3021
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135715; cv=none; b=oHBxCVgwgZeyRJhiPOeVA6WUs4Y/nIqvuxL+T8A+RftGbZ/1nwrFeYbbBPuJpvTVObrVBRBGBlmN62UIeLo0Dr9m1tm70oXlrEMElCx96FmF/CY7/6cd1eMAq2q63nyztGp7ClMcokEj1AKyzg8x5Jjb5U6ngsATGniFtOxABvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135715; c=relaxed/simple;
	bh=uwnB7KIAOhvADNb1putg/UdBDY1XsRIOpiKip54wq4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h/9pj1rEumFRApm2e831zMwuFb8Ub1+ipqH26e+crMYJp76koIrLGAZMUClgpUtiLCQ+q28PdSPV4RvIhj81LtmAIfS3da9Lxw6T3vLrprUnMSOHghfxvqamTd3CRMwrJFxfakwxzrYYjURCUN/zcqsYXOJi6Rf8jKKXIWpw/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Vv81Zeca; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2057835395aso9046735ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135713; x=1726740513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYUHDiaPMMueqbiDNw78EX5OSuDZL3PEhOrFAUYYTvk=;
        b=Vv81Zecah+X4a4ehPRUutxZvwA3EWjkRoxd5L/4ivKScrDQSs/ICSo2T9d3LAVH0WU
         MfGMgIILYnAP+sUa0ZAEwzuiQZzHp39pKPsgmd9NeQJ/ct8BzGi7ZcJgPAT+bKqa2oek
         IbUFKmYnLu/mkSkV7mdNNu+SmDgo6s4CyQyQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135713; x=1726740513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYUHDiaPMMueqbiDNw78EX5OSuDZL3PEhOrFAUYYTvk=;
        b=rLTR2NnZZpk4pBGFxVrR7+BuCSRNv60OybNy2X3+QdLraW3ZlOW4MuyDbasqzPyGg4
         wICeIV5jsc3eAZlzALaEBDvmytXMkq9ogCKEXNEtQ2OesvjHQflXdrdEfoMZv1t98FZI
         jIsn9+6z5FsLxXl5417L2xsa2NhCnWjyNRroee4Vs2ZIgXvF2SnsttzOSh+Wx6G/lu5L
         XTAmE8bNoSHQQ3weKoLEiLCkkLAmGYQnZ1RFa9EntlcYMkKprKQ2lDsSb5985sBUnXn7
         w+nKsEW17CFTRIH13lTauaLFdal1zzgEKG5IVrhSfpXSlYbFE2XGD/FCrIr6UYlg4o3w
         HBEw==
X-Forwarded-Encrypted: i=1; AJvYcCWFY7j/51Ys+HN9phudoOYfp4kb59yAE+K2+VH9UdeXrilCw20OrzVmKB4g/VpymxtiioaNh4ho7U7qkvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4GY46gs6BBTYuCuTEvwuPIEOewP93gPj5BTjLZm3cT6SLFzrc
	mLXx8Rd5VkU6eoHpih5uJhatHno3NS1HyYfPA16BETDVUdQ4aWWb4UJM4r5Boss=
X-Google-Smtp-Source: AGHT+IGIaPbmPm+BmWH0g8XO++iPi7QJxTG3L1tFpxkKNLL01SFf+ArX2Trm3DSSXgpP3VdPThCIoA==
X-Received: by 2002:a17:902:da8d:b0:205:3525:81bd with SMTP id d9443c01a7336-2076e36a660mr39610215ad.29.1726135713211;
        Thu, 12 Sep 2024 03:08:33 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:32 -0700 (PDT)
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 6/9] netdev-genl: Support setting per-NAPI config values
Date: Thu, 12 Sep 2024 10:07:14 +0000
Message-Id: <20240912100738.16567-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
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
 Documentation/netlink/specs/netdev.yaml | 11 ++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 14 ++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 45 +++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 73 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 906091c3059a..319c1e179b08 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -633,6 +633,17 @@ operations:
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
+            - napi-id
+            - defer-hard-irqs
+            - gro-flush-timeout
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index b088a34e9254..4c5bfbc85504 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -188,6 +188,7 @@ enum {
 	NETDEV_CMD_QUEUE_GET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
+	NETDEV_CMD_NAPI_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8350a0afa9ec..ead570c6ff7d 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -74,6 +74,13 @@ static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE
 	[NETDEV_A_QSTATS_SCOPE] = NLA_POLICY_MASK(NLA_UINT, 0x1),
 };
 
+/* NETDEV_CMD_NAPI_SET - set */
+static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
+	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
+	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = { .type = NLA_S32 },
+	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -151,6 +158,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
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
index 4698034b5a49..3c90a2fd005a 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -300,6 +300,51 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+static int
+netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
+{
+	u64 gro_flush_timeout = 0;
+	u32 defer = 0;
+
+	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
+		defer = nla_get_u32(info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]);
+		napi_set_defer_hard_irqs(napi, defer);
+	}
+
+	if (info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]) {
+		gro_flush_timeout = nla_get_uint(info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]);
+		napi_set_gro_flush_timeout(napi, gro_flush_timeout);
+	}
+
+	return 0;
+}
+
+int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct napi_struct *napi;
+	unsigned int napi_id;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
+		return -EINVAL;
+
+	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
+
+	rtnl_lock();
+
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		err = netdev_nl_napi_set_config(napi, info);
+	} else {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
+		err = -ENOENT;
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


