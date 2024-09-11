Return-Path: <linux-kernel+bounces-324039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AE1974720
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCB32895A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C20AAD2F;
	Wed, 11 Sep 2024 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3E0PZr3"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52BA934
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726013293; cv=none; b=Kzz+lQH/H+Xk7QzEOUBMArseOT8BavgJnZAHmRTxFYZAS4WAHiuJ21VtbiQC7B6o5T7UB+tCUCzNU+OIK1ISTneZCQI6a8drVCQz+V8UgSjjhDVFDAEJlzuOGd8nT7Z4mJMLAif59Sko/sGOqYRD6Gv3uNecYtoZx4zyZsU9mUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726013293; c=relaxed/simple;
	bh=p79RmnNeFZRiI1qyJp0oe5UH7x2O20vRmHYB8e1pjnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DnM4ghVQPUdbiv8Cz5cOmP5xotZTCN03xHPFx3qrV+0P+iXAx1JslWNOxKJxB2vLz2GEnxQL7ybM2jmxqbD4FSyMRDYrFsld/NYAvv/hrAWKmutAqn8fFRQe7fH3Y154DnKxIfYyjS7W3/gEnzx+oR5RNdjk5jDI27PZfIKhAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3E0PZr3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso2305391276.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726013290; x=1726618090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSuZrkmmWtMnows6Vqiwj1CrlHfoTWnGKJn8p+iwjqk=;
        b=G3E0PZr3jvZ46JvdIf/bM3AoppGphJgPI7oscHs47zWsAHiTl1MqYeqlhYm0s2YpII
         +ABhOu+NO++geDm+WZnggxcbifWH/akgKbIDJIUqmVqVhRbOvUE/FbXMYGth3l+3l/mz
         Zt4p7BBp63TcI57mKPhtvErwZGTLpYf8vVZe3Chy0m7Q3NjsQjjlkb9ekZ0h9mCLRtVU
         2rBf8Dg2y+PzrjtgSoBRQYY1C0DtFCDrjzYf1fwwyqbBwvRq/aeffPBIHkUKBplDR1q1
         hD91rBH4O8mR2DcePUiAUb/NQV7cRMUae0I8EjRRon6wdGhkUnMQUa9a3vVJwgSAJjTB
         t87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726013290; x=1726618090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSuZrkmmWtMnows6Vqiwj1CrlHfoTWnGKJn8p+iwjqk=;
        b=lLeSEqkYLnYwLfkhQwSgcr0KhCnmKTscHUn0ShTj1UcM7wKugQ+Rez86I1bJ5HgCXa
         jW2Ga8jhSXTVDVUq5O/5Hqy6Jleg/WMgJOBb+rbeW22UtMPgdZsitsHVP/4zMVoR3k4J
         UNo5e47Wz6SG0nwVLxMkfbbX8ySYiVCh2myr7qCvCcWqZt2WY8+9Kqxuokh9uZY3bkXN
         G/28kqckOaVv6KmJbRHfQRjj+BqM0kw8p+c5KWBxDSzNR1mM0OQha9ui5vzP4xbzvLY9
         LLtg3BcWd2yE1s/rYza530hnefqHdd27L6D4Z7nRLE+1OdH1WtX9ZccA2sbo82799FaX
         4FtA==
X-Gm-Message-State: AOJu0YycURjL/7ZpjMQFJhnAIZNwpAKpByZYLLALE5gTRSq719/t5tNV
	zuJcaw8sFhU+z2nkC95dw7poB8+JfQxCEyc/+fcYF49KurXIF+QCsVMxpxzV7/pjO+PvzszvqAb
	xqA==
X-Google-Smtp-Source: AGHT+IHOqIdoAg2rmgyqW9sBWtxtlOruH3pbEyFufuku6W/fDinOxjHZ62GG721mGzE+Hp6WvzdAchgSRiU=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a5b:648:0:b0:e0e:4350:d7de with SMTP id
 3f1490d57ef6-e1d8c539e89mr1680276.9.1726013289313; Tue, 10 Sep 2024 17:08:09
 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:07:06 -0700
