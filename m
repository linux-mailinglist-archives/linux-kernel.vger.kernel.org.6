Return-Path: <linux-kernel+bounces-381276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575459AFCE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F2428336C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E841D2234;
	Fri, 25 Oct 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ifh0aOab";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wgIvr9QC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ifh0aOab";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wgIvr9QC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6701BA89B;
	Fri, 25 Oct 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845849; cv=none; b=pT56cBeVzk+AnrNt8/jh4mnF5P4NnvQbANYkt9vEfzOstFW6lAR+Vd5iSM8pwM+EbyKrMLS5g2CcxwKp3p2p5lxbvi6PGVffUwfMtbAEltpbMRmfmQqx+Ah91awoSsZqNcMC6FcbR7og76EpXlBKZ+VWh/7p75usWPv+zBERbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845849; c=relaxed/simple;
	bh=6sym0Z3+jhw6V3tTOEsO2KNBvwo4u4Vlc1SXEoFTKqQ=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=ua2Iyx7AjS7HOr2vLARZJtNnIwklMaPQ4zLI/vdCSWMcrqPFCCPtTIb6dZC8J0eWRK6uBbJut94UgRhkK16pRy3QpwuYUMBQ6nP146JTpyTkHuRi4uu/dSh5sKa9wjciUCpcsxWCSiCkCcqVMcPKSjpQgG9X+30BSeucVSgwBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ifh0aOab; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wgIvr9QC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ifh0aOab; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wgIvr9QC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C46DF1F79D;
	Fri, 25 Oct 2024 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729845844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Po8dSFEhLasSM8h9X0R59J9hvW9Nk4L9IvjRSuc6Ru8=;
	b=Ifh0aOabU94RtXW8D6pPI/b68t6sqEcaFjGYI3UbXG6NbdvK2HWENceGcu2xYS1M1fyhEe
	rUtea1t90xUaz3tXBEra3cHjd0w6cibz8b8bVoaF9WdhDJ/UL9Qebgeozoy2ZBcMebHQd6
	PIt3CBfvpTKWFY+EKcM4LQpw6/GtXRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729845844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Po8dSFEhLasSM8h9X0R59J9hvW9Nk4L9IvjRSuc6Ru8=;
	b=wgIvr9QC22KNitPdUibVlTaeU2tpulePFkIg1h1EtrXo8FkoKacVTj4gf+4dapAS9Dv1h0
	7NmRFG+WPvZ8WoDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729845844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Po8dSFEhLasSM8h9X0R59J9hvW9Nk4L9IvjRSuc6Ru8=;
	b=Ifh0aOabU94RtXW8D6pPI/b68t6sqEcaFjGYI3UbXG6NbdvK2HWENceGcu2xYS1M1fyhEe
	rUtea1t90xUaz3tXBEra3cHjd0w6cibz8b8bVoaF9WdhDJ/UL9Qebgeozoy2ZBcMebHQd6
	PIt3CBfvpTKWFY+EKcM4LQpw6/GtXRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729845844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Po8dSFEhLasSM8h9X0R59J9hvW9Nk4L9IvjRSuc6Ru8=;
	b=wgIvr9QC22KNitPdUibVlTaeU2tpulePFkIg1h1EtrXo8FkoKacVTj4gf+4dapAS9Dv1h0
	7NmRFG+WPvZ8WoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 983F513B18;
	Fri, 25 Oct 2024 08:44:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +fS8I1RaG2eNZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 25 Oct 2024 08:44:04 +0000
Date: Fri, 25 Oct 2024 10:45:05 +0200
Message-ID: <87bjz8tvu6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.12-rc5
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.12-rc5 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc5

The topmost commit is c9f7a144e7e3effd49303bfc58c07cc10ab2d573

----------------------------------------------------------------

sound fixes for 6.12-rc5

The majority of changes here are about ASoC.

There are two core changes in ASoC (the bump of minimal topology
ABI version and the fix for references of components in DAPM code),
and others are mostly various device-specific fixes for SoundWire,
AMD, Intel, SOF, Qualcomm and FSL, in addition to a few usual
HD-audio quirks and fixes.

----------------------------------------------------------------

Alexey Klimov (2):
      ASoC: qcom: sdm845: add missing soundwire runtime stream alloc
      ASoC: codecs: lpass-rx-macro: fix RXn(rx,n) macro for DSM_CTL and SEC7 regs

Amadeusz S³awiñski (2):
      ASoC: Intel: avs: Update stream status in a separate thread
      ASoC: topology: Bump minimal topology ABI version

Andrei Simion (1):
      MAINTAINERS: Update maintainer list for MICROCHIP ASOC, SSC and MCP16502 drivers

Andrey Shumilin (1):
      ALSA: firewire-lib: Avoid division by zero in apply_constraint_to_size()

Benjamin Bara (1):
      ASoC: dapm: avoid container_of() to get component

