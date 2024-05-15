Return-Path: <linux-kernel+bounces-179660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3348C62F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83088B22787
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357604F1F1;
	Wed, 15 May 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TpdvzDei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p7CY2zav";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N+fsSLTv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/+GquGla"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6D4D9EC;
	Wed, 15 May 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715762291; cv=none; b=nna481DprjUMi2X9SkxneuHp+TpuFVSLMPPOa8MN/2IxgAAxMeLH8vQYBbGLfFpRiducAPenG4IEixN7V0neE/RPrzLqDEAldujZ5wKEL2QoxmSIhZT/baUoLHLQScLXObe9Or86Oi2m5/8pu4G524LJ7VDHEd7yO3wLBRgaBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715762291; c=relaxed/simple;
	bh=TFrLGkfWlSTg7r1kx5J50EvauuV0kIRj/Z2W8jIpD2A=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=nKWX2J1EqEaYBgvI1RI+LNDd73lUbamQ5ifzq3uDyZAaA75mO0aJP8qCjBVwX/nWkuHnBRv/aw2mzNP2DrlhoEKYv+SThP7vc8kFxJbC3iZk78tVGuCPDICLJcI2+/+7VJ0xOpOnQ1CZUudBp8GL621BFuxBQ4KaTi1aYfkEi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TpdvzDei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p7CY2zav; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N+fsSLTv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/+GquGla; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF0DB203DA;
	Wed, 15 May 2024 08:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715762284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ene7Y+jDlJK4lHXCMgwmOwK3n5Jp/bP7EYxhZaq6kQ=;
	b=TpdvzDeiXYQgAq1pcSpJd7BSE6502Qz5S8kIJlor0N5k/am63opLVEv/TTjauVFdetpOgW
	tkr1qdv45hUCLDZdtnJkUJxoPjc9Kwfl0q5xDixxDLFfpsJmipWZaHQ1IvnyxhXhW0qa5v
	76dj/zy13lyjJvDWTe8pWnAB4p7ujIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715762284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ene7Y+jDlJK4lHXCMgwmOwK3n5Jp/bP7EYxhZaq6kQ=;
	b=p7CY2zavpgXDioGyCR73fY/gTCHAys3cVxjV707cYnKkxVOwUKjQJtpXJsktsadL2qK5L3
	PdAyUP/tAq4BmuDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715762283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ene7Y+jDlJK4lHXCMgwmOwK3n5Jp/bP7EYxhZaq6kQ=;
	b=N+fsSLTv3PYhr3QwVLqIUWnhKoAhU/SnDT6tDv2ZAaQ8fwCL9m1e+lDePuxi+KwP+YkLvG
	ZvaeEAtuBgWhRvtL3KRLJcLTy7LHXibI2OQ8q3FexYJ8kYOoJ11PuZRt5GCcZFyRBIYuJ5
	FSz6fA6VmCJFyRo3uhsu/C49gDAIL9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715762283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ene7Y+jDlJK4lHXCMgwmOwK3n5Jp/bP7EYxhZaq6kQ=;
	b=/+GquGlafV1owUyUYaf9t+58pvVa37InSNyWFeiv9hyQG60VaLhlvmAHHeGvC2qdvI9jwp
	FUlzKc3F8FYx+GAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CB2A139B3;
	Wed, 15 May 2024 08:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 37vjJGt0RGZvLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 15 May 2024 08:38:03 +0000
Date: Wed, 15 May 2024 10:38:20 +0200
Message-ID: <87zfsr5v2b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates for 6.10-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]

Linus,

please pull sound updates for v6.10-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc1

The topmost commit is d731b1ed15052580b7b2f40559021012d280f1d9

----------------------------------------------------------------

sound updates for 6.10-rc1

This one became bigger than usual, not in the total size but rather
containing lots of small changes all over the places.  The majority of
changes are about ASoC, especially SOF / Intel stuff, and we see an
interesting work for ASoC DAPM graph visualization, while there are
many other code cleanup and refactoring, too.

Core:
- A deadlock fix at device disconnection
- A new tool dapm-graph for visualising the DAPM state

ASoC:
- Large updates throughout the Intel audio drivers
- Fixes and clarifications for the DAPM documentation
- Cleanups of accessors for driver data, module labelling, and for
  constification
- Modernsation and cleanup work in the Mediatek drivers
- Several fixes and features for the DaVinci I2S driver
- New drivers for several AMD and Intel platforms, Nuvoton NAU8325,
  Rockchip RK3308 and Texas Instruments PCM6240

HD-audio:
- Cleanup for CONFIG_PM dependencies
- Cirrus HD-audio codec fixes and quirks

Others:
- Series of tree-wide fixes in Makefiles to use *-y
- Additions of missing module descriptions
- Scarlett2 USB mixer enhancements
- A series of legacy emu10k1 fixes and improvements

----------------------------------------------------------------

Aleksandr Mishin (1):
      ASoC: kirkwood: Fix potential NULL dereference

Alexander Stein (1):
      ASoC: fsl: fsl_ssi: Add dev_err_probe if PCM DMA init fails

Amadeusz S³awiñski (16):
      ASoC: Intel: avs: i2s_test: Remove redundant dapm routes
      ASoC: Intel: avs: hdaudio: Use devm_kstrdup_const
      ASoC: Intel: avs: Use devm_kstrdup_const
      ASoC: Intel: avs: hdaudio: Constify probing_link
      ASoC: Intel: avs: es8336: Constify card_headset_pins
      ASoC: Intel: avs: nau8825: Constify card_headset_pins
      ASoC: Intel: avs: rt274: Constify card_headset_pins
      ASoC: Intel: avs: rt286: Constify card_headset_pins
      ASoC: Intel: avs: rt298: Constify card_headset_pins
      ASoC: Intel: avs: rt5663: Constify card_headset_pins
      ASoC: Intel: avs: rt5682: Constify card_headset_pins
      ASoC: Intel: avs: Restore stream decoupling on prepare
      ASoC: Intel: avs: Add assert_static to guarantee ABI sizes
      ASoC: Intel: avs: Switch to ACPI NHLT
      ASoC: Intel: avs: boards: Properly name input device
      ALSA: hda: intel-dsp-config: Switch to ACPI NHLT

Andy Shevchenko (7):
      ASoC: fsl: imx-es8328: Switch to using gpiod API
      ASoC: fsl: imx-es8328: Remove leftover gpio initialisation
      ASoC: soc-jack: Get rid of legacy GPIO support
      ASoC: soc.h: Don't use "proxy" headers
      ALSA: control: Use list_for_each_entry_safe()
      ASoC: atmel: tse850-pcm5142: Remove unused of_gpio.h
      ALSA: docs: Correct the kernel object suffix of target

AngeloGioacchino Del Regno (20):
      ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
      ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
      ASoC: mediatek: Commonize ADDA rate transform functions and enums
      ASoC: mediatek: Assign dummy when codec not specified for a DAI link
      ASoC: mediatek: Add common machine soundcard driver probe mechanism
      ASoC: mediatek: common: Constify struct mtk_sof_priv
      ASoC: mediatek: mt8188: Migrate to mtk_soundcard_common_probe
      ASoC: mediatek: mt8195: Migrate to mtk_soundcard_common_probe
      ASoC: mediatek: mt8192: Migrate to mtk_soundcard_common_probe
      ASoC: mediatek: mt8186: Migrate to mtk_soundcard_common_probe
      ASoC: mediatek: Add common snd_soc_ops .startup() callback
      ASoC: mediatek: mt8195: Migrate to the common mtk_soundcard_startup
      ASoC: mediatek: mt8192: Migrate to the common mtk_soundcard_startup
      ASoC: mediatek: mt8186-rt1019: Migrate to the common mtk_soundcard_startup
      ASoC: mediatek: Add common mtk_afe_component_probe callback
      ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb
      ASoC: mediatek: mt8186: Unify mt8186-mt6366 machine drivers
      ASoC: dt-bindings: mt8195: Document audio-routing and dai-link subnode
      ASoC: dt-bindings: mt8192: Document audio-routing and dai-link subnode
      ASoC: dt-bindings: mt8186: Document audio-routing and dai-link subnode

Animesh Agarwal (1):
      ASoC: dt-bindings: ti,pcm1681: Convert to dtschema

Arnaud Ferraris (2):
      ASoC: sun50i-codec-analog: Enable jack detection on startup
      ASoC: sun8i-codec: Implement jack and accessory detection

Arnd Bergmann (1):
      ASoC: codecs: rk3308: fix building without CONFIG_OF

Balamurugan C (1):
      ASoC: Intel: soc-acpi-intel-arl-match: Add rt711 sdca codec support

Bard Liao (26):
      ASoC: Intel: sof_sdw: use generic rtd_init function for Realtek SDW DMICs
      ASoC: Intel: sof_sdw: remove unused rt dmic rtd_init
      ASoC: Intel: sof_sdw_rt722_sdca: set rtd_init in codec_info_list[]
      ASoC: Intel: sof_sdw_rt722_sdca: use rt_dmic_rtd_init
      ASoC: rt715-sdca: rename dai name with rt715-sdca prefix
      ASoC: Intel: sof_sdw: change rt715-sdca dai name
      ASoC: Intel: change cs35l56 name_prefix
      Revert "ASoC: SOF: Intel: hda-dai-ops: reset device count for SoundWire DAIs"
      Revert "ASoC: SOF: Intel: hda-dai-ops: only allocate/release streams for first CPU DAI"
      ASoC: SOF: make dma_config_tlv be an array
      ASoC: SOF: Intel: hda-dai: set lowest N bits in ch_mask
      ASoC: SOF: Intel: hda-dai: set dma_stream_channel_map device
      ASoC: Intel: sof_sdw: add missing sof_sdw_rt_amp_init for Realtek multi-function codecs
      ASoC: Intel: sof_rt5682: use RT5682S_PLL1 if needed
      ASoC: Intel: sof_rt5682: add missing MAX98357A config
      ASoC: Intel: sof_sdw: add a space before cfg-amp in components
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: remove -sdca for new codecs
      ASoC: Intel: soc-acpi-intel-mtl-match: add cs42l43 only support
      ASoC: Intel: soc-acpi-intel-lnl-match: add cs42l43 only support
      ASoC: Intel: sof_sdw_cs_amp: rename Speakers to Speaker
      ASoC: Intel: sof_sdw: use generic name for controls/widgets
      ASoC: Intel: sof_sdw: add controls and dapm widgets in codec_info
      ASoC: Intel: sof_sdw: use .controls/.widgets to add controls/widgets
      ASoC: Intel: sof_sdw: add dai parameter to rtd_init callback
      ASoC: Intel: sof_sdw_rt_amp: use dai parameter
      ASoC: rt715-sdca-sdw: Fix wrong complete waiting in rt715_dev_resume()

Bastien Curutchet (13):
      ASoC: dt-bindings: davinci-mcbsp: convert McBSP bindings to yaml schema
      ASoC: dt-bindings: davinci-mcbsp: Add optional clock
      ASoC: ti: davinci-i2s: Remove the unused clk_input_pin attribute
      ASoC: ti: davinci-i2s: Replace dev_err with dev_err_probe
      ASoC: ti: davinci-i2s: Use external clock to drive sample rate generator
      ASoC: ti: davinci-i2s: Delete unnecessary assignment
      ASoC: ti: davinci-i2s: Add TDM support
      ASoC: ti: davinci-i2s: Add handling of BP_FC format
      ASoC: ti: davinci-i2s: Enable unexpected frame pulses detection
      ASoC: ti: davinci-i2s: Link free-run mode to SND_SOC_DAIFMT_[GATED/CONT]
      ASoC: ti: davinci-i2s: Add S24_LE to supported formats
      ASoC: dt-bindings: davinci-mcbsp: Add the 'ti,T1-framing-{rx/tx}' flags
      ASoC: ti: davinci-i2s: Add T1 framing support

