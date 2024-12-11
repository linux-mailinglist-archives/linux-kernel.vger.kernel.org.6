Return-Path: <linux-kernel+bounces-440681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD69EC2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08616166023
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA520A5F1;
	Wed, 11 Dec 2024 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPYDExPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4591FECAA;
	Wed, 11 Dec 2024 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886446; cv=none; b=NtfH3BZ8bScStE2to5H4GSvO5HOAjuyU56Epaps9KeUfznyW5N3KMr/KW2lGBiZQ78uZK5Zo+iVtI6xO+Ink5WGDQXv0pCk/yzKPhQPN0BN2tzR68YDquA96cxWbIvBbtBEie5eALyMgwiDsEoZTluBK8K8zCmyzR/Kfos79g1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886446; c=relaxed/simple;
	bh=YnY9okmLhb2rO8nDQHC9+5DkEpZ8pF35PzYJ12Pfjgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcdWQJDt2K88Q0bkUG+tWFw8nWFeVPTodEA+1PyHX7tE9GcQ09hPmbU2NfknGbcO19Y72XDy0xraFM96ESHkEW3/iFiJ75X63tPcmbS34ysZYV7SVbiMQwbpOp0v1DPlBKmpKEkt2z0RARpV2cEi7oujdZAijhHAz7Cjpdv5fok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPYDExPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96E58C4CEE0;
	Wed, 11 Dec 2024 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886445;
	bh=YnY9okmLhb2rO8nDQHC9+5DkEpZ8pF35PzYJ12Pfjgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PPYDExPxVc7BRKjZcuurAIpEm7akLs9ii7geehDLqw0RGyjbT5eLeK32npeh1aWAA
	 hV2cdh7ZJlbIZlwIuk5FBEPK+cYye5G7tUDSY8e/kd9OjR4OK3pknAALQHhglIp+fl
	 DbxMWCjv9BrvAfF+7rn31G0IrHC0A9Evv0IBhfa1EEhVlkpvEhTS5U0ljMG9fyKFiG
	 qCi7NH4YnYB18FiOF/qsHe+8CVGw3DmdtxaR8zbHHwg5jxnGQn9xqmJSYTsgb56ad0
	 uksBIWZxfBv+V3rn7r4F5hdUrd21bnqKivzrAjD/32P3P6l0OxuwpuU949efiWiULY
	 UPhFu8saFzygA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B78E77183;
	Wed, 11 Dec 2024 03:07:25 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 10 Dec 2024 19:07:08 -0800
Subject: [PATCH v2 2/3] usb: typec: tcpm: Add support for parsing
 pd-revision DT property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-get_rev_upstream-v2-2-d0094e52d48f@google.com>
References: <20241210-get_rev_upstream-v2-0-d0094e52d48f@google.com>
In-Reply-To: <20241210-get_rev_upstream-v2-0-d0094e52d48f@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733886444; l=3819;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=ZW21PLDCuXrKmljq+jN/SmgnnmS/lrVcV0OJXDrQ1ss=;
 b=+Ck5oNB/ElrMm+RfnlnYn1wZ5E8R/15GJ7yUCc8n6abVyxyB6HjMQWBkp15kAfU+8HbBb2ZB6
 1YTydniyDJGAUNUOlqdWm7kr5T4x83B22cRV5EjF3X7/iwh6H26ll11
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add support for parsing "pd-revision" DT property in TCPM and store PD
revision and version supported by the Type-C connnector.

It should be noted that the PD revision is the maximum possible revision
supported by the port. This is different from the 2 bit revision set in
PD msg headers. The purpose of the 2 bit revision value is to negotiate
between Rev 2.X & 3.X spec rev as part of contract negotiation, while
this is used for Get_Revision AMS after a contract is in place.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 46 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6021eeb903fec53316dfa2d6b825c334d55b7cab..59621cfaee3d67a36f3ad6870bd1aa92d382f33a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -310,6 +310,13 @@ struct pd_data {
 	unsigned int operating_snk_mw;
 };
 
+struct pd_revision_info {
+	u8 rev_major;
+	u8 rev_minor;
+	u8 ver_major;
+	u8 ver_minor;
+};
+
 /*
  * @sink_wait_cap_time: Deadline (in ms) for tTypeCSinkWaitCap timer
  * @ps_src_wait_off_time: Deadline (in ms) for tPSSourceOff timer
@@ -567,6 +574,9 @@ struct tcpm_port {
 
 	/* Timer deadline values configured at runtime */
 	struct pd_timings timings;
+
+	/* Indicates maximum (revision, version) supported */
+	struct pd_revision_info pd_rev;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -7036,7 +7046,9 @@ static void tcpm_port_unregister_pd(struct tcpm_port *port)
 
 static int tcpm_port_register_pd(struct tcpm_port *port)
 {
-	struct usb_power_delivery_desc desc = { port->typec_caps.pd_revision };
+	u16 pd_revision = port->typec_caps.pd_revision;
+	u16 pd_version = port->pd_rev.ver_major << 8 | port->pd_rev.ver_minor;
+	struct usb_power_delivery_desc desc = { pd_revision, pd_version };
 	struct usb_power_delivery_capabilities *cap;
 	int ret, i;
 
@@ -7331,6 +7343,29 @@ static int tcpm_fw_get_snk_vdos(struct tcpm_port *port, struct fwnode_handle *fw
 	return 0;
 }
 
+static void tcpm_fw_get_pd_revision(struct tcpm_port *port, struct fwnode_handle *fwnode)
+{
+	int ret;
+	u8 val[4];
+
+	ret = fwnode_property_count_u8(fwnode, "pd-revision");
+	if (!ret || ret != 4) {
+		tcpm_log(port, "Unable to find pd-revision property or incorrect array size");
+		return;
+	}
+
+	ret = fwnode_property_read_u8_array(fwnode, "pd-revision", val, 4);
+	if (ret) {
+		tcpm_log(port, "Failed to parse pd-revision, ret:(%d)", ret);
+		return;
+	}
+
+	port->pd_rev.rev_major = val[0];
+	port->pd_rev.rev_minor = val[1];
+	port->pd_rev.ver_major = val[2];
+	port->pd_rev.ver_minor = val[3];
+}
+
 /* Power Supply access to expose source power information */
 enum tcpm_psy_online_states {
 	TCPM_PSY_OFFLINE = 0,
@@ -7669,11 +7704,18 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 		goto out_destroy_wq;
 
 	tcpm_fw_get_timings(port, tcpc->fwnode);
+	tcpm_fw_get_pd_revision(port, tcpc->fwnode);
 
 	port->try_role = port->typec_caps.prefer_role;
 
 	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
-	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
+
+	if (port->pd_rev.rev_major)
+		port->typec_caps.pd_revision = port->pd_rev.rev_major << 8 |
+					       port->pd_rev.rev_minor;
+	else
+		port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
+
 	port->typec_caps.svdm_version = SVDM_VER_2_0;
 	port->typec_caps.driver_data = port;
 	port->typec_caps.ops = &tcpm_ops;

-- 
2.47.0.338.g60cca15819-goog



