Return-Path: <linux-kernel+bounces-306959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD1964606
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2A1286933
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A145B1AE850;
	Thu, 29 Aug 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JYvjlZBh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9961AE056
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937192; cv=none; b=A5tq5bW87q1dTitB3opkLREoX+JWlMl2gNgKq84mfcxUNsinp/MqcMikMYcISG5MJ/5u7cFQog5d418mMQsiSVNdfktXMd/GJC4Nxc73vU1PjveZzxkJS3KNNMvZ8/HsfZJBjKeGpNCdQLbbNYUSMP+EiiFMqqIrEvmjWdFMX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937192; c=relaxed/simple;
	bh=NfMMj+y0jjd3+zEO9SA39G8wNB8TIgOiJ9flYi/rUVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p82mF86wQH5HnaU0A16pIhsj38tOweHfj0Y3vm2abOJulWF/SfAnveOfDJ5dqsLPIbazyRGyU35EKT+gnPZNny75bAZEvjQ5TSEZzwh+cVMUfLW68lGT8FhyVEV6Oy4B2+g2IAai8qjlnhIEEb/2wkuRRQMW7qMgNdqmvcWqqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JYvjlZBh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20219a0fe4dso5057125ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724937190; x=1725541990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J76VgAVWfMg9eT/1kj4172Eex7vGiEhRt/GH9utayOA=;
        b=JYvjlZBhSxGqvyqWdJiXYfT3gjK9poCuMaItgyU3cUnWxaCi6KnEIYvM7QH5U4Z5Re
         2DBbCqJQwOBP6fguAwhR/OADKpyEi+QB/Ru43uyaSLE7x234IO1wqO9YLdVjLmTU1N9P
         5Pi4lxgVjuyzJIqVS90aMs4ZIey9nt8+Ikt4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937190; x=1725541990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J76VgAVWfMg9eT/1kj4172Eex7vGiEhRt/GH9utayOA=;
        b=G67Spp2N16IN2ivzrfCcWqAZoV63ZiHQdNpVXeTx5hNL+26iztRT/6LCR4LF1KBSFm
         EMh+d7jycc5rU8Wzg+VN+ruY3CsBgvs5QZWp2mLnc8hyP3VnJSMI9i4NOTFzTk/UShzW
         QgM+5oMJcqJNPbTruL/DlzgXKntGRgACHjbC4MbFn/A3cJD9I6+ezexwcKzs77VFxzQ6
         bz71diBlRFcz4aKELTAygaqZh7vGSKaBrkArHAoUfdnhvhIEvbuloZgT8ljtnp4hSbst
         rJWv8c2Q7sL3YB0OqvsFWNFwZLdvHoi/rBsGQIZ1qWDcaW6HAPMO7Z+ynOWhWy2kYi5N
         ViZA==
X-Forwarded-Encrypted: i=1; AJvYcCWNVxppVnqAUa+XdQBmPAfJGFAbx9vGr0X9JGgn6OT7Wp86xTO3aKIbkLlzMDKtcnSJwDvkSa3/NQr6nMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0UU7onypT2vQf+7w48c0ENdx+JZDu5dlYp37r6U5LySLDx9+w
	HuvIhHMe8q0MrNlp4xr6Us/ytYBcuNrb4ZZnSx1E3nEqrdThMdTnPNz2A4cW2r8=
X-Google-Smtp-Source: AGHT+IGRrAws7CHX7jP1QU0EU6Idn1nTO6GPORRmwPdsv5pW4OpP6YLYsyLZx6bewfvVf8tm7K2EKQ==
X-Received: by 2002:a17:902:ec88:b0:202:883:bd6 with SMTP id d9443c01a7336-2050c4c8a3fmr36374235ad.63.1724937189882;
        Thu, 29 Aug 2024 06:13:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b13c9sm10991065ad.62.2024.08.29.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:13:09 -0700 (PDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/5] net: napi: Make gro_flush_timeout per-NAPI
Date: Thu, 29 Aug 2024 13:11:59 +0000
Message-Id: <20240829131214.169977-4-jdamato@fastly.com>
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

Allow per-NAPI gro_flush_timeout setting.

The existing sysfs parameter is respected; writes to sysfs will write to
all NAPI structs for the device and the net_device gro_flush_timeout
field.  Reads from sysfs will read from the net_device field.

