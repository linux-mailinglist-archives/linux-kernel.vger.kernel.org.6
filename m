Return-Path: <linux-kernel+bounces-196783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D528D61D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994C62877E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641D0158849;
	Fri, 31 May 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uq1ILOhx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IF3riYDf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zai2LxUY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SyUNQ1hX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68231586EE;
	Fri, 31 May 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158859; cv=none; b=ONeclZVbZpjVGQo0TM2bZLmI5pgIDTxVdEtfCLmaaPyT93qoqThQSMv7iLU4V7pnjRNHlZOdMpoMNNkzEaFhmUT2SwdaZonuHqMHLLUwipqvbfi0my157+PM/JeWw8c0Yog930PZKydbaXuzdC0ogc2TYtddtVv7pMFVO30CaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158859; c=relaxed/simple;
	bh=XNDl58inuAex0Tk4FdDlHU5e+HdOYp2FnbZr91WyUK0=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=kFzIqFPftDKIfkl69SrDQhynVniSFyDUKmCCsi8X0Fpg+zHhEhDKMTsBtj99gf8+Nyuw/PS13f3e4/zCY7BkaJ/oXHzXIGS+MCRY9VMma56j/2MJ8SaJErXPJjpYmuPnW3gj27eFDsAuhBEnPQMdrAMoaMhYSKfKVkudFfhghdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uq1ILOhx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IF3riYDf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zai2LxUY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SyUNQ1hX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DDD981F8B5;
	Fri, 31 May 2024 12:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717158856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ZdLBrUOq0mWcnqZp5e/wbxTbZjKjzpaNyiA0RgebWtY=;
	b=Uq1ILOhxxMtRce91Y/3X3zVEDYeLQfWUlryxidvpseUKebVlUasr5zCi67BSIDiTrQfcgH
	5qeKMYpDE62c0KoiLghrgxEdxF9vI1qsDclunZkAfz91So+6xTjj4sTu0rbtYosUU5Tmy2
	HXzp+BmSHLYRKWbI9pniteB6AFp3wNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717158856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ZdLBrUOq0mWcnqZp5e/wbxTbZjKjzpaNyiA0RgebWtY=;
	b=IF3riYDfSrhVNn3PejA82d5mC/8OQ0g6VuHUxZR1eagPzuvBBo31xuCYeCLOV7CAtjfxRv
	S/6qKfqY1/kPUCCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zai2LxUY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SyUNQ1hX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717158855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ZdLBrUOq0mWcnqZp5e/wbxTbZjKjzpaNyiA0RgebWtY=;
	b=zai2LxUYQcXip7KWIT2XNJ2Cg4GHgqHzJf86TQVzwPOJRfpFfP4SpDO9h+4inFOuZebhUa
	vqkDJH1XO0kANxypijXoMgOwZ0h0+OUzAZQsUZF4rnde6881eST0e5yFwg/kpfH94Vr8JQ
	nR9RjWPpvSIN/+dKKdwMBJBVrvrTttc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717158855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ZdLBrUOq0mWcnqZp5e/wbxTbZjKjzpaNyiA0RgebWtY=;
	b=SyUNQ1hXqRN0bAQqRXQo7u8XAv+7FxnRlYHr/I8pHxv19lwRVTvNYP+wytIksnTjQdVgO4
	m7TkWc+Y/7aEA/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1287137C3;
	Fri, 31 May 2024 12:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m8/5KcfDWWZ5VAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 31 May 2024 12:34:15 +0000
Date: Fri, 31 May 2024 14:34:38 +0200
Message-ID: <877cfa40td.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.10-rc2
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DDD981F8B5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

Linus,

please pull sound fixes for v6.10-rc2 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc2

The topmost commit is 310fa3ec2859f1c094e6e9b5d2e1ca51738c409a

----------------------------------------------------------------

sound fixes for 6.10-rc2

Lots of small fixes.

- A race fix for debugfs handling in ALSA core
- A series of corrections for MIDI2 core format conversions
- ASoC Intel fixes for 16 bit DMIC config
- Updates for missing module parameters in ASoC code
- HD-audio quirk, Cirrus codec fix, etc minor fixes

----------------------------------------------------------------

Alexandre Belloni (1):
      ALSA: pcm: fix typo in comment

Charles Keepax (3):
      ASoC: cs42l43: Only restrict 44.1kHz for the ASP
      ASoC: wm_adsp: Add missing MODULE_DESCRIPTION()
      MAINTAINERS: Remove James Schulman from Cirrus audio maintainers

Luke D. Jones (1):
      ALSA: hda/realtek: Adjust G814JZR to use SPI init for amp

Peter Ujfalusi (6):
      ASoC: SOF: ipc4-topology: Fix input format query of process modules without base extension
      ASoC: SOF: ipc4-topology: Add support for NHLT with 16-bit only DMIC blob
      ASoC: SOF: ipc4-topology: Print out the channel count in sof_ipc4_dbg_audio_format
      ASoC: SOF: ipc4-topology/pcm: Rename sof_ipc4_copier_is_single_format()
      ASoC: SOF: ipc4-topology: Improve readability of sof_ipc4_prepare_dai_copier()
      ASoC: SOF: ipc4-topology: Adjust the params based on DAI formats

