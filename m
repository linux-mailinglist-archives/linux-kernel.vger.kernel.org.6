Return-Path: <linux-kernel+bounces-576708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA674A71359
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0153B52C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A201A5BB2;
	Wed, 26 Mar 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="byEvDqtb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jm3uNQ5T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="byEvDqtb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jm3uNQ5T"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9217A2F8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980214; cv=none; b=Z5O6x5kLJ9qKeWn4KjZT0LlCvcVssTBDZx8eFQlLd7+uN5Kir+mmWN/1tol8sQojgABDBHpWiKAN4b6M+52pV5HmdpjhCSsIhNsENF0d1mSVLFUa9qr5X4PDfuwz+GIWVrsOf8+9Kfmi5PSz4oKaboEk5671meUQIXuTo98we5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980214; c=relaxed/simple;
	bh=oIhlNs35aD8l/O9+/+M/IOII8nobvBhFZZh/f/jPJXw=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=bgi/kI5CUgYK5z0b1tyNUiD9vMnFTLoojRjJclD2sHejFNsMfJ5WoKTk9mJDlNX/xPcFM4ZicAihyLukYQ2IA0eVHfwf380hQmyC25hqEfQGwfnGlQN8P+fkSZS4few31KHgdXFuCJ2Euqa+jTmsv/cX7dnipO6cQpX3oMFHPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=byEvDqtb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jm3uNQ5T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=byEvDqtb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jm3uNQ5T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 489A91F456;
	Wed, 26 Mar 2025 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742980208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TgJfF+/p3EIAEbYE4r1cdpWcMqewyLotvpaosiEWCbY=;
	b=byEvDqtbE7GpITEzTAm6NPICnTP2Oxy3zxvmdY9mUivIp+yLZljTjAP30InAamr8eXLA10
	gexbpyNTUlngNUsTPVdQCPuVA0R14eoR9f0Lt618my95zioby5Q+HzUOWAmkYLAIeqd2Nw
	IicXnx8wE4HAUXjlAsUXE33mYbjxFW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742980208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TgJfF+/p3EIAEbYE4r1cdpWcMqewyLotvpaosiEWCbY=;
	b=Jm3uNQ5TP89XnfMNldU8w0aBmDg1hye6qF+0hwMSvuxEnjSu1yAO7yC9nqZJwhODCASaCn
	G5lyKQut/+UTsuBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=byEvDqtb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jm3uNQ5T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742980208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TgJfF+/p3EIAEbYE4r1cdpWcMqewyLotvpaosiEWCbY=;
	b=byEvDqtbE7GpITEzTAm6NPICnTP2Oxy3zxvmdY9mUivIp+yLZljTjAP30InAamr8eXLA10
	gexbpyNTUlngNUsTPVdQCPuVA0R14eoR9f0Lt618my95zioby5Q+HzUOWAmkYLAIeqd2Nw
	IicXnx8wE4HAUXjlAsUXE33mYbjxFW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742980208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TgJfF+/p3EIAEbYE4r1cdpWcMqewyLotvpaosiEWCbY=;
	b=Jm3uNQ5TP89XnfMNldU8w0aBmDg1hye6qF+0hwMSvuxEnjSu1yAO7yC9nqZJwhODCASaCn
	G5lyKQut/+UTsuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F214113927;
	Wed, 26 Mar 2025 09:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TjPnOW/E42e9XgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Mar 2025 09:10:07 +0000
Date: Wed, 26 Mar 2025 10:10:07 +0100
Message-ID: <87zfh89mz4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates for 6.15-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 489A91F456
X-Spam-Score: -3.51
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

please pull sound updates for v6.15-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.15-rc1

The topmost commit is 3a949fc08103c0ce3a1d0ef30459c7b3acc6a214

----------------------------------------------------------------

sound updates for 6.15-rc1

We've received lots of commits at this time, as a result of various
cleanup and refactoring works as well as a few new drivers and the
generic SoundWire support.  Most of changes are device-specific,
little about the core changes.  Some highlights below:

Core:
* A couple of (rather minor) race fixes in ALSA sequencer code
* A regression fix in ALSA timer code that may lead to a deadlock

ASoC:
* A large series of code conversion to use modern terminology for the
  clocking configuration
* Conversions of PM ops with the modern macros in all ASoC drivers
* Clarification of the control operations
* Prepartory work for more generic SoundWire SCDA controls
* Support for AMD ACP 7.x, AWINC WM88166, Everest ES8388, Intel AVS
  PEAKVOL and GAIN DSP modules Mediatek MT8188 DMIC, NXP i.MX95,
  nVidia Tegra interconnects, Rockchip RK3588 S/PDIF, Texas
  Instruments SN012776 and TAS5770L, and Wolfson WM8904 DMICs

Others:
* Conversions of PM ops with the modern macros in the rest drivers
* USB-audio quirks and fixes for Presonus Studio, DJM-A9, CME
* HD-audio quirks and fixes ASUS, HP, Lenovo, and others

Note that the PR contains some changes from the tip tree for AMD code,
and it might give some merge conflict due to the rebase afterwards.

----------------------------------------------------------------

Alexey Charkov (1):
      dt-bindings: ASoC: rockchip: Add compatible for RK3588 SPDIF

Alexey Klimov (2):
      ASoC: codecs: wsa883x: Implement temperature reading and hwmon
      ASoC: qcom: sm8250: explicitly set format in sm8250_be_hw_params_fixup()

Amadeusz S³awiñski (3):
      ASoC: Intel: avs: Configure basefw on TGL-based platforms
      ASoC: Intel: avs: Add volume control for GAIN module
      ASoC: Intel: avs: Add support for mute for PEAKVOL and GAIN

Amin Dandache (1):
      ALSA: usb-audio: enable support for Presonus Studio 1824c within 1810c file

Andrei Simion (1):
      ASoC: dt-bindings: atmel,at91-ssc: Convert to YAML format

Andres Traumann (1):
      ALSA: hda/realtek: Bass speaker fixup for ASUS UM5606KA

Andres Urian Florez (1):
      ALSA: echoaudio: remove unused variable

Andy Shevchenko (2):
      ASoC: tas2781: Switch to use %ptTsr
      ASoC: SOF: ipc4-topology: Allocate ref_params on stack

AngeloGioacchino Del Regno (1):
      ASoC: SOF: mediatek: Commonize duplicated functions

Arnd Bergmann (2):
      ASoC: mediatek: mt8188: avoid uninitialized variable use
      ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS

Balakrishnan Sambath (1):
      ASoC: dt-bindings: atmel-at91sam9g20ek: convert to json-schema

Baojun Xu (1):
      ASoC: tas2781: Clean up for some define

Bard Liao (8):
      ASoC: rt722: get lane mapping property
      ASoC: Intel: adl: add 2xrt1316 audio configuration
      ASoC: sdw_utils: add mic and amp dais to 0xaaaa codec
      ASoC: Intel: add multi-function SDW mockup codec match
      ASoC: Intel: soc-acpi-intel-lnl-match: add sdw multi function mockup codec
      ASoC: Intel: soc-acpi-intel-ptl-match: add sdw multi function mockup codec
      ASoC: Intel: soc-acpi-intel-lnl-match: add cs42l43 6x cs35l56 support
      ASoC: Intel: soc-acpi-intel-ptl-match: add cs42l43 6x cs35l56 support

Cezary Rojewski (40):
      ASoC: codecs: pcm3168a: Add ACPI match table
      ASoC: codecs: pcm3168a: Relax probing conditions
      ASoC: codecs: pcm3168a: Allow for 24-bit in provider mode
      ASoC: Intel: avs: Add pcm3168a machine board
      ASoC: Intel: avs: pcm3168a board selection
      ASoC: Intel: avs: Move DSP-boot steps into individual functions
      ASoC: Intel: avs: New gateway configuration mechanism
      ASoC: Intel: avs: Remove unused gateway configuration code
      ASoC: Intel: avs: Add WHM module support
      ALSA: hda: Select avs-driver by default on MBL
      ASoC: topology: Create kcontrols based on their type
      ASoC: topology: Save num_channels value for mixer controls
      ASoC: Intel: avs: Make PEAKVOL configurable from topology
      ASoC: Intel: avs: Update VOLUME and add MUTE IPCs
      ASoC: Intel: avs: New volume control operations
      ASoC: Intel: avs: Move to the new control operations
      ASoC: Intel: avs: Honor the invert flag for mixer controls
      ASoC: Intel: avs: Support multi-channel PEAKVOL instantiation
      ASoC: codecs: rt1011: Fix definition of device_id tables
      ASoC: codecs: rt1015: Fix definition of device_id tables
      ASoC: codecs: rt1016: Fix definition of device_id tables
      ASoC: codecs: rt1019: Fix definition of device_id tables
      ASoC: codecs: rt1305: Fix definition of device_id tables
      ASoC: codecs: rt1308: Fix definition of device_id tables
      ASoC: codecs: rt1318: Fix definition of device_id tables
      ASoC: codecs: rt274: Fix definition of device_id tables
      ASoC: codecs: rt5514: Fix definition of device_id tables
      ASoC: codecs: rt5640: Fix definition of device_id tables
      ASoC: codecs: rt5645: Fix definition of device_id tables
      ASoC: codecs: rt5651: Fix definition of device_id tables
      ASoC: codecs: rt5659: Fix definition of device_id tables
      ASoC: codecs: rt5660: Fix definition of device_id tables
      ASoC: codecs: rt5663: Fix definition of device_id tables
      ASoC: codecs: rt5665: Fix definition of device_id tables
      ASoC: codecs: rt5668: Fix definition of device_id tables
      ASoC: codecs: rt5670: Fix definition of device_id tables
      ASoC: codecs: rt5682: Fix definition of device_id tables
      ASoC: codecs: rt286: Update definition of device_id tables
      ASoC: codecs: rt298: Update definition of device_id tables
      ASoC: codecs: rt5677: Update definition of device_id tables

Charles Han (3):
      ALSA: emu10k1: fix inconsistent indenting warning in snd_emu10k1_synth_free()
      ALSA: opti9xx: fix inconsistent indenting warning in snd_opti9xx_configure()
      ALSA: seq: seq_oss_event: fix inconsistent indenting warning in note_on_event()

