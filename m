Return-Path: <linux-kernel+bounces-262923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30393CEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8BF1C2133A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F83C548EE;
	Fri, 26 Jul 2024 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JENxbB/M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B9ePZyfN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JENxbB/M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B9ePZyfN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8923D2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978432; cv=none; b=Y5aUFdqGu2J4ucvxfEH7RX6d3AmTGi51OPwd50Uw0BZYWf6NlSPHL/CT1VAZIynhLvuY60gC6apYXuRb59WhJ6cqXkxqX+DHtYiqgXoRCJfqdidvO48xaugiGWIixagUw/mHW91Z9lIGsKXN9Js1NTawCqkQMyroKsq18w3JqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978432; c=relaxed/simple;
	bh=3cSuLKpE/DMHGp7izyzBHI/ahbST+ml4yDAQmeRQlS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q20MHaMdqqBdyLoAXnWdiDMbXztRAicA00ny05LRD8c5TC+2RUEaYGENQG8PqCjQ/+TwYW52z068NjNgZb4MWfuHdIg6Qrz8XlF5MWGfd93Rp6L8jYnmfPJemlvYgZmWXI//pJBGn+GpCmPY9OuHQiR1d+7lDhDw++eYbgecvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JENxbB/M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B9ePZyfN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JENxbB/M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B9ePZyfN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21F0621A52;
	Fri, 26 Jul 2024 07:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721978429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l4aoEm5lf95gxMPPAT4dKt3MyZiPjHCL44jorGbcuts=;
	b=JENxbB/MHuGcZnjfNogE6CaeJVl9k9BqXrFTQOuSQ87iV8RN2yEy6vbN76mdv3zdX32hwX
	Byx1tquuzgLWSkB9gnGuFLsq+ARh51ncb4Tc8X/JwoTcIbi32qK6andzkJcXbs7sylIRpJ
	qw6R9ReEmEuJ1m6jyKJH6JU8W+9OOEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721978429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l4aoEm5lf95gxMPPAT4dKt3MyZiPjHCL44jorGbcuts=;
	b=B9ePZyfNgO7ipdi209M7WR9gXGA2rggSeCUYjZXuXDK7GlUg18ax5HnwMqzm8PegJo8lzJ
	PaGvMBiyAjg+TADA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="JENxbB/M";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B9ePZyfN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721978429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l4aoEm5lf95gxMPPAT4dKt3MyZiPjHCL44jorGbcuts=;
	b=JENxbB/MHuGcZnjfNogE6CaeJVl9k9BqXrFTQOuSQ87iV8RN2yEy6vbN76mdv3zdX32hwX
	Byx1tquuzgLWSkB9gnGuFLsq+ARh51ncb4Tc8X/JwoTcIbi32qK6andzkJcXbs7sylIRpJ
	qw6R9ReEmEuJ1m6jyKJH6JU8W+9OOEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721978429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l4aoEm5lf95gxMPPAT4dKt3MyZiPjHCL44jorGbcuts=;
	b=B9ePZyfNgO7ipdi209M7WR9gXGA2rggSeCUYjZXuXDK7GlUg18ax5HnwMqzm8PegJo8lzJ
	PaGvMBiyAjg+TADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBE581396E;
	Fri, 26 Jul 2024 07:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5rLdLDxOo2abHgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 07:20:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>,
	Xiao Yang <yangx.jy@fujitsu.com>,
	Yang Xu <xuyang2018.jy@fujitsu.com>,
	Andrea Cervesato <andrea.cervesato@suse.de>,
	ltp@lists.linux.it,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Vorel <petr.vorel@gmail.com>
Subject: [PATCH 1/1] MAINTAINERS: Update LTP members and web
Date: Fri, 26 Jul 2024 09:20:09 +0200
Message-ID: <20240726072009.1021599-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 21F0621A52
X-Spam-Score: -1.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,redhat.com,fujitsu.com,suse.de,lists.linux.it,linux-foundation.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCPT_COUNT_SEVEN(0.00)[11];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

LTP project uses now readthedocs.org instance instead of GitHub wiki.

LTP maintainers are listed in alphabetical order.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..fa514177125b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13322,14 +13322,16 @@ F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
 
 LTP (Linux Test Project)
+M:	Andrea Cervesato <andrea.cervesato@suse.com>
 M:	Cyril Hrubis <chrubis@suse.cz>
 M:	Jan Stancek <jstancek@redhat.com>
 M:	Petr Vorel <pvorel@suse.cz>
 M:	Li Wang <liwang@redhat.com>
 M:	Yang Xu <xuyang2018.jy@fujitsu.com>
+M:	Xiao Yang <yangx.jy@fujitsu.com>
 L:	ltp@lists.linux.it (subscribers-only)
 S:	Maintained
-W:	http://linux-test-project.github.io/
+W:	https://linux-test-project.readthedocs.io/
 T:	git https://github.com/linux-test-project/ltp.git
 
 LTR390 AMBIENT/UV LIGHT SENSOR DRIVER
-- 
2.45.2