Pierre-Louis Bossart (6):
      ASoC: SOF: stream-ipc: remove unnecessary MODULE_LICENSE
      ASoC: SOF: AMD: group all module related information
      ASoC: SOF: reorder MODULE_ definitions
      ASoC: SOF: add missing MODULE_DESCRIPTION()
      ALSA/hda: intel-dsp-config: reduce log verbosity
      ASoC: Intel: sof-sdw: fix missing SPI_MASTER dependency

Takashi Iwai (9):
      ALSA: core: Remove debugfs at disconnection
      ALSA: seq: Fix missing bank setup between MIDI1/MIDI2 UMP conversion
      ALSA: seq: Don't clear bank selection at event -> UMP MIDI2 conversion
      ALSA: seq: Fix incorrect UMP type for system messages
      ALSA: ump: Don't clear bank selection after sending a program change
      ALSA: ump: Don't accept an invalid UMP protocol number
      ALSA: ump: Set default protocol when not given explicitly
      ALSA: seq: Fix yet another spot for system message conversion
      ALSA: seq: ump: Fix swapped song position pointer data

---
 MAINTAINERS                                    |   1 -
 include/sound/pcm.h                            |   2 +-
 sound/core/init.c                              |   9 +-
 sound/core/jack.c                              |  21 ++--
 sound/core/seq/seq_ump_convert.c               |  48 +++++++-
 sound/core/ump.c                               |  15 +++
 sound/core/ump_convert.c                       |   1 -
 sound/hda/intel-dsp-config.c                   |   8 +-
 sound/pci/hda/patch_realtek.c                  |   2 +-
 sound/soc/codecs/cs42l43.c                     |   5 +-
 sound/soc/codecs/wm_adsp.c                     |   1 +
 sound/soc/intel/boards/Kconfig                 |   2 +-
 sound/soc/sof/amd/acp-common.c                 |   4 +-
 sound/soc/sof/amd/acp.c                        |   2 +-
 sound/soc/sof/amd/acp63.c                      |   4 -
 sound/soc/sof/amd/pci-acp63.c                  |   1 +
 sound/soc/sof/amd/pci-rmb.c                    |   1 +
 sound/soc/sof/amd/pci-rn.c                     |   1 +
 sound/soc/sof/amd/pci-vangogh.c                |   1 +
 sound/soc/sof/amd/rembrandt.c                  |   4 -
 sound/soc/sof/amd/renoir.c                     |   4 -
 sound/soc/sof/amd/vangogh.c                    |   4 -
 sound/soc/sof/core.c                           |   2 +-
 sound/soc/sof/imx/imx-common.c                 |   1 +
 sound/soc/sof/imx/imx8.c                       |   3 +-
 sound/soc/sof/imx/imx8m.c                      |   3 +-
 sound/soc/sof/imx/imx8ulp.c                    |   3 +-
 sound/soc/sof/intel/atom.c                     |   1 +
 sound/soc/sof/intel/bdw.c                      |   1 +
 sound/soc/sof/intel/byt.c                      |   1 +
 sound/soc/sof/intel/hda-codec.c                |   1 +
 sound/soc/sof/intel/hda-ctrl.c                 |   1 +
 sound/soc/sof/intel/hda-mlink.c                |   1 +
 sound/soc/sof/intel/hda.c                      |   1 +
 sound/soc/sof/intel/pci-apl.c                  |   1 +
 sound/soc/sof/intel/pci-cnl.c                  |   1 +
 sound/soc/sof/intel/pci-icl.c                  |   1 +
 sound/soc/sof/intel/pci-lnl.c                  |   1 +
 sound/soc/sof/intel/pci-mtl.c                  |   1 +
 sound/soc/sof/intel/pci-skl.c                  |   1 +
 sound/soc/sof/intel/pci-tgl.c                  |   1 +
 sound/soc/sof/intel/pci-tng.c                  |   1 +
 sound/soc/sof/ipc4-pcm.c                       |  12 +-
 sound/soc/sof/ipc4-topology.c                  | 163 +++++++++++++++++--------
 sound/soc/sof/ipc4-topology.h                  |   6 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c         |   3 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c         |   3 +-
 sound/soc/sof/mediatek/mtk-adsp-common.c       |   1 +
 sound/soc/sof/nocodec.c                        |   2 +-
 sound/soc/sof/sof-acpi-dev.c                   |   1 +
 sound/soc/sof/sof-client-ipc-flood-test.c      |   2 +-
 sound/soc/sof/sof-client-ipc-kernel-injector.c |   2 +-
 sound/soc/sof/sof-client-ipc-msg-injector.c    |   2 +-
 sound/soc/sof/sof-client-probes.c              |   2 +-
 sound/soc/sof/sof-of-dev.c                     |   1 +
 sound/soc/sof/sof-pci-dev.c                    |   1 +
 sound/soc/sof/sof-utils.c                      |   1 +
 sound/soc/sof/stream-ipc.c                     |   2 -
 sound/soc/sof/xtensa/core.c                    |   2 +-
 59 files changed, 257 insertions(+), 117 deletions(-)


