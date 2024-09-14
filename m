Return-Path: <linux-kernel+bounces-329509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D7897922B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3731F223BA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7031D1301;
	Sat, 14 Sep 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SMDR1ojk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cc2o0oUE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SMDR1ojk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cc2o0oUE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70731D12E6;
	Sat, 14 Sep 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332307; cv=none; b=h681XsnwXyH26+A00QZV6x9QcUFkWafiwd7a7XI3n+kz+DL/lHLUR8hPOrtqnELDgfxhhgt4Idh5PGlTEpBW6xBWrBrQYMGLIe/kSynxmVUNvSR2GSlTCGq55bv3zjgx3y5cElV2lvCTRUX+0VN88UpMq9/25Mxhf7BFcbJvSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332307; c=relaxed/simple;
	bh=EPY5qhQKETijPB6mACJwu2+VqeBpYTnsFesVSWd0eKI=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=U49ijVxqlBjl3oj0nufTR/bb+ASAavUeL4GFSh1F/efdasBqfLo7FBxIsWeaC+W/S+Arc7kPrDcpoO83+Ln5tFyRv/wFS8CgJtSzmJEUcbqn4Tlrou3ZtTnHAmtwFfynCbMO2jLQh/3K/JhRkruClXa9x6as7hrzaJ8r2vtYEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SMDR1ojk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cc2o0oUE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SMDR1ojk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cc2o0oUE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E4C321993;
	Sat, 14 Sep 2024 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726332295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aLV/Bar4CAmgtBtN6weTuXdw2hir/APP5Fwd8nHEHPA=;
	b=SMDR1ojkf3bTEzBCD4b3CfSVLpWyFpncsxS1ncmwT5xGRUWPJfbVeFkhxdCDOAsfof0mZz
	C1+og0t9nWI0PK32GAHtHkVTSub5K1AAhbKtSRnLcJzOp8V1sIUiUMAOuMdsIzYUHiXAOe
	N6PbF5vXxCdS48fWOpBGW5BnQSdr4GM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726332295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aLV/Bar4CAmgtBtN6weTuXdw2hir/APP5Fwd8nHEHPA=;
	b=Cc2o0oUE/Q27y2cDFqyVvViQv9d06ApaEs1JZM0gyJIUs9JvJYYyX7zGyx/IT8dL8boYZ/
	tcuhU69yDZLaMCBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726332295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aLV/Bar4CAmgtBtN6weTuXdw2hir/APP5Fwd8nHEHPA=;
	b=SMDR1ojkf3bTEzBCD4b3CfSVLpWyFpncsxS1ncmwT5xGRUWPJfbVeFkhxdCDOAsfof0mZz
	C1+og0t9nWI0PK32GAHtHkVTSub5K1AAhbKtSRnLcJzOp8V1sIUiUMAOuMdsIzYUHiXAOe
	N6PbF5vXxCdS48fWOpBGW5BnQSdr4GM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726332295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aLV/Bar4CAmgtBtN6weTuXdw2hir/APP5Fwd8nHEHPA=;
	b=Cc2o0oUE/Q27y2cDFqyVvViQv9d06ApaEs1JZM0gyJIUs9JvJYYyX7zGyx/IT8dL8boYZ/
	tcuhU69yDZLaMCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8D5313A30;
	Sat, 14 Sep 2024 16:44:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g85SM4a95WbdZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 14 Sep 2024 16:44:54 +0000
Date: Sat, 14 Sep 2024 18:45:44 +0200
Message-ID: <87wmje9oav.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates for 6.12-rc1 (early PR)
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
	NEURAL_HAM_SHORT(-0.20)[-0.992];
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
X-Spam-Score: -3.30
X-Spam-Flag: NO

Linus,

please pull sound updates for v6.12-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc1

The topmost commit is 64c0ce555ad2d84f497f5f584ddd31e87ac690a2

----------------------------------------------------------------

sound updates for 6.12-rc1

A fairly big update at this time, both in core and driver sides.

The core received rewrites in PCM buffer allocation handling and
locking optimizations, PCM rate updates followed by lots of cleanups.

In ASoC side, the legacy Intel drivers have been deprecated by AVS
drivers which leaded to the significant amount of code reduction.
SoundWire driver updates and other cleanups contributed more code
reduction, too.

USB-audio driver received a large cleanup of its big quirk table, and
the old snd_print*() API usages in many legacy drivers are replaced
with the standard print API.

Here are some highlights:

Core:
- More optimized locking in ALSA control code
- Rewrites of memalloc helpers for better DMA API usage
- Drop of obsoleted vmalloc PCM buffer helper API
- Continued MIDI2 UMP updates
- Support of a new user-space driven timer instance
- Update for more PCM support rates and cleanups
- Xrun counter report in the proc files

ASoC:
- Continued simplification and cleanup works for ASoC
- Extensive cleanups and refactoring of the Soundwire drivers
- Removal of Intel machine support obsoleted by the AVS driver
- Lots of DT schema conversions
- Machine support for many AMD and Intel x86 platforms
- Support for AMD ACP 7.1, Mediatek MT6367 and MT8365, Realtek RTL1320
  SoundWire and rev C, and Texas Instruments TAS2563

USB-audio:
- Add support of multiple control interfaces
- A large rewrite of quirk table with macros
- Support for RME Digiface USB

HD-audio:
- Cleanup of quirk code for Samsung Galaxy laptops
- Clean up of detection of Cirrus codecs
- C-Media CM9825 HD-audio codec support

Others:
- Rewrites to standard print API in a lot of legacy drivers

----------------------------------------------------------------

Alexandre Mergnat (11):
      ASoC: dt-bindings: mediatek,mt8365-afe: Add audio afe document
      ASoC: dt-bindings: mediatek,mt8365-mt6357: Add audio sound card document
      dt-bindings: mfd: mediatek: Add codec property for MT6357 PMIC
      ASoC: mediatek: mt8365: Add common header
      ASoC: mediatek: mt8365: Add audio clock control support
      ASoC: mediatek: mt8365: Add I2S DAI support
      ASoC: mediatek: mt8365: Add ADDA DAI support
      ASoC: mediatek: mt8365: Add DMIC DAI support
      ASoC: mediatek: mt8365: Add PCM DAI support
      ASoC: mediatek: mt8365: Add the AFE driver support
      ASoC: mediatek: Add MT8365 support

Andrei Simion (1):
      ASoC: dt-bindings: microchip,sama7g5-spdifrx: Add common DAI reference

Andrew Kreimer (1):
      ASoC: tlv320aic31xx: Fix typos

Andy Shevchenko (1):
      ALSA: ump: Use %*ph to print small buffer

Animesh Agarwal (2):
      ASoC: dt-bindings: ti,pcm512x: Convert to dtschema
      ASoC: dt-bindings: fsl,imx-audio-es8328: Convert to dtschema

Arnd Bergmann (2):
      ASoC: mediatek: mt8365: include linux/bitfield.h
      ASoC: mediatek: mt8365: remove unused mt8365_i2s_hd_str

Asahi Lina (1):
      ALSA: usb-audio: Add mixer quirk for RME Digiface USB

Balamurugan C (4):
      ASoC: Intel: soc-acpi: Add entry for sof_es8336 in ARL match table.
      ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in ARL match table
      ASoC: Intel: sof_rt5682: Add HDMI-In capture with rt5682 support for ARL.
      ASoC: Intel: ARL: Add entry for HDMI-In capture support to non-I2S codec boards.

Baojun Xu (1):
      ASoC: tas2781: Remove unnecessary line feed for tasdevice_codec_remove

Bard Liao (6):
      ASoC: Intel: soc-acpi-intel-ptl-match: add rt711-sdca table
      ASoC: Intel: soc-acpi-intel-ptl-match: Add rt722 support
      ASoC: Intel: sof_sdw: add rt1320 amp support
      ASoC: SOF: Intel: hda: refactoring topology name fixup for HDA mach
      ASoC: Intel: sof_sdw: move ignore_internal_dmic check earlier
      ASoC: Intel: sof_sdw: overwrite mach_params->dmic_num

Biju Das (2):
      ASoC: dt-bindings: renesas,rz-ssi: Document port property
      ASoC: sh: rz-ssi: Add full duplex support

Binbin Zhou (7):
      ASoC: loongson: Use BIT() macro
      ASoC: loongson: Simplify probe() with local dev variable
      ASoC: loongson: Simplify with dev_err_probe()
      ASoC: loongson: Simplify if statment in loongson_card_hw_params()
      ASoC: loongson: Replace if with ternary operator
      ASoC: loongson: Factor out loongson_card_acpi_find_device() function
      ASoC: loongson: Factor out loongson i2s enable clock functions

Brent Lu (10):
      ASoC: SOF: Intel: hda: refactoring topology name fixup for SDW mach
      ASoC: SOF: Intel: hda: support BT link mask in mach_params
      ASoC: Intel: skl_hda_dsp_generic: support BT audio offload
      ASoC: Intel: skl_hda_dsp_generic: remove hdac-hdmi support
      ASoC: Intel: skl_hda_dsp_generic: use sof_hdmi_private to init HDMI
      ASoC: Intel: board_helpers: support HDA link initialization
      ASoC: Intel: skl_hda_dsp_generic: use common module for DAI links
      ASoC: Intel: ehl_rt5660: do not check common_hdmi_codec_drv
      ASoC: Intel: sof_pcm512x: do not check common_hdmi_codec_drv
      ASoC: SOF: Intel: hda: remove common_hdmi_codec_drv

Cezary Rojewski (14):
      ALSA: hda: Move SST device entries to AVS
      ASoC: Intel: Drop skl_machine_pdata usage
      ASoC: Intel: Remove bxt_rt298 board driver
      ASoC: Intel: Remove bxt_da7219_max98357a board driver
      ASoC: Intel: Remove kbl_rt5663_rt5514_max98927 board driver
      ASoC: Intel: Remove kbl_rt5663_max98927 board driver
      ASoC: Intel: Remove kbl_rt5660 board driver
      ASoC: Intel: Remove kbl_da7219_max98927 board driver
      ASoC: Intel: Remove kbl_da7219_max98357a board driver
      ASoC: Intel: Remove skl_rt286 board driver
      ASoC: Intel: Remove skl_nau88l25_ssm4567 board driver
      ASoC: Intel: Remove skl_nau88l25_max98357a board driver
      ASoC: Intel: Remove skylake driver
      ASoC: Intel: avs: Enable by default for all SST configurations

