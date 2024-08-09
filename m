Return-Path: <linux-kernel+bounces-280889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980D94D083
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6DF1C211DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40810194AD8;
	Fri,  9 Aug 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O/d4fy7W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pyVe9woa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O/d4fy7W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pyVe9woa"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D4194ACA;
	Fri,  9 Aug 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207749; cv=none; b=LXHbMMeEj7HU9lQx/1u2EgsqlrG5fTY24E1OzfjFoukKm5CDX3jzd/2A+IfVuRiGBj882SFVaRYpPkrkUfSFy63paPhBrR5u5OChfOCHL3Ifnq792JEnEWoU3RKygyNIPMLiemJoSHj49SBY3zI0SmVt5J+c8rCt6m9Z2WPNwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207749; c=relaxed/simple;
	bh=el+2wMo+BQYZPbcTiD8WKebzfbjgoDYD0lcFtOEsaSU=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=BgYlkY1HKmPwbbAM+f9AGa8JAYL4cfqNmz7cKYA01/pMNLAj0FD1IHNw7wKQLfJvXjQoFewJmQDd5M6iIFDR92hfUemaOmRPoeWV7SFr8TgLzy5ZJEYXDzs5Nf+PQd0o7Aq7vmhfXCnvcApDPTesMlHF0BoZuCHb9pZ0XTeujXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O/d4fy7W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pyVe9woa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O/d4fy7W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pyVe9woa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 59BA021F33;
	Fri,  9 Aug 2024 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723207744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xDH7jGw+Qug8RAycGpVLEM+D4LfpipX3IlH9p18Qzuc=;
	b=O/d4fy7WBMLoXDz1UrRZN+H1syuiQCw47pFDd0P5JOV28thfZ1w9RQuueR1BfCz758QYZ/
	EEe/vYrlCTsBNcgxUsJo5bbtyEmO9lvFNQXhSfNOlhH+gwROQsKpQR2rruLaOXDu8lczlA
	7hNSuOXIu1WsNW9h0X/BreXXLxtPRec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723207744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xDH7jGw+Qug8RAycGpVLEM+D4LfpipX3IlH9p18Qzuc=;
	b=pyVe9woadI+oQg8znwGDPMt37eV3xk7yOXhd9acFZuxbdm8qndhIy2LDLIbqDHa28nOMnd
	NNkb2iwDYLYGjMBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="O/d4fy7W";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pyVe9woa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723207744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xDH7jGw+Qug8RAycGpVLEM+D4LfpipX3IlH9p18Qzuc=;
	b=O/d4fy7WBMLoXDz1UrRZN+H1syuiQCw47pFDd0P5JOV28thfZ1w9RQuueR1BfCz758QYZ/
	EEe/vYrlCTsBNcgxUsJo5bbtyEmO9lvFNQXhSfNOlhH+gwROQsKpQR2rruLaOXDu8lczlA
	7hNSuOXIu1WsNW9h0X/BreXXLxtPRec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723207744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xDH7jGw+Qug8RAycGpVLEM+D4LfpipX3IlH9p18Qzuc=;
	b=pyVe9woadI+oQg8znwGDPMt37eV3xk7yOXhd9acFZuxbdm8qndhIy2LDLIbqDHa28nOMnd
	NNkb2iwDYLYGjMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E5481379A;
	Fri,  9 Aug 2024 12:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mz3OCUAQtmbncwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Aug 2024 12:49:04 +0000
Date: Fri, 09 Aug 2024 14:49:43 +0200
Message-ID: <87ikw9n9nc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.11-rc3
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 59BA021F33
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.51

Linus,

please pull sound fixes for v6.11-rc3 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc3

The topmost commit is d3e82ced462b4ed956504b62603a11d52a599f99

----------------------------------------------------------------

sound fixes for 6.11-rc3

A collection of lots of small changes, almost all device-specific.

- A series of fixes for ASoC Qualcomm stuff
- Various fixes for Cirrus ASoC and HD-audio codecs
- A few AMD ASoC quirks and usual HD-audio quirks
- Other misc fixes, including a long-time regression in USB-audio

----------------------------------------------------------------

Bruno Ancona (1):
      ASoC: amd: yc: Support mic on HP 14-em0002la

Charles Keepax (5):
      ASoC: cs42l43: Remove redundant semi-colon at end of function
      ASoC: soc-component: Add new snd_soc_component_get_kcontrol() helpers
      ASoC: cs35l45: Use new snd_soc_component_get_kcontrol_locked() helper
      ASoC: cs42l43: Cache shutter IRQ control pointers
      MAINTAINERS: Update Cirrus Logic parts to linux-sound mailing list

Curtis Malainey (1):
      ASoC: SOF: Remove libraries from topology lookups

Dustin L. Howett (1):
      ALSA: hda/realtek: Add Framework Laptop 13 (Intel Core Ultra) to quirks

Francesco Dolcini (1):
      ASoC: nau8822: Lower debug print priority

Jerome Audu (1):
      ASoC: sti: add missing probe entry for player and reader

Jerome Brunet (1):
      ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT

Johan Hovold (1):
      ASoC: codecs: lpass-macro: fix missing codec version