Binbin Zhou (1):
      ASoC: loongson: Fix component check failed on FDT systems

Chancel Liu (1):
      ASoC: fsl_micfil: Add a flag to distinguish with different volume control types

Christian Heusel (1):
      ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA

Colin Ian King (1):
      ASoC: max98388: Fix missing increment of variable slot_found

Derek Fang (1):
      ASoC: Intel: soc-acpi: lnl: Add match entry for TM2 laptops

Eric Biggers (1):
      ALSA: hda/tas2781: select CRC32 instead of CRC32_SARWATE

Ilya Dudikov (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA

Jack Yu (1):
      ASoC: rt722-sdca: increase clk_stop_timeout to fix clock stop issue

José Relvas (1):
      ALSA: hda/realtek: Add subwoofer quirk for Acer Predator G9-593

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda-loader: do not wait for HDaudio IOC

Kailang Yang (1):
      ALSA: hda/realtek: Update default depop procedure

Kirill Marinushkin (1):
      ASoC: Change my e-mail to gmail

Krzysztof Kozlowski (2):
      ASoC: qcom: Select missing common Soundwire module code on SDM845
      ASoC: qcom: sc7280: Fix missing Soundwire runtime stream alloc

Lad Prabhakar (1):
      ASoC: rsnd: Fix probe failure on HiHope boards due to endpoint parsing

Miquel Raynal (1):
      ASoC: dt-bindings: davinci-mcasp: Fix interrupt properties

Ranjani Sridharan (4):
      ASoC: SOF: ipc4-topology: Do not set ALH node_id for aggregated DAIs
      ASoC: SOF: Intel: hda: Handle prepare without close for non-HDA DAI's
      soundwire: intel_ace2x: Send PDI stream number during prepare
      ASoC: SOF: Intel: hda: Always clean up link DMA during stop

Shengjiu Wang (2):
      ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
      ASoC: fsl_micfil: Add sample rate constraint

Venkata Prasad Potturu (2):
      ASoC: SOF: amd: Add error log for DSP firmware validation failure
      ASoC: SOF: amd: Fix for ACP SRAM addr for acp7.0 platform

Zhu Jun (1):
      ASoC: codecs: Fix error handling in aw_dev_get_dsp_status function

Zichen Xie (1):
      ASoC: qcom: Fix NULL Dereference in asoc_qcom_lpass_cpu_platform_probe()

---
 .../bindings/sound/davinci-mcasp-audio.yaml        | 18 ++---
 MAINTAINERS                                        |  5 +-
 drivers/soundwire/intel_ace2x.c                    | 19 ++---
 include/uapi/sound/asoc.h                          |  2 +-
 sound/firewire/amdtp-stream.c                      |  3 +
 sound/pci/hda/Kconfig                              |  2 +-
 sound/pci/hda/patch_realtek.c                      | 48 +++++++------
 sound/soc/amd/yc/acp6x-mach.c                      | 14 ++++
 sound/soc/codecs/aw88399.c                         |  2 +-
 sound/soc/codecs/lpass-rx-macro.c                  | 15 ++--
 sound/soc/codecs/max98388.c                        |  1 +
 sound/soc/codecs/pcm3060-i2c.c                     |  4 +-
 sound/soc/codecs/pcm3060-spi.c                     |  4 +-
 sound/soc/codecs/pcm3060.c                         |  4 +-
 sound/soc/codecs/pcm3060.h                         |  2 +-
 sound/soc/codecs/rt722-sdca-sdw.c                  |  2 +-
 sound/soc/fsl/fsl_esai.c                           |  4 +-
 sound/soc/fsl/fsl_micfil.c                         | 81 +++++++++++++++++++++-
 sound/soc/intel/avs/core.c                         |  3 +-
 sound/soc/intel/avs/pcm.c                          | 19 +++++
 sound/soc/intel/avs/pcm.h                          | 16 +++++
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  | 38 ++++++++++
 sound/soc/loongson/loongson_card.c                 |  1 +
 sound/soc/qcom/Kconfig                             |  2 +
 sound/soc/qcom/lpass-cpu.c                         |  2 +
 sound/soc/qcom/sc7280.c                            | 10 ++-
 sound/soc/qcom/sdm845.c                            |  7 +-
 sound/soc/sh/rcar/core.c                           |  7 +-
 sound/soc/soc-dapm.c                               |  4 +-
 sound/soc/sof/amd/acp-loader.c                     |  5 +-
 sound/soc/sof/amd/acp.c                            |  4 +-
 sound/soc/sof/intel/hda-dai-ops.c                  | 23 +++---
 sound/soc/sof/intel/hda-dai.c                      | 37 ++++++++--
 sound/soc/sof/intel/hda-loader.c                   | 17 -----
 sound/soc/sof/ipc4-topology.c                      | 15 +++-
 35 files changed, 329 insertions(+), 111 deletions(-)
 create mode 100644 sound/soc/intel/avs/pcm.h