Brent Lu (76):
      ASoC: Intel: board_helpers: support DAI link ID customization
      ASoC: Intel: sof_ssp_amp: use common module for DAI link generation
      ASoC: Intel: board_helpers: change dai link helpers to static function
      ASoC: Intel: sof_da7219: add rpl_mx98360_da7219 board config
      ASoC: Intel: sof_rt5682: support ALC5650 on RPL boards
      ASoC: Intel: sof_cs42l42: rename BT offload quirk
      ASoC: Intel: board_helpers: support sof_card_private initialization
      ASoC: Intel: sof_cs42l42: use common module for sof_card_private initialization
      ASoC: Intel: sof_nau8825: use common module for sof_card_private initialization
      ASoC: Intel: sof_rt5682: use common module for sof_card_private initialization
      ASoC: Intel: sof_ssp_amp: use common module for sof_card_private initialization
      ASoC: Intel: sof_da7219: use common module for DAI link generation
      ASoC: Intel: sof_da7219: add codec exit function
      ASoC: Intel: sof_da7219: add SOF_DA7219_MCLK_EN quirk
      ASoC: Intel: sof_da7219: board id cleanup for jsl boards
      ASoC: Intel: sof_da7219: board id cleanup for adl boards
      ASoC: Intel: sof_da7219: board id cleanup for rpl boards
      ASoC: Intel: sof_rt5682: remove unnecessary idisp HDMI quirk
      ASoC: Intel: sof_ssp_amp: remove unnecessary idisp HDMI quirk
      ASoC: Intel: sof_nau8825: remove sof_nau8825 board id
      ASoC: Intel: sof_rt5682: board id cleanup for cml boards
      ASoC: Intel: ssp-common: relocate source file
      ASoC: Intel: ssp-common: relocate header file
      ASoC: Intel: ssp-common: naming convention change
      ASoC: Intel: ssp-common: module name change
      ASoC: Intel: ssp-common: delete module
      ASoC: Intel: ssp-common: get codec tplg suffix function
      ASoC: SOF: Intel: support tplg suffix detection
      ASoC: Intel: sof_nau8825: mach cleanup for adl boards
      ASoC: Intel: sof_nau8825: mach cleanup for rpl boards
      ASoC: Intel: sof_nau8825: add mtl_nau8825_def for mtl boards
      ASoC: Intel: sof_rt5682: mach cleanup for tgl boards
      ASoC: Intel: sof_rt5682: mach cleanup for adl boards
      ASoC: Intel: sof_rt5682: mach cleanup for rpl boards
      ASoC: Intel: sof_rt5682: mach cleanup for mtl boards
      ASoC: Intel: sof_cs42l42: board id cleanup for adl boards
      ASoC: Intel: sof_cs42l42: mach cleanup for adl boards
      ASoC: Intel: sof_cs42l42: add rpl_cs42l42_def for rpl boards
      ASoC: Intel: sof_cs42l42: add mtl_cs42l42_def for mtl boards
      ASoC: Intel: sof_da7219: mach cleanup for adl boards
      ASoC: Intel: sof_da7219: mach cleanup for rpl boards
      ASoC: Intel: sof_da7219: add mtl_da7219_def for mtl boards
      ASoC: Intel: sof_realtek_common: support 4xALC1011 amplifier
      ASoC: Intel: sof_rt5682: support ALC1011 on cml boards
      ASoC: Intel: cml_rt1011_rt5682: delete driver
      ASoC: Intel: nau8825/rt5682: move speaker widget to common modules
      ASoC: Intel: sof_maxim_common: support MAX98390 on cml boards
      ASoC: Intel: sof_da7219: support MAX98390
      ASoC: Intel: sof_da7219: add cml_da7219_def for cml boards
      ASoC: Intel: sof_da7219: support MAX98390 on cml boards
      ASoC: Intel: bxt_da7219_max98357a: remove MAX98390 support
      ASoC: Intel: sof_da7219: support MAX98357A
      ASoC: Intel: sof_da7219: support MAX98357A on cml boards
      ASoC: Intel: bxt_da7219_max98357a: remove cml support
      ASoC: Intel: sof_da7219: add glk_da7219_def for glk boards
      ASoC: Intel: sof_da7219: support MAX98357A on glk boards
      ASoC: Intel: bxt_da7219_max98357a: remove glk support
      ASoC: Intel: sof_rt5682: add glk_rt5682_def for glk boards
      ASoC: Intel: sof_rt5682: support MAX98357A on glk boards
      ASoC: Intel: glk_rt5682_max98357a: delete driver
      ASoC: Intel: sof-rt5682: add mclk_en to sof_rt5682_private
      ASoC: Intel: sof-rt5682: remove SOF_RT5682_MCLK_BYTCHT_EN
      ASoC: Intel: sof_rt5682: add icl_rt5682_def for icl boards
      ASoC: Intel: sof-rt5682: add driver_data to sof_rt5682 board
      ASoC: Intel: sof-rt5682: setup pll_id only when needed
      ASoC: Intel: sof-rt5682: get bclk frequency from topology
      ASoC: Intel: sof-rt5682: support bclk as PLL source on rt5682s
      ASoC: Intel: sof-rt5682: remove DMI quirk for hatch
      ASoC: Intel: sof_rt5682: board id cleanup for mtl boards
      ASoC: Intel: realtek-common: remove 2-spk rt1015p config
      ASoC: Intel: maxim-common: add max_98373_dai_link function
      ASoC: Intel: sof_da7219: use max_98373_dai_link function
      ASoC: Intel: sof_nau8825: use max_98373_dai_link function
      ASoC: Intel: sof_rt5682: use max_98373_dai_link function
      ASoC: Intel: sof_sdw: add max98373 dapm routes
      ASoC: Intel: maxim-common: change max98373 data to static

Cezary Rojewski (29):
      ASoC: Intel: Disable route checks for Skylake boards
      ASoC: topology: Do not ignore route checks when parsing graphs
      ASoC: Intel: avs: ssm4567: Do not ignore route checks
      ASoC: Intel: avs: ssm4567: Board cleanup
      ASoC: Intel: Skylake: Remove soc-topology ABI v4 support
      ASoC: topology: Remove ABI v4 support
      ASoC: topology: Cleanup after ABI v4 support removal
      ASoC: topology: Remove obsolete ABI v4 structs
      ASoC: Intel: avs: Fix debug-slot offset calculation
      ASoC: Intel: avs: Silence false-positive memcpy() warnings
      ASoC: Intel: avs: Fix config_length for config-less copiers
      ASoC: Intel: avs: Fix ASRC module initialization
      ASoC: Intel: avs: Replace risky functions with safer variants
      ASoC: Intel: avs: Fix potential integer overflow
      ASoC: Intel: avs: Test result of avs_get_module_entry()
      ASoC: Intel: avs: Remove dead code
      ASoC: Intel: avs: Wake from D0ix when starting streaming
      ASoC: Intel: avs: Init debugfs before booting firmware
      ASoC: Intel: avs: Rule invalid buffer and period sizes out
      ASoC: Intel: avs: New IRQ handling implementation
      ASoC: Intel: avs: Remove unused IRQ-related code
      ASoC: pcm: Reverse iterate DAIs when shutting them down
      ASoC: Intel: avs: Relocate HDA BE DAI specific operations
      ASoC: Intel: avs: Remove redundancy around DAI shutdown
      ASoC: Intel: avs: Store pointer to adev in DAI dma_data
      ASoC: Intel: avs: Remove redundancy around DAI startup
      ASoC: Intel: avs: Remove redundancy around DAI prepare
      ASoC: Intel: avs: Store pointer to link_stream in dma_data
      ASoC: Intel: avs: Clean up hw constraints initialization

Chaitanya Kumar Borah (1):
      ALSA: hda: Add Intel BMG PCI ID and HDMI codec vid

Chancel Liu (5):
      ASoC: fsl: imx-pcm-rpmsg: Register component with rpmsg channel name
      ASoC: fsl: imx-audio-rpmsg: Register device with rpmsg channel name
      ASoC: fsl: Let imx-audio-rpmsg register platform device for card
      ASoC: fsl: fsl_rpmsg: Register CPU DAI with name of rpmsg channel
      ASoC: fsl: imx-rpmsg: Update to correct DT node

Charles Keepax (28):
      ASoC: intel: sof_sdw: Make find_codec_info_part() return a pointer
      ASoC: intel: sof_sdw: Make find_codec_info_acpi() return a pointer
      ASoC: intel: sof_sdw: Make find_codec_info_dai() return a pointer
      ASoC: intel: sof_sdw: Only pass codec_conf pointer around
      ASoC: intel: sof_sdw: Set channel map directly from endpoints
      ASoC: Intel: sof_sdw: Move get_codec_dai_by_name() into sof_sdw itself
      ASoC: Intel: sof_sdw: Move flags to private struct
      ASoC: Intel: sof_sdw: Only pass dai_link pointer around
      ASoC: Intel: sof_sdw: Use for_each_set_bit
      ASoC: Intel: sof_sdw: Factor out SSP DAI creation
      ASoC: Intel: sof_sdw: Factor out DMIC DAI creation.
      ASoC: Intel: sof_sdw: Factor out HDMI DAI creation
      ASoC: Intel: sof_sdw: Factor out BlueTooth DAI creation
      ASoC: Intel: sof_sdw: Factor out codec name generation
      ASoC: Intel: sof_sdw: Remove no longer supported quirk
      ASoC: intel: soc-acpi: Add missing cs42l43 endpoints
      ASoC: Intel: sof-sdw: Add new code for parsing the snd_soc_acpi structs
      ASoC: Intel: sof_sdw: Move counting and codec_conf to new parsing
      ASoC: Intel: sof_sdw: Move ignore_pch_dmic to new parsing
      ASoC: Intel: sof_sdw: Move append_dai_type to new parsing
      ASoC: Intel: sof_sdw: Move generation of DAI links to new parsing
      ASoC: intel: sof_sdw: Factor out SoundWire DAI creation
      ASoC: Intel: sof_sdw: Don't pass acpi_link_adr to init functions
      ASoC: Intel: sof_sdw: Remove redundant initialisations
      ASoC: Intel: sof_sdw: Add quirk for optional codec speakers
      ASoC: Intel: sof_sdw: Add support for cs42l43 optional speaker output
      ASoC: Intel: sof_sdw: Delay update of the codec_conf array
      ASoC: Intel: sof_sdw: Add callbacks to register sidecar devices

Colin Ian King (3):
      ASoC: codecs: tas2780: remove redundant assignments to variable ret
      ASoc: PCM6240: Fix spelling mistake: "deley" -> "delay"
      ALSA: kunit: make read-only array buf_samples static const

Dan Carpenter (5):
      ASoC: SOF: Disable pointless writes to debugfs file
      ASoC: SOF: Clean up sof_ipc_flood_dfs_write()
      ASoC: Intel: sof_rt5682: Fix uninitialized variable in probe
      ASoC: soc-card: soc-card-test: Fix some error handling in init()
      ASoC: cs35l41: Delete unnecessary condition in cs35l41_pcm_hw_params()

Dragan Simic (1):
      ASoC: pcm: perform power-down delay checks a bit faster

Fabio Estevam (1):
      ASoC: dt-bindings: fsl-asoc-card: Document fsl,imx25-pdk-sgtl5000

Francesco Dolcini (1):
      ASoC: nau8822: Remove unused member from struct

Frank Li (7):
      ASoC: dt-bindings: fsl-audmix: Convert fsl,audmix.txt to yaml
      ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt to yaml
      ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains property
      ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
      ASoC: dt-bindings: fsl-sai: allow only one dma-names
      ASoC: dt-bindings: fsl-esai: Remove 'fsl,*' from required list
      ASoC: dt-bindings: fsl-esai: Add ref: dai-common.yaml

Geert Uytterhoeven (2):
      ASoC: codecs: Rockchip on-SoC codecs should depend on ARCH_ROCKCHIP
      ASoC: dt-bindings: renesas: Fix R-Car Gen4 SoC-specific compatibles

Geoffrey D. Bennett (16):
      ALSA: scarlett2: Move initialisation code lower in the source
      ALSA: scarlett2: Implement handling of the ACK notification
      ALSA: scarlett2: Add support for reading from flash
      ALSA: scarlett2: Rename gen4_write_addr to param_buf_addr
      ALSA: scarlett2: Add pbuf field to struct scarlett2_config
      ALSA: scarlett2: Add support for config items with size = 32
      ALSA: scarlett2: Add additional input configuration parameters
      ALSA: scarlett2: Define the maximum preamp input gain per-config-set
      ALSA: scarlett2: Define autogain status texts per-config-set
      ALSA: scarlett2: Add input mute controls
      ALSA: scarlett2: Add DSP controls
      ALSA: scarlett2: Add support for Focusrite Vocaster One and Two
      ALSA: scarlett2: Add autogain target controls
      ALSA: scarlett2: Add Bluetooth volume control for Vocaster Two
      ALSA: scarlett2: Add S/PDIF source selection controls
      ALSA: scarlett2: Increase mixer range to +12dB

Gustavo A. R. Silva (1):
      ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning

Hsin-Te Yuan (1):
      ASoC: mediatek: mt8192: fix register configuration for tdm

Jaroslav Kysela (1):
      selftests/alsa: make dump_config_tree() as void function

Joao Schim (1):
      ASoC: sunxi: DMIC: Add controls for adjusting the mic gains

John Watts (3):
      ASoC: soc-dai: Note valid values of sysclock direction
      ASoC: sunxi: sun4i-i2s: Support 32-bit audio formats
      ASoC: sunxi: sun4i-i2s: Fix pcm_formats type specification

Junhao Pei (1):
      ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7

Kailang Yang (1):
      ALSA: hda/realtek - fixed headset Mic not show

Kartik Agarwala (3):
      ASoC: dt-bindings: wm8776: Convert to dtschema
      ASoC: dt-bindings: wm8974: Convert to dtschema
      ASoC: dt-bindings: mt2701-wm8960: Convert to dtschema

