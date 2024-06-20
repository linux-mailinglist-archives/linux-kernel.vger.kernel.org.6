Return-Path: <linux-kernel+bounces-222684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AA39105A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F8CB24795
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA701ACE92;
	Thu, 20 Jun 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dHkZmwvI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4DdG9AM3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QY3b5NXc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7U27d2ZZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A31E49E;
	Thu, 20 Jun 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889490; cv=none; b=WKAKqadCCrpjOo/VTa+/8qnEt7TvxEOiBXVNHa7tOhJcmXrQRCeFT0/pJ245hGWTyV1caM4XGCAQDfRD0q5W88iCW+N1bbJsQ0ONUgF86FE+WWAfBGjP4bB1KC+3mHd+HAZ9YMwZFOmKOP41qMHwOYu+jXiQshjQONhIaSQARnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889490; c=relaxed/simple;
	bh=0VoUrdir8gdv7EgPqFTfzmhTTsZMwRBiZVMv9XQRydQ=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=eKwXk9DpIMvc+pzvnMGS+6pXLY0LLSBYC5gwBXA2SSIBW5bjxVTz+CeQ2DkwUox33DujSVVZ6LonkA4wkyomTtJ7a75remkobnqHb151bkbKrakRH6WsPKus69HU2j3A01gpddzHo1Nd5G+6Ec0JAB4J1hkh0GnfuqxrMpjOGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dHkZmwvI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4DdG9AM3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QY3b5NXc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7U27d2ZZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C919C21A82;
	Thu, 20 Jun 2024 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718889487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UBueZNwNCBqucrpmUNNm9cwxIcT/Z5gLqiEY6hNCWao=;
	b=dHkZmwvIbf37AcxNwLtt4VRwgq/mSzEuCWsCxbSjc+BCKrfmAfzAeX0hJKetx2BY/1VWzO
	/lheimhIu1lomCv3xOCYYSS8TH16V9eL5A82V4HmMK2qv/5EswESic/vi4tHTZHajR0e0l
	yE/mfGhq3S20EyVFWI4kQHCCwqQjvQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718889487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UBueZNwNCBqucrpmUNNm9cwxIcT/Z5gLqiEY6hNCWao=;
	b=4DdG9AM3o/gnAMIosKtufCzjURXeMDB96+dyEmBisvdtxae8sqC1QNTPiItZ3v5PsG9+nX
	/CxMjqWYkD9XS6Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QY3b5NXc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7U27d2ZZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718889485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UBueZNwNCBqucrpmUNNm9cwxIcT/Z5gLqiEY6hNCWao=;
	b=QY3b5NXcdCSIktudFN6YnhoLChIsFYODhAMnAdCW+BQBCfDUVmLFQPoIJ/pEfnnzMUeNSw
	/+rYZ3h9CM/1GCeiNbU8wcqBbBK2hapFHxOPIXonnbpxSqp1y++AKyBsouLphoYhsRhTPk
	b0zLfKFSKeTt8H7DONJ2MMggFpRmeVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718889485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UBueZNwNCBqucrpmUNNm9cwxIcT/Z5gLqiEY6hNCWao=;
	b=7U27d2ZZ0M4aB3nfQkVvEqZ3I8/cbQrWxUdwRPhufUrLsp7pwieVVmww2fTC9XBv2FFdCq
	P1332A5Wb1LawiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA6581369F;
	Thu, 20 Jun 2024 13:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U55XKA0sdGYmRwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Jun 2024 13:18:05 +0000
Date: Thu, 20 Jun 2024 15:18:31 +0200
Message-ID: <87jzij21nc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.10-rc5
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C919C21A82
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Linus,

please pull sound fixes for v6.10-rc5 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc5

The topmost commit is 9b1effff19cdf2230d3ecb07ff4038a0da32e9cc

----------------------------------------------------------------

sound fixes for 6.10-rc5

Lots of small HD-audio quirks and fixes (mostly Realtek codec and
Cirrus stuff).  Also a small MIDI 2.0 fix and a fix for missing
module description are included.

----------------------------------------------------------------

Ajrat Makhmutov (1):
      ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 445/465 G11.

Dustin L. Howett (1):
      ALSA: hda/realtek: Remove Framework Laptop 16 from quirks

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on N14AP7

Gergely Meszaros (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14ARP8

Jeff Johnson (1):
      sound/oss/dmasound: add missing MODULE_DESCRIPTION() macro

Kailang Yang (1):
      ALSA: hda/realtek: Add more codec ID to no shutup pins list

Peter Ujfalusi (1):
      ALSA/hda: intel-dsp-config: Document AVS as dsp_driver option

Simon Trimmer (6):
      ALSA: hda: cs35l56: Fix lifecycle of codec pointer
      ALSA: hda: cs35l41: Possible null pointer dereference in cs35l41_hda_unbind()
      ALSA: hda: cs35l56: Component should be unbound before deconstruction
      ALSA: hda: cs35l41: Component should be unbound before deconstruction
      ALSA: hda: tas2781: Component should be unbound before deconstruction
      ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE

Stefan Binding (4):
      ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P Gen 5
      ALSA: hda: cs35l41: Support Lenovo Thinkbook 13x Gen 4
      ALSA: hda/realtek: Support Lenovo Thinkbook 16P Gen 5
      ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 4

Takashi Iwai (1):
      ALSA: seq: ump: Fix missing System Reset message handling

---
 sound/core/seq/seq_ump_convert.c     |  2 ++
 sound/hda/intel-dsp-config.c         |  2 +-
 sound/oss/dmasound/dmasound_core.c   |  1 +
 sound/pci/hda/Kconfig                |  2 ++
 sound/pci/hda/cs35l41_hda.c          |  6 +++---
 sound/pci/hda/cs35l41_hda_property.c |  8 ++++++++
 sound/pci/hda/cs35l56_hda.c          |  9 +++++++--
 sound/pci/hda/patch_realtek.c        | 38 +++++++++++++++++++++++++++++++++---
 sound/pci/hda/tas2781_hda_i2c.c      |  4 ++--
 9 files changed, 61 insertions(+), 11 deletions(-)


