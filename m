Return-Path: <linux-kernel+bounces-336370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD64983A67
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C17F1C2192D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6085931;
	Mon, 23 Sep 2024 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQHKrq47"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199012CDA5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131272; cv=none; b=K+EBX+wgB5EvTO/wMATEJoSuhFmkPXjREbITte1SJ/zWFkEw/WJNnAOmAlL57kbC2njgAM7RWcOPvDcjOmXbkDHlKuPGuTWwtVD4Af79PChv4OZgXjQQRtOlcJmsejfqAg/7MsPD7is6/U86sAikS2r3LZkUTspXOX3m7useU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131272; c=relaxed/simple;
	bh=Hodq5RHSLNvDU0kWQYUS5MtS4N/sAOd18eJkJzQy2yQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pyNgk+rKgVZt/jlXHv7IUsT2oNhMWXHYKIJLz3i5UzD68Jj6H0e59eA/dwpUb1cCnaQo+WQf1d9jXMhdJhMTS+8hTipDvAUQhdrFR02vGSDlbDsBmioMSmuB158C5yuBkYQmKwqZp58SoCUr7v2WVCg6tSBZ4h3ZeHThHcM20s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQHKrq47; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1cefe6afc4so7667805276.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727131270; x=1727736070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2/5FoFqMYLDskw0LGckVxOOGoqnljVK4brc1RjW8hA=;
        b=EQHKrq47RxwZzq5fM8Dd5oH5b138vWPWZSFiHbliC3M0z5BHO1BbL7VWo/sTd6ubzo
         UZ6rFvkJ7Ja9HpCkytRW4m+R0H0JCvvVRSLsJWy9+SjLlDgsyFnO73QkbZPScGXo5eHy
         yv6ryfdf2wjGB+StlaPGZrNfS6XRwsp0Zc9PnzEtMhvNvCa5qIjglk5OzQYTGmKSrbda
         i/LZy+I1r/kHj68WYkIxYUxHxlIUg3B5En1s9+pApt19viD/fFUMaEEPYbEFvsN/KBtq
         0iAPN1aJRjeJsjyp42JV3rbETKtJX6+ucL+S+gstu8pUdPghfTsr8SNxUPwIUZs8ZYoI
         YD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727131270; x=1727736070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2/5FoFqMYLDskw0LGckVxOOGoqnljVK4brc1RjW8hA=;
        b=bNFV6guKNminUpRIx7Z7KbU3UXx7ZNdaWRHuwPaLCOXr589sDHCeWsDf4AURMK+Dxl
         itsbQU0+rgPGYdYE8h/8cmA47wxqFjLBUJ7mn3qzGuhktOKzM1imeOTOF/WMCYHaS3J5
         FtI21wpSOMHuFh0eyYsT6f11q1ziUFw/ryPJdMLmKJrm3XGzLKhvYM+88SN+9N254txj
         sj+tOLn1H7D6Ws/sZYsJfv80tDnOX7BF2ajwyehTkyDY0/XvC9FBlfpsr97yvaG3mSJF
         r85eV9KGHWIjmPuUwIcIunAadtu0RLm+7eQnii1JBtBkCjlr5LskT//NbEonKcZQtkuF
         B2uA==
X-Forwarded-Encrypted: i=1; AJvYcCWCAEahLFXRoCE62TtBSWAS50sEDpFWAxE8VPOb/bG+2wdiFw8aNnxl3YFoKdIEQoHTIymZ9SPuEVTHibs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDmjkhoXHiqBjGKTh7IO+BpXnNQZTHHrb5X3arncw6JSIiCzR3
	17usqwAyJYlhiVq/qonj+xt0YIJQQla+vueumgKoaFFfv7OdslaCVEzpvayyF6u2VWjB1Tzhx0h
	EDw==
X-Google-Smtp-Source: AGHT+IGwYdnk1TnkY48JqaPbWqa6BChs4EteYkdBZdEzxBAseTgJg9m141jE0iPjCxLnEZs9cqm88HIfO0s=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a25:6947:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e2250c24e0dmr11268276.1.1727131270248; Mon, 23 Sep 2024 15:41:10
 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:40:51 -0700
In-Reply-To: <20240923224059.3674414-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923224059.3674414-1-amitsd@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923224059.3674414-3-amitsd@google.com>
Subject: [RFC v3 2/2] usb: typec: tcpm: Add support for parsing time dt properties
From: Amit Sunil Dhamne <amitsd@google.com>
To: gregkh@linuxfoundation.org, robh@kernel.org, dmitry.baryshkov@linaro.org, 
	heikki.krogerus@linux.intel.com
