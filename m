Return-Path: <linux-kernel+bounces-401748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12C9C1EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FF81F22F56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E451E7C20;
	Fri,  8 Nov 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqioFINL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qOK3gHp8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqioFINL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qOK3gHp8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C4137E;
	Fri,  8 Nov 2024 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074330; cv=none; b=gKD9FV0dWCuy6xdovVDpmQX/0Xyfc6BBj1FnZVhVVNtZwjsDdhixOXZkuVlRdNpewwThn9USov+9PZdZOnQ0uxX/GRo8T8dxX6N5sDbgahOWRtw0Aa32zC1ODZcELoqLva5E7da1m96sSvASheTzLtbRuKXGvHBITNWw4mctsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074330; c=relaxed/simple;
	bh=kigZZFiIdO+1izDCUqQtceowvgWZbHeVOQunup/D1nw=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=tWsqBIOV2rOtFXDcpsGkZdBoPqQEm/JeSZE+mhYbutLPZsjo5FbYYf/aAT3RZsk2ked6f4kbZV96Z8NghtjlJ+snHDyYpi4WJn5Y5ekF+0VStG5D7e9ybND5egs9s8psSVkAzH4tXcKfIFtE8LMrbAch4dp3uENA4JwBrCqVMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqioFINL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qOK3gHp8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqioFINL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qOK3gHp8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A0B21FB88;
	Fri,  8 Nov 2024 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731074324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s/KC2+TXZEiRsAZ0XyNkyrBgbO4KNBKL4ew4wROs37o=;
	b=gqioFINLN0LDz/MwKVYfjRSXbNHqVIY/ECthhp+peMk/rXH1wglo/SqteaijIwqutFTCJ4
	jt2RfD2fH9NzlS2hVDgAL+DkRnMdjYtDVaUr4kLe22VIcXPa93RL/FLkmfIfxgTujqm9/5
	LVu22HBxVfwNd7wyKlAAr6kb2ZJzAV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731074324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s/KC2+TXZEiRsAZ0XyNkyrBgbO4KNBKL4ew4wROs37o=;
	b=qOK3gHp8KkCNHcVOVLxu8Dcgnj5tuKQGbaADWKAgyKWcYMPCEcEnDDgvqDTM21vLvyjpJ2
	k4HCxht75mJZxQDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gqioFINL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qOK3gHp8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731074324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s/KC2+TXZEiRsAZ0XyNkyrBgbO4KNBKL4ew4wROs37o=;
	b=gqioFINLN0LDz/MwKVYfjRSXbNHqVIY/ECthhp+peMk/rXH1wglo/SqteaijIwqutFTCJ4
	jt2RfD2fH9NzlS2hVDgAL+DkRnMdjYtDVaUr4kLe22VIcXPa93RL/FLkmfIfxgTujqm9/5
	LVu22HBxVfwNd7wyKlAAr6kb2ZJzAV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731074324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s/KC2+TXZEiRsAZ0XyNkyrBgbO4KNBKL4ew4wROs37o=;
	b=qOK3gHp8KkCNHcVOVLxu8Dcgnj5tuKQGbaADWKAgyKWcYMPCEcEnDDgvqDTM21vLvyjpJ2
	k4HCxht75mJZxQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E328813967;
	Fri,  8 Nov 2024 13:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m0YoNhMZLmflegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Nov 2024 13:58:43 +0000
Date: Fri, 08 Nov 2024 14:58:43 +0100
Message-ID: <87ed3lg73g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.12-rc7
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A0B21FB88
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.12-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc7

The topmost commit is fa59caa7859813b2a20f33e7c1f89459e7b6055f

----------------------------------------------------------------

sound fixes for 6.12-rc7

Still more changes floating than wished at this late stage, but
all are small device-specific fixes, and look less troublesome.

Including a few ASoC quirk / ID additoins, a series of ASoC STM
fixes, HD-audio conexant codec regression fix, and other various
quirks and device-specific fixes.

----------------------------------------------------------------

Amelie Delaunay (1):
      ASoC: stm32: spdifrx: fix dma channel release in stm32_spdifrx_remove

Jaros³aw Janik (1):
      Revert "ALSA: hda/conexant: Mute speakers at suspend / shutdown"

Jyri Sarha (1):
      ASoC: SOF: sof-client-probes-ipc4: Set param_size extension bits

Kuninori Morimoto (1):
      MAINTAINERS: Generic Sound Card section

Luo Yifan (2):
      ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
      ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()

Markus Petri (1):
      ASoC: amd: yc: Support dmic on another model of Lenovo Thinkpad E14 Gen 6

Mingcong Bai (1):
      ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022

Murad Masimov (1):
      ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()

Shenghao Ding (1):
      ASoC: tas2781: Add new driver version for tas2563 & tas2781 qfn chip

Takashi Iwai (2):
      ALSA: ump: Don't enumeration invalid groups for legacy rawmidi
      ALSA: usb-audio: Add quirk for HP 320 FHD Webcam

Venkata Prasad Potturu (1):
      ASoC: SOF: amd: Fix for incorrect DMA ch status register offset

---
 MAINTAINERS                            |  9 +++++++++
 sound/core/ump.c                       |  2 +-
 sound/firewire/tascam/amdtp-tascam.c   |  2 +-
 sound/pci/hda/patch_conexant.c         |  2 --
 sound/soc/amd/yc/acp6x-mach.c          | 14 ++++++++++++++
 sound/soc/codecs/tas2781-fmwlib.c      |  1 +
 sound/soc/sof/amd/acp.c                | 10 +++++++++-
 sound/soc/sof/sof-client-probes-ipc4.c |  1 +
 sound/soc/stm/stm32_sai_sub.c          |  6 +++---
 sound/soc/stm/stm32_spdifrx.c          |  2 +-
 sound/usb/mixer.c                      |  1 +
 sound/usb/quirks.c                     |  2 ++
 12 files changed, 43 insertions(+), 9 deletions(-)


