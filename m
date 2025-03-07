Return-Path: <linux-kernel+bounces-550663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D1A56294
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306D77A9E0E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106871AE876;
	Fri,  7 Mar 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oXIhDNgM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LSODo0SU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oXIhDNgM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LSODo0SU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F31A83E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336404; cv=none; b=b2uCeFcmWC6Eq2O0MFUTL6wblA7EmYF30YqKiYX8F+cxdeiaPD6wBebhN6VUoYI4dXmct9rWwjtbMTfpApeQA0Oiy3RNhlFjdWkFMHr3ZxuG44j7ZytGilvYnV/EPUAutk9NAwFyRJtrf46juujxvgv3n8+obDlKdDhV82MbQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336404; c=relaxed/simple;
	bh=fp0wZ1B37+kunhup5NKCEVsmlLuykTmuA8Xv2dkWZSM=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=H2qNmm3JH0Vjj8I7V/oJFrGwAkYyl96qoWDNqNeZ0MI00tePzKUilswItz27tBYqfb0OVvfjoZ7mJSgkCehqC6+S1FglYm8jGO7qvy/kI1r6/+X2kujoiozaP2jTWnfIZ5TmN7rL4ZPCmaH3qGExq7JGTVA9GgDgSmWQeACS398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oXIhDNgM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LSODo0SU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oXIhDNgM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LSODo0SU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41E69211D3;
	Fri,  7 Mar 2025 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741336394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QKcHz4XyuMo1oBhlgcGkCEjsGlCzsu9+zyXeDFtPsMk=;
	b=oXIhDNgMrb5fmcZxGshmB9oKIF18FPiO4dSku6eq+zKd7VlW9Vriy1MrPy+XhOcyRUB1EF
	vtSOouqGcp7wMixEwJEN2M6LOg7JAYg+1MuKo/5NvN3sj8tKXBOhXgee8exh5hphXVt6FZ
	Ria57AH4CTCtuG2X34jJ7YalmXOm9e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741336394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QKcHz4XyuMo1oBhlgcGkCEjsGlCzsu9+zyXeDFtPsMk=;
	b=LSODo0SUAbLxWQmIm9mVfPu0lTsorAYywbe6kmlDQTVnT/sEUoSpAyBfE37ef+gazjoKdd
	NtaK0hN1swf/E1Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oXIhDNgM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LSODo0SU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741336394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QKcHz4XyuMo1oBhlgcGkCEjsGlCzsu9+zyXeDFtPsMk=;
	b=oXIhDNgMrb5fmcZxGshmB9oKIF18FPiO4dSku6eq+zKd7VlW9Vriy1MrPy+XhOcyRUB1EF
	vtSOouqGcp7wMixEwJEN2M6LOg7JAYg+1MuKo/5NvN3sj8tKXBOhXgee8exh5hphXVt6FZ
	Ria57AH4CTCtuG2X34jJ7YalmXOm9e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741336394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QKcHz4XyuMo1oBhlgcGkCEjsGlCzsu9+zyXeDFtPsMk=;
	b=LSODo0SUAbLxWQmIm9mVfPu0lTsorAYywbe6kmlDQTVnT/sEUoSpAyBfE37ef+gazjoKdd
	NtaK0hN1swf/E1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23ACE13939;
	Fri,  7 Mar 2025 08:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ItCGB0qvymfANQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 07 Mar 2025 08:33:14 +0000
Date: Fri, 07 Mar 2025 09:33:13 +0100
Message-ID: <878qphjl4m.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.14-rc6
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41E69211D3
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.14-rc6 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc6

The topmost commit is 8463d2adbe1901247937fcdfe4b525130f6db10b

----------------------------------------------------------------

sound fixes for 6.14-rc6

There is a single change in ALSA core (for sequencer code for the
module auto-loading in a wrong timing) while the all rest are various
HD- and USB-audio fixes.  Many of them are boring device-specific
quirks, and should be safe to take.

----------------------------------------------------------------

Antheas Kapenekakis (2):
      ALSA: hda/realtek: Remove (revert) duplicate Ally X config
      ALSA: hda/realtek: Fix Asus Z13 2025 audio

Arnd Bergmann (1):
      ALSA: hda: realtek: fix incorrect IS_REACHABLE() usage

Daniel Bárta (1):
      ALSA: hda: Fix speakers on ASUS EXPERTBOOK P5405CSA 1.0

Hoku Ishibe (1):
      ALSA: hda: intel: Add Dell ALC3271 to power_save denylist

Kailang Yang (2):
      ALSA: hda/realtek - add supported Mic Mute LED for Lenovo platform
      ALSA: hda/realtek: update ALC222 depop optimize

Murad Masimov (1):
      ALSA: usx2y: validate nrpacks module parameter on probe

Stefan Binding (7):
      ALSA: hda/realtek: Add support for ASUS ROG Strix G814 Laptop using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS ROG Strix GA603 Laptops using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS ROG Strix G614 Laptops using CS35L41 HDA
      ALSA: hda/realtek: Add support for various ASUS Laptops using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS B3405 and B3605 Laptops using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS B5405 and B5605 Laptops using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS Zenbook UM3406KA Laptops using CS35L41 HDA

Takashi Iwai (1):
      ALSA: seq: Avoid module auto-load handling at event delivery

---
 sound/core/seq/seq_clientmgr.c  |  46 ++++++++++-----
 sound/pci/hda/Kconfig           |   1 +
 sound/pci/hda/hda_intel.c       |   2 +
 sound/pci/hda/patch_realtek.c   | 128 ++++++++++++++++++++++++++++++++++++----
 sound/usb/usx2y/usbusx2y.c      |  11 ++++
 sound/usb/usx2y/usbusx2y.h      |  26 ++++++++
 sound/usb/usx2y/usbusx2yaudio.c |  27 ---------
 7 files changed, 185 insertions(+), 56 deletions(-)


