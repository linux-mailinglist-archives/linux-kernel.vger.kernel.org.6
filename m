Return-Path: <linux-kernel+bounces-289112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54131954226
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E66B26E06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74EA13C673;
	Fri, 16 Aug 2024 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZyZFrRYe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oHHdvgze";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZyZFrRYe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oHHdvgze"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18A84A32
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791189; cv=none; b=T1zQslj0PjOHGIRD3CBgjHlC80BlswsKqpZVRtYa01YyXZ9KPdEgSSD005kVQVv0FGK6B8cO2/P41flw8NVzR0jpTsaU9Z+xW/vsgXAnX9MKJA41Q+Olu6/7uv1ezveoW6gb5KUuVscNex/I8LwrguTyt74PLDHESNyf6a+BXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791189; c=relaxed/simple;
	bh=oakOgnKKvuvCz18fve+8nqa5O90sCOaifg/eznGiGS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laAUR6wqK+MZ42WUQ2RGbbqMMIcjUEoZJw5q+lZeSFAvbeHtio7sH4TJlNLA416SmsS2Yoh+HLDAfxaPJkD76sYQsBxoGc67gi4VeM4RjP0GzBNfVisyuGuOXwUKxO44QRFl/ckVas5uYrfYDwcYDL4HsLHw+7KJYCAErDTQmlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZyZFrRYe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oHHdvgze; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZyZFrRYe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oHHdvgze; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85C4F1FDC9;
	Fri, 16 Aug 2024 06:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723791185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oX3/jIN/2itdKhrK17EryBHW5e7SEAyJKPs7KRVgPkE=;
	b=ZyZFrRYea79HpBJG6P1GzcF64cs3DnHs/LfuYt1flHjr22jgHmHYBstif1X/a6AqyDF+cm
	H27eqp+wzUumQnR+BqU27ObY+Qg3qfgr6SLRCpMbysUvvtSJodiMhGHgrthHrs8jXDJBY5
	5P2k97kUYI3w8SH9txMjH6m04UwTYkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723791185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oX3/jIN/2itdKhrK17EryBHW5e7SEAyJKPs7KRVgPkE=;
	b=oHHdvgze/8+LrUNTkY2WLyxW2h1dnjU34GiwW1dY3AfEjIhFTYQmLfoO6Xw/jbDZzdx5QO
	+8AMyhIbrjVXerCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723791185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oX3/jIN/2itdKhrK17EryBHW5e7SEAyJKPs7KRVgPkE=;
	b=ZyZFrRYea79HpBJG6P1GzcF64cs3DnHs/LfuYt1flHjr22jgHmHYBstif1X/a6AqyDF+cm
	H27eqp+wzUumQnR+BqU27ObY+Qg3qfgr6SLRCpMbysUvvtSJodiMhGHgrthHrs8jXDJBY5
	5P2k97kUYI3w8SH9txMjH6m04UwTYkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723791185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oX3/jIN/2itdKhrK17EryBHW5e7SEAyJKPs7KRVgPkE=;
	b=oHHdvgze/8+LrUNTkY2WLyxW2h1dnjU34GiwW1dY3AfEjIhFTYQmLfoO6Xw/jbDZzdx5QO
	+8AMyhIbrjVXerCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7588513A2F;
	Fri, 16 Aug 2024 06:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qBIzHFH3vmbDfgAAD6G6ig
	(envelope-from <iivanov@suse.de>); Fri, 16 Aug 2024 06:53:05 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	"Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH] ipmi:ssif: Exit early when there is a SMBus error
Date: Fri, 16 Aug 2024 09:54:58 +0300
Message-ID: <20240816065458.117986-1-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

It is pointless to continue module probing when communication
with device is failing. This just fill logs with misleading
messages like this:

