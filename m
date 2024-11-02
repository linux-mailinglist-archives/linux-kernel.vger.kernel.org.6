Return-Path: <linux-kernel+bounces-393085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AB69B9BAF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC9DB2154E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E3F18035;
	Sat,  2 Nov 2024 00:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EdMQ/wFK"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1E3C47B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508858; cv=none; b=Hm7MhbCNZS9y4HfHDJ3riydu5h4n9iPHkH9OuHnZqsYSZlfdzJKPo1rgOsNwwgr1gNQvp19eof/sHiMpc1aowko238EdbR0G4pY9jeE7FdwmvllOBw5l3XkW5oWT6mjEzcmaKnW5SOwLY8IoNIp7g7CayQX4PGA94H9dt/YpzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508858; c=relaxed/simple;
	bh=nRBblhddC4Wbxftd3VbV6KULNGr3qIsMDBnpN6TT00g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKMzqm8vSWZNuUPy4c2ivoo9RHpYK316pQiyc2jdet8U0R3di5LaJYPGznRkUzmJJxaTfLpQOO973cj3AQurNU9Wn08SKdFI9anTu3yFuNTOJsaiEcNbmAQUVaQoYtF1htbIiFx/Y8cYX7M9zVfcRy61ni8aX7GZD0zqLvOJUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EdMQ/wFK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-720be2b27acso1926480b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730508856; x=1731113656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5LKEdV6HP4yIuWo2dodz4RIUTy9Jbn4GlOxrAsLcFU=;
        b=EdMQ/wFKTRWP7TEVUpFffVnQuyct9ZNfj5JmivlOABVvHltn8OOp77xaXXNoiyVPKz
         4aTDmJbaXvh7dP426PHxFN3s5RqWW6Km1BtZSPUyEYUpzWVtMCho/CevxggKRkgw2Fps
         /tqJZccb4kIGyjTNZTUHjQuCFQt4zaoqYkJA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508856; x=1731113656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5LKEdV6HP4yIuWo2dodz4RIUTy9Jbn4GlOxrAsLcFU=;
        b=nW/wDgzxLVINvlBOMyEk+cKFkZUeameW+z6NGSAm2yFm0rQrBA/QigTqy/NLbKtlb3
         0pLpEj/OzFbNvabh0q2h0H0cy9oMXQYqMQQqns1bQg8wTVk+qsehnbl+R9+ipe12k97n
         5/3OcrTltpSUzfAO0bvqppvNKJRJduXxjXFh9Slvp0fDnrb4JqvmJOhoyZsTlAKUXotr
         tNxiNeioFBnyUSiVlO97ct5fXk7AnfksLDl8CX6I8nJF6+DA3EEC0t0ahXnssAa2Ii4w
         ws1KIuemm7jsqUrNGhCatdDXP7SlaezhwOjbLmR1xd/wlfbgBdsq+t7j2z13122iocpe
         Ismw==
X-Forwarded-Encrypted: i=1; AJvYcCU0akV+DY/byp/BW/dlVY8n4ooICx8/vEJKlNXvUzLFuq+5+xmJ85jmsBHtrYZJiroF7AEP0eTxFx73rCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjasnRxoHH3GVYJ4p4oRVF1/42A+lMjC5Kg2v+2UcTLbEqBtJG
	nzJ3nqUYc0mfSpTkCyySVqbYFXhsetnoocr527Fpt6PDmG4UxV6zqlUq3shIsfU=
X-Google-Smtp-Source: AGHT+IGNGoetZwf/8DHyMJu1JI+ygccnV8VeTcEQgFDvrzgSKBDC1hclUno0vPiKtCbp4IU8bDU2jw==
X-Received: by 2002:a05:6a21:a34c:b0:1cc:9f25:54d4 with SMTP id adf61e73a8af0-1db91e68252mr12469348637.38.1730508855804;
        Fri, 01 Nov 2024 17:54:15 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc3152fesm3274549b3a.195.2024.11.01.17.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:54:15 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: bagasdotme@gmail.com,
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
Subject: [PATCH net-next v4 1/7] net: Add napi_struct parameter irq_suspend_timeout
Date: Sat,  2 Nov 2024 00:51:57 +0000
Message-Id: <20241102005214.32443-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241102005214.32443-1-jdamato@fastly.com>
References: <20241102005214.32443-1-jdamato@fastly.com>
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


