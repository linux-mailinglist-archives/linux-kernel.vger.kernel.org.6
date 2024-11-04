Return-Path: <linux-kernel+bounces-395604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5B9BC06D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF881C209F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC141FDFA4;
	Mon,  4 Nov 2024 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="E7La8h2o"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771A1FDF99
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757409; cv=none; b=g/8X6r1k3lE0q1jYN6j8cxa3Na2IYCDP1815mxJUSq4/XPHhoDPMjP1aswZdk4B9pMoN9jyHvaeeErxnDEvUm/A/QvZGiFID2Ept9ZewQBd4yozMWnx3jofvBDoNty6QX2w+53zHVpzOmEAmbw2hQgK63vfn986Bz8yeKljFm5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757409; c=relaxed/simple;
	bh=vhpZbxXd7C7mjQJupVwVecfi6bQG/CCh2CT3lQxFliI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSB+4GmWjFP2ivoh1joDgDT0fVYNweRwHXY25IoBNQpQ5x4nFLexsxXYgACr0lr1oylLgGk9DymBokzBUwiKYFwy13yu8zTM+ifhV3298F7jSjLOof/Y7vwJCqXnMyQWeK+S1shCv1u8LiII7eLDnlEsg+c2KEZ4Mdq1Zi3vZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=E7La8h2o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cdb889222so45191935ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730757407; x=1731362207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8AKrkYZkK/XfTl4qhIfRCQST4FHZONknN91eVwQ+ak=;
        b=E7La8h2oWxYiztZ3iL5olF1EgWTKpfE9jdYEvVqIIr648Dnc5DGz0/7ONQCkv+NHQ5
         dJSsL/ClnEVqhwZdHw0ZWlkOwtmxAqiOhb6/d2E/3nMKYdrmOgxoaI9KaJSIogXWxyEL
         Mn/pRl/TXDABWw7sQ1ASAFV+0QuEjLDKSgWYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757407; x=1731362207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8AKrkYZkK/XfTl4qhIfRCQST4FHZONknN91eVwQ+ak=;
        b=gfutRLul6tXVBnvJqC38P9/tsiJ1N1RRmazOQM3g2/OttYZ0aaTi6RG8LtCO7gTu8f
         /SLSY2tdIe0sECHXAb+dz6brVG0wpWFgULN40aZ2beQfy5e/MOnRjjcR58xGfnl1KSpG
         C+PqnyItUw/UKH4Movj/jNeYcTI/p29AObghoDIBNi1gz8/usKGk0gv51IUrZzsIcVSq
         8QQOgI5xWCZgMpG/GbG+G+Jl1vCPmZaM0QrO47OtIAnj6gl5bxMPp7uVFgF/g0eMzwGO
         skFQCuG3q7JuAJ/vNBPlnd7qoT7GSFr5WWpzg0smlb92Gh0b5gjSCoq7H2fDHma/63rP
         D6fw==
X-Forwarded-Encrypted: i=1; AJvYcCWylyEkBe7U2k5/Q3VBwMWIr4Z13/MW11JDKkkSOwOHjkC1u8FY1Ii684L8jwLqSI7yZofZUGX4jwGZqOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYs3dDFmaA6/HeTdpLO9Cw3aqEPRz+wsNQ97wUSvUuh39CRBk
	cQ7l87af+/BTVDLwdizZsVgCLAYSjeEDJuMWRmw6knT0v0DoMNs7RjYsQpuKA2o=
X-Google-Smtp-Source: AGHT+IGZpla/tpOFXwXFyt22gVkeERj0rgsN4L4q1/aze9+jv8ZcJV0nxbmSTTBOTTlBNDYAq9n/Zw==
X-Received: by 2002:a17:902:d50e:b0:20c:bda8:3a10 with SMTP id d9443c01a7336-21103c5a090mr232854785ad.37.1730757406628;
        Mon, 04 Nov 2024 13:56:46 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm65860255ad.63.2024.11.04.13.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:56:46 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 1/7] net: Add napi_struct parameter irq_suspend_timeout
Date: Mon,  4 Nov 2024 21:55:25 +0000
Message-Id: <20241104215542.215919-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104215542.215919-1-jdamato@fastly.com>
References: <20241104215542.215919-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

Add a per-NAPI IRQ suspension parameter, which can be get/set with
netdev-genl.

This patch doesn't change any behavior but prepares the code for other
changes in the following commits which use irq_suspend_timeout as a
timeout for IRQ suspension.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v1 -> v2:
   - rewrote this patch to make irq_suspend_timeout per-napi via
     netdev-genl.

 rfc -> v1:
   - removed napi.rst documentation from this patch; added to patch 6.

 Documentation/netlink/specs/netdev.yaml |  7 +++++++
 include/linux/netdevice.h               |  2 ++
 include/uapi/linux/netdev.h             |  1 +
 net/core/dev.c                          |  2 ++
 net/core/dev.h                          | 25 +++++++++++++++++++++++++
 net/core/netdev-genl-gen.c              |  5 +++--
 net/core/netdev-genl.c                  | 12 ++++++++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 8 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index f9cb97d6106c..cbb544bd6c84 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -263,6 +263,11 @@ attribute-sets:
              the end of a NAPI cycle. This may add receive latency in exchange
              for reducing the number of frames processed by the network stack.
         type: uint
