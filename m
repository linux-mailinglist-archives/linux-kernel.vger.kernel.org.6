Return-Path: <linux-kernel+bounces-369976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE69A2521
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7786CB27A18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B391DE8B1;
	Thu, 17 Oct 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RpZJB1EN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ucpTSItd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RpZJB1EN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ucpTSItd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E71DE4EE;
	Thu, 17 Oct 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175553; cv=none; b=EiO5GTHXtWAqeF4no1Sr7XW2pcVWIRxaLHiJn3Gm4QVvUEf/HLzT44DJD2ph8vw8Arynp5gb2w009BHVvidXlBcmlZIAbO5+eM7ZoOd0ZN0kzi6G+V8rFptb2bJGylaGFgKatLUv4zvDPgCvWZanjYuUVLQn0QA/b71zQngC/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175553; c=relaxed/simple;
	bh=4QSAetL/CWQZmcwa/BoS4/rSRNkHh2T80YBu17/HB4o=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=D6CAg1uLuisSjp9TFp+uX709wk9uMiQK5lmskmYjPJ/rfAZez3Hoh3iXQkJ1MXSnj/hFznVRgmfYAK1uP8ZEVo75tLBRbz5MX9SYCgpeYTiCUgdQLfNEvUz6jVw0Ovw4whYewfVPG2Aw43W/qSRluFCJG29emjHEHRNc+EZtgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RpZJB1EN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ucpTSItd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RpZJB1EN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ucpTSItd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7512F21E97;
	Thu, 17 Oct 2024 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729175549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uwSWX3ymcZ6sdX0IWkECsPOSUUYKhvHIUeePSrS5P+U=;
	b=RpZJB1ENQhQ5GzCbhATGtCXQuHv2dZQ+8Z505690c4BRkZU/gIVYN1mcXV9Kr4pYg7pi9K
	SmJKQ3324qqKN36V54R5TcPl/E41CtqNfoZJRjB9Vi4V8ltI0AJUT372teQrV/jd3KjVfP
	WRFCFdo40eUdklt6tA6HzU57jLGW5fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729175549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uwSWX3ymcZ6sdX0IWkECsPOSUUYKhvHIUeePSrS5P+U=;
	b=ucpTSItdgNbMzKDuWKqReufzDOdUq0Kc13B8EsUkj6RIdK4WYgud3bDte4HUQ1QwttKvS+
	DC0/JRZXTjEAPACw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RpZJB1EN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ucpTSItd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729175549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uwSWX3ymcZ6sdX0IWkECsPOSUUYKhvHIUeePSrS5P+U=;
	b=RpZJB1ENQhQ5GzCbhATGtCXQuHv2dZQ+8Z505690c4BRkZU/gIVYN1mcXV9Kr4pYg7pi9K
	SmJKQ3324qqKN36V54R5TcPl/E41CtqNfoZJRjB9Vi4V8ltI0AJUT372teQrV/jd3KjVfP
	WRFCFdo40eUdklt6tA6HzU57jLGW5fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729175549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uwSWX3ymcZ6sdX0IWkECsPOSUUYKhvHIUeePSrS5P+U=;
	b=ucpTSItdgNbMzKDuWKqReufzDOdUq0Kc13B8EsUkj6RIdK4WYgud3bDte4HUQ1QwttKvS+
	DC0/JRZXTjEAPACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 535DA13A42;
	Thu, 17 Oct 2024 14:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4mEWE/0fEWcQKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 17 Oct 2024 14:32:29 +0000
Date: Thu, 17 Oct 2024 16:33:28 +0200
Message-ID: <87o73ire87.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.12-rc4
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 7512F21E97
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.12-rc4 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc4

The topmost commit is 164cd0e077a18d6208523c82b102c98c77fdd51f

----------------------------------------------------------------

sound fixes for 6.12-rc4

A collection of small fixes, nothing really stands out.

- Usual HD-audio quirks / device-specific fixes
- Kconfig dependency fix for UM
- A series of minor fixes for SoundWire
- Updates of USB-audio LINE6 contact address

----------------------------------------------------------------

Baojun Xu (1):
      ALSA: hda/tas2781: Add new quirk for Lenovo, ASUS, Dell projects

Julian Vetter (1):
      sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

Karol Kosik (1):
      ALSA: usb-audio: Fix NULL pointer deref in snd_usb_power_domain_set()

Markus Grabner (1):
      ALSA: line6: update contact information

Murad Masimov (1):
      ALSA: hda/cs8409: Fix possible NULL dereference

Pierre-Louis Bossart (4):
      ALSA/hda: intel-sdw-acpi: cleanup sdw_intel_scan_controller
      ALSA/hda: intel-sdw-acpi: fetch fwnode once in sdw_intel_scan_controller()
      ALSA/hda: intel-sdw-acpi: simplify sdw-master-count property read
      ALSA/hda: intel-sdw-acpi: add support for sdw-manager-list property read

Vasiliy Kovalev (2):
      ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2
      ALSA: hda/conexant - Use cached pin control for Node 0x1d on HP EliteOne 1000 G2

Zhu Jun (1):
      ALSA: scarlett2: Add error check after retrieving PEQ filter values

christoph.plattner (1):
      ALSA: hda: Sound support for HP Spectre x360 16 inch model 2024

---
 include/linux/soundwire/sdw_intel.h |  2 +-
 sound/Kconfig                       |  2 +-
 sound/hda/intel-sdw-acpi.c          | 33 ++++++++++------
 sound/pci/hda/patch_conexant.c      | 19 +++++++++
 sound/pci/hda/patch_cs8409.c        |  5 ++-
 sound/pci/hda/patch_realtek.c       | 79 ++++++++++++++++++++++++++++++++++++-
 sound/usb/line6/capture.c           |  2 +-
 sound/usb/line6/capture.h           |  2 +-
 sound/usb/line6/driver.c            |  4 +-
 sound/usb/line6/driver.h            |  2 +-
 sound/usb/line6/midi.c              |  2 +-
 sound/usb/line6/midi.h              |  2 +-
 sound/usb/line6/midibuf.c           |  2 +-
 sound/usb/line6/midibuf.h           |  2 +-
 sound/usb/line6/pcm.c               |  2 +-
 sound/usb/line6/pcm.h               |  2 +-
 sound/usb/line6/playback.c          |  2 +-
 sound/usb/line6/playback.h          |  2 +-
 sound/usb/line6/pod.c               |  2 +-
 sound/usb/line6/toneport.c          |  2 +-
 sound/usb/line6/variax.c            |  2 +-
 sound/usb/mixer_scarlett2.c         |  2 +
 sound/usb/stream.c                  |  1 +
 23 files changed, 143 insertions(+), 32 deletions(-)


