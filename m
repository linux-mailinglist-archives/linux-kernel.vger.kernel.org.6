Return-Path: <linux-kernel+bounces-302880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A54960499
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797EC1F22F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C3197A83;
	Tue, 27 Aug 2024 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mswjum4k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5LqKuqOY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mswjum4k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5LqKuqOY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7A14A90;
	Tue, 27 Aug 2024 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747962; cv=none; b=W3RSwMaXAz4tPxF05++0q7jUhZxqfz+5EdncR1ln19LwIo+Y5MHWTrsjprOsSu76A+GDBnIaGEgNSW8MboYxB2ITJ0CmcFD9dnUXI0bNbfcHquUfItwr8GgPr3puSoyCX63YJccGgrcXkAsq3kU13HxbZEdGjuK3QTJOP2SyONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747962; c=relaxed/simple;
	bh=si+DrXeOC6jl+FzJPYmVZJNqRw8SM0DSMfghOPNmA6s=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=GpZuh0zs3aBo0oNITsDb02Y6W9pYJihmhEzSK4TyYIrUtcCONzybZ7ucjimls+Ka8wWBtInkAH/lysL4LFwYyxhhDaeAoSdMrg66SINIERyXRkuntfXWKzfw4e8ykk2g5mC8OTJ9lHfgHTxEnxeLbA+wOpfvsT+XjMf2fsKeYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mswjum4k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5LqKuqOY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mswjum4k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5LqKuqOY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28EEB1FB51;
	Tue, 27 Aug 2024 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724747959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wWSM30/jjOeBszKKgXJTIzBpDLn18GrnIpI3U+R15ik=;
	b=mswjum4kj9QfxxHmH462tpJKVDx4S5HHZco5oiO30CpIZc6wFSX9Y6iuXwFTGwJW2jKKdJ
	wtiRLMR2GIbSz4ianhK9eRMCI8vx4+UfVTdqBs2aeT68iDLLQoFrIni2YEolUDXZVPAzxB
	QCgtujCUT4vQ1VKef4MEALsETXV4mCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724747959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wWSM30/jjOeBszKKgXJTIzBpDLn18GrnIpI3U+R15ik=;
	b=5LqKuqOYyRuncf6Y+7axCjdslUOZU3dqp/d3NHIr7wKILLhL4vjlU2frN2cGbYjdyeHR4G
	U65HhlKBLhjQMYBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724747959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wWSM30/jjOeBszKKgXJTIzBpDLn18GrnIpI3U+R15ik=;
	b=mswjum4kj9QfxxHmH462tpJKVDx4S5HHZco5oiO30CpIZc6wFSX9Y6iuXwFTGwJW2jKKdJ
	wtiRLMR2GIbSz4ianhK9eRMCI8vx4+UfVTdqBs2aeT68iDLLQoFrIni2YEolUDXZVPAzxB
	QCgtujCUT4vQ1VKef4MEALsETXV4mCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724747959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wWSM30/jjOeBszKKgXJTIzBpDLn18GrnIpI3U+R15ik=;
	b=5LqKuqOYyRuncf6Y+7axCjdslUOZU3dqp/d3NHIr7wKILLhL4vjlU2frN2cGbYjdyeHR4G
	U65HhlKBLhjQMYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0221913724;
	Tue, 27 Aug 2024 08:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCDxOraQzWaUFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 27 Aug 2024 08:39:18 +0000
Date: Tue, 27 Aug 2024 10:40:02 +0200
Message-ID: <87zfoy1hr1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.11-rc6
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

please pull sound fixes for v6.11-rc6 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc6

The topmost commit is 28b329f431cef840fddd9a9b493bc3eff1aa06c0

----------------------------------------------------------------

sound fixes for 6.11-rc6

It became a bit larger collection of fixes than wished at this time,
but all changes are small and mostly device-specific fixes that
should be fairly safe to apply.  Majority of fixes are about ASoC
for AMD SOF, Cirrus codecs, lpass, etc, in addition to the usual
HD-audio quirks / fixes.

----------------------------------------------------------------

Albert Jakie³a (1):
      ASoC: SOF: mediatek: Add missing board compatible

Dmitry Baryshkov (2):
      ASoC: codecs: lpass-macro: fix version strings returned for 1.x codecs
      ASoC: codecs: lpass-va-macro: warn on unknown version

Hendrik Borghorst (1):
      ALSA: hda/realtek: support HP Pavilion Aero 13-bg0xxx Mute LED

Hongbo Li (2):
      ASoC: allow module autoloading for table db1200_pids
      ASoC: allow module autoloading for table board_ids

John Sweeney (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs on HP Laptop 14-ey0xxx

Kailang Yang (2):
      ALSA: hda/realtek - Fixed ALC256 headphone no sound
      ALSA: hda/realtek - FIxed ALC285 headphone no sound

Krzysztof Kozlowski (2):
      ASoC: MAINTAINERS: Drop Banajit Goswami from Qualcomm sound drivers
      ASoC: codecs: wcd937x: Fix missing de-assert of reset GPIO

Richard Fitzgerald (3):
      ASoC: cs-amp-lib-test: Force test calibration blob entries to be valid
      ASoC: cs-amp-lib: Ignore empty UEFI calibration entries
      ALSA: hda: hda_component: Fix mutex crash if nothing ever binds

Simon Trimmer (1):
      ALSA: hda: cs35l56: Don't use the device index as a calibration index

Takashi Iwai (1):
      ALSA: seq: Skip event type filtering for UMP events

Vijendar Mukunda (3):
      ASoC: SOF: amd: move iram-dram fence register programming sequence
      ASoC: SOF: amd: Fix for incorrect acp error register offsets
      ASoC: SOF: amd: Fix for acp init sequence

YOUNGJIN JOO (1):
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book3 Ultra

YR Yang (1):
      ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile

Yuntao Liu (1):
      ASoC: amd: acp: fix module autoloading

---
 MAINTAINERS                                |  1 -
 sound/core/seq/seq_clientmgr.c             |  3 ++
 sound/pci/hda/cs35l56_hda.c                |  2 +-
 sound/pci/hda/hda_component.c              |  5 +-
 sound/pci/hda/patch_realtek.c              | 79 ++++++++++++++++++++----------
 sound/soc/amd/acp/acp-legacy-mach.c        |  2 +
 sound/soc/amd/acp/acp-sof-mach.c           |  2 +
 sound/soc/au1x/db1200.c                    |  1 +
 sound/soc/codecs/cs-amp-lib-test.c         |  9 ++++
 sound/soc/codecs/cs-amp-lib.c              |  7 ++-
 sound/soc/codecs/lpass-macro-common.h      |  6 +++
 sound/soc/codecs/lpass-va-macro.c          |  4 ++
 sound/soc/codecs/wcd937x.c                 |  5 +-
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c |  1 +
 sound/soc/sof/amd/acp-dsp-offset.h         |  6 ++-
 sound/soc/sof/amd/acp.c                    | 52 +++++++++++++-------
 sound/soc/sof/amd/acp.h                    |  9 +++-
 sound/soc/sof/amd/pci-acp63.c              |  2 +
 sound/soc/sof/amd/pci-rmb.c                |  2 +
 sound/soc/sof/amd/pci-rn.c                 |  2 +
 sound/soc/sof/mediatek/mt8195/mt8195.c     |  3 ++
 21 files changed, 149 insertions(+), 54 deletions(-)


