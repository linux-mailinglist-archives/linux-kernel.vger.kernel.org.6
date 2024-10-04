Return-Path: <linux-kernel+bounces-350080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A952D98FF7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297081F2311C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014831459E0;
	Fri,  4 Oct 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1dqG5NQZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A6FZuMMJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1dqG5NQZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A6FZuMMJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D12139D0B;
	Fri,  4 Oct 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033703; cv=none; b=XN7RoeVZe6d9FTOgbo5fYn9hEPZCrFKO/miNvoQko3rrjQEtgELOl0B2Bz9uS1KwT3LR7fnCrg/A4izoXdBz0RdMq+24V3AxXJdU8pi5edwMNKzwZxwKpIhWFKNMRkshNokw/w2iDbNrtLRu5KPPnPpOoM+aSN28mHShEiN+ZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033703; c=relaxed/simple;
	bh=jV1V3+gphJ25WTc+zI9DWTg4rwRV6ZRn/+ZRazf6awo=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=eZkLvkJ67iUW6tjPqx6lqe0KNmGYhIs2AvUeMogRbHuUA5Bgdyu6s8Lne2+c4Br/d/vVW57I0/Xh3gE8ivqQXSqMjPSM4bFYAUCr5ockeGrre97MISlQanf25jbCocY1iD2eypCI9Tx5JzF1sMsJXthVESX6zt0edIqEX8LLePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1dqG5NQZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A6FZuMMJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1dqG5NQZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A6FZuMMJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82EB221E79;
	Fri,  4 Oct 2024 09:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728033693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZbRMeOo7+gG7DCshmhHBjxN68K93DcuLR/0DlJkK0L0=;
	b=1dqG5NQZcZKxIuU1Gre9FMnlWzW7hdxBJTZ5D0SbeQpTjP8EcNXt+PZIUlfjZrFnXMHKec
	EOOIE7tpzN3d0NRUmkXBx5BrMxs2Hq6i4AZLyJtDYKwQzyFAvYjIakzpTh3LhTmna7E91P
	KS4sRBC29U/USpaSMulR5IN71jlUneU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728033693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZbRMeOo7+gG7DCshmhHBjxN68K93DcuLR/0DlJkK0L0=;
	b=A6FZuMMJ6NI9uJ1GlNbKN6NmyryveoF66hra0Pe7+5Pdg/kcTblG7u3bCsBI6zcgeVbWG3
	hqSJRMeSqSbY0WCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1dqG5NQZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A6FZuMMJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728033693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZbRMeOo7+gG7DCshmhHBjxN68K93DcuLR/0DlJkK0L0=;
	b=1dqG5NQZcZKxIuU1Gre9FMnlWzW7hdxBJTZ5D0SbeQpTjP8EcNXt+PZIUlfjZrFnXMHKec
	EOOIE7tpzN3d0NRUmkXBx5BrMxs2Hq6i4AZLyJtDYKwQzyFAvYjIakzpTh3LhTmna7E91P
	KS4sRBC29U/USpaSMulR5IN71jlUneU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728033693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZbRMeOo7+gG7DCshmhHBjxN68K93DcuLR/0DlJkK0L0=;
	b=A6FZuMMJ6NI9uJ1GlNbKN6NmyryveoF66hra0Pe7+5Pdg/kcTblG7u3bCsBI6zcgeVbWG3
	hqSJRMeSqSbY0WCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 597B713A55;
	Fri,  4 Oct 2024 09:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mYChFJ2z/2Y6CQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 04 Oct 2024 09:21:33 +0000
Date: Fri, 04 Oct 2024 11:22:27 +0200
Message-ID: <875xq8mdd8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.12-rc2
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82EB221E79
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

please pull sound fixes for v6.12-rc2 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc2

The topmost commit is b3ebb007060f89d5a45c9b99f06a55e36a1945b5

----------------------------------------------------------------

sound fixes for 6.12-rc2

Slightly high amount of changes in this round, partly because of my
vacation in the last weeks.  But all changes are small and nothing
looks worrisome.

The biggest LOCs is MAINTAINERS updates, and there is a core change
for card-ID string creation for non-ASCII inputs.  Others are rather
device-specific, such as new quirks and device IDs for ASoC, usual
HD-audio and USB-audio quirks and fixes, as well as regression fixes
in HD-audio HDMI audio and Conexant codec.

----------------------------------------------------------------

Abdul Rahim (1):
      selftest: alsa: check if user has alsa installed

Abhishek Tamboli (1):
      ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200

Ai Chao (1):
      ALSA: hda/realtek: Add quirk for Huawei MateBook 13 KLV-WX9

Alexey Klimov (3):
      ASoC: codecs: lpass-rx-macro: add missing CDC_RX_BCL_VBAT_RF_PROC2 to default regs values
      ASoC: dt-bindings: qcom,sm8250: add qrb4210-rb2-sndcard
      ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string

Andrei Simion (1):
      ASoC: atmel: mchp-pdmc: Skip ALSA restoration if substream runtime is uninitialized

Baojun Xu (1):
      ALSA: hda/tas2781: Add new quirk for Lenovo Y990 Laptop

Bard Liao (1):
      ASoC: Intel: soc-acpi-intel-rpl-match: add missing empty item

