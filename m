Return-Path: <linux-kernel+bounces-434667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353929E6997
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1321883452
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A11E009D;
	Fri,  6 Dec 2024 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q98OhgMN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ND8n3Y10";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q98OhgMN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ND8n3Y10"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0718E050;
	Fri,  6 Dec 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475802; cv=none; b=ogbs8KyzHV+tmqo+TwPTSW8g0WX68Sw2NqCTP89wvGnfQp42mkcYex3LgQskTsy2acXnLxA+8adxPRuNwJuoxJn4LOmPnOoi7G1NE0Gyr0fpfjWBjMlrxfKs3yYO1thS+0HsMn6VaJKCulowhZA+UrsYtcaJZYTt/JLFZNHct8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475802; c=relaxed/simple;
	bh=PZebbAYCSWxSiPPRSvS5Vy7sEYZALfxiV6+N1A0uqlU=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=o3+0X5GWCSFAvD09Vm7ObOpuwiyE+DVuow7oZdG0aDjOAmYgor5eDCcB3N9f0K8k+K+CJkwxbPKZNkVRF5zAZiKBxLzoqc+wzxRoS7Oy6Xs87s05HeMCyyDYESYqIhHFUxnc5AoVi1Uv7aLT8sNictqjKTJewIeY5m1eX27eGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q98OhgMN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ND8n3Y10; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q98OhgMN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ND8n3Y10; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4EE61F38E;
	Fri,  6 Dec 2024 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733475798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=haYiRBuJD6qVdfpMmGceiz+yupXQb2bFsDT9UXN9G98=;
	b=q98OhgMNN6zvBZANl7gQNQC19/Vp8nQ9Pm2FdnsGjnYrbgt9QW+J7/S1C+r6D97tPi603q
	R7RL/7HL+EYxfvCcovXJxkQleIM/c5ZpWCqLniiiCcP6dhZew8X+P0XKDlwbh/qZVRRmqN
	8gEPn8AK1oPy1idHSD6+uWBxnle/65E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733475798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=haYiRBuJD6qVdfpMmGceiz+yupXQb2bFsDT9UXN9G98=;
	b=ND8n3Y10bhuJyq93PSC3I4z+cEVyTZ0O/FRuRjm02oz2ylYFut9C/Wqr9n/aFFfY/WVVQm
	1tQLJcedouq9AEBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q98OhgMN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ND8n3Y10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733475798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=haYiRBuJD6qVdfpMmGceiz+yupXQb2bFsDT9UXN9G98=;
	b=q98OhgMNN6zvBZANl7gQNQC19/Vp8nQ9Pm2FdnsGjnYrbgt9QW+J7/S1C+r6D97tPi603q
	R7RL/7HL+EYxfvCcovXJxkQleIM/c5ZpWCqLniiiCcP6dhZew8X+P0XKDlwbh/qZVRRmqN
	8gEPn8AK1oPy1idHSD6+uWBxnle/65E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733475798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=haYiRBuJD6qVdfpMmGceiz+yupXQb2bFsDT9UXN9G98=;
	b=ND8n3Y10bhuJyq93PSC3I4z+cEVyTZ0O/FRuRjm02oz2ylYFut9C/Wqr9n/aFFfY/WVVQm
	1tQLJcedouq9AEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 815F613647;
	Fri,  6 Dec 2024 09:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A9NVHta9UmeBBQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Dec 2024 09:03:18 +0000
Date: Fri, 06 Dec 2024 10:03:18 +0100
Message-ID: <8734j1tc89.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound fixes for 6.13-rc2
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4EE61F38E
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	FAKE_REPLY(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

please pull sound fixes for v6.13-rc2 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc2

The topmost commit is c34e9ab9a612ee8b18273398ef75c207b01f516d

----------------------------------------------------------------

sound fixes for 6.13-rc2

A collection of small fixes that have been gathered in the week.

- Fix the missing XRUN handling in USB-audio low latency mode
- Fix regression by the previous USB-audio hadening change
- Clean up old SH sound driver to use the standard helpers
- A few further fixes for MIDI 2.0 UMP handling
- Various HD-audio and USB-audio quirks
- Fix jack handling at PM on ASoC Intel AVS
- Misc small fixes for ASoC SOF and Mediatek

----------------------------------------------------------------

Asahi Lina (1):
      ALSA: usb-audio: Add extra PID for RME Digiface USB

Chris Chiu (1):
      ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops

Colin Ian King (1):
      ALSA: hda/realtek: Fix spelling mistake "Firelfy" -> "Firefly"

Dan Carpenter (3):
      ALSA: hda/tas2781: Fix error code tas2781_read_acpi()
      ASoC: SOF: ipc3-topology: fix resource leaks in sof_ipc3_widget_setup_comp_dai()
      ALSA: usb-audio: Fix a DMA to stack memory bug

Marek Maslanka (1):
      ASoC: Intel: avs: da7219: Remove suspend_pre() and resume_post()

Marie Ramlow (1):
      ALSA: usb-audio: add mixer mapping for Corsair HS80

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable mute and micmute LED on HP ProBook 430 G8

Nícolas F. R. A. Prado (1):
      ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic codec

Sahas Leelodharry (1):
      ALSA: hda/realtek: Add support for Samsung Galaxy Book3 360 (NP730QFG)

Takashi Iwai (7):
      ALSA: seq: ump: Fix seq port updates per FB info notify
      ALSA: ump: Don't open legacy substream for an inactive group
      ALSA: ump: Indicate the inactive group in legacy substream names
      ALSA: ump: Update legacy substream names upon FB info update
      ALSA: usb-audio: Notify xrun for low-latency mode
      ALSA: sh: Use standard helper for buffer accesses
      ALSA: ump: Shut up truncated string warning

bo liu (1):
      ALSA: hda/conexant: fix Z60MR100 startup pop issue

---
 sound/core/seq/seq_ump_client.c           |   6 +-
 sound/core/ump.c                          |  26 ++-
 sound/pci/hda/patch_conexant.c            |  28 +++
 sound/pci/hda/patch_realtek.c             |   8 +
 sound/pci/hda/tas2781_hda_i2c.c           |   1 +
 sound/sh/sh_dac_audio.c                   |   5 +-
 sound/soc/intel/avs/boards/da7219.c       |  17 --
 sound/soc/mediatek/mt8188/mt8188-mt6359.c |   4 +-
 sound/soc/sof/ipc3-topology.c             |   7 +-
 sound/usb/endpoint.c                      |  14 +-
 sound/usb/mixer_maps.c                    |  10 +
 sound/usb/mixer_quirks.c                  |   1 +
 sound/usb/quirks-table.h                  | 341 +++++++++++++++---------------
 sound/usb/quirks.c                        |  44 ++--
 14 files changed, 291 insertions(+), 221 deletions(-)


