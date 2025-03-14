Return-Path: <linux-kernel+bounces-561139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9AA60E00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48ED71894BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300C1EF368;
	Fri, 14 Mar 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YTnMrqXi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rwzc2KsQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YTnMrqXi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rwzc2KsQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B511D6187
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946245; cv=none; b=UMLIvUH/ssOQReQmsV7VddcA6+poReFk+73QnGKlAuv6rSjAbLIItpi+k5ZE3FuFnvWHbtUgG9M/BTzhIH6BxtM9UK+VASl9vhXCGmFZ0Wb+zeT3BiEPt/osxjLCjDKJboiN7+AThyPd/1U8TCNUxyiRXibAe9GdN/0SX81pQpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946245; c=relaxed/simple;
	bh=XuHaS1SreI7HGeM2X3F8ZmDECaY9vN/87Syd4zfMHKE=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=qOUUydyWsq/4zJypOb/d6jlnZHg8aLL+bSX2zuV4RSxbIsiHG/lyS4eQASkeLrZTD5vsa/Cw8ZpXFbR4YdZ/fuH/GpMQmj3A7Y1gcIsjlY1RlUe/M6TJX55RxjdHGUTXrDKbgDWMjFkiWHI/7EGrxmxyUNyTtzaq7g2+aQseZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YTnMrqXi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rwzc2KsQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YTnMrqXi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rwzc2KsQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37D071F38E;
	Fri, 14 Mar 2025 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741946242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VbBMpWmHKuN5+l4Oh5G2g61fbSStc3KAtQ8hmFlFbp4=;
	b=YTnMrqXixboU7OKwlBFvfOC5jTRqi42eKir5Pk8lFkmHUzf8Td1hGaegbeDOZDXX2dUiwh
	W/S3PyVh9aZ4HpBdeO/gidrtsg7DECt0tK5n1uZu9kXkkE5pZ6THtZAViQxPIEICXy/OIh
	6fWQneNospy1lb1lc3kmePkwUGcdLXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741946242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VbBMpWmHKuN5+l4Oh5G2g61fbSStc3KAtQ8hmFlFbp4=;
	b=rwzc2KsQH5027jp6y9Jmd1c2G/id4Fd4QymJ0jH0NB6NXcNYJAMD4inVhr7TegBe+zoCe5
	CYLO2D85IDg2p9BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741946242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VbBMpWmHKuN5+l4Oh5G2g61fbSStc3KAtQ8hmFlFbp4=;
	b=YTnMrqXixboU7OKwlBFvfOC5jTRqi42eKir5Pk8lFkmHUzf8Td1hGaegbeDOZDXX2dUiwh
	W/S3PyVh9aZ4HpBdeO/gidrtsg7DECt0tK5n1uZu9kXkkE5pZ6THtZAViQxPIEICXy/OIh
	6fWQneNospy1lb1lc3kmePkwUGcdLXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741946242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VbBMpWmHKuN5+l4Oh5G2g61fbSStc3KAtQ8hmFlFbp4=;
	b=rwzc2KsQH5027jp6y9Jmd1c2G/id4Fd4QymJ0jH0NB6NXcNYJAMD4inVhr7TegBe+zoCe5
	CYLO2D85IDg2p9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EBC913A31;
	Fri, 14 Mar 2025 09:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7GMXAoL902ebWwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Mar 2025 09:57:22 +0000
Date: Fri, 14 Mar 2025 10:57:21 +0100
Message-ID: <87zfho7x4u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.14-rc7
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.14-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc7

The topmost commit is de69d56daac6d9b98fa384184078751db1288144

----------------------------------------------------------------

sound fixes for 6.14-rc7

A collection of last-minute fixes.  Most of them are for ASoC, and
the only one core fix is for reverting the previous change, while
the rest are all device-specific quirks and fixes, which should be
relatively safe to apply.

----------------------------------------------------------------

Alexey Klimov (1):
      ASoC: codecs: wsa884x: report temps to hwmon in millidegree of Celsius

Arnd Bergmann (1):
      ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS

Bard Liao (2):
      ASoC: rt1320: set wake_capable = 0 explicitly
      ASoC: rt722-sdca: add missing readable registers

Charles Keepax (2):
      ASoC: ops: Consistently treat platform_max as control value
      ASoC: cs42l43: Fix maximum ADC Volume

Christophe JAILLET (1):
      ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()

Maciej Strozek (1):
      ASoC: cs42l43: Add jack delay debounce after suspend

Navon John Lukose (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion x360 14-dy1xxx

Peter Ujfalusi (1):
      ASoC: Intel: sof_sdw: Fix unlikely uninitialized variable use in create_sdw_dailinks()

Thomas Mizrahi (1):
      ASoC: amd: yc: Support mic on another Lenovo ThinkPad E16 Gen 2 model

Thorsten Blum (1):
      ASoC: tegra: Fix ADX S24_LE audio format

---
 include/sound/soc.h               |  5 ++++-
 sound/pci/hda/patch_realtek.c     | 21 +++++++++++++++++++++
 sound/soc/amd/yc/acp6x-mach.c     |  7 +++++++
 sound/soc/codecs/cs42l43-jack.c   | 13 ++++++++++---
 sound/soc/codecs/cs42l43.c        | 17 +++++++++++++++--
 sound/soc/codecs/cs42l43.h        |  3 +++
 sound/soc/codecs/rt1320-sdw.c     |  3 +++
 sound/soc/codecs/rt722-sdca-sdw.c |  4 ++++
 sound/soc/codecs/wm0010.c         | 13 +++++++++++--
 sound/soc/codecs/wsa884x.c        |  4 ++--
 sound/soc/intel/boards/sof_sdw.c  |  2 +-
 sound/soc/soc-ops.c               | 15 +++++++--------
 sound/soc/tegra/tegra210_adx.c    |  4 ++--
 13 files changed, 90 insertions(+), 21 deletions(-)


