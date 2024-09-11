Return-Path: <linux-kernel+bounces-324822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8888F975156
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402AA287300
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC918785F;
	Wed, 11 Sep 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUoL3Pvn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D319992A;
	Wed, 11 Sep 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055953; cv=none; b=ARQaVBHpYoUwB0ISESvqW5JGYN2Zbwpj3xNPj302RGigESYeCPwVxqxH8vf2Gn1TqKHCKrnuhI/6bRiVMp5DpkfqFTPNRKlERHMtdZvrrtcWA9M+M+fDA7gjHzXCwzCvHc3L2t2o9hUndG/feZGzSvIdfs+dM8QUPEotk8Xk3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055953; c=relaxed/simple;
	bh=WAgu6JTe9rbbUDigxdAPNYw1V4HycexXa8xhS8dmrtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCbWLygZRZjJLvV4moi5ClMZ9jdhxQbaW7rWXCr0CTPr7se0a2N9pNqHiWN7VYv6/Mo1/SN8OOL/dLGp6vBf+8mWGlcGoi+zP2XgB6X+xp1nwtzCXw2K4O6dFz3cLiZQO6RDf9bFZukA6/llSQ6+DlwU8UEA8UDH25jwxGx2A1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUoL3Pvn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055952; x=1757591952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WAgu6JTe9rbbUDigxdAPNYw1V4HycexXa8xhS8dmrtw=;
  b=CUoL3PvnDvUuqw+xlACX2+P2khGySavfxngbXOJxzUco8VchSaRrDwcF
   vOWHdpxaJ92P3PVuU4l+wAO52/8nnD8v5zc0yNI+Z7r4cWQfVbjUtKCHx
   X3OV7cwKMTIy9g3u7RHc2lG14h0Riu6wIcTdhtGz/Dd0xo+3y+WTDJxac
   AJYuvDg0Vcg1MZDO+KMpZJci8V0ZfRehNZyKD3i4WQzI5f3PVeeXJMoy/
   +/9fUgWiSOA7YQSeUtIyeoKuRw9+0eDuOUuSPw3ShUeDKa/4rVaOU0Utb
   e6IG4F37SfxaqQzaTmTOUFDVkuBKStj1dL5KPrcVDE8fOmRdBLzoDIJIh
   g==;
X-CSE-ConnectionGUID: 7/oa7RlESKC5NA2blvSahQ==
X-CSE-MsgGUID: iq2X3nK3Qay2sd75ZwTSvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417234"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:12 -0700
X-CSE-ConnectionGUID: FYgaz57bRiSJUztxBhqx/g==
X-CSE-MsgGUID: qRypAEX+TNKBAOEO0/HvOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292736"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:09 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 04/14] soundwire: optimize sdw_bus structure
Date: Wed, 11 Sep 2024 19:58:17 +0800
Message-ID: <20240911115827.233171-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
References: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The sdw_bus structure has seen multiple additions over the years. It's
one of the most used structures in this subsystem, so there's merit in
reshuffling the members a bit with 'pahole' to reduce holes and
structures across cache lines.

before:

struct sdw_bus {
	struct device *            dev;                  /*     0     8 */
	struct sdw_master_device * md;                   /*     8     8 */
	int                        controller_id;        /*    16     4 */
	unsigned int               link_id;              /*    20     4 */
	int                        id;                   /*    24     4 */

	/* XXX 4 bytes hole, try to pack */

	struct list_head           slaves;               /*    32    16 */
	long unsigned int          assigned[1];          /*    48     8 */
	struct mutex               bus_lock;             /*    56   160 */
	/* --- cacheline 3 boundary (192 bytes) was 24 bytes ago --- */
	struct lock_class_key      bus_lock_key;         /*   216    16 */
	struct mutex               msg_lock;             /*   232   160 */
	/* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
	struct lock_class_key      msg_lock_key;         /*   392    16 */
	int                        (*compute_params)(struct sdw_bus *); /*   408     8 */
	const struct sdw_master_ops  * ops;              /*   416     8 */
	const struct sdw_master_port_ops  * port_ops;    /*   424     8 */
	struct sdw_bus_params      params;               /*   432    36 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 7 boundary (448 bytes) was 24 bytes ago --- */
	struct sdw_master_prop     prop;                 /*   472    72 */

