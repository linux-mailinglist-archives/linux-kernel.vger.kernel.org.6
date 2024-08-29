Return-Path: <linux-kernel+bounces-306957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2D964601
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDAE1C21794
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ED81AD3ED;
	Thu, 29 Aug 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="J7BARKZT"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540981AB515
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937183; cv=none; b=aiPbmqRxU2f7M+naJk75+s+oUHYWb8uP5uNO4UaWJENTa7OTyk8hkhhr3ZVFe42Gf9PKHHruOAJfQaxanm7MgVwNohGhjuQkTmpROUIoz/s0KWPcAe07OvSiR/7CUM8GueLwW65GuG6S8xKsTg8QRWKxHT7yboPZgGGc+cl0o98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937183; c=relaxed/simple;
	bh=TY/JWmRiSZtiMQ0TAf+u6i4UVWxaSuovZzLy2w5lMjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1yjC6tWUlYzUVHuvQOF+ENv1oJNeJ7WnuN0XCEuKn8chy8qcMV5pDxqONPNeEmKMmPZxI0C+ntqlk48DCbAm8YwpSd0PjTFsokw8hfv6NOyyBTO/uiVHRQOMDAFVPRCf0th2kutlkjlsZqLBs2sAkP/ecblOdeN2u9pscGI2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=J7BARKZT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3da6d3f22so468652a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724937181; x=1725541981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22aHmfqwjI90w/pPkOedAr7NxRy2oPkhi9j2dLkCk3E=;
        b=J7BARKZTBJlurgm2QemHh9gZCzRCexXHiZFc55cvdyKqlIrZJYqbi0oY3e3fUoJ4sR
         d3F5seEjZaSvBVtWvxkWVTW4BgQ2tBb6tUQX/JoN5x4jqFBgFid4ihnHtloQUyeJqQU0
         9QbzfLXODbUShWZvptvJAkrxnKXMsmVYSNXb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937181; x=1725541981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22aHmfqwjI90w/pPkOedAr7NxRy2oPkhi9j2dLkCk3E=;
        b=PKoQcyo2ia5cCp0PRSapTbtahD0rW4Wc4Aj8Z7avt+928NnSTLTO1P6EYMJQn1ZCVo
         3Fr5wxUGsVdKAQVaLvEXtN0gPvMJ4SpiPKh9ZV+nhQXPtjNBOTny/OUxEAWSFknK0Acs
         PnCdiE6tXnxeKpmYrqorEaWynBrfGKNrPhFi96nXEscygethp9DeRRPLKwsQTRe9StCn
         SE40YAUcJsuBcu2MzV3lIIq9BmepdSrmrvdzHXTk/kjO4NNxbZY33ehgj7PkrzpRbfx5
         8hLnC1ftXpdk4t/xM4NQXm+YeMFFi/v2V+De1zCvo8u87Z+vrmglm/v5EyNNlatvBhTH
         umjw==
X-Forwarded-Encrypted: i=1; AJvYcCVcEZaY1Ry7OKh03iZf62MYy0FKGLBGQxvGTGHoGOmwRmeKWQGTMwz193qGiTKc97ERmzfNRl1u2/5Yvu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhW+8CuYCyOptgVnGOboGv6gnX7GpihxBFsziWhCRJqgxPexLn
	nv8IAhcDq+utEY2EA0P3JvEw+pGkECJBOmjBb3ly/HHK+W6FJxx++AzK3UByn4Y=
X-Google-Smtp-Source: AGHT+IFvljfc/Yc183V5qkQ42ui0+yJbXNPmaZhUq6obEMakZydtd3fXFn77oKh/p+qGKoJg8oZ3Lg==
X-Received: by 2002:a17:90b:1c01:b0:2d0:153f:ce00 with SMTP id 98e67ed59e1d1-2d85649ea90mr2664660a91.41.1724937181433;
        Thu, 29 Aug 2024 06:13:01 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b13c9sm10991065ad.62.2024.08.29.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:12:58 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs per-NAPI
Date: Thu, 29 Aug 2024 13:11:57 +0000
Message-Id: <20240829131214.169977-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829131214.169977-1-jdamato@fastly.com>
References: <20240829131214.169977-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow per-NAPI defer_hard_irqs setting.

The existing sysfs parameter is respected; writes to sysfs will write to
all NAPI structs for the device and the net_device defer_hard_irq field.
Reads from sysfs will read from the net_device field.

sysfs code was updated to guard against what appears to be a potential
overflow as the field is an int, but the value passed in is an unsigned
long.

