Return-Path: <linux-kernel+bounces-425426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED49DC1E6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181F3163237
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100EC18A6AE;
	Fri, 29 Nov 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CQbcxcVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NkcmNbCh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CQbcxcVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NkcmNbCh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3CD15747D;
	Fri, 29 Nov 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874564; cv=none; b=a3KkrSNT2y/Coo0f7bZzUMDm1ahrqpOHZr/or9cGj+BRsQxS91JbqX6UUFnyHDD9OCEYuv/pAc0RNRFWwPnuI9M7K78Lw1dxayfRUXLpYRCc72h+TUN05ci3PlRftTUbwjYAZd20uQQhJ5+lhImHnMrNtyxNx55YUQdxyCDNCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874564; c=relaxed/simple;
	bh=q0LkgFJokAZerh74zTa4x9y7lBFvzoUNLgtWfBP24So=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=LZ84LenwPKgWOO+Q9px04sGyjHOhK/ueeTJNILA+U/qAr+N3gxmqmdpu2UfeTr+Xy/MuSB6M9pl8dMHdBCA3G6K9iJY8Zlyqtzza1MbXsOmSkt/DFiHbt1P6uGfRe5oxa1PLJ34PqfnbUrNJYXoyj+V3wqx49m5vDgKv2KqyzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CQbcxcVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NkcmNbCh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CQbcxcVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NkcmNbCh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53E861F390;
	Fri, 29 Nov 2024 10:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732874559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=anUGXR1AkUS9BU36gUjhtYbV9oPbfPDeIdYSyQcpuLI=;
	b=CQbcxcVWLUj/5ysP2xJ56T2ILyWJUcdVLhGWnmiZXSwjChxOQLpMHQwttkSE13OxlxFPwt
	OwpwaejdrT8r8tVJfrpv1Yy06ZfQ+S0K4151u7TMcSt1UQJEN3mF1dGC0EFs/iqLd3YlR3
	AhStvej1bDg4BgPu3Ctd4vVxvdLJzVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732874559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=anUGXR1AkUS9BU36gUjhtYbV9oPbfPDeIdYSyQcpuLI=;
	b=NkcmNbChDcyVwNNR9KZz+eXSGr8VpaJahSG6vHmyjpM8fC8bEYO9znhXjNqxaa4FZNk5N9
	7Kc3rggPc2tDWRAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CQbcxcVW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NkcmNbCh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732874559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=anUGXR1AkUS9BU36gUjhtYbV9oPbfPDeIdYSyQcpuLI=;
	b=CQbcxcVWLUj/5ysP2xJ56T2ILyWJUcdVLhGWnmiZXSwjChxOQLpMHQwttkSE13OxlxFPwt
	OwpwaejdrT8r8tVJfrpv1Yy06ZfQ+S0K4151u7TMcSt1UQJEN3mF1dGC0EFs/iqLd3YlR3
	AhStvej1bDg4BgPu3Ctd4vVxvdLJzVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732874559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=anUGXR1AkUS9BU36gUjhtYbV9oPbfPDeIdYSyQcpuLI=;
	b=NkcmNbChDcyVwNNR9KZz+eXSGr8VpaJahSG6vHmyjpM8fC8bEYO9znhXjNqxaa4FZNk5N9
	7Kc3rggPc2tDWRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AF73133F3;
	Fri, 29 Nov 2024 10:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zqM9CT+RSWdIXAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Nov 2024 10:02:39 +0000
Date: Fri, 29 Nov 2024 11:02:38 +0100
Message-ID: <87sera5pdt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.13-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53E861F390
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.13-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.13-rc1

The topmost commit is 2e5bf5b6d2617aff3bd6577bbc8e024cca436d76

----------------------------------------------------------------

sound fixes for 6.13-rc1

A collection of small fixes.  Majority of changes are device-specific
fixes and quirks, while there are a few core fixes to address
regressions and corner cases spotted by fuzzers.

- Fix of spinlock range that wrongly covered kvfree() call in rawmidi
- Fix potential NULL dereference at PCM mmap
- Fix incorrectly advertised MIDI 2.0 UMP Function Block info
- Various ASoC AMD quirks and fixes
- ASoC SOF Intel, Mediatek, HDMI-codec fixes
- A few more quirks and TAS2781 codec fix for HD-audio
- A couple of fixes for USB-audio for malicious USB descriptors