The ability to set gro_flush_timeout on specific NAPI instances will be
added in a later commit, via netdev-genl.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 include/linux/netdevice.h | 26 ++++++++++++++++++++++++++
 net/core/dev.c            | 32 ++++++++++++++++++++++++++++----
 net/core/net-sysfs.c      |  2 +-
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7d53380da4c0..d00024d9f857 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -372,6 +372,7 @@ struct napi_struct {
 	int			rx_count; /* length of rx_list */
 	unsigned int		napi_id;
 	int			defer_hard_irqs;
+	unsigned long		gro_flush_timeout;
 	struct hrtimer		timer;
 	struct task_struct	*thread;
 	/* control-path-only fields follow */
@@ -557,6 +558,31 @@ void napi_set_defer_hard_irqs(struct napi_struct *n, int defer);
  */
 void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer);
 
+/**
+ * napi_get_gro_flush_timeout - get the gro_flush_timeout
+ * @n: napi struct to get the gro_flush_timeout from
+ *
+ * Returns the per-NAPI value of the gro_flush_timeout field.
+ */
+unsigned long napi_get_gro_flush_timeout(const struct napi_struct *n);
+
+/**
+ * napi_set_gro_flush_timeout - set the gro_flush_timeout for a napi
+ * @n: napi struct to set the gro_flush_timeout
+ * @timeout: timeout value to set
+ *
+ * napi_set_gro_flush_timeout sets the per-NAPI gro_flush_timeout
+ */
+void napi_set_gro_flush_timeout(struct napi_struct *n, unsigned long timeout);
+
+/**
+ * netdev_set_gro_flush_timeout - set gro_flush_timeout for all NAPIs of a netdev
+ * @netdev: the net_device for which all NAPIs will have their gro_flush_timeout set
+ * @timeout: the timeout value to set
+ */
+void netdev_set_gro_flush_timeout(struct net_device *netdev,
+				  unsigned long timeout);
+
 /**
  * napi_complete_done - NAPI processing complete
  * @n: NAPI context
diff --git a/net/core/dev.c b/net/core/dev.c
index f7baff0da057..3f7cb1085efa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6234,6 +6234,29 @@ void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer)
 }
 EXPORT_SYMBOL_GPL(netdev_set_defer_hard_irqs);
 
+unsigned long napi_get_gro_flush_timeout(const struct napi_struct *n)
+{
+	return READ_ONCE(n->gro_flush_timeout);
+}
+EXPORT_SYMBOL_GPL(napi_get_gro_flush_timeout);
+
+void napi_set_gro_flush_timeout(struct napi_struct *n, unsigned long timeout)
+{
+	WRITE_ONCE(n->gro_flush_timeout, timeout);
+}
+EXPORT_SYMBOL_GPL(napi_set_gro_flush_timeout);
+
+void netdev_set_gro_flush_timeout(struct net_device *netdev,
+				  unsigned long timeout)
+{
+	struct napi_struct *napi;
+
+	WRITE_ONCE(netdev->gro_flush_timeout, timeout);
+	list_for_each_entry(napi, &netdev->napi_list, dev_list)
+		napi_set_gro_flush_timeout(napi, timeout);
+}
+EXPORT_SYMBOL_GPL(netdev_set_gro_flush_timeout);
+
 bool napi_complete_done(struct napi_struct *n, int work_done)
 {
 	unsigned long flags, val, new, timeout = 0;
@@ -6251,12 +6274,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 
 	if (work_done) {
 		if (n->gro_bitmask)
-			timeout = READ_ONCE(n->dev->gro_flush_timeout);
+			timeout = napi_get_gro_flush_timeout(n);
 		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
 	if (n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
-		timeout = READ_ONCE(n->dev->gro_flush_timeout);
+		timeout = napi_get_gro_flush_timeout(n);
 		if (timeout)
 			ret = false;
 	}
@@ -6391,7 +6414,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
+		timeout = napi_get_gro_flush_timeout(napi);
 		if (napi->defer_hard_irqs_count && timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
@@ -6673,6 +6696,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
 	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
+	napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -11054,7 +11078,7 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
 	WARN_ON(dev->reg_state == NETREG_REGISTERED);
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		dev->gro_flush_timeout = 20000;
+		netdev_set_gro_flush_timeout(dev, 20000);
 		netdev_set_defer_hard_irqs(dev, 1);
 	}
 }
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 8272f0144d81..ff545a422b1f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -408,7 +408,7 @@ NETDEVICE_SHOW_RW(tx_queue_len, fmt_dec);
 
 static int change_gro_flush_timeout(struct net_device *dev, unsigned long val)
 {
-	WRITE_ONCE(dev->gro_flush_timeout, val);
+	netdev_set_gro_flush_timeout(dev, val);
 	return 0;
 }
 
-- 
2.25.1


