Return-Path: <linux-kernel+bounces-416885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FB9D4C07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15B5280DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4B1CB316;
	Thu, 21 Nov 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CxB1BNRz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lzCuoM7l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HcTt61KE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HzujP5to"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6951D2F48;
	Thu, 21 Nov 2024 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188841; cv=none; b=QJMsMTl3fmz1PicNYTyTnC7IBSIWX53RNwpzEcQpgpFBRLt+teVAC9mixPI5cj0BM4Owj3imw4Rrab6vbUau3Voy+eYy7VJerOnPCt62SXpuz8aQnX36gFER3pDZGDgh/Wf0of55NmrswBAMq9RVxc9hZidMuj1JBQSAOKV2tQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188841; c=relaxed/simple;
	bh=41SgpszonwSkXbeLHRj/Putqo2Rjt/GA825K4W8TJrg=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=lCdf2f95BrBueSDY7I4HAJl29PAQDSJHug9RPnp16H7ecS26ej5Gv1TdHSKomBhTY9yIuia7vpfnfdcSv96b2VPR661uwSv03cIeU2NrVZmPMRCqppYDddtGVeH1s7DyTvW7tvk0DRClHohFFHLGmFVwdd48kLjLlFbbzfgZaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CxB1BNRz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lzCuoM7l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HcTt61KE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HzujP5to; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78DF11F7F9;
	Thu, 21 Nov 2024 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732188836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b2eG7mTlKY8ybRzJUlXV7f+pJ7nAqVwI7ZieiWVHm0I=;
	b=CxB1BNRzsft6LP8ZXSD685eorcFjfyQy3QsTfY+mQZHJ/aE55CilvI6A6pZ64XgifnAZxw
	cvjQ6ezxUix17V1MKgdKRWFudGg/g7tVOYVfl1ee6jyWoQkhGbAJcrEafKM/VHHRkwPfZm
	uJtdolIsZqK//D3TAk3QCv3TmEUeAtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732188836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b2eG7mTlKY8ybRzJUlXV7f+pJ7nAqVwI7ZieiWVHm0I=;
	b=lzCuoM7lZMGjZrRgIVp13ndN50cldqUMaFv9YD8qDyncvSPs6HeFT6u8c2hLDLJL/SfUGT
	1CUS3kdIR4t+HPAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732188835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b2eG7mTlKY8ybRzJUlXV7f+pJ7nAqVwI7ZieiWVHm0I=;
	b=HcTt61KE/prvRz24hOi2w1OkiUXvr/3dw3RJQdrno7+ZE/SZa+qTpr81bRVKLvPk9zbtw7
	giuVgsViL34wfHoMmtaFz9yf7XYd2kAIFq5/nk2HmVUZhdKGCLPgG0+erCbIkwNRcPZDrB
	oVt7hDfkh6bM9Y2PQdtKsRfF9bfnskY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732188835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b2eG7mTlKY8ybRzJUlXV7f+pJ7nAqVwI7ZieiWVHm0I=;
	b=HzujP5toOZHBO5EUDP5qP0P55AId66VL6icZCFlTaHAlD6YFxPegVWO8qC/oB5FGukma3z
	8/YKJZhWNOgr2yCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46F3F13A7D;
	Thu, 21 Nov 2024 11:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7pbLD6MaP2dLBAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 21 Nov 2024 11:33:55 +0000
Date: Thu, 21 Nov 2024 12:33:54 +0100
Message-ID: <87iksg3jod.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates for 6.13-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
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
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

please pull sound updates for v6.13-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc1

The topmost commit is e3f8064d8b29036f037fd1ff6000e5d959d84843

----------------------------------------------------------------

sound updates for 6.13-rc1

This is a relatively calm cycle, and majority of changes are about
ASoC.  There are little changes in the core side but we received
lots of new drivers for new vendors.

* ALSA Core:
- The new accel operation mode for compress-offload API;
  only the core part, and the actual user will follow at next

* ASoC:
- Continued API simplification works
- Renaming of the sh directory to Renesas
- Factoring out of some of the common code for Realtek devices
- Ussal ASoC Intel SOF, AMD and SoundWire updates
- Support for Allwinner H616, AMD ACP 6.3 systems, AWInic AW88081,
  Cirrus Logic CS32L84, Everest ES8328, Iron Devices SMA1307,
  Longsoon I2S, NeoFidelity NTP8918 and NTP8835, Philips UDA1342,
  Qualcomm SM8750, RealTek RT721, and ST Microelectronics STM32MP25

* HD- and USB-audio:
- Clean up of IRQ handling in legacy HD-audio driver
- Fix soft lockup at disconnection of non-standard USB drivers
- Scarlett2 mixer improvements
- New quirks and cleanups in HD- and USB-audio

----------------------------------------------------------------

Advait Dhamorikar (1):
      ASoC: tlv320adc3xxx: Fix unsigned int compared against 0

Alexey Klimov (1):
      ASoC: qcom: sm8250: add handling of secondary MI2S clock

Amadeusz S³awiñski (3):
      ASoC: Intel: Remove unused code
      ASoC: Intel: avs: Fix return status of avs_pcm_hw_constraints_init()
      ALSA: hda: Fix all stream interrupts definition

Andy Shevchenko (1):
      ASoC: codecs: wcd937x: Remove unused of_gpio.h

Anne Onciulescu (1):
      ASoC: SOF: sof-of-dev: add parameter to override tplg/fw_filename

Arnd Bergmann (3):
      ASoC: loongson: make loongson-i2s.o a separate module
      ASoC: cs42l84: remove incorrect of_match_ptr()
      ASoC: sma1307: fix uninitialized variable refence

Bagas Sanjaya (2):
      ALSA: docs: compress-accel: Format state machine flowchart as code block
      ALSA: docs: Add toctree index entry for co-processor acceleration API

Balamurugan C (1):
      ASoC: Intel: sof_rt5682: Add HDMI-In capture with rt5682 support for MTL.

Bard Liao (6):
      soundwire: sdw_intel: include linux/acpi.h
      ASoC: rt-sdw-common: fix rt_sdca_index_update_bits function parameter description
      ASoC: Intel: Kconfig: make SND_SOC_ACPI_INTEL_MATCH depend on ACPI
      ASoC: Intel: Kconfig: select SND_SOC_SDCA by SND_SOC_ACPI_INTEL_SDCA_QUIRKS
      ASoC: sdca: test adev before calling acpi_dev_for_each_child
      ASoC: Intel: soc-acpi-intel-lnl-match: add rt712_vb + rt1320 support

Biju Das (1):
      ASoC: sh: rz-ssi: Use SSIFCR_FIFO_RST macro

Binbin Zhou (7):
      ASoC: dt-bindings: Add Everest ES8323 Codec
      ASoC: codecs: Add support for ES8323
      ASoC: dt-bindings: Add NXP uda1342 Codec
      ASoC: codecs: Add uda1342 codec driver
      ASoC: dt-bindings: Add Loongson I2S controller
      ASoC: loongson: Add I2S controller driver as platform device
      ASoC: loongson: Fix build warning when !CONFIG_PCI

Chancel Liu (2):
      ASoC: imx-card: Set mclk for codec
      ASoC: imx-card: Add CS42888 support