Charles Keepax (3):
      ASoC: Intel: soc-acpi: arl: Add match entries for new cs42l43 laptops
      ASoC: Intel: soc-acpi: adl: Add match entries for new cs42l43 laptops
      ASoC: Intel: soc-acpi: lnl: Add match entries for new cs42l43 laptops

Chen Ni (4):
      ASoC: mediatek: mt8192: remove redundant null pointer check before of_node_put
      ASoC: cs42l42: Convert comma to semicolon
      ASoC: topology-test: Convert comma to semicolon
      ASoC: Intel: skl_hda_dsp_generic: convert comma to semicolon

Christophe JAILLET (4):
      ASoC: sti-sas: Constify snd_soc_component_driver struct
      ASoC: cs43130: Constify snd_soc_component_driver struct
      ASoC: cs43130: Constify struct reg_sequence and reg_sequences
      ASoC: rt1318: Constify struct reg_sequence

Codrin Ciubotariu (5):
      ASoC: atmel: mchp-i2s-mcc: Improve maxburst calculation for better performance
      ASoC: atmel: mchp-i2s-mcc: Remove interface name from stream_name
      ASoC: atmel: mchp-pdmc: Improve maxburst calculation for better performance
      ASoC: atmel: mchp-pdmc: Add snd_soc_dai_driver name
      ASoC: atmel: mchp-pdmc: Retain Non-Runtime Controls

Colin Ian King (2):
      ASoC: codecs: wcd934x: make read-only array minCode_param static const
      ALSA: ali5451: Remove trailing space after \n newline

Cyan Nyan (1):
      ALSA: usb-audio: Add quirk for RME Digiface USB

Dmitry Torokhov (1):
      ASoC: tas5086: use sleeping variants of gpiod API

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable mic on Vaio VJFH52

Fabio Estevam (7):
      ASoC: fsl_audmix: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
      ASoC: fsl_mqs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
      ASoC: fsl_rpmsg: Switch to RUNTIME_PM_OPS()
      ASoC: fsl_spdif: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
      ASoC: fsl_ssi: Switch to SYSTEM_SLEEP_PM_OPS
      ASoC: imx-audmux: Switch to SYSTEM_SLEEP_PM_OPS
      ASoC: imx-pcm-rpmsg: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()

Frank Li (2):
      ASoC: dt-bindings: convert tlv320aic31xx.txt to yaml
      ASoC: dt-bindings: Convert tpa6130a2.txt to yaml

Fred Oh (1):
      ASoC: SOF: Intel: add PTL specific power control register

Geert Uytterhoeven (1):
      ASoC: dt-bindings: dlg,da7213: Convert to json-schema

Gustavo A. R. Silva (1):
      ASoC: SOF: sof-audio: Avoid -Wflex-array-member-not-at-end warnings

He Lugang (1):
      ALSA: rme9652: remove unused parameter in macro

Heiko Stuebner (2):
      ASoC: dt-bindings: realtek,rt5616: document mclk clock
      ASoC: dt-bindings: realtek,rt5616: Document audio graph port

Hongbo Li (3):
      ASoC: dapm: Use IS_ERR_OR_NULL() helper function
      ALSA: pcm: replace simple_strtoul to kstrtoul
      ASoC: adi: Use str_enabled_disabled() helper

Ivan Orlov (4):
      ALSA: aloop: Allow using global timers
      Docs/sound: Add documentation for userspace-driven ALSA timers
      ALSA: timer: Introduce virtual userspace-driven timers
      selftests: ALSA: Cover userspace-driven timers with test

Jens Reidel (1):
      ASoC: qcom: sm8250: enable primary mi2s

Jerome Brunet (16):
      ALSA: snd-usb-caiaq: use snd_pcm_rate_to_rate_bit
      ASoC: amlogic: do not use dpcm_playback/capture flags
      ALSA: pcm: add more sample rate definitions
      ALSA: cmipci: drop SNDRV_PCM_RATE_KNOT
      ALSA: emu10k1: drop SNDRV_PCM_RATE_KNOT
      ALSA: hdsp: drop SNDRV_PCM_RATE_KNOT
      ALSA: hdspm: drop SNDRV_PCM_RATE_KNOT
      ASoC: cs35l36: drop SNDRV_PCM_RATE_KNOT
      ASoC: cs35l41: drop SNDRV_PCM_RATE_KNOT
      ASoC: cs53l30: drop SNDRV_PCM_RATE_KNOT
      ASoC: Intel: avs: drop SNDRV_PCM_RATE_KNOT
      ASoC: qcom: q6asm-dai: drop SNDRV_PCM_RATE_KNOT
      ASoC: sunxi: sun4i-codec: drop SNDRV_PCM_RATE_KNOT
      ASoC: cs35l34: drop useless rate contraint
      ASoC: spdif: extend supported rates to 768kHz
      ALSA: IEC958 definition for consumer status channel update

Jinjie Ruan (1):
      ALSA: core: timer: Use NSEC_PER_SEC macro

Jonathan LoBue (1):
      ALSA: hda/realtek: tas2781: Fix ROG ALLY X audio

Joshua Grisham (2):
      ALSA: hda/realtek: Refactor and simplify Samsung Galaxy Book init
      ALSA: hda/realtek: Add support for Galaxy Book2 Pro (NP950XEE)

Joshua Pius (1):
      ALSA: usb-audio: Add logitech Audio profile quirk

Karol Kosik (1):
      ALSA: usb-audio: Support multiple control interfaces

Krzysztof Kozlowski (16):
      ASoC: codecs: wsa881x: Drop unused version readout
      ASoC: codecs: wsa883x: Handle reading version failure
      ASoC: codecs: wsa883x: Simplify handling variant/version
      ASoC: codecs: wsa884x: Simplify handling variant
      ASoC: dt-bindings: qcom,apq8016-sbc-sndcard: move to separate binding
      ASoC: codecs: lpass-wsa-macro: Do not hard-code dai in VI mixer
      ASoC: codecs: wsa881x: Use designator array initializers for Soundwire ports
      ASoC: codecs: wsa883x: Use designator array initializers for Soundwire ports
      ASoC: codecs: wsa884x: Use designator array initializers for Soundwire ports
      ASoC: codecs: wcd938x: Drop unused defines and enums
      ASoC: codecs: wcd937x: Move max port number defines to enum
      ASoC: codecs: wcd938x: Move max port number defines to enum
      ASoC: codecs: wcd939x: Move max port number defines to enum
      ASoC: dt-bindings: samsung,odroid: drop stale clocks
      ASoC: MAINTAINERS: Drop incorrect tlv320aic31xx.txt path
      ASoC: codecs: wsa884x: Implement temperature reading and hwmon

Kuninori Morimoto (24):
      ASoC: rsnd: remove rsnd_mod_confirm_ssi() under DEBUG
      ASoC: rsnd: use pcm_dmaengine code
      ALSA: pci: pcxhr: use snd_pcm_direction_name()
      ALSA: pci: rme9652: use snd_pcm_direction_name()
      ALSA: trace: use snd_pcm_direction_name()
      ALSA: aloop: use snd_pcm_direction_name()
      ALSA: pcm_timer: use snd_pcm_direction_name()
      ASoC: stm: use snd_pcm_direction_name()
      ASoC: sof: pcm: use snd_pcm_direction_name()
      ASoC: sof: intel: use snd_pcm_direction_name()
      ASoC: fsl: lpc3xxx-i2s: use snd_pcm_direction_name()
      ASoC: tegra: use snd_pcm_direction_name()
      ASoC: soc-pcm: use snd_pcm_direction_name()
      ASoC: soc-dapm: use snd_pcm_direction_name()
      ASoC: remove bespoke trigger support
      ASoC: soc-pcm: remove snd_soc_dpcm_stream_{lock/unlock}_irq()
      ASoC: soc-pcm: remove snd_soc_dpcm_stream_lock_irqsave_nested()
      ASoC: soc-pcm: Indicate warning if dpcm_playback/capture were used for availability limition
      ASoC: remove snd_soc_dai_link_set_capabilities()
      ASoC: Intel: sof_sdw: use playback/capture_only flags
      ASoC: soc-pcm: move snd_soc_dpcm_can_be_xxx() to top
      ASoC: soc-pcm: makes snd_soc_dpcm_can_be_xxx() local function
      ASoC: makes rtd->initialized bit field
      ASoC: dt-bindings: renesas,rsnd: add post-init-providers property

Leo Tsai (1):
      ALSA: hda: Add a new CM9825 standard driver

Linus Walleij (3):
      ASoC: tas2781-i2c: Drop weird GPIO code
      ASoC: tas2781-i2c: Get the right GPIO line
      ASoC: tas*: Drop unused GPIO includes

Liu Jing (1):
      ASoC: mediatek: mt2701-cs42448: Optimize redundant code in mt2701_cs42448_machine_probe

Luca Ceresoli (3):
      ASoC: dapm-graph: remove the "ROOT" cluster
      ASoC: dapm-graph: visualize component On/Off bias level
      ASoC: dapm-graph: show path name for non-static routes

Lukasz Majewski (1):
      ASoC: dt-bindings: Convert mxs-saif.txt to fsl,saif.yaml (imx28 saif)

Ma Ke (2):
      ASoC: rt5682s: Return devm_of_clk_add_hw_provider to transfer the error
      ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error

Maciej Strozek (1):
      ASoC: Intel: sof_sdw: Add quirks from some new Dell laptops

Marek Vasut (1):
      ASoC: tlv320aic32x4: Add multi endpoint support

Mark Brown (7):
      ASoC: mt8365: Open code BIT() to avoid spurious warnings
      ASoC: mt8365: Remove spurious unsigned long casts
      ASoC: mt8365: Remove unused prototype for mt8365_afe_clk_group_48k()
      ASoC: mt8365: Make non-exported functions static
      ASoC: mt8365: Remove unused variables
      ASoC: mt8365: Remove unused DMIC IIR coefficient configuration
      ASoC: mt8365: Allow build coverage

Muhammad Usama Anjum (3):
      ASoC: amd: acp: Return in-case of error
      ASoC: mediatek: mt8365: check validity before usage of i2s_data
      ASoc: mediatek: mt8365: Remove unneeded assignment

Neil Armstrong (2):
      ASoC: dt-bindings: amlogic,axg-sound-card: document clocks property
      ASoC: dt-bindings: amlogic,gx-sound-card: document clocks property

Nicolas Belin (2):
      ASoc: mediatek: mt8365: Add a specific soundcard for EVK
      ASoC: codecs: add MT6357 support