	/* XXX last struct has 6 bytes of padding */

	/* --- cacheline 8 boundary (512 bytes) was 32 bytes ago --- */
	void *                     vendor_specific_prop; /*   544     8 */
	struct list_head           m_rt_list;            /*   552    16 */
	struct dentry *            debugfs;              /*   568     8 */
	/* --- cacheline 9 boundary (576 bytes) --- */
	struct irq_chip            irq_chip;             /*   576   264 */
	/* --- cacheline 13 boundary (832 bytes) was 8 bytes ago --- */
	struct irq_domain *        domain;               /*   840     8 */
	struct sdw_defer           defer_msg;            /*   848   112 */
	/* --- cacheline 15 boundary (960 bytes) --- */
	unsigned int               clk_stop_timeout;     /*   960     4 */
	u32                        bank_switch_timeout;  /*   964     4 */
	bool                       multi_link;           /*   968     1 */

	/* XXX 3 bytes hole, try to pack */

	int                        hw_sync_min_links;    /*   972     4 */
	int                        stream_refcount;      /*   976     4 */

	/* size: 984, cachelines: 16, members: 27 */
	/* sum members: 969, holes: 3, sum holes: 11 */
	/* padding: 4 */
	/* paddings: 1, sum paddings: 6 */
	/* last cacheline: 24 bytes */
};

after:

struct sdw_bus {
	struct device *            dev;                  /*     0     8 */
	struct sdw_master_device * md;                   /*     8     8 */
	struct lock_class_key      bus_lock_key;         /*    16    16 */
	struct mutex               bus_lock;             /*    32   160 */
	/* --- cacheline 3 boundary (192 bytes) --- */
	struct list_head           slaves;               /*   192    16 */
	struct lock_class_key      msg_lock_key;         /*   208    16 */
	struct mutex               msg_lock;             /*   224   160 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	struct list_head           m_rt_list;            /*   384    16 */
	struct sdw_defer           defer_msg;            /*   400   112 */
	/* --- cacheline 8 boundary (512 bytes) --- */
	struct sdw_bus_params      params;               /*   512    36 */
	int                        stream_refcount;      /*   548     4 */
	const struct sdw_master_ops  * ops;              /*   552     8 */
	const struct sdw_master_port_ops  * port_ops;    /*   560     8 */
	struct sdw_master_prop     prop;                 /*   568    72 */

	/* XXX last struct has 6 bytes of padding */

	/* --- cacheline 10 boundary (640 bytes) --- */
	void *                     vendor_specific_prop; /*   640     8 */
	int                        hw_sync_min_links;    /*   648     4 */
	int                        controller_id;        /*   652     4 */
	unsigned int               link_id;              /*   656     4 */
	int                        id;                   /*   660     4 */
	int                        (*compute_params)(struct sdw_bus *); /*   664     8 */
	long unsigned int          assigned[1];          /*   672     8 */
	unsigned int               clk_stop_timeout;     /*   680     4 */
	u32                        bank_switch_timeout;  /*   684     4 */
	struct irq_chip            irq_chip;             /*   688   264 */
	/* --- cacheline 14 boundary (896 bytes) was 56 bytes ago --- */
	struct irq_domain *        domain;               /*   952     8 */
	/* --- cacheline 15 boundary (960 bytes) --- */
	struct dentry *            debugfs;              /*   960     8 */
	bool                       multi_link;           /*   968     1 */