In-Reply-To: <20240911000715.554184-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911000715.554184-1-amitsd@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911000715.554184-3-amitsd@google.com>
Subject: [RFC 2/2] usb: typec: tcpm: Add support for pd-timers DT property
From: Amit Sunil Dhamne <amitsd@google.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kyletso@google.com, rdbabiera@google.com, 
	Amit Sunil Dhamne <amitsd@google.com>, Badhri Jagan Sridharan <badhri@google.com>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for DT property "pd-timers" to allow users to define
platform specific values. For values that have not been explicitly
defined in DT using this attribute, default values will be set.
Therefore making this change backward compatible.

Cc: Badhri Jagan Sridharan <badhri@google.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 110 ++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4b02d6474259..596d19ff85ac 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -574,6 +574,31 @@ static const char * const pd_rev[] = {
 	[PD_REV30]		= "rev3",
 };
 
+/*
+ * Though "pd-timers" is a 1D array, it can be imagined as a table with 2
+ * columns, key at even index (that represents timer definition) & value
+ * at odd index (that represents timer values in ms).
+ */
+#define NUM_TIMER_TABLE_COLS		2
+
+/*
+ * PD Timer definitions for timers that can be tuned based on platform/board via DT.
+ * The timer definition value should always match that of macros defined in
+ * dt-bindings/usb/pd.h.
+ */
+enum pd_timer {
+	PD_TIMER_SINK_WAIT_CAP,
+	PD_TIMER_PS_SOURCE_OFF,
+	PD_TIMER_CC_DEBOUNCE,
+	PD_NUM_TIMERS
+};
+
+static u32 pd_timers[PD_NUM_TIMERS] = {
+	[PD_TIMER_SINK_WAIT_CAP] = PD_T_SINK_WAIT_CAP,
+	[PD_TIMER_PS_SOURCE_OFF] = PD_T_PS_SOURCE_OFF,
+	[PD_TIMER_CC_DEBOUNCE] = PD_T_CC_DEBOUNCE,
+};
+
 #define tcpm_cc_is_sink(cc) \
 	((cc) == TYPEC_CC_RP_DEF || (cc) == TYPEC_CC_RP_1_5 || \
 	 (cc) == TYPEC_CC_RP_3_0)
@@ -4601,7 +4626,7 @@ static void run_state_machine(struct tcpm_port *port)
 {
 	int ret;
 	enum typec_pwr_opmode opmode;
-	unsigned int msecs;
+	unsigned int msecs, timer_val_msecs;
 	enum tcpm_state upcoming_state;
 
 	if (port->tcpc->check_contaminant && port->state != CHECK_CONTAMINANT)
@@ -4637,17 +4662,18 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_UNATTACHED, PD_T_DRP_SNK);
 		break;
 	case SRC_ATTACH_WAIT:
+		timer_val_msecs = pd_timers[PD_TIMER_CC_DEBOUNCE];
 		if (tcpm_port_is_debug(port))
 			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
-				       PD_T_CC_DEBOUNCE);
+				       timer_val_msecs);
 		else if (tcpm_port_is_audio(port))
 			tcpm_set_state(port, AUDIO_ACC_ATTACHED,
-				       PD_T_CC_DEBOUNCE);
+				       timer_val_msecs);
 		else if (tcpm_port_is_source(port) && port->vbus_vsafe0v)
 			tcpm_set_state(port,
 				       tcpm_try_snk(port) ? SNK_TRY
 							  : SRC_ATTACHED,
-				       PD_T_CC_DEBOUNCE);
+				       timer_val_msecs);
 		break;
 
 	case SNK_TRY:
@@ -4698,7 +4724,7 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		break;
 	case SRC_TRYWAIT_DEBOUNCE:
-		tcpm_set_state(port, SRC_ATTACHED, PD_T_CC_DEBOUNCE);
+		tcpm_set_state(port, SRC_ATTACHED, pd_timers[PD_TIMER_CC_DEBOUNCE]);
 		break;
 	case SRC_TRYWAIT_UNATTACHED:
 		tcpm_set_state(port, SNK_UNATTACHED, 0);