Charles Keepax (4):
      ASoC: sdw_utils: Add support for exclusion DAI quirks
      ASoC: sdw_utils: Add a quirk to allow the cs42l43 mic DAI to be ignored
      ASoC: Intel: sof_sdw: Add quirk for cs42l43 system using host DMICs
      ASoC: Intel: sof_sdw: Add quirks for some new Lenovo laptops

Claudiu Beznea (3):
      ASoC: da7213: Populate max_register to regmap_config
      ASoC: da7213: Return directly the value of regcache_sync()
      ASoC: da7213: Add suspend to RAM support

Codrin Ciubotariu (4):
      ASoC: atmel: atmel_ssc_dai: Add stream names
      ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due to single channel limitation
      ASoC: atmel: mchp-spdiftx: Remove interface name from stream_name
      ASoC: atmel: mchp-spdifrx: Remove interface name from stream_name

Colin Ian King (3):
      ASoC: codecs: aw88395: Fix spelling mistake "unsupport" -> "unsupported"
      ASoC: codecs: aw88399: Fix spelling mistake "unsupport" -> "unsupported"
      ASoC: SOF: ipc4-topology: remove redundant assignment to variable ret

Cristian Ciocaltea (1):
      ASoC: dt-bindings: everest,es8328: Document audio graph port

Daniel Baluta (1):
      ASoC: SOF: ipc3: Use standard dev_dbg API

Deep Harsora (1):
      ASoC: Intel: sof_sdw: Add missing quirks from some new Dell

Dharageswari R (2):
      ASoC: Intel: sof_rt5682: Add support for ptl_max98360a_rt5682
      ASoC: intel: sof_sdw: add RT722 SDCA card for PTL platform

Dr. David Alan Gilbert (2):
      ALSA: firewire: Remove unused cmp_connection_update
      ASoC: soc-devres: Remove unused devm_snd_soc_register_dai

Everest K.C (2):
      ASoC: rt721-sdca: Clean logically deadcode in rt721-sdca.c
      ASoC: rt722-sdca: Remove logically deadcode in rt722-sdca.c

Fabio Estevam (1):
      ASoC: dt-bindings: fsl_spdif: Document imx6sl/sx compatible fallback

Fei Shao (3):
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Add mediatek,adsp property
      ASoC: dt-bindings: everest,es8326: Document interrupt property
      ASoC: dt-bindings: maxim,max98390: Reference common DAI properties

Frank Li (2):
      ASoC: dt-bindings: fsl-esai: Add power-domains for fsl,imx8qm-esai
      ASoC: dt-bindings: fsl-esai: allow fsl,imx8qm-esai fallback to fsl,imx6ull-esai

Geert Uytterhoeven (2):
      ASoC: fsl-asoc-card: Add missing handling of {hp,mic}-dt-gpios
      ASoC: dt-bindings: Deprecate {hp,mic}-det-gpio

Geoffrey D. Bennett (5):
      ALSA: scarlett2: Fix redeclaration of loop variable
      ALSA: scarlett2: Fix mixed declarations and code warning
      ALSA: scarlett2: Return ENOSPC for out-of-bounds flash writes
      ALSA: scarlett2: Simplify linked channel handling
      ALSA: scarlett2: Add support for device map retrieval

Hao Bui (2):
      ASoC: da7213: Avoid setting PLL when closing audio stream
      ASoC: da7213: Extend support for the MCK in range [2, 50] MHz

Harshit Mogalapalli (1):
      ASoC: codecs: fix error code in ntp8835_i2c_probe()

Heiko Stuebner (1):
      ASoC: dt-bindings: rockchip,rk3036-codec: convert to yaml

Heiner Kallweit (2):
      ALSA: hda: intel: Don't free interrupt when suspending
      ALSA: hda: intel: Switch to pci_alloc_irq_vectors API

Hendrik v. Raven (2):
      ASoc: simple-mux: add idle-state support
      ASoC: dt-bindings: simple-mux: add idle-state property

Herve Codina (1):
      ASoC: fsl: fsl_qmc_audio: Remove the logging when parsing channels

Hongbo Li (5):
      ASoC: improve macro definition on TWL4030_OUTPUT_PGA
      ASoC: remove unused substream in macro soc_component_mark_pop
      ASoC: remove unused substream in macro soc_dai_mark_pop
      ASoC: remove unused substream in macro soc_link_mark_pop
      ASoC: stm: fix macro definition on STM_SAI_HAS_EXT_SYNC

Huacai Chen (1):
      ALSA: hda: Poll jack events for LS7A HD-Audio

Igor Prusov (6):
      dt-bindings: vendor-prefixes: Add NeoFidelity, Inc
      ASoC: codecs: Add NeoFidelity Firmware helpers
      ASoC: dt-bindings: Add NeoFidelity NTP8918
      ASoC: codecs: Add NeoFidelity NTP8918 codec
      ASoC: dt-bindings: Add NeoFidelity NTP8835
      ASoC: codecs: Add NeoFidelity NTP8835 codec

Ingyu Jang (2):
      ASoC: uniphier: Handle regmap_write errors in aio_src_set_param()
      ASoC: uniphier: Handle regmap_write errors in aio_iecout_set_enable()

Jack Yu (6):
      ASoC: rt-sdw-common: Common functions for Realtek soundwire driver
      ASoC: rt721-sdca: Add RT721 SDCA driver
      ASoC: rt721-sdca: Fix issue of warning message
      ASoC: Intel: Add rt721-sdca support for PTL platform
      ASoC: rt-sdw-common: Enhance switch case to prevent uninitialized variable
      ASoC: rt721-sdca: change interrupt mask from XU to GE

James Calligeros (1):
      ASoC: cs42l84: leverage ring sense IRQs to correctly detect headsets

Jaroslav Kysela (1):
      ALSA: compress_offload: introduce accel operation mode

Javier Carrasco (1):
      ASoC: constify snd_soc_component_driver struct

Jerome Brunet (1):
      ASoC: meson: axg-iface: set continuous rates

Jiapeng Chong (1):
      ASoC: cs42l84: Remove unused including <linux/version.h>

John Watts (1):
      ASoC: test-component: Support continuous rates for test component

Jonas Karlman (1):
      ASoC: hdmi-codec: reorder channel allocation list

Kiseok Jo (2):
      ASoC: dt-bindings: irondevice,sma1307: Add initial DT
      ASoC: sma1307: Add driver for Iron Device SMA1307

Krzysztof Kozlowski (5):
      ASoC: qcom: sm8250: correct typo in shutdown function name
      ASoC: dt-bindings: qcom: Add SM8750 LPASS macro codecs
      ASoC: qcom: x1e80100: Support boards with two speakers
      ASoC: dt-bindings: qcom,sm8250: Add SM8750 sound card
      ASoC: qcom: sc8280xp Add SM8750 sound card

