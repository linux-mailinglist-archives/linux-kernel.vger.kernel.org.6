Return-Path: <linux-kernel+bounces-536108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD65FA47B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79EE3AE47C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B4622DF97;
	Thu, 27 Feb 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/47jN6d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF422D7B4;
	Thu, 27 Feb 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654718; cv=none; b=LCT4JwElMrzm6hOx5cN8dvSQvYbGaeC9BlzEqNnfQyAMrUbFc9dGbiDfq6S6cDIabZiejbRcBlZc6MP6tAZ61Gpc31dnMLXOH2F1SRflYwg7z2J7ZwvztS73vsSwhT9ilgOAv//v+fOECMQJh6jqX1vhPTVEcaoEeaArKNIEUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654718; c=relaxed/simple;
	bh=mucfkWFu30e5h8/g7C9h1wCwh6Ehed3Xm81bCO+Lft0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOGIs+HdaUM/vJ6ozXTPMxWFWMgNDHQNpc7Qa0whccLX3/pjkVkNcqXn3H5xg3jeoDVmOm+ImKsEBBaZdtdq2dXIruIfeqyjg5wFQcD14HfRQXadMrHWkOlxcqVJbBWTLFCbZppGOs9lVPKdgAqk5+ZSpIPaOVh3in8BbQCHEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/47jN6d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654717; x=1772190717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mucfkWFu30e5h8/g7C9h1wCwh6Ehed3Xm81bCO+Lft0=;
  b=O/47jN6dcysrWvNPy3nDB4JeCjU7jwigt0Rk0lL3eIzOa/QNeAHiSsKk
   NITZJJ0W3SHEaQlGNM5vlYF0XaoROrfcZdOuVV271SgEZ5ziJFjrhIjNL
   sa2DUYqSr99uljWZdNDhquZeHYPvLwgHwUhyMW4XgZ+lVv7Nq4+vZRv4D
   Q/L5256LUj/mkQFW/4CbMBn9YdGJUOjRWpWQlT/u94MT7jfYpgtwdwFZA
   IAQQ4/8gnnOwRNESk/cWg6Apqm3WcZb7i68aKcDnxmsmhvXHP+KkevYAm
   Y7zlWwvlr7VGFQdnSBkgRRXrg5nYfm2xPt+oOxUu04RQqjUQg8d3NnMHj
   g==;
X-CSE-ConnectionGUID: JKhpYU3/TZel2QhFTKeDNg==
X-CSE-MsgGUID: 3U257CF4TPy1AI/e1nKY1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189840"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189840"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:56 -0800
X-CSE-ConnectionGUID: z8zrDOeYRw23e5NewXIdYg==
X-CSE-MsgGUID: GW39ivwNSk2tGT+3cTswDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154178996"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:54 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 07/16] soundwire: bus: add send_async/wait APIs for BPT protocol
Date: Thu, 27 Feb 2025 19:11:20 +0800
Message-ID: <20250227111130.272698-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
References: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

Add definitions and helpers for the BPT/BRA protocol. Peripheral
drivers (aka ASoC codec drivers) can use this API to send bulk data
such as firmware or tables. The design intent is however NOT to
directly use this API but to rely on an intermediate regmap layer.

The API is only available when no other audio streams have been
allocated, and only one BTP/BRA stream is allowed per link. To avoid
the addition of yet another lock, the refcount tests are handled in
the stream master_runtime alloc/free routines where the bus_lock is
already held. Another benefit of this approach is that the same
bus_lock is used to handle runtime and port linked lists, which
reduces the potential for misaligned configurations.

In addition to exclusion with audio streams, BPT transfers have a lot
of overhead, specifically registers writes are needed to enable
transport in DP0. Most DMAs don't handle too well very small data sets
and they may have alignment limitations.

The size and alignment requirements are for now not handled by the
core but must be checked by platform-specific drivers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/bus.c       | 43 +++++++++++++++++++++++++++++++++++
 drivers/soundwire/bus.h       | 18 +++++++++++++++
 drivers/soundwire/stream.c    | 30 ++++++++++++++++++++++++
 include/linux/soundwire/sdw.h | 23 +++++++++++++++++++
 4 files changed, 114 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 25120aa3bd67..6f8a20014e76 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -2039,3 +2039,46 @@ void sdw_clear_slave_status(struct sdw_bus *bus, u32 request)
 	}
 }
 EXPORT_SYMBOL(sdw_clear_slave_status);
