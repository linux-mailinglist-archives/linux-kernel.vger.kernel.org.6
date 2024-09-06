Return-Path: <linux-kernel+bounces-318709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4996F1DE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CF4B20AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22B1C9EDB;
	Fri,  6 Sep 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tHwl6+F7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErDCS3Pm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tHwl6+F7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErDCS3Pm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACF81745;
	Fri,  6 Sep 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619668; cv=none; b=Xsp1yD/lPCXxtjL7uozjHY0DdoD59iqFZ0DYefvOsLrA+j78mHYFWZCyReiLY/rx/AZA0qDuc3tgVhvM01OEDQ9arRhePgVyAMqryp6NhIO28zJdCaSH4remuMkRtYCCRhEc+dMjlPh4lWzvz0U9ARZ/74ptb+y/DvehIDhNDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619668; c=relaxed/simple;
	bh=popGKZkxSyOkhtXWOF52G3sbmdKPh9jAf+EFGm5GTt4=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=Bzh16Kwqv0BneN8R5AQYGoMFI3yHqtXJ5RxFYJpFMj98qixcZb4T9+5y7fCe6FYspkirMP8YGrWvGf+lRXqK93UOn2BSFQKmVB/KbJlnAApSNa9VNtpP7+jQPo480vGt6caI14k1ZYgPGEq18zQP/i7GVQVYIgrYozkg3Xid0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tHwl6+F7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ErDCS3Pm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tHwl6+F7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ErDCS3Pm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06D6A21296;
	Fri,  6 Sep 2024 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725619665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8m9+n8DYoRGTmAnTJJBCgF8YEVPSUXFrIxgh+2Q+kDo=;
	b=tHwl6+F7Y+8zkxtoIrSB7KuAYyAYbMJWPq7cNDl29JWZ5T4YsKFl6HHlL3SOZHPkcQENoP
	btK2XCQrLs+4tYkKOfZaTS8UHKUeAlRNzkcZ6bbZIDvXexkPmfblXyWQ0nHHO6uZVNWSov
	9tolnRp7bc0zj0LNsUtvJpKyvOPKMrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725619665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8m9+n8DYoRGTmAnTJJBCgF8YEVPSUXFrIxgh+2Q+kDo=;
	b=ErDCS3Pmo/QfyEsMYH70ku5aY38ffcpbWGprkxGsDTST/GMnxZ/vNwZflf8oaDFKnLhIcC
	5mJURtYEQSQhUYCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tHwl6+F7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ErDCS3Pm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725619665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8m9+n8DYoRGTmAnTJJBCgF8YEVPSUXFrIxgh+2Q+kDo=;
	b=tHwl6+F7Y+8zkxtoIrSB7KuAYyAYbMJWPq7cNDl29JWZ5T4YsKFl6HHlL3SOZHPkcQENoP
	btK2XCQrLs+4tYkKOfZaTS8UHKUeAlRNzkcZ6bbZIDvXexkPmfblXyWQ0nHHO6uZVNWSov
	9tolnRp7bc0zj0LNsUtvJpKyvOPKMrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725619665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8m9+n8DYoRGTmAnTJJBCgF8YEVPSUXFrIxgh+2Q+kDo=;
	b=ErDCS3Pmo/QfyEsMYH70ku5aY38ffcpbWGprkxGsDTST/GMnxZ/vNwZflf8oaDFKnLhIcC
	5mJURtYEQSQhUYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0587136A8;
	Fri,  6 Sep 2024 10:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V1iJMdDd2maScQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Sep 2024 10:47:44 +0000
Date: Fri, 06 Sep 2024 12:48:30 +0200
Message-ID: <87seuddpmp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.11-rc7
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06D6A21296
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

please pull sound fixes for v6.11-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc7

The topmost commit is c491b044cf5f8236742887ba59b30032036e4ac8

----------------------------------------------------------------

sound fixes for 6.11-rc7

Hopefully the last PR for 6.11, at least for this level of amount.

In addition to the usual HD-audio quirks, there are more changes in
ASoC, but all look small and device-specific fixes, and nothing stands
out.  The only slightly big change is sunxi I2S fix, which looks quite
safe to apply, too.

----------------------------------------------------------------

Adam Queler (1):
      ALSA: hda/realtek: Enable Mute Led for HP Victus 15-fb1xxx

Chen-Yu Tsai (1):
      ASoc: SOF: topology: Clear SOF link platform name upon unload

Christoffer Sandberg (1):
      ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices

Hans de Goede (2):
      ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards harder
      ASoC: Intel: soc-acpi-cht: Make Lenovo Yoga Tab 3 X90F DMI match less strict

Kai Vehmanen (1):
      ALSA: hda: add HDMI codec ID for Intel PTL

Laurentiu Mihalcea (1):
      ASoC: SOF: ipc: replace "enum sof_comp_type" field with "uint32_t"

Liao Chen (4):
      ASoC: intel: fix module autoloading
      ASoC: google: fix module autoloading
      ASoC: tda7419: fix module autoloading
      ASoC: fix module autoloading

Marek Marczykowski-Górecki (1):
      ALSA: hda/realtek: extend quirks for Clevo V5[46]0

Markuss Broks (1):
      ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)

Matteo Martelli (1):
      ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode

Maximilien Perreault (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx

Mohan Kumar (1):
      ASoC: tegra: Fix CBB error during probe()

Srinivas Kandagatla (1):
      ASoC: codecs: lpass-va-macro: set the default codec version for sm8250

Terry Cheong (1):
      ALSA: hda/realtek: add patch for internal mic in Lenovo V145

Vasiliy Kovalev (1):
      ALSA: hda/realtek - Fix inactive headset mic jack for ASUS Vivobook 15 X1504VAP

Zhang Yi (1):
      ASoC: mediatek: mt8188-mt6359: Modify key

robelin (1):
      ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object

---
 include/sound/sof/topology.h                      |   2 +-
 include/uapi/sound/sof/abi.h                      |   2 +-
 sound/pci/hda/patch_conexant.c                    |  11 ++
 sound/pci/hda/patch_hdmi.c                        |   1 +
 sound/pci/hda/patch_realtek.c                     |  22 +++-
 sound/soc/amd/yc/acp6x-mach.c                     |   7 ++
 sound/soc/codecs/chv3-codec.c                     |   1 +
 sound/soc/codecs/lpass-va-macro.c                 |  11 +-
 sound/soc/codecs/tda7419.c                        |   1 +
 sound/soc/google/chv3-i2s.c                       |   1 +
 sound/soc/intel/boards/bxt_rt298.c                |   2 +-
 sound/soc/intel/boards/bytcht_cx2072x.c           |   2 +-
 sound/soc/intel/boards/bytcht_da7213.c            |   2 +-
 sound/soc/intel/boards/bytcht_es8316.c            |   2 +-
 sound/soc/intel/boards/bytcr_rt5640.c             |   2 +-
 sound/soc/intel/boards/bytcr_rt5651.c             |   2 +-
 sound/soc/intel/boards/bytcr_wm5102.c             |   2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c           |   2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c           |   2 +-
 sound/soc/intel/common/soc-acpi-intel-cht-match.c |   1 -
 sound/soc/intel/keembay/kmb_platform.c            |   1 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c         |  17 ++-
 sound/soc/soc-dapm.c                              |   1 +
 sound/soc/sof/topology.c                          |   2 +
 sound/soc/sunxi/sun4i-i2s.c                       | 143 +++++++++++-----------
 sound/soc/tegra/tegra210_ahub.c                   |  12 +-
 26 files changed, 161 insertions(+), 93 deletions(-)


