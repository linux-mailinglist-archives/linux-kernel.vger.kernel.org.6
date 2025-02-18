Return-Path: <linux-kernel+bounces-519286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4804A39B09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0186189442E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2259D23F260;
	Tue, 18 Feb 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bbWJk+Ik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MhAwsvC3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bbWJk+Ik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MhAwsvC3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788CE1AA78E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878310; cv=none; b=hDNp1kh6UAX0nbk01cQ6Ss+bwYmrZgtthOpj8Y8ol8EvCbVo1/btwO5ExbLbSMAxOYaAc0Pzu5Rp3I4dPS5S5GowXmUIMTK32frMVUEEEHoOInCUN57S2YOd0IAtvLktlhoydJ7JQhgUHR25/jiYziK4pq4XzAOFkfrWzwoKI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878310; c=relaxed/simple;
	bh=c9kDDkRSwo3NwDUYJsOqjCYZWHbmZ8OAUMYaM2jKYE4=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=BsC4LrksDMgnoMrk+5WLzjjlUz5PxhLS0kv9GzH96xJVdlkPRCHikUL6EH8ISL3arrH1Xp1IRsqItr6SBRrJrhTikyCCUoiNQTxcsAkE63+M416FVDTqtRyhAP5c4GppoyO1sz1WpzzQPvfNOVjMpzSyUBKSVkWPQXvHinFbY3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bbWJk+Ik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MhAwsvC3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bbWJk+Ik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MhAwsvC3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71C2121164;
	Tue, 18 Feb 2025 11:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739878306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=c5fF7JpvJH2DLgRsuojPxlvr2gmpS/fg7TGIXVKHJAc=;
	b=bbWJk+IkxZJ9JxM+wW2LLPgO3W4dMjVB2C5AOlZXcmrm7UZdjg8HApkoKV+MKx+kPB1IJS
	FglEp9tehsfDBrz5h13z2lSQkRMgl/Ll9uZ7oe6edOumoilgFyRPfcdDw60oNNMV/DDofp
	naDFbEPyXrq+IDEW6vY4I+9V6PHkJbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739878306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=c5fF7JpvJH2DLgRsuojPxlvr2gmpS/fg7TGIXVKHJAc=;
	b=MhAwsvC33lewKxHgMN85FzhRdQ1XEZ6b3g3PaVuJAXjtIaN4z+AHqbli5TJ1AYgzNuJSCD
	0GGyG7qpLN8Uc6Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739878306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=c5fF7JpvJH2DLgRsuojPxlvr2gmpS/fg7TGIXVKHJAc=;
	b=bbWJk+IkxZJ9JxM+wW2LLPgO3W4dMjVB2C5AOlZXcmrm7UZdjg8HApkoKV+MKx+kPB1IJS
	FglEp9tehsfDBrz5h13z2lSQkRMgl/Ll9uZ7oe6edOumoilgFyRPfcdDw60oNNMV/DDofp
	naDFbEPyXrq+IDEW6vY4I+9V6PHkJbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739878306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=c5fF7JpvJH2DLgRsuojPxlvr2gmpS/fg7TGIXVKHJAc=;
	b=MhAwsvC33lewKxHgMN85FzhRdQ1XEZ6b3g3PaVuJAXjtIaN4z+AHqbli5TJ1AYgzNuJSCD
	0GGyG7qpLN8Uc6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AEB613A1D;
	Tue, 18 Feb 2025 11:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9YC2OqFvtGf3IAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Feb 2025 11:31:45 +0000
Date: Tue, 18 Feb 2025 12:31:45 +0100
Message-ID: <87jz9n5w0u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.14-rc4
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

please pull sound fixes for v6.14-rc4 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc4

The topmost commit is e77aa4b2eaa7fb31b2a7a50214ecb946b2a8b0f6

----------------------------------------------------------------

sound fixes for 6.14-rc4

A slightly large collection of fixes, spread over various drivers.
Almost all are small and device-specific fixes and quirks in ASoC
SOF Intel and AMD, Renesas, Cirrus, HD-audio, in addition to a small
fix for MIDI 2.0.

----------------------------------------------------------------

Baojun Xu (2):
      ALSA: hda/tas2781: Update tas2781 hda SPI driver
      ALSA: hda/tas2781: Fix index issue in tas2781 hda SPI driver

Bard Liao (2):
      ASoC: Intel: soc-acpi-intel-tgl-match: declare adr as ull
      ASoC: Intel: soc-acpi-intel-mtl-match: declare adr as ull

Cristian Ciocaltea (4):
      ASoC: SOF: amd: Add post_fw_run_delay ACP quirk
      ASoC: SOF: amd: Drop unused includes from Vangogh driver
      ASoC: SOF: amd: Handle IPC replies before FW_BOOT_COMPLETE
      ASoC: SOF: amd: Add branch prediction hint in ACP IRQ handler

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on Positivo ARN50

John Keeping (1):
      ASoC: rockchip: i2s-tdm: fix shift config for SND_SOC_DAIFMT_DSP_[AB]

John Veness (1):
      ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute LED

Kailang Yang (1):
      ALSA: hda/realtek: Fixup ALC225 depop procedure