+
+int sdw_bpt_send_async(struct sdw_bus *bus, struct sdw_slave *slave, struct sdw_bpt_msg *msg)
+{
+	if (msg->len > SDW_BPT_MSG_MAX_BYTES) {
+		dev_err(bus->dev, "Invalid BPT message length %d\n", msg->len);
+		return -EINVAL;
+	}
+
+	/* check device is enumerated */
+	if (slave->dev_num == SDW_ENUM_DEV_NUM ||
+	    slave->dev_num > SDW_MAX_DEVICES) {
+		dev_err(&slave->dev, "Invalid device number %d\n", slave->dev_num);
+		return -ENODEV;
+	}
+
+	/* make sure all callbacks are defined */
+	if (!bus->ops->bpt_send_async ||
+	    !bus->ops->bpt_wait) {
+		dev_err(bus->dev, "BPT callbacks not defined\n");
+		return -EOPNOTSUPP;
+	}
+
+	return bus->ops->bpt_send_async(bus, slave, msg);
+}
+EXPORT_SYMBOL(sdw_bpt_send_async);
+
+int sdw_bpt_wait(struct sdw_bus *bus, struct sdw_slave *slave, struct sdw_bpt_msg *msg)
+{
+	return bus->ops->bpt_wait(bus, slave, msg);
+}
+EXPORT_SYMBOL(sdw_bpt_wait);
+
+int sdw_bpt_send_sync(struct sdw_bus *bus, struct sdw_slave *slave, struct sdw_bpt_msg *msg)
+{
+	int ret;
+
+	ret = sdw_bpt_send_async(bus, slave, msg);
+	if (ret < 0)
+		return ret;
+
+	return sdw_bpt_wait(bus, slave, msg);
+}
+EXPORT_SYMBOL(sdw_bpt_send_sync);
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index fc990171b3f7..02651fbb683a 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -72,6 +72,24 @@ struct sdw_msg {
 	bool page;
 };
 
+/**
+ * struct sdw_btp_msg - Message structure
+ * @addr: Start Register address accessed in the Slave
+ * @len: number of bytes to transfer. More than 64Kb can be transferred
+ * but a practical limit of SDW_BPT_MSG_MAX_BYTES is enforced.
+ * @dev_num: Slave device number
+ * @flags: transfer flags, indicate if xfer is read or write
+ * @buf: message data buffer (filled by host for write, filled
+ * by Peripheral hardware for reads)
+ */
+struct sdw_bpt_msg {
+	u32 addr;
+	u32 len;
+	u8 dev_num;
+	u8 flags;
+	u8 *buf;
+};
+
 #define SDW_DOUBLE_RATE_FACTOR		2
 #define SDW_STRM_RATE_GROUPING		1
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index d29d85d809c8..a4bea742b5d9 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1227,6 +1227,20 @@ static struct sdw_master_runtime
 	struct sdw_master_runtime *m_rt, *walk_m_rt;
 	struct list_head *insert_after;
 
+	if (stream->type == SDW_STREAM_BPT) {
+		if (bus->stream_refcount > 0 || bus->bpt_stream_refcount > 0) {
+			dev_err(bus->dev, "%s: %d/%d audio/BPT stream already allocated\n",
+				__func__, bus->stream_refcount, bus->bpt_stream_refcount);
+			return ERR_PTR(-EBUSY);
+		}
+	} else {
+		if (bus->bpt_stream_refcount > 0) {
+			dev_err(bus->dev, "%s: BPT stream already allocated\n",
+				__func__);
+			return ERR_PTR(-EAGAIN);
+		}
+	}
+
 	m_rt = kzalloc(sizeof(*m_rt), GFP_KERNEL);
 	if (!m_rt)
 		return NULL;
@@ -1255,6 +1269,8 @@ static struct sdw_master_runtime
 	m_rt->stream = stream;
 
 	bus->stream_refcount++;
+	if (stream->type == SDW_STREAM_BPT)
+		bus->bpt_stream_refcount++;
 
 	return m_rt;
 }
