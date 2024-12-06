Return-Path: <linux-kernel+bounces-434553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3F99E682E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453A0168F09
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646421DF997;
	Fri,  6 Dec 2024 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJLOpSE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C61DE2B7;
	Fri,  6 Dec 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471218; cv=none; b=ke9NqgpqKNaCQgCNJi085lx6jp/TqavnLgKUwtfnMCkgwCUABRiZG1MzMQGidsDm3xcP0+8Z4y80eeAQjBdI3dfEKLe+Ukmc6wsOtdo4QvRBmWs5Z1z19fycJRt6OnUIo27c33Nb/C2enDZqSVifEZMtMCTvFuqtej6W1LvgLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471218; c=relaxed/simple;
	bh=YnY9okmLhb2rO8nDQHC9+5DkEpZ8pF35PzYJ12Pfjgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUCx+Uu6KmY8dBDwNxBKcyTHxFWToRztt4H4Wc3E3E4H8Jd0Rb9EIQLQw6xtcP9Jbdw8Kus1zOrSZ7vLrT/mct1eH4WFQbfOxjUclucw5ZZRrE3Ts6ORGDU/I8DIJQ0onlMqckDSk/IONBiHwr9a+WLgqL2RjV8xSmmowkMXvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJLOpSE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44989C4CEE2;
	Fri,  6 Dec 2024 07:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733471218;
	bh=YnY9okmLhb2rO8nDQHC9+5DkEpZ8pF35PzYJ12Pfjgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WJLOpSE+hFqypNmZGmqO5rQF6BCjjfId3vlfsh+RGxTT1rAdJaq2tOYUtynVpgx9r
	 rakmqFgEOOsYtoRNSnxNOdNDxl58p6MT5bRqVubT31+AlXF75Ee/lyL9xqaIKBzGit
	 7dbQc+gTid0kwgmfG0MKPRT09fjtn5+nQtAQwHLYsC0KDdDKKvEKZ9EX4m7mplRDds
	 AgL5D/1HHc9eUva7xXQeVfdMKMBObjYljID+mBqpRSQlPsSc2rNxikvXLrjXNG72zJ
	 +nwhqDkjWjllE7n6ZN2iTJ9Us8yHpub05DKmbRw230SMd6yV6NGsSBDx/WJRDSJYOX
	 RhUAR/Lk/COHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D37E7717D;
	Fri,  6 Dec 2024 07:46:58 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Thu, 05 Dec 2024 23:46:09 -0800
Subject: [PATCH 2/3] usb: typec: tcpm: Add support for parsing pd-revision
 DT property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-get_rev_upstream-v1-2-90158ee7d75f@google.com>
References: <20241205-get_rev_upstream-v1-0-90158ee7d75f@google.com>
In-Reply-To: <20241205-get_rev_upstream-v1-0-90158ee7d75f@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733471217; l=3819;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=ZW21PLDCuXrKmljq+jN/SmgnnmS/lrVcV0OJXDrQ1ss=;
 b=QQpQdKPVDVgLOvWOVKIjUMdCy+MX63R5teB+pQd2qRFLUdUbJUrENM6y9wGq7ak3j7itQHrIG
 +iHPiI8YQuvBrbyVzIUFt7aoqv5/eaqPNfu+yOFNX54vbHIjKBwyrNm
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



