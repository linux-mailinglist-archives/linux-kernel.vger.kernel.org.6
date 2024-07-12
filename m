Return-Path: <linux-kernel+bounces-250319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0D692F66C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E4128319C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C713E02A;
	Fri, 12 Jul 2024 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LH19nVHR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FzAoSyOC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LH19nVHR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FzAoSyOC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45018E0E;
	Fri, 12 Jul 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770376; cv=none; b=LTS/clj2+Y4QYfSc/RkTTIttc3a1XCWarquc7hE56Y65cn4TfzzMRPtH9vXoYgXl1nq9GpkcblGj9NWKAzhdTQpzNlH+jneDEVwWNfArzYYP6XyfxOLAYx93qEeXUEjB7odS0Untse8kwWMCwKCfFdQWetXhzpGtvD5z0yOSFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770376; c=relaxed/simple;
	bh=FLZJ2DNKRObjLLAsheukVyi/6CyxQ92QWG6OPveNOeQ=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=jjuQba2wzFIN6dMsXy7ZefLlDAcjxFuU8KWRfE9NPMh+JnGMFNBpEgcsaf71TNv206ytGTWGojHy+Mvru0CuZpub+aVX6DPeeNRCObt6Oigsx7T36b/ZimU/r6XY/NdNzVLWuDb2HN0B6npJwyhxRd9+JfOqZRKPq2MJxGGZpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LH19nVHR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FzAoSyOC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LH19nVHR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FzAoSyOC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C414B21A9A;
	Fri, 12 Jul 2024 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720770372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4POzoQr9IczO1/1hb4qIFi9RmUkhNPmaG86SNToS2gI=;
	b=LH19nVHRKIjBbPoqtXGprVQ2hNAT0WOPe9GuF1HlLiMXIc5CL8ZGHXdNrXKWTtiNbZyI/b
	NlGKGCKaDDPmUjWAIiwWOj3XWlBTfLAzPukjEhIyR6iGR5ZvMCG3Ns3+gqdT3EoAjWjhuR
	Tz3uXDFpafvopVTB6/6YaJfaYEm2RUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720770372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4POzoQr9IczO1/1hb4qIFi9RmUkhNPmaG86SNToS2gI=;
	b=FzAoSyOCUDdGV8TKV7UatWnRqNwqYGuldnQ0KcWgU4oEfBAQUFVkzZ4G9BpKVLiKmTD7xc
	zxDKYgqWwfkrUDCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720770372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4POzoQr9IczO1/1hb4qIFi9RmUkhNPmaG86SNToS2gI=;
	b=LH19nVHRKIjBbPoqtXGprVQ2hNAT0WOPe9GuF1HlLiMXIc5CL8ZGHXdNrXKWTtiNbZyI/b
	NlGKGCKaDDPmUjWAIiwWOj3XWlBTfLAzPukjEhIyR6iGR5ZvMCG3Ns3+gqdT3EoAjWjhuR
	Tz3uXDFpafvopVTB6/6YaJfaYEm2RUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720770372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4POzoQr9IczO1/1hb4qIFi9RmUkhNPmaG86SNToS2gI=;
	b=FzAoSyOCUDdGV8TKV7UatWnRqNwqYGuldnQ0KcWgU4oEfBAQUFVkzZ4G9BpKVLiKmTD7xc
	zxDKYgqWwfkrUDCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A6CE13686;
	Fri, 12 Jul 2024 07:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fRRyJETfkGbrdgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Jul 2024 07:46:12 +0000
Date: Fri, 12 Jul 2024 09:46:44 +0200
Message-ID: <87a5int5ln.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.10
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
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
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Linus,

please pull sound fixes for v6.10 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10

The topmost commit is f19e1027f6c0f5fae18b2f2ed88b55a6a637f76e

----------------------------------------------------------------

sound fixes for 6.10-final

Majority of changes here are small device-specific fixes for ASoC
SOF / Intel and usual HD-audio quirks.

The only significant high LOC is found in the Cirrus firmware driver,
but all those are for hardening against malicious firmware blobs, and
they look fine for taking as a last minute fix, too.

----------------------------------------------------------------

Bard Liao (1):
      ASoC: rt711-sdw: add missing readable registers

Dmitry Savin (1):
      ALSA: hda: cs35l41: Fix swapped l/r audio channels for Lenovo ThinBook 13x Gen4

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on VAIO PRO PX

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda: fix null deref on system suspend entry

Micha³ Kopeæ (1):
      ALSA: hda/realtek: add quirk for Clevo V5[46]0TU

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable Mute LED on HP 250 G7

Peter Ujfalusi (1):
      ASoC: SOF: Intel: hda-pcm: Limit the maximum number of periods by MAX_BDL_ENTRIES

Richard Fitzgerald (5):
      firmware: cs_dsp: Fix overflow checking of wmfw header
      firmware: cs_dsp: Return error if block header overflows file
      firmware: cs_dsp: Validate payload length before processing block
      firmware: cs_dsp: Prevent buffer overrun when processing V2 alg headers
      firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files

---
 drivers/firmware/cirrus/cs_dsp.c     | 231 +++++++++++++++++++++++++----------
 sound/pci/hda/cs35l41_hda_property.c |   4 +-
 sound/pci/hda/patch_realtek.c        |   4 +
 sound/soc/codecs/rt711-sdw.c         |   2 +
 sound/soc/sof/intel/hda-dai.c        |  12 +-
 sound/soc/sof/intel/hda-pcm.c        |   6 +
 6 files changed, 184 insertions(+), 75 deletions(-)


