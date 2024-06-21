Return-Path: <linux-kernel+bounces-224913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C615691289D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D81F2679E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1D3A1C9;
	Fri, 21 Jun 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EukmjfWC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BfmrTB14";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NwDdPl7p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3tRrfoPY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F3383A2;
	Fri, 21 Jun 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981752; cv=none; b=iQoz81hTYswNEzp8EXnoAOaWLY/hf+6KotLtOS82uWpBhvKu99BAauvx4LKLxI3j8LClZ34TQALxybIYR3KGo2AOoCm+QY2oe+5+1uSIIzCh5TXwDtGJPwzUt0MFhrdJbOhGu392KQoElq1JsdD3znSoPZ6zR2nM3FWC81DR+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981752; c=relaxed/simple;
	bh=FgVdijDU0BtB3Yp38vf7dWgs4zrbtpChVLwuhV1ycjc=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=gbri9QMjOfJJizwCxR59D34n6ic747zNpUwpb2jNqm8Cy3j1XGdqumP7jBTlbX9fehtm6rrPUtzRmUfMIKSIEBkgrjcqfluIhQ4vYZQsKU7RKhyEkon2ILQDCNAf5HeHx4mTWsDuDVdyzPXR8o2cMSS569LNNwlvlyzyKmke+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EukmjfWC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BfmrTB14; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NwDdPl7p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3tRrfoPY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9B8D1FB80;
	Fri, 21 Jun 2024 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718981749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9cBWSUlwLGO8g801If0Hzc9joacR0slodg2mwVbceUs=;
	b=EukmjfWCJRqqs4u7B9Va97XA/bQbz+gfPCCTKpa/Ypwa+DI+f6Ylp0QYH1GMyrGhyv4Cw/
	slKfGQvujOXRiP3lu81q/CuyJgn42eQW1leZQZTAZZ7qTtJOChFkb9JG2CIMcuLHGHeNdZ
	WRMybSLPNYyx426W87gECOIv4wOrzTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718981749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9cBWSUlwLGO8g801If0Hzc9joacR0slodg2mwVbceUs=;
	b=BfmrTB14dDy/T9ELlBYdyW3sLQqaL2cAwoUe3zgB0nlMXMHeWucQoVfJuiA52MPb0XiwSv
	WeBn8b1huXE62cDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NwDdPl7p;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3tRrfoPY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718981746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9cBWSUlwLGO8g801If0Hzc9joacR0slodg2mwVbceUs=;
	b=NwDdPl7pFUNSmB67fbK1upmIR/7JKB8qE7qPg5i/UVhQD33hCmEkgeuY0kYyhbRVTc6Mfp
	5QaqaBwflMkW1/H6zX9sdHjci095coHnnC/fnmveA4phQxvwbEbmVpfdiu01XxVmYxPE1D
	rGHMrglPOE8a0qGJ1lCbgpp57lYoi44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718981746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9cBWSUlwLGO8g801If0Hzc9joacR0slodg2mwVbceUs=;
	b=3tRrfoPYaiEhrz4PL9JM6Yzae5eugDRi/HyekJhUrl/NNVzX4jK1rOa2WTG2LBWIe6GGKq
	OBDySSIwAXFPIcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B8A713ABD;
	Fri, 21 Jun 2024 14:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B2/cIHKUdWZjMgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 21 Jun 2024 14:55:46 +0000
Date: Fri, 21 Jun 2024 16:56:12 +0200
Message-ID: <87sex6xs37.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.10-rc5 #2
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9B8D1FB80
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Linus,

please pull additional sound fixes for v6.10-rc5 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc5-2

The topmost commit is 17563b4a19d1844bdbccc7a82d2f31c28ca9cfae

----------------------------------------------------------------

sound fixes for 6.10-rc5 #2

A follow-up fix of the previous PR for a random build issue,
as well as another trivial HD-audio quirk.

----------------------------------------------------------------

Pablo Caño (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9

Takashi Iwai (1):
      ALSA: hda: Use imply for suggesting CONFIG_SERIAL_MULTI_INSTANTIATE

---
 sound/pci/hda/Kconfig         | 4 ++--
 sound/pci/hda/patch_realtek.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)