Kuninori Morimoto (25):
      ASoC: makes snd_soc_set_runtime_hwparams() inline
      ASoC: amd: remove dpcm_xxx flags
      ASoC: fsl: remove dpcm_xxx flags
      ASoC: sof: remove dpcm_xxx flags
      ASoC: intel: remove dpcm_xxx flags
      ASoC: samsung: remove dpcm_xxx flags
      ASoC: mediatek: remove dpcm_xxx flags
      ASoC: soc-core: remove dpcm_xxx flags
      ASoC: soc-compress: remove dpcm_xxx flags
      ASoC: soc-topology: remove dpcm_xxx flags
      ASoC: intel: boards: remove dpcm_xxx flags
      ASoC: soc-pcm: remove dpcm_xxx flags
      ASoC: doc: remove dpcm_xxx flags
      ASoC: soc-pcm: merge DPCM and non-DPCM validation check
      ASoC: rename rtd->num to rtd->id
      ASoC: fsl: switch to use rtd->id from rtd->num
      ASoC: meson: switch to use rtd->id from rtd->num
      ASoC: sh: switch to use rtd->id from rtd->num
      ASoC: generic: switch to use rtd->id from rtd->num
      ASoC: remove rtd->num
      ASoC: soc-core: do rtd->id trick at snd_soc_add_pcm_runtime()
      ASoC: cleanup function parameter for rtd and its id
      ASoC: add symmetric_ prefix for dai->rate/channels/sample_bits
      ASoC: simple-card-utils: care simple_util_dai for dummy DAI
      ALSA: tidyup SNDRV_PCM_TRIGGER_xxx numbering

Lad Prabhakar (6):
      ASoC: rsnd: Refactor port handling with helper for endpoint node selection
      ASoC: Rename "sh" to "renesas"
      ASoC: renesas, rsnd: Update file path
      ASoC: audio-graph-card2: Update comment with renamed file path
      MAINTAINERS: Add entry for Renesas R-Car and FSI ASoC drivers
      MAINTAINERS: Add entry for Renesas RZ ASoC driver

Liu Jing (1):
      ASoC: rx651: Use card->dev in replace of the &pdev->dev argument in the dev_err function

Luo Yifan (1):
      ALSA: ump: remove unnecessary check on blk

Mac Chiang (3):
      ASoC: sdw_utils: Add quirk to exclude amplifier function
      ASoC: intel: sof_sdw: add quirk for Dell SKU
      ASoC: Intel: soc-acpi-intel-arl-match: Add rt722 and rt1320 support

Macpaul Lin (1):
      ASoC: dt-bindings: mt6359: Update generic node name and dmic-mode

Marcus Cooper (2):
      ASoC: sun4i-codec: Add support for different DAC FIFOC addresses to quirks
      ASoC: sun4i-codec: Add playback only flag to quirks

Marek Vasut (3):
      ASoC: max98088: Remove duplicate DACs
      ASoC: max98088: Add left/right DAC volume control
      ASoC: max98088: Add headphone mixer switch

Mario Limonciello (1):
      ASoC: amd: acp: Add stream name to ACP PDM DMIC devices

Mark Brown (2):
      ASoC: bcm2835-i2s: Use maple tree register cache
      ASoC: fsl: Use maple tree register cache

Markus Elfring (1):
      ASoC: tas5805m: Improve a size determination in tas5805m_i2c_probe()

Martin Povi¹er (2):
      ASoC: cs42l84: Add new codec driver
      ASoC: dt-bindings: Add CS42L84 codec

Masahiro Yamada (1):
      ASoC: codecs: wcd9335: remove unnecessary MODULE_ALIAS()

Murad Masimov (1):
      ASoC: amd: acp: drop bogus NULL check from i2s_irq_handler

Naveen Manohar (2):
      ASoC: intel/sdw_utils: refactor RT multifunction sdca speaker codecs
      ASoC: Intel: soc-acpi-intel-ptl-match: Add rt721 support

Neil Armstrong (1):
      ASoC: dt-bindings: realtek,rt5640: Convert to dtschema

Nuno Sa (5):
      ASoC: codecs: adau1372: add match table
      ASoC: codecs: adau1373: add some kconfig text
      ASoC: dt-bindings: document the adau1373 Codec
      ASoC: codecs: adau1373: drop patform_data
      ASoC: codecs: adau1373: add powerdown gpio

Olivier Moysan (6):
      ASoC: dt-bindings: add stm32mp25 support for sai
      ASoC: stm32: sai: add stm32mp25 support
      ASoC: dt-bindings: add stm32mp25 support for i2s
      ASoC: stm32: i2s: add stm32mp25 support
      ASoC: dt-bindings: stm32: add missing port property
      ASoC: stm32: dfsdm: change rate upper limits

Peter Ujfalusi (17):
      ASoC: SOF: ipc4-topology: Drop the 'index' from 'Pin index' of format print
      ASoC: SOF: ipc4-topology: Use local variables in sof_ipc4_init_input_audio_fmt()
      ASoC: SOF: ipc4-topology: Remove redundant check in sof_ipc4_init_input_audio_fmt()
      ASoC: SOF: ipc4-topology: Simplify match format print in sof_ipc4_init_input_audio_fmt()
      ASoC: SOF: ipc4-topology: Use local variables in sof_ipc4_init_output_audio_fmt()
      ASoC: SOF: ipc4-topology: Simplify code to deal with process modules without output
      ASoC: SOF: ipc4-topology: Concentrate prints inside of sof_ipc4_init_output_audio_fmt()
      ASoC: SOF: ipc4-topology: Add helper function to print the module's in/out audio format
      ASoC: SOF: core: Add debug module parameters to set IPC and boot timeout
      ASoC: SOF: core: Add fw, tplg and ipc type override parameters
      ALSA: compress_offload: Use runtime pointer in snd_compr_poll()
      ASoC: SOF: ext_manifest: Add missing ext_manifest type for PROBE_INFO
      ASoC: SOF: ipc3-loader: 'Handle' PROBE_INFO ext_manifest type when parsing
      ASoC: SOF: Intel: hda-stream: Always use at least two BDLE for transfers
      ASoC: SOF: Intel: hda: Add support for persistent Code Loader DMA buffers
      ASoC: Intel: Kconfig: Only select SND_SOC_SDCA if ACPI is enabled
      ASoC: Intel: Kconfig: Revert make SND_SOC_ACPI_INTEL_MATCH depend on ACPI

Pierre-Louis Bossart (12):
      ASoC: SOF: Intel: hda-mlink: expose unlocked interrupt enable routine
      ASoC/SoundWire: Intel: lnl: enable interrupts after first power-up/before last power-down
      ASoC/soundwire: remove sdw_slave_extended_id
      ASoC: SDCA: add initial module
      soundwire: slave: lookup SDCA version and functions
      ASoC: SDCA: add quirk function for RT712_VB match
      ASoC: rt712-sdca: detect the SMART_MIC function during the probe stage
      ASoC: soc-acpi: introduce new 'machine check' callback
      ASoC: sdw_utils: add SmartMic DAI for RT712 VB
      ASoC: sdw_utils: add SmartMic DAI for RT713 VB
      ASoC: Intel: soc-acpi: add is_device_rt712_vb() helper
      ASoC: SOF: Intel: hda: use machine_check() for SoundWire

Qiu-ji Chen (1):
      ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()

Ranjani Sridharan (1):
      ASoC: SOF: Intel: hda: handle only paused streams in hda_dai_suspend()

Ritu Chaudhary (1):
      ASoC: tegra: Add support for S24_LE audio format

Ryan Roberts (1):
      ASoC: soc-utils: Remove PAGE_SIZE compile-time constant assumption

