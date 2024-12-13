Return-Path: <linux-kernel+bounces-444538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6AE9F0885
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FCD1627C4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995991B3934;
	Fri, 13 Dec 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hAty4y7W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uEoMGMfc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p3D7/bAD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ng5bItiK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C001B413D;
	Fri, 13 Dec 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083550; cv=none; b=GgvaxP6KAekqsGfUj8ZMdwO4He6a/DqwCeJ91ySKANECKHNCkXnW8Qlnw3kW8I68LYgp2LoEzLK/6XTGiJ7NuVo2a+Dw1eTVbcFji9wnKp+izSZnqz2ImvGgGQ+sz3oaL76sG+WMN5TXnZ/WEdacIG8QjrN+ysnRBa9tS7Wi9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083550; c=relaxed/simple;
	bh=u6vG6kCoxMmg9EkDe9k70uLIOs9bjxxQohQyTs65CLg=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=utuaHKrQM7X5wDPX+RdoVVPJ1DIDh5NYHdjJY803C6b1LxAvGfHc1C/FyxBrOMCWOzEmJqK3unCAQH+p/+9iWMOZS5Ao2MumUV2bwkXWkLxc2CV7CGf5wManUhs5X48xyRsP+9hwqz1hy0mLEttJj0Yzcmrn5bYRpIiwqDRR4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hAty4y7W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uEoMGMfc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p3D7/bAD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ng5bItiK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1BE21FC26;
	Fri, 13 Dec 2024 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734083547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=QkBzAipk+7/WTp/O2Q5RAsm9VxPwF20e1XHfMY17s8o=;
	b=hAty4y7WqZ7iNZXNf9GsnXXT+R6paLg1Lluwh0fnaouVzFX0T3KB7PfFHKC9oYHF2HyaEV
	wgr7BXl8g4qyK0JxP1HrussKxaGRpqgVyBYT2gO08HG38E1GKOVeiAVNrUuw0YGnkhvIBV
	Bzsb/dlXh1218ZSQ7m4Yg3r7xBaCWmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734083547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=QkBzAipk+7/WTp/O2Q5RAsm9VxPwF20e1XHfMY17s8o=;
	b=uEoMGMfciKflndq/IquiFSf5MZlLj/YMI0hK5RZwd98uhVkiM5ArabMXvwGt+h86Y/KM2T
	OG+soPHzQ7jkawBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="p3D7/bAD";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ng5bItiK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734083546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=QkBzAipk+7/WTp/O2Q5RAsm9VxPwF20e1XHfMY17s8o=;
	b=p3D7/bADSO8PmZNZ6nyuJRLiaq/h2GXuN1fi+kMcdXKe1iZWy5yyH26v7un6dq/v8Q6nPo
	t2asMPubf00q8jvJGh0kQovwsl/d5x82uTixzPa5s9Oe0JjP3nP9NpSbxuVF/tQYkqZw/S
	EjxY/FWsp6o/eOzumDXK6oFAq+pHnn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734083546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=QkBzAipk+7/WTp/O2Q5RAsm9VxPwF20e1XHfMY17s8o=;
	b=Ng5bItiKHcO/fsMkUxfbPlRRQqGsx4iNVSyXXQXzUvIaUlx87qIBuUMyNbV6Zl2pM4bO9b
	BdNKnfds9fH3nUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96C01137CF;
	Fri, 13 Dec 2024 09:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /OKAItoDXGc6PQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 13 Dec 2024 09:52:26 +0000
Date: Fri, 13 Dec 2024 10:52:26 +0100
Message-ID: <87pllvyko5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.13-rc3
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E1BE21FC26
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

please pull sound fixes for v6.13-rc3 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc3

The topmost commit is 7b26bc6582b13a52a42a4a9765e8f30d58a81198

----------------------------------------------------------------

sound fixes for 6.13-rc3

A collection of fixes; all look small, device-specific and boring.

----------------------------------------------------------------

Adrian Ratiu (2):
      sound: usb: enable DSD output for ddHiFi TC44C
      sound: usb: format: don't warn that raw DSD is unsupported

Charles Keepax (1):
      ASoC: Intel: sof_sdw: Add space for a terminator into DAIs array

Hridesh MG (1):
      ALSA: hda/realtek: Fix headset mic on Acer Nitro 5

Jaakko Salo (1):
      ALSA: usb-audio: Add implicit feedback quirk for Yamaha THR5

Shenghao Ding (1):
      ASoC: tas2781: Fix calibration issue in stress test

Shengjiu Wang (2):
      ASoC: fsl_xcvr: change IFACE_PCM to IFACE_MIXER
      ASoC: fsl_spdif: change IFACE_PCM to IFACE_MIXER

Simon Trimmer (1):
      ALSA: hda: cs35l56: Remove calls to cs35l56_force_sync_asp1_registers_from_cache()

Stephen Gordon (1):
      ASoC: audio-graph-card: Call of_node_put() on correct node

Takashi Iwai (2):
      ALSA: hda/ca0132: Use standard HD-audio quirk matching helpers
      ALSA: control: Avoid WARN() for symlink errors

Vasiliy Kovalev (2):
      ALSA: hda/realtek - Add support for ASUS Zen AIO 27 Z272SD_A272SD audio
      ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model

Venkata Prasad Potturu (1):
      ASoC: amd: yc: Fix the wrong return value

---
 include/sound/cs35l56.h               |  6 ------
 sound/core/control_led.c              | 14 +++++++++----
 sound/pci/hda/cs35l56_hda.c           |  8 --------
 sound/pci/hda/patch_ca0132.c          | 37 ++++++++++++++++++++---------------
 sound/pci/hda/patch_realtek.c         | 24 +++++++++++++++++++++++
 sound/soc/amd/yc/acp6x-mach.c         | 13 ++++++++----
 sound/soc/codecs/tas2781-i2c.c        |  2 +-
 sound/soc/fsl/fsl_spdif.c             |  2 +-
 sound/soc/fsl/fsl_xcvr.c              |  2 +-
 sound/soc/generic/audio-graph-card2.c |  2 +-
 sound/soc/intel/boards/sof_sdw.c      |  8 ++++++--
 sound/usb/format.c                    |  7 ++++++-
 sound/usb/quirks.c                    |  4 ++++
 13 files changed, 84 insertions(+), 45 deletions(-)