----------------------------------------------------------------

Alex Far (1):
      ASoC: amd: yc: fix internal mic on Redmi G 2022

Baojun Xu (1):
      ALSA: hda/tas2781: Add speaker id check for ASUS projects

Bard Liao (1):
      ASoC: SOF: ipc3-topology: Convert the topology pin index to ALH dai index

Benoît Sevens (1):
      ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices

Charles Han (1):
      ASoC: imx-audmix: Add NULL check in imx_audmix_probe

Dinesh Kumar (1):
      ALSA: hda/realtek: Fix Internal Speaker and Mic boost of Infinix Y4 Max

Dirk Su (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook X G1i

Hridesh MG (1):
      ALSA: docs: fix dead hyperlink to Intel HD-Audio spec

Ilya Zverev (1):
      ASoC: amd: yc: Add a quirk for microfone on Lenovo ThinkPad P14s Gen 5 21MES00B00

Jaroslav Kysela (1):
      ALSA: hda: improve bass speaker support for ASUS Zenbook UM5606WA

Kailang Yang (4):
      ALSA: hda/realtek: Update ALC256 depop procedure
      ALSA: hda/realtek: Enable speaker pins for Medion E15443 platform
      ALSA: hda/realtek: Update ALC225 depop procedure
      ALSA: hda/realtek: Set PCBeep to default value for ALC274

Li Zhijian (1):
      selftests/alsa: Add a few missing gitignore files

Mario Limonciello (1):
      ASoC: amd: Fix build dependencies for `SND_SOC_AMD_PS`

Nícolas F. R. A. Prado (1):
      ASoC: mediatek: Check num_codecs is not zero to avoid panic during probe

Pei Xiao (1):
      ALSA: ac97: bus: Fix the mistake in the comment

Takashi Iwai (6):
      ALSA: pcm: Add sanity NULL check for the default mmap fault handler
      ALSA: rawmidi: Fix kvfree() call in spinlock
      ALSA: usb-audio: Fix out of bounds reads when finding clock sources
      ALSA: hda: Show the codec quirk info at probing
      ALSA: ump: Fix evaluation of MIDI 1.0 FB info
      ALSA: hda/realtek: Apply quirk for Medion E15433

Uwe Kleine-König (1):
      ASoC: amd: yc: Add quirk for microphone on Lenovo Thinkpad T14s Gen 6 21M1CTO1WW

Venkata Prasad Potturu (1):
      ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD entry

Zhu Jun (1):
      ALSA: asihpi: Remove unused variable

Zichen Xie (1):
      ALSA: core: Fix possible NULL dereference caused by kunit_kzalloc()

anish kumar (1):
      ASoC: doc: dapm: Add location information for dapm-graph tool

liujing (1):
      ASoC: apple: Fix the wrong format specifier

---
 Documentation/sound/hd-audio/notes.rst             |   2 +-
 Documentation/sound/soc/dapm.rst                   |   3 +
 include/sound/tas2781.h                            |   1 +
 sound/ac97/bus.c                                   |   5 +-
 sound/core/pcm_native.c                            |   6 +-
 sound/core/rawmidi.c                               |   4 +-
 sound/core/sound_kunit.c                           |  11 ++
 sound/core/ump.c                                   |   5 +-
 sound/pci/asihpi/asihpi.c                          |   2 +-
 sound/pci/hda/hda_auto_parser.c                    |  20 +--
 sound/pci/hda/patch_realtek.c                      | 169 ++++++++++++---------
 sound/pci/hda/tas2781_hda_i2c.c                    |  63 +++++++-
 sound/soc/amd/Kconfig                              |   1 +
 sound/soc/amd/yc/acp6x-mach.c                      |  39 ++++-
 sound/soc/apple/mca.c                              |   2 +-
 sound/soc/fsl/imx-audmix.c                         |   3 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |   9 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |   4 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c          |   9 +-
 sound/soc/sof/ipc3-topology.c                      |  26 +++-
 sound/usb/clock.c                                  |  24 ++-
 sound/usb/quirks.c                                 |  27 +++-
 tools/testing/selftests/alsa/.gitignore            |   2 +
 23 files changed, 328 insertions(+), 109 deletions(-)


