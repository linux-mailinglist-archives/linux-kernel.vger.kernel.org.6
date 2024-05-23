Return-Path: <linux-kernel+bounces-187829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E88CD917
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284EE1F2196B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9368763F2;
	Thu, 23 May 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="t4BEUZKJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04F1CFBE;
	Thu, 23 May 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484693; cv=none; b=Ve8RVt7uCO3GCakpFY1Sf2Z2bba94Mn0UTVDInNyKsY47rUg9a97Sopa+yuUc4OmJIama5FoLQfMITeT/B+ta0OHN8aOl/1DEldjUETVTpStErmnvzyK4TQ8lDCBxn1ZAYLJQe9uY+Mil4qs4J7ey5CyJ5021Yr416Q0AJZbQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484693; c=relaxed/simple;
	bh=KTKxHsL5GgQd/RymDOm5ZQw9KJwWaBDPIsYCic3kzu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJzjZc7C55xEJKCA11AoTguOzYmZr2eHC/2riWOt6GU7+WDkcuzfKJGfDHDnonoI1yOkqh4KNCPP4BVLxosNYF/vg8DZYS6p2IOsWW2MAMZYpKj1haICWox2Y7OyQ98z+Uyopr7LGJ0WTYT2z8KtfAbKQ75NUYION4WkQVlCKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=t4BEUZKJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716484689;
	bh=KTKxHsL5GgQd/RymDOm5ZQw9KJwWaBDPIsYCic3kzu0=;
	h=From:To:Cc:Subject:Date:From;
	b=t4BEUZKJ/6ZaH+Y3XfIz0pektCrP7Cg1f9dQdvNRzc+Bxoz3ui7P6ARxJA+NTnrKl
	 C57W2HeLT1OhbIEU3TMMvmWzA3UH0E2OR48qrmYoTRGUyzPt0NiAnnGHljPsMldnWK
	 ya7H/LUM/YRlMJMwRlFZGIVPRguAKCceQZdh7cqCy3ErJFhs8OmSc+pZNkhfD0rUtV
	 gB5yXVOPFHy8UC417vfUZ+q3lKd75uqhl13maaQgUiwMjERGQpNExAJ/UYa/stzRX+
	 Ni7sxDWmSH1hxjl7z3dkmc5v3ytJpa26mPq/Ngssi+3UCUTiVz2rO6dx5H3+TTlG5A
	 8N5FxyqbGEGFw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB10437821B3;
	Thu, 23 May 2024 17:18:09 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 71FB34800C9; Thu, 23 May 2024 19:18:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 1/1] usb: typec: tcpm: avoid resets for missing source capability messages
Date: Thu, 23 May 2024 19:17:52 +0200
Message-ID: <20240523171806.223727-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the Linux Type-C controller drivers probe, they requests a soft
reset, which should result in the source restarting to send Source
Capability messages again independently of the previous state.
Unfortunately some USB PD sources do not follow the specification and
do not send them after a soft reset when they already negotiated a
specific contract before. The current way (and what is described in the
specificiation) to resolve this problem is triggering a hard reset.

But a hard reset is fatal on batteryless platforms powered via USB-C PD,
since that removes VBUS for some time. Since this is triggered at boot
time, the system will be stuck in a boot loop. Examples for platforms
affected by this are the Radxa Rock 5B or the Libre Computer Renegade
Elite ROC-RK3399-PC.

Instead of directly trying a hard reset when no Source Capability
message is send by the USB-PD source automatically, this changes the
state machine to try explicitly asking for the capabilities by sending
a Get Source Capability control message.

For me this solves issues with 2 different USB-PD sources - a RAVPower
powerbank and a Lemorele USB-C dock. Every other PD source I own
follows the specification and automatically sends the Source Capability
message after a soft reset, which works with or without this change.

I decided against making this extra step limited to devices not having
the self_powered flag set, since I don't see any huge drawbacks in this
approach and it keeps the logic simpler. The worst case scenario would
be a power source, which is really stuck. In that case the hard reset
is delayed by another 310ms.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 375bc84d14a2..bac6866617c8 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -57,6 +57,7 @@
 	S(SNK_DISCOVERY_DEBOUNCE),		\
 	S(SNK_DISCOVERY_DEBOUNCE_DONE),		\
 	S(SNK_WAIT_CAPABILITIES),		\
+	S(SNK_WAIT_CAPABILITIES_TIMEOUT),	\
 	S(SNK_NEGOTIATE_CAPABILITIES),		\
 	S(SNK_NEGOTIATE_PPS_CAPABILITIES),	\
 	S(SNK_TRANSITION_SINK),			\
@@ -3108,7 +3109,8 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 						   PD_MSG_CTRL_REJECT :
 						   PD_MSG_CTRL_NOT_SUPP,
 						   NONE_AMS);
-		} else if (port->state == SNK_WAIT_CAPABILITIES) {
+		} else if (port->state == SNK_WAIT_CAPABILITIES ||
+			   port->state == SNK_WAIT_CAPABILITIES_TIMEOUT) {
 		/*
 		 * This message may be received even if VBUS is not
 		 * present. This is quite unexpected; see USB PD
@@ -5039,10 +5041,31 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_SOFT_RESET,
 				       PD_T_SINK_WAIT_CAP);
 		} else {
-			tcpm_set_state(port, hard_reset_state(port),
+			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
 				       PD_T_SINK_WAIT_CAP);
 		}
 		break;
+	case SNK_WAIT_CAPABILITIES_TIMEOUT:
+		/*
+		 * There are some USB PD sources in the field, which do not
+		 * properly implement the specification and fail to start
+		 * sending Source Capability messages after a soft reset. The
+		 * specification suggests to do a hard reset when no Source
+		 * capability message is received within PD_T_SINK_WAIT_CAP,
+		 * but that might effectively kil the machine's power source.
+		 *
+		 * This slightly diverges from the specification and tries to
+		 * recover from this by explicitly asking for the capabilities
+		 * using the Get_Source_Cap control message before falling back
+		 * to a hard reset. The control message should also be supported
+		 * and handled by all USB PD source and dual role devices
+		 * according to the specification.
+		 */
+		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))
+			tcpm_set_state_cond(port, hard_reset_state(port), 0);
+		else
+			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
+		break;
 	case SNK_NEGOTIATE_CAPABILITIES:
 		port->pd_capable = true;
 		tcpm_set_partner_usb_comm_capable(port,
-- 
2.43.0


