Return-Path: <linux-kernel+bounces-415912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B559D3DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3598D282A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458E1BB6BE;
	Wed, 20 Nov 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pcFDLmkH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PSqLD9t6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pcFDLmkH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PSqLD9t6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C021C729E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114032; cv=none; b=HaTqwPyGVh5LnaoINOemr4aEoKf9ZKDzkDvex0ap+iOV9kNmurMQpiGTJBMQLL7WwLdL44mkovoeubIRafZh2AULlGIsv4Ra5qbcxwgatF7DZLc+0BNtWrAxpS9FqD1yElUtNKkHEctxDedhyEaNjhPv/QXGn81XLA+24j4zYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114032; c=relaxed/simple;
	bh=Q//CceOGU1KDOVF7hhFvXgmcJjAmUOZIg4W19EMSW9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRV/kRqkYFLTbfpyUMYjnSARK+8+GsougicUu60pBaGdniYnHa12NMEoUSLJkXfaj9VkbZpVBqxO2d3QZuCW1h668kvpYSL0/m/F8P9B5cCCpO5UK9zhDv753mhYpvQxLly/OovW++2NIkwCva6uY/tlgUpqqq3p2aMJem7f20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pcFDLmkH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PSqLD9t6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pcFDLmkH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PSqLD9t6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 920FA21983;
	Wed, 20 Nov 2024 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732114028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTjEPcqQSzMAywwV8WVIkb9ZCpihPqw/U/xxDZQayo0=;
	b=pcFDLmkHQvt2hSh6KLg3ubqvitELmEtlHS03i4FA4f+J1pHbSpgqAQXgsKmitySXAluJnF
	D1SbQAEKPug2lklLFdIbOaSeEpTjUcoH/aXtXYvJRQXuRjvq7XQYc6BFGzpPPItf+ga7Nw
	SavAw4HAJmNqBa68EDdk6KSMWvFF79U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732114028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTjEPcqQSzMAywwV8WVIkb9ZCpihPqw/U/xxDZQayo0=;
	b=PSqLD9t6fBDrGfFJ3QcjDDWV75ZHn0OT3VxoU/xKcHBcnl19E0AaU9f3i0umhlGXnonkRj
	5cSiLtnpBOkMCuBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pcFDLmkH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PSqLD9t6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732114028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTjEPcqQSzMAywwV8WVIkb9ZCpihPqw/U/xxDZQayo0=;
	b=pcFDLmkHQvt2hSh6KLg3ubqvitELmEtlHS03i4FA4f+J1pHbSpgqAQXgsKmitySXAluJnF
	D1SbQAEKPug2lklLFdIbOaSeEpTjUcoH/aXtXYvJRQXuRjvq7XQYc6BFGzpPPItf+ga7Nw
	SavAw4HAJmNqBa68EDdk6KSMWvFF79U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732114028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTjEPcqQSzMAywwV8WVIkb9ZCpihPqw/U/xxDZQayo0=;
	b=PSqLD9t6fBDrGfFJ3QcjDDWV75ZHn0OT3VxoU/xKcHBcnl19E0AaU9f3i0umhlGXnonkRj
	5cSiLtnpBOkMCuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33874137CF;
	Wed, 20 Nov 2024 14:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a9Z4Cmz2PWcCOAAAD6G6ig
	(envelope-from <pperego@suse.de>); Wed, 20 Nov 2024 14:47:08 +0000
From: Paolo Perego <pperego@suse.de>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Bakker <kees@ijzerbout.nl>,
	Paolo Perego <pperego@suse.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] staging:gpib: Fix a dereference before null check issue
Date: Wed, 20 Nov 2024 15:46:53 +0100
Message-ID: <20241120144653.377795-1-pperego@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 920FA21983
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,linaro.org,ijzerbout.nl,suse.de,arndb.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This commit fixes a dereference before null check issue discovered by
Coverity (CID 1601566).

The check ad line 1450 suggests that a_priv can be NULL, however it has
been derefenced before, in the interface_to_usbdev() call.

Signed-off-by: Paolo Perego <pperego@suse.de>
---
 drivers/staging/gpib/agilent_82357a/agilent_82357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index bf05fb4a736b..604e13c32dfb 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -1446,8 +1446,8 @@ static void agilent_82357a_detach(gpib_board_t *board)
 	mutex_lock(&agilent_82357a_hotplug_lock);
 
 	a_priv = board->private_data;
-	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	if (a_priv) {
+		usb_dev = interface_to_usbdev(a_priv->bus_interface);
 		if (a_priv->bus_interface) {
 			agilent_82357a_go_idle(board);
 			usb_set_intfdata(a_priv->bus_interface, NULL);
-- 
2.47.0


