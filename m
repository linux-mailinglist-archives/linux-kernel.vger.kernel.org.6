Return-Path: <linux-kernel+bounces-257042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EDE937468
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5B3281859
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086C154645;
	Fri, 19 Jul 2024 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hdo4x24i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3pc0O+GN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hdo4x24i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3pc0O+GN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848F2CA6;
	Fri, 19 Jul 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721374476; cv=none; b=Eia/5VQhg9Z6Vhf+9gpRPqSd8JQhSNCojYwuaJG5vq3OMQFxVWpm7GqBrPf23WMQvRVKLM7Xi9dmcGt30g7gnf3CYIllPkZz2zD5EFMSaoZ2Duante+t5tX9MIMArqKxDyJ3623UUdyTCy7BBBjhWyw/BsDLTZQtni69EC0HjBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721374476; c=relaxed/simple;
	bh=ECaexTDc+pNi7zWDaBsH2fRk93UPh/rZuYGw8WBbi7E=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=g8qUwhG0dAYqzM+KS1BMCrlIAA8ZVRcMtBFDLYWA+ynB/nl+Sfr5Uq7LWX7JEaEf0urqAwxI5l26YGKa/tgIQRxLSGnbeRLfECjOBOANgsAHLxGbfndYEOCYuiclOPnDL0/70mbKHT0+PjcuO+InhtiXa19+uLJmiPE2rZAorEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hdo4x24i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3pc0O+GN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hdo4x24i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3pc0O+GN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D655219C4;
	Fri, 19 Jul 2024 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721374471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7qEiX9d64c61GTll1n32RopbYgNTRkhpCRymOvH1SOE=;
	b=hdo4x24iBSklI6UbZ7ZImO5J/qYh8/s9LORTDikTrG8yN5VNLowzwJCTZBaOlSRy9FdcfM
	PlcaT8tKQugzfUaERvBKIHnCwC/XgvY+QyjrJcGECasYEnzHZ2OPHecE3zCshvEy8MeMhF
	45SiNveRWZhgXHOqZTOl5vAKNZAN3XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721374471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7qEiX9d64c61GTll1n32RopbYgNTRkhpCRymOvH1SOE=;
	b=3pc0O+GN9tCoreh6UKYQTikeIyeN5uKVSYsie0IxgxmrN/RurBoc/rQI/JP+XSSebk8SEm
	lJl/JnBTwjKbyrDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721374471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7qEiX9d64c61GTll1n32RopbYgNTRkhpCRymOvH1SOE=;
	b=hdo4x24iBSklI6UbZ7ZImO5J/qYh8/s9LORTDikTrG8yN5VNLowzwJCTZBaOlSRy9FdcfM
	PlcaT8tKQugzfUaERvBKIHnCwC/XgvY+QyjrJcGECasYEnzHZ2OPHecE3zCshvEy8MeMhF
	45SiNveRWZhgXHOqZTOl5vAKNZAN3XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721374471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7qEiX9d64c61GTll1n32RopbYgNTRkhpCRymOvH1SOE=;
	b=3pc0O+GN9tCoreh6UKYQTikeIyeN5uKVSYsie0IxgxmrN/RurBoc/rQI/JP+XSSebk8SEm
	lJl/JnBTwjKbyrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0839136F7;
	Fri, 19 Jul 2024 07:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fTKfMQYXmmaXJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Jul 2024 07:34:30 +0000
Date: Fri, 19 Jul 2024 09:35:04 +0200
Message-ID: <87v811u95j.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates for 6.11-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Linus,

please pull sound updates for v6.11-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc1

The topmost commit is 4594d26fca91fab0e1621d2ab196f3f9bab96bc8

----------------------------------------------------------------

sound updates for 6.11-rc1

Lots of changes in this cycle, but mostly for cleanups and
refactoring.  Significant amount of changes are about DT schema
conversions for ASoC at this time while we see other usual
suspects, too.  Some highlights below:

Core:
- Re-introduction of PCM sync ID support API
- MIDI2 time-base extension in ALSA sequencer API

ASoC:
- Syncing of features between simple-audio-card and the two
  audio-graph cards
- Support for specifying the order of operations for components
  within cards to allow quirking for unusual systems
- Lots of DT schema conversions
- Continued SOF/Intel updates for topology, SoundWire, IPC3/4
- New support for Asahi Kasei AK4619, Cirrus Logic CS530x, Everest
  Semiconductors ES8311, NXP i.MX95 and LPC32xx, Qualcomm LPASS
  v2.5 and WCD937x, Realtek RT1318 and RT1320 and Texas
  Instruments PCM5242

HD-audio:
- More quirks, Intel PantherLake support, senarytech codec support
- Refactoring of Cirrus codec component-binding

Others:
- ALSA control kselftest improvements, and fixes for input value
  checks in various drivers

----------------------------------------------------------------

Abdulrasaq Lawani (1):
      dt-bindings: sound: Convert max98088 to dtschema

Aleksandr Mishin (2):
      ASoC: qcom: Adjust issues in case of DT error in asoc_qcom_lpass_cpu_platform_probe()
      ASoC: amd: Adjust error handling in case of absent codec device

Amadeusz S³awiñski (13):
      ASoC: topology: Simplify code
      ASoC: topology: Do not do unnecessary dobj management
      ASoC: topology: Properly initialize soc_enum values
      ASoC: topology: Cleanup soc_tplg_dapm_widget_dbytes_create
      ASoC: topology: Cleanup soc_tplg_dapm_widget_dmixer_create
      ASoC: topology: Cleanup soc_tplg_dapm_widget_denum_create
      ASoC: topology: Correctly set shift_r in soc_tplg_denum_create()
      ASoC: topology: Align dynamic object initialization for controls
      ASoC: topology: Rename function creating widget kcontrol
      ASoC: topology: Reshuffle function placement
      ASoC: topology: Unify code for creating standalone and widget bytes control
      ASoC: topology: Unify code for creating standalone and widget mixer control
      ASoC: topology: Unify code for creating standalone and widget enum control

Andrejs Cainikovs (3):
      ASoC: nau8822: move nau8822_set_dai_sysclk()
      ASoC: nau8822: set NAU8822_REFIMP_80K only once
      ASoC: nau8822: add MCLK support

Andy Shevchenko (6):
      ASoC: codecs: Remove unused of_gpio.h
      ASoC: fsl: Remove unused of_gpio.h
      ASoC: rockchip: Remove unused of_gpio.h
      ASoC: codecs: Replace of_gpio.h by proper one
      ASoC: generic: Replace of_gpio.h by proper one
      ASoC: samsung: Replace of_gpio.h by proper one

Animesh Agarwal (11):
      ASoC: dt-bindings: ak4554: Convert to dtschema
      ASoC: dt-bindings: linux,spdif: Convert spdif-reciever.txt to dtschema
      ASoC: dt-bindings: wlf,wm8782: Convert to dtschema
      ASoC: dt-bindings: wlf,wm8804: Convert to dtschema
      ASoC: dt-bindings: realtek,rt5631: Convert to dtschema
      ASoC: dt-bindings: realtek,rt5514: Convert to dtschema
      ASoC: dt-bindings: realtek,rt5659: Convert to dtschema
      ASoC: dt-bindings: realtek,rt5677: Convert to dtschema
      ASoC: dt-bindings: realtek,rt5645: Convert to dtschema
      ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema
      ASoC: dt-bindings: cirrus,cs42xx8: Convert to dtschema