Krzysztof Kozlowski (54):
      ASoC: loongson: i2s/pci: drop driver owner assignment
      ASoC: tlv320aic32x4-spi: drop driver owner assignment
      ASoC: tlv320aic3x-spi: drop driver owner assignment
      ASoC: max98373-sdw: drop driver owner assignment
      ASoC: rt1017-sdca-sdw: drop driver owner assignment
      ASoC: rt1308-sdw: drop driver owner assignment
      ASoC: rt1316-sdw: drop driver owner assignment
      ASoC: rt1318-sdw: drop driver owner assignment
      ASoC: rt5682-sdw: drop driver owner assignment
      ASoC: rt700-sdw: drop driver owner assignment
      ASoC: rt711-sdca-sdw: drop driver owner assignment
      ASoC: rt711-sdw: drop driver owner assignment
      ASoC: rt712-sdca-dmic: drop driver owner assignment
      ASoC: rt712-sdca-sdw: drop driver owner assignment
      ASoC: rt715-sdca-sdw: drop driver owner assignment
      ASoC: rt715-sdw: drop driver owner assignment
      ASoC: rt722-sdca-sdw: drop driver owner assignment
      ASoC: sdw-mockup: drop driver owner assignment
      ASoC: wcd934x: Drop unneeded MODULE_ALIAS
      ASoC: samsung: i2s: Drop unneeded MODULE_ALIAS
      ASoC: amd: acp-da7219-max98357a: Constify regulator_ops
      ASoC: SOF: debug: Constify local snd_sof_dsp_ops
      ASoC: SOF: ipc3: Constify local snd_sof_dsp_ops
      ASoC: SOF: pcm: Constify local snd_sof_dsp_ops
      ASoC: SOF: Constify stored pointer to snd_sof_dsp_ops
      ASoC: SOF: intel: pci-tng: Constify snd_sof_dsp_ops
      ASoC: SOF: intel: hda: Constify snd_sof_dsp_ops
      ASoC: SOF: amd: acp: Constify snd_sof_dsp_ops
      ASoC: SOF: imx8: Constify snd_sof_dsp_ops
      ASoC: SOF: imx8m: Constify snd_sof_dsp_ops
      ASoC: SOF: imx8ulp: Constify snd_sof_dsp_ops
      ASoC: SOF: intel: bdw: Constify snd_sof_dsp_ops
      ASoC: SOF: intel: byt: Constify snd_sof_dsp_ops
      ASoC: SOF: mediatek: mt8186: Constify snd_sof_dsp_ops
      ASoC: SOF: mediatek: mt8195: Constify snd_sof_dsp_ops
      ASoC: Use inline function for type safety in snd_soc_substream_to_rtd()
      ASoC: qcom: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: tegra: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: ti: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: arm: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: amd: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: fsl: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: img: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: kirkwood: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: loongson: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: mediatek: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: meson: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: samsung: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: sunxi: Use snd_soc_substream_to_rtd() for accessing private_data
      ASoC: qcom: Constify static snd_pcm_hardware
      ASoC: fsl: Constify static snd_pcm_hardware
      ASoC: meson: Constify static snd_pcm_hardware
      ASoC: uniphier: Constify static snd_pcm_hardware
      ASoC: qcom: q6apm-dai: drop unused 'q6apm_dai_rtd' fields

Kuninori Morimoto (9):
      ASoC: rsnd: cleanup regmap table
      ASoC: rsnd: don't get resource from ID
      ASoC: rsnd: rename rsnd_is_e3() to rsnd_is_gen3_e3()
      ASoC: rsnd: R-Car Gen1/Gen2 exception
      ASoC: rsnd: no exception for SCU
      ASoC: dt-bindings: renesas: add R8A779H0 V4M
      ASoC: dt-bindings: renesas,rsnd: add missing renesas,rcar_sound-gen4
      ASoC: audio-graph-card2: remove unneeded of_node_get()
      ASoC: audio-graph-card2: call of_node_get() before of_get_next_child()

Laurentiu Mihalcea (2):
      ASoC: SOF: imx: drop usage of the imx8_*_clocks API
      ASoC: SOF: imx: remove imx8_*_clocks API

Luca Ceresoli (19):
      ASoC: dt-bindings: Add Rockchip RK3308 internal audio codec
      ASoC: core: add SOC_DOUBLE_RANGE_TLV() helper macro
      ASoC: codecs: Add RK3308 internal audio codec driver
      ASoC: codecs: rk3308: fix "defined but not used" warning on !OF
      ASoC: codecs: rk3308: depend on ARM64 || COMPILE_TEST
      ASoC: dapm: debugfs: add component to route lines
      ASoC: dapm: debugfs: show the widget type
      ASoC: dapm-graph: new tool to visualize DAPM state
      ASoC: doc: dapm: fix typos
      ASoC: doc: dapm: fix struct name
      ASoC: doc: dapm: minor rewording
      ASoC: doc: dapm: remove dash after colon
      ASoC: doc: dapm: replace "map" with "graph"
      ASoC: doc: dapm: extend initial descrption
      ASoC: doc: dapm: describe how widgets and routes are registered
      ASoC: doc: dapm: fix and improve section "Registering DAPM controls"
      ASoC: doc: dapm: improve section "Codec/DSP Widget Interconnections"
      ASoC: doc: dapm: update section "DAPM Widget Events"
      ASoC: doc: dapm: update event types

Mac Chiang (1):
      ASoC: Intel: soc-acpi-intel-lnl-match: adds RT714 and RT1318 support

Maciej Strozek (1):
      ASoC: intel: sof_sdw: Add support for cs42l43-cs35l56 sidecar amps

Manuel Barrio Linares (1):
      ALSA: usb-audio: Add sampling rates support for Mbox3

Mohammad Rafi Shaik (2):
      ASoC: dt-bindings: qcom,sm8250: Add QCM6490 snd QCS6490 sound card
      ASoC: qcom: sc8280xp: Add support for QCM6490 and QCS6490

Mohammad Shehar Yaar Tausif (3):
      ASoC: dt-bindings: tegra20-das: Convert to schema
      ASoC: dt-bindings: tegra20-ac97: convert to dt schema
      ASoC: dt-bindings: tegra30-i2s: convert to dt schema

Nathan Chancellor (1):
      ALSA: scarlett2: Zero initialize ret in scarlett2_ag_target_ctl_get()

Ondrej Jirman (1):
      ASoC: sun8i-codec: Fix build with CONFIG_SND_JACK_INPUT_DEV disabled

Oswald Buddenhagen (21):
      ALSA: emux: fix /proc teardown at module unload
      ALSA: emux: prune unused parameter from snd_soundfont_load_guspatch()
      ALSA: emux: fix validation of snd_emux.num_ports
      ALSA: emux: fix init of patch_info.truesize in load_data()
      ALSA: emu10k1: prune vestiges of SNDRV_SFNT_SAMPLE_{BIDIR,REVERSE}_LOOP support
      ALSA: emux: centralize & improve patch info validation
      ALSA: emux: improve patch ioctl data validation
      ALSA: emu10k1: move patch loader assertions into low-level functions
      ALSA: emu10k1: fix sample signedness issues in wavetable loader
      ALSA: emu10k1: fix playback of 8-bit wavetable samples
      ALSA: emu10k1: merge conditions in patch loader
      ALSA: emu10k1: fix wavetable offset recalculation
      ALSA: emu10k1: de-duplicate size calculations for 16-bit samples
      ALSA: emu10k1: improve cache behavior documentation
      ALSA: emu10k1: fix wavetable playback position and caching, take 2
      ALSA: emu10k1: shrink blank space in front of wavetable samples
      ALSA: emux: simplify snd_sf_list.callback handling
      ALSA: emu10k1: simplify E-MU card FPGA reset sequence
      ALSA: emu10k1: make snd_emu1010_load_firmware_entry() void
      ALSA: emu10k1: move snd_emu1010_load_firmware_entry() to io.c
      ALSA: emu10k1: move code for entering E-MU card FPGA programming mode

Pavel Hofman (3):
      ALSA: aloop: add DSD formats
      ALSA: pcm: add support for 705.6kHz and 768kHz sample rates
      ALSA: aloop: add support for up to 768kHz sample rate

Peter Ujfalusi (22):
      ASoC: SOF: Intel: hda: Create debugfs file to force a clean DSP boot
      ASoC: SOF: Intel: mtl: Correct rom_status_reg
      ASoC: SOF: Intel: lnl: Correct rom_status_reg
      ASoC: SOF: Intel: mtl: Disable interrupts when firmware boot failed
      ASoC: SOF: Intel: mtl: Implement firmware boot state check
      ASoC: SOF: Intel: hda-dsp/mtl: Add support for ACE ROM state codes
      ASoC: SOF: Intel: mtl: Correct the mtl_dsp_dump output
      ASoC: SOF: Intel: tgl: Add fw_regs area to debugfs map for IPC4
      ASoC: SOF: Intel: mtl: Add fw_regs area to debugfs map
      ASoC: SOF: Intel: lnl: Add fw_regs area to debugfs map
      ALSA: hda: Introduce flags to force commands via PIO instead of CORB
      ALSA: hda: hdac_controller: Implement support for use_pio_for_commands mode
      ALSA: pci: hda: hda_controller: Add support for use_pio_for_commands mode
      ALSA: hda: Intel: Select AZX_DCAPS_PIO_COMMANDS for Lunar Lake
      ASoC: SOF: Intel: hda-bus: Use PIO mode for Lunar Lake
      ASoC: Intel: skl_hda_dsp_generic: Allocate snd_soc_card dynamically
      ASoC: Intel: skl_hda_dsp_generic: Use devm_kasprintf for the components string
      ASoC: Intel: sof_sdw: Allocate snd_soc_card dynamically
      ASoC: SOF: debug: Handle cases when fw_lib_prefix is not set, NULL
      ASoC: SOF: ipc4-topology: Advertise passthrough capable PCMs (using ChainDMA)
      ASoC: SOF: ipc4-topology: Allow selective update in sof_ipc4_update_hw_params
      ASoC: SOF: ipc4-topology: Correct DAI copier config and NHLT blob request

Pierre-Louis Bossart (49):
      ASoC: hdac_hda: improve error logs
      ASoC: SOF: amd: acp-loader: abort firmware download on write error
      ASoC: SOF: ipc4-priv: align prototype and function declaration
      ASoC: SOF: ipc4-topology: remove shadowed variable
      ASoC: SOF: Intel: hda-dai: fix channel map configuration for aggregated dailink
      ASoC: SOF: Intel: hda-dai: add helpers to set dai config
      ASoC: SOF: Intel: set the DMA TLV device as dai_index
      ASoC: SOF: Intel: hda: extend signature of sdw_hda_dai_hw_params()
      ASoC: SOF: IPC4: extend dai_data with node_id
      ASoC: SOF: Intel: hda: move helper to static inline
      ASoC: SOF: sof-audio: revisit sof_pcm_stream_free() error handling and logs
      ASoC: SOF: pcm: simplify sof_pcm_hw_free() with helper
      ASoC: SOF: pcm: add pending_stop state variable
      ASoC: SOF: pcm: reset all PCM sources in case of xruns
      ASoC: SOF: Intel: hda-loader: add flag to tag ICCMAX stream
      ASoC: SOF: Intel: hda-loader: change signature of code loader helpers
      ASoC: SOF: Intel: don't ignore IOC interrupts for non-audio transfers
      ASoC: SOF: Intel: hda-stream: clarify comment
      ASoC: SOF: Intel: hda-ctrl: add missing WAKE_STS clear
      ASoC: SOF: Intel: lnl: add helper to detect SoundWire wakes
      ASoC: SOF: Intel: hda-codec: preserve WAKEEN values
      ASoC: SOF: Intel: hda-ctrl: only clear WAKESTS for HDaudio codecs
      ASoC: Intel: soc-acpi: add support for HP Omen14 SoundWire configuration
      ASoC: Intel: sof_sdw: add JD2 quirk for HP Omen 14
      ASoC: Intel: sof_sdw: add quirk for Dell SKU 0C0F
      ASoC: Intel: sof_sdw: remove FOUR_SPEAKER quirks
      ASoC: Intel: soc-acpi: mtl: add Dell SKU 0C64 and 0CC6
      ASoC: Intel: soc-acpi: mtl: add support for Acer Swift Go 14
      ASoC: Intel: sof-sdw: don't set card long_name
      ASoC: Intel: sof-sdw: really remove FOUR_SPEAKER quirk
      ASoC: SOF: Intel: hda: simplify and reduce indentation for hda_sdw_machine_select()
      ASoC: SOF: Intel: hda: list SoundWire peripherals on mismatch
      ASoC: SOF: Intel: discard SoundWire configuration if HDaudio codec is reported
      ASoC: SOF: Intel: hda-stream: export stream_get_position() helper
      ASoC: SOF: Intel: regroup all SoundWire/Intel functions in hda.c
      ASoC: SOF: Intel: start splitting top-level from common parts
      ASoC: SOF: Intel: move common code from hda.c
      ASoC: SOF: Intel: move tracepoint creation
      ASoC: SOF: Intel: remove circular dependency on hda_sdw_process_wakeen()
      ASoC: SOF: Intel: move hda.c to different module
      ASoC: SOF: Intel: clarify Copyright information
      ASoC: Intel: boards: clarify Copyright information
      ASoC: Intel: common: clarify Copyright information
      ASoC: codecs: Intel: clarify Copyright information
      ASoC: Intel: catpt: clarify Copyright information
      ASoC: Intel: avs: clarify Copyright information
      ASoC: soc-topology-test: clarify Copyright information
      ALSA: hda: clarify Copyright information
      ALSA/ASoC: include: clarify Copyright information

