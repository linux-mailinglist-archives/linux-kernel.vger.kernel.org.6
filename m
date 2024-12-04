Return-Path: <linux-kernel+bounces-431116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E95A9E39CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D70CB36CEA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033A1B85D7;
	Wed,  4 Dec 2024 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNpae8kF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80511B85CA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312630; cv=none; b=G/tq7g1ph0ospOYuozB3eeJQHSUslp0sDSfTdOnGm+KMcw21Zm4zP+R9a82xXTJ6b7690fH/b0cBHiOkgSkc2SfWB4W5RjfXB0q7GvhgIKMTIlQIsZNTftabkNSR+JLdoAx6ws7Qt/Yaqw3JOC096+WAvmTlRt/GrS28VLleHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312630; c=relaxed/simple;
	bh=1+z/KJU6xvjn7XX+MwP8QoPz1pxkpfF7bpjERU8+HII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQuzwfMYnSQ3zOjHftDk/ogQYnthgzd066g7oKQI0MxFUTcYPz1kxblwamxd3pxM95HX/6iw7zkJNKfL/oPwAd7uyFvYyELR8GivuVMZtjCxTmAR4ryFCjYaVo0kmeTF2JesHHzR70FS0WJwDOYR2JqC+K0oqOVD2t+vxpyGsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNpae8kF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733312627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAAUCxkswU4jgn9KaJsquRaa+KOEK5hfScrof0xevFg=;
	b=SNpae8kFysnyqavOlBAY/7ZB71J9CkaPvbrJOqhMMAoVbyoWXYQ9JgKJhLStIvwypt5gMZ
	8gCVHYSqjPsZ4RhYMj11pgSkKycfflyT+oAEqNVG2nQT2D4QPREysE6uGVzJ8DWRISRtSl
	EtJqimaEeD5vDN7YJ/MKo4/S6bph9r0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-Nb3gPDAUN-20-dKbI4VyIA-1; Wed,
 04 Dec 2024 06:43:44 -0500
X-MC-Unique: Nb3gPDAUN-20-dKbI4VyIA-1
X-Mimecast-MFC-AGG-ID: Nb3gPDAUN-20-dKbI4VyIA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15FA91955D83;
	Wed,  4 Dec 2024 11:43:42 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0B133000197;
	Wed,  4 Dec 2024 11:43:35 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH iwl-net 3/4] igb: split igb_msg_task()
Date: Wed,  4 Dec 2024 08:42:26 -0300
Message-ID: <20241204114229.21452-4-wander@redhat.com>
In-Reply-To: <20241204114229.21452-1-wander@redhat.com>
References: <20241204114229.21452-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From the perspective of PREEMPT_RT, igb_msg_task() invokes functions
that are a mix of IRQ-safe and non-IRQ-safe operations.

To address this, we separate igb_msg_task() into distinct IRQ-safe and
preemptible-safe components. This is a preparatory step for upcoming
commits, where the igb_msix_other interrupt handler will be split into
IRQ and threaded handlers, each invoking the appropriate part of the
newly divided igb_msg_task().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 88 +++++++++++++++++++++--
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 9b4235ec226df..5828831fd29c2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -149,6 +149,8 @@ static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
 static void igb_restore_vlan(struct igb_adapter *);
 static void igb_rar_set_index(struct igb_adapter *, u32);
 static void igb_ping_all_vfs(struct igb_adapter *);
+static void igb_msg_task_irq_safe(struct igb_adapter *adapter);
+static void igb_msg_task_preemptible_safe(struct igb_adapter *adapter);
 static void igb_msg_task(struct igb_adapter *);
 static void igb_vmm_control(struct igb_adapter *);
 static int igb_set_vf_mac(struct igb_adapter *, int, unsigned char *);
@@ -3681,6 +3683,30 @@ static __always_inline void vfs_unlock_irqrestore(struct igb_adapter *adapter,
 	raw_spin_unlock_irqrestore(&adapter->raw_vfs_lock, flags);
 	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 }