Charles Han (1):
      ASoC: intel: sof_sdw: Add check devm_kasprintf() returned value

Charles Keepax (1):
      ASoC: Intel: soc-acpi: arl: Fix some missing empty terminators

Christophe JAILLET (2):
      ALSA: mixer_oss: Remove some incorrect kfree_const() usages
      ALSA: gus: Fix some error handling paths related to get_bpos() usage

Dan Carpenter (1):
      ALSA: silence integer wrapping warning

David Lawrence Glanzman (1):
      ASoC: amd: yc: Add quirk for HP Dragonfly pro one

Hans P. Moller (1):
      ALSA: line6: add hw monitor volume control to POD HD500X

Hui Wang (1):
      ASoC: imx-card: Set card.owner to avoid a warning calltrace if SND=m

Jan Lalinsky (1):
      ALSA: usb-audio: Add native DSD support for Luxman D-08u

Jaroslav Kysela (3):
      ALSA: hda: fix trigger_tstamp_latched
      MAINTAINERS: ALSA: use linux-sound@vger.kernel.org list
      ALSA: core: add isascii() check to card ID generator

Julia Lawall (1):
      ALSA: Reorganize kerneldoc parameter names

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET

Miquel Raynal (1):
      ASoC: dt-bindings: davinci-mcasp: Fix interrupts property

Nikolai Afanasenkov (1):
      ALSA: hda/realtek: fix mute/micmute LED for HP mt645 G8

Oder Chiou (1):
      ALSA: hda/realtek: Fix the push button function for the ALC257

Oldherl Oh (1):
      ALSA: hda/conexant: fix some typos

Ricardo Rivera-Matos (1):
      ASoC: cs35l45: Corrects cs35l45_get_clk_freq_id function data type

Shengjiu Wang (1):
      ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit

Takashi Iwai (5):
      ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs
      ALSA: hda/generic: Drop obsoleted obey_preferred_dacs flag
      Revert "ALSA: hda: Conditionally use snooping for AMD HDMI"
      ALSA: hda: Add missing parameter description for snd_hdac_stream_timecounter_init()
      ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin

Tang Bin (1):
      ASoC: topology: Fix incorrect addressing assignments

Uwe Kleine-König (1):
      ALSA: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Vijendar Mukunda (1):
      ASoC: amd: acp: don't set card long_name

Wolfram Sang (1):
      ASoC: dt-bindings: renesas,rsnd: correct reg-names for R-Car Gen1

Yu Jiaoliang (1):
      ALSA: Fix typos in comments across various files

---
 .../bindings/sound/davinci-mcasp-audio.yaml        |  2 +-
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |  1 +
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |  2 +-
 MAINTAINERS                                        | 86 +++++++++++-----------
 include/sound/hdaudio.h                            |  2 +-
 sound/aoa/codecs/onyx.c                            |  2 +-
 sound/aoa/codecs/tas.c                             |  2 +-
 sound/core/compress_offload.c                      |  2 +-
 sound/core/control.c                               |  2 +
 sound/core/init.c                                  | 14 +++-
 sound/core/oss/mixer_oss.c                         |  4 +-
 sound/core/oss/rate.c                              |  2 +-
 sound/core/pcm_native.c                            |  2 +-
 sound/core/sound.c                                 |  2 +-
 sound/hda/hdac_stream.c                            |  7 +-
 sound/isa/gus/gus_pcm.c                            |  4 +-
 sound/pci/hda/cs35l41_hda_i2c.c                    |  2 +-
 sound/pci/hda/hda_codec.c                          |  2 +-
 sound/pci/hda/hda_controller.c                     |  3 +-
 sound/pci/hda/hda_controller.h                     |  2 +-
 sound/pci/hda/hda_generic.c                        |  4 +-
 sound/pci/hda/hda_generic.h                        |  1 -
 sound/pci/hda/hda_intel.c                          | 10 +--
 sound/pci/hda/patch_conexant.c                     | 40 ++++++----
 sound/pci/hda/patch_realtek.c                      |  9 ++-
 sound/pci/hda/tas2781_hda_i2c.c                    |  2 +-
 sound/soc/amd/acp/acp-sdw-sof-mach.c               |  5 --
 sound/soc/amd/yc/acp6x-mach.c                      |  7 ++
 sound/soc/atmel/mchp-pdmc.c                        |  3 +
 sound/soc/codecs/cs35l45-tables.c                  |  2 +-
 sound/soc/codecs/cs35l45.h                         |  2 +-
 sound/soc/codecs/lpass-rx-macro.c                  |  2 +-
 sound/soc/fsl/fsl_sai.c                            |  5 +-
 sound/soc/fsl/fsl_sai.h                            |  1 +
 sound/soc/fsl/imx-card.c                           |  1 +
 sound/soc/intel/boards/sof_sdw.c                   | 12 +++
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |  2 +
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c  |  1 +
 sound/soc/qcom/sm8250.c                            |  1 +
 sound/soc/soc-topology.c                           |  4 +-
 sound/usb/line6/podhd.c                            |  2 +-
 sound/usb/quirks.c                                 |  4 +
 tools/testing/selftests/alsa/Makefile              |  4 +
 43 files changed, 162 insertions(+), 107 deletions(-)