Ranjani Sridharan (2):
      ASoC: SOF: Intel: hda: Clear Soundwire node ID during BE DAI hw_free
      ASoC: SOF: ipc4-topology: Save the ALH DAI index during hw_params

Richard Fitzgerald (9):
      ALSA: control: Introduce snd_ctl_find_id_mixer_locked()
      ASoC: soc-card: Use snd_ctl_find_id_mixer() instead of open-coding
      ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol
      ASoC: wm_adsp: Include array_size.h
      ASoC: cs35l56: Include array_size.h
      ALSA: hda: cs35l41: Remove redundant argument to cs35l41_request_firmware_file()
      ALSA: hda/cs_dsp_ctl: Use private_free for control cleanup
      ALSA: hda: hda_component: Initialize shared data during bind callback
      ALSA: hda: cs35l56: Fix lifetime of cs_dsp instance

Samuel Holland (2):
      ASoC: sun50i-codec-analog: Move suspend/resume to set_bias_level
      ASoC: sun8i-codec: Enable bus clock at STANDBY and higher bias

Seven Lee (6):
      ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
      ASoC: nau8325: new driver
      ASoC: nau8325: Revise soc_enum structure definition.
      ASoC: dt-bindings: nau8821: Add delay control for ADC
      ASoC: nau8821: Add delay control for ADC
      ASoC: nau8821: Remove redundant ADC controls

Shenghao Ding (5):
      ASoc: PCM6240: Create PCM6240 Family driver code
      ASoc: PCM6240: Create header file for PCM6240 Family driver code
      ASoc: PCM6240: Add compile item for PCM6240 Family driver
      ASoc: dt-bindings: PCM6240: Add initial DT binding
      ASoC: tas2781: Fix a warning reported by robot kernel test

Shengjiu Wang (5):
      ASoC: dt-bindings: fsl-asoc-card: convert to YAML
      ASoC: dt-bindings: imx-audio-spdif: convert to YAML
      ASoC: fsl-asoc-card: add wm8904 codec support
      ASoC: dt-bindings: fsl-asoc-card: Add compatbile string for wm8904 codec
      ASoC: dt-bindings: fsl,ssi: Convert to YAML

Simon Trimmer (5):
      firmware: cs_dsp: Add locked wrappers for coeff read and write
      ASoC: wm_adsp: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
      ALSA: hda: hda_cs_dsp_ctl: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
      ASoC: wm_adsp: Remove notification of driver write
      ALSA: hda: hda_cs_dsp_ctl: Remove notification of driver write

Stefan Binding (11):
      ALSA: hda: cs35l41: Set the max PCM Gain using tuning setting
      ALSA: hda: cs35l41: Support HP Omen models without _DSD
      ALSA: hda/realtek: Add quirks for HP Omen models using CS35L41
      ALSA: hda: cs35l41: Update DSP1RX5/6 Sources for DSP config
      ALSA: hda: cs35l41: Use shared cs-amp-lib to apply calibration
      ALSA: hda: cs35l41: Remove Speaker ID for Lenovo Legion slim 7 16ARHA7
      ALSA: hda: cs35l41: Support Lenovo 13X laptop without _DSD
      ALSA: hda/realtek: Add quirks for Lenovo 13X
      ALSA: hda: cs35l41: Ignore errors when configuring IRQs
      ALSA: hda: cs35l41: Add support for ASUS ROG 2024 Laptops
      ALSA: hda/realtek: Add support for ASUS Zenbook 2024 HN7306W

Steven 'Steve' Kendall (1):
      ALSA: usb-audio: Add name for HP Engage Go dock

Steven Rostedt (1):
      ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its value

Takashi Iwai (75):
      ALSA: seq: dummy: Allow UMP conversion
      ASoC: core: Use *-y instead of *-objs in Makefile
      ASoC: codecs: Use *-y instead of *-objs in Makefile
      ASoC: adi: Use *-y instead of *-objs in Makefile
      ASoC: amd: Use *-y instead of *-objs in Makefile
      ASoC: apple: Use *-y instead of *-objs in Makefile
      ASoC: atmel: Use *-y instead of *-objs in Makefile
      ASoC: au1x: Use *-y instead of *-objs Makefile
      ASoC: bcm: Use *-y instead of *-objs in Makefile
      ASoC: cirrus: Use *-y instead of *-objs in Makefile
      ASoC: fsl: Use *-y instead of *-objs in Makefile
      ASoC: generic: Use *-y instead of *-objs in Makefile
      ASoC: intel: Use *-y instead of *-objs in Makefile
      ASoC: jz4740: Use *-y instead of *-objs in Makefile
      ASoC: kirkwood: Use *-y instead of *-objs in Makefile
      ASoC: loongson: Use *-y instead of *-objs in Makefile
      ASoC: mediatek: Use *-y instead of *-objs in Makefile
      ASoC: meson: Use *-y instead of *-objs in Makefile
      ASoC: mxs: Use *-y instead of *-objs in Makefile
      ASoC: pxa: Use *-y instead of *-objs in Makefile
      ASoC: qcom: Use *-y instead of *-objs in Makefile
      ASoC: rockchip: Use *-y instead of *-objs in Makefile
      ASoC: samsung: Use *-y instead of *-objs in Makefile
      ASoC: sh: Use *-y instead of *-objs in Makefile
      ASoC: SOF: Use *-y instead of *-objs in Makefile
      ASoC: spear: Use *-y instead of *-objs in Makefile
      ASoC: sprd: Use *-y instead of *-objs in Makefile
      ASoC: sti: Use *-y instead of *-objs in Makefile
      ASoC: stm: Use *-y instead of *-objs in Makefile
      ASoC: tegra: Use *-y instead of *-objs in Makefile
      ASoC: ti: Use *-y instead of *-objs in Makefile
      ASoC: uniphier: Use *-y instead of *-objs in Makefile
      ASoC: ux500: Use *-y instead of *-objs in Makefile
      ASoC: xilinx: Use *-y instead of *-objs in Makefile
      ASoC: xtensa: Use *-y instead of *-objs in Makefile
      ASoC: ab8500: Add missing module description
      ASoC: sigmadsp: Add missing module description
      ASoC: qcom: Add missing module descriptions
      ASoC: dmaengine: Add missing module description
      ASoC: topology-test: Add missing module description
      ASoC: ux500: Add missing module description
      ASoC: xilinx: Add missing module descriptions
      ALSA: hda: intel: Reduce CONFIG_PM dependencies
      ALSA: hda: codec: Reduce CONFIG_PM dependencies
      ALSA: hda: generic: Reduce CONFIG_PM dependencies
      ALSA: hda: analog: Reduce CONFIG_PM dependencies
      ALSA: hda: ca0132: Reduce CONFIG_PM dependencies
      ALSA: hda: cirrus: Reduce CONFIG_PM dependencies
      ALSA: hda: conexant: Reduce CONFIG_PM dependencies
      ALSA: hda: cs4809: Reduce CONFIG_PM dependencies
      ALSA: hda: hdmi: Reduce CONFIG_PM dependencies
      ALSA: hda: realtek: Reduce CONFIG_PM dependencies
      ALSA: hda: sigmantel: Reduce CONFIG_PM dependencies
      ALSA: hda: via: Reduce CONFIG_PM dependencies
      ALSA: core: Use *-y instead of *-objs in Makefile
      ALSA: pci: Use *-y instead of *-objs in Makefile
      ALSA: hda: Use *-y instead of *-objs in Makefile
      ALSA: isa: Use *-y instead of *-objs in Makefile
      ALSA: usb: Use *-y instead of *-objs in Makefile
      ALSA: drivers: Use *-y instead of *-objs in Makefile
      ALSA: firewire: Use *-y instead of *-objs in Makefile
      ALSA: aoa: Use *-y instead of *-objs in Makefile
      ALSA: misc: Use *-y instead of *-objs in Makefile
      ALSA: ac97: legacy: Add missing module description
      ALSA: ac97: bus: Add missing module description
      ALSA: pcm_dmaengine: Add missing module description
      ALSA: kunit: Add missing module descriptions
      ALSA: pcmtest: Add missing module descriptions
      ALSA: hda: cirrus_scodec_test: Add missing module descriptions
      sound: oss: dmasound: Add missing module descriptions
      ASoC: SOF: amd: Correct spaces in Makefile
      ALSA: Fix deadlocks with kctl removals at disconnection
      ALSA: core: Remove superfluous CONFIG_PM
      ASoC: SOF: amd: Fix build error with built-in config
      ALSA: hda/realtek: Drop doubly quirk entry for 103c:8a2e

Takashi Sakamoto (1):
      ALSA: kunit: use const qualifier for immutable data

Tomi Valkeinen (1):
      ASoC: dmaengine_pcm: Allow passing component name via config

Uwe Kleine-König (1):
      ASoC: codecs: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Vijendar Mukunda (3):
      ASoC: amd: simplify soundwire dependencies for legacy stack
      ASoC: amd: fix for soundwire build dependencies for legacy stack
      ASoC: amd: acp: fix for acp platform device creation failure

Wolfram Sang (5):
      ASoC: codecs: wm8962: use 'time_left' variable with wait_for_completion_timeout()
      ASoC: codecs: wm8993: use 'time_left' variable with wait_for_completion_timeout()
      ASoC: codecs: wm8994: use 'time_left' variable with wait_for_completion_timeout()
      ASoC: codecs: wm8996: use 'time_left' variable with wait_for_completion_timeout()
      ALSA: aoa: soundbus: i2sbus: pcm: use 'time_left' variable with wait_for_completion_timeout()

Yong Zhi (2):
      ASoC: SOF: ipc4-loader: save FW version info to debugfs
      ASoC: SOF: topology: remove incorrect widget id in error message

Zhang Yi (2):
      ASoC: codecs: ES8326: Reducing power consumption
      ASoC: codecs: ES8326: Delete unused REG_SUPPLY

end.to.start (1):
      ASoC: amd: Support microphone from Acer Aspire A315-24P

