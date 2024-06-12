Return-Path: <linux-kernel+bounces-210727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716419047F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDF2B21A09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56FA34;
	Wed, 12 Jun 2024 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dK00H4gV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D1382;
	Wed, 12 Jun 2024 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718151187; cv=none; b=nUePvGGqMhfKGcKsXROGeAZiZsNyvy69HhLSNwQmzSvCDU6j0Mshw2p7Rw7XE9eDwoFC/UongIoYpIMDEU1cBUUyVMRhOUiTCTqw2n3Aaa3z2bJdTVdrUm/oM+BemgNz4JruJaNrBb1TCqa3q8T1CNMhkXHesi/6KIdgZ7CNGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718151187; c=relaxed/simple;
	bh=7vu1Ks1RnEhbT/nHOc/KjjVES6ch0isQ8pjYfNuoTfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNivn4bY2csNhV5d+4k24ofwJH9kIGlb9ftQ2RAr+/kK8zX2TkN93tWrln2ZetSIoCe1DGIjC15LaypFGBInCSzSH6CE6Uqz8jkj1L+sKP2nllg+qUBjfh6G9JgcQGr2/YqTF02RWgeHYj+d3hLQhOAnYQOJAkCxfvC/tBF1dVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dK00H4gV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718151186; x=1749687186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7vu1Ks1RnEhbT/nHOc/KjjVES6ch0isQ8pjYfNuoTfE=;
  b=dK00H4gVLd4oz6tTZr92Bm9g+srYOn9zEqzKCKM2dnQGNuX5CMiNg6pa
   mgtRfSB6JMIR2BrlQFNARtevr8J7FlMvxT655NQvK8RRwX6bQ/0EtMgJR
   wAlZ0lknbaRSUz6h6mxb8ICPrTryUPoWoQ/aPztYCnIp/qNqCWtx30Ork
   3/I3ErQYKiCSAQLTIMYHz2DXOUsCSuSiC+dTuTFxT9mAqo2eeSf3IHoki
   rhaxdulKxj65WT09X/kn2AuvmtZ5vDHUGac22sgQYToZ/CJM4Uz9/RBW4
   qEyVtWv4yaBl79QQYy4bGu3C27xADJQ8IZA21zhWKrgMlOyqeazGOq8kv
   A==;
X-CSE-ConnectionGUID: efVl+nwsTVGtW45cs5L+yw==
X-CSE-MsgGUID: HZm5hm8GQLGSlXH2gxMVjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25471314"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="25471314"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 17:13:05 -0700
X-CSE-ConnectionGUID: jEKaR3n1TxaFGUesyOu6NQ==
X-CSE-MsgGUID: hFxaRuprSFa4xjG9EHzWgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="39718795"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 17:13:06 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH next v1] kernel-wide: fix spelling mistakes like "assocative" -> "associative"
Date: Tue, 11 Jun 2024 17:12:22 -0700
Message-ID: <20240612001247.356867-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were several instances of the string "assocat" in the kernel,
which should have been spelled "associat", with the various endings of
-ive, -ed, -ion, and sometimes beginnging with dis-.

Add to the spelling dictionary the corrections so that future instances
will be caught by checkpatch, and fix the instances found.

Originally noticed by accident with a 'git grep socat'.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Checkpatch failures expected since I'm documenting the mistakes.
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 drivers/net/wireless/ti/wl1251/acx.h           | 2 +-
 drivers/scsi/qedf/qedf_main.c                  | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 2 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c   | 2 +-
 include/linux/nvme-fc-driver.h                 | 2 +-
 include/linux/soc/apple/rtkit.h                | 4 ++--
 net/netfilter/nf_conntrack_core.c              | 2 +-
 net/tipc/socket.c                              | 2 +-
 scripts/spelling.txt                           | 3 +++
 10 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 090724fa766c..d54162ce0f99 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -340,7 +340,7 @@ static int eb_create(struct i915_execbuffer *eb)
 		 * Without a 1:1 association between relocation handles and
 		 * the execobject[] index, we instead create a hashtable.
 		 * We size it dynamically based on available memory, starting
-		 * first with 1:1 assocative hash and scaling back until
+		 * first with 1:1 associative hash and scaling back until
 		 * the allocation succeeds.
 		 *
 		 * Later on we use a positive lut_size to indicate we are
