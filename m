Return-Path: <linux-kernel+bounces-390260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAFA9B779E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0691C21F61
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60119341D;
	Thu, 31 Oct 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bYFuX0Af";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gkq2147k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bYFuX0Af";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gkq2147k"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DB197556;
	Thu, 31 Oct 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367294; cv=none; b=CoduAJNdAohzgrfwR+NPaoK+dBt84zWXSrSjg4R3ZCcCSRAi7C65oOmf67blFfSEcB9X3MJP4+9IMck4eRw3xFgG4Gv8k2KCX1GS2lZ7GvuplGGmkUqwKnmmDz3xhG++reh1sltqocjqX4FWDSXHCSOR3t6Q1EAE2txyYtGXs50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367294; c=relaxed/simple;
	bh=niiZTCgRtzfWSVRbWqD1/QkJo5ax0robeVdIJMAjaxE=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=q5tTVXD31i0MV5gyc+ZKZuiJxmBvOOAmuVp9GuxIQ1QpaXk7RwXo/EWczCISceMWNUWhUDHdr5W5xmQq3C1upbhV3BlQc56oFZr94ylIZKNjnlqrE1q0W4w2Q9Mekyew3SOhgAz0N0E16RxkM9VfXnj3mIKmPF50vkTh40O3GYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bYFuX0Af; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gkq2147k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bYFuX0Af; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gkq2147k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76A6F1F7D4;
	Thu, 31 Oct 2024 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730367290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7LQqGi+STaQS8efhJJrG9XShYj6w+9H2fAdBtqwECtI=;
	b=bYFuX0AfkEkr9XlUJSS0b6d7hHmtN85C2mzQc7/yhAjNSkX8CT1VBta/uf1oIWDma6UNg3
	XNXA5ScLVqNyDO48V/FFw+hdrQM09m2zQKLo/vf7U8SjVF6DeYLu3OqgiPOAfJdQbxgbz2
	agSclZHHaJJskBf38H726ieWwY3cJvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730367290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7LQqGi+STaQS8efhJJrG9XShYj6w+9H2fAdBtqwECtI=;
	b=gkq2147kiDhak+pIHRXaNvY5qTLuCzJowRjShbsLq7xH9jbNwTgmhZhmaESTJLsUR4LezR
	rKP6IVTiVHcmN1AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bYFuX0Af;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gkq2147k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730367290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7LQqGi+STaQS8efhJJrG9XShYj6w+9H2fAdBtqwECtI=;
	b=bYFuX0AfkEkr9XlUJSS0b6d7hHmtN85C2mzQc7/yhAjNSkX8CT1VBta/uf1oIWDma6UNg3
	XNXA5ScLVqNyDO48V/FFw+hdrQM09m2zQKLo/vf7U8SjVF6DeYLu3OqgiPOAfJdQbxgbz2
	agSclZHHaJJskBf38H726ieWwY3cJvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730367290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7LQqGi+STaQS8efhJJrG9XShYj6w+9H2fAdBtqwECtI=;
	b=gkq2147kiDhak+pIHRXaNvY5qTLuCzJowRjShbsLq7xH9jbNwTgmhZhmaESTJLsUR4LezR
	rKP6IVTiVHcmN1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C17C13A53;
	Thu, 31 Oct 2024 09:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ni8YETpPI2cVLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Oct 2024 09:34:50 +0000
Date: Thu, 31 Oct 2024 10:35:54 +0100
Message-ID: <87ldy4wr5x.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.12-rc6
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76A6F1F7D4
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.12-rc6 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc6

The topmost commit is e49370d769e71456db3fbd982e95bab8c69f73e8

----------------------------------------------------------------

sound fixes for 6.12-rc6

Here we see slightly more commits than wished, but basically all are
small and mostly trivial fixes.  The only core change is the
workaround for __counted_by() usage in ASoC DAPM code, while the rest
are device-specific fixes for Intel Baytrail devices, Cirrus and
wcd937x codecs, and HD-audio / USB-audio devices.

----------------------------------------------------------------

Aleksei Vetrov (1):
      ASoC: dapm: fix bounds checker error in dapm_widget_list_create

Alexey Klimov (2):
      ASoC: codecs: wcd937x: add missing LO Switch control
      ASoC: codecs: wcd937x: relax the AUX PDM watchdog

Christoffer Sandberg (2):
      ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3
      ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1

Christophe JAILLET (1):
      ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()

Dmitry Yashin (1):
      ASoC: dt-bindings: rockchip,rk3308-codec: add port property

Hans de Goede (5):
      ASoC: codecs: rt5640: Always disable IRQs from rt5640_cancel_work()
      ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet
      ASoC: Intel: sst: Support LPE0F28 ACPI HID
      ASoC: Intel: sst: Fix used of uninitialized ctx to log an error

Jan Schär (1):
      ALSA: usb-audio: Add quirks for Dell WD19 dock

Kailang Yang (1):
      ALSA: hda/realtek: Limit internal Mic boost on Dell platform

Piyush Raj Chouhan (1):
      ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13

---
 .../bindings/sound/rockchip,rk3308-codec.yaml      |  4 ++
 sound/hda/intel-dsp-config.c                       |  4 ++
 sound/pci/hda/patch_realtek.c                      | 35 +++++++++++-
 sound/soc/codecs/cs42l51.c                         |  7 ++-
 sound/soc/codecs/rt5640.c                          | 27 +++++----
 sound/soc/codecs/wcd937x.c                         | 12 +++-
 sound/soc/codecs/wcd937x.h                         |  4 ++
 sound/soc/intel/atom/sst/sst_acpi.c                | 64 +++++++++++++++++++---
 sound/soc/intel/boards/bytcr_rt5640.c              | 48 +++++++++++++++-
 sound/soc/soc-dapm.c                               |  2 +
 sound/usb/mixer_quirks.c                           |  3 +
 11 files changed, 179 insertions(+), 31 deletions(-)


