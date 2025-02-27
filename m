Return-Path: <linux-kernel+bounces-536847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DA5A484E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C74F3A9F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10651B3957;
	Thu, 27 Feb 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vGxpn2Lz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rL3B9CE0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vGxpn2Lz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rL3B9CE0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0D1B042D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673356; cv=none; b=ClYZvZPyRNBGYPF5utzs/cHjSR4ueX8lACBkVzUoKyouchbISgBZFtxLJn0rWWidbdFFrblPgA4k9V+Qd8gj62aimKdIN7cF4rufzFNBbbJCFTPXEVqAqQW+LluExeDwy8jfBok8w26NLXk2Vrtk00sNZC13yfG3H+JRZKyDg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673356; c=relaxed/simple;
	bh=EJQswW+uV50ipsNAKIS0BlM7xVZL9rml7ToPuMbP644=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=nXGuLtdp/SNG6tPQ7CElHwA1MsZIHnR+/IiJU5J61tVtmUci7jpF304Sed/xzHE5IVQriv9C+WTEcOWbkIZMXxHGTTlBJXmd9ikp2A1wxiNL//lthkubKMxhgDj/UN+zvAOWxiM+YG1W7bC2EGUHC87JckrsawbAe8S3xpA8meE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vGxpn2Lz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rL3B9CE0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vGxpn2Lz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rL3B9CE0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5633D1F38A;
	Thu, 27 Feb 2025 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740673353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7V56fokguSA/WYKJDRk2Eox6EGfnPhEQzwOcUhOq7IY=;
	b=vGxpn2Lzk2RYRmUIjN/e8KtPfMf11jBw0/VCsvf3t2A4h/vyFR3ml6WUhuN3GWV3s/n147
	C4LZS9yUSXFMl2ucKloJc0qk960mR739w2a3wJVGKFmnNc0mbLDwIbpDvql/Lyg97GU4Uk
	ed9U+0SIPRvSyTr1r9ScYHHSZY1IHhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740673353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7V56fokguSA/WYKJDRk2Eox6EGfnPhEQzwOcUhOq7IY=;
	b=rL3B9CE0bUGINuE4+uJlPCYnz0p2RflPn4pKDaDjQ/MUgUmV+sHfdEbPrCEP8z8/R+PpU4
	bHaIdF6CzFhNIDBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740673353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7V56fokguSA/WYKJDRk2Eox6EGfnPhEQzwOcUhOq7IY=;
	b=vGxpn2Lzk2RYRmUIjN/e8KtPfMf11jBw0/VCsvf3t2A4h/vyFR3ml6WUhuN3GWV3s/n147
	C4LZS9yUSXFMl2ucKloJc0qk960mR739w2a3wJVGKFmnNc0mbLDwIbpDvql/Lyg97GU4Uk
	ed9U+0SIPRvSyTr1r9ScYHHSZY1IHhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740673353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7V56fokguSA/WYKJDRk2Eox6EGfnPhEQzwOcUhOq7IY=;
	b=rL3B9CE0bUGINuE4+uJlPCYnz0p2RflPn4pKDaDjQ/MUgUmV+sHfdEbPrCEP8z8/R+PpU4
	bHaIdF6CzFhNIDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EB551376A;
	Thu, 27 Feb 2025 16:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l+DkBUmRwGdZHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 27 Feb 2025 16:22:33 +0000
Date: Thu, 27 Feb 2025 17:22:32 +0100
Message-ID: <87mse75pdj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.14-rc5
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.14-rc5 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc5

The topmost commit is fe1544deda605f6100cbff1d5aeb179c3aa1515c

----------------------------------------------------------------

sound fixes for 6.14-rc5

A collection of fixes.  The only slightly large change is for ASoC
Cirrus codec, but that's still in a normal range.
All the rest are small device-specific fixes and should be fairly
safe to take.

----------------------------------------------------------------

Adrien Vergé (1):
      ALSA: hda/realtek: Fix microphone regression on ASUS N705UD

Bard Liao (2):
      ASoC: SOF: Intel: don't check number of sdw links when set dmic_fixup
      ASoC: Intel: sof_sdw: warn both sdw and pch dmic are used

Chancel Liu (1):
      ASoC: fsl: Rename stream name of SAI DAI driver

Dmitry Panchenko (1):
      ALSA: usb-audio: Re-add sample rate quirk for Pioneer DJM-900NXS2

Hector Martin (3):
      ASoC: tas2770: Fix volume scale
      ASoC: tas2764: Fix power control mask
      ASoC: tas2764: Set the SDOUT polarity correctly

Nicolas Frattaroli (2):
      ASoC: es8328: fix route from DAC to output
      ASoC: dapm-graph: set fill colour of turned on nodes

Richard Fitzgerald (2):
      firmware: cs_dsp: Remove async regmap writes
      ASoC: cs35l56: Prevent races when soft-resetting using SPI control

Takashi Iwai (2):
      ALSA: usb-audio: Avoid dropping MIDI events at closing multiple ports
      ALSA: hda/realtek: Fix wrong mic setup for ASUS VivoBook 15

---
 drivers/firmware/cirrus/cs_dsp.c  | 24 +++---------
 include/sound/cs35l56.h           | 31 +++++++++++++++
 sound/pci/hda/cs35l56_hda_spi.c   |  3 ++
 sound/pci/hda/patch_realtek.c     |  2 +-
 sound/soc/codecs/cs35l56-shared.c | 80 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56-spi.c    |  3 ++
 sound/soc/codecs/es8328.c         | 15 ++------
 sound/soc/codecs/tas2764.c        | 10 ++++-
 sound/soc/codecs/tas2764.h        |  8 +++-
 sound/soc/codecs/tas2770.c        |  2 +-
 sound/soc/fsl/fsl_sai.c           |  6 +--
 sound/soc/fsl/imx-audmix.c        |  4 +-
 sound/soc/intel/boards/sof_sdw.c  |  7 ++++
 sound/soc/sof/intel/hda.c         | 18 +--------
 sound/usb/midi.c                  |  2 +-
 sound/usb/quirks.c                |  1 +
 tools/sound/dapm-graph            |  2 +-
 17 files changed, 162 insertions(+), 56 deletions(-)