---
 .../devicetree/bindings/sound/davinci-mcbsp.txt    |   50 -
 .../devicetree/bindings/sound/davinci-mcbsp.yaml   |  113 +
 .../devicetree/bindings/sound/fsl,audmix.txt       |   50 -
 .../devicetree/bindings/sound/fsl,audmix.yaml      |   83 +
 .../devicetree/bindings/sound/fsl,esai.txt         |   68 -
 .../devicetree/bindings/sound/fsl,esai.yaml        |  118 +
 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |   14 +
 .../bindings/sound/fsl,imx-audio-spdif.yaml        |   66 +
 .../devicetree/bindings/sound/fsl,sai.yaml         |    6 +-
 .../devicetree/bindings/sound/fsl,spdif.yaml       |   35 +-
 .../devicetree/bindings/sound/fsl,ssi.txt          |   87 -
 .../devicetree/bindings/sound/fsl,ssi.yaml         |  194 ++
 .../devicetree/bindings/sound/fsl-asoc-card.txt    |  117 -
 .../devicetree/bindings/sound/fsl-asoc-card.yaml   |  197 ++
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   36 -
 .../bindings/sound/mediatek,mt2701-wm8960.yaml     |   54 +
 .../devicetree/bindings/sound/mt2701-wm8960.txt    |   24 -
 .../sound/mt8186-mt6366-da7219-max98357.yaml       |  131 +-
 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml        |  120 +-
 .../sound/mt8192-mt6359-rt1015-rt5682.yaml         |  139 +-
 .../devicetree/bindings/sound/mt8195-mt6359.yaml   |  134 +
 .../devicetree/bindings/sound/nuvoton,nau8325.yaml |   80 +
 .../devicetree/bindings/sound/nuvoton,nau8821.yaml |    7 +
 .../bindings/sound/nvidia,tegra20-ac97.txt         |   36 -
 .../bindings/sound/nvidia,tegra20-ac97.yaml        |   82 +
 .../bindings/sound/nvidia,tegra20-das.txt          |   12 -
 .../bindings/sound/nvidia,tegra20-das.yaml         |   36 +
 .../bindings/sound/nvidia,tegra30-i2s.txt          |   27 -
 .../bindings/sound/nvidia,tegra30-i2s.yaml         |   67 +
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |    2 +
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |    5 +-
 .../bindings/sound/rockchip,rk3308-codec.yaml      |   98 +
 .../devicetree/bindings/sound/ti,pcm1681.txt       |   15 -
 .../devicetree/bindings/sound/ti,pcm1681.yaml      |   43 +
 .../devicetree/bindings/sound/ti,pcm6240.yaml      |  177 ++
 .../devicetree/bindings/sound/wlf,wm8776.yaml      |   41 +
 .../devicetree/bindings/sound/wlf,wm8974.txt       |   15 -
 .../devicetree/bindings/sound/wlf,wm8974.yaml      |   41 +
 Documentation/devicetree/bindings/sound/wm8776.txt |   18 -
 .../sound/kernel-api/writing-an-alsa-driver.rst    |    4 +-
 Documentation/sound/soc/dapm-graph.svg             |  375 +++
 Documentation/sound/soc/dapm.rst                   |  167 +-
 MAINTAINERS                                        |   13 +
 drivers/firmware/cirrus/cs_dsp.c                   |   54 +
 include/linux/firmware/cirrus/cs_dsp.h             |    4 +
 include/linux/pci_ids.h                            |    1 +
 include/linux/platform_data/davinci_asp.h          |   15 -
 include/sound/control.h                            |   23 +
 include/sound/cs35l41.h                            |    5 +
 include/sound/dmaengine_pcm.h                      |    2 +
 include/sound/emu10k1.h                            |   33 +-
 include/sound/hda-mlink.h                          |    2 +-
 include/sound/hda_codec.h                          |   11 -
 include/sound/hdaudio.h                            |    2 +
 include/sound/pcm.h                                |    5 +
 include/sound/soc-acpi-intel-match.h               |    2 +-
 .../sound/soc-acpi-intel-ssp-common.h              |   29 +-
 include/sound/soc-acpi.h                           |   14 +-
 include/sound/soc-jack.h                           |    2 -
 include/sound/soc.h                                |   56 +-
 include/sound/sof.h                                |    4 +-
 include/sound/sof/channel_map.h                    |    2 +-
 include/sound/sof/control.h                        |    2 +-
 include/sound/sof/dai-intel.h                      |    2 +-
 include/sound/sof/dai.h                            |    2 +-
 include/sound/sof/debug.h                          |    2 +-
 include/sound/sof/ext_manifest.h                   |    2 +-
 include/sound/sof/ext_manifest4.h                  |    2 +-
 include/sound/sof/header.h                         |    2 +-
 include/sound/sof/info.h                           |    2 +-
 include/sound/sof/ipc4/header.h                    |    2 +-
 include/sound/sof/pm.h                             |    2 +-
 include/sound/sof/stream.h                         |    2 +-
 include/sound/sof/topology.h                       |    2 +-
 include/sound/sof/trace.h                          |    2 +-
 include/sound/sof/xtensa.h                         |    2 +-
 include/sound/soundfont.h                          |    2 +-
 include/trace/events/asoc.h                        |    2 +
 include/trace/events/sof.h                         |    2 +-
 include/trace/events/sof_intel.h                   |    2 +-
 include/uapi/sound/asoc.h                          |   56 -
 include/uapi/sound/intel/avs/tokens.h              |    2 +-
 include/uapi/sound/skl-tplg-interface.h            |   74 -
 include/uapi/sound/sof/abi.h                       |    2 +-
 include/uapi/sound/sof/fw.h                        |    2 +-
 include/uapi/sound/sof/header.h                    |    2 +-
 include/uapi/sound/sof/tokens.h                    |    2 +-
 sound/Makefile                                     |    2 +-
 sound/ac97/bus.c                                   |    1 +
 sound/ac97_bus.c                                   |    1 +
 sound/aoa/codecs/Makefile                          |    6 +-
 sound/aoa/core/Makefile                            |    2 +-
 sound/aoa/fabrics/Makefile                         |    2 +-
 sound/aoa/soundbus/Makefile                        |    2 +-
 sound/aoa/soundbus/i2sbus/Makefile                 |    2 +-
 sound/aoa/soundbus/i2sbus/pcm.c                    |   10 +-
 sound/arm/Makefile                                 |    4 +-
 sound/arm/pxa2xx-pcm-lib.c                         |    4 +-
 sound/atmel/Makefile                               |    2 +-
 sound/core/Makefile                                |   18 +-
 sound/core/control_led.c                           |   15 +-
 sound/core/init.c                                  |   11 +-
 sound/core/oss/Makefile                            |    2 +-
 sound/core/pcm_dmaengine.c                         |    1 +
 sound/core/pcm_native.c                            |    2 +-
 sound/core/seq/Makefile                            |   14 +-
 sound/core/seq/oss/Makefile                        |    2 +-
 sound/core/seq/seq_dummy.c                         |   24 +-
 sound/core/sound_kunit.c                           |   11 +-
 sound/drivers/Makefile                             |   18 +-
 sound/drivers/aloop.c                              |    9 +-
 sound/drivers/mpu401/Makefile                      |    4 +-
 sound/drivers/opl3/Makefile                        |    2 +-
 sound/drivers/opl4/Makefile                        |    4 +-
 sound/drivers/pcmtest.c                            |    1 +
 sound/drivers/pcsp/Makefile                        |    2 +-
 sound/drivers/vx/Makefile                          |    2 +-
 sound/firewire/Makefile                            |    4 +-
 sound/firewire/amdtp-stream.c                      |   10 +-
 sound/firewire/bebob/Makefile                      |    2 +-
 sound/firewire/dice/Makefile                       |    2 +-
 sound/firewire/digi00x/Makefile                    |    2 +-
 sound/firewire/fireface/Makefile                   |    2 +-
 sound/firewire/fireworks/Makefile                  |    2 +-
 sound/firewire/motu/Makefile                       |    2 +-
 sound/firewire/oxfw/Makefile                       |    2 +-
 sound/firewire/tascam/Makefile                     |    2 +-
 sound/hda/Kconfig                                  |    1 +
 sound/hda/Makefile                                 |    8 +-
 sound/hda/ext/Makefile                             |    2 +-
 sound/hda/hdac_controller.c                        |  127 +-
 sound/hda/intel-dsp-config.c                       |   16 +-
 sound/i2c/Makefile                                 |    6 +-
 sound/i2c/other/Makefile                           |   10 +-
 sound/isa/Makefile                                 |   18 +-
 sound/isa/ad1816a/Makefile                         |    2 +-
 sound/isa/ad1848/Makefile                          |    2 +-
 sound/isa/cs423x/Makefile                          |    4 +-
 sound/isa/es1688/Makefile                          |    4 +-
 sound/isa/galaxy/Makefile                          |    4 +-
 sound/isa/gus/Makefile                             |   12 +-
 sound/isa/msnd/Makefile                            |    6 +-
 sound/isa/opti9xx/Makefile                         |    8 +-
 sound/isa/sb/Makefile                              |   18 +-
 sound/isa/sb/emu8000_patch.c                       |   13 -
 sound/isa/wavefront/Makefile                       |    2 +-
 sound/isa/wss/Makefile                             |    2 +-
 sound/mips/Makefile                                |    4 +-
 sound/oss/dmasound/dmasound_atari.c                |    2 +
 sound/oss/dmasound/dmasound_paula.c                |    1 +
 sound/parisc/Makefile                              |    2 +-
 sound/pci/Makefile                                 |   48 +-
 sound/pci/ali5451/Makefile                         |    2 +-
 sound/pci/asihpi/Makefile                          |    2 +-
 sound/pci/au88x0/Makefile                          |    6 +-
 sound/pci/aw2/Makefile                             |    2 +-
 sound/pci/ca0106/Makefile                          |    2 +-
 sound/pci/ctxfi/Makefile                           |    2 +-
 sound/pci/echoaudio/Makefile                       |   28 +-
 sound/pci/emu10k1/Makefile                         |    6 +-
 sound/pci/emu10k1/emu10k1_callback.c               |   13 +-
 sound/pci/emu10k1/emu10k1_main.c                   |   75 +-
 sound/pci/emu10k1/emu10k1_patch.c                  |  207 +-
 sound/pci/emu10k1/io.c                             |   53 +
 sound/pci/emu10k1/memory.c                         |   55 +-
 sound/pci/hda/Kconfig                              |    2 +
 sound/pci/hda/Makefile                             |   52 +-
 sound/pci/hda/cirrus_scodec_test.c                 |    1 +
 sound/pci/hda/cs35l41_hda.c                        |  418 ++-
 sound/pci/hda/cs35l41_hda.h                        |    6 +
 sound/pci/hda/cs35l41_hda_property.c               |   24 +-
 sound/pci/hda/cs35l56_hda.c                        |    8 +-
 sound/pci/hda/hda_codec.c                          |   37 +-
 sound/pci/hda/hda_component.c                      |   16 +-
 sound/pci/hda/hda_component.h                      |    7 +-
 sound/pci/hda/hda_controller.c                     |   11 +-
 sound/pci/hda/hda_controller.h                     |    1 +
 sound/pci/hda/hda_cs_dsp_ctl.c                     |   69 +-
 sound/pci/hda/hda_generic.c                        |    4 -
 sound/pci/hda/hda_generic.h                        |    2 -
 sound/pci/hda/hda_intel.c                          |   55 +-
 sound/pci/hda/hda_intel_trace.h                    |    2 -
 sound/pci/hda/hda_sysfs.c                          |    4 -
 sound/pci/hda/patch_analog.c                       |    4 -
 sound/pci/hda/patch_ca0132.c                       |    4 -
 sound/pci/hda/patch_cirrus.c                       |    4 -
 sound/pci/hda/patch_conexant.c                     |    4 -
 sound/pci/hda/patch_cs8409.c                       |    8 -
 sound/pci/hda/patch_hdmi.c                         |   11 +-
 sound/pci/hda/patch_realtek.c                      |   49 +-
 sound/pci/hda/patch_sigmatel.c                     |    8 -
 sound/pci/hda/patch_via.c                          |    6 -
 sound/pci/ice1712/Makefile                         |    6 +-
 sound/pci/korg1212/Makefile                        |    2 +-
 sound/pci/lx6464es/Makefile                        |    2 +-
 sound/pci/mixart/Makefile                          |    2 +-
 sound/pci/nm256/Makefile                           |    2 +-
 sound/pci/oxygen/Makefile                          |    8 +-
 sound/pci/pcxhr/Makefile                           |    2 +-
 sound/pci/riptide/Makefile                         |    2 +-
 sound/pci/rme9652/Makefile                         |    6 +-
 sound/pci/trident/Makefile                         |    2 +-
 sound/pci/vx222/Makefile                           |    2 +-
 sound/pci/ymfpci/Makefile                          |    2 +-
 sound/pcmcia/pdaudiocf/Makefile                    |    2 +-
 sound/pcmcia/vx/Makefile                           |    2 +-
 sound/ppc/Makefile                                 |    2 +-
 sound/sh/Makefile                                  |    4 +-
 sound/soc/Kconfig                                  |    8 +
 sound/soc/Makefile                                 |   20 +-
 sound/soc/adi/Makefile                             |    4 +-
 sound/soc/amd/Kconfig                              |   21 +-
 sound/soc/amd/Makefile                             |   12 +-
 sound/soc/amd/acp-da7219-max98357a.c               |    2 +-
 sound/soc/amd/acp/Makefile                         |   26 +-
 sound/soc/amd/acp/acp-legacy-common.c              |   98 +-
 sound/soc/amd/acp/acp-mach-common.c                |    2 +-
 sound/soc/amd/acp/acp-pci.c                        |    9 +-
 sound/soc/amd/acp/amd.h                            |   10 +-
 sound/soc/amd/acp/chip_offset_byte.h               |    1 +
 sound/soc/amd/acp3x-rt5682-max9836.c               |    2 +-
 sound/soc/amd/ps/Makefile                          |    8 +-
 sound/soc/amd/ps/ps-sdw-dma.c                      |    2 +-
 sound/soc/amd/raven/Makefile                       |    6 +-
 sound/soc/amd/renoir/Makefile                      |    6 +-
 sound/soc/amd/rpl/Makefile                         |    2 +-
 sound/soc/amd/vangogh/Makefile                     |    8 +-
 sound/soc/amd/yc/Makefile                          |    6 +-
 sound/soc/apple/Makefile                           |    2 +-
 sound/soc/atmel/Makefile                           |   30 +-
 sound/soc/atmel/tse850-pcm5142.c                   |    3 +-
 sound/soc/au1x/Makefile                            |   16 +-
 sound/soc/bcm/Makefile                             |    6 +-
 sound/soc/cirrus/Makefile                          |    6 +-
 sound/soc/codecs/Kconfig                           |   25 +
 sound/soc/codecs/Makefile                          |  784 +++---
 sound/soc/codecs/ab8500-codec.c                    |    1 +
 sound/soc/codecs/adau1372-i2c.c                    |    2 +-
 sound/soc/codecs/adau1373.c                        |    2 +-
 sound/soc/codecs/adau1701.c                        |    8 +-
 sound/soc/codecs/adau7118-i2c.c                    |    2 +-
 sound/soc/codecs/adav803.c                         |    2 +-
 sound/soc/codecs/ak4118.c                          |    2 +-
 sound/soc/codecs/ak4535.c                          |    2 +-
 sound/soc/codecs/ak4641.c                          |    2 +-
 sound/soc/codecs/ak4671.c                          |    2 +-
 sound/soc/codecs/cs35l32.c                         |    2 +-
 sound/soc/codecs/cs35l33.c                         |    2 +-
 sound/soc/codecs/cs35l34.c                         |    2 +-
 sound/soc/codecs/cs35l35.c                         |    2 +-
 sound/soc/codecs/cs35l36.c                         |    2 +-
 sound/soc/codecs/cs35l41-i2c.c                     |    8 +-
 sound/soc/codecs/cs35l41.c                         |    7 +-
 sound/soc/codecs/cs35l45-i2c.c                     |    2 +-
 sound/soc/codecs/cs35l56-i2c.c                     |    2 +-
 sound/soc/codecs/cs35l56-shared.c                  |    1 +
 sound/soc/codecs/cs35l56.c                         |    1 +
 sound/soc/codecs/cs4265.c                          |    2 +-
 sound/soc/codecs/cs4270.c                          |    2 +-
 sound/soc/codecs/cs4271-i2c.c                      |    2 +-
 sound/soc/codecs/cs42l42-i2c.c                     |    2 +-
 sound/soc/codecs/cs42l51-i2c.c                     |    2 +-
 sound/soc/codecs/cs42l52.c                         |    2 +-
 sound/soc/codecs/cs42l56.c                         |    2 +-
 sound/soc/codecs/cs42l73.c                         |    2 +-
 sound/soc/codecs/cs43130.c                         |    8 +-
 sound/soc/codecs/cs4341.c                          |    2 +-
 sound/soc/codecs/cs4349.c                          |    2 +-
 sound/soc/codecs/cs53l30.c                         |    2 +-
 sound/soc/codecs/cx2072x.c                         |    4 +-
 sound/soc/codecs/da7210.c                          |    2 +-
 sound/soc/codecs/da7213.c                          |    2 +-
 sound/soc/codecs/da732x.c                          |    2 +-
 sound/soc/codecs/da9055.c                          |    2 +-
 sound/soc/codecs/es8316.c                          |    2 +-
 sound/soc/codecs/es8326.c                          |   43 +-
 sound/soc/codecs/es8328-i2c.c                      |    4 +-
 sound/soc/codecs/hda-dai.c                         |    2 +-
 sound/soc/codecs/hda.c                             |    2 +-
 sound/soc/codecs/hda.h                             |    2 +-
 sound/soc/codecs/hdac_hda.c                        |   44 +-
 sound/soc/codecs/isabelle.c                        |    2 +-
 sound/soc/codecs/lm4857.c                          |    2 +-
 sound/soc/codecs/lm49453.c                         |    2 +-
 sound/soc/codecs/max9768.c                         |    2 +-
 sound/soc/codecs/max98371.c                        |    2 +-
 sound/soc/codecs/max98373-i2c.c                    |    2 +-
 sound/soc/codecs/max98373-sdw.c                    |    1 -
 sound/soc/codecs/max98388.c                        |    2 +-
 sound/soc/codecs/max98390.c                        |    2 +-
 sound/soc/codecs/max9850.c                         |    2 +-
 sound/soc/codecs/max98520.c                        |    2 +-
 sound/soc/codecs/max9867.c                         |    2 +-
 sound/soc/codecs/max9877.c                         |    2 +-
 sound/soc/codecs/max98925.c                        |    2 +-
 sound/soc/codecs/max98926.c                        |    2 +-
 sound/soc/codecs/max98927.c                        |    2 +-
 sound/soc/codecs/ml26124.c                         |    2 +-
 sound/soc/codecs/mt6660.c                          |    2 +-
 sound/soc/codecs/nau8325.c                         |  900 ++++++
 sound/soc/codecs/nau8325.h                         |  391 +++
 sound/soc/codecs/nau8540.c                         |    2 +-
 sound/soc/codecs/nau8810.c                         |    6 +-
 sound/soc/codecs/nau8821.c                         |   21 +-
 sound/soc/codecs/nau8821.h                         |    1 +
 sound/soc/codecs/nau8822.c                         |    2 +-
 sound/soc/codecs/nau8822.h                         |    1 -
 sound/soc/codecs/nau8824.c                         |    2 +-
 sound/soc/codecs/nau8825.c                         |    2 +-
 sound/soc/codecs/pcm1681.c                         |    2 +-
 sound/soc/codecs/pcm1789-i2c.c                     |    2 +-
 sound/soc/codecs/pcm179x-i2c.c                     |    2 +-
 sound/soc/codecs/pcm6240.c                         | 2217 +++++++++++++++
 sound/soc/codecs/pcm6240.h                         |  252 ++
 sound/soc/codecs/rk3308_codec.c                    |  974 +++++++
 sound/soc/codecs/rk3308_codec.h                    |  579 ++++
 sound/soc/codecs/rt1011.c                          |    2 +-
 sound/soc/codecs/rt1015.c                          |    2 +-
 sound/soc/codecs/rt1016.c                          |    2 +-
 sound/soc/codecs/rt1017-sdca-sdw.c                 |    1 -
 sound/soc/codecs/rt1019.c                          |    2 +-
 sound/soc/codecs/rt1305.c                          |    4 +-
 sound/soc/codecs/rt1308-sdw.c                      |    1 -
 sound/soc/codecs/rt1308.c                          |    2 +-
 sound/soc/codecs/rt1316-sdw.c                      |    1 -
 sound/soc/codecs/rt1318-sdw.c                      |    1 -
 sound/soc/codecs/rt274.c                           |    2 +-
 sound/soc/codecs/rt286.c                           |    4 +-
 sound/soc/codecs/rt298.c                           |    2 +-
 sound/soc/codecs/rt5514.c                          |    2 +-
 sound/soc/codecs/rt5616.c                          |    2 +-
 sound/soc/codecs/rt5631.c                          |    4 +-
 sound/soc/codecs/rt5640.c                          |    6 +-
 sound/soc/codecs/rt5645.c                          |    4 +-
 sound/soc/codecs/rt5651.c                          |    2 +-
 sound/soc/codecs/rt5659.c                          |    4 +-
 sound/soc/codecs/rt5660.c                          |    2 +-
 sound/soc/codecs/rt5663.c                          |    2 +-
 sound/soc/codecs/rt5665.c                          |    2 +-
 sound/soc/codecs/rt5668.c                          |    2 +-
 sound/soc/codecs/rt5670.c                          |    6 +-
 sound/soc/codecs/rt5682-i2c.c                      |    2 +-
 sound/soc/codecs/rt5682-sdw.c                      |    1 -
 sound/soc/codecs/rt5682s.c                         |    2 +-
 sound/soc/codecs/rt700-sdw.c                       |    1 -
 sound/soc/codecs/rt711-sdca-sdw.c                  |    1 -
 sound/soc/codecs/rt711-sdw.c                       |    1 -
 sound/soc/codecs/rt712-sdca-dmic.c                 |    1 -
 sound/soc/codecs/rt712-sdca-sdw.c                  |    1 -
 sound/soc/codecs/rt715-sdca-sdw.c                  |    5 +-
 sound/soc/codecs/rt715-sdca.c                      |    4 +-
 sound/soc/codecs/rt715-sdw.c                       |    1 -
 sound/soc/codecs/rt722-sdca-sdw.c                  |    1 -
 sound/soc/codecs/sdw-mockup.c                      |    1 -
 sound/soc/codecs/sgtl5000.c                        |    2 +-
 sound/soc/codecs/sigmadsp.c                        |    1 +
 sound/soc/codecs/sma1303.c                         |    2 +-
 sound/soc/codecs/src4xxx-i2c.c                     |    2 +-
 sound/soc/codecs/ssm2518.c                         |    2 +-
 sound/soc/codecs/ssm4567.c                         |    2 +-
 sound/soc/codecs/sta32x.c                          |    6 +-
 sound/soc/codecs/sta350.c                          |    2 +-
 sound/soc/codecs/sta529.c                          |    2 +-
 sound/soc/codecs/tas2552.c                         |    2 +-
 sound/soc/codecs/tas2764.c                         |    2 +-
 sound/soc/codecs/tas2770.c                         |    2 +-
 sound/soc/codecs/tas2780.c                         |    5 +-
 sound/soc/codecs/tas2781-fmwlib.c                  |    6 +-
 sound/soc/codecs/tas5086.c                         |    2 +-
 sound/soc/codecs/tas6424.c                         |    2 +-
 sound/soc/codecs/tda7419.c                         |    2 +-
 sound/soc/codecs/tfa9879.c                         |    2 +-
 sound/soc/codecs/tlv320aic23-i2c.c                 |    2 +-
 sound/soc/codecs/tlv320aic32x4-spi.c               |    1 -
 sound/soc/codecs/tlv320aic3x-spi.c                 |    1 -
 sound/soc/codecs/ts3a227e.c                        |    2 +-
 sound/soc/codecs/tscs42xx.c                        |    4 +-
 sound/soc/codecs/tscs454.c                         |    2 +-
 sound/soc/codecs/uda1380.c                         |    2 +-
 sound/soc/codecs/wcd934x.c                         |    1 -
 sound/soc/codecs/wm1250-ev1.c                      |    2 +-
 sound/soc/codecs/wm2000.c                          |    2 +-
 sound/soc/codecs/wm2200.c                          |    2 +-
 sound/soc/codecs/wm5100.c                          |    2 +-
 sound/soc/codecs/wm8510.c                          |    2 +-
 sound/soc/codecs/wm8523.c                          |    2 +-
 sound/soc/codecs/wm8711.c                          |    2 +-
 sound/soc/codecs/wm8728.c                          |    2 +-
 sound/soc/codecs/wm8731-i2c.c                      |    2 +-
 sound/soc/codecs/wm8737.c                          |    2 +-
 sound/soc/codecs/wm8741.c                          |    2 +-
 sound/soc/codecs/wm8750.c                          |    4 +-
 sound/soc/codecs/wm8753.c                          |    2 +-
 sound/soc/codecs/wm8804-i2c.c                      |    2 +-
 sound/soc/codecs/wm8900.c                          |    2 +-
 sound/soc/codecs/wm8903.c                          |    2 +-
 sound/soc/codecs/wm8940.c                          |    2 +-
 sound/soc/codecs/wm8955.c                          |    2 +-
 sound/soc/codecs/wm8960.c                          |    2 +-
 sound/soc/codecs/wm8961.c                          |    2 +-
 sound/soc/codecs/wm8962.c                          |   14 +-
 sound/soc/codecs/wm8971.c                          |    2 +-
 sound/soc/codecs/wm8974.c                          |    2 +-
 sound/soc/codecs/wm8978.c                          |    2 +-
 sound/soc/codecs/wm8983.c                          |    2 +-
 sound/soc/codecs/wm8988.c                          |    2 +-
 sound/soc/codecs/wm8990.c                          |    2 +-
 sound/soc/codecs/wm8991.c                          |    2 +-
 sound/soc/codecs/wm8993.c                          |   14 +-
 sound/soc/codecs/wm8994.c                          |    8 +-
 sound/soc/codecs/wm8995.c                          |    2 +-
 sound/soc/codecs/wm8996.c                          |   16 +-
 sound/soc/codecs/wm9081.c                          |    2 +-
 sound/soc/codecs/wm9090.c                          |    4 +-
 sound/soc/codecs/wm_adsp.c                         |   33 +-
 sound/soc/fsl/Makefile                             |   52 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   10 +-
 sound/soc/fsl/fsl_rpmsg.c                          |   43 +-
 sound/soc/fsl/fsl_ssi.c                            |    4 +-
 sound/soc/fsl/imx-audio-rpmsg.c                    |   21 +-
 sound/soc/fsl/imx-card.c                           |    6 +-
 sound/soc/fsl/imx-es8328.c                         |   17 +-
 sound/soc/fsl/imx-hdmi.c                           |    2 +-
 sound/soc/fsl/imx-pcm-rpmsg.c                      |   19 +-
 sound/soc/fsl/imx-rpmsg.c                          |   28 +-
 sound/soc/generic/Makefile                         |   12 +-
 sound/soc/generic/audio-graph-card2.c              |    4 +-
 sound/soc/generic/simple-card-utils.c              |    2 -
 sound/soc/img/img-i2s-in.c                         |    2 +-
 sound/soc/img/img-i2s-out.c                        |    2 +-
 sound/soc/intel/Kconfig                            |    1 +
 sound/soc/intel/atom/Makefile                      |    2 +-
 sound/soc/intel/atom/sst/Makefile                  |    6 +-
 sound/soc/intel/avs/Makefile                       |   10 +-
 sound/soc/intel/avs/apl.c                          |   22 +-
 sound/soc/intel/avs/avs.h                          |   14 +-
 sound/soc/intel/avs/board_selection.c              |    9 +-
 sound/soc/intel/avs/boards/Makefile                |   34 +-
 sound/soc/intel/avs/boards/da7219.c                |    2 +-
 sound/soc/intel/avs/boards/dmic.c                  |    2 +-
 sound/soc/intel/avs/boards/es8336.c                |    6 +-
 sound/soc/intel/avs/boards/hdaudio.c               |    8 +-
 sound/soc/intel/avs/boards/i2s_test.c              |   81 +-
 sound/soc/intel/avs/boards/max98357a.c             |    2 +-
 sound/soc/intel/avs/boards/max98373.c              |    2 +-
 sound/soc/intel/avs/boards/max98927.c              |    2 +-
 sound/soc/intel/avs/boards/nau8825.c               |    6 +-
 sound/soc/intel/avs/boards/probe.c                 |    2 +-
 sound/soc/intel/avs/boards/rt274.c                 |    7 +-
 sound/soc/intel/avs/boards/rt286.c                 |    8 +-
 sound/soc/intel/avs/boards/rt298.c                 |    8 +-
 sound/soc/intel/avs/boards/rt5514.c                |    2 +-
 sound/soc/intel/avs/boards/rt5663.c                |    4 +-
 sound/soc/intel/avs/boards/rt5682.c                |    4 +-
 sound/soc/intel/avs/boards/ssm4567.c               |    7 +-
 sound/soc/intel/avs/cldma.c                        |   46 +-
 sound/soc/intel/avs/cldma.h                        |    3 +-
 sound/soc/intel/avs/cnl.c                          |   83 +-
 sound/soc/intel/avs/control.c                      |    2 +-
 sound/soc/intel/avs/control.h                      |    2 +-
 sound/soc/intel/avs/core.c                         |   99 +-
 sound/soc/intel/avs/debugfs.c                      |    2 +-
 sound/soc/intel/avs/dsp.c                          |    2 +-
 sound/soc/intel/avs/icl.c                          |   17 +-
 sound/soc/intel/avs/ipc.c                          |   50 +-
 sound/soc/intel/avs/loader.c                       |    8 +-
 sound/soc/intel/avs/messages.c                     |    2 +-
 sound/soc/intel/avs/messages.h                     |   49 +-
 sound/soc/intel/avs/path.c                         |   47 +-
 sound/soc/intel/avs/path.h                         |    2 +-
 sound/soc/intel/avs/pcm.c                          |  274 +-
 sound/soc/intel/avs/probes.c                       |   16 +-
 sound/soc/intel/avs/registers.h                    |    2 +-
 sound/soc/intel/avs/skl.c                          |   75 +-
 sound/soc/intel/avs/sysfs.c                        |    2 +-
 sound/soc/intel/avs/tgl.c                          |    5 +-
 sound/soc/intel/avs/topology.c                     |    2 +-
 sound/soc/intel/avs/topology.h                     |    2 +-
 sound/soc/intel/avs/trace.c                        |    2 +-
 sound/soc/intel/avs/utils.c                        |   10 +-
 sound/soc/intel/avs/utils.h                        |    2 +-
 sound/soc/intel/boards/Kconfig                     |   70 +-
 sound/soc/intel/boards/Makefile                    |   98 +-
 sound/soc/intel/boards/bdw_rt286.c                 |    2 +-
 sound/soc/intel/boards/bridge_cs35l56.c            |  137 +
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |  182 +-
 sound/soc/intel/boards/bxt_rt298.c                 |    3 +-
 sound/soc/intel/boards/cml_rt1011_rt5682.c         |  609 ----
 sound/soc/intel/boards/glk_rt5682_max98357a.c      |  691 -----
 sound/soc/intel/boards/hda_dsp_common.c            |    2 +-
 sound/soc/intel/boards/hsw_rt5640.c                |    2 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c      |    1 +
 sound/soc/intel/boards/kbl_da7219_max98927.c       |    4 +
 sound/soc/intel/boards/kbl_rt5660.c                |    1 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |    4 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |    3 +-
 sound/soc/intel/boards/skl_hda_dsp_common.h        |    1 +
 sound/soc/intel/boards/skl_hda_dsp_generic.c       |   50 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |    3 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |    4 +-
 sound/soc/intel/boards/skl_rt286.c                 |    5 +-
 sound/soc/intel/boards/sof_board_helpers.c         |  163 +-
 sound/soc/intel/boards/sof_board_helpers.h         |  108 +-
 sound/soc/intel/boards/sof_cirrus_common.h         |    2 +-
 sound/soc/intel/boards/sof_cs42l42.c               |   89 +-
 sound/soc/intel/boards/sof_da7219.c                |  521 ++--
 sound/soc/intel/boards/sof_maxim_common.c          |  137 +-
 sound/soc/intel/boards/sof_maxim_common.h          |    9 +-
 sound/soc/intel/boards/sof_nau8825.c               |  104 +-
 sound/soc/intel/boards/sof_nuvoton_common.h        |    2 +-
 sound/soc/intel/boards/sof_realtek_common.c        |  330 ++-
 sound/soc/intel/boards/sof_realtek_common.h        |    7 +-
 sound/soc/intel/boards/sof_rt5682.c                |  418 +--
 sound/soc/intel/boards/sof_sdw.c                   | 1415 +++++-----
 sound/soc/intel/boards/sof_sdw_common.h            |   98 +-
 sound/soc/intel/boards/sof_sdw_cs42l42.c           |   27 +-
 sound/soc/intel/boards/sof_sdw_cs42l43.c           |   66 +-
 sound/soc/intel/boards/sof_sdw_cs_amp.c            |   16 +-
 sound/soc/intel/boards/sof_sdw_maxim.c             |   29 +-
 sound/soc/intel/boards/sof_sdw_rt5682.c            |   27 +-
 sound/soc/intel/boards/sof_sdw_rt700.c             |   29 +-
 sound/soc/intel/boards/sof_sdw_rt711.c             |   28 +-
 sound/soc/intel/boards/sof_sdw_rt712_sdca.c        |   49 +-
 sound/soc/intel/boards/sof_sdw_rt715.c             |   26 -
 sound/soc/intel/boards/sof_sdw_rt715_sdca.c        |   26 -
 sound/soc/intel/boards/sof_sdw_rt722_sdca.c        |   60 +-
 sound/soc/intel/boards/sof_sdw_rt_amp.c            |   43 +-
 sound/soc/intel/boards/sof_sdw_rt_dmic.c           |   54 +
 .../soc/intel/boards/sof_sdw_rt_sdca_jack_common.c |   49 +-
 sound/soc/intel/boards/sof_ssp_amp.c               |  266 +-
 sound/soc/intel/boards/sof_ssp_common.c            |  122 -
 sound/soc/intel/catpt/Makefile                     |    2 +-
 sound/soc/intel/catpt/core.h                       |    2 +-
 sound/soc/intel/catpt/device.c                     |    2 +-
 sound/soc/intel/catpt/dsp.c                        |    2 +-
 sound/soc/intel/catpt/ipc.c                        |    2 +-
 sound/soc/intel/catpt/loader.c                     |    2 +-
 sound/soc/intel/catpt/messages.c                   |    2 +-
 sound/soc/intel/catpt/messages.h                   |    2 +-
 sound/soc/intel/catpt/pcm.c                        |    2 +-
 sound/soc/intel/catpt/registers.h                  |    2 +-
 sound/soc/intel/catpt/sysfs.c                      |    2 +-
 sound/soc/intel/catpt/trace.h                      |    2 +-
 sound/soc/intel/common/Makefile                    |    8 +-
 sound/soc/intel/common/soc-acpi-intel-adl-match.c  |  150 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |   24 +
 sound/soc/intel/common/soc-acpi-intel-cml-match.c  |   12 +-
 sound/soc/intel/common/soc-acpi-intel-glk-match.c  |    4 +-
 sound/soc/intel/common/soc-acpi-intel-icl-match.c  |    2 +-
 sound/soc/intel/common/soc-acpi-intel-jsl-match.c  |    4 +-
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |  104 +-
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |  244 +-
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c  |   97 +-
 sound/soc/intel/common/soc-acpi-intel-ssp-common.c |  159 ++
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c  |   85 +-
 sound/soc/intel/common/sst-dsp-priv.h              |    2 +-
 sound/soc/intel/common/sst-dsp.c                   |    2 +-
 sound/soc/intel/common/sst-dsp.h                   |    2 +-
 sound/soc/intel/common/sst-ipc.c                   |    2 +-
 sound/soc/intel/common/sst-ipc.h                   |    2 +-
 sound/soc/intel/keembay/Makefile                   |    2 +-
 sound/soc/intel/skylake/Makefile                   |    6 +-
 sound/soc/intel/skylake/skl-topology.c             |  169 --
 sound/soc/jz4740/Makefile                          |    2 +-
 sound/soc/kirkwood/Makefile                        |    4 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |    5 +-
 sound/soc/loongson/Makefile                        |    4 +-
 sound/soc/loongson/loongson_card.c                 |    2 +-
 sound/soc/loongson/loongson_dma.c                  |    2 +-
 sound/soc/loongson/loongson_i2s_pci.c              |    1 -
 sound/soc/mediatek/Kconfig                         |   24 +-
 sound/soc/mediatek/common/Makefile                 |    4 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |   18 +
 sound/soc/mediatek/common/mtk-dai-adda-common.c    |   70 +
 sound/soc/mediatek/common/mtk-dai-adda-common.h    |   45 +
 sound/soc/mediatek/common/mtk-dsp-sof-common.c     |   15 +-
 sound/soc/mediatek/common/mtk-dsp-sof-common.h     |    1 -
 sound/soc/mediatek/common/mtk-soc-card.h           |    7 +-
 sound/soc/mediatek/common/mtk-soundcard-driver.c   |  205 +-
 sound/soc/mediatek/common/mtk-soundcard-driver.h   |   42 +
 sound/soc/mediatek/mt2701/Makefile                 |    2 +-
 sound/soc/mediatek/mt6797/Makefile                 |    2 +-
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         |   14 +-
 sound/soc/mediatek/mt6797/mt6797-dai-adda.c        |   85 +-
 sound/soc/mediatek/mt7986/Makefile                 |    2 +-
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c         |   18 +-
 sound/soc/mediatek/mt8183/Makefile                 |    2 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         |   14 +-
 sound/soc/mediatek/mt8183/mt8183-dai-adda.c        |   90 +-
 sound/soc/mediatek/mt8186/Makefile                 |    5 +-
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c         |   14 +-
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c        |   92 +-
 .../mt8186/mt8186-mt6366-da7219-max98357.c         | 1189 --------
 ...186-mt6366-rt1019-rt5682s.c => mt8186-mt6366.c} |  586 ++--
 sound/soc/mediatek/mt8188/Makefile                 |    2 +-
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c         |   29 +-
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c        |   89 +-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |  209 +-
 sound/soc/mediatek/mt8192/Makefile                 |    2 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c         |  114 +-
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c        |   90 +-
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c         |    4 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |  301 +-
 sound/soc/mediatek/mt8195/Makefile                 |    2 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c         |   31 +-
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c        |   90 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c          |  495 ++--
 sound/soc/meson/Makefile                           |   50 +-
 sound/soc/meson/aiu-fifo-i2s.c                     |    2 +-
 sound/soc/meson/aiu-fifo-spdif.c                   |    2 +-
 sound/soc/meson/aiu-fifo.c                         |    2 +-
 sound/soc/meson/aiu-fifo.h                         |    2 +-
 sound/soc/meson/axg-fifo.c                         |    4 +-
 sound/soc/mxs/Makefile                             |    6 +-
 sound/soc/pxa/Makefile                             |   12 +-
 sound/soc/qcom/Makefile                            |   38 +-
 sound/soc/qcom/apq8016_sbc.c                       |    4 +-
 sound/soc/qcom/common.c                            |    2 +
 sound/soc/qcom/qdsp6/Makefile                      |    4 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |   16 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |    2 +-
 sound/soc/qcom/qdsp6/q6dsp-common.c                |    2 +
 sound/soc/qcom/sc7180.c                            |   10 +-
 sound/soc/qcom/sc7280.c                            |   12 +-
 sound/soc/qcom/sc8280xp.c                          |   10 +-
 sound/soc/qcom/sdw.c                               |    8 +-
 sound/soc/qcom/sm8250.c                            |   10 +-
 sound/soc/qcom/x1e80100.c                          |    8 +-
 sound/soc/rockchip/Makefile                        |   16 +-
 sound/soc/samsung/Makefile                         |   38 +-
 sound/soc/samsung/i2s.c                            |    1 -
 sound/soc/samsung/midas_wm1811.c                   |    2 +-
 sound/soc/sh/Makefile                              |   16 +-
 sound/soc/sh/rcar/Makefile                         |    2 +-
 sound/soc/sh/rcar/cmd.c                            |    6 +-
 sound/soc/sh/rcar/core.c                           |    4 +-
 sound/soc/sh/rcar/ctu.c                            |    6 +-
 sound/soc/sh/rcar/dma.c                            |    6 +-
 sound/soc/sh/rcar/dvc.c                            |    6 +-
 sound/soc/sh/rcar/gen.c                            |  515 ++--
 sound/soc/sh/rcar/mix.c                            |    6 +-
 sound/soc/sh/rcar/rsnd.h                           |   22 +-
 sound/soc/sh/rcar/src.c                            |   12 +-
 sound/soc/sh/rcar/ssi.c                            |    2 +-
 sound/soc/sh/rcar/ssiu.c                           |    2 +-
 sound/soc/soc-card-test.c                          |  186 ++
 sound/soc/soc-card.c                               |   21 +-
 sound/soc/soc-core.c                               |    8 +-
 sound/soc/soc-dai.c                                |    2 +-
 sound/soc/soc-dapm.c                               |   54 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |    4 +
 sound/soc/soc-jack.c                               |   23 +-
 sound/soc/soc-pcm.c                                |   11 +-
 sound/soc/soc-topology-test.c                      |    3 +-
 sound/soc/soc-topology.c                           |  252 +-
 sound/soc/sof/Makefile                             |   30 +-
 sound/soc/sof/amd/Makefile                         |   20 +-
 sound/soc/sof/amd/acp-common.c                     |    2 +-
 sound/soc/sof/amd/acp-loader.c                     |    2 +
 sound/soc/sof/amd/acp.h                            |    2 +-
 sound/soc/sof/control.c                            |    2 +-
 sound/soc/sof/core.c                               |    2 +-
 sound/soc/sof/debug.c                              |   46 +-
 sound/soc/sof/fw-file-profile.c                    |    2 +-
 sound/soc/sof/imx/Makefile                         |    8 +-
 sound/soc/sof/imx/imx-common.c                     |   24 -
 sound/soc/sof/imx/imx-common.h                     |    9 -
 sound/soc/sof/imx/imx8.c                           |   45 +-
 sound/soc/sof/imx/imx8m.c                          |   42 +-
 sound/soc/sof/imx/imx8ulp.c                        |   44 +-
 sound/soc/sof/intel/Kconfig                        |   25 +-
 sound/soc/sof/intel/Makefile                       |   35 +-
 sound/soc/sof/intel/apl.c                          |    5 +-
 sound/soc/sof/intel/atom.c                         |    2 +-
 sound/soc/sof/intel/atom.h                         |    2 +-
 sound/soc/sof/intel/bdw.c                          |    4 +-
 sound/soc/sof/intel/byt.c                          |    6 +-
 sound/soc/sof/intel/cnl.c                          |   17 +-
 sound/soc/sof/intel/ext_manifest.h                 |    2 +-
 sound/soc/sof/intel/hda-bus.c                      |    9 +-
 sound/soc/sof/intel/hda-codec.c                    |   17 +-
 sound/soc/sof/intel/hda-common-ops.c               |    5 +-
 sound/soc/sof/intel/hda-ctrl.c                     |   21 +-
 sound/soc/sof/intel/hda-dai-ops.c                  |   43 +-
 sound/soc/sof/intel/hda-dai.c                      |  132 +-
 sound/soc/sof/intel/hda-dsp.c                      |  504 +++-
 sound/soc/sof/intel/hda-ipc.c                      |  117 +-
 sound/soc/sof/intel/hda-ipc.h                      |    2 +-
 sound/soc/sof/intel/hda-loader-skl.c               |    2 +-
 sound/soc/sof/intel/hda-loader.c                   |  122 +-
 sound/soc/sof/intel/hda-mlink.c                    |    2 +-
 sound/soc/sof/intel/hda-pcm.c                      |    8 +-
 sound/soc/sof/intel/hda-probes.c                   |    4 +-
 sound/soc/sof/intel/hda-stream.c                   |   39 +-
 sound/soc/sof/intel/hda-trace.c                    |    5 +-
 sound/soc/sof/intel/hda.c                          |  834 ++----
 sound/soc/sof/intel/hda.h                          |   47 +-
 sound/soc/sof/intel/icl.c                          |    6 +-
 sound/soc/sof/intel/lnl.c                          |   35 +-
 sound/soc/sof/intel/lnl.h                          |   15 +
 sound/soc/sof/intel/mtl.c                          |   91 +-
 sound/soc/sof/intel/mtl.h                          |   50 +-
 sound/soc/sof/intel/pci-apl.c                      |    3 +-
 sound/soc/sof/intel/pci-cnl.c                      |    3 +-
 sound/soc/sof/intel/pci-icl.c                      |    4 +-
 sound/soc/sof/intel/pci-lnl.c                      |    5 +-
 sound/soc/sof/intel/pci-mtl.c                      |    3 +-
 sound/soc/sof/intel/pci-skl.c                      |    3 +-
 sound/soc/sof/intel/pci-tgl.c                      |    4 +-
 sound/soc/sof/intel/pci-tng.c                      |    4 +-
 sound/soc/sof/intel/shim.h                         |    5 +-
 sound/soc/sof/intel/skl.c                          |    2 +-
 sound/soc/sof/intel/telemetry.c                    |    3 +-
 sound/soc/sof/intel/telemetry.h                    |    2 +-
 sound/soc/sof/intel/tgl.c                          |   27 +-
 sound/soc/sof/intel/tracepoints.c                  |    5 +
 sound/soc/sof/iomem-utils.c                        |    2 +-
 sound/soc/sof/ipc.c                                |    2 +-
 sound/soc/sof/ipc3-control.c                       |    2 +-
 sound/soc/sof/ipc3-dtrace.c                        |    2 +-
 sound/soc/sof/ipc3-loader.c                        |    2 +-
 sound/soc/sof/ipc3-pcm.c                           |    2 +-
 sound/soc/sof/ipc3-priv.h                          |    8 +-
 sound/soc/sof/ipc3-topology.c                      |    2 +-
 sound/soc/sof/ipc3.c                               |    2 +-
 sound/soc/sof/ipc4-control.c                       |    2 +-
 sound/soc/sof/ipc4-fw-reg.h                        |    2 +-
 sound/soc/sof/ipc4-loader.c                        |   10 +-
 sound/soc/sof/ipc4-mtrace.c                        |    2 +-
 sound/soc/sof/ipc4-pcm.c                           |    2 +-
 sound/soc/sof/ipc4-priv.h                          |    4 +-
 sound/soc/sof/ipc4-telemetry.c                     |    2 +-
 sound/soc/sof/ipc4-telemetry.h                     |    2 +-
 sound/soc/sof/ipc4-topology.c                      |  368 ++-
 sound/soc/sof/ipc4-topology.h                      |    5 +-
 sound/soc/sof/ipc4.c                               |    2 +-
 sound/soc/sof/loader.c                             |    2 +-
 sound/soc/sof/mediatek/mt8186/Makefile             |    2 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c             |    2 +-
 sound/soc/sof/mediatek/mt8195/Makefile             |    2 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c             |    2 +-
 sound/soc/sof/nocodec.c                            |    2 +-
 sound/soc/sof/ops.c                                |    2 +-
 sound/soc/sof/ops.h                                |    2 +-
 sound/soc/sof/pcm.c                                |   62 +-
 sound/soc/sof/pm.c                                 |    2 +-
 sound/soc/sof/sof-acpi-dev.c                       |    2 +-
 sound/soc/sof/sof-acpi-dev.h                       |    2 +-
 sound/soc/sof/sof-audio.c                          |   31 +-
 sound/soc/sof/sof-audio.h                          |    4 +-
 sound/soc/sof/sof-client-ipc-flood-test.c          |   19 +-
 sound/soc/sof/sof-client-ipc-kernel-injector.c     |    2 +-
 sound/soc/sof/sof-client-ipc-msg-injector.c        |    2 +-
 sound/soc/sof/sof-client-probes-ipc3.c             |    2 +-
 sound/soc/sof/sof-client-probes-ipc4.c             |    2 +-
 sound/soc/sof/sof-client-probes.c                  |    2 +-
 sound/soc/sof/sof-client.c                         |    2 +-
 sound/soc/sof/sof-pci-dev.c                        |    2 +-
 sound/soc/sof/sof-pci-dev.h                        |    2 +-
 sound/soc/sof/sof-priv.h                           |    2 +-
 sound/soc/sof/sof-utils.c                          |    2 +-
 sound/soc/sof/sof-utils.h                          |    2 +-
 sound/soc/sof/stream-ipc.c                         |    2 +-
 sound/soc/sof/topology.c                           |    9 +-
 sound/soc/sof/trace.c                              |    2 +-
 sound/soc/sof/xtensa/Makefile                      |    2 +-
 sound/soc/sof/xtensa/core.c                        |    2 +-
 sound/soc/spear/Makefile                           |    6 +-
 sound/soc/sprd/Makefile                            |    2 +-
 sound/soc/sti/Makefile                             |    2 +-
 sound/soc/stm/Makefile                             |    8 +-
 sound/soc/sunxi/sun4i-i2s.c                        |   33 +-
 sound/soc/sunxi/sun50i-codec-analog.c              |   73 +-
 sound/soc/sunxi/sun50i-dmic.c                      |   36 +-
 sound/soc/sunxi/sun8i-codec.c                      |  346 ++-
 sound/soc/tegra/Makefile                           |   46 +-
 sound/soc/tegra/tegra_asoc_machine.c               |    2 +-
 sound/soc/tegra/tegra_pcm.c                        |    6 +-
 sound/soc/ti/Makefile                              |   36 +-
 sound/soc/ti/davinci-i2s.c                         |  278 +-
 sound/soc/ti/omap-hdmi.c                           |    2 +-
 sound/soc/uniphier/Makefile                        |    8 +-
 sound/soc/uniphier/aio-dma.c                       |    2 +-
 sound/soc/ux500/Makefile                           |    6 +-
 sound/soc/ux500/ux500_msp_dai.c                    |    1 +
 sound/soc/xilinx/Makefile                          |    6 +-
 sound/soc/xilinx/xlnx_formatter_pcm.c              |    2 +
 sound/soc/xilinx/xlnx_i2s.c                        |    1 +
 sound/soc/xtensa/Makefile                          |    2 +-
 sound/sparc/Makefile                               |    6 +-
 sound/spi/Makefile                                 |    2 +-
 sound/synth/Makefile                               |    2 +-
 sound/synth/emux/Makefile                          |    2 +-
 sound/synth/emux/emux.c                            |    6 +-
 sound/synth/emux/emux_hwdep.c                      |    3 +-
 sound/synth/emux/emux_oss.c                        |    3 +-
 sound/synth/emux/emux_proc.c                       |    1 +
 sound/synth/emux/emux_seq.c                        |    6 +-
 sound/synth/emux/soundfont.c                       |   73 +-
 sound/usb/6fire/Makefile                           |    2 +-
 sound/usb/Makefile                                 |    4 +-
 sound/usb/card.c                                   |    4 +
 sound/usb/hiface/Makefile                          |    2 +-
 sound/usb/misc/Makefile                            |    2 +-
 sound/usb/mixer_quirks.c                           |    2 +
 sound/usb/mixer_scarlett2.c                        | 2945 ++++++++++++++++----
 sound/usb/quirks-table.h                           |   38 +-
 sound/usb/quirks.c                                 |   74 +-
 sound/usb/usx2y/Makefile                           |    4 +-
 sound/virtio/Makefile                              |    2 +-
 sound/x86/Makefile                                 |    2 +-
 sound/xen/Makefile                                 |    2 +-
 tools/sound/dapm-graph                             |  303 ++
 tools/testing/selftests/alsa/conf.c                |    2 +-
 814 files changed, 21220 insertions(+), 12870 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,ssi.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,ssi.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt2701-wm8960.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-das.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-das.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8776.txt
 create mode 100644 Documentation/sound/soc/dapm-graph.svg
 rename sound/soc/intel/boards/sof_ssp_common.h => include/sound/soc-acpi-intel-ssp-common.h (66%)
 create mode 100644 sound/soc/codecs/nau8325.c
 create mode 100644 sound/soc/codecs/nau8325.h
 create mode 100644 sound/soc/codecs/pcm6240.c
 create mode 100644 sound/soc/codecs/pcm6240.h
 create mode 100644 sound/soc/codecs/rk3308_codec.c
 create mode 100644 sound/soc/codecs/rk3308_codec.h
 create mode 100644 sound/soc/intel/boards/bridge_cs35l56.c
 delete mode 100644 sound/soc/intel/boards/cml_rt1011_rt5682.c
 delete mode 100644 sound/soc/intel/boards/glk_rt5682_max98357a.c
 delete mode 100644 sound/soc/intel/boards/sof_sdw_rt715.c
 delete mode 100644 sound/soc/intel/boards/sof_sdw_rt715_sdca.c
 create mode 100644 sound/soc/intel/boards/sof_sdw_rt_dmic.c
 delete mode 100644 sound/soc/intel/boards/sof_ssp_common.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-ssp-common.c
 create mode 100644 sound/soc/mediatek/common/mtk-dai-adda-common.c
 create mode 100644 sound/soc/mediatek/common/mtk-dai-adda-common.h
 delete mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
 rename sound/soc/mediatek/mt8186/{mt8186-mt6366-rt1019-rt5682s.c => mt8186-mt6366.c} (72%)
 create mode 100644 sound/soc/soc-card-test.c
 create mode 100644 sound/soc/sof/intel/lnl.h
 create mode 100644 sound/soc/sof/intel/tracepoints.c
 create mode 100755 tools/sound/dapm-graph