+      -
+        name: irq-suspend-timeout
+        doc: The timeout, in nanoseconds, of how long to suspend irq
+             processing, if event polling finds events
+        type: uint
   -
     name: queue
     attributes:
@@ -653,6 +658,7 @@ operations:
             - pid
             - defer-hard-irqs
             - gro-flush-timeout
+            - irq-suspend-timeout
       dump:
         request:
           attributes:
@@ -704,6 +710,7 @@ operations:
             - id
             - defer-hard-irqs
             - gro-flush-timeout
+            - irq-suspend-timeout
 
 kernel-family:
   headers: [ "linux/list.h"]
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3c552b648b27..c8ab5f08092b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -347,6 +347,7 @@ struct gro_list {
  */
 struct napi_config {
 	u64 gro_flush_timeout;
+	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
 	unsigned int napi_id;
 };
@@ -383,6 +384,7 @@ struct napi_struct {
 	struct hrtimer		timer;
 	struct task_struct	*thread;
 	unsigned long		gro_flush_timeout;
+	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e3ebb49f60d2..e4be227d3ad6 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -124,6 +124,7 @@ enum {
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/dev.c b/net/core/dev.c
index 6a31152e4606..4d910872963f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6666,6 +6666,7 @@ static void napi_restore_config(struct napi_struct *n)
 {
 	n->defer_hard_irqs = n->config->defer_hard_irqs;
 	n->gro_flush_timeout = n->config->gro_flush_timeout;
+	n->irq_suspend_timeout = n->config->irq_suspend_timeout;
 	/* a NAPI ID might be stored in the config, if so use it. if not, use
 	 * napi_hash_add to generate one for us. It will be saved to the config
 	 * in napi_disable.
@@ -6680,6 +6681,7 @@ static void napi_save_config(struct napi_struct *n)
 {
 	n->config->defer_hard_irqs = n->defer_hard_irqs;
 	n->config->gro_flush_timeout = n->gro_flush_timeout;
+	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
 	n->config->napi_id = n->napi_id;
 	napi_hash_del(n);
 }
diff --git a/net/core/dev.h b/net/core/dev.h
index 7881bced70a9..d043dee25a68 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -236,6 +236,31 @@ static inline void netdev_set_gro_flush_timeout(struct net_device *netdev,
 		netdev->napi_config[i].gro_flush_timeout = timeout;
 }
 
+/**
+ * napi_get_irq_suspend_timeout - get the irq_suspend_timeout
+ * @n: napi struct to get the irq_suspend_timeout from
+ *
+ * Return: the per-NAPI value of the irq_suspend_timeout field.
+ */
+static inline unsigned long
+napi_get_irq_suspend_timeout(const struct napi_struct *n)
+{
+	return READ_ONCE(n->irq_suspend_timeout);
+}
+
+/**
+ * napi_set_irq_suspend_timeout - set the irq_suspend_timeout for a napi
+ * @n: napi struct to set the irq_suspend_timeout
+ * @timeout: timeout value to set
+ *
+ * napi_set_irq_suspend_timeout sets the per-NAPI irq_suspend_timeout
+ */
+static inline void napi_set_irq_suspend_timeout(struct napi_struct *n,
+						unsigned long timeout)
+{
+	WRITE_ONCE(n->irq_suspend_timeout, timeout);
+}
+
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 21de7e10be16..a89cbd8d87c3 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -92,10 +92,11 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 };
 
 /* NETDEV_CMD_NAPI_SET - do */
-static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
+static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT + 1] = {
 	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
+	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
 };
 
 /* Ops table for netdev */
@@ -186,7 +187,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.cmd		= NETDEV_CMD_NAPI_SET,
 		.doit		= netdev_nl_napi_set_doit,
 		.policy		= netdev_napi_set_nl_policy,
-		.maxattr	= NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b49c3b4e5fbe..765ce7c9d73b 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -161,6 +161,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	unsigned long irq_suspend_timeout;
 	unsigned long gro_flush_timeout;
 	u32 napi_defer_hard_irqs;
 	void *hdr;
@@ -196,6 +197,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			napi_defer_hard_irqs))
 		goto nla_put_failure;
 
+	irq_suspend_timeout = napi_get_irq_suspend_timeout(napi);
+	if (nla_put_uint(rsp, NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+			 irq_suspend_timeout))
+		goto nla_put_failure;
+
 	gro_flush_timeout = napi_get_gro_flush_timeout(napi);
 	if (nla_put_uint(rsp, NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 			 gro_flush_timeout))
@@ -306,6 +312,7 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 static int
 netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 {
+	u64 irq_suspend_timeout = 0;
 	u64 gro_flush_timeout = 0;
 	u32 defer = 0;
 
@@ -314,6 +321,11 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 		napi_set_defer_hard_irqs(napi, defer);
 	}
 
+	if (info->attrs[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT]) {
+		irq_suspend_timeout = nla_get_uint(info->attrs[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT]);
+		napi_set_irq_suspend_timeout(napi, irq_suspend_timeout);
+	}
+
 	if (info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]) {
 		gro_flush_timeout = nla_get_uint(info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]);
 		napi_set_gro_flush_timeout(napi, gro_flush_timeout);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e3ebb49f60d2..e4be227d3ad6 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -124,6 +124,7 @@ enum {
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


