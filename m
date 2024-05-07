Return-Path: <linux-kernel+bounces-171009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099308BDEBE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B817828279C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962091509A5;
	Tue,  7 May 2024 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E691q55S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qrUCpV9A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lY5r0qUb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9x8dM6XN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD314EC42
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074726; cv=none; b=ouSZx2bDvV3yHH4F4k7x7TOXGoJZ9YgJX9u41F+iM7nM4Lv0VZvLMKa/YGG048Eh5LhOXYGAy85cBo8EkatdzNVqrBy82upsFiO/IPs60zkj7eCBZ7qZqJbNFuts3RLaxD05MQLi4TprABTE83eU4G6R1ShU8/oMQ8dJ9Z9+jLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074726; c=relaxed/simple;
	bh=eXbpKyWcHlhKmPca1+OaSuv/lJ5TwkkXnxA+XDvD2Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hWadWb+eKahzMLlpH6YwYsWwFd1+joh9Kj44Wq70yZuEly+0NMXb7TbEw5VL6vjDr0zOu14SXw3pDO/KDmTQDk76rBs5S8ASaYh1TvVKMAkvrjzj3YmgoyH3cp3XNkJo6UXyAFO38z5e3QS2lfdagjLAMAlQ7vFbkIvlajd652I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E691q55S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qrUCpV9A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lY5r0qUb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9x8dM6XN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F069B33C86;
	Tue,  7 May 2024 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715074723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KjXHh1Mbqhk+raTWPa9v8fmmU58/T1wwTtl0+ktsZ2U=;
	b=E691q55SG9U+6u+dupULFV5WQ6z9E1YQvjW/7hz68I6WUZDk3M8zZZl9agJY1Oxw0pzeLk
	vi2LXVZEGzdjbMUDt/FEakQrp1CoBhh3GkyDxzlhkhIQoZA6aeVX2xfJYXvBrWqdoFny5I
	ifQvN2/fzU52VRWedbD6/c5UdzjOfq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715074723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KjXHh1Mbqhk+raTWPa9v8fmmU58/T1wwTtl0+ktsZ2U=;
	b=qrUCpV9AwnOh3dBfH3G8XXDTMwG5BmMeAGStL849qeggkMaXIPIoUhE3aE4KQoKd5NM4Bn
	SskIWO+S25uGxjDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lY5r0qUb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9x8dM6XN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715074721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KjXHh1Mbqhk+raTWPa9v8fmmU58/T1wwTtl0+ktsZ2U=;
	b=lY5r0qUbL5/KwJWofZg7GVSim6AZPKYydwqejHE9XLKa406prkMmSvyf7r9UQpniddJ7xC
	LPXhP4Jg0sSEmUXsC1TcyIGLLJkJn2W1+XgrttOM9SaiuPe4CNgOs8RJKjonoSawfpG7NR
	oNuvxhnF49OdJRf7e6JwjwRPmk2eolA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715074721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KjXHh1Mbqhk+raTWPa9v8fmmU58/T1wwTtl0+ktsZ2U=;
	b=9x8dM6XNDVfq4SybOr0PIjf1AUj7TCzlaORQSL5ucL7Ei8E83eKpXfbE9oRc+8ZJvPdmGy
	HuHxPcPthunEncCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7254B13A2D;
	Tue,  7 May 2024 09:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rtcoFaH2OWZIUwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 07 May 2024 09:38:41 +0000
Date: Tue, 7 May 2024 11:38:38 +0200
From: Jean Delvare <jdelvare@suse.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] firmware: dmi: Mark dmi_memdev_populated_nr __initdata
Message-ID: <20240507113838.760b4d47@endymion.delvare>
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
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F069B33C86
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

Static variable dmi_memdev_populated_nr is only used in __init
functions, so it can be marked __initdata.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
---
I could also squash this change in the commit which introduced
dmi_memdev_populated_nr, as it's not upstream yet, if Heiner is OK with
it.

 drivers/firmware/dmi_scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.8.orig/drivers/firmware/dmi_scan.c
+++ linux-6.8/drivers/firmware/dmi_scan.c
@@ -42,7 +42,7 @@ static struct dmi_memdev_info {
 	u8 type;		/* DDR2, DDR3, DDR4 etc */
 } *dmi_memdev;
 static int dmi_memdev_nr;
-static int dmi_memdev_populated_nr;
+static int dmi_memdev_populated_nr __initdata;
 
 static const char * __init dmi_string_nosave(const struct dmi_header *dm, u8 s)
 {


-- 
Jean Delvare
SUSE L3 Support