Nikita Shubin (1):
      ASoC: dt-bindings: cirrus,cs4271: Convert to dtschema

Norman Bintang (1):
      ALSA: pcm: Add xrun counter for snd_pcm_substream

Pierre-Louis Bossart (11):
      ASoC: Intel: soc-acpi: add PTL match tables
      ASoC: SOF: Intel: add initial support for PTL
      ASoC: SOF: sof-priv.h: optimize snd_sof_platform_stream_params
      ASoC: SOF: sof-priv.h: optimize snd_sof_mailbox
      ASoC: SOF: sof-priv.h: optimize snd_sof_ipc_msg
      ASoC: SOF: sof-audio.h: optimize snd_sof_pcm_stream_pipeline_list
      ALSA/ASoC/SoundWire: Intel: use single definition for SDW_INTEL_MAX_LINKS
      soundwire: intel: add probe-time check on link id
      soundwire: intel: increase maximum number of links
      ASoC: Intel: sof_sdw: make sof_sdw_quirk static
      ASoC: Intel: boards: always check the result of acpi_dev_get_first_match_dev()

Richard Fitzgerald (2):
      ASoC: cs35l56: Make struct regmap_config const
      ASoC: cs-amp-lib: Add KUnit test case for empty calibration entries

Rob Herring (Arm) (2):
      ASoC: Use of_property_present()
      ASoC: Use of_property_read_bool()

Romain Gantois (1):
      ASoC: tlv320aic31xx: Add support for loading filter coefficients

Shen Lichuan (2):
      ALSA: usb-audio: Use kmemdup_array instead of kmemdup for multiple allocation
      ASoC: SOF: topology: Use kmemdup_array instead of kmemdup for multiple allocation

Shenghao Ding (7):
      ASoC: tas2781: Add TAS2563 into the Header
      ASoC: tas2781: Fix a compiling warning reported by robot kernel test due to adding tas2563_dvc_table
      ASoc: tas2781: Rename dai_driver name to unify the name between TAS2563 and TAS2781
      ASoc: tas2781: Remove unnecessary line feed and space
      ASoC: tas2781: mark const variables tas2563_dvc_table as __maybe_unused
      ASoC: tas2781: replace devm_kzalloc and scnprintf with devm_kstrdup
      ASoC: tas2781: Add Calibration Kcontrols for Chromebook

Shuming Fan (1):
      ASoC: rt1320: Add support for version C

Simon Trimmer (3):
      ASoC: cs35l56: Use regmap_read_bypassed() to wake the device
      ALSA: hda/realtek: Convert existing CS35L56 products to use autodetect fixup function
      ALSA: hda/realtek: Autodetect Cirrus Logic companion amplifier bindings

Srinivas Kandagatla (1):
      ASoC: dt-bindings: qcom,lpass-wsa-macro: correct clocks on SM8250

Stefan Stistrup (1):
      ALSA: usb-audio: Add input gain and master output mixer elements for RME Babyface Pro

Takashi Iwai (98):
      ASoC: Use __counted_by() annotation for snd_soc_pcm_runtime
      ALSA: control: Annotate snd_kcontrol with __counted_by()
      ALSA: ump: Update substream name from assigned FB names
      ALSA: hda: Keep PM disablement for deny-listed instance
      ALSA: hda: Enhance pm_blacklist option
      ALSA: control: Take power_ref lock primarily
      ALSA: control: Fix leftover snd_power_unref()
      ALSA: memalloc: Use DMA API for x86 WC page allocations, too
      ALSA: memalloc: Let IOMMU handle S/G primarily
      ALSA: ump: Handle MIDI 1.0 Function Block in MIDI 2.0 protocol
      ALSA: usb-audio: Add input value sanity checks for standard types
      ALSA: ump: Choose the protocol when protocol caps are changed
      ALSA: usb-audio: Accept multiple protocols in GTBs
      ALSA: usb-audio: Set MIDI1 flag appropriately for GTB MIDI 1.0 entry
      ALSA: usb-audio: Update UMP group attributes for GTB blocks, too
      ALSA: seq: Print MIDI 1.0 specific port in proc output
      ALSA: seq: Fix missing seq port info bit return for MIDI 1.0 block
      ALSA: portman2x4: Use standard print API
      ALSA: mts64: Use standard print API
      ALSA: mpu401: Use standard print API
      ALSA: mpu401_uart: Use standard print API
      ALSA: mtpav: Use standard print API
      ALSA: opl3: Use standard print API
      ALSA: opl4: Use standard print API
      ALSA: serial-u16550: Use standard print API
      ALSA: virmidi: Use standard print API
      ALSA: vx_core: Drop unused dev field
      ALSA: vx_core: Use standard print API
      ALSA: aloop: Use standard print API
      ALSA: dummy: Use standard print API
      ALSA: pcsp: Use standard print API
      ALSA: i2c: cs8427: Use standard print API
      ALSA: i2c: pt2258: Use standard print API
      ALSA: i2c: Drop commented old debug prints
      ALSA: ad1816a: Use standard print API
      ALSA: als100: Use standard print API
      ALSA: azt2320: Use standard print API
      ALSA: cmi8328: Use standard print API
      ALSA: cmi8330: Use standard print API
      ALSA: cs4236: Use standard print API
      ALSA: es1688: Use standard print API
      ALSA: es18xx: Use standard print API
      ALSA: gus: Use standard print API
      ALSA: msnd: Use standard print API
      ALSA: opl3sa2: Use standard print API
      ALSA: opti9xx: Use standard print API
      ALSA: sb: Use standard print API
      ALSA: control_led: Use dev_err()
      ALSA: pcm: oss: Use pr_debug()
      ALSA: sc6000: Use standard print API
      ALSA: sscape: Use standard print API
      ALSA: wavefront: Use standard print API
      ALSA: wss: Use standard print API
      ALSA: riptide: Use standard print API
      ALSA: korg1212: Use standard print API
      ALSA: lx6464es: Cleanup the print API usages
      ALSA: azt3328: Use pr_warn()
      ALSA: emu10k1: Use dev_warn()
      ALSA: trident: Use standard print API
      ALSA: emux: Use standard print API
      ALSA: usx2y: Use standard print API
      ALSA: usb-audio: Use standard print API
      ALSA: intel8x0: Drop unused snd_printd() calls
      ALSA: vxpocket: Use standard print API
      ALSA: pdaudiocf: Use standard print API
      ALSA: ppc: Use standard print API
      ALSA: sh: Use standard print API
      ALSA: sparc: Use standard print API
      ALSA: asihpi: Use standard print API
      ALSA: docs: Drop snd_print*() stuff
      ALSA: core: Drop snd_print stuff and co
      ALSA: asihpi: Fix potential OOB array access
      ALSA: hdsp: Break infinite MIDI input flush loop
      ALSA: usb-audio: Check shutdown at endpoint_set_interface()
      ALSA: vxpocket: Drop no longer existent chip->dev assignment
      ALSA: control: Fix power_ref lock order for compat code, too
      ALSA: vxpocket: Fix a typo at conversion to dev_*()
      ALSA: sparc: Fix a typo at dev_*() conversion
      ALSA: caiaq: Fix unused variable warning
      ALSA: usx2y: Drop no longer used variable
      ALSA: control: Rename ctl_files_rwlock to controls_rwlock
      ALSA: control: Optimize locking for look-up
      ASoC: Drop snd_soc_*_get_kcontrol_locked()
      ALSA: usb-audio: Define macros for quirk table entries
      ALSA: usb-audio: Replace complex quirk lines with macros
      ALSA: seq: Drop superfluous filter argument of get_event_dest_client()
      drm/bridge: dw-hdmi: Move vmalloc PCM buffer management into the driver
      ALSA: pcm: Drop PCM vmalloc buffer helpers
      ALSA: pcm: Fix the previous conversion to kstrtoul()
      ALSA: pcm: Fix yet more compile warning at replacement with kstrtoul()
      ALSA: core: Drop superfluous no_free_ptr() for memdup_user() errors
      ALSA: hda: Allow the default preallocation for x86 again
      ALSA: hda: Use non-SG allocation for the communication buffers
      ALSA: memalloc: Move snd_malloc_ops definition into memalloc.c again
      ALSA: memalloc: Drop Xen PV workaround again
      ALSA: pcm: Fix breakage of PCM rates used for topology
      ALSA: memalloc: Use proper DMA mapping API for x86 WC buffer allocations
      ALSA: memalloc: Use proper DMA mapping API for x86 S/G buffer allocations

Tang Bin (6):
      ASoC: loongson: remove redundant variable assignments
      ASoC: codecs: fix the right check and simplify code
      ASoC: soc-ac97: Fix the incorrect description
      ASoC: loongson: Add the correct judgement return
      ASoC: mediatek: mt7986-afe-pcm: Remove redundant error message
      ASoC: topology: Fix redundant logical jump

Uwe Kleine-König (1):
      ASoC: Switch back to struct platform_driver::remove()

Venkata Prasad Potturu (12):
      ASoC: amd: acp: Refactor TDM slots selction based on acp revision id
      ASoC: amd: acp: Refactor I2S dai driver
      ASoC: amd: acp: Update pcm hardware capabilities for acp6.3 platform
      ASoC: amd: acp: Add I2S TDM support for acp6.3 platform
      ASoC: amd: acp: Update pcm hardware capabilities for acp7.0 platform
      ASoC: amd: acp: Add I2S master clock generation support for acp7.0 platform
      ASoC: amd: acp: Set i2s clock for acp7.0 platform
      ASoC: amd: acp: Modify max channels and sample rate support for acp70 dai driver
      ASoC: amd: acp: Add I2S TDM support for acp7.0 platform
      ASoC: amd: acp: Add pte configuration for ACP7.0 platform
      ASoC: amd: acp: Add i2s master clock generation support for acp7.1 platform
      ASoC: amd: acp: Add I2S TDM support for acp7.1 platform