[Fri Jul 26 18:32:34 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Error fetching SSIF: -121 180453376 62, your system probably doesn't support this command so using defaults
[Fri Jul 26 18:32:54 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Unable to clear message flags: -121 180453376 62
[Fri Jul 26 18:33:14 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Error getting global enables: -121 180453376 62
[Fri Jul 26 18:33:49 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
[Fri Jul 26 18:33:50 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
[Fri Jul 26 18:34:07 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
[Fri Jul 26 18:34:07 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
[Fri Jul 26 18:34:25 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
[Fri Jul 26 18:34:25 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
[Fri Jul 26 18:34:43 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
[Fri Jul 26 18:34:43 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
[Fri Jul 26 18:35:01 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
[Fri Jul 26 18:35:01 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
[Fri Jul 26 18:35:19 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
[Fri Jul 26 18:35:19 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: Unable to get the device id: -5
[Fri Jul 26 18:35:19 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Unable to register device: error -5
[Fri Jul 26 18:35:19 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Unable to start IPMI SSIF: -5
[Fri Jul 26 18:35:19 2024] ipmi_ssif: probe of i2c-IPI0001:00 failed with error -5

Also in some of these prints uninitialized variables are used.
So just exit early when communication with device is flawed.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/char/ipmi/ipmi_ssif.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 96ad571d041a..37516733e5c8 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1315,6 +1315,16 @@ static int read_response(struct i2c_client *client, unsigned char *resp)
 	return ret;
 }
 
+/* Filter SMBus communication errors from incorrect response errors */
+static bool is_smbus_error(struct device *dev, int err)
+{
+	if (!err || err == -EINVAL || err == -E2BIG)
+		return false;
+
+	dev_err(dev, "SMbus error: %d\n", err);
+	return true;
+}
+
 static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,
 		  int *resp_len, unsigned char *resp)
 {
@@ -1709,6 +1719,8 @@ static int ssif_probe(struct i2c_client *client)
 	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
 	msg[2] = 0; /* SSIF */
 	rv = do_cmd(client, 3, msg, &len, resp);
+	if (is_smbus_error(&client->dev, rv))
+		goto out;
 	if (!rv && (len >= 3) && (resp[2] == 0)) {
 		if (len < 7) {
 			if (ssif_dbg_probe)
@@ -1767,6 +1779,8 @@ static int ssif_probe(struct i2c_client *client)
 	msg[1] = IPMI_CLEAR_MSG_FLAGS_CMD;
 	msg[2] = WDT_PRE_TIMEOUT_INT;
 	rv = do_cmd(client, 3, msg, &len, resp);
+	if (is_smbus_error(&client->dev, rv))
+		goto out;
 	if (rv || (len < 3) || (resp[2] != 0))
 		dev_warn(&ssif_info->client->dev,
 			 "Unable to clear message flags: %d %d %2.2x\n",
@@ -1776,6 +1790,8 @@ static int ssif_probe(struct i2c_client *client)
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_GET_BMC_GLOBAL_ENABLES_CMD;
 	rv = do_cmd(client, 2, msg, &len, resp);
+	if (is_smbus_error(&client->dev, rv))
+		goto out;
 	if (rv || (len < 4) || (resp[2] != 0)) {
 		dev_warn(&ssif_info->client->dev,
 			 "Error getting global enables: %d %d %2.2x\n",
@@ -1796,6 +1812,8 @@ static int ssif_probe(struct i2c_client *client)
 	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
 	msg[2] = ssif_info->global_enables | IPMI_BMC_EVT_MSG_BUFF;
 	rv = do_cmd(client, 3, msg, &len, resp);
+	if (is_smbus_error(&client->dev, rv))
+		goto out;
 	if (rv || (len < 2)) {
 		dev_warn(&ssif_info->client->dev,
 			 "Error setting global enables: %d %d %2.2x\n",
@@ -1818,6 +1836,8 @@ static int ssif_probe(struct i2c_client *client)
 	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
 	msg[2] = ssif_info->global_enables | IPMI_BMC_RCV_MSG_INTR;
 	rv = do_cmd(client, 3, msg, &len, resp);
+	if (is_smbus_error(&client->dev, rv))
+		goto out;
 	if (rv || (len < 2)) {
 		dev_warn(&ssif_info->client->dev,
 			 "Error setting global enables: %d %d %2.2x\n",
-- 
2.43.0