Krzysztof Kozlowski (10):
      ASoC: codecs: wcd937x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wcd938x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wcd939x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wsa881x: Correct Soundwire ports mask
      ASoC: codecs: wsa883x: Correct Soundwire ports mask
      ASoC: codecs: wsa884x: Correct Soundwire ports mask
      ASoC: dt-bindings: qcom,wcd937x: Correct reset GPIO polarity in example
      ASoC: dt-bindings: qcom,wcd934x: Correct reset GPIO polarity in example
      ASoC: dt-bindings: qcom,wcd938x: Correct reset GPIO polarity in example
      ASoC: dt-bindings: qcom,wcd939x: Correct reset GPIO polarity in example

Krzysztof Stêpniak (1):
      ASoC: amd: yc: Support mic on Lenovo Thinkpad E14 Gen 6

Paul Handrigan (1):
      ASoC: cs530x: Change IN HPF Select kcontrol name

Richard Fitzgerald (2):
      ASoC: cs-amp-lib: Fix NULL pointer crash if efi.get_variable is NULL
      ASoC: cs35l56: Handle OTP read latency over SoundWire

Shengjiu Wang (2):
      ASoC: fsl_micfil: Expand the range of FIFO watermark mask
      ASoC: fsl_micfil: Differentiate register access permission for platforms

Simon Trimmer (4):
      ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coefficients
      ASoC: wm_adsp: Add control_add callback and export wm_adsp_control_add()
      ASoC: cs35l56: Stop creating ALSA controls for firmware coefficients
      ASoC: cs35l56: Patch CS35L56_IRQ1_MASK_18 to the default value

Stefan Binding (1):
      ALSA: hda: cs35l41: Stop creating ALSA Controls for firmware coefficients

Steven 'Steve' Kendall (1):
      ALSA: hda: Add HP MP9 G4 Retail System AMS to force connect list

Takashi Iwai (4):
      ALSA: line6: Fix racy access to midibuf
      ALSA: hda/hdmi: Yet more pin fix for HP EliteDesk 800 G4
      ALSA: usb-audio: Re-add ScratchAmp quirk entries
      ASoC: amd: yc: Add quirk entry for OMEN by HP Gaming Laptop 16-n0xxx

Zhang Yi (1):
      ASoC: codecs: ES8326: button detect issue

---
 .../devicetree/bindings/sound/qcom,wcd934x.yaml    |  3 +-
 .../devicetree/bindings/sound/qcom,wcd937x.yaml    |  2 +-
 .../devicetree/bindings/sound/qcom,wcd938x.yaml    |  3 +-
 .../devicetree/bindings/sound/qcom,wcd939x.yaml    |  4 +-
 MAINTAINERS                                        |  4 +-
 include/sound/cs35l56.h                            |  5 ++
 include/sound/soc-component.h                      |  5 ++
 sound/pci/hda/cs35l41_hda.c                        | 13 ----
 sound/pci/hda/cs35l56_hda.c                        | 38 +----------
 sound/pci/hda/cs35l56_hda.h                        |  1 -
 sound/pci/hda/patch_hdmi.c                         |  2 +
 sound/pci/hda/patch_realtek.c                      |  1 +
 sound/soc/amd/yc/acp6x-mach.c                      | 21 ++++++
 sound/soc/codecs/cs-amp-lib.c                      |  2 +-
 sound/soc/codecs/cs35l45.c                         | 11 +---
 sound/soc/codecs/cs35l56-sdw.c                     | 77 ++++++++++++++++++++++
 sound/soc/codecs/cs35l56-shared.c                  |  1 +
 sound/soc/codecs/cs35l56.c                         | 11 ++++
 sound/soc/codecs/cs42l43.c                         | 75 ++++++++++++++++-----
 sound/soc/codecs/cs42l43.h                         |  2 +
 sound/soc/codecs/cs530x.c                          |  8 +--
 sound/soc/codecs/es8326.c                          |  2 +
 sound/soc/codecs/lpass-va-macro.c                  |  2 +
 sound/soc/codecs/nau8822.c                         |  2 +-
 sound/soc/codecs/wcd937x-sdw.c                     |  4 +-
 sound/soc/codecs/wcd938x-sdw.c                     |  4 +-
 sound/soc/codecs/wcd939x-sdw.c                     |  4 +-
 sound/soc/codecs/wm_adsp.c                         | 17 ++++-
 sound/soc/codecs/wm_adsp.h                         |  3 +
 sound/soc/codecs/wsa881x.c                         |  2 +-
 sound/soc/codecs/wsa883x.c                         |  2 +-
 sound/soc/codecs/wsa884x.c                         |  2 +-
 sound/soc/fsl/fsl_micfil.c                         | 20 ++++--
 sound/soc/fsl/fsl_micfil.h                         |  2 +-
 sound/soc/meson/axg-fifo.c                         | 26 +++-----
 sound/soc/soc-component.c                          | 42 +++++++++---
 sound/soc/sof/mediatek/mt8195/mt8195.c             |  2 +-
 sound/soc/sti/sti_uniperif.c                       |  2 +-
 sound/soc/sti/uniperif.h                           |  1 +
 sound/soc/sti/uniperif_player.c                    |  1 +
 sound/soc/sti/uniperif_reader.c                    |  1 +
 sound/usb/line6/driver.c                           |  5 ++
 sound/usb/quirks-table.h                           |  4 ++
 43 files changed, 304 insertions(+), 135 deletions(-)


