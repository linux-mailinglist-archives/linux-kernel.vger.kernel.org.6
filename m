Return-Path: <linux-kernel+bounces-410472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6A19CDC03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20592283DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29965193067;
	Fri, 15 Nov 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HrhlFTU6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NfwlmhTU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u9hXQfOV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FT5/TzqE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E4192D64;
	Fri, 15 Nov 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664785; cv=none; b=F0RdU9YhtqSx91I2IjIVkU1Vs85R171SYJuQZvm6UnVbt5QNNDEKD/vmZNVLD+JJFGBe+B7jbUvEATTUmgU0cLEKW2ZtF4119vn8qzkIYzHai7QDvL/nZCCXaZ9XaoYPYECKWdkfQiqAW/aQ3kUe7OI3Iz5MnxPObD3rETJtQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664785; c=relaxed/simple;
	bh=aNneLhG6ndUm6PgWRzbt0kR8VVlFoKPdIhn59X2H178=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=gl30XBMkKUQNbGaCw3kB9ZJNxwhaNpj2P8UR8Exq3rGq800P72QnI8lttoqhSZ+LDyI0s172YUHQip/chn4AvJxRd2rrv0gD7sta3zRGupZfwQFGJ4pFB3WZ8jr1uYlRN4EIbl63aJIgkyEXYcoEBc4f03J3nZq3dzj2IAa/JT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HrhlFTU6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NfwlmhTU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u9hXQfOV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FT5/TzqE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A283B1F7BF;
	Fri, 15 Nov 2024 09:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731664781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gl/T2RQ1L4pDQg5cdpxUzjXA9Vs2o4SR+xWtc9Ju0zg=;
	b=HrhlFTU6pCOX5mp9DgF+EA35v6NMVmt86LC25HsYsyvIxVoOkIk+PsB5DU3XYxkRuiSdnR
	yMd/8dadeHdDl85HDaBmhV1+lnsviscqKBUTwgTxt8+JCv+a8SRN/qUAFoiihRNR1r7NJR
	MTrMUPrKAB7+fg/FBhAT+XwpPCVs+Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731664781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gl/T2RQ1L4pDQg5cdpxUzjXA9Vs2o4SR+xWtc9Ju0zg=;
	b=NfwlmhTUSdhs+eEi9rtPmBmyJrasS2T4AuFCDUpVNiUu/+VnB7zCaD91VE1x351FxnnOSB
	5EDLiJ5bCvUa3UDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731664780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gl/T2RQ1L4pDQg5cdpxUzjXA9Vs2o4SR+xWtc9Ju0zg=;
	b=u9hXQfOV4U6ENkpkr7emNOQB9z9eKHxFO5DNLH8Um3xYU9AYeH57bm939t4VoWWlzn6IQc
	rysKRlSPyap0eGABg0Rrqk9wa8omQvFA7QRnR2YzhWQubVks6JjjxGleyHe1oNOVp9bdND
	LKTfv9M6TPg5qveoZ2kP3BPZlNWn+pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731664780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gl/T2RQ1L4pDQg5cdpxUzjXA9Vs2o4SR+xWtc9Ju0zg=;
	b=FT5/TzqEGlJnRndrp8/ZoegcbR5FPVaGetWzFlhWiQjLh8nCD/24+A3wC43Mo4YOcC1CxU
	pYLPkpUWtNsbjNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B858134B8;
	Fri, 15 Nov 2024 09:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e+0EHYwbN2c6TgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Nov 2024 09:59:40 +0000
Date: Fri, 15 Nov 2024 10:59:40 +0100
Message-ID: <877c94stpv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.12
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

please pull sound fixes for v6.12 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12

The topmost commit is 5ec23a1b53a98dbd7ea33954db5f0fe7110903aa

----------------------------------------------------------------

sound fixes for 6.12

A few last-minute fixes.  All changes are device-specific small
fixes that should be pretty safe to apply.

----------------------------------------------------------------

Deep Harsora (1):
      ASoC: intel: sof_sdw: add quirk for Dell SKU

Eryk Zagorski (1):
      ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry

John Watts (1):
      ASoC: audio-graph-card2: Purge absent supplies for device tree nodes

Kailang Yang (2):
      ALSA: hda/realtek - Fixed Clevo platform headset Mic issue
      ALSA: hda/realtek - update set GPIO3 to default for Thinkpad with ALC1318

Maksym Glubokiy (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP EliteBook 645 G10

Mark Brown (1):
      ASoC: max9768: Fix event generation for playback mute

---
 sound/pci/hda/patch_realtek.c         | 13 +++++++++++--
 sound/soc/codecs/max9768.c            | 11 +++++++++--
 sound/soc/generic/audio-graph-card2.c |  3 +++
 sound/soc/intel/boards/sof_sdw.c      |  8 ++++++++
 sound/usb/quirks-table.h              | 14 +++++++++++++-
 5 files changed, 44 insertions(+), 5 deletions(-)


