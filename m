Return-Path: <linux-kernel+bounces-183480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB698C99AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDC91F21504
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64081BF38;
	Mon, 20 May 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Y1qrsit";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MEREtT8B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Y1qrsit";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MEREtT8B"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA3FC1D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716192746; cv=none; b=PhDhwokZ5xyDhI2FCRz/5lFuM3yBU+T8M1PAVNfX4XX0CgLhVge4JbVUXMFsuk/OeIgvEKv+Z/M0pK/E6v7B41tn+WfPETsiB3IJ7yAl3MrDBMNVCNFl/Vah+5uA69qxd6sP3xAJ2i5awVera6tVlj3VQ0luvyP9k9YdqxkqPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716192746; c=relaxed/simple;
	bh=IjOPMFS0BvHE2ltRHld+74oQKCRSM8tN46/uyLdlo70=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=aFFQ/DxPONxVrwfZ6+KoP8Qeop5mQcqYYZHYiUIudY1h21CgaubaYAdrDfrZJrz3tXF/Eo6RLSkR7WbxXnBjewja9Fh4dUCzRgL+cw02afalSMjCVOpWMjvoB26USq5zOLGXItfL45rZNGRmyGl9nDdda01AdS9czMEzYDxcRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Y1qrsit; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MEREtT8B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Y1qrsit; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MEREtT8B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29FEC20B88;
	Mon, 20 May 2024 08:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716192743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RfO4OrdsEs2zpIDzxNtv58pndZOnIczWQ6oCFt1KxL0=;
	b=0Y1qrsitqvIXDIPwoldsOC1/1PJrffnkKW48cJnFYhvmbEKnuAk+AOy4rx1icRhhRk8yNL
	NSqyXNUQTqVOog58c9tO32xujEhjiriRhk+QdEOACMn7vejnEMR0J2vYkFsQPvrotcnkFS
	hshxOqScf7K7znSEDZyjpM+HKesBVgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716192743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RfO4OrdsEs2zpIDzxNtv58pndZOnIczWQ6oCFt1KxL0=;
	b=MEREtT8BDzqWP4Y4G4Gm7hQ1ghJc4Ju2zzmBcG7DBHkUoKyfdgvpJ2QKFSpZSSKOFl1b3i
	XGVe8rApDQPq5MAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0Y1qrsit;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MEREtT8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716192743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RfO4OrdsEs2zpIDzxNtv58pndZOnIczWQ6oCFt1KxL0=;
	b=0Y1qrsitqvIXDIPwoldsOC1/1PJrffnkKW48cJnFYhvmbEKnuAk+AOy4rx1icRhhRk8yNL
	NSqyXNUQTqVOog58c9tO32xujEhjiriRhk+QdEOACMn7vejnEMR0J2vYkFsQPvrotcnkFS
	hshxOqScf7K7znSEDZyjpM+HKesBVgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716192743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RfO4OrdsEs2zpIDzxNtv58pndZOnIczWQ6oCFt1KxL0=;
	b=MEREtT8BDzqWP4Y4G4Gm7hQ1ghJc4Ju2zzmBcG7DBHkUoKyfdgvpJ2QKFSpZSSKOFl1b3i
	XGVe8rApDQPq5MAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB12813A21;
	Mon, 20 May 2024 08:12:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UblYN+YFS2YUVAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 20 May 2024 08:12:22 +0000
Date: Mon, 20 May 2024 10:12:21 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>, LKML 
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmi update for v6.10
Message-ID: <20240520101221.463a1ec8@endymion.delvare>
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
X-Spam-Score: -4.43
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 29FEC20B88
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.43 / 50.00];
	BAYES_HAM(-2.92)[99.66%];
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
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]

Hi Linus,

Please pull dmi subsystem updates for Linux v6.10 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-v6.10

Summary of changes:
* Bug fixes:
  - KCFI violation in dmi-id
  - Panic on broken (short) DMI table entry
* New features:
  - Print info about populated memory slots at boot

This is the first time I use a signed tag for a pull request, I hope I
got it right, if not feel free to complain.

 drivers/firmware/dmi-id.c   |  7 ++++++-
 drivers/firmware/dmi_scan.c | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

---------------

Arnd Bergmann (1):
      firmware: dmi-id: add a release callback function

Heiner Kallweit (1):
      firmware: dmi: Add info message for number of populated and total memory slots

Jean Delvare (1):
      firmware: dmi: Stop decoding on broken entry

Thanks,
-- 
Jean Delvare
SUSE L3 Support

