Return-Path: <linux-kernel+bounces-289312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 906EF9544AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148F71F21EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16CE13A276;
	Fri, 16 Aug 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uSMOKKEN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gf6cEKpF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uSMOKKEN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gf6cEKpF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486201DFFC;
	Fri, 16 Aug 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797862; cv=none; b=El8V110uPk8Ur3RMBR14yxR5ePdFzSvafjn1/zzanYEWYv8S55zYpi/bvvoH7Uvqs0AlaIyoUQYYsSoa3pRmgSiMA2quY+1UraMP6sE8IJXpIpYBHf3VOWBULzhwPZIj+4dD5LwVcOPC5oosu1QMdHVPiZV3AKgkBiPRqo6W/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797862; c=relaxed/simple;
	bh=UcKSgu7tH6gudD+Qyv6Gtt8dHN55p8Dqy2CrjkEAlvA=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=XHwflEQP/sP8IZHp0g5H/khaN+QEEy/QPS7Po2etZMXsdE/fF0gqUV/giQ0S85IQAWY+acJERLwYl3XuZw6qDYIbN61D33hhBEjxj5cmx8NttZSXg/dBvdR6iazCQRf7tROjfUmI5cDvvI2wFt8NjAaP6kjKRev4uNaCRW6spwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uSMOKKEN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gf6cEKpF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uSMOKKEN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gf6cEKpF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03AD02007B;
	Fri, 16 Aug 2024 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723797858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M1PDgaomHDsuabABtUPcyT4+tao7rNzMpf9YVtApS4s=;
	b=uSMOKKENKlVoikTBO9N2UMTpnWTnEg9KxOuqNZNGBfjV1yYHV5iSXiVvfsYM+pKlOOy7ns
	jfbXKncST5zlQ4ew0qFFqSSo2hQnsZM/yMi5O9Zdih9f7CqxLH2H9Nj1aF6e9MiaXBzhkF
	Syawv2XWNHHZV2pYfhZcHXg071Do1Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723797858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M1PDgaomHDsuabABtUPcyT4+tao7rNzMpf9YVtApS4s=;
	b=Gf6cEKpFsj3QacGudYoFxgVpHGSBJusQZ1DUgM2m6LdjFcvnWQvC+cNCJCklJe4cEg+tBT
	s8I2DKMDtWX9HiAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uSMOKKEN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gf6cEKpF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723797858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M1PDgaomHDsuabABtUPcyT4+tao7rNzMpf9YVtApS4s=;
	b=uSMOKKENKlVoikTBO9N2UMTpnWTnEg9KxOuqNZNGBfjV1yYHV5iSXiVvfsYM+pKlOOy7ns
	jfbXKncST5zlQ4ew0qFFqSSo2hQnsZM/yMi5O9Zdih9f7CqxLH2H9Nj1aF6e9MiaXBzhkF
	Syawv2XWNHHZV2pYfhZcHXg071Do1Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723797858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M1PDgaomHDsuabABtUPcyT4+tao7rNzMpf9YVtApS4s=;
	b=Gf6cEKpFsj3QacGudYoFxgVpHGSBJusQZ1DUgM2m6LdjFcvnWQvC+cNCJCklJe4cEg+tBT
	s8I2DKMDtWX9HiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1CB91397F;
	Fri, 16 Aug 2024 08:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UtJzMWERv2a9IgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Aug 2024 08:44:17 +0000
Date: Fri, 16 Aug 2024 10:44:58 +0200
Message-ID: <87sev43lh1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.11-rc4
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 03AD02007B

Linus,

please pull sound fixes for v6.11-rc4 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc4

The topmost commit is 829e2a23121fb36ee30ea5145c2a85199f68e2c8

----------------------------------------------------------------

sound fixes for 6.11-rc4

All small fixes, mostly for usual suspects, HD-audio and USB-audio
device-specific fixes / quirks.  The Cirrus codec support took the
update of SPI header as well.  Other than that, there is a regression
fix in the sanity check of ALSA timer code.

----------------------------------------------------------------

Baojun Xu (1):
      ALSA: hda/tas2781: fix wrong calibrated data order

Juan José Arboleda (1):
      ALSA: usb-audio: Support Yamaha P-125 quirk entry

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710 HEADSET

Parsa Poorshikhian (1):
      ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7

Richard Fitzgerald (3):
      spi: Add empty versions of ACPI functions
      ALSA: hda: cs35l56: Remove redundant call to hda_cs_dsp_control_remove()
      ALSA: hda: cs35l41: Remove redundant call to hda_cs_dsp_control_remove()

Simon Trimmer (1):
      ALSA: hda/realtek: Add support for new HP G12 laptops

Takashi Iwai (2):
      ALSA: timer: Relax start tick time check for slave timer elements
      ALSA: hda/tas2781: Use correct endian conversion

---
 include/linux/spi/spi.h         |  19 +++++++-
 sound/core/timer.c              |   2 +-
 sound/pci/hda/cs35l41_hda.c     |   2 +-
 sound/pci/hda/cs35l56_hda.c     |   2 +-
 sound/pci/hda/patch_realtek.c   | 100 +++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/tas2781_hda_i2c.c |  14 ++++--
 sound/usb/quirks-table.h        |   1 +
 sound/usb/quirks.c              |   2 +
 8 files changed, 132 insertions(+), 10 deletions(-)