Charles Keepax (50):
      ASoC: rt722-sdca: Add some missing readable registers
      ASoC: rt722-sdca: Make use of new expanded MBQ regmap
      ASoC: SDCA: Minor formatting and naming tweaks
      ASoC: SDCA: Add support for Entity 0
      ASoC: SDCA: Add SDCA Control parsing
      ASoC: SDCA: Add parsing for Control range structures
      ASoC: SDCA: Add Channel Cluster parsing
      ASoC: SDCA: Add support for IT/OT Entity properties
      ASoC: SDCA: Add support for clock Entity properties
      ASoC: SDCA: Add support for PDE Entity properties
      regcache: Add support for sorting defaults arrays
      ASoC: SDCA: Add generic regmap SDCA helpers
      ASoC: SDCA: Add regmap helpers for parsing for DisCo Constant values
      ASoC: SDCA: Add helper to write out defaults and fixed values
      ASoC: Remove unused helper macro
      ASoC: rt715: Remove duplicate SOC_DOUBLE_R_EXT() helper macro
      ASoC: sma1307: Use SOC_SINGLE_EXT() helper macro
      ASoC: tas2562: Use SOC_SINGLE_EXT_TLV() helper macro
      ASoC: wcd938x: Use SOC_SINGLE_EXT_TLV() helper macro
      ASoC: wm9712: Use SOC_SINGLE_EXT() helper macro
      ASoC: wm9713: Use SOC_DOUBLE_EXT() helper macro
      ASoC: wsa881x: Use SOC_SINGLE_EXT_TLV() helper macro
      ASoC: atmel: tse850-pcm5142: Use SOC_SINGLE_EXT() helper macro
      ASoC: dapm: Add missing SOC_DAPM_DOUBLE_R_TLV() helper
      ASoC: dapm: Use ASoC control macros where possible
      ASoC: Tidy up SOC_DOUBLE_R_* helpers
      ASoC: Tidy up SOC_DOUBLE_* and SOC_SINGLE_* helpers
      ASoC: dapm: Fix changes to DECLARE_ADAU17X1_DSP_MUX_CTRL
      ASoC: SDCA: Tidy up initialization write parsing
      ASoC: SDCA: Use __free() to manage local buffers
      ASoC: SDCA: Allow naming of imp def controls
      ASoC: SDCA: Add type flag for Controls
      ASoC: SDCA: Add SDCA Control Range data access helper
      ASoC: SDCA: Add support for GE Entity properties
      ASoC: ops-test: Add some basic kunit tests for soc-ops
      ASoC: ops: Minor formatting fixups
      ASoC: ops: Update comments for xr_sx control helpers
      ASoC: ops: Update mask generation to use GENMASK
      ASoC: ops: Factor out helper to check valid control values
      ASoC: ops: Replace snd_soc_read_signed() with new helper
      ASoC: ops: Add control to register value helper
      ASoC: ops: Remove snd_soc_info_volsw_range()
      ASoC: ops: Remove snd_soc_get_volsw_range()
      ASoC: ops: Remove snd_soc_put_volsw_range()
      ASoC: ops: Factor out common code from info callbacks
      ASoC: ops: Factor out common code from put callbacks
      ASoC: ops: Factor out common code from get callbacks
      ASoC: ops: Remove some unnecessary local variables
      ASoC: ops: Apply platform_max after deciding control type
      ASoC: SDCA: Correct handling of selected mode DisCo property

Chen Ni (7):
      ASoC: ti: davinci-i2s: remove unnecessary NULL check before clk_disable_unprepare()
      ASoC: mt8365: remove unnecessary NULL check before clk_disable_unprepare()
      ASoC: tlv320adc3xxx: remove unnecessary NULL check before clk_disable_unprepare()
      ASoC: cs35l56: Remove redundant 'flush_workqueue()' calls
      ASoC: codecs: ntp8918: Remove duplicate clk.h header
      ALSA: hda: cs35l56: Remove unnecessary NULL check before release_firmware()
      ALSA: hda: tas2781-i2c: Remove unnecessary NULL check before release_firmware()

Chenyuan Yang (1):
      ASoC: sma1307: Add NULL check in sma1307_setting_loaded()

Chris Chiu (2):
      ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3315
      ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3247

Chris Morgan (1):
      ASoC: dt-bindings: sun4i-a10-codec: add hp-det-gpios

Colin Ian King (1):
      ALSA: es18xx: Fix spelling mistake "grap" -> "grab"

Dan Carpenter (3):
      ASoC: SOF: imx: Fix an IS_ERR() vs NULL bug in imx_parse_ioremap_memory()
      ASoC: SOF: imx: Fix error code in probe()
      ASoC: amd: acp: Fix leak in acp_pci_probe()

David Lechner (1):
      ASoC: adau1701: use gpiod_multi_set_value_cansleep