@@ -4896,12 +4922,13 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SRC_UNATTACHED, PD_T_DRP_SRC);
 		break;
 	case SNK_ATTACH_WAIT:
+		timer_val_msecs = pd_timers[PD_TIMER_CC_DEBOUNCE];
 		if ((port->cc1 == TYPEC_CC_OPEN &&
 		     port->cc2 != TYPEC_CC_OPEN) ||
 		    (port->cc1 != TYPEC_CC_OPEN &&
 		     port->cc2 == TYPEC_CC_OPEN))
 			tcpm_set_state(port, SNK_DEBOUNCED,
-				       PD_T_CC_DEBOUNCE);
+				       timer_val_msecs);
 		else if (tcpm_port_is_disconnected(port))
 			tcpm_set_state(port, SNK_UNATTACHED,
 				       PD_T_PD_DEBOUNCE);
@@ -4941,7 +4968,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_TRYWAIT:
 		tcpm_set_cc(port, TYPEC_CC_RD);
-		tcpm_set_state(port, SNK_TRYWAIT_VBUS, PD_T_CC_DEBOUNCE);
+		tcpm_set_state(port, SNK_TRYWAIT_VBUS, pd_timers[PD_TIMER_CC_DEBOUNCE]);
 		break;
 	case SNK_TRYWAIT_VBUS:
 		/*
@@ -5014,7 +5041,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_DISCOVERY_DEBOUNCE:
 		tcpm_set_state(port, SNK_DISCOVERY_DEBOUNCE_DONE,
-			       PD_T_CC_DEBOUNCE);
+			       pd_timers[PD_TIMER_CC_DEBOUNCE]);
 		break;
 	case SNK_DISCOVERY_DEBOUNCE_DONE:
 		if (!tcpm_port_is_disconnected(port) &&
@@ -5032,6 +5059,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_READY, 0);
 			break;
 		}
+		timer_val_msecs = pd_timers[PD_TIMER_SINK_WAIT_CAP];
 		/*
 		 * If VBUS has never been low, and we time out waiting
 		 * for source cap, try a soft reset first, in case we
@@ -5041,10 +5069,10 @@ static void run_state_machine(struct tcpm_port *port)
 		if (port->vbus_never_low) {
 			port->vbus_never_low = false;
 			tcpm_set_state(port, SNK_SOFT_RESET,
-				       PD_T_SINK_WAIT_CAP);
+				       timer_val_msecs);
 		} else {
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
-				       PD_T_SINK_WAIT_CAP);
+				       timer_val_msecs);
 		}
 		break;
 	case SNK_WAIT_CAPABILITIES_TIMEOUT:
@@ -5054,7 +5082,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 * sending Source Capability messages after a soft reset. The
 		 * specification suggests to do a hard reset when no Source
 		 * capability message is received within PD_T_SINK_WAIT_CAP,
-		 * but that might effectively kil the machine's power source.
+		 * but that might effectively kill the machine's power source.
 		 *
 		 * This slightly diverges from the specification and tries to
 		 * recover from this by explicitly asking for the capabilities
@@ -5066,7 +5094,8 @@ static void run_state_machine(struct tcpm_port *port)
 		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))
 			tcpm_set_state_cond(port, hard_reset_state(port), 0);
 		else
-			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
+			tcpm_set_state(port, hard_reset_state(port),
+				       pd_timers[PD_TIMER_SINK_WAIT_CAP]);
 		break;
 	case SNK_NEGOTIATE_CAPABILITIES:
 		port->pd_capable = true;
@@ -5203,7 +5232,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, ACC_UNATTACHED, 0);
 		break;
 	case AUDIO_ACC_DEBOUNCE:
-		tcpm_set_state(port, ACC_UNATTACHED, PD_T_CC_DEBOUNCE);
+		tcpm_set_state(port, ACC_UNATTACHED, pd_timers[PD_TIMER_CC_DEBOUNCE]);
 		break;
 
 	/* Hard_Reset states */
@@ -5420,7 +5449,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, ERROR_RECOVERY, 0);
 		break;
 	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
