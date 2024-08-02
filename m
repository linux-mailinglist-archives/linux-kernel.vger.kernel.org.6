Return-Path: <linux-kernel+bounces-272291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6D9459B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D306B22C7B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0611BF31B;
	Fri,  2 Aug 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MR+ZOD2a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pEKRmw+H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MR+ZOD2a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pEKRmw+H"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D81C2320;
	Fri,  2 Aug 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586512; cv=none; b=t9CktgWYx/PZ4+7LJTnR4B0BU8HNPICMQYyD2VSmLaJ6vSHgiI0uX4RA0wQ6Sj0f8jZeFcHGuq1e1sxZrUhKcmWwLmNdsIWh+h8Akafpzz2HgpQYVIF3q8HUvOPy1m1Z6FP/94puVlPR5AEsQjvzz9RU2JEwB52Qgxb7g9NcCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586512; c=relaxed/simple;
	bh=rUGiqUtkECcedRY5gwuInYiGisG6BkiiZ+WexGU1ij8=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=JyArih5GPsGgJwL91SMjx4NmKI4qgm8Czofde7nsLEU+0XcF+cHODLh7fK+H9GWdT7M0h+7wLnwRykKj+oTkHHoxZ08agcKyvy062B4kDT5jBBox+LVpZgNnr6qSo3NWe6MigW0TMaSKOWa7XIP0Bd7hYIUsEiExVZbTtNEBxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MR+ZOD2a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pEKRmw+H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MR+ZOD2a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pEKRmw+H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 088871FB9E;
	Fri,  2 Aug 2024 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722586509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=YV5OCMwPGyXDbLzuHRb5lov1nuB0wNv3q6FJUz4/JA0=;
	b=MR+ZOD2a/ikY3Owc0OOSG7p0n2BGm8WTZh6hq9TzfizVno/uTwVuhOs76R8VoXKjis848a
	c5WX0rUDqlSOhA1HBkSpiowgm378jgfZ9mBNkiIFBXxUmMhzwHnEhAclcYOTTtPsSt8IPF
	aXZl474SCvc/lmFfKZmAQjSGGwNz2JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722586509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=YV5OCMwPGyXDbLzuHRb5lov1nuB0wNv3q6FJUz4/JA0=;
	b=pEKRmw+HnV7qr9DSBhVf64mmB5Oa2zQlZ8KxGO7SFSUeGSXGizsmCRV1bLx+zjMRa+JN6L
	IDje03qVyqUgCPDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722586509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=YV5OCMwPGyXDbLzuHRb5lov1nuB0wNv3q6FJUz4/JA0=;
	b=MR+ZOD2a/ikY3Owc0OOSG7p0n2BGm8WTZh6hq9TzfizVno/uTwVuhOs76R8VoXKjis848a
	c5WX0rUDqlSOhA1HBkSpiowgm378jgfZ9mBNkiIFBXxUmMhzwHnEhAclcYOTTtPsSt8IPF
	aXZl474SCvc/lmFfKZmAQjSGGwNz2JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722586509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=YV5OCMwPGyXDbLzuHRb5lov1nuB0wNv3q6FJUz4/JA0=;
	b=pEKRmw+HnV7qr9DSBhVf64mmB5Oa2zQlZ8KxGO7SFSUeGSXGizsmCRV1bLx+zjMRa+JN6L
	IDje03qVyqUgCPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9CCB1388E;
	Fri,  2 Aug 2024 08:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eHNmM4yVrGahEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Aug 2024 08:15:08 +0000
Date: Fri, 02 Aug 2024 10:15:45 +0200
Message-ID: <87a5hvibm6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux
   Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.12-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

Linus,

please pull sound fixes for v6.11-rc2 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc2

The topmost commit is 478689b5990deb626a0b3f1ebf165979914d6be4

----------------------------------------------------------------

sound fixes for 6.11-rc2

A small collection of fixes:
- Revert of FireWire changes that caused a long-time regression
- Another long-time regression fix for AMD HDMI
- MIDI2 UMP fixes
- HD-audio Conexant codec fixes and a qurik

----------------------------------------------------------------

Edmund Raile (2):
      Revert "ALSA: firewire-lib: obsolete workqueue for period update"
      Revert "ALSA: firewire-lib: operate for period elapse event in process context"

Mavroudis Chatzilazaridis (1):
      ALSA: hda/realtek: Add quirk for Acer Aspire E5-574G

Takashi Iwai (10):
      ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown
      ALSA: hda/conexant: Mute speakers at suspend / shutdown
      ALSA: seq: ump: Optimize conversions from SysEx to UMP
      ALSA: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
      ALSA: ump: Explicitly reset RPN with Null RPN
      ALSA: seq: ump: Use the common RPN/bank conversion context
      ALSA: seq: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
      ALSA: seq: ump: Explicitly reset RPN with Null RPN
      ALSA: usb-audio: Correct surround channels in UAC1 channel map
      ALSA: hda: Conditionally use snooping for AMD HDMI

songxiebing (1):
      ALSA: hda: conexant: Fix headset auto detect fail in the polling mode

---
 include/sound/ump_convert.h      |   1 +
 sound/core/seq/seq_ports.h       |  14 +---
 sound/core/seq/seq_ump_convert.c | 138 ++++++++++++++++++++++++---------------
 sound/core/ump_convert.c         |  60 ++++++++++++-----
 sound/firewire/amdtp-stream.c    |  38 +++++++----
 sound/firewire/amdtp-stream.h    |   1 +
 sound/pci/hda/hda_controller.h   |   2 +-
 sound/pci/hda/hda_generic.c      |  63 ++++++++++++++++++
 sound/pci/hda/hda_generic.h      |   1 +
 sound/pci/hda/hda_intel.c        |  10 ++-
 sound/pci/hda/patch_conexant.c   |  56 ++++------------
 sound/pci/hda/patch_realtek.c    |   1 +
 sound/usb/stream.c               |   4 +-
 13 files changed, 244 insertions(+), 145 deletions(-)