Artur Weber (6):
      ASoC: dt-bindings: samsung,midas-audio: Add headset mic bias supply
      ASoC: dt-bindings: samsung,midas-audio: Add GPIO-based headset jack detection
      ASoC: samsung: midas_wm1811: Use SND_SOC_DAPM_REGULATOR_SUPPLY for bias regulators
      ASoC: samsung: midas_wm1811: Add headset mic bias supply support
      ASoC: samsung: midas_wm1811: Add GPIO-based headset jack detection
      ASoC: samsung: midas_wm1811: Use dev_err_probe where appropriate

Bard Liao (8):
      ASoC: Intel: sof_sdw_cs42l42: use dai parameter
      ASoC: Intel: sof_sdw_rt711: use dai parameter
      ASoC: Intel: sof_sdw_rt5682: use dai parameter
      ASoC: Intel: sof_sdw_rt700: use dai parameter
      ASoC: Intel: sof_sdw_rt_dmic: use from dai parameter
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: use dai parameter
      ASoC: Intel: sof_sdw: remove get_codec_dai_by_name
      ASoC: Intel: sof_sdw: select PINCTRL_CS42L43 and SPI_CS42L43

Brent Lu (8):
      ASoC: SOF: sof-audio: rename dai clock setting query function
      ASoC: SOF: sof-audio: add sof_dai_get_tdm_slots function
      ASoC: SOF: ipc3-topology: support tdm slot number query
      ASoC: SOF: ipc4-topology: support tdm slot number query
      ASoC: Intel: maxim-common: rewrite max_98373_hw_params function
      ASoC: Intel: sof_da7219: remove local max98373 ops
      ASoC: Intel: sof_da7219: disable max98373 speaker pins in late_probe
      ASoC: Intel: maxim-common: add max_98373_get_tx_mask function

Chancel Liu (3):
      ASoC: dt-bindings: fsl_rpmsg: Add compatible string for i.MX95
      ASoC: fsl_rpmsg: Add support for i.MX95 platform
      ASoC: fsl_xcvr: Improve suspend/resume flow in fsl_xcvr_trigger()

Charles Keepax (3):
      ASoC: Intel: sof_sdw: Add missing controls for cs42l43/cs35l56
      ASoC: Intel: soc-acpi: Add match entries for some cs42l43 laptops
      ASoC: Intel: sof_sdw: Add quirks for some new Dell laptops

Chen Ni (2):
      ASoC: max98088: Check for clk_prepare_enable() error
      ASoC: Intel: sof_sdw: Convert comma to semicolon

Christian Hewitt (2):
      ASoC: Add support for ti,pcm5242 to the pcm512x driver
      ASoC: dt-bindings: add ti,pcm5242 to pcm512x

Christophe JAILLET (8):
      ASoC: topology: Constify an argument of snd_soc_tplg_component_load()
      ASoC: Intel: avs: Constify struct snd_soc_tplg_ops
      ASoC: qdsp6: audioreach: Constify struct snd_soc_tplg_ops
      ASoC: Intel: Skylake: Constify struct snd_soc_tplg_ops
      ASoC: SOF: topology: Constify struct snd_soc_tplg_ops
      const_structs.checkpatch: add snd_soc_tplg_ops
      ASoC: intel: Constify struct snd_soc_ops
      ASoC: SOF: mediatek: Constify struct mtk_adsp_ipc_ops

Dan Carpenter (1):
      ASoC: samsung: midas_wm1811: Fix error code in probe()

Dr. David Alan Gilbert (4):
      ASoC: codecs: lpass-rx-macro: remove unused struct 'rx_macro_reg_mask_val'
      ASoC: codecs: wm0010: remove unused struct 'wm0010_spi_msg'
      ASoC: codecs: cx2072x: remove unused struct 'cx2072x_eq_ctrl'
      ALSA: xen-front: remove unused struct 'alsa_sndif_hw_param'

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Positivo SU C1400

Elinor Montmasson (5):
      ASoC: fsl-asoc-card: add support for dai links with multiple codecs
      ASoC: fsl-asoc-card: add second dai link component for codecs
      ASoC: fsl-asoc-card: add compatibility to use 2 codecs in dai-links
      ASoC: fsl-asoc-card: merge spdif support from imx-spdif.c
      ASoC: dt-bindings: update fsl-asoc-card bindings after imx-spdif merge

Fabio Estevam (3):
      ASoC: fsl: fsl_aud2htx: Switch to RUNTIME_PM_OPS()
      ASoC: fsl: fsl_easrc: Switch to RUNTIME_PM_OPS()
      ASoC: fsl: fsl_xcvr: Switch to RUNTIME_PM_OPS()

Hao Ge (1):
      ASoc: PCM6240: Return directly after a failed devm_kzalloc() in pcmdevice_i2c_probe()

Herve Codina (10):
      ASoC: fsl: fsl_qmc_audio: Check devm_kasprintf() returned value
      ASoC: fsl: fsl_qmc_audio: Fix issues detected by checkpatch
      ASoC: fsl: fsl_qmc_audio: Split channel buffer and PCM pointer handling
      ASoC: fsl: fsl_qmc_audio: Identify the QMC channel involved in completion routines
      ASoC: fsl: fsl_qmc_audio: Introduce qmc_audio_pcm_{read,write}_submit()
      ASoC: fsl: fsl_qmc_audio: Introduce qmc_dai_constraints_interleaved()
      soc: fsl: cpm1: qmc: Introduce functions to get a channel from a phandle list
      soc: fsl: cpm1: qmc: Introduce qmc_chan_count_phandles()
      dt-bindings: sound: fsl,qmc-audio: Add support for multiple QMC channels per DAI
      ASoC: fsl: fsl_qmc_audio: Add support for non-interleaved mode.

Jack Yu (1):
      ASoC: rt1318: Add RT1318 audio amplifier driver

Jaroslav Kysela (3):
      ALSA: pcm: reinvent the stream synchronization ID API
      ALSA: pcm: optimize and clarify stream synchronization ID API
      ALSA: pcm: Fix id copying in snd_pcm_set_sync_per_card()

Javier Carrasco (9):
      ASoC: cs35l34: Constify struct regmap_config
      ASoC: cs35l35: Constify struct regmap_config
      ASoC: cs35l36: Constify struct regmap_config
      ASoC: cs53l30: Constify struct regmap_config
      ASoC: jz4760: Constify struct regmap_config
      ASoC: jz4770: Constify struct regmap_config
      ASoC: wsa881x: Constify struct regmap_config
      ASoC: wsa883x: Constify struct regmap_config
      ASoC: wsa884x: Constify struct regmap_config

Jeff Johnson (2):
      ASoC: amd: add missing MODULE_DESCRIPTION() macros
      ASoC: fsl: imx-pcm-fiq: add missing MODULE_DESCRIPTION() macro

Jerome Brunet (2):
      ASoC: soc-utils: allow sample rate up to 768kHz for the dummy dai
      ASoC: meson: tdm: add sample rate support up to 768kHz

Jiaxin Yu (1):
      ASoC: mediatek: mt6358: Add "Dmic Mode Switch" kcontrol for switch DMIC mode.

Khanh Le (1):
      ASoC: Add ak4619 codec support

