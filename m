Return-Path: <linux-kernel+bounces-187826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDF8CD90E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069A52835ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9021364;
	Thu, 23 May 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nNhLrNpy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE5AD27;
	Thu, 23 May 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484648; cv=none; b=AY4FZ3PDiOLq84nlMWfnKJhmj5+kAyMbcwP389ILGiK3LJLC66SkS8w2jHdfM3jixTLTz0eW6yeiS5lqc1H/QAGyFTmbOPGCUeq5aRZ1cU8MNVTOdQJVhoyNnM0NX2wlj70LoOvrO8ZjkPb8N4ze8fHbDIm79LcVDVwStqRSctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484648; c=relaxed/simple;
	bh=O7RWrEm6Vj69Eur57L0pSmBb5qrZIwen6LArd8lQTA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcGqXkKjJOLm885ohq1HfgbX3bRyOa3ZiYzfxip2QSKOlciUoHJ3XxHg4LgWaNNpARHyptoGcFJ/hPh6F99LosXb7WYKHx0C/q+1XN1Ib+am+sZVzucZFXTD7+mSCioCTgHu3OtRDp0VB2vzdJO6FVJ0vf6eyXAeCEZSRwW6yfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nNhLrNpy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716484639;
	bh=O7RWrEm6Vj69Eur57L0pSmBb5qrZIwen6LArd8lQTA0=;
	h=From:To:Cc:Subject:Date:From;
	b=nNhLrNpy8zCYj7/QLT6c5DxITQM1hjumEGo6OLzDCD92w+CY9rcx4gReh900ES7oL
	 C1/UtlVfxPL8yg18JDt/lzYN2HTlM230GmPhG3Y4yCFulzdvXfC3+5Wdgx0+6K0SR0
	 i07hJ1HCiOxAEgE13JEeG3uqrZbR+WjRKvnp1pGu32aINyDr/Bv54a2sThQu49fJxK
	 a/b55eNclzEL/DyFUwY/c3dpA1E0hQ6oOI9Vr7EI249GS37jhL4WZiRx2xaaAY4oAJ
	 kUOzxzt1aJTbJcC2HMikKYH3PTCUkfjdL+KI0zZua+EojWgVqC6VKFrmcty7P5yXLo
	 WdDuKbANR5gJQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 122B837821B3;
	Thu, 23 May 2024 17:17:19 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A550D4800C9; Thu, 23 May 2024 19:17:18 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 1/1] usb: typec: tcpm: print error on hard reset
Date: Thu, 23 May 2024 19:12:29 +0200
Message-ID: <20240523171645.223225-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A USB-C hard reset involves removing the voltage from VBUS for some
time. So basically it has the same effect as removing the USB-C plug
for a short moment. If the machine is powered from the USB-C port and
does not have a fallback supply (e.g. a battery), this will result in
a full machine reset due to power loss.

Ideally we want to avoid triggering a hard reset on these boards. A
non-working USB-C port is probably better than unplanned reboots. But
boards with a backup supply should do the hard reset to get everything
working again.

In theory it would be enough to check the self_powered property, but
it seems the property might not be configured consistently enough in
system firmwares.

So let's start with just printing an error message when a hard reset is
triggered on systems we expect to be affected. This at least makes
debugging issues on affected systems easier without impacting unaffected
systems too much.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8a1af08f71b6..375bc84d14a2 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5185,6 +5185,8 @@ static void run_state_machine(struct tcpm_port *port)
 	case HARD_RESET_SEND:
 		if (port->ams != NONE_AMS)
 			tcpm_ams_finish(port);
+		if (!port->self_powered && port->port_type == TYPEC_PORT_SNK)
+			dev_err(port->dev, "Initiating hard-reset, which might result in machine power-loss.\n");
 		/*
 		 * State machine will be directed to HARD_RESET_START,
 		 * thus set upcoming_state to INVALID_STATE.
-- 
2.43.0