Vijendar Mukunda (47):
      ASoC: intel: rename codec_info and dai_info structures names
      ASoC: intel: rename soundwire common header macros
      ASoC: intel: rename soundwire machine driver soc ops
      ASoC: intel: rename soundwire codec helper functions
      ASoC: intel: rename maxim codec macros
      ASoC: intel: rename ignore_pch_dmic variable name
      ASoC: intel/sdw-utils: move soundwire machine driver soc ops
      ASoC: intel: move soundwire machine driver common structures
      ASoC: intel/sdw_utils: move soundwire machine driver helper functions
      ASoC: intel/sdw_utils: move dmic codec helper function
      ASoC: intel/sdw_utils: move rtk dmic helper functions
      ASoC: intel/sdw_utils: move rt712 sdca helper functions
      ASoC: intel/sdw_utils: move rt722 sdca helper functions
      ASoC: intel: split soundwire machine driver private data
      ASoC: intel/sdw_utils: move rt5682 codec helper function
      ASoC: intel/sdw_utils: move rtk jack common helper functions
      ASoC: intel/sdw_utils: move rt700 and rt711 codec helper functions
      ASoC: intel/sdw_utils: move rtk amp codec helper functions
      ASoC: intel/sdw_utils: move cirrus soundwire codec helper functions
      ASoC: intel/sdw_utils: move maxim codec helper functions
      ASoC: intel/sdw_utils: move dai id common macros
      ASoC: intel/sdw_utils: move soundwire dai type macros
      ASoC: intel/sdw_utils: move soundwire codec_info_list structure
      ASoC: intel/sdw_utils: move machine driver dai link helper functions
      ASoC: sdw_utils: refactor sof_sdw_card_late_probe function
      ASoC: intel/sdw_utils: refactor init_dai_link() and init_simple_dai_link()
      ASoC: soc-acpi: add pci revision id field in mach params structure
      ASoC: amd: acp: add soundwire machines for acp6.3 based platform
      ASoC: SOF: amd: add alternate machines for acp6.3 based platform
      ASoC: SOF: amd: update mach params subsystem_rev variable
      ASoC: amd/sdw_utils: add sof based soundwire generic machine driver
      ASoC: amd: acp: remove MODULE_ALIAS for SoundWire machine driver
      ASoC: amd: acp: add ZSC control register programming sequence
      ASoC: SOF: amd: update conditional check for cache register update
      ASoC: amd: acp: Convert comma to semicolon
      ASoC: amd: acp: add legacy driver support for ACP7.1 based platforms
      ASoC: amd: acp: replace desc->rev check with acp pci revision id
      ASoC: SOF: amd: remove unused variable from sof_amd_acp_desc structure
      ASoC: amd: Add acpi machine id for acp7.0 version based platform
      ASoC: SOF: amd: add support for acp7.0 based platform
      ASoC: amd: acp: remove MODULE_ALIAS for legacy machine driver
      ASoC: amd: acp: remove MODULE_ALIAS for sof based generic machine driver
      ASoC: intel: sof_sdw: rename soundwire endpoint and dailink structures
      ASoC: intel: sof_sdw: rename soundwire parsing helper functions
      ASoC: sdw_util/intel: move soundwire endpoint and dai link structures
      ASoC: sdw_utils/intel: move soundwire endpoint parsing helper functions
      ASoC: amd: acp: refactor SoundWire machine driver code

Wu Bo (1):
      ASoC: dwc: change to use devm_clk_get_enabled() helpers

Yue Haibing (5):
      ASoC: fsl: lpc3xxx-i2s: Remove set but not used variable 'savedbitclkrate'
      ASoC: fsl: lpc3xxx: Make some symbols static
      ALSA: oss: Remove unused declarations
      ALSA: seq: Remove unused declarations
      ALSA: trident: Remove unused declarations

Yuntao Liu (1):
      ALSA: hda: cs35l41: fix module autoloading

Zhang Yi (2):
      ASoC: codecs: ES8326: suspend issue
      ASoC: codecs: ES8326: input issue after init

Zhang Zekun (4):
      ALSA: aoa: Use helper function for_each_child_of_node()
      ASoC: audio-graph-card: Use for_each_child_of_node_scoped() to simplify code
      ASoC: audio-graph-card2: Use helper function of_get_child_count()
      ASoC: meson: Remove unused declartion in header file

tangbin (3):
      ASoC: loongson: Remove useless variable definitions
      ASoC: loongson: remove unnecessary assignment in i2s_resume()
      ASoC: loongson: fix error release

ying zuxin (1):
      ASoC: codecs: Use devm_clk_get_enabled() helpers