Krzysztof Kozlowski (70):
      ASoC: Constify channel mapping array arguments in set_channel_map()
      ASoC: qcom: q6apm-lpass-dais: Implement proper channel mapping
      ASoC: qcom: qdsp6: Set channel mapping instead of fixed defaults
      ASoC: qcom: x1e80100: Correct channel mapping
      ASoC: codecs: wcd938x: Drop unused duplicated MIC2 bias register defines
      ASoC: codecs: wcd938x: Unify define used for MIC2 bias register
      ASoC: codecs: wcd939x: Unify define used for MIC bias registers
      ASoC: codecs: wcd939x: Minor white-space and define cleanup
      ASoC: codecs: wcd939x: Unify define used for MIC bias VOUT registers
      ASoC: codecs: wcd938x: Drop no-op ADC2_BCS Disable Switch
      ASoC: soc-dai.h: Constify DAI ops auto_selectable_formats
      ASoC: Constify DAI ops auto_selectable_formats
      ASoC: Constify of_phandle_args in snd_soc_dai_driver
      ASoC: Constify of_phandle_args in snd_soc_dai_link_component
      ASoC: Constify passed data to core function
      ASoC: Constify DAI passed to get_channel_map
      ASoC: Constify return of snd_soc_dai_get_pcm_stream()
      ASoC: qcom: x1e80100: Add USB DisplayPort plug support
      ASoC: codecs: wcd-mbhc: Constify passed MBHC reg fields
      ASoC: codecs: wcd9335: Drop unused state container fields
      ASoC: codecs: wcd9335: Constify static data
      ASoC: codecs: wcd9335: Handle nicer probe deferral and simplify with dev_err_probe()
      ASoC: codecs: wcd9335: Drop unneeded error message
      ASoC: codecs: wcd9335: Drop unused dmic rate handling
      ASoC: codecs: wcd934x: Drop unused interp path enum
      ASoC: codecs: wcd934x: Constify static data
      ASoC: codecs: wcd934x: Drop unused mic bias voltage fields
      ASoC: codecs: wcd934x: Handle nicer probe deferral and simplify with dev_err_probe()
      ASoC: codecs: wcd937x: Constify static data
      ASoC: codecs: wcd937x: Constify wcd937x_sdw_ch_info
      ASoC: codecs: wcd937x: Drop unused enums, defines and types
      ASoC: codecs: wcd937x: Drop unused state container fields
      ASoC: codecs: wcd937x: Drop unused chipid member
      ASoC: codecs: wcd938x: Constify static data
      ASoC: codecs: wcd938x: Constify wcd938x_sdw_ch_info
      ASoC: codecs: wcd938x: Drop unused RX/TX direction enum
      ASoC: codecs: wcd938x: Drop unused num_ports field
      ASoC: codecs: wcd939x: Constify static data
      ASoC: codecs: wcd939x: Constify wcd939x_sdw_ch_info
      ASoC: codecs: wcd939x: Drop unused RX/TX direction enum
      ASoC: codecs: wcd939x: Drop unused num_ports field
      ASoC: codecs: lpass-rx-macro: add missing handling of v2.1 codec
      ASoC: codecs: lpass-wsa-macro: Drop unused define
      ASoC: codecs: lpass-wsa-macro: Prepare to accommodate new codec versions
      ASoC: codecs: lpass-wsa-macro: Correct support for newer v2.5 version
      ASoC: codecs: lpass-macro: Gracefully handle unknown version
      ASoC: codecs: lpass-macro: Use enum for handling codec version
      ASoC: codecs: lpass-wsa-macro: add missing select of common code
      ASoC: codecs: lpass-rx-macro: Fix using NULL pointer in probe() dev_err
      ASoC: codecs: lpass-wsa-macro: Fix using NULL pointer in probe() dev_err
      ASoC: codecs: lpass-rx-macro: Simplify PDS cleanup with devm
      ASoC: codecs: lpass-rx-macro: Simplify with cleanup.h
      ASoC: codecs: lpass-rx-macro: Keep static regmap_config as const
      ASoC: dapm: Use unsigned for number of widgets in snd_soc_dapm_new_controls()
      ASoC: codecs: lpass-rx-macro: Use unsigned for number of widgets
      ASoC: codecs: lpass-wsa-macro: Simplify with cleanup.h
      ASoC: codecs: wcd939x: Fix typec mux and switch leak during device removal
      ASoC: codecs: audio-iio-aux: Simplify audio_iio_aux_add_dapms() with cleanup.h
      ASoC: codecs: audio-iio-aux: Simplify audio_iio_aux_probe() with cleanup.h
      ASoC: codecs: wcd9335: Simplify with cleanup.h
      ASoC: codecs: wcd934x: Simplify with cleanup.h
      ASoC: simple-card-utils: Simplify with cleanup.h
      ASoC: audio-graph-card: Use cleanup.h instead of devm_kfree()
      ASoC: audio-graph-card2: Use cleanup.h instead of devm_kfree()
      ASoC: simple-card: Use cleanup.h instead of devm_kfree()
      ASoC: ops: Simplify with cleanup.h
      ASoC: dapm: Simplify dapm_cnew_widget() with cleanup.h
      ASoC: dapm: Simplify snd_soc_dai_link_event_pre_pmu() with cleanup.h
      ASoC: codecs: aw88395: Simplify with cleanup.h
      ASoC: qcom: topology: Simplify with cleanup.h

Kuninori Morimoto (22):
      ASoC: simple-card-utils: remove both playback/capture_only check
      ASoC: audio-graph-card2: add ep_to_port() / port_to_ports()
      ASoC: audio-graph-card2: remove ports node name check
      ASoC: audio-graph-card2: expand dai_link property part
      ASoC: audio-graph-card2: merge graph_parse_mclk_fs() into graph_link_init()
      ASoC: audio-graph-card: add ep_to_port() / port_to_ports()
      ASoC: audio-graph-card: remove ports node name check
      ASoC: audio-graph-card: enable playback/capture_only property
      ASoC: audio-graph-card: merge graph_parse_mclk_fs() into graph_link_init()
      ASoC: simple-audio-card: enable playback/capture_only property
      ASoC: simple-audio-card: merge simple_parse_mclk_fs() into simple_link_init()
      ASoC: audio-graph-card2: add support for aux devices
      ASoC: dt-bindings: audio-graph-card2: add support for aux devices
      ASoC: dt-bindings: ak4619: Add initial DT binding
      ASoC: dt-bindings: add missing vender prefix on filename
      ASoC: audio-graph-port: add link-trigger-order
      ASoC: simple-card-utils: add link-trigger-order support
      ASoC: simple-audio-card: add link-trigger-order support
      ASoC: audio-graph-card: add link-trigger-order support
      ASoC: audio-graph-card2: add link-trigger-order support
      ASoC: simple-audio-mux: enable to select MUX names
      ASoC: dt-bindings: simple-audio-mux: add state-labels property

Linus Walleij (1):
      ASoC: tas5086: Convert to GPIO descriptors

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entries after adding vendor prefix in sound dtbs

Manikantan R (1):
      ASoC: dt-bindings: wsa883x: Document port mapping property

Mark Brown (3):
      kselftest/alsa: Fix validation of writes to volatile controls
      kselftest/alsa: Use card name rather than number in test names
      kselftest/alsa: Log the PCM ID in pcm-test

Matteo Martelli (2):
      ASoC: es8311: dt-bindings: add everest es8311 codec
      ASoC: codecs: es8311: add everest es8311 codec support

Maxim Kochetkov (2):
      ASoC: dt-bindings: nau8824: Add master clock handling
      ASoC: codecs: nau8824: Add master clock handling

Mithil Bavishi (1):
      ASoC: dt-bindings: omap-mcpdm: Convert to DT schema