Ryan Walklin (2):
      ASoC: sun4i-codec: support allwinner H616 codec
      ASoC: dt-bindings: allwinner: add H616 sun4i audio codec binding

Sarah Grant (1):
      ALSA: usb-audio: Add Pioneer DJ/AlphaTheta DJM-A9 Mixer

Shengjiu Wang (6):
      ASoC: fsl_micfil: fix regmap_write_bits usage
      ASoC: fsl_micfil: Add mclk enable flag
      ASoC: fsl_micfil: Enable micfil error interrupt
      ASoC: fsl_xcvr: enable interrupt of cmdc status update
      ASoC: fsl_xcvr: reset RX dpath after wrong preamble
      ASoC: fsl_mqs: Support accessing registers by scmi interface

Shuming Fan (4):
      ASoC: rt1320: reads patch code from firmware file
      ASoC: rt1320: fix the range of patch code address
      ASoC: rt1320: add mic function
      ASoC: rt722: change the interrupt mask for jack type detection

Stanislav Jakubek (2):
      ASoC: dt-bindings: sprd,pcm-platform: convert to YAML
      ASoC: dt-bindings: sprd,sc9860-mcdt: convert to YAML

Suraj Sonawane (2):
      ASoC: bcm63xx-pcm-whistler: fix uninit-value in i2s_dma_isr
      ASoc: SOF: ipc4-pcm: fix uninit-value in sof_ipc4_pcm_dai_link_fixup_rate

Takashi Iwai (13):
      ALSA: hda: Use own quirk lookup helper
      ALSA: hda/conexant: Use the new codec SSID matching
      ALSA: hda/realtek: Use codec SSID matching for Lenovo devices
      ALSA: hda: Fix build error without CONFIG_SND_DEBUG
      ALSA: hda: Fix unused variable warning
      ALSA: usb-audio: Make mic volume workarounds globally applicable
      ALSA: pcm: Define snd_pcm_mmap_data_{open|close}() locally
      ALSA: usx2y: Use snd_card_free_when_closed() at disconnection
      ALSA: us122l: Use snd_card_free_when_closed() at disconnection
      ALSA: us122l: Drop mmap_count field
      ALSA: caiaq: Use snd_card_free_when_closed() at disconnection
      ALSA: 6fire: Release resources at card release
      ALSA: compress_offload: Add missing descriptions in structs

Tang Bin (7):
      ASoC: tas2781: Fix redundant parameter assignment
      ASoC: codecs: Fix error check in es8323_i2c_probe
      ASoC: mediatek: mt8188: Remove unnecessary variable assignments
      ASoC: mediatek: mt8188: remove unnecessary variable assignment
      ASoC: ux500: Remove redundant casts
      ASoC: mediatek: mt8183: Remove unnecessary variable assignments
      ASoC: sma1307: Fix invalid logical judgement

Uwe Kleine-König (1):
      sound: Switch back to struct platform_driver::remove()

Venkata Prasad Potturu (1):
      ASoC: amd: acp: Fix for ACP SOF dmic tplg component load failure

Vijendar Mukunda (20):
      ASoC: amd: acp: simplify platform conditional checks code
      ASoC: amd: acp: use acp_rev for platform specific conditional checks
      ASoC: amd: acp: use acp pci revision id for platform differntiation
      ASoC: amd: acp: store acp pci rev id in platform driver private structure
      ASoC: amd: acp: pass acp pci revision id as platform data
      ASoC: amd: acp: update mach_params subsystem_rev field
      ASoC: amd: acp: remove unused variable from acp_card_drvdata structure
      ASoC: amd: acp: replace adata->platform conditional check
      ASoC: amd: acp: remove unused variable from acp platform driver
      ASoC: amd: acp: fix for inconsistent indenting
      ASoC: amd: acp: fix for cpu dai index logic
      ASoC: amd: acp: refactor sof_card_dai_links_create() function
      ASoC: sdw_utils/intel/amd: refactor dai link init logic
      ASoC: sdw_utils: Update stream_name in dai_links structure
      ASoC: amd: acp: add rt722 based soundwire machines
      ASoC: amd: acp: add RT711, RT714 & RT1316 support for acp 6.3 platform
      ASoC: amd: ps: add soundwire machines for acp6.3 platform
      ASoC: amd: acp: move get_acp63_cpu_pin_id() to common file
      ASoC: amd: acp: add soundwire machine driver for legacy stack
      ASoC: amd: ps: fix the pcm device numbering for acp 6.3 platform

Vitaliy Shevtsov (1):
      ASoC: nau8821: check regmap_raw_read/regmap_raw_write for failure

Weidong Wang (2):
      ASoC: dt-bindings: Add schema for "awinic,aw88081"
      ASoC: codecs: Add aw88081 amplifier driver

Yang Li (1):
      ASoC: codecs: Remove unneeded semicolon

Zhang Yi (2):
      ASoC: codecs: ES8326: Modify the configuration of and micbias
      ASoC: codecs: ES8326: Reduce pop noise

Zhu Jun (5):
      ALSA: dbri: Fix formatting issue in dbri.c
      ALSA: aica: Remove unused variable
      ASoC: aw88399: Correct error handling in aw_dev_get_dsp_status function
      ALSA: ice1712: Remove redundant code in stac9460_dac_vol_put
      ALSA: usb-audio: Use snprintf instead of sprintf in build_mixer_unit_ctl

anish kumar (2):
      ASoC: doc: update clock api details
      ASoC: machine: update documentation

zhang jiao (1):
      ALSA: ump: Fix the wrong format specifier

