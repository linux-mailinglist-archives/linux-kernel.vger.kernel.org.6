Return-Path: <linux-kernel+bounces-188635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163AD8CE4B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473491C21494
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A120486277;
	Fri, 24 May 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="gOI3nfEu"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC842078;
	Fri, 24 May 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548890; cv=none; b=SEmJMzYEPXiRnli6BLCjZ+7/Azj2TPfXfL500fMG9raA2KBnNyVXh7WRnsOpCleZsvdZXa/vIuLoSJ9ZAiNhNN3ma5W9cJrxKoS8e4wNmP2MtV7oTnTjC6qvjkASXq5WHX1nkmcfPMxOn18WKlhbCjJX3U4KKYo7uf22HZeV5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548890; c=relaxed/simple;
	bh=F+uCQdV0aunttbQzzXVZNYHFs0YrsoqwUqhoLVcnC9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTpTdoA+yZsg2Qxcfy4xMRHnN9j4igjZ8wcdvEOwP3bfOrySPNufESlzmuvJER8xf1Zvg98NFtLarLv4cIKFiwEpgbN9QhlYdn4zACQhvkMrjxOpCximTmtdil0un6iq3oKvCFDacim8faLTty51lvCQjpI8YmnYdqxW25QKKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=gOI3nfEu; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 23BC1601A40F;
	Fri, 24 May 2024 11:59:59 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id 4SPOHJ6UAWWl; Fri, 24 May 2024 11:59:56 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id D65FE600087F;
	Fri, 24 May 2024 11:59:56 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1716548396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7o+fFn7gbAlvwKqYJrJ0dZxZZJ/KAuKR0bymU0MdKuQ=;
	b=gOI3nfEuvAJruhD/F3G0dI4EpjmmZNiJs2ecWhlKUmNsTIRJGfk0zAb4XkLHyIJjIhcZJg
	9N1U42wbTgnS3jwR40mKqf9PGRCjsxoUmamDymK/SAhfRxvAYbfW7w4nlk4t3jih1i6/8y
	DLNPvPEbGAXWe+LEqX90jwutZ+QZo3o=
Received: from diogo-gram.. (unknown [136.226.215.14])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 75E963600C8;
	Fri, 24 May 2024 11:59:55 +0100 (WEST)
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	dmitry.baryshkov@linaro.org,
	jthies@google.com,
	bleung@chromium.org,
	abhishekpandit@chromium.org,
	saranya.gopal@intel.com,
	lk@c--e.de,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmalani@chromium.org
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Subject: [PATCH 2/2] usb: typec: ucsi: Enable UCSI v2.0 notifications
Date: Fri, 24 May 2024 11:58:21 +0100
Message-ID: <20240524105837.15342-3-diogo.ivo@tecnico.ulisboa.pt>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524105837.15342-1-diogo.ivo@tecnico.ulisboa.pt>
References: <20240524105837.15342-1-diogo.ivo@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UCSI version 2.0 and above define new PPM notifications. Update the
logic to determine which notifications to enable taking into account
these changes.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
 drivers/usb/typec/ucsi/ucsi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cb52e7b0a2c5..0cc1c49da4a0 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1664,7 +1664,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 
 static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
 {
-	u8 features = ucsi->cap.features;
+	u16 features = ucsi->cap.features;
 	u64 ntfy = UCSI_ENABLE_NTFY_ALL;
 
 	if (!(features & UCSI_CAP_ALT_MODE_DETAILS))
@@ -1680,6 +1680,23 @@ static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
 	if (!(features & UCSI_CAP_PD_RESET))
 		ntfy &= ~UCSI_ENABLE_NTFY_PD_RESET_COMPLETE;
 
+	if (ucsi->version <= UCSI_VERSION_1_2)
+		return ntfy;
+
+	ntfy |= UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE;
+
+	if (features & UCSI_CAP_GET_ATTENTION_VDO)
+		ntfy |= UCSI_ENABLE_NTFY_ATTENTION;
+
+	if (features & UCSI_CAP_FW_UPDATE_REQUEST)
+		ntfy |= UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ;
+
+	if (features & UCSI_CAP_SECURITY_REQUEST)
+		ntfy |= UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER;
+
+	if (features & UCSI_CAP_SET_RETIMER_MODE)
+		ntfy |= UCSI_ENABLE_NTFY_SET_RETIMER_MODE;
+
 	return ntfy;
 }
 
-- 
2.45.1