Mohammad Rafi Shaik (3):
      ASoC: codecs: wcd937x-sdw: Fix Unbalanced pm_runtime_enable
      ASoC: codecs: wcd937x: Remove the string compare in MIC BIAS widget settings
      ASoC: codecs: wcd937x: Remove separate handling for vdd-buck supply

Mohan Kumar (2):
      ASoC: simple-card-utils: Split simple_fixup_sample_fmt func
      ASoC: tegra: I2S client convert formats handling

Nathan Chancellor (2):
      ASoC: fsl: lpc3xxx-i2s: Avoid using ret uninitialized in lpc32xx_i2s_probe()
      ASoC: fsl: lpc3xxx-i2s: Include bitfield.h for FIELD_PREP

Neil Armstrong (5):
      ASoC: dt-bindings: convert amlogic,g12a-tohdmitx to dt-schema
      ASoC: dt-bindings: convert tas571x.txt to dt-schema
      ASoC: dt-bindings: convert everest,es7241.txt to dt-schema
      ASoC: dt-bindings: convert everest,es7134.txt to dt-schema
      ASoC: dt-bindings: amlogic,gx-sound-card: drop minItems for audio-widgets

Paul Handrigan (4):
      ASoC: dt-bindings: cirrus,cs530x: Add initial DT binding
      ASoC: cs530x: Support for cs530x ADCs
      ASoC: cs530x: Calculate proper bclk rate using TDM
      ASoC: cs530x: Remove bclk from private structure

Peter Ujfalusi (4):
      ASoC: SOF: ipc4-topology: Add support for NHLT with 16-bit only DMIC blob
      ASoC: SOF: Intel: pci-tgl: Align ADL-N sof_dev_desc struct name to convention
      ASoC: SOF: ipc4-topology: Use correct queue_id for requesting input pin format
      ASoC: SOF: ipc4-topology: Use single token list for the copiers

Pierre-Louis Bossart (9):
      ASoC: SOF: Intel: hda: print PCI class info only once
      ACPI: utils: introduce acpi_get_local_u64_address()
      soundwire: slave: simplify code with acpi_get_local_u64_address()
      ALSA: hda: intel-sdw-acpi: use acpi_get_local_u64_address()
      PCI: Add INTEL_HDA_PTL to pci_ids.h
      ALSA: hda: hda-intel: add PantherLake support
      ALSA: hda: intel-dsp-config: Add PTL support
      ASoC: Intel: sof_sdw: fix jack detection on ADL-N variant RVP
      ASoC: Intel: sof_sdw: add quirk for Dell SKU 0B8C

Piotr Wojtaszczyk (2):
      ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
      ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs

Prasad Kumpatla (7):
      ASoC: dt-bindings: document wcd937x Audio Codec
      ASoC: codecs: wcd937x-sdw: add SoundWire driver
      ASoC: codecs: wcd937x: add wcd937x codec driver
      ASoC: codecs: wcd937x: add basic controls
      ASoC: codecs: wcd937x: add playback dapm widgets
      ASoC: codecs: wcd937x: add capture dapm widgets
      ASoC: codecs: wcd937x: add audio routing and Kconfig

Rayyan Ansari (2):
      ASoC: dt-bindings: qcom,msm8916-wcd-digital-codec: convert to dtschema
      ASoC: dt-bindings: qcom,apq8096-sndcard: use dtschema

Ricard Wanderlof (3):
      ASoC: dt-bindings: tlv320adc3xxx: Fix incorrect GPIO description
      ASoC: dt-bindings: tlv320adc3xxx: Add MICBIAS-as-GPO properties
      ASoC: tlv320adc3xxx: Add support for using MICBIAS pins as GPO

Richard Fitzgerald (10):
      ASoC: cs35l56: Revert support for dual-ownership of ASP registers
      ASoC: cs35l56: Remove support for A1 silicon
      ASoC: cs35l56: Remove redundant clearing of clk_stop_mode1
      firmware: cs_dsp: Don't allow writes to read-only controls
      ASoC: cs35l56: Use header defines for Speaker Volume control definition
      ASoC: cs35l56: Limit Speaker Volume to +12dB maximum
      firmware: cs_dsp: Don't allocate temporary buffer for info text
      firmware: cs_dsp: Make wmfw and bin filename arguments const char *
      firmware: cs_dsp: Clarify wmfw format version log message
      firmware: cs_dsp: Rename fw_ver to wmfw_ver

Rob Herring (Arm) (2):
      ASoC: PCM6240: Use of_property_read_reg()
      ASoC: tas2781: Use of_property_read_reg()

Seunghun Han (1):
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book Pro 360

Shenghao Ding (9):
      ASoc: tas2781: Enable RCA-based playback without DSP firmware download
      ASoc: tas2781: Add name_prefix as the prefix name of firmwares and kcontrol to support corresponding TAS2563/TAS2781s
      ASoc: tas2781: Add name_prefix as the prefix name of DSP firmwares and calibrated data files
      ASoc: tas2781: Set "Speaker Force Firmware Load" as the common kcontrol for both tas27871 and tas2563
      ASoc: pcm6240: Remove unnecessary name-prefix for all the controls
      ASoc: TAS2781: replace beXX_to_cpup with get_unaligned_beXX for potentially broken alignment
      ASoc: TAS2781: rename the tas2781_reset as tasdevice_reset
      ASoC: tas2781: Add new Kontrol to set tas2563 digital Volume
      ALSA: hda/tas2781: Add new quirk for Lenovo Hera2 Laptop

Shengjiu Wang (10):
      ASoC: dt-bindings: fsl,mqs: Add i.MX95 platform support
      ASoC: fsl_mqs: Add i.MX95 platform support
      ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX95
      ASoC: fsl_xcvr: Add support for i.MX95 platform
      ASoC: fsl_sai: Add separate DAI for transmitter and receiver
      ASoC: fsl_audmix: Split playback and capture stream to different DAI
      ASoC: imx-audmix: Split capture device for audmix
      ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
      ASoC: ak4458: remove "reset-gpios" property handler
      ALSA: pcm_dmaengine: Don't synchronize DMA channel when DMA is paused

Shuming Fan (4):
      ASoC: rt1320: Add RT1320 SDCA vendor-specific driver
      ASoC: rt711-sdca: add GE selected mode control
      ASoC: rt712-sdca: change the definition name of SDCA channel number
      ASoC: rt712-sdca: add the function for version B

Simon Trimmer (7):
      ASoC: cs35l56: Attempt to read from cirrus,speaker-id device property first
      ALSA: hda: hda_component: Introduce component parent structure
      ALSA: hda: hda_component: Change codecs to use component parent structure
      ALSA: hda: hda_component: Move codec field into the parent
      ALSA: hda: hda_component: Protect shared data with a mutex
      ALSA: hda: cs35l56: Perform firmware download in the background
      ASoC: cs35l56: Accept values greater than 0 as IRQ numbers

Srinivas Kandagatla (9):
      ASoC: codecs: lpass-macro: add helpers to get codec version
      ASoC: codec: lpass-rx-macro: prepare driver to accomdate new codec versions
      ASoC: codec: lpass-rx-macro: add support for 2.5 codec version
      ASoC: qcom: q6dsp: parse Display port tokens
      ASoC: qcom: common: add Display port Jack function
      ASoC: qcom: sc8280xp: add Display port Jack
      ASoC: codecs: wsa883x: parse port-mapping information
      ASoC: dt-bindings: wsa8840: Document port mapping property
      ASoC: codecs: wsa884x: parse port-mapping information

Stefan Binding (1):
      ALSA: hda: cs35l41: Fix missing Speaker ID GPIO description in _DSD