---
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   |   21 +
 .../bindings/sound/amlogic,axg-sound-card.yaml     |    7 +
 .../bindings/sound/amlogic,gx-sound-card.yaml      |    7 +
 .../devicetree/bindings/sound/cirrus,cs4271.yaml   |  101 +
 Documentation/devicetree/bindings/sound/cs4271.txt |   57 -
 Documentation/devicetree/bindings/sound/da7213.txt |   45 -
 .../devicetree/bindings/sound/dlg,da7213.yaml      |  103 +
 .../bindings/sound/fsl,imx-audio-es8328.yaml       |  111 +
 .../devicetree/bindings/sound/fsl,saif.yaml        |   83 +
 .../devicetree/bindings/sound/imx-audio-es8328.txt |   60 -
 .../bindings/sound/mediatek,mt8365-afe.yaml        |  130 +
 .../bindings/sound/mediatek,mt8365-mt6357.yaml     |  107 +
 .../bindings/sound/microchip,sama7g5-spdifrx.yaml  |    5 +-
 .../devicetree/bindings/sound/mxs-saif.txt         |   41 -
 .../devicetree/bindings/sound/pcm512x.txt          |   53 -
 .../bindings/sound/qcom,apq8016-sbc-sndcard.yaml   |  205 ++
 .../bindings/sound/qcom,lpass-wsa-macro.yaml       |   22 +-
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |  137 -
 .../devicetree/bindings/sound/realtek,rt5616.yaml  |   12 +
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |    6 +
 .../devicetree/bindings/sound/renesas,rz-ssi.yaml  |    4 +
 .../devicetree/bindings/sound/samsung,odroid.yaml  |    5 -
 .../devicetree/bindings/sound/ti,pcm512x.yaml      |  101 +
 .../bindings/sound/ti,tlv320dac3100.yaml           |  127 +
 .../devicetree/bindings/sound/ti,tpa6130a2.yaml    |   55 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   77 -
 .../devicetree/bindings/sound/tpa6130a2.txt        |   27 -
 Documentation/sound/alsa-configuration.rst         |    3 +
 Documentation/sound/hd-audio/notes.rst             |    6 -
 Documentation/sound/index.rst                      |    1 +
 .../sound/kernel-api/writing-an-alsa-driver.rst    |   25 -
 Documentation/sound/utimers.rst                    |  126 +
 MAINTAINERS                                        |    4 +-
 .../gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c    |   30 +-
 drivers/soundwire/intel.h                          |    7 +
 drivers/soundwire/intel_ace2x.c                    |   20 +
 drivers/soundwire/intel_auxdevice.c                |   14 +
 include/linux/soundwire/sdw_intel.h                |    8 +
 include/sound/aci.h                                |    1 +
 include/sound/asoundef.h                           |    6 +-
 include/sound/control.h                            |   27 +-
 include/sound/core.h                               |   69 +-
 include/sound/cs35l56.h                            |    6 +-
 include/sound/es1688.h                             |    1 +
 include/sound/memalloc.h                           |    7 +-
 include/sound/pcm.h                                |   49 +-
 include/sound/seq_kernel.h                         |    4 -
 include/sound/snd_wavefront.h                      |    4 -
 include/sound/soc-acpi-intel-match.h               |    2 +
 include/sound/soc-acpi.h                           |    6 +-
 include/sound/soc-card.h                           |    2 -
 include/sound/soc-component.h                      |    3 -
 include/sound/soc-dai.h                            |    6 +-
 include/sound/soc-dpcm.h                           |   19 -
 include/sound/soc.h                                |    7 +-
 include/sound/soc_sdw_utils.h                      |  247 ++
 include/sound/soundfont.h                          |    6 +-
 include/sound/tas2563-tlv.h                        |  279 ++
 include/sound/tas2781-tlv.h                        |  260 --
 include/sound/tas2781.h                            |   71 +-
 include/sound/ump.h                                |   12 +
 include/sound/vx_core.h                            |    1 -
 include/trace/events/asoc.h                        |    3 +-
 include/uapi/sound/asequencer.h                    |    2 +
 include/uapi/sound/asound.h                        |   17 +-
 sound/aoa/soundbus/i2sbus/core.c                   |    4 +-
 sound/core/Kconfig                                 |   19 +-
 sound/core/compress_offload.c                      |    2 +-
 sound/core/control.c                               |  212 +-
 sound/core/control_compat.c                        |   47 +-
 sound/core/control_led.c                           |    4 +-
 sound/core/init.c                                  |    2 +-
 sound/core/memalloc.c                              |  214 +-
 sound/core/memalloc_local.h                        |   16 -
 sound/core/misc.c                                  |   71 -
 sound/core/oss/mixer_oss.c                         |   10 +-
 sound/core/oss/pcm_plugin.h                        |    5 +-
 sound/core/pcm.c                                   |    6 +
 sound/core/pcm_lib.c                               |    3 +
 sound/core/pcm_memory.c                            |   68 +-
 sound/core/pcm_misc.c                              |   18 +-
 sound/core/pcm_native.c                            |   18 +-
 sound/core/pcm_timer.c                             |    3 +-
 sound/core/seq/oss/seq_oss_device.h                |    4 -
 sound/core/seq/seq_clientmgr.c                     |   26 +-
 sound/core/seq/seq_ports.c                         |    5 +
 sound/core/seq/seq_ports.h                         |    2 +
 sound/core/seq/seq_queue.h                         |    1 -
 sound/core/seq/seq_timer.h                         |    2 -
 sound/core/seq/seq_ump_client.c                    |   79 +-
 sound/core/seq/seq_ump_convert.c                   |   11 +-
 sound/core/timer.c                                 |  229 +-
 sound/core/ump.c                                   |  120 +-
 sound/drivers/aloop.c                              |    7 +-
 sound/drivers/dummy.c                              |    5 +-
 sound/drivers/mpu401/mpu401.c                      |   16 +-
 sound/drivers/mpu401/mpu401_uart.c                 |   31 +-
 sound/drivers/mtpav.c                              |   14 +-
 sound/drivers/mts64.c                              |   18 +-
 sound/drivers/opl3/opl3_lib.c                      |   18 +-
 sound/drivers/opl3/opl3_midi.c                     |   95 +-
 sound/drivers/opl3/opl3_oss.c                      |   12 +-
 sound/drivers/opl3/opl3_synth.c                    |    4 +-
 sound/drivers/opl4/opl4_lib.c                      |    8 +-
 sound/drivers/opl4/yrw801.c                        |    2 +-
 sound/drivers/pcsp/pcsp.c                          |   21 +-
 sound/drivers/pcsp/pcsp_lib.c                      |   38 +-
 sound/drivers/pcsp/pcsp_mixer.c                    |    2 +-
 sound/drivers/portman2x4.c                         |   19 +-
 sound/drivers/serial-u16550.c                      |   41 +-
 sound/drivers/virmidi.c                            |    8 +-
 sound/drivers/vx/vx_core.c                         |   64 +-
 sound/drivers/vx/vx_hwdep.c                        |    4 +-
 sound/drivers/vx/vx_pcm.c                          |   23 +-
 sound/drivers/vx/vx_uer.c                          |    3 +-
 sound/hda/Kconfig                                  |    5 +-
 sound/hda/intel-dsp-config.c                       |  111 +-
 sound/hda/intel-sdw-acpi.c                         |    5 +-
 sound/i2c/cs8427.c                                 |   37 +-
 sound/i2c/other/ak4113.c                           |    2 -
 sound/i2c/other/ak4114.c                           |   12 -
 sound/i2c/other/ak4117.c                           |   13 -
 sound/i2c/other/ak4xxx-adda.c                      |    2 -
 sound/i2c/other/pt2258.c                           |    6 +-
 sound/i2c/tea6330t.c                               |    3 -
 sound/isa/ad1816a/ad1816a.c                        |   16 +-
 sound/isa/ad1816a/ad1816a_lib.c                    |   16 +-
 sound/isa/als100.c                                 |   16 +-
 sound/isa/azt2320.c                                |   14 +-
 sound/isa/cmi8328.c                                |   42 +-
 sound/isa/cmi8330.c                                |   36 +-
 sound/isa/cs423x/cs4236.c                          |   31 +-
 sound/isa/cs423x/cs4236_lib.c                      |   56 +-
 sound/isa/es1688/es1688.c                          |    2 +-
 sound/isa/es1688/es1688_lib.c                      |   55 +-
 sound/isa/es18xx.c                                 |   87 +-
 sound/isa/gus/gus_dma.c                            |   37 +-
 sound/isa/gus/gus_io.c                             |  215 +-
 sound/isa/gus/gus_irq.c                            |    7 +-
 sound/isa/gus/gus_main.c                           |   29 +-
 sound/isa/gus/gus_mem.c                            |    2 +-
 sound/isa/gus/gus_pcm.c                            |   33 +-
 sound/isa/gus/gus_reset.c                          |    8 +-
 sound/isa/gus/gus_uart.c                           |   21 +-
 sound/isa/gus/gus_volume.c                         |    7 +-
 sound/isa/gus/gusclassic.c                         |    4 +-
 sound/isa/gus/gusextreme.c                         |    4 +-
 sound/isa/gus/gusmax.c                             |   16 +-
 sound/isa/gus/interwave.c                          |   61 +-
 sound/isa/msnd/msnd.c                              |   46 +-
 sound/isa/msnd/msnd_midi.c                         |    4 -
 sound/isa/msnd/msnd_pinnacle.c                     |  184 +-
 sound/isa/opl3sa2.c                                |   46 +-
 sound/isa/opti9xx/miro.c                           |  163 +-
 sound/isa/opti9xx/opti92x-ad1848.c                 |   62 +-
 sound/isa/sb/emu8000.c                             |   11 +-
 sound/isa/sb/emu8000_patch.c                       |    1 -
 sound/isa/sb/emu8000_synth.c                       |    2 +-
 sound/isa/sb/jazz16.c                              |   49 +-
 sound/isa/sb/sb16.c                                |   42 +-
 sound/isa/sb/sb16_csp.c                            |   38 +-
 sound/isa/sb/sb16_main.c                           |   13 +-
 sound/isa/sb/sb8.c                                 |   12 +-
 sound/isa/sb/sb_common.c                           |   27 +-
 sound/isa/sb/sb_mixer.c                            |    4 +-
 sound/isa/sc6000.c                                 |  177 +-
 sound/isa/sscape.c                                 |   96 +-
 sound/isa/wavefront/wavefront.c                    |   61 +-
 sound/isa/wavefront/wavefront_fx.c                 |   36 +-
 sound/isa/wavefront/wavefront_midi.c               |   15 +-
 sound/isa/wavefront/wavefront_synth.c              |  196 +-
 sound/isa/wss/wss_lib.c                            |  178 +-
 sound/pci/ali5451/ali5451.c                        |    2 +-
 sound/pci/asihpi/asihpi.c                          |  101 +-
 sound/pci/asihpi/hpimsgx.c                         |    2 +-
 sound/pci/asihpi/hpioctl.c                         |    2 +-
 sound/pci/azt3328.c                                |    2 +-
 sound/pci/cmipci.c                                 |   32 +-
 sound/pci/emu10k1/emu10k1_patch.c                  |    5 +-
 sound/pci/emu10k1/emupcm.c                         |   31 +-
 sound/pci/hda/cs35l41_hda_spi.c                    |    1 +
 sound/pci/hda/hda_component.c                      |   19 +-
 sound/pci/hda/hda_component.h                      |    2 +-
 sound/pci/hda/hda_intel.c                          |   21 +-
 sound/pci/hda/hda_intel.h                          |    1 +
 sound/pci/hda/patch_cmedia.c                       |  269 ++
 sound/pci/hda/patch_realtek.c                      |  375 +-
 sound/pci/hda/samsung_helper.c                     |  310 --
 sound/pci/hda/tas2781_hda_i2c.c                    |    2 +-
 sound/pci/intel8x0.c                               |    3 -
 sound/pci/intel8x0m.c                              |    3 -
 sound/pci/korg1212/korg1212.c                      |   30 +-
 sound/pci/lx6464es/lx_core.c                       |    8 +-
 sound/pci/lx6464es/lx_core.h                       |    3 -
 sound/pci/pcxhr/pcxhr_mix22.c                      |    2 +-
 sound/pci/riptide/riptide.c                        |  193 +-
 sound/pci/rme9652/hdsp.c                           |   24 +-
 sound/pci/rme9652/hdspm.c                          |   36 +-
 sound/pci/trident/trident.h                        |    5 -
 sound/pci/trident/trident_memory.c                 |   10 +-
 sound/pcmcia/pdaudiocf/pdaudiocf.c                 |   21 +-
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c            |   36 +-
 sound/pcmcia/pdaudiocf/pdaudiocf_irq.c             |    3 +-
 sound/pcmcia/vx/vxp_ops.c                          |   10 +-
 sound/pcmcia/vx/vxpocket.c                         |   27 +-
 sound/ppc/awacs.c                                  |    4 +-
 sound/ppc/daca.c                                   |    2 +-
 sound/ppc/keywest.c                                |    5 +-
 sound/ppc/pmac.c                                   |   52 +-
 sound/ppc/powermac.c                               |    2 +-
 sound/ppc/tumbler.c                                |   21 +-
 sound/sh/aica.c                                    |    7 +-
 sound/sh/sh_dac_audio.c                            |    8 +-
 sound/soc/Kconfig                                  |    2 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/adi/axi-i2s.c                            |    6 +-
 sound/soc/adi/axi-spdif.c                          |    2 +-
 sound/soc/amd/acp-config.c                         |   12 +
 sound/soc/amd/acp-pcm-dma.c                        |    2 +-
 sound/soc/amd/acp/Kconfig                          |   22 +
 sound/soc/amd/acp/Makefile                         |    4 +
 sound/soc/amd/acp/acp-i2s.c                        |  182 +-
 sound/soc/amd/acp/acp-legacy-common.c              |   40 +-
 sound/soc/amd/acp/acp-legacy-mach.c                |    7 -
 sound/soc/amd/acp/acp-mach-common.c                |    2 +-
 sound/soc/amd/acp/acp-mach.h                       |    1 +
 sound/soc/amd/acp/acp-pci.c                        |    4 +
 sound/soc/amd/acp/acp-pdm.c                        |    7 +-
 sound/soc/amd/acp/acp-platform.c                   |  117 +-
 sound/soc/amd/acp/acp-rembrandt.c                  |    2 +-
 sound/soc/amd/acp/acp-renoir.c                     |    2 +-
 sound/soc/amd/acp/acp-sdw-sof-mach.c               |  509 +++
 sound/soc/amd/acp/acp-sof-mach.c                   |    7 -
 sound/soc/amd/acp/acp63.c                          |    2 +-
 sound/soc/amd/acp/acp70.c                          |   87 +-
 sound/soc/amd/acp/amd-acp63-acpi-match.c           |   90 +
 sound/soc/amd/acp/amd.h                            |   27 +-
 sound/soc/amd/acp/chip_offset_byte.h               |   84 +-
 sound/soc/amd/acp/soc_amd_sdw_common.h             |   44 +
 sound/soc/amd/mach-config.h                        |    2 +
 sound/soc/amd/ps/ps-pdm-dma.c                      |    2 +-
 sound/soc/amd/ps/ps-sdw-dma.c                      |    2 +-
 sound/soc/amd/raven/acp3x-pcm-dma.c                |    2 +-
 sound/soc/amd/renoir/acp3x-pdm-dma.c               |    2 +-
 sound/soc/amd/vangogh/acp5x-pcm-dma.c              |    2 +-
 sound/soc/amd/yc/acp6x-pdm-dma.c                   |    2 +-
 sound/soc/apple/mca.c                              |    2 +-
 sound/soc/atmel/atmel-i2s.c                        |    2 +-
 sound/soc/atmel/atmel_wm8904.c                     |    2 +-
 sound/soc/atmel/mchp-i2s-mcc.c                     |   44 +-
 sound/soc/atmel/mchp-pdmc.c                        |   99 +-
 sound/soc/atmel/mchp-spdifrx.c                     |    2 +-
 sound/soc/atmel/mchp-spdiftx.c                     |    2 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |    2 +-
 sound/soc/atmel/sam9x5_wm8731.c                    |    2 +-
 sound/soc/atmel/tse850-pcm5142.c                   |    2 +-
 sound/soc/au1x/ac97c.c                             |    2 +-
 sound/soc/au1x/i2sc.c                              |    2 +-
 sound/soc/au1x/psc-ac97.c                          |    2 +-
 sound/soc/au1x/psc-i2s.c                           |    2 +-
 sound/soc/bcm/bcm63xx-i2s-whistler.c               |    2 +-
 sound/soc/bcm/cygnus-ssp.c                         |    2 +-
 sound/soc/cirrus/edb93xx.c                         |    2 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |    2 +-
 sound/soc/codecs/Kconfig                           |    7 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ak4613.c                          |    4 +-
 sound/soc/codecs/cs-amp-lib-test.c                 |   44 +
 sound/soc/codecs/cs35l34.c                         |   21 -
 sound/soc/codecs/cs35l36.c                         |   34 +-
 sound/soc/codecs/cs35l41.c                         |   34 +-
 sound/soc/codecs/cs35l45.c                         |    2 +-
 sound/soc/codecs/cs35l56-shared.c                  |   25 +-
 sound/soc/codecs/cs42l42-sdw.c                     |   12 +-
 sound/soc/codecs/cs42l43.c                         |    2 +-
 sound/soc/codecs/cs43130.c                         |  113 +-
 sound/soc/codecs/cs47l15.c                         |    2 +-
 sound/soc/codecs/cs47l24.c                         |    2 +-
 sound/soc/codecs/cs47l35.c                         |    2 +-
 sound/soc/codecs/cs47l85.c                         |    2 +-
 sound/soc/codecs/cs47l90.c                         |    2 +-
 sound/soc/codecs/cs47l92.c                         |    2 +-
 sound/soc/codecs/cs53l30.c                         |   24 +-
 sound/soc/codecs/es8326.c                          |    6 +-
 sound/soc/codecs/inno_rk3036.c                     |    2 +-
 sound/soc/codecs/lpass-rx-macro.c                  |    2 +-
 sound/soc/codecs/lpass-tx-macro.c                  |    2 +-
 sound/soc/codecs/lpass-va-macro.c                  |    2 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |   27 +-
 sound/soc/codecs/msm8916-wcd-digital.c             |    2 +-
 sound/soc/codecs/mt6357.c                          | 1855 ++++++++++
 sound/soc/codecs/mt6357.h                          |  660 ++++
 sound/soc/codecs/peb2466.c                         |   14 +-
 sound/soc/codecs/rk817_codec.c                     |    2 +-
 sound/soc/codecs/rt1318.c                          |    3 +-
 sound/soc/codecs/rt1320-sdw.c                      | 2147 +++++++++++-
 sound/soc/codecs/rt1320-sdw.h                      |    3 +
 sound/soc/codecs/rt5682.c                          |    4 +-
 sound/soc/codecs/rt5682s.c                         |    4 +-
 sound/soc/codecs/spdif_receiver.c                  |    3 +-
 sound/soc/codecs/spdif_transmitter.c               |    3 +-
 sound/soc/codecs/sti-sas.c                         |   21 +-
 sound/soc/codecs/tas2552.c                         |    1 -
 sound/soc/codecs/tas2764.c                         |    1 -
 sound/soc/codecs/tas2770.c                         |    1 -
 sound/soc/codecs/tas2780.c                         |    1 -
 sound/soc/codecs/tas2781-comlib.c                  |   35 +-
 sound/soc/codecs/tas2781-fmwlib.c                  |   61 +-
 sound/soc/codecs/tas2781-i2c.c                     |  953 +++++-
 sound/soc/codecs/tas5086.c                         |    9 +-
 sound/soc/codecs/tlv320aic31xx.c                   |  102 +-
 sound/soc/codecs/tlv320aic32x4.c                   |    9 +
 sound/soc/codecs/wcd934x.c                         |    4 +-
 sound/soc/codecs/wcd937x.c                         |    2 +-
 sound/soc/codecs/wcd937x.h                         |   34 +-
 sound/soc/codecs/wcd938x.c                         |   20 +-
 sound/soc/codecs/wcd938x.h                         |    4 +-
 sound/soc/codecs/wcd939x.c                         |    2 +-
 sound/soc/codecs/wcd939x.h                         |    6 +-
 sound/soc/codecs/wm5102.c                          |    2 +-
 sound/soc/codecs/wm5110.c                          |    2 +-
 sound/soc/codecs/wm8994.c                          |    2 +-
 sound/soc/codecs/wm8997.c                          |    2 +-
 sound/soc/codecs/wm8998.c                          |    2 +-
 sound/soc/codecs/wsa881x.c                         |   44 +-
 sound/soc/codecs/wsa883x.c                         |   75 +-
 sound/soc/codecs/wsa884x.c                         |  240 +-
 sound/soc/dwc/dwc-i2s.c                            |   18 +-
 sound/soc/fsl/fsl_asrc.c                           |    2 +-
 sound/soc/fsl/fsl_aud2htx.c                        |    2 +-
 sound/soc/fsl/fsl_audmix.c                         |   14 +-
 sound/soc/fsl/fsl_dma.c                            |    2 +-
 sound/soc/fsl/fsl_easrc.c                          |    2 +-
 sound/soc/fsl/fsl_esai.c                           |    2 +-
 sound/soc/fsl/fsl_micfil.c                         |    2 +-
 sound/soc/fsl/fsl_mqs.c                            |   13 +-
 sound/soc/fsl/fsl_rpmsg.c                          |   11 +-
 sound/soc/fsl/fsl_sai.c                            |    2 +-
 sound/soc/fsl/fsl_spdif.c                          |   13 +-
 sound/soc/fsl/fsl_ssi.c                            |    8 +-
 sound/soc/fsl/fsl_xcvr.c                           |    4 +-
 sound/soc/fsl/imx-audmux.c                         |    8 +-
 sound/soc/fsl/imx-card.c                           |    3 -
 sound/soc/fsl/imx-pcm-rpmsg.c                      |   16 +-
 sound/soc/fsl/imx-sgtl5000.c                       |    2 +-
 sound/soc/fsl/lpc3xxx-i2s.c                        |   11 +-
 sound/soc/fsl/lpc3xxx-pcm.c                        |    2 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |    2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                    |    4 +-
 sound/soc/fsl/p1022_ds.c                           |    2 +-
 sound/soc/fsl/p1022_rdk.c                          |    2 +-
 sound/soc/fsl/pcm030-audio-fabric.c                |    2 +-
 sound/soc/generic/audio-graph-card.c               |   16 +-
 .../soc/generic/audio-graph-card2-custom-sample.c  |    2 +-
 sound/soc/generic/audio-graph-card2.c              |   15 +-
 sound/soc/generic/simple-card.c                    |    4 +-
 sound/soc/generic/test-component.c                 |   11 +-
 sound/soc/img/img-i2s-in.c                         |    2 +-
 sound/soc/img/img-i2s-out.c                        |    2 +-
 sound/soc/img/img-parallel-out.c                   |    2 +-
 sound/soc/img/img-spdif-in.c                       |    2 +-
 sound/soc/img/img-spdif-out.c                      |    2 +-
 sound/soc/img/pistachio-internal-dac.c             |    2 +-
 sound/soc/intel/Kconfig                            |  120 -
 sound/soc/intel/Makefile                           |    1 -
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |    2 +-
 sound/soc/intel/avs/core.c                         |    8 +-
 sound/soc/intel/avs/pcm.c                          |   22 +-
 sound/soc/intel/boards/Kconfig                     |  156 +-
 sound/soc/intel/boards/Makefile                    |   31 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |  720 ----
 sound/soc/intel/boards/bxt_rt298.c                 |  670 ----
 sound/soc/intel/boards/bytcht_cx2072x.c            |    4 +
 sound/soc/intel/boards/bytcht_da7213.c             |    4 +
 sound/soc/intel/boards/bytcht_es8316.c             |    4 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |    4 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    4 +-
 sound/soc/intel/boards/bytcr_wm5102.c              |    2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |    2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    4 +
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    4 +
 sound/soc/intel/boards/ehl_rt5660.c                |    3 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c      |  688 ----
 sound/soc/intel/boards/kbl_da7219_max98927.c       | 1175 -------
 sound/soc/intel/boards/kbl_rt5660.c                |  567 ---
 sound/soc/intel/boards/kbl_rt5663_max98927.c       | 1073 ------
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |  869 -----
 sound/soc/intel/boards/skl_hda_dsp_common.c        |  168 -
 sound/soc/intel/boards/skl_hda_dsp_common.h        |   67 -
 sound/soc/intel/boards/skl_hda_dsp_generic.c       |  242 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |  704 ----
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |  751 ----
 sound/soc/intel/boards/skl_rt286.c                 |  568 ---
 sound/soc/intel/boards/sof_board_helpers.c         |  152 +
 sound/soc/intel/boards/sof_board_helpers.h         |    3 +
 sound/soc/intel/boards/sof_es8336.c                |   14 +-
 sound/soc/intel/boards/sof_pcm512x.c               |    5 +-
 sound/soc/intel/boards/sof_rt5682.c                |    7 +
 sound/soc/intel/boards/sof_sdw.c                   | 1408 +-------
 sound/soc/intel/boards/sof_sdw_common.h            |  172 +-
 sound/soc/intel/boards/sof_sdw_hdmi.c              |   16 +-
 sound/soc/intel/boards/sof_ssp_amp.c               |    6 +
 sound/soc/intel/boards/sof_wm8804.c                |    6 +-
 sound/soc/intel/catpt/device.c                     |    2 +-
 sound/soc/intel/common/Makefile                    |    1 +
 sound/soc/intel/common/soc-acpi-intel-adl-match.c  |  105 +
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |  263 ++
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c  |    6 -
 sound/soc/intel/common/soc-acpi-intel-ehl-match.c  |    1 -
 sound/soc/intel/common/soc-acpi-intel-hda-match.c  |   18 +-
 sound/soc/intel/common/soc-acpi-intel-icl-match.c  |    6 -
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c  |   11 -
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |  104 +
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |  145 +
 sound/soc/intel/common/soc-acpi-intel-skl-match.c  |    5 -
 sound/soc/intel/skylake/Makefile                   |   15 -
 sound/soc/intel/skylake/bxt-sst.c                  |  629 ----
 sound/soc/intel/skylake/cnl-sst-dsp.c              |  266 --
 sound/soc/intel/skylake/cnl-sst-dsp.h              |  103 -
 sound/soc/intel/skylake/cnl-sst.c                  |  508 ---
 sound/soc/intel/skylake/skl-debug.c                |  248 --
 sound/soc/intel/skylake/skl-i2s.h                  |   87 -
 sound/soc/intel/skylake/skl-messages.c             | 1419 --------
 sound/soc/intel/skylake/skl-nhlt.c                 |  269 --
 sound/soc/intel/skylake/skl-pcm.c                  | 1507 --------
 sound/soc/intel/skylake/skl-ssp-clk.c              |  428 ---
 sound/soc/intel/skylake/skl-ssp-clk.h              |  108 -
 sound/soc/intel/skylake/skl-sst-cldma.c            |  373 --
 sound/soc/intel/skylake/skl-sst-cldma.h            |  243 --
 sound/soc/intel/skylake/skl-sst-dsp.c              |  462 ---
 sound/soc/intel/skylake/skl-sst-dsp.h              |  256 --
 sound/soc/intel/skylake/skl-sst-ipc.c              | 1071 ------
 sound/soc/intel/skylake/skl-sst-ipc.h              |  169 -
 sound/soc/intel/skylake/skl-sst-utils.c            |  425 ---
 sound/soc/intel/skylake/skl-sst.c                  |  599 ----
 sound/soc/intel/skylake/skl-topology.c             | 3605 --------------------
 sound/soc/intel/skylake/skl-topology.h             |  524 ---
 sound/soc/intel/skylake/skl.c                      | 1177 -------
 sound/soc/intel/skylake/skl.h                      |  207 --
 sound/soc/kirkwood/kirkwood-i2s.c                  |    2 +-
 sound/soc/loongson/loongson_card.c                 |  125 +-
 sound/soc/loongson/loongson_dma.c                  |   25 +-
 sound/soc/loongson/loongson_i2s.c                  |  115 +-
 sound/soc/loongson/loongson_i2s.h                  |   24 +-
 sound/soc/loongson/loongson_i2s_pci.c              |   51 +-
 sound/soc/mediatek/Kconfig                         |   20 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/common/mtk-btcvsd.c             |    2 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |    2 +-
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |   18 +-
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         |    2 +-
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c         |    9 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |    2 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         |    2 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c         |    2 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |    4 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c         |    2 +-
 sound/soc/mediatek/mt8365/Makefile                 |   15 +
 sound/soc/mediatek/mt8365/mt8365-afe-clk.c         |  421 +++
 sound/soc/mediatek/mt8365/mt8365-afe-clk.h         |   32 +
 sound/soc/mediatek/mt8365/mt8365-afe-common.h      |  448 +++
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c         | 2274 ++++++++++++
 sound/soc/mediatek/mt8365/mt8365-dai-adda.c        |  311 ++
 sound/soc/mediatek/mt8365/mt8365-dai-dmic.c        |  310 ++
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c         |  846 +++++
 sound/soc/mediatek/mt8365/mt8365-dai-pcm.c         |  293 ++
 sound/soc/mediatek/mt8365/mt8365-mt6357.c          |  343 ++
 sound/soc/mediatek/mt8365/mt8365-reg.h             |  993 ++++++
 sound/soc/meson/aiu-fifo.h                         |    2 -
 sound/soc/meson/aiu.c                              |    2 +-
 sound/soc/meson/axg-card.c                         |   13 +-
 sound/soc/meson/gx-card.c                          |    3 +-
 sound/soc/meson/meson-card-utils.c                 |    4 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |    2 +-
 sound/soc/pxa/mmp-sspa.c                           |    2 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |    2 +-
 sound/soc/qcom/common.c                            |    1 -
 sound/soc/qcom/lpass-apq8016.c                     |    2 +-
 sound/soc/qcom/lpass-ipq806x.c                     |    2 +-
 sound/soc/qcom/lpass-sc7180.c                      |    2 +-
 sound/soc/qcom/lpass-sc7280.c                      |    2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |   31 +-
 sound/soc/qcom/qdsp6/q6routing.c                   |    2 +-
 sound/soc/qcom/sm8250.c                            |    8 +
 sound/soc/rockchip/rockchip_i2s.c                  |    2 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c              |    2 +-
 sound/soc/rockchip/rockchip_pdm.c                  |    2 +-
 sound/soc/rockchip/rockchip_rt5645.c               |    2 +-
 sound/soc/rockchip/rockchip_spdif.c                |    2 +-
 sound/soc/samsung/arndale.c                        |    2 +-
 sound/soc/samsung/i2s.c                            |    2 +-
 sound/soc/samsung/odroid.c                         |    2 +-
 sound/soc/samsung/pcm.c                            |    2 +-
 sound/soc/samsung/snow.c                           |    2 +-
 sound/soc/samsung/spdif.c                          |    2 +-
 sound/soc/sdw_utils/Kconfig                        |    6 +
 sound/soc/sdw_utils/Makefile                       |   11 +
 .../soc_sdw_bridge_cs35l56.c}                      |   56 +-
 .../soc_sdw_cs42l42.c}                             |   13 +-
 .../soc_sdw_cs42l43.c}                             |   38 +-
 .../soc_sdw_cs_amp.c}                              |   18 +-
 .../sof_sdw_dmic.c => sdw_utils/soc_sdw_dmic.c}    |   10 +-
 .../sof_sdw_maxim.c => sdw_utils/soc_sdw_maxim.c}  |   56 +-
 .../soc_sdw_rt5682.c}                              |   12 +-
 .../sof_sdw_rt700.c => sdw_utils/soc_sdw_rt700.c}  |   12 +-
 .../sof_sdw_rt711.c => sdw_utils/soc_sdw_rt711.c}  |   38 +-
 .../soc_sdw_rt712_sdca.c}                          |   10 +-
 .../soc_sdw_rt722_sdca.c}                          |   10 +-
 .../soc_sdw_rt_amp.c}                              |   43 +-
 .../soc_sdw_rt_amp_coeff_tables.h}                 |    6 +-
 .../soc_sdw_rt_dmic.c}                             |   11 +-
 .../soc_sdw_rt_sdca_jack_common.c}                 |   40 +-
 sound/soc/sdw_utils/soc_sdw_utils.c                | 1170 +++++++
 sound/soc/sh/Kconfig                               |    1 +
 sound/soc/sh/fsi.c                                 |    2 +-
 sound/soc/sh/hac.c                                 |    2 +-
 sound/soc/sh/rcar/adg.c                            |    4 +-
 sound/soc/sh/rcar/core.c                           |   19 +-
 sound/soc/sh/rcar/dma.c                            |   75 +-
 sound/soc/sh/rcar/rsnd.h                           |   10 -
 sound/soc/sh/rcar/ssi.c                            |    2 +-
 sound/soc/sh/rz-ssi.c                              |  291 +-
 sound/soc/sh/siu_dai.c                             |    2 +-
 sound/soc/soc-ac97.c                               |    4 +-
 sound/soc/soc-card-test.c                          |   57 -
 sound/soc/soc-card.c                               |   10 -
 sound/soc/soc-component.c                          |   12 -
 sound/soc/soc-core.c                               |   21 +-
 sound/soc/soc-dai.c                                |   58 -
 sound/soc/soc-dapm.c                               |    5 +-
 sound/soc/soc-pcm.c                                |  364 +-
 sound/soc/soc-topology-test.c                      |  132 +-
 sound/soc/soc-topology.c                           |    9 +-
 sound/soc/sof/amd/Kconfig                          |   11 +
 sound/soc/sof/amd/Makefile                         |    4 +-
 sound/soc/sof/amd/acp-common.c                     |    3 +
 sound/soc/sof/amd/acp-dsp-offset.h                 |   24 +-
 sound/soc/sof/amd/acp-loader.c                     |    2 +-
 sound/soc/sof/amd/acp.c                            |   88 +-
 sound/soc/sof/amd/acp.h                            |   11 +-
 sound/soc/sof/amd/acp70.c                          |  142 +
 sound/soc/sof/amd/pci-acp63.c                      |    2 +-
 sound/soc/sof/amd/pci-acp70.c                      |  112 +
 sound/soc/sof/amd/pci-rmb.c                        |    1 -
 sound/soc/sof/amd/pci-rn.c                         |    1 -
 sound/soc/sof/amd/pci-vangogh.c                    |    1 -
 sound/soc/sof/imx/imx8.c                           |    2 +-
 sound/soc/sof/imx/imx8m.c                          |    2 +-
 sound/soc/sof/imx/imx8ulp.c                        |    2 +-
 sound/soc/sof/intel/Kconfig                        |   17 +
 sound/soc/sof/intel/Makefile                       |    2 +
 sound/soc/sof/intel/bdw.c                          |    2 +-
 sound/soc/sof/intel/byt.c                          |    2 +-
 sound/soc/sof/intel/hda-dsp.c                      |    1 +
 sound/soc/sof/intel/hda-stream.c                   |    4 +-
 sound/soc/sof/intel/hda.c                          |  282 +-
 sound/soc/sof/intel/hda.h                          |    1 +
 sound/soc/sof/intel/lnl.c                          |   27 +
 sound/soc/sof/intel/mtl.c                          |   16 +-
 sound/soc/sof/intel/mtl.h                          |    2 +
 sound/soc/sof/intel/pci-ptl.c                      |   77 +
 sound/soc/sof/intel/shim.h                         |    1 +
 sound/soc/sof/mediatek/mt8186/mt8186.c             |    2 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c             |    2 +-
 sound/soc/sof/pcm.c                                |    2 +-
 sound/soc/sof/sof-audio.h                          |    8 +-
 sound/soc/sof/sof-priv.h                           |   16 +-
 sound/soc/sof/topology.c                           |    8 +-
 sound/soc/sprd/sprd-mcdt.c                         |    2 +-
 sound/soc/starfive/jh7110_pwmdac.c                 |    2 +-
 sound/soc/starfive/jh7110_tdm.c                    |    2 +-
 sound/soc/stm/stm32_adfsdm.c                       |    2 +-
 sound/soc/stm/stm32_i2s.c                          |    6 +-
 sound/soc/stm/stm32_sai_sub.c                      |    2 +-
 sound/soc/stm/stm32_spdifrx.c                      |    2 +-
 sound/soc/sunxi/sun4i-codec.c                      |   30 +-
 sound/soc/sunxi/sun4i-i2s.c                        |    2 +-
 sound/soc/sunxi/sun4i-spdif.c                      |    2 +-
 sound/soc/sunxi/sun50i-dmic.c                      |    2 +-
 sound/soc/sunxi/sun8i-codec.c                      |    2 +-
 sound/soc/tegra/tegra186_asrc.c                    |    2 +-
 sound/soc/tegra/tegra186_dspk.c                    |    2 +-
 sound/soc/tegra/tegra20_ac97.c                     |    2 +-
 sound/soc/tegra/tegra20_i2s.c                      |    2 +-
 sound/soc/tegra/tegra210_admaif.c                  |    2 +-
 sound/soc/tegra/tegra210_adx.c                     |    2 +-
 sound/soc/tegra/tegra210_ahub.c                    |    2 +-
 sound/soc/tegra/tegra210_amx.c                     |    2 +-
 sound/soc/tegra/tegra210_dmic.c                    |    2 +-
 sound/soc/tegra/tegra210_i2s.c                     |   18 +-
 sound/soc/tegra/tegra210_mixer.c                   |    2 +-
 sound/soc/tegra/tegra210_mvc.c                     |    2 +-
 sound/soc/tegra/tegra210_ope.c                     |    2 +-
 sound/soc/tegra/tegra210_sfc.c                     |    2 +-
 sound/soc/tegra/tegra30_ahub.c                     |    2 +-
 sound/soc/tegra/tegra30_i2s.c                      |    2 +-
 sound/soc/tegra/tegra_audio_graph_card.c           |    2 +-
 sound/soc/tegra/tegra_pcm.c                        |    2 +-
 sound/soc/ti/ams-delta.c                           |    2 +-
 sound/soc/ti/davinci-i2s.c                         |    2 +-
 sound/soc/ti/davinci-mcasp.c                       |    2 +-
 sound/soc/ti/omap-mcbsp.c                          |    2 +-
 sound/soc/uniphier/aio-ld11.c                      |    2 +-
 sound/soc/uniphier/aio-pxs2.c                      |    2 +-
 sound/soc/uniphier/evea.c                          |    2 +-
 sound/soc/ux500/mop500.c                           |    2 +-
 sound/soc/ux500/ux500_msp_dai.c                    |    2 +-
 sound/soc/xilinx/xlnx_formatter_pcm.c              |    2 +-
 sound/soc/xilinx/xlnx_spdif.c                      |    2 +-
 sound/soc/xtensa/xtfpga-i2s.c                      |    2 +-
 sound/sparc/amd7930.c                              |    8 +-
 sound/sparc/cs4231.c                               |   78 +-
 sound/synth/emux/emux_hwdep.c                      |    6 +-
 sound/synth/emux/emux_oss.c                        |   11 +-
 sound/synth/emux/emux_seq.c                        |   13 +-
 sound/synth/emux/emux_synth.c                      |   12 +-
 sound/synth/emux/soundfont.c                       |   67 +-
 sound/usb/caiaq/audio.c                            |   15 +-
 sound/usb/card.c                                   |    8 +
 sound/usb/clock.c                                  |   62 +-
 sound/usb/endpoint.c                               |    3 +
 sound/usb/format.c                                 |    6 +-
 sound/usb/helper.c                                 |   34 +
 sound/usb/helper.h                                 |   10 +-
 sound/usb/midi.c                                   |    6 +-
 sound/usb/midi2.c                                  |   36 +-
 sound/usb/mixer.c                                  |   37 +-
 sound/usb/mixer.h                                  |    1 +
 sound/usb/mixer_quirks.c                           |  593 +++-
 sound/usb/mixer_scarlett.c                         |    4 +-
 sound/usb/power.c                                  |    3 +-
 sound/usb/power.h                                  |    1 +
 sound/usb/quirks-table.h                           | 2455 +++++--------
 sound/usb/quirks.c                                 |   62 +-
 sound/usb/stream.c                                 |   21 +-
 sound/usb/usbaudio.h                               |   12 +
 sound/usb/usx2y/us122l.c                           |   45 +-
 sound/usb/usx2y/usX2Yhwdep.c                       |   25 +-
 sound/usb/usx2y/usb_stream.c                       |   95 +-
 sound/usb/usx2y/usb_stream.h                       |    1 +
 sound/usb/usx2y/usbusx2y.c                         |    7 +-
 sound/usb/usx2y/usbusx2yaudio.c                    |   67 +-
 sound/usb/usx2y/usx2yhwdeppcm.c                    |   54 +-
 tools/sound/dapm-graph                             |   44 +-
 tools/testing/selftests/alsa/Makefile              |    4 +-
 tools/testing/selftests/alsa/global-timer.c        |   87 +
 tools/testing/selftests/alsa/utimer-test.c         |  164 +
 648 files changed, 25012 insertions(+), 32651 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs4271.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/da7213.txt
 create mode 100644 Documentation/devicetree/bindings/sound/dlg,da7213.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-es8328.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,saif.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mxs-saif.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/pcm512x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm512x.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tlv320dac3100.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tpa6130a2.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/tpa6130a2.txt
 create mode 100644 Documentation/sound/utimers.rst
 create mode 100644 include/sound/soc_sdw_utils.h
 create mode 100644 include/sound/tas2563-tlv.h
 delete mode 100644 sound/core/memalloc_local.h
 delete mode 100644 sound/pci/hda/samsung_helper.c
 create mode 100644 sound/soc/amd/acp/acp-sdw-sof-mach.c
 create mode 100644 sound/soc/amd/acp/amd-acp63-acpi-match.c
 create mode 100644 sound/soc/amd/acp/soc_amd_sdw_common.h
 create mode 100644 sound/soc/codecs/mt6357.c
 create mode 100644 sound/soc/codecs/mt6357.h
 delete mode 100644 sound/soc/intel/boards/bxt_da7219_max98357a.c
 delete mode 100644 sound/soc/intel/boards/bxt_rt298.c
 delete mode 100644 sound/soc/intel/boards/kbl_da7219_max98357a.c
 delete mode 100644 sound/soc/intel/boards/kbl_da7219_max98927.c
 delete mode 100644 sound/soc/intel/boards/kbl_rt5660.c
 delete mode 100644 sound/soc/intel/boards/kbl_rt5663_max98927.c
 delete mode 100644 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
 delete mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.c
 delete mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.h
 delete mode 100644 sound/soc/intel/boards/skl_nau88l25_max98357a.c
 delete mode 100644 sound/soc/intel/boards/skl_nau88l25_ssm4567.c
 delete mode 100644 sound/soc/intel/boards/skl_rt286.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-ptl-match.c
 delete mode 100644 sound/soc/intel/skylake/Makefile
 delete mode 100644 sound/soc/intel/skylake/bxt-sst.c
 delete mode 100644 sound/soc/intel/skylake/cnl-sst-dsp.c
 delete mode 100644 sound/soc/intel/skylake/cnl-sst-dsp.h
 delete mode 100644 sound/soc/intel/skylake/cnl-sst.c
 delete mode 100644 sound/soc/intel/skylake/skl-debug.c
 delete mode 100644 sound/soc/intel/skylake/skl-i2s.h
 delete mode 100644 sound/soc/intel/skylake/skl-messages.c
 delete mode 100644 sound/soc/intel/skylake/skl-nhlt.c
 delete mode 100644 sound/soc/intel/skylake/skl-pcm.c
 delete mode 100644 sound/soc/intel/skylake/skl-ssp-clk.c
 delete mode 100644 sound/soc/intel/skylake/skl-ssp-clk.h
 delete mode 100644 sound/soc/intel/skylake/skl-sst-cldma.c
 delete mode 100644 sound/soc/intel/skylake/skl-sst-cldma.h
 delete mode 100644 sound/soc/intel/skylake/skl-sst-dsp.c
 delete mode 100644 sound/soc/intel/skylake/skl-sst-dsp.h
 delete mode 100644 sound/soc/intel/skylake/skl-sst-ipc.c
 delete mode 100644 sound/soc/intel/skylake/skl-sst-ipc.h
 delete mode 100644 sound/soc/intel/skylake/skl-sst-utils.c
 delete mode 100644 sound/soc/intel/skylake/skl-sst.c
 delete mode 100644 sound/soc/intel/skylake/skl-topology.c
 delete mode 100644 sound/soc/intel/skylake/skl-topology.h
 delete mode 100644 sound/soc/intel/skylake/skl.c
 delete mode 100644 sound/soc/intel/skylake/skl.h
 create mode 100644 sound/soc/mediatek/mt8365/Makefile
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-dai-dmic.c
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-mt6357.c
 create mode 100644 sound/soc/mediatek/mt8365/mt8365-reg.h
 create mode 100644 sound/soc/sdw_utils/Kconfig
 create mode 100644 sound/soc/sdw_utils/Makefile
 rename sound/soc/{intel/boards/bridge_cs35l56.c => sdw_utils/soc_sdw_bridge_cs35l56.c} (63%)
 rename sound/soc/{intel/boards/sof_sdw_cs42l42.c => sdw_utils/soc_sdw_cs42l42.c} (82%)
 rename sound/soc/{intel/boards/sof_sdw_cs42l43.c => sdw_utils/soc_sdw_cs42l43.c} (73%)
 rename sound/soc/{intel/boards/sof_sdw_cs_amp.c => sdw_utils/soc_sdw_cs_amp.c} (66%)
 rename sound/soc/{intel/boards/sof_sdw_dmic.c => sdw_utils/soc_sdw_dmic.c} (71%)
 rename sound/soc/{intel/boards/sof_sdw_maxim.c => sdw_utils/soc_sdw_maxim.c} (63%)
 rename sound/soc/{intel/boards/sof_sdw_rt5682.c => sdw_utils/soc_sdw_rt5682.c} (82%)
 rename sound/soc/{intel/boards/sof_sdw_rt700.c => sdw_utils/soc_sdw_rt700.c} (81%)
 rename sound/soc/{intel/boards/sof_sdw_rt711.c => sdw_utils/soc_sdw_rt711.c} (70%)
 rename sound/soc/{intel/boards/sof_sdw_rt712_sdca.c => sdw_utils/soc_sdw_rt712_sdca.c} (74%)
 rename sound/soc/{intel/boards/sof_sdw_rt722_sdca.c => sdw_utils/soc_sdw_rt722_sdca.c} (68%)
 rename sound/soc/{intel/boards/sof_sdw_rt_amp.c => sdw_utils/soc_sdw_rt_amp.c} (84%)
 rename sound/soc/{intel/boards/sof_sdw_amp_coeff_tables.h => sdw_utils/soc_sdw_rt_amp_coeff_tables.h} (97%)
 rename sound/soc/{intel/boards/sof_sdw_rt_dmic.c => sdw_utils/soc_sdw_rt_dmic.c} (70%)
 rename sound/soc/{intel/boards/sof_sdw_rt_sdca_jack_common.c => sdw_utils/soc_sdw_rt_sdca_jack_common.c} (78%)
 create mode 100644 sound/soc/sdw_utils/soc_sdw_utils.c
 create mode 100644 sound/soc/sof/amd/acp70.c
 create mode 100644 sound/soc/sof/amd/pci-acp70.c
 create mode 100644 sound/soc/sof/intel/pci-ptl.c
 create mode 100644 tools/testing/selftests/alsa/global-timer.c
 create mode 100644 tools/testing/selftests/alsa/utimer-test.c


