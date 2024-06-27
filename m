Return-Path: <linux-kernel+bounces-231973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E9A91A0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C081F224E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874EF7345D;
	Thu, 27 Jun 2024 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wAhdVlnF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QlolrcAo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wAhdVlnF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QlolrcAo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF5288BD;
	Thu, 27 Jun 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475119; cv=none; b=a+r4IsrzsYSgRa0AiAaUiDRzLg2O3I0yi4QOAj5FLtWrK4HpIBTZLGoFEKVhHefYzDMLYxylI8tzS6zJ+ZQWhKkLZiE/vRZ+tEHjGEekfTSL3SwESsqQo9sLrg8dW5SB1lirPhb0Bdm8ePnZ9KoKeNjG6OpXfIyd4j4jTnwclbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475119; c=relaxed/simple;
	bh=r/ggCtTzDXViToCDpmhQ8dJEM7OOeSw9FvKfcg9YnuI=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=f2ePYkQErM/mKDR2nseGj4lI1fP8kIyfNFn+kOPiQqJ6IsHZMCwDKNJkNF+weOI/RRCXUPWyzWcb26QyTY9c4KQOksVcGlUAqS0DMGQqxBI7rtSuWSmMnxAP+4wnwKh08Ab1YhNGFMNdOSCzNvGvCojX/SN+wfLOV0k8Kfo8SUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wAhdVlnF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QlolrcAo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wAhdVlnF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QlolrcAo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02B8721B77;
	Thu, 27 Jun 2024 07:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719475116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7FUs+mGtHTT7x23vuUeMYlEQ5nTfea293mfyQqUZ99c=;
	b=wAhdVlnFOAXPbgUljp7Kb03XdzqWeB9qSbfvx69i/tIph95lFT7MOA/BpSfeTTCn+/KsfD
	TQUxYCFKxKTVPeNuEFne7KaCPM23lvMml05u4bXkxM9zdxYONQy2+Vdcms7/YkWI0DxnII
	OGZz3+oK6B2lRHw9/wykoDhAEVv03LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719475116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7FUs+mGtHTT7x23vuUeMYlEQ5nTfea293mfyQqUZ99c=;
	b=QlolrcAol8D+5ZipBcepYLH2+adCujhQBmER3iFtI2wdxFJ2PBWVXk59DOoWeBgRnt+PRN
	Qrbwo2wVnQzm93Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wAhdVlnF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QlolrcAo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719475116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7FUs+mGtHTT7x23vuUeMYlEQ5nTfea293mfyQqUZ99c=;
	b=wAhdVlnFOAXPbgUljp7Kb03XdzqWeB9qSbfvx69i/tIph95lFT7MOA/BpSfeTTCn+/KsfD
	TQUxYCFKxKTVPeNuEFne7KaCPM23lvMml05u4bXkxM9zdxYONQy2+Vdcms7/YkWI0DxnII
	OGZz3+oK6B2lRHw9/wykoDhAEVv03LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719475116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7FUs+mGtHTT7x23vuUeMYlEQ5nTfea293mfyQqUZ99c=;
	b=QlolrcAol8D+5ZipBcepYLH2+adCujhQBmER3iFtI2wdxFJ2PBWVXk59DOoWeBgRnt+PRN
	Qrbwo2wVnQzm93Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6D42137DF;
	Thu, 27 Jun 2024 07:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yZ/5LasbfWa0AQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 27 Jun 2024 07:58:35 +0000
Date: Thu, 27 Jun 2024 09:59:03 +0200
Message-ID: <871q4iizp4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.10-rc6
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 02B8721B77
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 

Linus,

please pull sound fixes for v6.10-rc6 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc6

The topmost commit is 4b3e3810738376b3292d1bf29996640843fbd9a0

----------------------------------------------------------------

sound fixes for 6.10-rc6

This became bigger than usual, as it receives a pile of pending
ASoC fixes.  Most of changes are for device-specific issues while
there are a few core fixes that are all rather trivial.

- DMA-engine sync fixes
- Continued MIDI2 conversion fixes
- Various ASoC Intel SOF fixes
- A series of ASoC topology fixes for memory handling
- AMD ACP fix, curing a recent regression, too
- Platform / codec-specific fixes for mediatek, atmel, realtek, etc

----------------------------------------------------------------

Aivaz Latypov (1):
      ALSA: hda/relatek: Enable Mute LED on HP Laptop 15-gw0xxx

Alibek Omarov (1):
      ASoC: rockchip: i2s-tdm: Fix trcm mode by setting clock on right mclk

Amadeusz S³awiñski (5):
      ASoC: topology: Fix references to freed memory
      ASoC: Intel: avs: Fix route override
      ASoC: topology: Do not assign fields that are already set
      ASoC: topology: Clean up route loading
      ASoC: topology: Fix route memory corruption

Andrei Simion (1):
      ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix card init

Bard Liao (2):
      ASoC: SOF: Intel: hda-dai: skip tlv for dspless mode
      ASoC: SOF: Intel: hda-dai: remove skip_tlv label