-		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_OFF);
+		tcpm_set_state(port, ERROR_RECOVERY, pd_timers[PD_TIMER_PS_SOURCE_OFF]);
 		break;
 	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
 		if (port->vbus_source)
@@ -5475,7 +5504,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_cc(port, TYPEC_CC_RD);
 		/* allow CC debounce */
 		tcpm_set_state(port, PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED,
-			       PD_T_CC_DEBOUNCE);
+			       pd_timers[PD_TIMER_CC_DEBOUNCE]);
 		break;
 	case PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED:
 		/*
@@ -5510,7 +5539,7 @@ static void run_state_machine(struct tcpm_port *port)
 						       port->pps_data.active, 0);
 		tcpm_set_charge(port, false);
 		tcpm_set_state(port, hard_reset_state(port),
-			       PD_T_PS_SOURCE_OFF);
+			       pd_timers[PD_TIMER_PS_SOURCE_OFF]);
 		break;
 	case PR_SWAP_SNK_SRC_SOURCE_ON:
 		tcpm_enable_auto_vbus_discharge(port, true);
@@ -5666,7 +5695,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case PORT_RESET_WAIT_OFF:
 		tcpm_set_state(port,
 			       tcpm_default_state(port),
-			       port->vbus_present ? PD_T_PS_SOURCE_OFF : 0);
+			       port->vbus_present ? pd_timers[PD_TIMER_PS_SOURCE_OFF] : 0);
 		break;
 
 	/* AMS intermediate state */
@@ -6157,7 +6186,7 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
 	case SRC_ATTACH_WAIT:
 		if (tcpm_port_is_source(port))
 			tcpm_set_state(port, tcpm_try_snk(port) ? SNK_TRY : SRC_ATTACHED,
-				       PD_T_CC_DEBOUNCE);
+				       pd_timers[PD_TIMER_CC_DEBOUNCE]);
 		break;
 	case SRC_STARTUP:
 	case SRC_SEND_CAPABILITIES:
@@ -7273,6 +7302,47 @@ static int tcpm_fw_get_snk_vdos(struct tcpm_port *port, struct fwnode_handle *fw
 	return 0;
 }
 
+static int tcpm_fw_get_pd_timers(struct tcpm_port *port, struct fwnode_handle *fwnode)
+{
+	int ret, i, len;
+	u32 *buf;
+
+	/* pd-timers is an optional property */
+	ret = fwnode_property_count_u32(fwnode, "pd-timers");
+	if (ret < 0) {
+		tcpm_log(port, "Unable to locate 'pd-timers' connector property (%d)", ret);
+		return 0;
+	}
+
+	if (ret % NUM_TIMER_TABLE_COLS || ret == 0) {
+		tcpm_log(port, "Incorrect 'pd-timers' value. Found %d u32 elements in array", ret);
+		return 0;
+	}
+
+	len = min(ret, PD_NUM_TIMERS * NUM_TIMER_TABLE_COLS);
+
+	buf = kcalloc(len, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = fwnode_property_read_u32_array(fwnode, "pd-timers", buf, len);
+	if (ret) {
+		dev_err(port->dev, "Unable to read pd-timers property (%d)", ret);
+		goto done;
+	}
+
+	for (i = 0; i < len - 1; i += NUM_TIMER_TABLE_COLS) {
+		if (buf[i] >= PD_NUM_TIMERS)
+			tcpm_log(port, "Unable to find timer index %d, skipping.", buf[i]);
+		else
+			pd_timers[buf[i]] = buf[i + 1];
+	}
+
+done:
+	kfree(buf);
+	return ret;
+}
+
 /* Power Supply access to expose source power information */
 enum tcpm_psy_online_states {
 	TCPM_PSY_OFFLINE = 0,
@@ -7608,6 +7678,10 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	init_completion(&port->pps_complete);
 	tcpm_debugfs_init(port);
 
+	err = tcpm_fw_get_pd_timers(port, tcpc->fwnode);
+	if (err)
+		goto out_destroy_wq;
+
 	err = tcpm_fw_get_caps(port, tcpc->fwnode);
 	if (err < 0)
 		goto out_destroy_wq;
-- 
2.46.0.598.g6f2099f65c-goog