	/* size: 976, cachelines: 16, members: 27 */
	/* padding: 7 */
	/* paddings: 1, sum paddings: 6 */
	/* last cacheline: 16 bytes */
};

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 79 ++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 2caea7345c3e..6fcf122c1831 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -871,68 +871,71 @@ struct sdw_master_ops {
  * struct sdw_bus - SoundWire bus
  * @dev: Shortcut to &bus->md->dev to avoid changing the entire code.
  * @md: Master device
- * @controller_id: system-unique controller ID. If set to -1, the bus @id will be used.
- * @link_id: Link id number, can be 0 to N, unique for each Controller
- * @id: bus system-wide unique id
- * @slaves: list of Slaves on this bus
- * @assigned: Bitmap for Slave device numbers.
- * Bit set implies used number, bit clear implies unused number.
+ * @bus_lock_key: bus lock key associated to @bus_lock
  * @bus_lock: bus lock
+ * @slaves: list of Slaves on this bus
+ * @msg_lock_key: message lock key associated to @msg_lock
  * @msg_lock: message lock
- * @compute_params: points to Bus resource management implementation
- * @ops: Master callback ops
- * @port_ops: Master port callback ops
- * @params: Current bus parameters
- * @prop: Master properties
- * @vendor_specific_prop: pointer to non-standard properties
  * @m_rt_list: List of Master instance of all stream(s) running on Bus. This
  * is used to compute and program bus bandwidth, clock, frame shape,
  * transport and port parameters
- * @debugfs: Bus debugfs
- * @domain: IRQ domain
  * @defer_msg: Defer message
- * @clk_stop_timeout: Clock stop timeout computed
- * @bank_switch_timeout: Bank switch timeout computed
- * @multi_link: Store bus property that indicates if multi links
- * are supported. This flag is populated by drivers after reading
- * appropriate firmware (ACPI/DT).
+ * @params: Current bus parameters
+ * @stream_refcount: number of streams currently using this bus
+ * @ops: Master callback ops
+ * @port_ops: Master port callback ops
+ * @prop: Master properties
+ * @vendor_specific_prop: pointer to non-standard properties
  * @hw_sync_min_links: Number of links used by a stream above which
  * hardware-based synchronization is required. This value is only
  * meaningful if multi_link is set. If set to 1, hardware-based
  * synchronization will be used even if a stream only uses a single
  * SoundWire segment.
- * @stream_refcount: number of streams currently using this bus
+ * @controller_id: system-unique controller ID. If set to -1, the bus @id will be used.
+ * @link_id: Link id number, can be 0 to N, unique for each Controller
+ * @id: bus system-wide unique id
+ * @compute_params: points to Bus resource management implementation
+ * @assigned: Bitmap for Slave device numbers.
+ * Bit set implies used number, bit clear implies unused number.
+ * @clk_stop_timeout: Clock stop timeout computed
+ * @bank_switch_timeout: Bank switch timeout computed
+ * @domain: IRQ domain
+ * @irq_chip: IRQ chip
+ * @debugfs: Bus debugfs (optional)
+ * @multi_link: Store bus property that indicates if multi links
+ * are supported. This flag is populated by drivers after reading
+ * appropriate firmware (ACPI/DT).
  */
 struct sdw_bus {
 	struct device *dev;
 	struct sdw_master_device *md;
-	int controller_id;
-	unsigned int link_id;
-	int id;
-	struct list_head slaves;
-	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
-	struct mutex bus_lock;
 	struct lock_class_key bus_lock_key;
-	struct mutex msg_lock;
+	struct mutex bus_lock;
+	struct list_head slaves;
 	struct lock_class_key msg_lock_key;
-	int (*compute_params)(struct sdw_bus *bus);
+	struct mutex msg_lock;
+	struct list_head m_rt_list;
+	struct sdw_defer defer_msg;
+	struct sdw_bus_params params;
+	int stream_refcount;
 	const struct sdw_master_ops *ops;
 	const struct sdw_master_port_ops *port_ops;
-	struct sdw_bus_params params;
 	struct sdw_master_prop prop;
 	void *vendor_specific_prop;
-	struct list_head m_rt_list;
-#ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs;
-#endif
-	struct irq_chip irq_chip;
-	struct irq_domain *domain;
-	struct sdw_defer defer_msg;
+	int hw_sync_min_links;
+	int controller_id;
+	unsigned int link_id;
+	int id;
+	int (*compute_params)(struct sdw_bus *bus);
+	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
 	unsigned int clk_stop_timeout;
 	u32 bank_switch_timeout;
+	struct irq_chip irq_chip;
+	struct irq_domain *domain;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+#endif
 	bool multi_link;
-	int hw_sync_min_links;
-	int stream_refcount;
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.43.0