Kuninori Morimoto (4):
      ASoC: simple-card-utils.c: add missing dlc->of_node
      ASoC: rsnd: indicate unsupported clock rate
      ASoC: rsnd: don't indicate warning on rsnd_kctrl_accept_runtime()
      ASoC: rsnd: adjust convert rate limitation

Nam Cao (1):
      ALSA: Switch to use hrtimer_setup()

Nikita Zhandarovich (1):
      ASoC: fsl_micfil: Enable default case in micfil_set_quality()

Peter Ujfalusi (6):
      ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
      ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
      ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers
      ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
      ASoC: Intel: soc-acpi-intel-ptl-match: revise typo of rt712_vb + rt1320 support
      ASoC: Intel: soc-acpi-intel-ptl-match: revise typo of rt713_vb_l2_rt1320_l13

Pierre-Louis Bossart (3):
      PCI: pci_ids: add INTEL_HDA_PTL_H
      ALSA: hda: intel-dsp-config: Add PTL-H support
      ALSA: hda: hda-intel: add Panther Lake-H support

Richard Fitzgerald (2):
      ASoC: Intel: sof_sdw: Add lookup of quirk using PCI subsystem ID
      ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S14

Shenghao Ding (1):
      ASoC: tas2781: drop a redundant code

Shengjiu Wang (1):
      ASoC: imx-audmix: remove cpu_mclk which is from cpu dai device

Stefan Binding (2):
      ASoC: cs35l41: Fallback to using HID for system_name if no SUB is available
      ASoC: cs35l41: Fix acpi_device_hid() not found

Stefano Garzarella (1):
      virtio_snd.h: clarify that `controls` depends on VIRTIO_SND_F_CTLS

Takashi Iwai (1):
      ALSA: seq: Drop UMP events when no UMP-conversion is set

Terry Cheong (1):
      ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module

Uday M Bhat (1):
      ASoC: Intel: sof_sdw: Add support for Fatcat board with BT offload enabled in PTL platform

Vitaly Rodionov (3):
      ASoC: arizona/madera: use fsleep() in up/down DAPM event delays.
      ALSA: hda/cirrus: Correct the full scale volume set logic
      ALSA: hda/cirrus: Reduce codec resume time

Wentao Liang (1):
      ALSA: hda: Add error check for snd_ctl_rename_id() in snd_hda_create_dig_out_ctls()

---
 include/linux/pci_ids.h                           |   1 +
 include/uapi/linux/virtio_snd.h                   |   2 +-
 sound/core/hrtimer.c                              |   3 +-
 sound/core/seq/seq_clientmgr.c                    |  12 ++-
 sound/drivers/dummy.c                             |   3 +-
 sound/drivers/pcsp/pcsp.c                         |   3 +-
 sound/hda/intel-dsp-config.c                      |   5 +
 sound/pci/hda/hda_codec.c                         |   4 +-
 sound/pci/hda/hda_intel.c                         |   2 +
 sound/pci/hda/patch_conexant.c                    |   1 +
 sound/pci/hda/patch_cs8409-tables.c               |  12 +--
 sound/pci/hda/patch_cs8409.c                      |  26 +++--
 sound/pci/hda/patch_cs8409.h                      |   7 +-
 sound/pci/hda/patch_realtek.c                     |   2 +
 sound/pci/hda/tas2781_hda_spi.c                   |  27 ++---
 sound/pci/hda/tas2781_spi_fwlib.c                 |  10 +-
 sound/sh/sh_dac_audio.c                           |   3 +-
 sound/soc/codecs/arizona.c                        |  14 +--
 sound/soc/codecs/cs35l41.c                        |  30 ++++--
 sound/soc/codecs/madera.c                         |  10 +-
 sound/soc/codecs/tas2781-i2c.c                    |   4 +-
 sound/soc/codecs/wm5110.c                         |   8 +-
 sound/soc/fsl/fsl_micfil.c                        |   2 +
 sound/soc/fsl/imx-audmix.c                        |  31 ------
 sound/soc/generic/simple-card-utils.c             |   1 +
 sound/soc/intel/boards/sof_sdw.c                  |  41 ++++++--
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c |   2 +-
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c |  12 +--
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c |  16 +--
 sound/soc/renesas/rcar/core.c                     |  14 ---
 sound/soc/renesas/rcar/rsnd.h                     |   1 -
 sound/soc/renesas/rcar/src.c                      | 116 +++++++++++++++++-----
 sound/soc/renesas/rcar/ssi.c                      |   3 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c             |   4 +-
 sound/soc/sof/amd/acp-ipc.c                       |  25 +++--
 sound/soc/sof/amd/acp.c                           |   1 +
 sound/soc/sof/amd/acp.h                           |   1 +
 sound/soc/sof/amd/pci-vangogh.c                   |   2 -
 sound/soc/sof/amd/vangogh.c                       |  22 +++-
 sound/soc/sof/intel/hda-codec.c                   |   1 +
 sound/soc/sof/intel/pci-ptl.c                     |   1 +
 sound/soc/sof/ipc4-topology.c                     |  12 ++-
 sound/soc/sof/pcm.c                               |   2 +
 sound/soc/sof/stream-ipc.c                        |   6 +-
 44 files changed, 319 insertions(+), 186 deletions(-)