The ability to set defer_hard_irqs on specific NAPI instances will be
added in a later commit, via netdev-genl.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 include/linux/netdevice.h | 23 +++++++++++++++++++++++
 net/core/dev.c            | 29 ++++++++++++++++++++++++++---
 net/core/net-sysfs.c      |  5 ++++-
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fce70990b209..7d53380da4c0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -371,6 +371,7 @@ struct napi_struct {
 	struct list_head	rx_list; /* Pending GRO_NORMAL skbs */
 	int			rx_count; /* length of rx_list */
 	unsigned int		napi_id;
+	int			defer_hard_irqs;
 	struct hrtimer		timer;
 	struct task_struct	*thread;
 	/* control-path-only fields follow */
@@ -534,6 +535,28 @@ static inline void napi_schedule_irqoff(struct napi_struct *n)
 		__napi_schedule_irqoff(n);
 }
 
+/**
+ * napi_get_defer_hard_irqs - get the NAPI's defer_hard_irqs
+ * @n: napi struct to get the defer_hard_irqs field from
+ *
+ * Returns the per-NAPI value of the defar_hard_irqs field.
+ */
+int napi_get_defer_hard_irqs(const struct napi_struct *n);
+
+/**
+ * napi_set_defer_hard_irqs - set the defer_hard_irqs for a napi
+ * @n: napi_struct to set the defer_hard_irqs field
+ * @defer: the value the field should be set to
+ */
+void napi_set_defer_hard_irqs(struct napi_struct *n, int defer);
+
+/**
+ * netdev_set_defer_hard_irqs - set defer_hard_irqs for all NAPIs of a netdev
+ * @netdev: the net_device for which all NAPIs will have their defer_hard_irqs set
+ * @defer: the defer_hard_irqs value to set
+ */
+void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer);
+
 /**
  * napi_complete_done - NAPI processing complete
  * @n: NAPI context
diff --git a/net/core/dev.c b/net/core/dev.c
index 63987b8b7c85..f7baff0da057 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6212,6 +6212,28 @@ void __napi_schedule_irqoff(struct napi_struct *n)
 }
 EXPORT_SYMBOL(__napi_schedule_irqoff);
 
+int napi_get_defer_hard_irqs(const struct napi_struct *n)
+{
+	return READ_ONCE(n->defer_hard_irqs);
+}
+EXPORT_SYMBOL_GPL(napi_get_defer_hard_irqs);
+
+void napi_set_defer_hard_irqs(struct napi_struct *n, int defer)
+{
+	WRITE_ONCE(n->defer_hard_irqs, defer);
+}
+EXPORT_SYMBOL_GPL(napi_set_defer_hard_irqs);
+
+void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer)
+{
+	struct napi_struct *napi;
+
+	WRITE_ONCE(netdev->napi_defer_hard_irqs, defer);
+	list_for_each_entry(napi, &netdev->napi_list, dev_list)
+		napi_set_defer_hard_irqs(napi, defer);
+}
+EXPORT_SYMBOL_GPL(netdev_set_defer_hard_irqs);
+
 bool napi_complete_done(struct napi_struct *n, int work_done)
 {
 	unsigned long flags, val, new, timeout = 0;
@@ -6230,7 +6252,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	if (work_done) {
 		if (n->gro_bitmask)
 			timeout = READ_ONCE(n->dev->gro_flush_timeout);
-		n->defer_hard_irqs_count = READ_ONCE(n->dev->napi_defer_hard_irqs);
+		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
 	if (n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
@@ -6368,7 +6390,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
+		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
 		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
 		if (napi->defer_hard_irqs_count && timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
@@ -6650,6 +6672,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
+	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -11032,7 +11055,7 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		dev->gro_flush_timeout = 20000;
-		dev->napi_defer_hard_irqs = 1;
+		netdev_set_defer_hard_irqs(dev, 1);
 	}
 }
 EXPORT_SYMBOL_GPL(netdev_sw_irq_coalesce_default_on);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e2084ce7b75..8272f0144d81 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -425,7 +425,10 @@ NETDEVICE_SHOW_RW(gro_flush_timeout, fmt_ulong);
 
 static int change_napi_defer_hard_irqs(struct net_device *dev, unsigned long val)
 {
-	WRITE_ONCE(dev->napi_defer_hard_irqs, val);
+	if (val > S32_MAX)
+		return -EINVAL;
+
+	netdev_set_defer_hard_irqs(dev, (int)val);
 	return 0;
 }
 
-- 
2.25.1