diff --git a/drivers/net/wireless/ti/wl1251/acx.h b/drivers/net/wireless/ti/wl1251/acx.h
index 1da6ab664e41..af5ec7f12231 100644
--- a/drivers/net/wireless/ti/wl1251/acx.h
+++ b/drivers/net/wireless/ti/wl1251/acx.h
@@ -229,7 +229,7 @@ struct acx_rx_msdu_lifetime {
  * ===		==========
  * 31:12		Reserved - Always equal to 0.
  * 11		Association - When set, the WiLink receives all association
- * 	 	related frames (association request/response, reassocation
+ *		related frames (association request/response, reassociation
  *		request/response, and disassociation). When clear, these frames
  *		are discarded.
  * 10		Auth/De auth - When set, the WiLink receives all authentication
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index fd12439cbaab..c87518e57bff 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -2276,7 +2276,7 @@ static bool qedf_process_completions(struct qedf_fastpath *fp)
 		 * on.
 		 */
 		if (!io_req)
-			/* If there is not io_req assocated with this CQE
+			/* If there is not io_req associated with this CQE
 			 * just queue it on CPU 0
 			 */
 			cpu = 0;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 985683767a40..9ebf25a0ef9b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -979,7 +979,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	left = pkt_len - (sizeof(struct ieee80211_hdr_3addr) + ie_offset);
 	pos = pframe + (sizeof(struct ieee80211_hdr_3addr) + ie_offset);
 
-	/*  check if this stat has been successfully authenticated/assocated */
+	/*  check if this stat has been successfully authenticated/associated */
 	if (!((pstat->state) & WIFI_FW_AUTH_SUCCESS)) {
 		if (!((pstat->state) & WIFI_FW_ASSOC_SUCCESS)) {
 			status = WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA;
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index a392d5b4caf2..e9763eab16f6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -452,7 +452,7 @@ void LPS_Enter(struct adapter *padapter, const char *msg)
 	if (hal_btcoex_IsBtControlLps(padapter))
 		return;
 
-	/* Skip lps enter request if number of assocated adapters is not 1 */
+	/* Skip lps enter request if number of associated adapters is not 1 */
 	if (check_fwstate(&(dvobj->padapters->mlmepriv), WIFI_ASOC_STATE))
 		n_assoc_iface++;
 	if (n_assoc_iface != 1)
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 4109f1bd6128..1177dde77104 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -620,7 +620,7 @@ enum {
  *
  * Structure used between LLDD and nvmet-fc layer to represent the exchange
  * context for a FC-NVME FCP I/O operation (e.g. a nvme sqe, the sqe-related
- * memory transfers, and its assocated cqe transfer).
+ * memory transfers, and its associated cqe transfer).
  *
  * The structure is allocated by the LLDD whenever a FCP CMD IU is received
  * from the FC link. The address of the structure is passed to the nvmet-fc
diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
index 8c9ca857ccf6..c06d17599ae7 100644
--- a/include/linux/soc/apple/rtkit.h
+++ b/include/linux/soc/apple/rtkit.h
@@ -69,7 +69,7 @@ struct apple_rtkit;
  * Initializes the internal state required to handle RTKit. This
  * should usually be called within _probe.
  *
- * @dev:         Pointer to the device node this coprocessor is assocated with
+ * @dev:         Pointer to the device node this coprocessor is associated with
  * @cookie:      opaque cookie passed to all functions defined in rtkit_ops
  * @mbox_name:   mailbox name used to communicate with the co-processor
  * @mbox_idx:    mailbox index to be used if mbox_name is NULL
@@ -83,7 +83,7 @@ struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
  * Non-devm version of devm_apple_rtkit_init. Must be freed with
  * apple_rtkit_free.
  *
- * @dev:         Pointer to the device node this coprocessor is assocated with
+ * @dev:         Pointer to the device node this coprocessor is associated with
  * @cookie:      opaque cookie passed to all functions defined in rtkit_ops
  * @mbox_name:   mailbox name used to communicate with the co-processor
  * @mbox_idx:    mailbox index to be used if mbox_name is NULL
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 7ac20750c127..9384426ddc06 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1090,7 +1090,7 @@ static int nf_ct_resolve_clash_harder(struct sk_buff *skb, u32 repl_idx)
  * A conntrack entry can be inserted to the connection tracking table
  * if there is no existing entry with an identical tuple.
  *
- * If there is one, @skb (and the assocated, unconfirmed conntrack) has
+ * If there is one, @skb (and the associated, unconfirmed conntrack) has
  * to be dropped.  In case @skb is retransmitted, next conntrack lookup
  * will find the already-existing entry.
  *
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 2d58ecae4e21..1a0cd06f0eae 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -657,7 +657,7 @@ static int tipc_release(struct socket *sock)
 }
 
 /**
- * __tipc_bind - associate or disassocate TIPC name(s) with a socket
+ * __tipc_bind - associate or disassociate TIPC name(s) with a socket
  * @sock: socket structure
  * @skaddr: socket address describing name(s) and desired operation
  * @alen: size of socket address data structure
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index edec60d39bbf..554329a074ce 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -176,8 +176,10 @@ assigment||assignment
 assigments||assignments
 assistent||assistant
 assocaited||associated
+assocated||associated
 assocating||associating
 assocation||association
+assocative||associative
 associcated||associated
 assotiated||associated
 asssert||assert
@@ -543,6 +545,7 @@ direcly||directly
 direectly||directly
 diregard||disregard
 disassocation||disassociation
+disassocative||disassociative
 disapear||disappear
 disapeared||disappeared
 disappared||disappeared
-- 
2.43.0


