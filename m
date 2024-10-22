Return-Path: <linux-kernel+bounces-376120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831A9AA055
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153EB28361F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F319993B;
	Tue, 22 Oct 2024 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dd1qYMsn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Hm1/5hq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dd1qYMsn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Hm1/5hq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B995198E75
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594070; cv=none; b=TxhHNlaCgWk81RllEwJeW1b4uXpKBjreOb5LOHXwer/gH4ebOcyGe7c+Zsgoivqcy+uY8oHqRxcGtxC++lWcIFe31Ld6w4VmW4wyYpRyT0XiqGo7qV+LxspI2jAZiYoGvnrXYyw0bptpnyfjw+8C9nxHpgjSCrBL/yzQwvZw0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594070; c=relaxed/simple;
	bh=UJK3iAXtp0KtFOuj4zyoXtcmuPwoV4LHGQX8Y+iZ8VM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Dddqo1dgjvEa8mNL9eZngAlmPzX3CdqHVXditwClUB0A6305B8+1I5tyUT+JKS0ioEpjV7kYu1vORywzAFIaPUzribNCLWhKcoNyXvHKnY84yGTiAA94byrCQxBHCXabyR3MmH5fBsGq3Naf8d6M6t+yFbmO+pJCeySiHrlbI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dd1qYMsn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Hm1/5hq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dd1qYMsn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Hm1/5hq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CB9721EDE;
	Tue, 22 Oct 2024 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729594067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hhORqBoElAyjPD+QsuV4UE5a/qdOiShbTdQibwv1ysg=;
	b=Dd1qYMsnNNq2LJWeY7XQr5DVvXILtIWOYmt1uXcwvmO9h4bhwYU1n9ae7gDOR42l4M0CRM
	wVNdnR0iIyq5ctvHKJma/G4Jnsfq8aNZqYmqaWc4Jw+UdND3a78cpvk3k6JeSGbMG+Z8/5
	MuCmJxu0n5Z5IjACedYD2RAUh0oKzBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729594067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hhORqBoElAyjPD+QsuV4UE5a/qdOiShbTdQibwv1ysg=;
	b=5Hm1/5hqNcMU6fXjD2Edj9MZ1pVZorEcEOlO6wIF3d/ynkQRu7xtnvT8HXbQC0pzqvo4w0
	MkXVI1wh9DyuPVBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dd1qYMsn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5Hm1/5hq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729594067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hhORqBoElAyjPD+QsuV4UE5a/qdOiShbTdQibwv1ysg=;
	b=Dd1qYMsnNNq2LJWeY7XQr5DVvXILtIWOYmt1uXcwvmO9h4bhwYU1n9ae7gDOR42l4M0CRM
	wVNdnR0iIyq5ctvHKJma/G4Jnsfq8aNZqYmqaWc4Jw+UdND3a78cpvk3k6JeSGbMG+Z8/5
	MuCmJxu0n5Z5IjACedYD2RAUh0oKzBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729594067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hhORqBoElAyjPD+QsuV4UE5a/qdOiShbTdQibwv1ysg=;
	b=5Hm1/5hqNcMU6fXjD2Edj9MZ1pVZorEcEOlO6wIF3d/ynkQRu7xtnvT8HXbQC0pzqvo4w0
	MkXVI1wh9DyuPVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1245113894;
	Tue, 22 Oct 2024 10:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TvxuAtOCF2fFKQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 22 Oct 2024 10:47:47 +0000
Date: Tue, 22 Oct 2024 12:47:45 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH] mfd: adp5585: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20241022124745.5d8d3778@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5CB9721EDE
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/mfd/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.12-rc4.orig/drivers/mfd/Kconfig
+++ linux-6.12-rc4/drivers/mfd/Kconfig
@@ -25,7 +25,7 @@ config MFD_ADP5585
 	select MFD_CORE
 	select REGMAP_I2C
 	depends on I2C
-	depends on OF || COMPILE_TEST
+	depends on OF
 	help
 	  Say yes here to add support for the Analog Devices ADP5585 GPIO
 	  expander, PWM and keypad controller. This includes the I2C driver and


-- 
Jean Delvare
SUSE L3 Support