@@ -1303,6 +1319,8 @@ static void sdw_master_rt_free(struct sdw_master_runtime *m_rt,
 	list_del(&m_rt->bus_node);
 	kfree(m_rt);
 
+	if (stream->type == SDW_STREAM_BPT)
+		bus->bpt_stream_refcount--;
 	bus->stream_refcount--;
 }
 
@@ -2001,6 +2019,12 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	m_rt = sdw_master_rt_find(bus, stream);
 	if (!m_rt) {
 		m_rt = sdw_master_rt_alloc(bus, stream);
+		if (IS_ERR(m_rt)) {
+			ret = PTR_ERR(m_rt);
+			dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s: %d\n",
+				__func__, stream->name, ret);
+			goto unlock;
+		}
 		if (!m_rt) {
 			dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
 				__func__, stream->name);
@@ -2116,6 +2140,12 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		 * So, allocate m_rt and add Slave to it.
 		 */
 		m_rt = sdw_master_rt_alloc(slave->bus, stream);
+		if (IS_ERR(m_rt)) {
+			ret = PTR_ERR(m_rt);
+			dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s: %d\n",
+				__func__, stream->name, ret);
+			goto unlock;
+		}
 		if (!m_rt) {
 			dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s\n",
 				__func__, stream->name);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ba58e2a52322..69f3e700796d 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -824,6 +824,15 @@ struct sdw_defer {
 	struct completion complete;
 };
 
+/*
+ * Add a practical limit to BPT transfer sizes. BPT is typically used
+ * to transfer firmware, and larger firmware transfers will increase
+ * the cold latency beyond typical OS or user requirements.
+ */
+#define SDW_BPT_MSG_MAX_BYTES  (1024 * 1024)
+
+struct sdw_bpt_msg;
+
 /**
  * struct sdw_master_ops - Master driver ops
  * @read_prop: Read Master properties
@@ -839,6 +848,10 @@ struct sdw_defer {
  * @get_device_num: Callback for vendor-specific device_number allocation
  * @put_device_num: Callback for vendor-specific device_number release
  * @new_peripheral_assigned: Callback to handle enumeration of new peripheral.
+ * @bpt_send_async: reserve resources for BPT stream and send message
+ * using BTP protocol
+ * @bpt_wait: wait for message completion using BTP protocol
+ * and release resources
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
@@ -855,6 +868,9 @@ struct sdw_master_ops {
 	void (*new_peripheral_assigned)(struct sdw_bus *bus,
 					struct sdw_slave *slave,
 					int dev_num);
+	int (*bpt_send_async)(struct sdw_bus *bus, struct sdw_slave *slave,
+			      struct sdw_bpt_msg *msg);
+	int (*bpt_wait)(struct sdw_bus *bus, struct sdw_slave *slave, struct sdw_bpt_msg *msg);
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
@@ -961,6 +977,8 @@ struct sdw_stream_runtime {
  * @defer_msg: Defer message
  * @params: Current bus parameters
  * @stream_refcount: number of streams currently using this bus
+ * @btp_stream_refcount: number of BTP streams currently using this bus (should
+ * be zero or one, multiple streams per link is not supported).
  * @ops: Master callback ops
  * @port_ops: Master port callback ops
  * @prop: Master properties
@@ -998,6 +1016,7 @@ struct sdw_bus {
 	struct sdw_defer defer_msg;
 	struct sdw_bus_params params;
 	int stream_refcount;
+	int bpt_stream_refcount;
 	const struct sdw_master_ops *ops;
 	const struct sdw_master_port_ops *port_ops;
 	struct sdw_master_prop prop;
@@ -1045,6 +1064,10 @@ int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
 void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
 bool is_clock_scaling_supported_by_slave(struct sdw_slave *slave);
 
+int sdw_bpt_send_async(struct sdw_bus *bus, struct sdw_slave *slave, struct sdw_bpt_msg *msg);
+int sdw_bpt_wait(struct sdw_bus *bus, struct sdw_slave *slave, struct sdw_bpt_msg *msg);
+int sdw_bpt_send_sync(struct sdw_bus *bus, struct sdw_slave *slave, struct sdw_bpt_msg *msg);
+
 #if IS_ENABLED(CONFIG_SOUNDWIRE)
 
 int sdw_stream_add_slave(struct sdw_slave *slave,
-- 
2.43.0


