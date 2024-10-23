Return-Path: <linux-kernel+bounces-377285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B1F9ABC85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866751C216DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C9140E2E;
	Wed, 23 Oct 2024 03:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4imKsYKf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF6D13B5B3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655756; cv=none; b=TRYpicYl88X3TV/euDd6kIJUbhncz9lTSxz4WEfKh8ntsfPljF+XEgx8sDr3hnk/E68nOFe/9yiuSCBNpR9HOozGTiH0gjXiAGYgwxH6ZAtddkZyXYPERhcziED+8p43yXcad0XT0q6oj8IBtH+++kgJIX5Bjun5PLT0CHQ7bTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655756; c=relaxed/simple;
	bh=FH6U7KnXlg0DlsMxo9+D3f1OK3GjUce6b7dLB/Q3Kf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mt5W7hAFAzB3dzt7sWwuEyMPOm3nGEdUzIwnC3tqWmaCrN3ui9YA9W66dyWCqCtd2VTcEgECvCk7yQBZk1uDCdZmeALUlT3G5iD1OQGQHtetVLiBPXzH7vkQwlSqIHEJ1dGZAN1+WNY+xGWQ83BqSN7b25v8cH+0fIY4H/jSzlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4imKsYKf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e291ac8dcf3so10663665276.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729655754; x=1730260554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOsBZgZOATojNbhZl/5sR+Os5FryhOZouU4YxFGVGZA=;
        b=4imKsYKfMGQ8AKuQL4YWAMFnCKMuFXVoj6/qJ77fR8grR5xi9BxptfSXpnsTSIy0CJ
         ZKtJ3CQEFiPrU9ZX/iY2uTMSUfC0DvN7FJeWq38VHdrGk6cCxuUGXlvJUH8ibmFoGnNL
         8y5Na1EsLHLsb/0Jc74RRBADe943ZEsYppTp6YSXgpBDj+5KKK7qVofp9NLosV5fa1vL
         py9ecu5HyEygliBTAjPwXwaKBEeiCdg54SHqen9ICdnyyTIdKoqDruPW4yUp48OKSRR6
         Gv+V55/TBkKUrWq+/BDxYsMU0+5OL/ltmQLuGs+0h6q7uDMF8mMvfvK3F/PCwScQthAq
         mltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729655754; x=1730260554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOsBZgZOATojNbhZl/5sR+Os5FryhOZouU4YxFGVGZA=;
        b=jknjA8rYOYaWqu53quZClNGCBL6hahL54IDAc+5qWUD8B/4lZvSXs2PiGCfi9LE6VJ
         AunlhaXk44lSbSrzsfZWWYnIz1F8l6NpKDigjaozPIbIxRcvZWYqLmjKdYMntksJUOcF
         QfHGGDChW9n80EfEnVktegDZFxD8ZV8a1E5iFgcyrumbSiaFFCPXUTo0qjOjWH85k0B5
         j6LOQX3UeCeodYkTCc1FfrGQsK/3C9pGgcJCe4fZx7Owuo07E0akggheXvO6RKPvAGCi
         jFVBouohw8LYN1JF4VjpLHDsLr/OOIRjvpVaNJgxxA9o9aNP83kGl+P62gRB7pM7tErw
         Mt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2lTqEXW7bkKwTjqxsJPODOrKsKCbbXCqKFtunlzhqerb5Z/VWbvvlbTxTEVOIeZjjx3n1ecuMLeZMMeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7zHCYJw/0GJ8Xl4NyXtAgAMnVvBKCK0wE7OJ6OpjFdC/ADMob
	AOIb54kjt02PUq0MInF8lxXDjOompZnBCOTnWj+FC3CX57uXI3+6b0bXxpRGYBx770LW4FvqbAo
	nrQ==
X-Google-Smtp-Source: AGHT+IEPAncleUxLaPGBvDbqXaopuR/zIMh3negnEP7jgItbB+b/QOlStSXnodJeBdj0I3b32obPQJz65QU=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a5b:bc3:0:b0:e24:a00a:518e with SMTP id
 3f1490d57ef6-e2e3a6b42fcmr1188276.7.1729655753833; Tue, 22 Oct 2024 20:55:53
 -0700 (PDT)
Date: Tue, 22 Oct 2024 20:55:49 -0700
In-Reply-To: <20241022-pd-dt-time-props-v1-0-fea96f51b302@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022-pd-dt-time-props-v1-0-fea96f51b302@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20241022-pd-dt-time-props-v1-2-fea96f51b302@google.com>
Subject: [PATCH 2/2] usb: typec: tcpm: Add support for parsing time dt properties
From: Amit Sunil Dhamne <amitsd@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>, 
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
	Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="utf-8"

Add support for DT time properties to allow users to define platform
specific timing deadlines of certain timers rather than using hardcoded
ones. For values that have not been explicitly defined in DT using this
property, default values will be set therefore, making this change
backward compatible.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 73 +++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index fc619478200f..b3d5d1d48937 100644
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
@@ -7610,6 +7649,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	if (err < 0)
 		goto out_destroy_wq;
 
+	tcpm_fw_get_timings(port, tcpc->fwnode);
+
 	port->try_role = port->typec_caps.prefer_role;
 
 	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */

-- 
2.47.0.105.g07ac214952-goog