Takashi Iwai (15):
      ALSA: vmaster: Return error for invalid input values
      ALSA: hda: Return -EINVAL for invalid volume/switch inputs
      ALSA: control: Apply sanity check of input values for user elements
      ALSA: chmap: Mark Channel Map controls as volatile
      ALSA: hda: Add input value sanity checks to HDMI channel map controls
      ALSA: control: Allow NULL passed to snd_ctl_remove()
      ALSA: sb: Drop NULL check for snd_ctl_remove()
      ALSA: hda: Drop NULL check for snd_ctl_remove()
      ALSA: spi: Drop NULL check for snd_ctl_remove()
      ALSA: pcm_dmaengine: Unify two close functions
      ALSA: pcm: Fix missing export of snd_pcm_set_sync_per-card()
      ALSA: seq: Add tempo base unit for MIDI2 Set Tempo messages
      ALSA: usb: Fix UBSAN warning in parse_audio_unit()
      ALSA: usb: Use BIT() for bit values
      ALSA: seq: ump: Skip useless ports for static blocks

Tony Luck (1):
      ASoC: Intel: avs: es8336: Switch to new Intel CPU model defines

Uwe Kleine-König (2):
      ASoC: codecs: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      ALSA: ppc: keywest: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Vijendar Mukunda (5):
      ASoC: amd: acp: remove acp_i2s_probe function
      ASoC: amd: acp: remove unused variables from acp_resource structure
      ASoC: amd: acp: modify conditional check for programming i2s mclk
      ASoC: amd: acp: move i2s clock generation sequence
      ASoC: amd: acp: add pcm constraints for buffer size and period size

Xiaxi Shen (1):
      ASoC: dt-bindings: ak4104: convert to dt schema

Yang Li (1):
      ASoC: Remove unneeded semicolon

Zhang Yi (3):
      ASoC: codecs: ES8326: Slove headphone detection issue
      ASoC: codecs: ES8326: Minimize the pop noise
      ASoC: codecs: ES8326: regcache_sync error issue

Zhu Jun (1):
      selftests/alsa:Fix printf format string in pcm-test.c

bo liu (1):
      ALSA: hda/senarytech: add senarytech codec support