Dhruv Deshpande (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx

Dmitry Baryshkov (2):
      ALSA: hda/hdmi: extract common interface for ELD handling
      ASoC: hdmi-codec: dump ELD through procfs

Dr. David Alan Gilbert (4):
      ASoC: mediatek: Remove unused mtk_memif_set_rate
      ASoC: mediatek: mt6358: Remove unused functions
      ALSA: lola: Remove unused lola_(save|restore)_mixer
      ASoC: mediatek: mt8186: Remove unused mt8186_afe_(suspend|resume)_clock

Dzmitry Sankouski (2):
      ASoC: dt-bindings: Add bindings for WCD934x DAIs
      ASoC: codecs: wcd934x: use wcd934x binding header

Ernest Van Hoecke (5):
      of: Add of_property_read_u16_index
      ASoC: wm8904: Don't touch GPIO configs set to 0xFFFF
      ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC and EQ support
      ASoC: wm8904: get platform data from DT
      ASoC: wm8904: add DMIC support

Ethan Carter Edwards (6):
      ASoC: q6dsp: q6apm: replace kzalloc() with kcalloc() in q6apm_map_memory_regions()
      ALSA: ctxfi: change dao_set_input functions from kzalloc to kcalloc
      ASoC: Intel: avs: Replace devm_kzalloc() with devm_kcalloc()
      ASoC: Intel: avs: ssm4567: Replace devm_kzalloc() with devm_kcalloc()
      ASoC: Intel: avs: max98373: Replace devm_kzalloc() with devm_kcalloc()
      ASoC: Intel: avs: max98927: Replace devm_kzalloc() with devm_kcalloc()

Frank Li (1):
      ASoC: dt-bindings: fsl,sai: Add i.MX94 support

Geert Uytterhoeven (1):
      ASoC: soc-core: Stop using of_property_read_bool() for non-boolean properties

Haoxiang Li (1):
      ASoC: codecs: wcd937x: fix a potential memory leak in wcd937x_soc_codec_probe()

Hector Martin (4):
      ASoC: tas2764: Power up/down amp on mute ops
      ASoC: tas2764: Wait for ramp-down after shutdown
      ASoC: tas2764: Mark SW_RESET as volatile
      ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG

Ivaylo Dimitrov (3):
      ASoC: cpcap: Implement .set_bias_level
      dt-bindings: mfd: motorola-cpcap: Document audio-codec interrupts
      ASoC: cpcap: Implement jack detection

Jakub Wilk (2):
      ALSA: docs: Fix typo
      ALSA: docs: Fix module paths in /sys

James Calligeros (2):
      ASoC: dt-bindings: tas27xx: add compatible for SN012776
      ASoC: dt-bindings: tas2770: add compatible for TAS5770L

Jayesh Choudhary (2):
      ASoC: ti: j721e-evm: Reduce log level for EPROBE_DEFER
      ASoC: ti: j721e-evm: Fix clock configuration for ti,j7200-cpb-audio compatible

Jiri Slaby (SUSE) (1):
      irqdomain: sound: Switch to irq_domain_create_linear()

Johan Hovold (1):
      ASoC: codecs: wcd93xx-sdw: fix of_property_read_bool() warnings

Krzysztof Kozlowski (3):
      ALSA: arm: aaci: Constify amba_id table
      ASoC: dt-bindings: everest,es8328: Mark ES8388 compatible with ES8328
      ASoC: dt-bindings: everest,es8328: Require reg property

Kuninori Morimoto (188):
      ASoC: soc-ops: remove soc-dpcm.h
      ASoC: add common snd_soc_ret() and use it
      ASoC: soc-utils: care -EOPNOTSUPP on snd_soc_ret()
      ASoC: soc-pcm: use snd_soc_ret()
      ASoC: simple-card: use snd_soc_ret()
      ASoC: simple-card-utils: use snd_soc_ret()
      ASoC: audio-graph-card: use snd_soc_ret()
      ASoC: audio-graph-card2: use snd_soc_ret()
      ASoC: soc-pcm: no need to check dpcm->fe on dpcm_be_connect()
      ASoC: soc-core: makes snd_soc_set_dmi_name() local
      ASoC: soc-ops: makes snd_soc_read_signed() void
      ASoC: soc-pcm: makes dpcm_dapm_stream_event() void
      ASoC: soc-dai: check return value at snd_soc_dai_set_tdm_slot()
      ASoC: soc-pcm: remove duplicate param from __soc_pcm_hw_params()
      ASoC: remove update from snd_soc_card
      ASoC: remove dpcm_process_paths()
      ASoC: soc-pcm: cleanup dpcm_dai_trigger_fe_be()
      ASoC: soc-pcm: cleanup dpcm_fe_dai_do_trigger()
      ASoC: Documentation: DPCM: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: kirkwood: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: ti: rx51: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: sh: migor: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: Documentation: Codec to Codec: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: ti: n810: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: ti: osk5912: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: ti: ams-delta: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: ti: j721e-evm: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: ti: davinci-evm: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: ti: omap-twl4030: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: ti: omap3pandora: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: amd: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: fsl: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mxs: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: pxa: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: qcom: sc7180: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: qcom: sc7280: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs4234: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs4265: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs4270: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs4271: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs4341: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs530x: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs35l32: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs35l33: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs35l34: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs42l42: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs42l51: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs42l52: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs42l56: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs42l73: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs42xx8: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs43130: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: cs53l30: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: da7210: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: da7218: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: da7219: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: da732x: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: da9055: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: nau8540: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: nau8810: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: nau8822: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: nau8824: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: nau8825: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rk817: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt274: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt286: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt298: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt1011: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt1015: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt1016: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt1305: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt1308: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5616: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5631: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5640: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5645: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5651: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5659: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5660: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5663: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5665: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5668: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5670: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5677: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5682: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: rt5682s: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm2200: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm5100: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8350: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8400: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8510: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8523: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8524: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8580: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8711: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8728: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8737: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8741: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8750: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8753: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8770: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8776: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8804: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8900: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8903: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8904: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8940: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8955: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8960: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8961: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8962: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8971: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8974: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8978: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8983: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8985: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8988: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8990: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8991: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8993: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8994: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8995: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm8996: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm9081: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: wm9713: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: madera: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: arizona: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: twl4030: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: src4xxx: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: sgtl5000: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: codec: lochnagar-sc: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: ux500: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: meson: t9015: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: meson: meson-card-utils: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: tegra: tegra_asoc_machine: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: tegra: tegra_wm8903: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: intel: rt274: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: intel: rt286: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: intel: rt298: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: intel: rt5514: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: intel: da7219: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: intel: ssm4567: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: intel: nau8825: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: intel: max98927: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: intel: max98357a: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: snow: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: bells: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: odroid: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: arndale: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: lowland: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: speyside: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: tobermory: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: tm2_wm5110: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: littlemill: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: smdk_wm8994: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: aries_wm8994: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: midas_wm1811: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: samsung: smdk_wm8994pcm: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt2701-wm8960: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt2701-cs42448: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt7986-wm8960: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt7986-dai-etdm: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8173-rt5650: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8173-max98090: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8173-rt5650-rt5676: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8173-rt5650-rt5514: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8183-da7219-max98357: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8183-mt6358-ts3a227-max98357: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8186-mt6366: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8192-mt6359-rt1015-rt5682: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8195-mt6359: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8365-mt6357: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8365-dai-i2s: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: mediatek: mt8365-dai-pcm: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: rockchip: rk3288_hdmi_analog: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: rockchip: rk3399_gru_sound: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: rockchip: rockchip_max98090: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: rockchip: rockchip_rt5645: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
      ASoC: soc-dai: remove SND_SOC_DAIFMT_CB{MS}_CF{MS}
      ASoC: audio-graph-card2-custom-sample1.dtsi: Separate Sample DT
      ASoC: audio-graph-card2-custom-sample2.dtsi: Separate Sample DT
      ASoC: audio-graph-card2-custom-sample.dtsi: remove original sample
      ASoC: doc: use SND_SOC_DAILINK_xxx() macro
      ASoC: soc-pcm: merge soc_pcm_hw_update_format/subformat()
      ASoC: soc-pcm: reuse dpcm_state_string()
      ASoC: soc-dai: add snd_soc_dai_mute_is_ctrled_at_trigger()
      ASoC: simple-card-utils: Don't use __free(device_node) at graph_util_parse_dai()
      ASoC: soc-pcm: tidyup function name to snd_soc_dpcm_be_can_xxx()

Laurentiu Mihalcea (11):
      ASoC: SOF: imx: introduce more common structures and functions
      ASoC: SOF: imx8: use common imx chip interface
      ASoC: SOF: imx8: use IMX_SOF_* macros
      ASoC: SOF: imx8: drop unneeded/unused macros/header includes
      ASoC: SOF: imx: merge imx8 and imx8m drivers
      ASoC: SOF: imx: merge imx8 and imx8ulp drivers
      ASoC: SOF: imx: add driver for the imx95 chip
      ASoC: SOF: imx-common: set sdev->pdata->hw_pdata after common is alloc'd
      ASoC: dt-bindings: wlf,wm8960: add 'port' property
      ASoC: dt-bindings: support imx95's CM7 core
      ASoC: dt-bindings: audio-graph-card2: add widgets and hp-det-gpios support

Linus Walleij (10):
      ASoC: samsung: bells: Drop unused include
      ASoC: samsung: littlemill: Drop unused include
      ASoC: samsung: lowland: Drop unused include
      ASoC: samsung: speyside: Convert to GPIO descriptor
      ASoC: samsung: tobermory: Drop unused include
      ASoC: samsung: tm2_wm5110: Drop unused include
      ASoC: samsung: speyside: Free gpiod table
      ASoC: pcm1681: Drop unused include
      ASoC: pcm3008: Convert to GPIO descriptors
      ASoC: pcm6240: Drop bogus code handling IRQ as GPIO

Louis-Alexis Eyraud (1):
      ASoC: mediatek: mt6359: Fix DT parse error due to wrong child node name

Maciej S. Szmigiero (1):
      ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7

Mario Limonciello (12):
      x86/amd_node: Add SMN offsets to exclusive region access
      x86/amd_node: Add support for debugfs access to SMN registers
      x86/amd_node: Add a smn_read_register() helper
      ASoC: amd: acp: rembrandt: Use AMD_NODE
      ASoC: amd: acp: acp70: Use AMD_NODE
      ASoC: amd: acp: acp63: Use AMD_NODE
      ASoC: SOF: amd: Use AMD_NODE
      ASoC: amd: acp: Drop local symbols for smn read/write
      ASoC: SOF: amd: Drop host bridge ID from struct
      ASoC: SOF: amd: Add depends on CPU_SUP_AMD
      ASoC: SOF: amd: Move depends on AMD_NODE to consumers
      ASoC: dmic: Fix NULL pointer dereference

Martin Povi¹er (5):
      ASoC: ops: Enforce platform maximum on initial value
      ASoC: tas2764: Extend driver to SN012776
      ASoC: tas2764: Add control concerning overcurrent events
      ASoC: tas2770: Factor out set_ivsense_slots
      ASoC: tas2770: Fix and redo I/V sense TDM slot setting logic

Masahiro Yamada (3):
      ASoC: dapm: unexport snd_soc_dapm_init()
      ASoC: dapm: unexport snd_soc_dapm_update_dai()
      ASoC: dapm: unexport dapm_mark_endpoints_dirty()

Maxim Mikityanskiy (2):
      ALSA: hda: intel: Fix Optimus when GPU has no sound
      ALSA: hda: intel: Add Lenovo IdeaPad Z570 to probe denylist

Mohammad Rafi Shaik (4):
      ASoC: dt-bindings: wcd937x-sdw: Add static channel mapping support
      ASoC: codecs: wcd937x: Add static channel mapping support in wcd937x-sdw
      soundwire: qcom: Add set_channel_map api support
      ASoC: qcom: sdw: Add get and set channel maps support from codec to cpu dais

Naveen Manohar (1):
      ASoC: Intel: soc-acpi-intel-ptl-match: Add cs42l43 support

Nícolas F. R. A. Prado (9):
      ASoC: mediatek: mt8188: Add audsys hires clocks
      ASoC: mediatek: mt8188: Add reference for dmic clocks
      ASoC: mediatek: mt8188: Treat DMIC_GAINx_CUR as non-volatile
      ASoC: mediatek: mt8188-mt6359: Add DMIC support
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Add DMIC backend to dai-link
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Add mediatek,accdet
      ASoC: mediatek: common: Handle mediatek,accdet property
      ASoC: mediatek: mt6359: Add stub for mt6359_accdet_enable_jack_detect
      ASoC: mediatek: mt8188-mt6359: Add accdet headset jack detect support

Olivia Mackintosh (1):
      ALSA: usb-audio: separate DJM-A9 cap lvl options

Olivier Moysan (2):
      ASoC: dt-bindings: add regulator support to dmic codec
      ASoC: dmic: add regulator support

Peter Ujfalusi (18):
      ASoC: SOF: Relocate and rework functionality for PCM stream freeing
      ASoC: SOF: pcm: Move period/buffer configuration print after platform open
      ASoC: SOF: pcm: Add snd_sof_pcm specific wrappers for dev_dbg() and dev_err()
      ASoC: SOF: ipc4-topology: Improve the information in prepare_copier prints
      ASoC: SOF: ipc4-pcm: Move out be_rate initialization from for loop in fixup
      ASoC: SOF: ipc4: Add support for split firmware releases
      ASoC: Intel: soc-acpi-intel-ptl-match: add rt712_vb + rt1320 support
      ASoC: Intel: soc-acpi-intel-ptl-match: add rt713_vb_l2_rt1320_l13
      ASoC: Intel: soc-acpi-intel-ptl-match: add rt712_vb_l3_rt1320_l2 support
      ASoC: Intel: soc-acpi-intel-ptl-match: add rt713_vb_l3_rt1320_l12 support
      ASoC: SOF: Intel: mtl: Split up dsp_ops setup code
      ASoC: SOF: Intel: lnl/ptl: Only set dsp_ops which differs from MTL
      ASoC: SOF: Intel: mtl: Stop exporting dsp_ops callback functions
      ASoC: SOF: Intel: Create ptl.c as placeholder for Panther Lake features
      ASoC: SOF: ipc4: Add support for Intel HW managed mic privacy messaging
      ASoC: SOF: Intel: hda-mlink: Add support for mic privacy in VS SHIM registers
      ASoC: SOF: hda/shim: Add callbacks to handle mic privacy change for sdw
      ASoC: SOF: Intel: ptl: Add support for mic privacy

Pierre-Louis Bossart (2):
      ASoC: SDCA: Add code to parse Function information
      ASoC: SDCA: Parse initialization write table

Raag Jadav (6):
      ASoC: Intel: avs: use devm_kmemdup_array()
      ASoC: hdac_hdmi: use devm_kmemdup_array()
      ASoC: tlv320dac33: use devm_kmemdup_array()
      ASoC: uda1380: use devm_kmemdup_array()
      ASoC: meson: axg-tdm-interface: use devm_kmemdup_array()
      ASoC: uniphier: use devm_kmemdup_array()

Ricard Wanderlof (1):
      ALSA: usb-audio: Fix CME quirk for UF series keyboards

Richard Fitzgerald (1):
      firmware: cs_dsp: test_bin_error: Use same test cases for adsp2 and Halo Core

Ritu Chaudhary (1):
      ASoC: tegra: Use non-atomic timeout for ADX status register

Ryan Walklin (3):
      ASoC: sun4i-codec: correct dapm widgets and controls for h616
      ASoC: sun4i-codec: support hp-det-gpios property
      ASoC: sun4i-codec: add h616 card long_name

Sheetal (2):
      ASoC: tegra: Add interconnect support
      ASoC: tegra: Remove the isomgr_bw APIs export

Shenghao Ding (1):
      ASoC: tas2781: Support dsp firmware Alpha and Beta seaies

Shengjiu Wang (11):
      ASoC: dmic: Add DSD big endian format support
      ASoC: fsl_micfil: Add decimation filter bypass mode support
      ASoC: dt-bindings: imx-card: Add playback-only and capture-only property
      ASoC: imx-card: Add playback_only or capture_only support
      ASoC: dt-bindings: fsl,easrc: Reference common DAI properties
      ASoC: dt-bindings: fsl,imx-asrc: Reference common DAI properties
      ASoC: dt-bindings: fsl,sai: Document audio graph port
      ASoC: dt-bindings: fsl,audmix: Document audio graph port
      ASoC: dt-bindings: fsl,audmix: make 'dais' property to be optional
      ASoC: fsl_audmix: register card device depends on 'dais' property
      ASoC: dt-bindings: fsl,imx-asrc: Document audio graph port

Shuming Fan (1):
      ASoC: rt712-sdca: Add FU05 playback switch control

Stefan Binding (1):
      ALSA: hda/realtek: Add support for various HP Laptops using CS35L41 HDA

Sudeep Holla (1):
      ASoC: soc-utils: Transition to the faux device interface

Syed Saba kareem (1):
      ASoC: amd: yc: update quirk data for new Lenovo model

Takashi Iwai (104):
      ALSA: pcm: Drop superfluous NULL check in snd_pcm_format_set_silence()
      ALSA: seq: Improve data consistency at polling
      ALSA: seq: Avoid client data changes during proc reads
      ALSA: ac97: Convert to RUNTIME_PM_OPS() macro
      ALSA: atmel: Convert to DEFINE_SIMPLE_DEV_PM_OPS() macro
      ALSA: pcm: Convert to SYSTEM_SLEEP_PM_OPS()
      ALSA: hda: Use RUNTIME_PM_OPS() and pm_ptr()
      ALSA: hda-intel: Convert to RUNTIME_PM_OPS()
      ALSA: hda/tegra: Convert to RUNTIME_PM_OPS() & co
      ALSA: oxygen: Convert to EXPORT_SIMPLE_DEV_PM_OPS()
      ALSA: vx222: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      ALSA: intel-hdmi-audio: Convert to SYSTEM_SLEEP_PM_OPS()
      ALSA: hda/realtek: Always honor no_shutup_pins
      ASoC: au1x: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      ASoC: ak4375: Convert to RUNTIME_PM_OPS() & co
      ASoC: ak4458: Convert to RUNTIME_PM_OPS() & co
      ASoC: ak5558: Convert to RUNTIME_PM_OPS() & co
      ASoC: cs35l32: Convert to RUNTIME_PM_OPS()
      ASoC: cs35l33: Convert to RUNTIME_PM_OPS()
      ASoC: cs35l34: Convert to RUNTIME_PM_OPS()
      ASoC: cs4234: Convert to RUNTIME_PM_OPS()
      ASoC: cs42l42: Convert to RUNTIME_PM_OPS() & co
      ASoC: cs42l51: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: cs42l83: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: cs42xx8: Convert to EXPORT_GPL_DEV_PM_OPS()
      ASoC: cs43130: Convert to RUNTIME_PM_OPS()
      ASoC: cs4349: Convert to RUNTIME_PM_OPS()
      ASoC: cs53l30: Convert to RUNTIME_PM_OPS()
      ASoC: cx2072x: Convert to RUNTIME_PM_OPS() & co
      ASoC: da7213: Convert to RUNTIME_PM_OPS() & co
      ASoC: hdac_hdmi: Convert to RUNTIME_PM_OPS() & co
      ASoC: lpass: Convert to RUNTIME_PM_OPS()
      ASoC: max98090: Convert to RUNTIME_PM_OPS() & co
      ASoC: max98373: Convert to RUNTIME_PM_OPS() & co
      ASoC: max98390: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: max98396: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: max98520: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: max9860: Convert to RUNTIME_PM_OPS()
      ASoC: max98927: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: mt6660: Convert to RUNTIME_PM_OPS()
      ASoC: pcm512x: Convert to EXPORT_GPL_DEV_PM_OPS()
      ASoC: rt1017-sdca-sdw: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt1308-sdw: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt1316-sdw: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt1318-sdw: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt1320-sdw: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt5514: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: rt5645: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: rt5682-sdw: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt700-sdw: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt711: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt712: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt715: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt721: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt722: Convert to RUNTIME_PM_OPS() & co
      ASoC: rt9120: Convert to RUNTIME_PM_OPS()
      ASoC: rtq9128: Convert to RUNTIME_PM_OPS()
      ASoC: tas2552: Convert to RUNTIME_PM_OPS()
      ASoC: ts3a227e: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: wcd937x: Convert to RUNTIME_PM_OPS()
      ASoC: wcd938x: Convert to RUNTIME_PM_OPS()
      ASoC: wcd939x: Convert to RUNTIME_PM_OPS()
      ASoC: wm2200: Convert to RUNTIME_PM_OPS()
      ASoC: wm5100: Convert to RUNTIME_PM_OPS()
      ASoC: wm8804: Convert to EXPORT_GPL_DEV_PM_OPS()
      ASoC: wm8962: Convert to RUNTIME_PM_OPS() & co
      ASoC: wm8994: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: wsa881x: Convert to RUNTIME_PM_OPS()
      ASoC: wsa883x: Convert to RUNTIME_PM_OPS()
      ASoC: wsa884x: Convert to RUNTIME_PM_OPS()
      ASoC: dwc: Convert to RUNTIME_PM_OPS()
      ASoC: fsl: Convert to RUNTIME_PM_OPS() and co
      ASoC: img: Convert to RUNTIME_PM_OPS() and co
      ASoC: intel: avs: Convert to RUNTIME_PM_OPS()
      ASoC: intel: catpt: Convert to RUNTIME_PM_OPS() & co
      ASoC: mediatek: mt2701: Convert to RUNTIME_PM_OPS()
      ASoC: mediatek: mt6797: Convert to RUNTIME_PM_OPS()
      ASoC: mediatek: mt7986: Convert to RUNTIME_PM_OPS()
      ASoC: mediatek: mt8173: Convert to RUNTIME_PM_OPS()
      ASoC: mediatek: mt8183: Convert to RUNTIME_PM_OPS()
      ASoC: mediatek: mt8186: Convert to RUNTIME_PM_OPS()
      ASoC: mediatek: mt8188: Convert to RUNTIME_PM_OPS()
      ASoC: mediatek: mt8192: Convert to RUNTIME_PM_OPS()
      ASoC: mediatek: mt8195: Convert to RUNTIME_PM_OPS()
      ASoC: mediatek: mt8365: Convert to RUNTIME_PM_OPS() & co
      ASoC: qcom: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: rcar: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: rockchip: Convert to RUNTIME_PM_OPS() & co
      ASoC: samsung: Convert to RUNTIME_PM_OPS() & co
      ASoC: SOF: acpi: Convert to EXPORT_NS_DEV_PM_OPS()
      ASoC: SOF: pci: Convert to EXPORT_NS_DEV_PM_OPS()
      ASoC: SOF: of: Convert to EXPORT_DEV_PM_OPS()
      ASoC: stm: Convert to SYSTEM_SLEEP_PM_OPS()
      ASoC: sunxi: Convert to RUNTIME_PM_OPS()
      ASoC: tegra186: Convert to RUNTIME_PM_OPS() & co
      ASoC: tegra210: Convert to RUNTIME_PM_OPS() & co
      ASoC: tegra20: Convert to RUNTIME_PM_OPS() & co
      ASoC: tegra30: Convert to RUNTIME_PM_OPS() & co
      ASoC: xtensa: Convert to RUNTIME_PM_OPS()
      ASoC: amd: Convert to RUNTIME_PM_OPS() & co
      ASoC: pcm3168a: Convert to EXPORT_GPL_DEV_PM_OPS()
      ALSA: oxygen: Fix dependency on CONFIG_PM_SLEEP
      ALSA: timer: Don't take register_mutex with copy_from/to_user()
      ALSA: hda/realtek: Fix built-in mic assignment on ASUS VivoBook X515UA

Thomas Weißschuh (1):
      firmware: cs_dsp: test_control_parse: null-terminate test strings

Thorsten Blum (14):
      x86/mtrr: Use str_enabled_disabled() helper in print_mtrr_state()
      ASoC: amd: acp: Use str_low_high() helper function
      ASoC: SOF: mediatek: Use str_on_off() helper function
      ASoC: tscs454: Use str_enable_disable() in pll_power_event()
      ASoC: Intel: avs: Use str_on_off() in avs_dsp_core_power()
      ASoC: SOF: ipc3: Use str_enabled_disabled() helper function
      ASoC: wm_hubs: Use str_enable_disable() in wm_hubs_update_class_w()
      ASoC: SOF: Intel: Use str_enable_disable() helper
      ASoC: soc-core: Use str_yes_no() in snd_soc_close_delayed_work()
      ASoC: fsl: fsl_qmc_audio: Remove unnecessary bool conversions
      ASoC: atmel: atmel-classd: Use str_enabled_disabled() helper
      ASoC: cros_ec_codec: Use str_enable_disable() helper in wov_enable_put()
      ASoC: amd: acp: acp70: Remove unnecessary if-check
      ASoC: SOF: Intel: hda-dai: Remove unnecessary bool conversion

Uwe Kleine-König (1):
      ASoC: SOF: Intel: Don't import non-existing module namespace

Venkata Prasad Potturu (17):
      ASoC: amd: acp: Remove redundant acp70 chip->name
      ASoC: amd: acp: Implement acp_common_hw_ops support for acp platforms
      ASoC: amd: acp: Refactor dmic-codec platform device creation
      ASoC: amd: acp: Refactor acp platform device creation
      ASoC: amd: acp: Refactor acp machine select
      ASoC: amd: acp: Add new interrupt handle callbacks in acp_common_hw_ops
      ASoC: amd: acp: Remove redundant acp_dev_data structure
      ASoC: amd: acp: Move spin_lock and list initialization to acp-pci driver
      ASoC: amd: acp: Remove white line
      ASoC: amd: acp: Refactor acp70 platform resource structure
      ASoC: amd: acp: Refactor acp63 platform resource structure
      ASoC: amd: acp: Refactor rembrant platform resource structure
      ASoC: amd: acp: Refactor renoir platform resource structure
      ASoC: amd: acp: Fix for enabling DMIC on acp platforms via _DSD entry
      ASoC: amd: acp: Fix snd_soc_acpi_mach id's duplicate symbol error
      ASoC: amd: acp: Fix acp_resource duplicate symbol error
      ASoC: amd: acp: Fix acp_common_hw_ops declaration error

Vijendar Mukunda (27):
      ASoC: amd: ps: rename structure names, variable and other macros
      ASoC: amd: ps: use macro for ACP6.3 pci revision id
      ASoC: amd: ps: add acp pci driver hw_ops for acp6.3 platform
      ASoC: amd: ps: add callback functions for acp pci driver pm ops
      ASoC: amd: ps: add callback to read acp pin configuration
      ASoC: amd: ps: add soundwire dma irq thread callback
      ASoC: amd: ps: refactor soundwire dma interrupt handling
      ASoC: amd: ps: store acp revision id in SoundWire dma driver private data
      ASoC: amd: ps: refactor soundwire dma driver code
      ASoC: amd: ps: refactor soundwire dma interrupts enable/disable sequence
      ASoC: amd: ps: rename acp_restore_sdw_dma_config() function
      ASoC: amd: ps: add pci driver hw_ops for ACP7.0 & ACP7.1 variants
      ASoC: amd: ps: add pm ops related hw_ops for ACP7.0 & ACP7.1 platforms
      ASoC: amd: ps: add ACP7.0 & ACP7.1 specific soundwire dma driver changes
      ASoC: amd: ps: implement function to restore dma config for ACP7.0 platform
      ASoC: amd: ps: add soundwire dma interrupts handling for ACP7.0 platform
      ASoC: amd: ps: add soundwire wake interrupt handling
      ASoC: amd: ps: update module description
      ASoC: amd: ps: update file description and copyright year
      ASoC: amd: update Pink Sardine platform Kconfig description
      ASoC: amd: acp: add machine driver changes for ACP7.0 and ACP7.1 platforms
      ASoC: amd: acp: add RT711, RT714 & RT1316 support for ACP7.0 platform
      ASoC: amd: acp: amd-acp70-acpi-match: Add rt722 support
      ASoC: amd: acp: amd-acp70-acpi-match: Add RT1320 & RT722 combination soundwire machine
      ASoC: amd: amd_sdw: Add quirks for Dell SKU's
      ASoC: amd: ps: use switch statements for acp pci revision id check
      ASoC: amd: ps: fix inconsistent indenting warning in check_and_handle_sdw_dma_irq()

Vincenzo Frascino (4):
      ASoC: dt-bindings: xlnx,i2s: Convert to json-schema
      ASoC: dt-bindings: xlnx,audio-formatter: Convert to json-schema
      ASoC: dt-bindings: xlnx,spdif: Convert to json-schema
      MAINTAINERS: Add Vincenzo Frascino as Xilinx Sound Driver Maintainer

Vitaliy Shevtsov (1):
      ASoC: cs35l41: check the return value from spi_setup()

Vitaly Kuznetsov (1):
      x86/entry: Add __init to ia32_emulation_override_cmdline()

Weidong Wang (2):
      ASoC: dt-bindings: Add schema for "awinic,aw88166"
      ASoC: codecs: Add aw88166 amplifier driver

Yazen Ghannam (1):
      x86/amd_node, platform/x86/amd/hsmp: Have HSMP use SMN through AMD_NODE

Zhang Heng (1):
      ASoC: SOF: topology: Use krealloc_array() to replace krealloc()

keenplify (1):
      ASoC: amd: Add DMI quirk for ACP6X mic support

parkeryang (1):
      ASoC: mediatek: mt8188: Add support for DMIC

---
 .../devicetree/bindings/mfd/motorola-cpcap.txt     |    6 +
 .../devicetree/bindings/misc/atmel-ssc.txt         |   50 -
 .../bindings/sound/allwinner,sun4i-a10-codec.yaml  |    6 +
 .../devicetree/bindings/sound/atmel,at91-ssc.yaml  |  104 ++
 .../bindings/sound/atmel,at91sam9g20ek-wm8731.yaml |   72 +
 .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     |   26 -
 .../bindings/sound/audio-graph-card2.yaml          |    4 +
 .../devicetree/bindings/sound/awinic,aw88395.yaml  |    1 +
 .../devicetree/bindings/sound/dmic-codec.yaml      |    3 +
 .../devicetree/bindings/sound/everest,es8328.yaml  |   11 +-
 .../devicetree/bindings/sound/fsl,audmix.yaml      |   61 +-
 .../devicetree/bindings/sound/fsl,easrc.yaml       |    5 +-
 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |   15 +-
 .../bindings/sound/fsl,imx95-cm7-sof.yaml          |   64 +
 .../devicetree/bindings/sound/fsl,sai.yaml         |   55 +
 .../devicetree/bindings/sound/fsl,sof-cpu.yaml     |   27 +
 .../devicetree/bindings/sound/imx-audio-card.yaml  |   14 +
 .../bindings/sound/mediatek,mt8188-mt6359.yaml     |    9 +
 .../bindings/sound/qcom,wcd937x-sdw.yaml           |   36 +
 .../devicetree/bindings/sound/rockchip-spdif.yaml  |    4 +
 .../devicetree/bindings/sound/ti,tas2770.yaml      |    1 +
 .../devicetree/bindings/sound/ti,tas27xx.yaml      |    1 +
 .../devicetree/bindings/sound/wlf,wm8904.yaml      |  129 ++
 .../devicetree/bindings/sound/wlf,wm8960.yaml      |    4 +
 .../bindings/sound/xlnx,audio-formatter.txt        |   29 -
 .../bindings/sound/xlnx,audio-formatter.yaml       |   72 +
 .../devicetree/bindings/sound/xlnx,i2s.txt         |   28 -
 .../devicetree/bindings/sound/xlnx,i2s.yaml        |   65 +
 .../devicetree/bindings/sound/xlnx,spdif.txt       |   28 -
 .../devicetree/bindings/sound/xlnx,spdif.yaml      |   77 +
 Documentation/sound/alsa-configuration.rst         |    2 +-
 Documentation/sound/designs/powersave.rst          |    6 +-
 Documentation/sound/soc/codec-to-codec.rst         |    4 +-
 Documentation/sound/soc/dpcm.rst                   |   21 +-
 MAINTAINERS                                        |   11 +-
 drivers/base/regmap/regcache.c                     |   31 +
 .../firmware/cirrus/test/cs_dsp_test_bin_error.c   |   13 +-
 .../cirrus/test/cs_dsp_test_control_parse.c        |   51 +-
 drivers/of/property.c                              |   33 +
 drivers/soundwire/qcom.c                           |   26 +
 include/dt-bindings/sound/qcom,wcd934x.h           |   16 +
 include/linux/of.h                                 |    9 +
 include/linux/regmap.h                             |    7 +
 include/sound/hda-mlink.h                          |   25 +
 include/sound/hda_codec.h                          |    1 +
 include/sound/pcm_drm_eld.h                        |   91 +
 include/sound/sdca.h                               |   22 +-
 include/sound/sdca_function.h                      | 1179 +++++++++++-
 include/sound/sdca_regmap.h                        |   31 +
 include/sound/simple_card_utils.h                  |    8 +-
 include/sound/soc-dai.h                            |    8 +-
 include/sound/soc-dapm.h                           |   65 +-
 include/sound/soc-dpcm.h                           |    8 +-
 include/sound/soc.h                                |  133 +-
 include/sound/sof/ipc4/header.h                    |   13 +
 include/sound/tas2781-dsp.h                        |   30 +-
 include/sound/tas2781.h                            |   33 +-
 include/sound/wm8904.h                             |    3 +
 include/uapi/sound/intel/avs/tokens.h              |   11 +
 sound/ac97/bus.c                                   |    9 +-
 sound/arm/aaci.c                                   |    2 +-
 sound/atmel/ac97c.c                                |    9 +-
 sound/core/pcm.c                                   |    4 +-
 sound/core/pcm_drm_eld.c                           |  387 ++++
 sound/core/pcm_misc.c                              |    4 +-
 sound/core/seq/oss/seq_oss_event.c                 |    8 +-
 sound/core/seq/seq_clientmgr.c                     |    7 +-
 sound/core/seq/seq_memory.c                        |    1 +
 sound/core/timer.c                                 |  147 +-
 sound/hda/intel-dsp-config.c                       |    4 +
 sound/isa/es18xx.c                                 |    8 +-
 sound/isa/opti9xx/opti92x-ad1848.c                 |    2 +-
 sound/pci/ctxfi/ctdaio.c                           |    4 +-
 sound/pci/echoaudio/echoaudio.c                    |    6 +-
 sound/pci/emu10k1/memory.c                         |    2 +-
 sound/pci/hda/Kconfig                              |    1 +
 sound/pci/hda/cs35l56_hda.c                        |    6 +-
 sound/pci/hda/hda_beep.c                           |   15 +-
 sound/pci/hda/hda_bind.c                           |    2 +-
 sound/pci/hda/hda_codec.c                          |    3 +-
 sound/pci/hda/hda_eld.c                            |  383 +---
 sound/pci/hda/hda_intel.c                          |   56 +-
 sound/pci/hda/hda_local.h                          |   49 +-
 sound/pci/hda/hda_tegra.c                          |   16 +-
 sound/pci/hda/patch_hdmi.c                         |    6 +-
 sound/pci/hda/patch_realtek.c                      |   79 +-
 sound/pci/hda/tas2781-spi.h                        |    1 -
 sound/pci/hda/tas2781_hda_i2c.c                    |   13 +-
 sound/pci/hda/tas2781_hda_spi.c                    |    5 +-
 sound/pci/hda/tas2781_spi_fwlib.c                  |    8 +-
 sound/pci/lola/lola.h                              |    2 -
 sound/pci/lola/lola_mixer.c                        |   43 -
 sound/pci/oxygen/oxygen.c                          |    4 +-
 sound/pci/oxygen/oxygen.h                          |    2 -
 sound/pci/oxygen/oxygen_lib.c                      |    5 +-
 sound/pci/oxygen/se6x.c                            |    4 +-
 sound/pci/oxygen/virtuoso.c                        |    4 +-
 sound/pci/vx222/vx222.c                            |    9 +-
 sound/soc/Kconfig                                  |    7 +
 sound/soc/Makefile                                 |    4 +
 sound/soc/amd/Kconfig                              |   10 +-
 sound/soc/amd/acp/Kconfig                          |   12 +
 sound/soc/amd/acp/Makefile                         |    4 +-
 sound/soc/amd/acp/acp-i2s.c                        |  183 +-
 sound/soc/amd/acp/acp-legacy-common.c              |  308 +++-
 sound/soc/amd/acp/acp-mach-common.c                |    2 +-
 sound/soc/amd/acp/acp-pci.c                        |  218 ++-
 sound/soc/amd/acp/acp-pdm.c                        |   53 +-
 sound/soc/amd/acp/acp-platform.c                   |  145 +-
 sound/soc/amd/acp/acp-rembrandt.c                  |  145 +-
 sound/soc/amd/acp/acp-renoir.c                     |  116 +-
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            |   45 +
 sound/soc/amd/acp/acp-sdw-mach-common.c            |   34 +
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c      |    5 +-
 sound/soc/amd/acp/acp63.c                          |  155 +-
 sound/soc/amd/acp/acp70.c                          |  132 +-
 sound/soc/amd/acp/amd-acp70-acpi-match.c           |  160 ++
 sound/soc/amd/acp/amd-acpi-mach.c                  |   93 +
 sound/soc/amd/acp/amd.h                            |  166 +-
 sound/soc/amd/acp/chip_offset_byte.h               |   12 +-
 sound/soc/amd/acp/soc_amd_sdw_common.h             |   12 +
 sound/soc/amd/mach-config.h                        |    1 +
 sound/soc/amd/ps/Makefile                          |    2 +-
 sound/soc/amd/ps/acp63.h                           |  246 ++-
 sound/soc/amd/ps/pci-ps.c                          |  450 +++--
 sound/soc/amd/ps/ps-common.c                       |  475 +++++
 sound/soc/amd/ps/ps-pdm-dma.c                      |   18 +-
 sound/soc/amd/ps/ps-sdw-dma.c                      |  381 +++-
 sound/soc/amd/rpl/rpl-pci-acp6x.c                  |   10 +-
 sound/soc/amd/vangogh/acp5x-pcm-dma.c              |   11 +-
 sound/soc/amd/yc/acp6x-mach.c                      |   14 +
 sound/soc/amd/yc/acp6x-pdm-dma.c                   |   12 +-
 sound/soc/amd/yc/pci-acp6x.c                       |   10 +-
 sound/soc/atmel/atmel-classd.c                     |    3 +-
 sound/soc/atmel/tse850-pcm5142.c                   |   11 +-
 sound/soc/au1x/i2sc.c                              |   17 +-
 sound/soc/au1x/psc-ac97.c                          |   17 +-
 sound/soc/au1x/psc-i2s.c                           |   17 +-
 sound/soc/codecs/Kconfig                           |   13 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/adau1701.c                        |    4 +-
 sound/soc/codecs/adau17x1.c                        |    2 +-
 sound/soc/codecs/ak4375.c                          |   11 +-
 sound/soc/codecs/ak4458.c                          |   13 +-
 sound/soc/codecs/ak5558.c                          |   11 +-
 sound/soc/codecs/arizona.c                         |   12 +-
 sound/soc/codecs/aw88166.c                         | 1933 ++++++++++++++++++++
 sound/soc/codecs/aw88166.h                         |  534 ++++++
 sound/soc/codecs/cpcap.c                           |  200 +-
 sound/soc/codecs/cros_ec_codec.c                   |    3 +-
 sound/soc/codecs/cs35l32.c                         |   11 +-
 sound/soc/codecs/cs35l33.c                         |   14 +-
 sound/soc/codecs/cs35l34.c                         |   14 +-
 sound/soc/codecs/cs35l41-spi.c                     |    5 +-
 sound/soc/codecs/cs35l56.c                         |    1 -
 sound/soc/codecs/cs4234.c                          |   12 +-
 sound/soc/codecs/cs4265.c                          |    4 +-
 sound/soc/codecs/cs4270.c                          |    4 +-
 sound/soc/codecs/cs4271.c                          |    4 +-
 sound/soc/codecs/cs42l42-i2c.c                     |    6 +-
 sound/soc/codecs/cs42l42-sdw.c                     |   16 +-
 sound/soc/codecs/cs42l42.c                         |    4 +-
 sound/soc/codecs/cs42l51-i2c.c                     |    2 +-
 sound/soc/codecs/cs42l51.c                         |    8 +-
 sound/soc/codecs/cs42l52.c                         |    4 +-
 sound/soc/codecs/cs42l56.c                         |    4 +-
 sound/soc/codecs/cs42l73.c                         |    4 +-
 sound/soc/codecs/cs42l83-i2c.c                     |    6 +-
 sound/soc/codecs/cs42xx8-i2c.c                     |    2 +-
 sound/soc/codecs/cs42xx8.c                         |   14 +-
 sound/soc/codecs/cs43130.c                         |   33 +-
 sound/soc/codecs/cs4341.c                          |    2 +-
 sound/soc/codecs/cs4349.c                          |    7 +-
 sound/soc/codecs/cs530x.c                          |    4 +-
 sound/soc/codecs/cs53l30.c                         |   11 +-
 sound/soc/codecs/cx2072x.c                         |   12 +-
 sound/soc/codecs/da7210.c                          |    4 +-
 sound/soc/codecs/da7213.c                          |   10 +-
 sound/soc/codecs/da7218.c                          |    4 +-
 sound/soc/codecs/da7219.c                          |    4 +-
 sound/soc/codecs/da732x.c                          |    4 +-
 sound/soc/codecs/da9055.c                          |    4 +-
 sound/soc/codecs/dmic.c                            |   27 +-
 sound/soc/codecs/hdac_hdmi.c                       |   18 +-
 sound/soc/codecs/hdmi-codec.c                      |   68 +
 sound/soc/codecs/jz4760.c                          |   32 +-
 sound/soc/codecs/jz4770.c                          |   40 +-
 sound/soc/codecs/lochnagar-sc.c                    |    4 +-
 sound/soc/codecs/lpass-rx-macro.c                  |    8 +-
 sound/soc/codecs/lpass-tx-macro.c                  |    8 +-
 sound/soc/codecs/lpass-va-macro.c                  |    8 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |    8 +-
 sound/soc/codecs/madera.c                          |   12 +-
 sound/soc/codecs/max98090.c                        |   11 +-
 sound/soc/codecs/max98373-i2c.c                    |    6 +-
 sound/soc/codecs/max98373-sdw.c                    |   10 +-
 sound/soc/codecs/max98390.c                        |    6 +-
 sound/soc/codecs/max98396.c                        |    6 +-
 sound/soc/codecs/max98520.c                        |    8 +-
 sound/soc/codecs/max9860.c                         |    6 +-
 sound/soc/codecs/max98927.c                        |    6 +-
 sound/soc/codecs/mt6358.c                          |  104 --
 sound/soc/codecs/mt6358.h                          |    4 -
 sound/soc/codecs/mt6359-accdet.h                   |    9 +
 sound/soc/codecs/mt6359.c                          |    9 +-
 sound/soc/codecs/mt6660.c                          |    9 +-
 sound/soc/codecs/nau8540.c                         |    4 +-
 sound/soc/codecs/nau8810.c                         |    4 +-
 sound/soc/codecs/nau8822.c                         |    4 +-
 sound/soc/codecs/nau8824.c                         |    4 +-
 sound/soc/codecs/nau8825.c                         |    4 +-
 sound/soc/codecs/ntp8918.c                         |    1 -
 sound/soc/codecs/pcm1681.c                         |    1 -
 sound/soc/codecs/pcm3008.c                         |   61 +-
 sound/soc/codecs/pcm3008.h                         |   19 -
 sound/soc/codecs/pcm3168a-i2c.c                    |   11 +-
 sound/soc/codecs/pcm3168a-spi.c                    |    2 +-
 sound/soc/codecs/pcm3168a.c                        |   18 +-
 sound/soc/codecs/pcm512x-i2c.c                     |    2 +-
 sound/soc/codecs/pcm512x-spi.c                     |    2 +-
 sound/soc/codecs/pcm512x.c                         |    7 +-
 sound/soc/codecs/pcm6240.c                         |   28 +-
 sound/soc/codecs/pcm6240.h                         |    7 +-
 sound/soc/codecs/rk817_codec.c                     |    4 +-
 sound/soc/codecs/rt1011.c                          |    8 +-
 sound/soc/codecs/rt1015.c                          |   10 +-
 sound/soc/codecs/rt1016.c                          |   10 +-
 sound/soc/codecs/rt1017-sdca-sdw.c                 |   10 +-
 sound/soc/codecs/rt1019.c                          |    6 +-
 sound/soc/codecs/rt1305.c                          |   12 +-
 sound/soc/codecs/rt1308-sdw.c                      |   10 +-
 sound/soc/codecs/rt1308.c                          |    8 +-
 sound/soc/codecs/rt1316-sdw.c                      |   10 +-
 sound/soc/codecs/rt1318-sdw.c                      |   10 +-
 sound/soc/codecs/rt1318.c                          |    6 +-
 sound/soc/codecs/rt1320-sdw.c                      |   10 +-
 sound/soc/codecs/rt274.c                           |   12 +-
 sound/soc/codecs/rt286.c                           |    9 +-
 sound/soc/codecs/rt298.c                           |    9 +-
 sound/soc/codecs/rt5514-spi.c                      |    8 +-
 sound/soc/codecs/rt5514.c                          |   12 +-
 sound/soc/codecs/rt5616.c                          |    4 +-
 sound/soc/codecs/rt5631.c                          |    4 +-
 sound/soc/codecs/rt5640.c                          |   18 +-
 sound/soc/codecs/rt5645.c                          |   24 +-
 sound/soc/codecs/rt5651.c                          |   12 +-
 sound/soc/codecs/rt5659.c                          |   12 +-
 sound/soc/codecs/rt5660.c                          |   12 +-
 sound/soc/codecs/rt5663.c                          |   10 +-
 sound/soc/codecs/rt5665.c                          |   12 +-
 sound/soc/codecs/rt5668.c                          |   10 +-
 sound/soc/codecs/rt5670.c                          |   12 +-
 sound/soc/codecs/rt5677-spi.c                      |    3 +-
 sound/soc/codecs/rt5677.c                          |    5 +-
 sound/soc/codecs/rt5682-i2c.c                      |    6 +-
 sound/soc/codecs/rt5682-sdw.c                      |   12 +-
 sound/soc/codecs/rt5682.c                          |    4 +-
 sound/soc/codecs/rt5682s.c                         |    4 +-
 sound/soc/codecs/rt700-sdw.c                       |   12 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |   12 +-
 sound/soc/codecs/rt711-sdw.c                       |   12 +-
 sound/soc/codecs/rt712-sdca-dmic.c                 |   12 +-
 sound/soc/codecs/rt712-sdca-sdw.c                  |   12 +-
 sound/soc/codecs/rt712-sdca.c                      |   80 +-
 sound/soc/codecs/rt712-sdca.h                      |    3 +
 sound/soc/codecs/rt715-sdca-sdw.c                  |   10 +-
 sound/soc/codecs/rt715-sdca.c                      |    8 -
 sound/soc/codecs/rt715-sdw.c                       |   10 +-
 sound/soc/codecs/rt715.c                           |    8 -
 sound/soc/codecs/rt721-sdca-sdw.c                  |   12 +-
 sound/soc/codecs/rt722-sdca-sdw.c                  |  142 +-
 sound/soc/codecs/rt722-sdca-sdw.h                  |   99 +-
 sound/soc/codecs/rt722-sdca.c                      |  135 +-
 sound/soc/codecs/rt722-sdca.h                      |    4 +-
 sound/soc/codecs/rt9120.c                          |    8 +-
 sound/soc/codecs/rtq9128.c                         |    8 +-
 sound/soc/codecs/sgtl5000.c                        |    4 +-
 sound/soc/codecs/sma1307.c                         |   39 +-
 sound/soc/codecs/src4xxx.c                         |    4 +-
 sound/soc/codecs/tas2552.c                         |    9 +-
 sound/soc/codecs/tas2562.c                         |   14 +-
 sound/soc/codecs/tas2764.c                         |  113 +-
 sound/soc/codecs/tas2764.h                         |    7 +
 sound/soc/codecs/tas2770.c                         |   57 +-
 sound/soc/codecs/tas2781-fmwlib.c                  |  197 +-
 sound/soc/codecs/tas2781-i2c.c                     |  215 ++-
 sound/soc/codecs/tlv320adc3xxx.c                   |    3 +-
 sound/soc/codecs/tlv320dac33.c                     |    6 +-
 sound/soc/codecs/ts3a227e.c                        |    6 +-
 sound/soc/codecs/tscs454.c                         |    5 +-
 sound/soc/codecs/twl4030.c                         |    2 +-
 sound/soc/codecs/uda1380.c                         |    6 +-
 sound/soc/codecs/wcd934x.c                         |   16 +-
 sound/soc/codecs/wcd937x-sdw.c                     |   49 +-
 sound/soc/codecs/wcd937x.c                         |   57 +-
 sound/soc/codecs/wcd937x.h                         |    7 +-
 sound/soc/codecs/wcd938x-sdw.c                     |   10 +-
 sound/soc/codecs/wcd938x.c                         |   11 +-
 sound/soc/codecs/wcd939x-sdw.c                     |   10 +-
 sound/soc/codecs/wcd939x.c                         |    2 +-
 sound/soc/codecs/wm2200.c                          |   15 +-
 sound/soc/codecs/wm5100.c                          |   15 +-
 sound/soc/codecs/wm5110.c                          |    4 +-
 sound/soc/codecs/wm8350.c                          |    4 +-
 sound/soc/codecs/wm8400.c                          |    4 +-
 sound/soc/codecs/wm8510.c                          |    4 +-
 sound/soc/codecs/wm8523.c                          |    4 +-
 sound/soc/codecs/wm8524.c                          |    2 +-
 sound/soc/codecs/wm8580.c                          |    4 +-
 sound/soc/codecs/wm8711.c                          |    4 +-
 sound/soc/codecs/wm8728.c                          |    2 +-
 sound/soc/codecs/wm8737.c                          |    4 +-
 sound/soc/codecs/wm8741.c                          |    2 +-
 sound/soc/codecs/wm8750.c                          |    4 +-
 sound/soc/codecs/wm8753.c                          |   12 +-
 sound/soc/codecs/wm8770.c                          |    4 +-
 sound/soc/codecs/wm8776.c                          |    4 +-
 sound/soc/codecs/wm8804-i2c.c                      |    2 +-
 sound/soc/codecs/wm8804-spi.c                      |    2 +-
 sound/soc/codecs/wm8804.c                          |   11 +-
 sound/soc/codecs/wm8900.c                          |    8 +-
 sound/soc/codecs/wm8903.c                          |    8 +-
 sound/soc/codecs/wm8904.c                          |  325 +++-
 sound/soc/codecs/wm8940.c                          |    4 +-
 sound/soc/codecs/wm8955.c                          |    4 +-
 sound/soc/codecs/wm8960.c                          |    4 +-
 sound/soc/codecs/wm8961.c                          |    4 +-
 sound/soc/codecs/wm8962.c                          |   12 +-
 sound/soc/codecs/wm8971.c                          |    4 +-
 sound/soc/codecs/wm8974.c                          |    4 +-
 sound/soc/codecs/wm8978.c                          |    4 +-
 sound/soc/codecs/wm8983.c                          |    4 +-
 sound/soc/codecs/wm8985.c                          |    4 +-
 sound/soc/codecs/wm8988.c                          |    4 +-
 sound/soc/codecs/wm8990.c                          |    4 +-
 sound/soc/codecs/wm8991.c                          |    4 +-
 sound/soc/codecs/wm8993.c                          |    8 +-
 sound/soc/codecs/wm8994.c                          |   10 +-
 sound/soc/codecs/wm8995.c                          |    4 +-
 sound/soc/codecs/wm8996.c                          |    8 +-
 sound/soc/codecs/wm9081.c                          |    8 +-
 sound/soc/codecs/wm9712.c                          |   10 +-
 sound/soc/codecs/wm9713.c                          |   18 +-
 sound/soc/codecs/wm_hubs.c                         |    3 +-
 sound/soc/codecs/wsa881x.c                         |   17 +-
 sound/soc/codecs/wsa883x.c                         |  202 +-
 sound/soc/codecs/wsa884x.c                         |    8 +-
 sound/soc/dwc/dwc-i2s.c                            |    6 +-
 sound/soc/fsl/fsl-asoc-card.c                      |    4 +-
 sound/soc/fsl/fsl_aud2htx.c                        |    3 +-
 sound/soc/fsl/fsl_audmix.c                         |   16 +-
 sound/soc/fsl/fsl_esai.c                           |    9 +-
 sound/soc/fsl/fsl_micfil.c                         |   58 +-
 sound/soc/fsl/fsl_micfil.h                         |    1 +
 sound/soc/fsl/fsl_qmc_audio.c                      |    4 +-
 sound/soc/fsl/fsl_sai.c                            |    8 +-
 sound/soc/fsl/fsl_xcvr.c                           |    3 +-
 sound/soc/fsl/imx-card.c                           |    5 +
 sound/soc/generic/audio-graph-card.c               |   97 +-
 .../generic/audio-graph-card2-custom-sample.dtsi   |  702 -------
 .../generic/audio-graph-card2-custom-sample1.dtsi  |  396 ++++
 .../generic/audio-graph-card2-custom-sample2.dtsi  |  382 ++++
 sound/soc/generic/audio-graph-card2.c              |   95 +-
 sound/soc/generic/simple-card-utils.c              |  177 +-
 sound/soc/generic/simple-card.c                    |  132 +-
 sound/soc/img/img-i2s-in.c                         |    9 +-
 sound/soc/img/img-i2s-out.c                        |    9 +-
 sound/soc/img/img-parallel-out.c                   |    5 +-
 sound/soc/img/img-spdif-in.c                       |    9 +-
 sound/soc/img/img-spdif-out.c                      |   10 +-
 sound/soc/img/pistachio-internal-dac.c             |    8 +-
 sound/soc/intel/avs/avs.h                          |    1 +
 sound/soc/intel/avs/board_selection.c              |   17 +-
 sound/soc/intel/avs/boards/Kconfig                 |   10 +
 sound/soc/intel/avs/boards/Makefile                |    2 +
 sound/soc/intel/avs/boards/da7219.c                |    5 +-
 sound/soc/intel/avs/boards/es8336.c                |    3 +-
 sound/soc/intel/avs/boards/max98357a.c             |    2 +-
 sound/soc/intel/avs/boards/max98373.c              |    2 +-
 sound/soc/intel/avs/boards/max98927.c              |    4 +-
 sound/soc/intel/avs/boards/nau8825.c               |    5 +-
 sound/soc/intel/avs/boards/pcm3168a.c              |  143 ++
 sound/soc/intel/avs/boards/rt274.c                 |    5 +-
 sound/soc/intel/avs/boards/rt286.c                 |    5 +-
 sound/soc/intel/avs/boards/rt298.c                 |    7 +-
 sound/soc/intel/avs/boards/rt5514.c                |    2 +-
 sound/soc/intel/avs/boards/rt5663.c                |    3 +-
 sound/soc/intel/avs/boards/rt5682.c                |    3 +-
 sound/soc/intel/avs/boards/ssm4567.c               |    4 +-
 sound/soc/intel/avs/control.c                      |  186 +-
 sound/soc/intel/avs/control.h                      |   12 +-
 sound/soc/intel/avs/core.c                         |   24 +-
 sound/soc/intel/avs/dsp.c                          |    3 +-
 sound/soc/intel/avs/loader.c                       |   74 +-
 sound/soc/intel/avs/messages.c                     |  149 +-
 sound/soc/intel/avs/messages.h                     |   46 +-
 sound/soc/intel/avs/path.c                         |  387 ++--
 sound/soc/intel/avs/path.h                         |    5 +
 sound/soc/intel/avs/pcm.c                          |    2 +-
 sound/soc/intel/avs/tgl.c                          |   33 +
 sound/soc/intel/avs/topology.c                     |   89 +-
 sound/soc/intel/avs/topology.h                     |   16 +-
 sound/soc/intel/catpt/device.c                     |   14 +-
 sound/soc/intel/common/soc-acpi-intel-adl-match.c  |   29 +
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |  137 ++
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |  284 +++
 .../intel/common/soc-acpi-intel-sdw-mockup-match.c |   42 +
 .../intel/common/soc-acpi-intel-sdw-mockup-match.h |    1 +
 sound/soc/kirkwood/armada-370-db.c                 |    6 +-
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |   20 -
 sound/soc/mediatek/common/mtk-afe-fe-dai.h         |    2 -
 sound/soc/mediatek/common/mtk-soc-card.h           |    1 +
 sound/soc/mediatek/common/mtk-soundcard-driver.c   |   19 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |    6 +-
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |    8 +-
 sound/soc/mediatek/mt2701/mt2701-wm8960.c          |    2 +-
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         |    6 +-
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c         |    6 +-
 sound/soc/mediatek/mt7986/mt7986-dai-etdm.c        |    4 +-
 sound/soc/mediatek/mt7986/mt7986-wm8960.c          |    2 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |    6 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |    2 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |    2 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |    4 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |    2 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         |    6 +-
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c |    2 +-
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c        |    4 +-
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c         |   55 -
 sound/soc/mediatek/mt8186/mt8186-afe-clk.h         |    2 -
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c         |    6 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366.c          |    2 +-
 sound/soc/mediatek/mt8188/Makefile                 |    1 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c         |    8 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h         |    8 +
 sound/soc/mediatek/mt8188/mt8188-afe-common.h      |    1 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c         |   34 +-
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c      |    4 +
 sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h    |    4 +
 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c        |  683 +++++++
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |   57 +
 sound/soc/mediatek/mt8188/mt8188-reg.h             |   17 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c         |    6 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |    2 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c         |    6 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c          |   12 +-
 sound/soc/mediatek/mt8365/mt8365-afe-clk.c         |    3 +-
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c         |   19 +-
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c         |   12 +-
 sound/soc/mediatek/mt8365/mt8365-dai-pcm.c         |    4 +-
 sound/soc/mediatek/mt8365/mt8365-mt6357.c          |    2 +-
 sound/soc/meson/axg-tdm-interface.c                |    9 +-
 sound/soc/meson/meson-card-utils.c                 |    4 +-
 sound/soc/meson/t9015.c                            |    4 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |    2 +-
 sound/soc/pxa/spitz.c                              |    2 +-
 sound/soc/qcom/lpass-sc7180.c                      |    8 +-
 sound/soc/qcom/lpass-sc7280.c                      |    8 +-
 sound/soc/qcom/qdsp6/q6apm.c                       |    2 +-
 sound/soc/qcom/sc7180.c                            |    2 +-
 sound/soc/qcom/sc7280.c                            |    4 +-
 sound/soc/qcom/sdw.c                               |   34 +-
 sound/soc/qcom/sm8250.c                            |    3 +
 sound/soc/renesas/migor.c                          |    2 +-
 sound/soc/renesas/rcar/core.c                      |    8 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c            |    2 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |   10 +-
 sound/soc/rockchip/rockchip_i2s.c                  |    5 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c              |   16 +-
 sound/soc/rockchip/rockchip_max98090.c             |    8 +-
 sound/soc/rockchip/rockchip_pdm.c                  |   10 +-
 sound/soc/rockchip/rockchip_rt5645.c               |    2 +-
 sound/soc/rockchip/rockchip_spdif.c                |    9 +-
 sound/soc/samsung/aries_wm8994.c                   |    6 +-
 sound/soc/samsung/arndale.c                        |    4 +-
 sound/soc/samsung/bells.c                          |   21 +-
 sound/soc/samsung/i2s.c                            |   10 +-
 sound/soc/samsung/littlemill.c                     |    5 +-
 sound/soc/samsung/lowland.c                        |    7 +-
 sound/soc/samsung/midas_wm1811.c                   |    2 +-
 sound/soc/samsung/odroid.c                         |    2 +-
 sound/soc/samsung/smdk_wm8994.c                    |    4 +-
 sound/soc/samsung/smdk_wm8994pcm.c                 |    2 +-
 sound/soc/samsung/snow.c                           |    2 +-
 sound/soc/samsung/speyside.c                       |   53 +-
 sound/soc/samsung/tm2_wm5110.c                     |    9 +-
 sound/soc/samsung/tobermory.c                      |    3 +-
 sound/soc/sdca/Makefile                            |    2 +-
 sound/soc/sdca/sdca_device.c                       |    3 +-
 sound/soc/sdca/sdca_functions.c                    | 1697 ++++++++++++++++-
 sound/soc/sdca/sdca_regmap.c                       |  321 ++++
 sound/soc/sdw_utils/soc_sdw_utils.c                |   14 +-
 sound/soc/soc-card.c                               |   14 +-
 sound/soc/soc-component.c                          |   36 +-
 sound/soc/soc-compress.c                           |    2 +-
 sound/soc/soc-core.c                               |   50 +-
 sound/soc/soc-dai.c                                |   38 +-
 sound/soc/soc-dapm.c                               |   51 +-
 sound/soc/soc-link.c                               |   18 +-
 sound/soc/soc-ops-test.c                           |  541 ++++++
 sound/soc/soc-ops.c                                |  743 +++-----
 sound/soc/soc-pcm.c                                |  281 ++-
 sound/soc/soc-topology.c                           |   63 +-
 sound/soc/soc-utils.c                              |   61 +-
 sound/soc/sof/amd/Kconfig                          |    5 +
 sound/soc/sof/amd/acp.c                            |   56 +-
 sound/soc/sof/amd/acp.h                            |    2 -
 sound/soc/sof/amd/pci-acp63.c                      |    3 +-
 sound/soc/sof/amd/pci-acp70.c                      |    3 +-
 sound/soc/sof/amd/pci-rmb.c                        |    1 -
 sound/soc/sof/amd/pci-rn.c                         |    3 +-
 sound/soc/sof/amd/pci-vangogh.c                    |    3 +-
 sound/soc/sof/imx/Kconfig                          |   17 +-
 sound/soc/sof/imx/Makefile                         |    6 +-
 sound/soc/sof/imx/imx-common.c                     |  430 ++++-
 sound/soc/sof/imx/imx-common.h                     |  151 ++
 sound/soc/sof/imx/imx8.c                           |  805 +++-----
 sound/soc/sof/imx/imx8m.c                          |  567 ------
 sound/soc/sof/imx/imx8ulp.c                        |  520 ------
 sound/soc/sof/imx/imx9.c                           |  137 ++
 sound/soc/sof/intel/Makefile                       |    2 +-
 sound/soc/sof/intel/bdw.c                          |    3 +-
 sound/soc/sof/intel/byt.c                          |    3 +-
 sound/soc/sof/intel/hda-dai.c                      |    2 +-
 sound/soc/sof/intel/hda-mlink.c                    |  127 ++
 sound/soc/sof/intel/hda.c                          |   34 +
 sound/soc/sof/intel/hda.h                          |    4 -
 sound/soc/sof/intel/lnl.c                          |  117 +-
 sound/soc/sof/intel/lnl.h                          |    6 +
 sound/soc/sof/intel/mtl.c                          |   81 +-
 sound/soc/sof/intel/mtl.h                          |   15 +-
 sound/soc/sof/intel/pci-apl.c                      |    2 +-
 sound/soc/sof/intel/pci-cnl.c                      |    2 +-
 sound/soc/sof/intel/pci-icl.c                      |    2 +-
 sound/soc/sof/intel/pci-lnl.c                      |   14 +-
 sound/soc/sof/intel/pci-mtl.c                      |   10 +-
 sound/soc/sof/intel/pci-ptl.c                      |   19 +-
 sound/soc/sof/intel/pci-skl.c                      |    2 +-
 sound/soc/sof/intel/pci-tgl.c                      |    2 +-
 sound/soc/sof/intel/pci-tng.c                      |    3 +-
 sound/soc/sof/intel/ptl.c                          |  106 ++
 sound/soc/sof/intel/ptl.h                          |   19 +
 sound/soc/sof/intel/shim.h                         |    2 +
 sound/soc/sof/ipc3-pcm.c                           |   13 +-
 sound/soc/sof/ipc3-topology.c                      |   20 +-
 sound/soc/sof/ipc3.c                               |   12 +-
 sound/soc/sof/ipc4-loader.c                        |  176 +-
 sound/soc/sof/ipc4-pcm.c                           |   21 +-
 sound/soc/sof/ipc4-priv.h                          |    6 +
 sound/soc/sof/ipc4-topology.c                      |   65 +-
 sound/soc/sof/ipc4.c                               |   26 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c             |  107 +-
 sound/soc/sof/mediatek/mt8195/mt8195-clk.c         |    3 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c             |  107 +-
 sound/soc/sof/mediatek/mtk-adsp-common.c           |  130 ++
 sound/soc/sof/mediatek/mtk-adsp-common.h           |   10 +
 sound/soc/sof/pcm.c                                |  169 +-
 sound/soc/sof/sof-acpi-dev.c                       |    9 +-
 sound/soc/sof/sof-audio.c                          |   49 -
 sound/soc/sof/sof-audio.h                          |   17 +-
 sound/soc/sof/sof-of-dev.c                         |    8 +-
 sound/soc/sof/sof-pci-dev.c                        |    9 +-
 sound/soc/sof/topology.c                           |    4 +-
 sound/soc/stm/stm32_i2s.c                          |    6 +-
 sound/soc/stm/stm32_sai.c                          |    6 +-
 sound/soc/stm/stm32_sai_sub.c                      |    6 +-
 sound/soc/stm/stm32_spdifrx.c                      |    6 +-
 sound/soc/sunxi/sun4i-codec.c                      |   57 +-
 sound/soc/sunxi/sun4i-spdif.c                      |    6 +-
 sound/soc/sunxi/sun50i-dmic.c                      |    6 +-
 sound/soc/sunxi/sun8i-codec.c                      |    6 +-
 sound/soc/tegra/Makefile                           |    2 +-
 sound/soc/tegra/tegra186_asrc.c                    |   13 +-
 sound/soc/tegra/tegra186_dspk.c                    |   13 +-
 sound/soc/tegra/tegra20_i2s.c                      |   13 +-
 sound/soc/tegra/tegra20_spdif.c                    |   13 +-
 sound/soc/tegra/tegra210_admaif.c                  |   37 +-
 sound/soc/tegra/tegra210_admaif.h                  |    9 +-
 sound/soc/tegra/tegra210_adx.c                     |   19 +-
 sound/soc/tegra/tegra210_ahub.c                    |   13 +-
 sound/soc/tegra/tegra210_amx.c                     |   13 +-
 sound/soc/tegra/tegra210_dmic.c                    |   13 +-
 sound/soc/tegra/tegra210_i2s.c                     |   13 +-
 sound/soc/tegra/tegra210_mixer.c                   |   13 +-
 sound/soc/tegra/tegra210_mvc.c                     |   13 +-
 sound/soc/tegra/tegra210_ope.c                     |   13 +-
 sound/soc/tegra/tegra210_sfc.c                     |   13 +-
 sound/soc/tegra/tegra30_ahub.c                     |   13 +-
 sound/soc/tegra/tegra30_i2s.c                      |   13 +-
 sound/soc/tegra/tegra_asoc_machine.c               |   18 +-
 sound/soc/tegra/tegra_isomgr_bw.c                  |  129 ++
 sound/soc/tegra/tegra_isomgr_bw.h                  |   31 +
 sound/soc/tegra/tegra_wm8903.c                     |    2 +-
 sound/soc/ti/ams-delta.c                           |    2 +-
 sound/soc/ti/davinci-evm.c                         |    2 +-
 sound/soc/ti/davinci-i2s.c                         |    6 +-
 sound/soc/ti/j721e-evm.c                           |    9 +-
 sound/soc/ti/n810.c                                |    2 +-
 sound/soc/ti/omap-twl4030.c                        |    6 +-
 sound/soc/ti/omap3pandora.c                        |    4 +-
 sound/soc/ti/osk5912.c                             |    2 +-
 sound/soc/ti/rx51.c                                |    2 +-
 sound/soc/uniphier/aio-cpu.c                       |    8 +-
 sound/soc/ux500/mop500_ab8500.c                    |    4 +-
 sound/soc/xtensa/xtfpga-i2s.c                      |    6 +-
 sound/usb/format.c                                 |    4 +
 sound/usb/midi.c                                   |   80 +-
 sound/usb/mixer_quirks.c                           |   10 +-
 sound/usb/quirks.c                                 |    4 +-
 sound/x86/intel_hdmi_audio.c                       |    8 +-
 610 files changed, 19605 insertions(+), 8594 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/atmel-ssc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,at91-ssc.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
 create mode 100644 include/dt-bindings/sound/qcom,wcd934x.h
 create mode 100644 include/sound/sdca_regmap.h
 create mode 100644 sound/soc/amd/acp/amd-acp70-acpi-match.c
 create mode 100644 sound/soc/amd/acp/amd-acpi-mach.c
 create mode 100644 sound/soc/amd/ps/ps-common.c
 create mode 100644 sound/soc/codecs/aw88166.c
 create mode 100644 sound/soc/codecs/aw88166.h
 delete mode 100644 sound/soc/codecs/pcm3008.h
 delete mode 100644 sound/soc/generic/audio-graph-card2-custom-sample.dtsi
 create mode 100644 sound/soc/generic/audio-graph-card2-custom-sample1.dtsi
 create mode 100644 sound/soc/generic/audio-graph-card2-custom-sample2.dtsi
 create mode 100644 sound/soc/intel/avs/boards/pcm3168a.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
 create mode 100644 sound/soc/sdca/sdca_regmap.c
 create mode 100644 sound/soc/soc-ops-test.c
 delete mode 100644 sound/soc/sof/imx/imx8m.c
 delete mode 100644 sound/soc/sof/imx/imx8ulp.c
 create mode 100644 sound/soc/sof/imx/imx9.c
 create mode 100644 sound/soc/sof/intel/ptl.c
 create mode 100644 sound/soc/sof/intel/ptl.h
 create mode 100644 sound/soc/tegra/tegra_isomgr_bw.c
 create mode 100644 sound/soc/tegra/tegra_isomgr_bw.h