+
+static __always_inline void vfs_spin_lock_irqsave(struct igb_adapter *adapter,
+						  unsigned long *flags)
+{
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+}
+
+static __always_inline void vfs_spin_unlock_irqrestore(struct igb_adapter *adapter,
+						       unsigned long flags)
+{
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
+
+static __always_inline void vfs_raw_spin_lock_irqsave(struct igb_adapter *adapter,
+						      unsigned long *flags)
+{
+	raw_spin_lock_irqsave(&adapter->raw_vfs_lock, *flags);
+}
+
+static __always_inline void vfs_raw_spin_unlock_irqrestore(struct igb_adapter *adapter,
+							   unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&adapter->raw_vfs_lock, flags);
+}
 #else
 static __always_inline void vfs_lock_init(struct igb_adapter *adapter)
 {
@@ -3696,6 +3722,30 @@ static __always_inline void vfs_unlock_irqrestore(struct igb_adapter *adapter, u
 {
 	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 }
+
+static __always_inline void vfs_spin_lock_irqsave(struct igb_adapter *adapter,
+						  unsigned long *flags)
+{
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+}
+
+static __always_inline void vfs_spin_unlock_irqrestore(struct igb_adapter *adapter,
+						       unsigned long flags)
+{
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
+
+static __always_inline void vfs_raw_spin_lock_irqsave(struct igb_adapter *adapter,
+						      unsigned long *flags)
+{
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+}
+
+static __always_inline void vfs_raw_spin_unlock_irqrestore(struct igb_adapter *adapter,
+							   unsigned long flags)
+{
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
 #endif
 
 #ifdef CONFIG_PCI_IOV
@@ -8070,27 +8120,51 @@ static void igb_rcv_msg_from_vf(struct igb_adapter *adapter, u32 vf)
 	igb_unlock_mbx(hw, vf);
 }
 
-static void igb_msg_task(struct igb_adapter *adapter)
+/*
+ * Note: the split of irq and preempible safe parts of igb_msg_task()
+ * only makes sense under PREEMPT_RT.
+ * The root cause of igb_rcv_msg_from_vf() is not IRQ safe is because
+ * it calls kcalloc with GFP_ATOMIC, but GFP_ATOMIC is not IRQ safe
+ * in PREEMPT_RT.
+ */
+static void igb_msg_task_irq_safe(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned long flags;
 	u32 vf;
 
-	vfs_lock_irqsave(adapter, &flags);
+	vfs_raw_spin_lock_irqsave(adapter, &flags);
 	for (vf = 0; vf < adapter->vfs_allocated_count; vf++) {
 		/* process any reset requests */
 		if (!igb_check_for_rst(hw, vf))
 			igb_vf_reset_event(adapter, vf);
 
-		/* process any messages pending */
-		if (!igb_check_for_msg(hw, vf))
-			igb_rcv_msg_from_vf(adapter, vf);
-
 		/* process any acks */
 		if (!igb_check_for_ack(hw, vf))
 			igb_rcv_ack_from_vf(adapter, vf);
 	}
-	vfs_unlock_irqrestore(adapter, flags);
+	vfs_raw_spin_unlock_irqrestore(adapter, flags);
+}
+
+static void igb_msg_task_preemptible_safe(struct igb_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	unsigned long flags;
+	u32 vf;
+
+	vfs_spin_lock_irqsave(adapter, &flags);
+	for (vf = 0; vf < adapter->vfs_allocated_count; vf++) {
+		/* process any messages pending */
+		if (!igb_check_for_msg(hw, vf))
+			igb_rcv_msg_from_vf(adapter, vf);
+	}
+	vfs_spin_unlock_irqrestore(adapter, flags);
+}
+
+static __always_inline void igb_msg_task(struct igb_adapter *adapter)
+{
+	igb_msg_task_irq_safe(adapter);
+	igb_msg_task_preemptible_safe(adapter);
 }
 
 /**
-- 
2.47.0