Chen-Yu Tsai (1):
      ASoC: mediatek: mt8195: Add platform entry for ETDM1_OUT_BE dai link

Dirk Su (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook 645/665 G11.

Dmitry Baryshkov (1):
      MAINTAINERS: copy linux-arm-msm for sound/qcom changes

Elinor Montmasson (1):
      ASoC: fsl-asoc-card: set priv->pdev before using it

Hsin-Te Yuan (1):
      ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol name collision

Jack Yu (3):
      ASoC: rt722-sdca-sdw: add silence detection register as volatile
      ASoC: rt722-sdca-sdw: add debounce time for type detection
      ASoC: rt5645: fix issue of random interrupt from push-button

Jai Luthra (2):
      ALSA: dmaengine: Synchronize dma channel after drop()
      ASoC: ti: davinci-mcasp: Set min period size using FIFO config

Jeff Johnson (3):
      ASoC: mxs: add missing MODULE_DESCRIPTION() macro
      ASoC: fsl: add missing MODULE_DESCRIPTION() macro
      ASoC: qcom: add missing MODULE_DESCRIPTION() macro

Maciej Strozek (1):
      ASoC: cs42l43: Increase default type detect time and button delay

Peter Ujfalusi (1):
      ASoC: SOF: sof-audio: Skip unprepare for in-use widgets on error rollback

Primoz Fiser (1):
      ASoC: ti: omap-hdmi: Fix too long driver name

Richard Fitzgerald (1):
      ASoC: cs35l56: Disconnect ASP1 TX sources when ASP1 DAI is hooked up

Shengjiu Wang (1):
      ALSA: dmaengine_pcm: terminate dmaengine before synchronize

Shuming Fan (1):
      ASoC: Intel: soc-acpi: mtl: fix speaker no sound on Dell SKU 0C64

Srinivas Kandagatla (1):
      ASoC: q6apm-lpass-dai: close graph on prepare errors

Takashi Iwai (4):
      ALSA: seq: Fix missing channel at encoding RPN/NRPN MIDI2 messages
      ALSA: PCM: Allow resume only for suspended streams
      ALSA: hda/realtek: Fix conflicting quirk for PCI SSID 17aa:3820
      ALSA: seq: Fix missing MSB in MIDI2 SPP conversion

Thomas GENTY (1):
      bytcr_rt5640 : inverse jack detect for Archos 101 cesium

Vijendar Mukunda (3):
      ASoC: amd: acp: add a null check for chip_pdev structure
      ASoC: amd: acp: remove i2s configuration check in acp_i2s_probe()
      ASoC: amd: acp: move chip->flag variable assignment

Vyacheslav Frantsishko (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA

Zhang Yi (1):
      ASoC: codecs: ES8326: Solve headphone detection issue

---
 MAINTAINERS                                        |  1 +
 include/sound/dmaengine_pcm.h                      |  1 +
 sound/core/pcm_dmaengine.c                         | 22 +++++++++++++
 sound/core/pcm_native.c                            |  2 ++
 sound/core/seq/seq_ump_convert.c                   | 10 +++---
 sound/pci/hda/patch_realtek.c                      | 25 ++++++++++++++-
 sound/soc/amd/acp/acp-i2s.c                        |  8 -----
 sound/soc/amd/acp/acp-pci.c                        | 12 ++++---
 sound/soc/amd/yc/acp6x-mach.c                      |  7 ++++
 sound/soc/atmel/atmel-classd.c                     |  7 ++--
 sound/soc/codecs/cs35l56-shared.c                  |  4 +++
 sound/soc/codecs/cs42l43-jack.c                    |  4 +--
 sound/soc/codecs/es8326.c                          |  8 +++--
 sound/soc/codecs/rt5645.c                          | 24 ++++++++++----
 sound/soc/codecs/rt5645.h                          |  6 ++++
 sound/soc/codecs/rt722-sdca-sdw.c                  |  4 ++-
 sound/soc/fsl/fsl-asoc-card.c                      |  3 +-
 sound/soc/fsl/imx-pcm-dma.c                        |  1 +
 sound/soc/intel/avs/topology.c                     | 19 ++++++++---
 sound/soc/intel/boards/bytcr_rt5640.c              | 11 +++++++
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |  2 +-
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 10 +++---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c          |  1 +
 sound/soc/mxs/mxs-pcm.c                            |  1 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c            | 32 ++++++++++++-------
 sound/soc/qcom/sdw.c                               |  1 +
 sound/soc/rockchip/rockchip_i2s_tdm.c              | 13 ++++++--
 sound/soc/soc-generic-dmaengine-pcm.c              |  8 +++++
 sound/soc/soc-topology.c                           | 37 ++++++++++------------
 sound/soc/sof/intel/hda-dai.c                      |  6 ++--
 sound/soc/sof/sof-audio.c                          |  2 +-
 sound/soc/ti/davinci-mcasp.c                       |  9 ++++--
 sound/soc/ti/omap-hdmi.c                           |  6 +---
 33 files changed, 221 insertions(+), 86 deletions(-)


