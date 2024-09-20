Return-Path: <linux-kernel+bounces-334227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741997D436
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83F9B221C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198313BC2F;
	Fri, 20 Sep 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Dn/a/Cy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jLWpAuDH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Dn/a/Cy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jLWpAuDH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491F1BC46
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828361; cv=none; b=lNrSbNfMrmwKMZ2GLc6atvINE74pg33W1OV8hWQbrRZzTdILRAggc3JbinA8OECnWwXKmWnot2/QQKk3al+yQCLC3gUjXmolXcLZaz9CA9TbGm31mkzYb6RBwV3moLR5bcCPUtqc8AJDgqQd08PbJSEFYujLPKGy7a3jXolYp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828361; c=relaxed/simple;
	bh=nlrGjBSyG3MwjE5yb2fsfr465lLdwPjOxqbrIgfspvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boJv3DkaVhgKbuupKMxqlpunHq+Uo8x3XkoUYninQH+Lki4ESi1uQ+GNP1W7dhCf5Q4TRru3Yy6B+DjrqoblttUh9Ur2z0XkSw05dCfwZVZplvxD7h46gbRMQaEeIORWOykF1dwk+VtD8hkqqcsROVU0ouM1KSUG7hCO41EPsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Dn/a/Cy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jLWpAuDH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Dn/a/Cy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jLWpAuDH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F8861F7FB;
	Fri, 20 Sep 2024 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726828352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j0X4i0heHHNdQhnOO3fFUS6xidmW19WD71uous8/JiE=;
	b=1Dn/a/CyO8aserIxAXiDSCMKA7FbsTo69KuOJoBPLsrgT0mkQHgCLh7lE6VfMnnIn1KMy6
	Cm5n6BlyfRI0wT7pZXGYPDRvScy5NHSW8YKMSNL/lRPJxWRmKZSB+lyxSp/fdI22oYeufH
	0VUvFxdJU1LE8zQJ54RjgCsn4VmmYMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726828352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j0X4i0heHHNdQhnOO3fFUS6xidmW19WD71uous8/JiE=;
	b=jLWpAuDHaTxFlFxzyFrlGlgvDniSAEaDsBe/gpZKwsA49fdUIblD/HUwInGI1tu5hkXsKU
	SunvkTksj43oK+Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726828352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j0X4i0heHHNdQhnOO3fFUS6xidmW19WD71uous8/JiE=;
	b=1Dn/a/CyO8aserIxAXiDSCMKA7FbsTo69KuOJoBPLsrgT0mkQHgCLh7lE6VfMnnIn1KMy6
	Cm5n6BlyfRI0wT7pZXGYPDRvScy5NHSW8YKMSNL/lRPJxWRmKZSB+lyxSp/fdI22oYeufH
	0VUvFxdJU1LE8zQJ54RjgCsn4VmmYMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726828352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j0X4i0heHHNdQhnOO3fFUS6xidmW19WD71uous8/JiE=;
	b=jLWpAuDHaTxFlFxzyFrlGlgvDniSAEaDsBe/gpZKwsA49fdUIblD/HUwInGI1tu5hkXsKU
	SunvkTksj43oK+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46EE713AA7;
	Fri, 20 Sep 2024 10:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id euIOEEBP7WagBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 20 Sep 2024 10:32:32 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	tuhaowen <tuhaowen@uniontech.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] parport: Proper fix for array out-of-bounds access
Date: Fri, 20 Sep 2024 12:32:19 +0200
Message-ID: <20240920103318.19271-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

The recent fix for array out-of-bounds accesses replaced sprintf()
calls blindly with snprintf().  However, since snprintf() returns the
would-be-printed size, not the actually output size, the length
calculation can still go over the given limit.

Use scnprintf() instead of snprintf(), which returns the actually
output letters, for addressing the potential out-of-bounds access
properly.

Fixes: ab11dac93d2d ("dev/parport: fix the array out-of-bounds risk")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

The code is very oldfashioned, but I leave as is in this patch for
making clearer that it's only about the replacements of snprintf().

 drivers/parport/procfs.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 3ef486cd3d6d..3880460e67f2 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -51,12 +51,12 @@ static int do_active_device(const struct ctl_table *table, int write,
 	
 	for (dev = port->devices; dev ; dev = dev->next) {
 		if(dev == port->cad) {
-			len += snprintf(buffer, sizeof(buffer), "%s\n", dev->name);
+			len += scnprintf(buffer, sizeof(buffer), "%s\n", dev->name);
 		}
 	}
 
 	if(!len) {
-		len += snprintf(buffer, sizeof(buffer), "%s\n", "none");
+		len += scnprintf(buffer, sizeof(buffer), "%s\n", "none");
 	}
 
 	if (len > *lenp)
@@ -87,19 +87,19 @@ static int do_autoprobe(const struct ctl_table *table, int write,
 	}
 	
 	if ((str = info->class_name) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "CLASS:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "CLASS:%s;\n", str);
 
 	if ((str = info->model) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "MODEL:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "MODEL:%s;\n", str);
 
 	if ((str = info->mfr) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "MANUFACTURER:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "MANUFACTURER:%s;\n", str);
 
 	if ((str = info->description) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "DESCRIPTION:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "DESCRIPTION:%s;\n", str);
 
 	if ((str = info->cmdset) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "COMMAND SET:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "COMMAND SET:%s;\n", str);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -128,7 +128,7 @@ static int do_hardware_base_addr(const struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
+	len += scnprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -155,7 +155,7 @@ static int do_hardware_irq(const struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->irq);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->irq);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -182,7 +182,7 @@ static int do_hardware_dma(const struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->dma);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->dma);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -213,7 +213,7 @@ static int do_hardware_modes(const struct ctl_table *table, int write,
 #define printmode(x)							\
 do {									\
 	if (port->modes & PARPORT_MODE_##x)				\
-		len += snprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
+		len += scnprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
 } while (0)
 		int f = 0;
 		printmode(PCSPP);
-- 
2.43.0