Cc: badhri@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for DT time properties to allow users to define platform
specific timing deadlines of certain timers rather than using hardcoded
ones. For values that have not been explicitly defined in DT using this
property, default values will be set therefore, making this change
backward compatible.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 74 +++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4b02d6474259..b06a4ff733bd 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -310,6 +310,17 @@ struct pd_data {
 	unsigned int operating_snk_mw;
 };
 
+/*
+ * @sink_wait_cap_time: Deadline (in ms) for tTypeCSinkWaitCap timer
+ * @ps_src_wait_off_time: Deadline (in ms) for tPSSourceOff timer
+ * @cc_debounce_time: Deadline (in ms) for tCCDebounce timer
+ */
+struct pd_timings {
+	u32 sink_wait_cap_time;
+	u32 ps_src_off_time;
+	u32 cc_debounce_time;
+};
+
 struct tcpm_port {
 	struct device *dev;
 
@@ -552,6 +563,9 @@ struct tcpm_port {
 	 */
 	unsigned int message_id_prime;
 	unsigned int rx_msgid_prime;
+
+	/* Timer deadline values configured at runtime */
+	struct pd_timings timings;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -4639,15 +4653,15 @@ static void run_state_machine(struct tcpm_port *port)
 	case SRC_ATTACH_WAIT:
 		if (tcpm_port_is_debug(port))
 			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
-				       PD_T_CC_DEBOUNCE);
+				       port->timings.cc_debounce_time);
 		else if (tcpm_port_is_audio(port))
 			tcpm_set_state(port, AUDIO_ACC_ATTACHED,
-				       PD_T_CC_DEBOUNCE);
+				       port->timings.cc_debounce_time);
 		else if (tcpm_port_is_source(port) && port->vbus_vsafe0v)
 			tcpm_set_state(port,
 				       tcpm_try_snk(port) ? SNK_TRY
 							  : SRC_ATTACHED,
-				       PD_T_CC_DEBOUNCE);
+				       port->timings.cc_debounce_time);
 		break;
 
 	case SNK_TRY:
@@ -4698,7 +4712,7 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		break;
 	case SRC_TRYWAIT_DEBOUNCE:
-		tcpm_set_state(port, SRC_ATTACHED, PD_T_CC_DEBOUNCE);
+		tcpm_set_state(port, SRC_ATTACHED, port->timings.cc_debounce_time);
 		break;
 	case SRC_TRYWAIT_UNATTACHED:
 		tcpm_set_state(port, SNK_UNATTACHED, 0);
@@ -4901,7 +4915,7 @@ static void run_state_machine(struct tcpm_port *port)
 		    (port->cc1 != TYPEC_CC_OPEN &&
 		     port->cc2 == TYPEC_CC_OPEN))
 			tcpm_set_state(port, SNK_DEBOUNCED,
-				       PD_T_CC_DEBOUNCE);
+				       port->timings.cc_debounce_time);
 		else if (tcpm_port_is_disconnected(port))
 			tcpm_set_state(port, SNK_UNATTACHED,
 				       PD_T_PD_DEBOUNCE);
@@ -4941,7 +4955,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_TRYWAIT:
 		tcpm_set_cc(port, TYPEC_CC_RD);
-		tcpm_set_state(port, SNK_TRYWAIT_VBUS, PD_T_CC_DEBOUNCE);
+		tcpm_set_state(port, SNK_TRYWAIT_VBUS, port->timings.cc_debounce_time);
 		break;
 	case SNK_TRYWAIT_VBUS:
 		/*
@@ -5014,7 +5028,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_DISCOVERY_DEBOUNCE:
 		tcpm_set_state(port, SNK_DISCOVERY_DEBOUNCE_DONE,
-			       PD_T_CC_DEBOUNCE);
+			       port->timings.cc_debounce_time);
 		break;
 	case SNK_DISCOVERY_DEBOUNCE_DONE:
 		if (!tcpm_port_is_disconnected(port) &&
@@ -5041,10 +5055,10 @@ static void run_state_machine(struct tcpm_port *port)
 		if (port->vbus_never_low) {
 			port->vbus_never_low = false;
 			tcpm_set_state(port, SNK_SOFT_RESET,
-				       PD_T_SINK_WAIT_CAP);
+				       port->timings.sink_wait_cap_time);
 		} else {
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
-				       PD_T_SINK_WAIT_CAP);
+				       port->timings.sink_wait_cap_time);
 		}
 		break;
 	case SNK_WAIT_CAPABILITIES_TIMEOUT:
@@ -5066,7 +5080,8 @@ static void run_state_machine(struct tcpm_port *port)
 		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))
 			tcpm_set_state_cond(port, hard_reset_state(port), 0);
 		else
-			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
+			tcpm_set_state(port, hard_reset_state(port),
+				       port->timings.sink_wait_cap_time);
 		break;
 	case SNK_NEGOTIATE_CAPABILITIES:
 		port->pd_capable = true;
@@ -5203,7 +5218,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, ACC_UNATTACHED, 0);
 		break;
 	case AUDIO_ACC_DEBOUNCE:
-		tcpm_set_state(port, ACC_UNATTACHED, PD_T_CC_DEBOUNCE);
+		tcpm_set_state(port, ACC_UNATTACHED, port->timings.cc_debounce_time);
 		break;
 
 	/* Hard_Reset states */
