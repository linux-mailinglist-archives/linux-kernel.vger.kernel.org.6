Return-Path: <linux-kernel+bounces-394912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8489BB5D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC21F22562
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5270839;
	Mon,  4 Nov 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LItpTLx5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rU+PZ3h2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LItpTLx5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rU+PZ3h2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803EF1805E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726543; cv=none; b=iIW1BCVYcKP8nQuGt3QQTjo5MK/NIvwFgVJv8LJn6KtJN4GSL30+oTISTa7vfC54+6XhzCIfGqNmOTHwe9ADqVimptAgdC/wbkEOaDZst3T7kumm7fCWZZzVIXdcRVmkBa51Z+KJ9zuiURC4XNMlTLlDiQN5WUABZltv1AHrapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726543; c=relaxed/simple;
	bh=C3I/a16UhzAH78djnTdAIo0mVoHQeH7jD9SXCSqSWIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TgKskm3l/wVRqdQKVhpokTQmMAPF1vubHW6q2FDYgA6se+X2B/5AXl6ONGOEZNjWuUDByqV07ru31ghZhub4uipBR8zWW3ubeeVZW7cedXg1PaDIBljnxJrC1DER7muXsFoWdomdhqfH59OnKtCw322PvmubAK5TvjIzpDO5CWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LItpTLx5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rU+PZ3h2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LItpTLx5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rU+PZ3h2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92F9921E07;
	Mon,  4 Nov 2024 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730726539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t4qAYNHvRlv4U7Et9ZCQ5zxRD/50zbtdrEMOh5EmF/0=;
	b=LItpTLx55scdQ55LBSS9wTNEUnBpJV3OXl+xqvb9t3q1ilCcMW0kIY8H3MknDCteO0Blq9
	JVI4BRNgzK8oOrhLjKPbz0O1vCkJgIf3jCTrPFHtAw+8EhOXG79QE8L5gKGU+vGfbFlgGN
	dRLgz/OfuiThSLha2H4UKXKGJjX+iLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730726539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t4qAYNHvRlv4U7Et9ZCQ5zxRD/50zbtdrEMOh5EmF/0=;
	b=rU+PZ3h2Weyp4LL1hhoM51s0LwtqwbwfXNYYNxP76KdGSFDpCqbCnDQHD7Fa11P8wKhrwS
	eykuUjHF8nU7gzCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LItpTLx5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rU+PZ3h2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730726539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t4qAYNHvRlv4U7Et9ZCQ5zxRD/50zbtdrEMOh5EmF/0=;
	b=LItpTLx55scdQ55LBSS9wTNEUnBpJV3OXl+xqvb9t3q1ilCcMW0kIY8H3MknDCteO0Blq9
	JVI4BRNgzK8oOrhLjKPbz0O1vCkJgIf3jCTrPFHtAw+8EhOXG79QE8L5gKGU+vGfbFlgGN
	dRLgz/OfuiThSLha2H4UKXKGJjX+iLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730726539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t4qAYNHvRlv4U7Et9ZCQ5zxRD/50zbtdrEMOh5EmF/0=;
	b=rU+PZ3h2Weyp4LL1hhoM51s0LwtqwbwfXNYYNxP76KdGSFDpCqbCnDQHD7Fa11P8wKhrwS
	eykuUjHF8nU7gzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46A761373E;
	Mon,  4 Nov 2024 13:22:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QN1PD4vKKGdNaQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 04 Nov 2024 13:22:19 +0000
Date: Mon, 4 Nov 2024 14:22:17 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gerhard Engleder <eg@keba.com>
Subject: [PATCH] misc: keba: Add hardware dependency
Message-ID: <20241104142217.1dad57cf@endymion.delvare>
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
X-Rspamd-Queue-Id: 92F9921E07
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[endymion.delvare:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Only propose KEBA CP500 drivers on architectures where the device
exists, unless build-testing.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-6.12-rc4.orig/drivers/misc/keba/Kconfig
+++ linux-6.12-rc4/drivers/misc/keba/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config KEBA_CP500
 	tristate "KEBA CP500 system FPGA support"
+	depends on X86_64 || ARM64 || COMPILE_TEST
 	depends on PCI
 	select AUXILIARY_BUS
 	help


-- 
Jean Delvare
SUSE L3 Support

