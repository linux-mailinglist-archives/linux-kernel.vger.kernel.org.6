Return-Path: <linux-kernel+bounces-173502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD38C0135
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AAF28902B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C94128378;
	Wed,  8 May 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="NRCdJVQs"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D47D3F5;
	Wed,  8 May 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183033; cv=none; b=mC1vQzkL4BrF4/1I1+b/L8NQhuGBqAjg3s2AbS8K9EbzVQUTycnZqlfaIApc9jIsl5Ev1iXrH3Mu/brOw5LDECiMy+B9DIDWNI7MJ0MGHnAUK188+OgEefXtZXWsMdrVGyQmamyY9p4G8BcH8MnfiSdLa1iTp7+0Yjx2EpULLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183033; c=relaxed/simple;
	bh=0j3aBfj9ZfpV1MH5nO9NGwaJrnnRhkiWZXMK8FGpErI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pytLkAcL1iRDqy2FOflh2Gtw2mJj341DeFjqo8RbSmUhjTmWBHs4oKVDlZ7nXWXMX1eLwhGMS9+ANOnGFxZX51Vdi8zzfVL+EbRvDVvjkNFNsgC4mxuuqgxJIC1q3ZFfrSSay3n77NGGFlHKW8N2C6v0uE5Tr6vFoTYImVX4wnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=NRCdJVQs; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 420666000852;
	Wed,  8 May 2024 16:43:48 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id Ra1H46aqlsMF; Wed,  8 May 2024 16:43:46 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id AAC0C6003C01;
	Wed,  8 May 2024 16:43:45 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1715183026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NQrIcFv9v2tmhATWNtUWwd3zf3STqTRGKWUwe6MA4gI=;
	b=NRCdJVQszJtyFHGVGnD5MzT6yNvhPwPdL6u/fZJ2iqnjkT/d9AQd+C5zGqkEItI3J6IWza
	xnPlieE3SGz8nEVPhO59cCHBWDvrwymYX83i7A1OBcLN7ZiQl2LJ8P3qe5Y864+p0VYHxC
	w43V5rknL0M16cJTiG8Qu3LFeFaESWI=
Received: from diogo-gram.home (unknown [IPv6:2a01:14:8070:dc60:4589:2164:1bc5:2670])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id E401F360092;
	Wed,  8 May 2024 16:43:44 +0100 (WEST)
Date: Wed, 8 May 2024 16:43:40 +0100
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	dmitry.baryshkov@linaro.org, bleung@chromium.org, pmalani@chromium.org, jthies@google.com, 
	abhishekpandit@chromium.org, lk@c--e.de, saranya.gopal@intel.com, dan.carpenter@linaro.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: diogo.ivo@tecnico.ulisboa.pt
Subject: [PATCH] usb: typec: ucsi: Add new notification bits
Message-ID: <3filrg6mbh6m3galir7ew5juakd25uvksimr7mqd7uc5td3xza@fdvxcewozqeh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Newer UCSI versions defined additional notification bits that can be
enabled by the PPM. Add their definitions and convert all definitions
to BIT_ULL() as we now cross the 32-bit boundary.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
 drivers/usb/typec/ucsi/ucsi.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index c4d103db9d0f..e70cf5b15562 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -124,18 +124,23 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 #define UCSI_ACK_COMMAND_COMPLETE		BIT(17)
 
 /* SET_NOTIFICATION_ENABLE command bits */
-#define UCSI_ENABLE_NTFY_CMD_COMPLETE		BIT(16)
-#define UCSI_ENABLE_NTFY_EXT_PWR_SRC_CHANGE	BIT(17)
-#define UCSI_ENABLE_NTFY_PWR_OPMODE_CHANGE	BIT(18)
-#define UCSI_ENABLE_NTFY_CAP_CHANGE		BIT(21)
-#define UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE	BIT(22)
-#define UCSI_ENABLE_NTFY_PD_RESET_COMPLETE	BIT(23)
-#define UCSI_ENABLE_NTFY_CAM_CHANGE		BIT(24)
-#define UCSI_ENABLE_NTFY_BAT_STATUS_CHANGE	BIT(25)
-#define UCSI_ENABLE_NTFY_PARTNER_CHANGE		BIT(27)
-#define UCSI_ENABLE_NTFY_PWR_DIR_CHANGE		BIT(28)
-#define UCSI_ENABLE_NTFY_CONNECTOR_CHANGE	BIT(30)
-#define UCSI_ENABLE_NTFY_ERROR			BIT(31)
+#define UCSI_ENABLE_NTFY_CMD_COMPLETE		BIT_ULL(16)
+#define UCSI_ENABLE_NTFY_EXT_PWR_SRC_CHANGE	BIT_ULL(17)
+#define UCSI_ENABLE_NTFY_PWR_OPMODE_CHANGE	BIT_ULL(18)
+#define UCSI_ENABLE_NTFY_ATTENTION		BIT_ULL(19)
+#define UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ	BIT_ULL(20)
+#define UCSI_ENABLE_NTFY_CAP_CHANGE		BIT_ULL(21)
+#define UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE	BIT_ULL(22)
+#define UCSI_ENABLE_NTFY_PD_RESET_COMPLETE	BIT_ULL(23)
+#define UCSI_ENABLE_NTFY_CAM_CHANGE		BIT_ULL(24)
+#define UCSI_ENABLE_NTFY_BAT_STATUS_CHANGE	BIT_ULL(25)
+#define UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER	BIT_ULL(26)
+#define UCSI_ENABLE_NTFY_PARTNER_CHANGE		BIT_ULL(27)
+#define UCSI_ENABLE_NTFY_PWR_DIR_CHANGE		BIT_ULL(28)
+#define UCSI_ENABLE_NTFY_SET_RETIMER_MODE	BIT_ULL(29)
+#define UCSI_ENABLE_NTFY_CONNECTOR_CHANGE	BIT_ULL(30)
+#define UCSI_ENABLE_NTFY_ERROR			BIT_ULL(31)
+#define UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE	BIT_ULL(32)
 #define UCSI_ENABLE_NTFY_ALL			0xdbe70000
 
 /* SET_UOR command bits */
-- 
2.45.0