---
 .../devicetree/bindings/sound/adi,adau1373.yaml    |  111 +
 .../bindings/sound/allwinner,sun4i-a10-codec.yaml  |   53 +-
 .../devicetree/bindings/sound/audio-graph.yaml     |    6 +
 .../devicetree/bindings/sound/awinic,aw88395.yaml  |    4 +-
 .../devicetree/bindings/sound/cirrus,cs42l84.yaml  |   56 +
 .../devicetree/bindings/sound/everest,es8316.yaml  |    4 +-
 .../devicetree/bindings/sound/everest,es8326.yaml  |    4 +
 .../devicetree/bindings/sound/everest,es8328.yaml  |    4 +
 .../devicetree/bindings/sound/fsl,esai.yaml        |   28 +-
 .../devicetree/bindings/sound/fsl,spdif.yaml       |   27 +-
 .../devicetree/bindings/sound/inno-rk3036.txt      |   20 -
 .../bindings/sound/irondevice,sma1307.yaml         |   53 +
 .../bindings/sound/loongson,ls2k1000-i2s.yaml      |   68 +
 .../devicetree/bindings/sound/maxim,max98390.yaml  |    8 +-
 .../bindings/sound/mediatek,mt8188-mt6359.yaml     |    7 +
 .../devicetree/bindings/sound/mt6359.yaml          |   10 +-
 .../bindings/sound/neofidelity,ntp8835.yaml        |   73 +
 .../bindings/sound/neofidelity,ntp8918.yaml        |   70 +
 .../devicetree/bindings/sound/nxp,uda1342.yaml     |   42 +
 .../bindings/sound/qcom,lpass-rx-macro.yaml        |    1 +
 .../bindings/sound/qcom,lpass-tx-macro.yaml        |    1 +
 .../bindings/sound/qcom,lpass-va-macro.yaml        |    1 +
 .../bindings/sound/qcom,lpass-wsa-macro.yaml       |    1 +
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |    1 +
 .../devicetree/bindings/sound/realtek,rt5640.yaml  |  146 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |    2 +-
 .../bindings/sound/rockchip,rk3036-codec.yaml      |   58 +
 Documentation/devicetree/bindings/sound/rt5640.txt |   97 -
 .../bindings/sound/simple-audio-mux.yaml           |    5 +
 .../devicetree/bindings/sound/simple-card.yaml     |   12 +
 .../bindings/sound/sprd,pcm-platform.yaml          |   56 +
 .../bindings/sound/sprd,sc9860-mcdt.yaml           |   47 +
 .../devicetree/bindings/sound/sprd-mcdt.txt        |   19 -
 .../devicetree/bindings/sound/sprd-pcm.txt         |   23 -
 .../devicetree/bindings/sound/st,stm32-i2s.yaml    |   36 +-
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |   26 +-
 .../bindings/sound/st,stm32-spdifrx.yaml           |    4 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/sound/designs/compress-accel.rst     |  134 +
 Documentation/sound/designs/index.rst              |    1 +
 Documentation/sound/soc/clocking.rst               |   12 +
 Documentation/sound/soc/dpcm.rst                   |   11 +-
 Documentation/sound/soc/machine.rst                |   26 +
 MAINTAINERS                                        |   23 +
 drivers/soundwire/Kconfig                          |    1 +
 drivers/soundwire/amd_init.c                       |   12 +-
 drivers/soundwire/intel_ace2x.c                    |    7 +
 drivers/soundwire/intel_init.c                     |   13 +-
 drivers/soundwire/slave.c                          |   14 +
 include/linux/soundwire/sdw.h                      |    9 +-
 include/linux/soundwire/sdw_amd.h                  |    7 +-
 include/linux/soundwire/sdw_intel.h                |    8 +-
 include/sound/adau1373.h                           |   33 -
 include/sound/compress_driver.h                    |   50 +
 include/sound/hda-mlink.h                          |    4 +
 include/sound/hda_register.h                       |    2 +-
 include/sound/pcm.h                                |   34 +-
 include/sound/sdca.h                               |   62 +
 include/sound/sdca_function.h                      |   55 +
 include/sound/soc-acpi.h                           |    8 +-
 include/sound/soc-dai.h                            |   11 +-
 include/sound/soc.h                                |   26 +-
 include/sound/soc_sdw_utils.h                      |   10 +-
 include/sound/sof/ext_manifest.h                   |    1 +
 include/uapi/sound/compress_offload.h              |   66 +-
 sound/arm/pxa2xx-ac97.c                            |    2 +-
 sound/atmel/ac97c.c                                |    2 +-
 sound/core/Kconfig                                 |    3 +
 sound/core/compress_offload.c                      |  358 +-
 sound/core/pcm_native.c                            |   20 +
 sound/core/ump.c                                   |    4 +-
 sound/drivers/mts64.c                              |    2 +-
 sound/drivers/pcmtest.c                            |    2 +-
 sound/drivers/portman2x4.c                         |    2 +-
 sound/firewire/cmp.c                               |   47 -
 sound/firewire/cmp.h                               |    1 -
 sound/mips/hal2.c                                  |    2 +-
 sound/mips/sgio2audio.c                            |    4 +-
 sound/oss/dmasound/dmasound_paula.c                |    2 +-
 sound/pci/hda/hda_auto_parser.c                    |   61 +-
 sound/pci/hda/hda_intel.c                          |   38 +-
 sound/pci/hda/hda_local.h                          |   28 +-
 sound/pci/hda/hda_tegra.c                          |    2 +-
 sound/pci/hda/patch_analog.c                       |    6 +-
 sound/pci/hda/patch_cirrus.c                       |    8 +-
 sound/pci/hda/patch_conexant.c                     |   36 +-
 sound/pci/hda/patch_cs8409-tables.c                |    2 +-
 sound/pci/hda/patch_cs8409.h                       |    2 +-
 sound/pci/hda/patch_realtek.c                      |  118 +-
 sound/pci/hda/patch_sigmatel.c                     |   22 +-
 sound/pci/hda/patch_via.c                          |    2 +-
 sound/pci/ice1712/prodigy192.c                     |    9 +-
 sound/ppc/powermac.c                               |    2 +-
 sound/sh/aica.c                                    |    4 +-
 sound/sh/sh_dac_audio.c                            |    2 +-
 sound/soc/Kconfig                                  |    3 +-
 sound/soc/Makefile                                 |    3 +-
 sound/soc/amd/acp-da7219-max98357a.c               |   20 +-
 sound/soc/amd/acp-es8336.c                         |    2 -
 sound/soc/amd/acp/Kconfig                          |   29 +
 sound/soc/amd/acp/Makefile                         |    4 +
 sound/soc/amd/acp/acp-i2s.c                        |   38 +-
 sound/soc/amd/acp/acp-legacy-common.c              |   24 +-
 sound/soc/amd/acp/acp-legacy-mach.c                |    8 +-
 sound/soc/amd/acp/acp-mach-common.c                |   63 +-
 sound/soc/amd/acp/acp-mach.h                       |   12 +-
 sound/soc/amd/acp/acp-pci.c                        |    7 +-
 sound/soc/amd/acp/acp-pdm.c                        |    2 +-
 sound/soc/amd/acp/acp-platform.c                   |   18 +-
 sound/soc/amd/acp/acp-rembrandt.c                  |    4 +-
 sound/soc/amd/acp/acp-renoir.c                     |    4 +-
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            |  486 +++
 sound/soc/amd/acp/acp-sdw-mach-common.c            |   64 +
 sound/soc/amd/acp/acp-sdw-sof-mach.c               |  104 +-
 sound/soc/amd/acp/acp-sof-mach.c                   |    6 +-
 sound/soc/amd/acp/acp63.c                          |    4 +-
 sound/soc/amd/acp/acp70.c                          |   14 +-
 sound/soc/amd/acp/acp_common.h                     |   19 +
 sound/soc/amd/acp/amd-acp63-acpi-match.c           |   54 +
 sound/soc/amd/acp/amd.h                            |    9 +-
 sound/soc/amd/acp/soc_amd_sdw_common.h             |    4 +
 sound/soc/amd/acp3x-rt5682-max9836.c               |    6 +-
 sound/soc/amd/mach-config.h                        |    1 +
 sound/soc/amd/ps/pci-ps.c                          |    4 +-
 sound/soc/amd/ps/ps-sdw-dma.c                      |    2 +
 sound/soc/amd/vangogh/acp5x-mach.c                 |    6 -
 sound/soc/atmel/atmel_ssc_dai.c                    |    5 +-
 sound/soc/atmel/mchp-spdifrx.c                     |    2 +-
 sound/soc/atmel/mchp-spdiftx.c                     |    2 +-
 sound/soc/au1x/dbdma2.c                            |    2 +-
 sound/soc/au1x/dma.c                               |    2 +-
 sound/soc/bcm/bcm2835-i2s.c                        |    2 +-
 sound/soc/bcm/bcm63xx-pcm-whistler.c               |    6 +-
 sound/soc/bcm/cygnus-pcm.c                         |    2 +-
 sound/soc/codecs/Kconfig                           |   69 +-
 sound/soc/codecs/Makefile                          |   20 +
 sound/soc/codecs/adau1372-i2c.c                    |    1 +
 sound/soc/codecs/adau1372-spi.c                    |    1 +
 sound/soc/codecs/adau1372.c                        |    8 +
 sound/soc/codecs/adau1372.h                        |    1 +
 sound/soc/codecs/adau1373.c                        |  208 +-
 sound/soc/codecs/aw88081.c                         | 1087 ++++++
 sound/soc/codecs/aw88081.h                         |  286 ++
 sound/soc/codecs/aw88395/aw88395_device.c          |    2 +-
 sound/soc/codecs/aw88395/aw88395_lib.c             |    2 +-
 sound/soc/codecs/aw88399.c                         |    2 +-
 sound/soc/codecs/cpcap.c                           |    2 +-
 sound/soc/codecs/cs42l84.c                         | 1111 ++++++
 sound/soc/codecs/cs42l84.h                         |  210 ++
 sound/soc/codecs/da7213.c                          |   27 +-
 sound/soc/codecs/da7213.h                          |    1 +
 sound/soc/codecs/da7219.c                          |    9 +-
 sound/soc/codecs/es8323.c                          |  792 +++++
 sound/soc/codecs/es8323.h                          |   78 +
 sound/soc/codecs/es8326.c                          |   20 +-
 sound/soc/codecs/hdmi-codec.c                      |  144 +-
 sound/soc/codecs/max98088.c                        |   86 +-
 sound/soc/codecs/nau8821.c                         |    9 +-
 sound/soc/codecs/ntp8835.c                         |  480 +++
 sound/soc/codecs/ntp8918.c                         |  397 +++
 sound/soc/codecs/ntpfw.c                           |  137 +
 sound/soc/codecs/ntpfw.h                           |   23 +
 sound/soc/codecs/pcm186x.c                         |    4 +-
 sound/soc/codecs/pcm5102a.c                        |    2 +-
 sound/soc/codecs/rt-sdw-common.c                   |  238 ++
 sound/soc/codecs/rt-sdw-common.h                   |   66 +
 sound/soc/codecs/rt1320-sdw.c                      | 3668 +++-----------------
 sound/soc/codecs/rt1320-sdw.h                      |    6 +
 sound/soc/codecs/rt712-sdca-sdw.c                  |    1 +
 sound/soc/codecs/rt712-sdca.c                      |   40 +-
 sound/soc/codecs/rt712-sdca.h                      |    1 +
 sound/soc/codecs/rt721-sdca-sdw.c                  |  546 +++
 sound/soc/codecs/rt721-sdca-sdw.h                  |  150 +
 sound/soc/codecs/rt721-sdca.c                      | 1545 +++++++++
 sound/soc/codecs/rt721-sdca.h                      |  269 ++
 sound/soc/codecs/rt722-sdca-sdw.c                  |   12 +-
 sound/soc/codecs/rt722-sdca.c                      |   15 +-
 sound/soc/codecs/simple-mux.c                      |   39 +-
 sound/soc/codecs/sma1307.c                         | 2049 +++++++++++
 sound/soc/codecs/sma1307.h                         |  444 +++
 sound/soc/codecs/spdif_receiver.c                  |    2 +-
 sound/soc/codecs/spdif_transmitter.c               |    2 +-
 sound/soc/codecs/tas2781-i2c.c                     |   35 +-
 sound/soc/codecs/tas5805m.c                        |    2 +-
 sound/soc/codecs/tas6424.c                         |    2 +-
 sound/soc/codecs/tlv320adc3xxx.c                   |    2 +-
 sound/soc/codecs/twl4030.c                         |   12 +-
 sound/soc/codecs/uda1342.c                         |  347 ++
 sound/soc/codecs/uda1342.h                         |   78 +
 sound/soc/codecs/wcd9335.c                         |    1 -
 sound/soc/codecs/wcd937x.c                         |    1 -
 sound/soc/fsl/Kconfig                              |    1 +
 sound/soc/fsl/fsl-asoc-card.c                      |   32 +-
 sound/soc/fsl/fsl_aud2htx.c                        |    2 +-
 sound/soc/fsl/fsl_easrc.c                          |    2 +-
 sound/soc/fsl/fsl_micfil.c                         |   51 +-
 sound/soc/fsl/fsl_mqs.c                            |   41 +
 sound/soc/fsl/fsl_qmc_audio.c                      |    2 -
 sound/soc/fsl/fsl_xcvr.c                           |   94 +-
 sound/soc/fsl/fsl_xcvr.h                           |    5 +
 sound/soc/fsl/imx-audmix.c                         |   18 +-
 sound/soc/fsl/imx-card.c                           |   69 +-
 sound/soc/generic/audio-graph-card2.c              |    2 +-
 sound/soc/generic/simple-card-utils.c              |   16 +-
 sound/soc/generic/test-component.c                 |    2 +-
 sound/soc/intel/Kconfig                            |    8 +-
 sound/soc/intel/avs/boards/da7219.c                |    2 -
 sound/soc/intel/avs/boards/dmic.c                  |    4 +-
 sound/soc/intel/avs/boards/es8336.c                |    2 -
 sound/soc/intel/avs/boards/hdaudio.c               |    4 -
 sound/soc/intel/avs/boards/i2s_test.c              |    2 -
 sound/soc/intel/avs/boards/max98357a.c             |    2 +-
 sound/soc/intel/avs/boards/max98373.c              |    2 -
 sound/soc/intel/avs/boards/max98927.c              |    2 -
 sound/soc/intel/avs/boards/nau8825.c               |    2 -
 sound/soc/intel/avs/boards/rt274.c                 |    2 -
 sound/soc/intel/avs/boards/rt286.c                 |    2 -
 sound/soc/intel/avs/boards/rt298.c                 |    2 -
 sound/soc/intel/avs/boards/rt5514.c                |    2 +-
 sound/soc/intel/avs/boards/rt5663.c                |    2 -
 sound/soc/intel/avs/boards/rt5682.c                |    2 -
 sound/soc/intel/avs/boards/ssm4567.c               |    2 -
 sound/soc/intel/avs/pcm.c                          |    2 +-
 sound/soc/intel/boards/Kconfig                     |    1 +
 sound/soc/intel/boards/bdw-rt5650.c                |    4 -
 sound/soc/intel/boards/bdw-rt5677.c                |    4 -
 sound/soc/intel/boards/bdw_rt286.c                 |   10 +-
 sound/soc/intel/boards/bytcht_cx2072x.c            |    6 +-
 sound/soc/intel/boards/bytcht_da7213.c             |    6 +-
 sound/soc/intel/boards/bytcht_es8316.c             |    6 +-
 sound/soc/intel/boards/bytcht_nocodec.c            |    6 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |    6 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    6 +-
 sound/soc/intel/boards/bytcr_wm5102.c              |    6 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |    6 +-
 sound/soc/intel/boards/cht_bsw_nau8824.c           |    6 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    6 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    6 +-
 sound/soc/intel/boards/ehl_rt5660.c                |   14 +-
 sound/soc/intel/boards/hsw_rt5640.c                |   10 +-
 sound/soc/intel/boards/sof_board_helpers.c         |   15 +-
 sound/soc/intel/boards/sof_es8336.c                |    8 +-
 sound/soc/intel/boards/sof_pcm512x.c               |    9 +-
 sound/soc/intel/boards/sof_rt5682.c                |   15 +
 sound/soc/intel/boards/sof_sdw.c                   |  117 +-
 sound/soc/intel/boards/sof_wm8804.c                |    2 -
 sound/soc/intel/common/Makefile                    |    6 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |   63 +
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |   65 +
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |   58 +
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |   75 +-
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.c  |   42 +
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.h  |   14 +
 sound/soc/intel/common/sst-dsp-priv.h              |  101 -
 sound/soc/intel/common/sst-dsp.c                   |  250 --
 sound/soc/intel/common/sst-dsp.h                   |   61 -
 sound/soc/intel/common/sst-ipc.c                   |  294 --
 sound/soc/intel/common/sst-ipc.h                   |   86 -
 sound/soc/loongson/Kconfig                         |   40 +-
 sound/soc/loongson/Makefile                        |    9 +-
 sound/soc/loongson/loongson_i2s.c                  |    5 +
 sound/soc/loongson/loongson_i2s_plat.c             |  185 +
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |   20 +-
 sound/soc/mediatek/mt2701/mt2701-wm8960.c          |    6 +-
 sound/soc/mediatek/mt6797/mt6797-mt6351.c          |   24 +-
 sound/soc/mediatek/mt7986/mt7986-wm8960.c          |    6 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |    6 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |    6 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |   10 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |   10 +-
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c |   34 +-
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c         |    7 +-
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c        |   34 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366.c          |   86 +-
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c        |    1 -
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c        |    5 +-
 sound/soc/mediatek/mt8188/mt8188-dai-pcm.c         |    2 +-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |   58 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |   78 +-
 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c         |    2 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c          |   60 +-
 sound/soc/mediatek/mt8365/mt8365-dai-dmic.c        |    6 +-
 sound/soc/mediatek/mt8365/mt8365-dai-pcm.c         |    2 +-
 sound/soc/mediatek/mt8365/mt8365-mt6357.c          |   14 +-
 sound/soc/meson/axg-card.c                         |    6 +-
 sound/soc/meson/axg-tdm-interface.c                |   12 +-
 sound/soc/meson/axg-tdm.h                          |    2 -
 sound/soc/meson/gx-card.c                          |    2 +-
 sound/soc/qcom/sc8280xp.c                          |    1 +
 sound/soc/qcom/sm8250.c                            |   12 +-
 sound/soc/qcom/x1e80100.c                          |   40 +-
 sound/soc/{sh => renesas}/Kconfig                  |    0
 sound/soc/{sh => renesas}/Makefile                 |    0
 sound/soc/{sh => renesas}/dma-sh7760.c             |    0
 sound/soc/{sh => renesas}/fsi.c                    |    0
 sound/soc/{sh => renesas}/hac.c                    |    0
 sound/soc/{sh => renesas}/migor.c                  |    0
 sound/soc/{sh => renesas}/rcar/Makefile            |    0
 sound/soc/{sh => renesas}/rcar/adg.c               |    0
 sound/soc/{sh => renesas}/rcar/cmd.c               |    0
 sound/soc/{sh => renesas}/rcar/core.c              |   32 +-
 sound/soc/{sh => renesas}/rcar/ctu.c               |    0
 sound/soc/{sh => renesas}/rcar/debugfs.c           |    0
 sound/soc/{sh => renesas}/rcar/dma.c               |    0
 sound/soc/{sh => renesas}/rcar/dvc.c               |    0
 sound/soc/{sh => renesas}/rcar/gen.c               |    0
 sound/soc/{sh => renesas}/rcar/mix.c               |    0
 sound/soc/{sh => renesas}/rcar/rsnd.h              |    0
 sound/soc/{sh => renesas}/rcar/src.c               |    0
 sound/soc/{sh => renesas}/rcar/ssi.c               |    0
 sound/soc/{sh => renesas}/rcar/ssiu.c              |    0
 sound/soc/{sh => renesas}/rz-ssi.c                 |    6 +-
 sound/soc/{sh => renesas}/sh7760-ac97.c            |    0
 sound/soc/{sh => renesas}/siu.h                    |    0
 sound/soc/{sh => renesas}/siu_dai.c                |    0
 sound/soc/{sh => renesas}/siu_pcm.c                |    0
 sound/soc/{sh => renesas}/ssi.c                    |    0
 sound/soc/samsung/odroid.c                         |   11 +-
 sound/soc/sdca/Kconfig                             |   11 +
 sound/soc/sdca/Makefile                            |    5 +
 sound/soc/sdca/sdca_device.c                       |   67 +
 sound/soc/sdca/sdca_functions.c                    |  177 +
 sound/soc/sdw_utils/Makefile                       |    3 +-
 sound/soc/sdw_utils/soc_sdw_rt712_sdca.c           |   48 -
 sound/soc/sdw_utils/soc_sdw_rt722_sdca.c           |   41 -
 sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c           |   90 +
 sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c  |    8 +
 sound/soc/sdw_utils/soc_sdw_utils.c                |   80 +-
 sound/soc/soc-acpi.c                               |   30 +-
 sound/soc/soc-component.c                          |   14 +-
 sound/soc/soc-compress.c                           |   28 +-
 sound/soc/soc-core.c                               |   70 +-
 sound/soc/soc-dai.c                                |   14 +-
 sound/soc/soc-devres.c                             |   37 -
 sound/soc/soc-link.c                               |   10 +-
 sound/soc/soc-pcm.c                                |  152 +-
 sound/soc/soc-topology-test.c                      |    2 -
 sound/soc/soc-topology.c                           |    4 +-
 sound/soc/soc-utils.c                              |    4 +-
 sound/soc/sof/amd/acp-common.c                     |    3 +-
 sound/soc/sof/core.c                               |   64 +
 sound/soc/sof/intel/hda-dai.c                      |    4 +
 sound/soc/sof/intel/hda-dsp.c                      |    5 -
 sound/soc/sof/intel/hda-loader.c                   |  100 +-
 sound/soc/sof/intel/hda-mlink.c                    |   18 +
 sound/soc/sof/intel/hda-stream.c                   |   32 +-
 sound/soc/sof/intel/hda.c                          |   27 +-
 sound/soc/sof/intel/hda.h                          |   14 +-
 sound/soc/sof/intel/lnl.c                          |   10 -
 sound/soc/sof/ipc3-loader.c                        |    3 +
 sound/soc/sof/ipc3.c                               |    2 +-
 sound/soc/sof/ipc4-pcm.c                           |    3 +
 sound/soc/sof/ipc4-topology.c                      |  376 +-
 sound/soc/sof/nocodec.c                            |    7 +-
 sound/soc/sof/sof-acpi-dev.c                       |    4 +-
 sound/soc/sof/sof-of-dev.c                         |   14 +-
 sound/soc/sof/sof-pci-dev.c                        |   12 +-
 sound/soc/stm/stm32_adfsdm.c                       |    4 +-
 sound/soc/stm/stm32_i2s.c                          |  211 +-
 sound/soc/stm/stm32_sai.c                          |   58 +-
 sound/soc/stm/stm32_sai.h                          |    6 +
 sound/soc/stm/stm32_sai_sub.c                      |  146 +-
 sound/soc/sunxi/sun4i-codec.c                      |  298 +-
 sound/soc/tegra/tegra186_dspk.c                    |    3 +
 sound/soc/tegra/tegra210_admaif.c                  |   11 +-
 sound/soc/tegra/tegra210_adx.c                     |    9 +-
 sound/soc/tegra/tegra210_amx.c                     |    9 +-
 sound/soc/tegra/tegra210_dmic.c                    |    7 +-
 sound/soc/tegra/tegra210_i2s.c                     |   14 +-
 sound/soc/tegra/tegra210_i2s.h                     |    9 +-
 sound/soc/tegra/tegra210_mixer.c                   |    9 +-
 sound/soc/tegra/tegra210_mvc.c                     |    9 +-
 sound/soc/tegra/tegra210_ope.c                     |    9 +-
 sound/soc/tegra/tegra210_sfc.c                     |    9 +-
 sound/soc/ti/rx51.c                                |   12 +-
 sound/soc/uniphier/aio-core.c                      |   25 +-
 sound/soc/uniphier/evea.c                          |    2 +-
 sound/soc/ux500/ux500_msp_dai.c                    |    6 +-
 sound/sparc/cs4231.c                               |    2 +-
 sound/sparc/dbri.c                                 |    4 +-
 sound/usb/6fire/chip.c                             |   10 +-
 sound/usb/caiaq/audio.c                            |   10 +-
 sound/usb/caiaq/audio.h                            |    1 +
 sound/usb/caiaq/device.c                           |   19 +-
 sound/usb/caiaq/input.c                            |   12 +-
 sound/usb/caiaq/input.h                            |    1 +
 sound/usb/mixer.c                                  |   61 +-
 sound/usb/mixer_quirks.c                           |   68 +-
 sound/usb/mixer_scarlett2.c                        |  220 +-
 sound/usb/quirks-table.h                           |   57 +
 sound/usb/quirks.c                                 |   31 +-
 sound/usb/usbaudio.h                               |    4 +
 sound/usb/usx2y/us122l.c                           |   21 +-
 sound/usb/usx2y/us122l.h                           |    2 -
 sound/usb/usx2y/usbusx2y.c                         |    2 +-
 395 files changed, 17567 insertions(+), 6488 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1373.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036.txt
 create mode 100644 Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/loongson,ls2k1000-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nxp,uda1342.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5640.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5640.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sprd,pcm-platform.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/sprd,sc9860-mcdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/sprd-mcdt.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/sprd-pcm.txt
 create mode 100644 Documentation/sound/designs/compress-accel.rst
 delete mode 100644 include/sound/adau1373.h
 create mode 100644 include/sound/sdca.h
 create mode 100644 include/sound/sdca_function.h
 create mode 100644 sound/soc/amd/acp/acp-sdw-legacy-mach.c
 create mode 100644 sound/soc/amd/acp/acp-sdw-mach-common.c
 create mode 100644 sound/soc/amd/acp/acp_common.h
 create mode 100644 sound/soc/codecs/aw88081.c
 create mode 100644 sound/soc/codecs/aw88081.h
 create mode 100644 sound/soc/codecs/cs42l84.c
 create mode 100644 sound/soc/codecs/cs42l84.h
 create mode 100644 sound/soc/codecs/es8323.c
 create mode 100644 sound/soc/codecs/es8323.h
 create mode 100644 sound/soc/codecs/ntp8835.c
 create mode 100644 sound/soc/codecs/ntp8918.c
 create mode 100644 sound/soc/codecs/ntpfw.c
 create mode 100644 sound/soc/codecs/ntpfw.h
 create mode 100644 sound/soc/codecs/rt-sdw-common.c
 create mode 100644 sound/soc/codecs/rt-sdw-common.h
 create mode 100644 sound/soc/codecs/rt721-sdca-sdw.c
 create mode 100644 sound/soc/codecs/rt721-sdca-sdw.h
 create mode 100644 sound/soc/codecs/rt721-sdca.c
 create mode 100644 sound/soc/codecs/rt721-sdca.h
 create mode 100644 sound/soc/codecs/sma1307.c
 create mode 100644 sound/soc/codecs/sma1307.h
 create mode 100644 sound/soc/codecs/uda1342.c
 create mode 100644 sound/soc/codecs/uda1342.h
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdca-quirks.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdca-quirks.h
 delete mode 100644 sound/soc/intel/common/sst-dsp-priv.h
 delete mode 100644 sound/soc/intel/common/sst-dsp.c
 delete mode 100644 sound/soc/intel/common/sst-dsp.h
 delete mode 100644 sound/soc/intel/common/sst-ipc.c
 delete mode 100644 sound/soc/intel/common/sst-ipc.h
 create mode 100644 sound/soc/loongson/loongson_i2s_plat.c
 rename sound/soc/{sh => renesas}/Kconfig (100%)
 rename sound/soc/{sh => renesas}/Makefile (100%)
 rename sound/soc/{sh => renesas}/dma-sh7760.c (100%)
 rename sound/soc/{sh => renesas}/fsi.c (100%)
 rename sound/soc/{sh => renesas}/hac.c (100%)
 rename sound/soc/{sh => renesas}/migor.c (100%)
 rename sound/soc/{sh => renesas}/rcar/Makefile (100%)
 rename sound/soc/{sh => renesas}/rcar/adg.c (100%)
 rename sound/soc/{sh => renesas}/rcar/cmd.c (100%)
 rename sound/soc/{sh => renesas}/rcar/core.c (98%)
 rename sound/soc/{sh => renesas}/rcar/ctu.c (100%)
 rename sound/soc/{sh => renesas}/rcar/debugfs.c (100%)
 rename sound/soc/{sh => renesas}/rcar/dma.c (100%)
 rename sound/soc/{sh => renesas}/rcar/dvc.c (100%)
 rename sound/soc/{sh => renesas}/rcar/gen.c (100%)
 rename sound/soc/{sh => renesas}/rcar/mix.c (100%)
 rename sound/soc/{sh => renesas}/rcar/rsnd.h (100%)
 rename sound/soc/{sh => renesas}/rcar/src.c (100%)
 rename sound/soc/{sh => renesas}/rcar/ssi.c (100%)
 rename sound/soc/{sh => renesas}/rcar/ssiu.c (100%)
 rename sound/soc/{sh => renesas}/rz-ssi.c (99%)
 rename sound/soc/{sh => renesas}/sh7760-ac97.c (100%)
 rename sound/soc/{sh => renesas}/siu.h (100%)
 rename sound/soc/{sh => renesas}/siu_dai.c (100%)
 rename sound/soc/{sh => renesas}/siu_pcm.c (100%)
 rename sound/soc/{sh => renesas}/ssi.c (100%)
 create mode 100644 sound/soc/sdca/Kconfig
 create mode 100644 sound/soc/sdca/Makefile
 create mode 100644 sound/soc/sdca/sdca_device.c
 create mode 100644 sound/soc/sdca/sdca_functions.c
 delete mode 100644 sound/soc/sdw_utils/soc_sdw_rt712_sdca.c
 delete mode 100644 sound/soc/sdw_utils/soc_sdw_rt722_sdca.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c