---
 Documentation/devicetree/bindings/sound/ak4104.txt |   25 -
 Documentation/devicetree/bindings/sound/ak4554.txt |   11 -
 .../bindings/sound/amlogic,g12a-tohdmitx.txt       |   58 -
 .../bindings/sound/amlogic,g12a-tohdmitx.yaml      |   54 +
 .../bindings/sound/amlogic,gx-sound-card.yaml      |    1 -
 .../bindings/sound/asahi-kasei,ak4104.yaml         |   49 +
 .../sound/{ak4375.yaml => asahi-kasei,ak4375.yaml} |    2 +-
 .../bindings/sound/asahi-kasei,ak4554.yaml         |   27 +
 .../sound/{ak4613.yaml => asahi-kasei,ak4613.yaml} |    2 +-
 .../bindings/sound/asahi-kasei,ak4619.yaml         |   62 +
 .../sound/{ak4642.yaml => asahi-kasei,ak4642.yaml} |    2 +-
 .../bindings/sound/audio-graph-card2.yaml          |    5 +
 .../bindings/sound/audio-graph-port.yaml           |    9 +
 .../devicetree/bindings/sound/cirrus,cs4270.yaml   |   59 +
 .../devicetree/bindings/sound/cirrus,cs42xx8.yaml  |   81 +
 .../devicetree/bindings/sound/cirrus,cs530x.yaml   |   85 +
 Documentation/devicetree/bindings/sound/cs4270.txt |   21 -
 .../devicetree/bindings/sound/cs42xx8.txt          |   34 -
 .../devicetree/bindings/sound/everest,es7134.txt   |   15 -
 .../devicetree/bindings/sound/everest,es71x4.yaml  |   62 +
 .../devicetree/bindings/sound/everest,es7241.txt   |   28 -
 .../devicetree/bindings/sound/everest,es7241.yaml  |   67 +
 .../devicetree/bindings/sound/everest,es8316.yaml  |    7 +-
 .../bindings/sound/fsl,imx-audio-spdif.yaml        |   66 -
 .../devicetree/bindings/sound/fsl,mqs.yaml         |    2 +
 .../devicetree/bindings/sound/fsl,qmc-audio.yaml   |   41 +-
 .../devicetree/bindings/sound/fsl,rpmsg.yaml       |    1 +
 .../sound/{sgtl5000.yaml => fsl,sgtl5000.yaml}     |    2 +-
 .../devicetree/bindings/sound/fsl,xcvr.yaml        |   43 +-
 .../devicetree/bindings/sound/fsl-asoc-card.yaml   |   53 +-
 .../{linux,spdif-dit.yaml => linux,spdif.yaml}     |    8 +-
 .../devicetree/bindings/sound/maxim,max98088.txt   |   23 -
 .../devicetree/bindings/sound/maxim,max98088.yaml  |   47 +
 .../sound/{zl38060.yaml => mscc,zl38060.yaml}      |    2 +-
 .../devicetree/bindings/sound/nuvoton,nau8824.yaml |    8 +
 .../devicetree/bindings/sound/nxp,lpc3220-i2s.yaml |   73 +
 .../devicetree/bindings/sound/omap-mcpdm.txt       |   30 -
 .../devicetree/bindings/sound/pcm512x.txt          |    2 +-
 .../devicetree/bindings/sound/qcom,apq8096.txt     |  128 -
 .../sound/qcom,msm8916-wcd-digital-codec.yaml      |   55 +
 .../bindings/sound/qcom,msm8916-wcd-digital.txt    |   20 -
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |    1 +
 .../bindings/sound/qcom,wcd937x-sdw.yaml           |   91 +
 .../devicetree/bindings/sound/qcom,wcd937x.yaml    |   82 +
 .../devicetree/bindings/sound/qcom,wsa883x.yaml    |    8 +
 .../devicetree/bindings/sound/qcom,wsa8840.yaml    |    8 +
 .../sound/{rt1019.yaml => realtek,rt1019.yaml}     |    2 +-
 .../devicetree/bindings/sound/realtek,rt5514.yaml  |   70 +
 .../devicetree/bindings/sound/realtek,rt5631.yaml  |   67 +
 .../devicetree/bindings/sound/realtek,rt5645.yaml  |  131 +
 .../devicetree/bindings/sound/realtek,rt5659.yaml  |  129 +
 .../devicetree/bindings/sound/realtek,rt5677.yaml  |  135 +
 Documentation/devicetree/bindings/sound/rt5514.txt |   37 -
 Documentation/devicetree/bindings/sound/rt5631.txt |   48 -
 Documentation/devicetree/bindings/sound/rt5645.txt |   82 -
 Documentation/devicetree/bindings/sound/rt5659.txt |   89 -
 Documentation/devicetree/bindings/sound/rt5677.txt |   78 -
 .../bindings/sound/samsung,midas-audio.yaml        |   33 +
 .../bindings/sound/simple-audio-mux.yaml           |    6 +
 .../devicetree/bindings/sound/spdif-receiver.txt   |   10 -
 .../devicetree/bindings/sound/tas571x.txt          |   49 -
 .../devicetree/bindings/sound/ti,omap4-mcpdm.yaml  |   73 +
 .../sound/{tas2562.yaml => ti,tas2562.yaml}        |    2 +-
 .../sound/{tas2770.yaml => ti,tas2770.yaml}        |    2 +-
 .../sound/{tas27xx.yaml => ti,tas27xx.yaml}        |    2 +-
 .../devicetree/bindings/sound/ti,tas57xx.yaml      |  133 +
 .../sound/{tas5805m.yaml => ti,tas5805m.yaml}      |    2 +-
 .../bindings/sound/ti,tlv320adc3xxx.yaml           |   32 +-
 .../{tlv320adcx140.yaml => ti,tlv320adcx140.yaml}  |    2 +-
 .../sound/{wm8750.yaml => wlf,wm8750.yaml}         |    2 +-
 .../devicetree/bindings/sound/wlf,wm8782.yaml      |   47 +
 .../devicetree/bindings/sound/wlf,wm8804.yaml      |   58 +
 Documentation/devicetree/bindings/sound/wm8782.txt |   24 -
 Documentation/devicetree/bindings/sound/wm8804.txt |   25 -
 MAINTAINERS                                        |   26 +-
 arch/arm/configs/imx_v6_v7_defconfig               |    1 -
 arch/arm64/configs/defconfig                       |    1 -
 drivers/acpi/utils.c                               |   16 +-
 drivers/firmware/cirrus/cs_dsp.c                   |   71 +-
 drivers/soc/fsl/qe/qmc.c                           |   32 +-
 drivers/soundwire/slave.c                          |   13 +-
 include/dt-bindings/sound/audio-graph.h            |   26 +
 include/linux/acpi.h                               |    1 +
 include/linux/firmware/cirrus/cs_dsp.h             |   10 +-
 include/linux/firmware/mediatek/mtk-adsp-ipc.h     |    2 +-
 include/linux/pci_ids.h                            |    1 +
 include/soc/fsl/qe/qmc.h                           |   27 +-
 include/sound/cs35l41.h                            |    4 +-
 include/sound/cs35l56.h                            |   13 +-
 include/sound/pcm.h                                |   16 +-
 include/sound/rt1318.h                             |   16 +
 include/sound/simple_card_utils.h                  |    8 +-
 include/sound/soc-dai.h                            |   36 +-
 include/sound/soc-dapm.h                           |    2 +-
 include/sound/soc-topology.h                       |    2 +-
 include/sound/soc.h                                |   19 +-
 include/sound/sof.h                                |    1 +
 include/sound/tas2781-dsp.h                        |   11 +-
 include/sound/tas2781-tlv.h                        |  262 +-
 include/sound/tas2781.h                            |   10 +-
 include/uapi/sound/asequencer.h                    |    7 +-
 include/uapi/sound/asound.h                        |    9 +-
 scripts/const_structs.checkpatch                   |    1 +
 sound/core/control.c                               |    9 +-
 sound/core/pcm_dmaengine.c                         |   40 +-
 sound/core/pcm_lib.c                               |   52 +-
 sound/core/pcm_native.c                            |    6 +
 sound/core/seq/seq_clientmgr.c                     |    4 +
 sound/core/seq/seq_queue.c                         |    6 +-
 sound/core/seq/seq_timer.c                         |   21 +-
 sound/core/seq/seq_timer.h                         |    4 +-
 sound/core/seq/seq_ump_client.c                    |   16 +
 sound/core/vmaster.c                               |    8 +
 sound/hda/hdac_device.c                            |    1 +
 sound/hda/hdmi_chmap.c                             |   18 +
 sound/hda/intel-dsp-config.c                       |    9 +
 sound/hda/intel-sdw-acpi.c                         |    6 +-
 sound/isa/sb/emu8000.c                             |    6 +-
 sound/isa/sb/sb16_csp.c                            |   12 +-
 sound/pci/emu10k1/p16v.c                           |   17 +-
 sound/pci/hda/Kconfig                              |   11 +
 sound/pci/hda/Makefile                             |    2 +
 sound/pci/hda/cs35l41_hda.c                        |  129 +-
 sound/pci/hda/cs35l41_hda.h                        |    1 +
 sound/pci/hda/cs35l41_hda_property.c               |   15 +
 sound/pci/hda/cs35l56_hda.c                        |  115 +-
 sound/pci/hda/cs35l56_hda.h                        |    3 +
 sound/pci/hda/hda_codec.c                          |   23 +-
 sound/pci/hda/hda_component.c                      |   75 +-
 sound/pci/hda/hda_component.h                      |   48 +-
 sound/pci/hda/hda_cs_dsp_ctl.c                     |    2 +-
 sound/pci/hda/hda_intel.c                          |    2 +
 sound/pci/hda/patch_realtek.c                      |   20 +-
 sound/pci/hda/patch_senarytech.c                   |  244 ++
 sound/pci/hda/tas2781_hda_i2c.c                    |   48 +-
 sound/ppc/keywest.c                                |    4 +-
 sound/soc/amd/acp-es8336.c                         |    4 +-
 sound/soc/amd/acp/acp-i2s.c                        |   19 +-
 sound/soc/amd/acp/acp-legacy-common.c              |    1 +
 sound/soc/amd/acp/acp-pci.c                        |    1 +
 sound/soc/amd/acp/acp-pdm.c                        |    1 +
 sound/soc/amd/acp/acp-platform.c                   |   14 +
 sound/soc/amd/acp/acp-rembrandt.c                  |    7 +-
 sound/soc/amd/acp/acp-renoir.c                     |    2 -
 sound/soc/amd/acp/acp63.c                          |    7 +-
 sound/soc/amd/acp/acp70.c                          |    2 -
 sound/soc/amd/acp/amd.h                            |    3 +-
 sound/soc/amd/ps/ps-mach.c                         |    1 +
 sound/soc/amd/renoir/acp3x-rn.c                    |    1 +
 sound/soc/amd/yc/acp6x-mach.c                      |    1 +
 sound/soc/codecs/Kconfig                           |   56 +
 sound/soc/codecs/Makefile                          |   19 +
 sound/soc/codecs/adau7118.c                        |    6 +-
 sound/soc/codecs/ak4118.c                          |    1 -
 sound/soc/codecs/ak4458.c                          |   12 +-
 sound/soc/codecs/ak4613.c                          |    2 +-
 sound/soc/codecs/ak4619.c                          |  912 ++++++
 sound/soc/codecs/audio-iio-aux.c                   |   83 +-
 sound/soc/codecs/aw87390.c                         |    2 +-
 sound/soc/codecs/aw88261.c                         |    2 +-
 sound/soc/codecs/aw88395/aw88395.c                 |    4 +-
 sound/soc/codecs/aw88395/aw88395_lib.c             |   51 +-
 sound/soc/codecs/aw88399.c                         |    4 +-
 sound/soc/codecs/cs35l34.c                         |    2 +-
 sound/soc/codecs/cs35l35.c                         |    2 +-
 sound/soc/codecs/cs35l36.c                         |    2 +-
 sound/soc/codecs/cs35l41-lib.c                     |    4 +-
 sound/soc/codecs/cs35l41.c                         |    3 +-
 sound/soc/codecs/cs35l56-sdw.c                     |   75 -
 sound/soc/codecs/cs35l56-shared.c                  |  133 +-
 sound/soc/codecs/cs35l56.c                         |  211 +-
 sound/soc/codecs/cs35l56.h                         |    2 -
 sound/soc/codecs/cs530x-i2c.c                      |   72 +
 sound/soc/codecs/cs530x.c                          |  971 +++++++
 sound/soc/codecs/cs530x.h                          |  223 ++
 sound/soc/codecs/cs53l30.c                         |    3 +-
 sound/soc/codecs/cx2072x.c                         |    5 -
 sound/soc/codecs/da7213.c                          |    2 +-
 sound/soc/codecs/es8311.c                          |  973 +++++++
 sound/soc/codecs/es8311.h                          |  162 ++
 sound/soc/codecs/es8326.c                          |   58 +-
 sound/soc/codecs/framer-codec.c                    |    2 +-
 sound/soc/codecs/hdmi-codec.c                      |    2 +-
 sound/soc/codecs/idt821034.c                       |    2 +-
 sound/soc/codecs/jz4760.c                          |    2 +-
 sound/soc/codecs/jz4770.c                          |    2 +-
 sound/soc/codecs/lpass-macro-common.c              |   23 +
 sound/soc/codecs/lpass-macro-common.h              |   41 +
 sound/soc/codecs/lpass-rx-macro.c                  |  623 ++--
 sound/soc/codecs/lpass-tx-macro.c                  |    2 +-
 sound/soc/codecs/lpass-va-macro.c                  |   31 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |  644 ++++-
 sound/soc/codecs/max98088.c                        |   10 +-
 sound/soc/codecs/max98390.c                        |    1 -
 sound/soc/codecs/max98504.c                        |    6 +-
 sound/soc/codecs/mt6358.c                          |   38 +-
 sound/soc/codecs/nau8822.c                         |   76 +-
 sound/soc/codecs/nau8822.h                         |    1 +
 sound/soc/codecs/nau8824.c                         |   21 +-
 sound/soc/codecs/nau8824.h                         |    1 +
 sound/soc/codecs/pcm3168a.c                        |    3 +-
 sound/soc/codecs/pcm512x-i2c.c                     |    2 +
 sound/soc/codecs/pcm512x-spi.c                     |    2 +
 sound/soc/codecs/pcm6240.c                         |   67 +-
 sound/soc/codecs/peb2466.c                         |    2 +-
 sound/soc/codecs/rk817_codec.c                     |    1 -
 sound/soc/codecs/rt1318.c                          | 1354 +++++++++
 sound/soc/codecs/rt1318.h                          |  342 +++
 sound/soc/codecs/rt1320-sdw.c                      | 2260 +++++++++++++++
 sound/soc/codecs/rt1320-sdw.h                      |   94 +
 sound/soc/codecs/rt711-sdca.c                      |   72 +
 sound/soc/codecs/rt711-sdca.h                      |    1 +
 sound/soc/codecs/rt712-sdca-sdw.c                  |   36 +-
 sound/soc/codecs/rt712-sdca-sdw.h                  |   95 +-
 sound/soc/codecs/rt712-sdca.c                      |  665 ++++-
 sound/soc/codecs/rt712-sdca.h                      |   48 +-
 sound/soc/codecs/simple-mux.c                      |   55 +-
 sound/soc/codecs/tas2552.c                         |    1 -
 sound/soc/codecs/tas2764.c                         |    1 -
 sound/soc/codecs/tas2770.c                         |    1 -
 sound/soc/codecs/tas2780.c                         |    1 -
 sound/soc/codecs/tas2781-comlib.c                  |   21 +-
 sound/soc/codecs/tas2781-fmwlib.c                  |   89 +-
 sound/soc/codecs/tas2781-i2c.c                     |  233 +-
 sound/soc/codecs/tas5086.c                         |   27 +-
 sound/soc/codecs/tlv320adc3xxx.c                   |  106 +-
 sound/soc/codecs/tlv320adcx140.c                   |    1 -
 sound/soc/codecs/tlv320aic31xx.c                   |    1 -
 sound/soc/codecs/ts3a227e.c                        |    1 -
 sound/soc/codecs/wcd-mbhc-v2.c                     |    4 +-
 sound/soc/codecs/wcd-mbhc-v2.h                     |    4 +-
 sound/soc/codecs/wcd9335.c                         |  128 +-
 sound/soc/codecs/wcd934x.c                         |   72 +-
 sound/soc/codecs/wcd937x-sdw.c                     | 1137 ++++++++
 sound/soc/codecs/wcd937x.c                         | 2971 ++++++++++++++++++++
 sound/soc/codecs/wcd937x.h                         |  624 ++++
 sound/soc/codecs/wcd938x-sdw.c                     |    4 +-
 sound/soc/codecs/wcd938x.c                         |   36 +-
 sound/soc/codecs/wcd938x.h                         |   10 +-
 sound/soc/codecs/wcd939x-sdw.c                     |    4 +-
 sound/soc/codecs/wcd939x.c                         |  176 +-
 sound/soc/codecs/wcd939x.h                         |   18 +-
 sound/soc/codecs/wm0010.c                          |    8 -
 sound/soc/codecs/wm_adsp.c                         |    2 +-
 sound/soc/codecs/wsa881x.c                         |    2 +-
 sound/soc/codecs/wsa883x.c                         |   11 +-
 sound/soc/codecs/wsa884x.c                         |   10 +-
 sound/soc/fsl/Kconfig                              |   18 +-
 sound/soc/fsl/Makefile                             |    4 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  383 ++-
 sound/soc/fsl/fsl_aud2htx.c                        |   11 +-
 sound/soc/fsl/fsl_audmix.c                         |   16 +-
 sound/soc/fsl/fsl_easrc.c                          |   10 +-
 sound/soc/fsl/fsl_mqs.c                            |   46 +-
 sound/soc/fsl/fsl_qmc_audio.c                      |  591 ++--
 sound/soc/fsl/fsl_rpmsg.c                          |    9 +
 sound/soc/fsl/fsl_sai.c                            |  141 +-
 sound/soc/fsl/fsl_sai.h                            |    4 +-
 sound/soc/fsl/fsl_xcvr.c                           |  179 +-
 sound/soc/fsl/fsl_xcvr.h                           |   91 +
 sound/soc/fsl/imx-audmix.c                         |   79 +-
 sound/soc/fsl/imx-es8328.c                         |    1 -
 sound/soc/fsl/imx-pcm-fiq.c                        |    1 +
 sound/soc/fsl/imx-rpmsg.c                          |    2 -
 sound/soc/fsl/imx-spdif.c                          |  103 -
 sound/soc/fsl/lpc3xxx-i2s.c                        |  375 +++
 sound/soc/fsl/lpc3xxx-i2s.h                        |   80 +
 sound/soc/fsl/lpc3xxx-pcm.c                        |   72 +
 sound/soc/generic/audio-graph-card.c               |  113 +-
 .../soc/generic/audio-graph-card2-custom-sample.c  |    3 +-
 sound/soc/generic/audio-graph-card2.c              |  189 +-
 sound/soc/generic/simple-card-utils.c              |  133 +-
 sound/soc/generic/simple-card.c                    |   71 +-
 sound/soc/generic/test-component.c                 |    2 +-
 sound/soc/intel/avs/boards/es8336.c                |    8 +-
 sound/soc/intel/avs/pcm.c                          |    4 +-
 sound/soc/intel/avs/topology.c                     |    2 +-
 sound/soc/intel/boards/Kconfig                     |    2 +
 sound/soc/intel/boards/bdw-rt5650.c                |    2 +-
 sound/soc/intel/boards/ehl_rt5660.c                |    2 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c      |    4 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c       |    6 +-
 sound/soc/intel/boards/kbl_rt5660.c                |    2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |    8 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |    6 +-
 sound/soc/intel/boards/sof_board_helpers.h         |    2 -
 sound/soc/intel/boards/sof_da7219.c                |   57 +-
 sound/soc/intel/boards/sof_es8336.c                |    2 +-
 sound/soc/intel/boards/sof_maxim_common.c          |  114 +-
 sound/soc/intel/boards/sof_nau8825.c               |    2 +-
 sound/soc/intel/boards/sof_realtek_common.c        |    2 +-
 sound/soc/intel/boards/sof_rt5682.c                |    2 +-
 sound/soc/intel/boards/sof_sdw.c                   |   64 +-
 sound/soc/intel/boards/sof_sdw_common.h            |    6 +-
 sound/soc/intel/boards/sof_sdw_cs42l42.c           |   11 +-
 sound/soc/intel/boards/sof_sdw_rt5682.c            |   11 +-
 sound/soc/intel/boards/sof_sdw_rt700.c             |   11 +-
 sound/soc/intel/boards/sof_sdw_rt711.c             |   11 +-
 sound/soc/intel/boards/sof_sdw_rt_amp.c            |    2 +-
 sound/soc/intel/boards/sof_sdw_rt_dmic.c           |   14 +-
 .../soc/intel/boards/sof_sdw_rt_sdca_jack_common.c |   11 +-
 sound/soc/intel/boards/sof_wm8804.c                |    2 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |   50 +
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c  |   50 +
 sound/soc/intel/skylake/skl-topology.c             |    2 +-
 sound/soc/meson/axg-fifo.c                         |    2 +-
 sound/soc/meson/axg-frddr.c                        |    4 +-
 sound/soc/meson/axg-tdm.h                          |    2 +-
 sound/soc/meson/axg-toddr.c                        |    4 +-
 sound/soc/qcom/common.c                            |   35 +
 sound/soc/qcom/common.h                            |    3 +
 sound/soc/qcom/lpass-cpu.c                         |    4 +
 sound/soc/qcom/qdsp6/audioreach.c                  |   30 +-
 sound/soc/qcom/qdsp6/audioreach.h                  |    2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |   16 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |    3 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c            |   21 +-
 sound/soc/qcom/qdsp6/topology.c                    |   38 +-
 sound/soc/qcom/sc8280xp.c                          |   15 +
 sound/soc/qcom/x1e80100.c                          |   38 +
 sound/soc/rockchip/rockchip_i2s.c                  |    1 -
 sound/soc/rockchip/rockchip_spdif.c                |    1 -
 sound/soc/samsung/Kconfig                          |    2 +-
 sound/soc/samsung/aries_wm8994.c                   |    2 +-
 sound/soc/samsung/midas_wm1811.c                   |  350 ++-
 sound/soc/sh/fsi.c                                 |    2 +-
 sound/soc/sh/rcar/core.c                           |    2 +-
 sound/soc/soc-core.c                               |    4 +-
 sound/soc/soc-dai.c                                |   18 +-
 sound/soc/soc-dapm.c                               |   49 +-
 sound/soc/soc-ops.c                                |   26 +-
 sound/soc/soc-pcm.c                                |   26 +-
 sound/soc/soc-topology.c                           |  618 ++--
 sound/soc/soc-utils.c                              |   19 +-
 sound/soc/sof/intel/hda.c                          |    4 +-
 sound/soc/sof/intel/pci-tgl.c                      |    4 +-
 sound/soc/sof/ipc3-topology.c                      |   14 +-
 sound/soc/sof/ipc4-topology.c                      |   71 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c             |    2 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c             |    2 +-
 sound/soc/sof/sof-audio.c                          |   20 +-
 sound/soc/sof/sof-audio.h                          |    9 +-
 sound/soc/sof/topology.c                           |    4 +-
 sound/soc/tegra/tegra210_i2s.c                     |   71 +-
 sound/soc/tegra/tegra210_i2s.h                     |    2 +
 sound/spi/at73c213.c                               |    8 +-
 sound/usb/format.c                                 |   17 +-
 sound/usb/mixer.c                                  |   45 +-
 sound/usb/mixer_quirks.c                           |   20 +-
 sound/xen/xen_snd_front_alsa.c                     |    5 -
 tools/testing/selftests/alsa/mixer-test.c          |  143 +-
 tools/testing/selftests/alsa/pcm-test.c            |   70 +-
 352 files changed, 21518 insertions(+), 4532 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak4104.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/ak4554.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml
 rename Documentation/devicetree/bindings/sound/{ak4375.yaml => asahi-kasei,ak4375.yaml} (94%)
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4554.yaml
 rename Documentation/devicetree/bindings/sound/{ak4613.yaml => asahi-kasei,ak4613.yaml} (94%)
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4619.yaml
 rename Documentation/devicetree/bindings/sound/{ak4642.yaml => asahi-kasei,ak4642.yaml} (94%)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs4270.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42xx8.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs4270.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/cs42xx8.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/everest,es7134.txt
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es71x4.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml
 rename Documentation/devicetree/bindings/sound/{sgtl5000.yaml => fsl,sgtl5000.yaml} (97%)
 rename Documentation/devicetree/bindings/sound/{linux,spdif-dit.yaml => linux,spdif.yaml} (75%)
 delete mode 100644 Documentation/devicetree/bindings/sound/maxim,max98088.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98088.yaml
 rename Documentation/devicetree/bindings/sound/{zl38060.yaml => mscc,zl38060.yaml} (96%)
 create mode 100644 Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
 rename Documentation/devicetree/bindings/sound/{rt1019.yaml => realtek,rt1019.yaml} (90%)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5514.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5631.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5677.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5514.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5631.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5645.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5659.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5677.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/tas571x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
 rename Documentation/devicetree/bindings/sound/{tas2562.yaml => ti,tas2562.yaml} (97%)
 rename Documentation/devicetree/bindings/sound/{tas2770.yaml => ti,tas2770.yaml} (97%)
 rename Documentation/devicetree/bindings/sound/{tas27xx.yaml => ti,tas27xx.yaml} (97%)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas57xx.yaml
 rename Documentation/devicetree/bindings/sound/{tas5805m.yaml => ti,tas5805m.yaml} (95%)
 rename Documentation/devicetree/bindings/sound/{tlv320adcx140.yaml => ti,tlv320adcx140.yaml} (99%)
 rename Documentation/devicetree/bindings/sound/{wm8750.yaml => wlf,wm8750.yaml} (92%)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8782.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8804.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8782.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8804.txt
 create mode 100644 include/dt-bindings/sound/audio-graph.h
 create mode 100644 include/sound/rt1318.h
 create mode 100644 sound/pci/hda/patch_senarytech.c
 create mode 100644 sound/soc/codecs/ak4619.c
 create mode 100644 sound/soc/codecs/cs530x-i2c.c
 create mode 100644 sound/soc/codecs/cs530x.c
 create mode 100644 sound/soc/codecs/cs530x.h
 create mode 100644 sound/soc/codecs/es8311.c
 create mode 100644 sound/soc/codecs/es8311.h
 create mode 100644 sound/soc/codecs/rt1318.c
 create mode 100644 sound/soc/codecs/rt1318.h
 create mode 100644 sound/soc/codecs/rt1320-sdw.c
 create mode 100644 sound/soc/codecs/rt1320-sdw.h
 create mode 100644 sound/soc/codecs/wcd937x-sdw.c
 create mode 100644 sound/soc/codecs/wcd937x.c
 create mode 100644 sound/soc/codecs/wcd937x.h
 delete mode 100644 sound/soc/fsl/imx-spdif.c
 create mode 100644 sound/soc/fsl/lpc3xxx-i2s.c
 create mode 100644 sound/soc/fsl/lpc3xxx-i2s.h
 create mode 100644 sound/soc/fsl/lpc3xxx-pcm.c


