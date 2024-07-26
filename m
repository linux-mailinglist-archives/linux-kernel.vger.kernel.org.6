Return-Path: <linux-kernel+bounces-262905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D241A93CE89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E050B229BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11717798C;
	Fri, 26 Jul 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cMJnBSOh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ki8qKwq4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cMJnBSOh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ki8qKwq4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B8176FB3;
	Fri, 26 Jul 2024 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977627; cv=none; b=CAcsZvko/B7Inm0CuveKNPKFD6dm2nYtLwjL6Gx7bh2TJnI8fLiQ653Ej0fPPBgqB1rntTMO5JP1WjDbiFL4YB3mCa06uMCSRFyNtsAwvFLlMla+K/vgCLMlO3kC2EQsPK3vO9rQ0kM8Cg3TrWZLj9Ns7T5JNAvgwCeQX/kaV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977627; c=relaxed/simple;
	bh=zAhgEqjAUHHGlpi6Rh8b5bm1Di8bavHwLB0FzbgZaAY=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=I0XQuOOyytwvxoARalH0M/5BvejVQVzbgGJhgW34gVhAp9Nw4TAtSK/JvxiOE5fkTtoMX451dgwjwKOb7fmmu0Uh12l3qZZsQRO7t+9rkkxvVqRv3C4HCJ/BWkz6OIJBbOo+RovgF9YgiTF6aHDzSFqj4pJZdw5P/QBdzj7gzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cMJnBSOh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ki8qKwq4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cMJnBSOh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ki8qKwq4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6567A1F867;
	Fri, 26 Jul 2024 06:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721977169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HjInU5/CNBl9RZHwKcIpVuA5oVueIOQCnxxVoCimJJQ=;
	b=cMJnBSOh3EB0jHL/++VhXNPalkqiqgzpGIIR1F+eTcK7UOP76lmzeKYr6SVsI+Xylwq+3W
	Gz4akr6qqZpooCpKDYziHfQYoKsPuFBS+OFyJqbr8i0EvwTCGyR07DJKSREEIGhO+vK3Nl
	P/rA61ijWtADhSGIwuLz2tFliLRPTCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721977169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HjInU5/CNBl9RZHwKcIpVuA5oVueIOQCnxxVoCimJJQ=;
	b=Ki8qKwq4iMR/IC8QJ4qW01DhaLmtnPWnZ6GMqpiOeeVZd0iBpmjeP3VIp9HPBjRvPRGpdx
	YoOFMieHay52NSBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721977169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HjInU5/CNBl9RZHwKcIpVuA5oVueIOQCnxxVoCimJJQ=;
	b=cMJnBSOh3EB0jHL/++VhXNPalkqiqgzpGIIR1F+eTcK7UOP76lmzeKYr6SVsI+Xylwq+3W
	Gz4akr6qqZpooCpKDYziHfQYoKsPuFBS+OFyJqbr8i0EvwTCGyR07DJKSREEIGhO+vK3Nl
	P/rA61ijWtADhSGIwuLz2tFliLRPTCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721977169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HjInU5/CNBl9RZHwKcIpVuA5oVueIOQCnxxVoCimJJQ=;
	b=Ki8qKwq4iMR/IC8QJ4qW01DhaLmtnPWnZ6GMqpiOeeVZd0iBpmjeP3VIp9HPBjRvPRGpdx
	YoOFMieHay52NSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BE16138A7;
	Fri, 26 Jul 2024 06:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bZmODVFJo2Z5GAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 26 Jul 2024 06:59:29 +0000
Date: Fri, 26 Jul 2024 09:00:03 +0200
Message-ID: <87ttgchc3w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.11-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

Linus,

please pull sound fixes for v6.11-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.11-rc1

The topmost commit is e8b96a66ae01d039699bac256c5b6b30b2284170

----------------------------------------------------------------

sound fixes for 6.11-rc1

A collection of the fixes gathered since the previous PR.
We see a bit large LOCs at a HD-audio quirk, but that's only bulk
COEF data, hence it's safe to take.  In addition to that, there
were two minor fixes for MIDI 2.0 handling for ALSA core, and the
rest are all rather random small and device-specific fixes.

----------------------------------------------------------------

Arnd Bergmann (2):
      ALSA: hda: tas2781: mark const variables as __maybe_unused
      ASoC: tegra: select CONFIG_SND_SIMPLE_CARD_UTILS

Curtis Malainey (1):
      ASoC: Intel: Fix RT5650 SSP lookup

Dan Carpenter (1):
      ASoC: TAS2781: Fix tasdev_load_calibrated_data()

Daniel Baluta (1):
      ASoC: SOF: imx8m: Fix DSP control regmap retrieval

Luke D. Jones (1):
      ALSA: hda/realtek: cs35l41: Fixup remaining asus strix models

Nick Weihs (1):
      ALSA: hda/realtek: Implement sound init sequence for Samsung Galaxy Book3 Pro 360

Peter Ujfalusi (2):
      ASoC: SOF: ipc4-topology: Only handle dai_config with HW_PARAMS for ChainDMA
      ASoC: SOF: ipc4-topology: Preserve the DMA Link ID for ChainDMA on unprepare

Pierre-Louis Bossart (2):
      ASOC: SOF: Intel: hda-loader: only wait for HDaudio IOC for IPC4 devices
      ASoC: Intel: use soc_intel_is_byt_cr() only when IOSF_MBI is reachable

Shengjiu Wang (1):
      ASoC: fsl-asoc-card: Dynamically allocate memory for snd_soc_dai_link_components

Takashi Iwai (4):
      ALSA: usb-audio: Move HD Webcam quirk to the right place
      ALSA: ump: Don't update FB name for static blocks
      ALSA: ump: Force 1 Group for MIDI1 FBs
      ASoC: amd: yc: Support mic on Lenovo Thinkpad E16 Gen 2

Venkata Prasad Potturu (1):
      ASoC: sof: amd: fix for firmware reload failure in Vangogh platform

wangdicheng (2):
      ALSA: usb-audio: Fix microphone sound on HD webcam.
      ALSA: usb-audio: Add a quirk for Sonix HD USB Camera

---
 include/sound/tas2781-tlv.h                        |   6 +-
 sound/core/ump.c                                   |  13 +
 sound/pci/hda/patch_realtek.c                      |  15 +-
 sound/pci/hda/samsung_helper.c                     | 310 +++++++++++++++++++++
 sound/soc/amd/yc/acp6x-mach.c                      |   7 +
 sound/soc/codecs/tas2781-fmwlib.c                  |   2 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  46 +--
 sound/soc/intel/common/soc-acpi-intel-ssp-common.c |   9 +
 sound/soc/intel/common/soc-intel-quirks.h          |   2 +-
 sound/soc/sof/amd/pci-vangogh.c                    |   1 -
 sound/soc/sof/imx/imx8m.c                          |   2 +-
 sound/soc/sof/intel/hda-loader.c                   |  18 +-
 sound/soc/sof/intel/hda.c                          |  17 +-
 sound/soc/sof/ipc4-topology.c                      |  18 +-
 sound/soc/tegra/Kconfig                            |   1 +
 sound/usb/mixer.c                                  |   7 +
 sound/usb/quirks.c                                 |   4 +
 17 files changed, 433 insertions(+), 45 deletions(-)
 create mode 100644 sound/pci/hda/samsung_helper.c