@@ -5420,7 +5435,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, ERROR_RECOVERY, 0);
 		break;
 	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
-		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_OFF);
+		tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps_src_off_time);
 		break;
 	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
 		if (port->vbus_source)
@@ -5475,7 +5490,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_cc(port, TYPEC_CC_RD);
 		/* allow CC debounce */
 		tcpm_set_state(port, PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED,
-			       PD_T_CC_DEBOUNCE);
+			       port->timings.cc_debounce_time);
 		break;
 	case PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED:
 		/*
@@ -5510,7 +5525,7 @@ static void run_state_machine(struct tcpm_port *port)
 						       port->pps_data.active, 0);
 		tcpm_set_charge(port, false);
 		tcpm_set_state(port, hard_reset_state(port),
-			       PD_T_PS_SOURCE_OFF);
+			       port->timings.ps_src_off_time);
 		break;
 	case PR_SWAP_SNK_SRC_SOURCE_ON:
 		tcpm_enable_auto_vbus_discharge(port, true);
@@ -5666,7 +5681,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case PORT_RESET_WAIT_OFF:
 		tcpm_set_state(port,
 			       tcpm_default_state(port),
-			       port->vbus_present ? PD_T_PS_SOURCE_OFF : 0);
+			       port->vbus_present ? port->timings.ps_src_off_time : 0);
 		break;
 
 	/* AMS intermediate state */
@@ -6157,7 +6172,7 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
 	case SRC_ATTACH_WAIT:
 		if (tcpm_port_is_source(port))
 			tcpm_set_state(port, tcpm_try_snk(port) ? SNK_TRY : SRC_ATTACHED,
-				       PD_T_CC_DEBOUNCE);
+				       port->timings.cc_debounce_time);
 		break;
 	case SRC_STARTUP:
 	case SRC_SEND_CAPABILITIES:
@@ -7053,6 +7068,30 @@ static int tcpm_port_register_pd(struct tcpm_port *port)
 	return ret;
 }
 
+static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fwnode)
+{
+	int ret;
+	u32 val;
+
+	ret = fwnode_property_read_u32(fwnode, "sink-wait-cap-time-ms", &val);
+	if (!ret)
+		port->timings.sink_wait_cap_time = val;
+	else
+		port->timings.sink_wait_cap_time = PD_T_SINK_WAIT_CAP;
+
+	ret = fwnode_property_read_u32(fwnode, "ps-source-off-time-ms", &val);
+	if (!ret)
+		port->timings.ps_src_off_time = val;
+	else
+		port->timings.ps_src_off_time = PD_T_PS_SOURCE_OFF;
+
+	ret = fwnode_property_read_u32(fwnode, "cc-debounce-time-ms", &val);
+	if (!ret)
+		port->timings.cc_debounce_time = val;
+	else
+		port->timings.cc_debounce_time = PD_T_CC_DEBOUNCE;
+}
+
 static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *capabilities, *child, *caps = NULL;
@@ -7611,10 +7650,13 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	err = tcpm_fw_get_caps(port, tcpc->fwnode);
 	if (err < 0)
 		goto out_destroy_wq;
+
 	err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
 	if (err < 0)
 		goto out_destroy_wq;
 
+	tcpm_fw_get_timings(port, tcpc->fwnode);
+
 	port->try_role = port->typec_caps.prefer_role;
 
 	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
-- 
2.46.0.792.g87dc391469-goog


