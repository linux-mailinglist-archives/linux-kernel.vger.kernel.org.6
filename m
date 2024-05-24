Return-Path: <linux-kernel+bounces-188442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D68CE21C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1382C1C2143D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8CB1292C1;
	Fri, 24 May 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RoY1zH+l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MP5bm/dU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RoY1zH+l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MP5bm/dU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A312836A;
	Fri, 24 May 2024 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538401; cv=none; b=WdSYko07C6vqjpcZrH6mp4Y/br3b+1kaidyQdfQGcw3tPGUW0ohgWF8WjbPtXcoZaRxo4VOTYby5lLruvYZ58d4gIjHn0KBn41c5L5KmJRcdVfa94i+ccAMlybtmj5vPnVpPZnkCnYIShIVoMyW9pn/sDrXQazUTbWlItkEgCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538401; c=relaxed/simple;
	bh=7VuJP8Vnly84R+bMoIjVxkdqLh/xmIQnHlsqmO1Rn9k=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=by2B8Q6d4LYZ/yuiYQNlHctEoKJyC+Qu6nduQvlfzH7ItWQ+iRIv5q6E5/HFlkMuy5B+QKep+GSLuWHj59YgIpQ8lnM86wTEROLxYX1218wqoxQNg43U8Y0M7u4J8JpxT4NxjxFIU+dRmlPPALEkQwbjgDup37K0IgEGkZahGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RoY1zH+l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MP5bm/dU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RoY1zH+l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MP5bm/dU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CACEC2207B;
	Fri, 24 May 2024 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716538397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wixCJesKzOkqepAOjyWPxCieNSE0jMDIePVeY+eukyk=;
	b=RoY1zH+lU57gVBbfvHDVhH6prk52oSuDgnhENF3zoUjcQ8G1LkLpAbmg1nrZkm43ssj3My
	LpzUWyG8h81O/FBqpY/SiWwTFueRRw5VeP2iFybjD+4DSBD0kIAWX4GQwBGMawWbuWfZwf
	gqwdamlz8BfHh0scVUdOKLBKwXA3whI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716538397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wixCJesKzOkqepAOjyWPxCieNSE0jMDIePVeY+eukyk=;
	b=MP5bm/dUbNY5TfWhtrdCJ33T6Se/StF8l1YSRNmDVARAUBOHf97qLnONhtM/X9QoOrWs0C
	sJQ2HMV0JUerLDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716538397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wixCJesKzOkqepAOjyWPxCieNSE0jMDIePVeY+eukyk=;
	b=RoY1zH+lU57gVBbfvHDVhH6prk52oSuDgnhENF3zoUjcQ8G1LkLpAbmg1nrZkm43ssj3My
	LpzUWyG8h81O/FBqpY/SiWwTFueRRw5VeP2iFybjD+4DSBD0kIAWX4GQwBGMawWbuWfZwf
	gqwdamlz8BfHh0scVUdOKLBKwXA3whI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716538397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wixCJesKzOkqepAOjyWPxCieNSE0jMDIePVeY+eukyk=;
	b=MP5bm/dUbNY5TfWhtrdCJ33T6Se/StF8l1YSRNmDVARAUBOHf97qLnONhtM/X9QoOrWs0C
	sJQ2HMV0JUerLDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B25813A6B;
	Fri, 24 May 2024 08:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u5VMJB1MUGb/MAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 24 May 2024 08:13:17 +0000
Date: Fri, 24 May 2024 10:13:36 +0200
Message-ID: <87ttin39vz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.10-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.10-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.10-rc1

The topmost commit is d001e978c1c45b25d823489171151d13fd28ef4e

----------------------------------------------------------------

sound fixes for 6.10-rc1

A collection of small fixes for 6.10-rc1.  Most of changes are
various device-specific fixes and quirks, while there are a few small
changes in ALSA core timer and module / built-in fixes.

----------------------------------------------------------------

Abhinav Saxena (1):
      Documentation: sound: Fix trailing whitespaces

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 440/460 G11.

Jack Yu (1):
      ASoC: rt5645: mic-in detection threshold modification

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897

Manuel Barrio Linares (1):
      ALSA: usb-audio: Fix for sampling rates support for Mbox3

Peter Ujfalusi (1):
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: Use name_prefix for `-sdca` detection

Rob Herring (Arm) (1):
      ASoC: dt-bindings: stm32: Ensure compatible pattern matches whole string

Shenghao Ding (2):
      ASoC: tas2552: Add TX path for capturing AUDIO-OUT data
      ASoC: tas2781: Fix wrong loading calibrated data sequence

Takashi Iwai (3):
      ALSA: timer: Set lower bound of start tick time
      ALSA: core: Fix NULL module pointer assignment at card init
      ALSA: core: Enable proc module when CONFIG_MODULES=y

Zhang Yi (1):
      ASoC: codecs: ES8326: solve hp and button detect issue

---
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |   2 +-
 Documentation/sound/hd-audio/notes.rst             |  16 ++--
 include/sound/tas2781-dsp.h                        |   7 +-
 sound/core/init.c                                  |  12 +--
 sound/core/timer.c                                 |   8 ++
 sound/pci/hda/patch_realtek.c                      |  12 +++
 sound/soc/codecs/es8326.c                          |   6 +-
 sound/soc/codecs/rt5645.c                          |   1 +
 sound/soc/codecs/tas2552.c                         |  15 ++-
 sound/soc/codecs/tas2781-fmwlib.c                  | 103 ++++++---------------
 sound/soc/codecs/tas2781-i2c.c                     |   4 +-
 .../soc/intel/boards/sof_sdw_rt_sdca_jack_common.c |   2 +-
 sound/usb/quirks.c                                 |   4 +-
 13 files changed, 86 insertions(+), 106 deletions(-)


