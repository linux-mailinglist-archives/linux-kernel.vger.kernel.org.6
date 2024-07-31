Return-Path: <linux-kernel+bounces-269213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF53942F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F2B1C23C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E11B1512;
	Wed, 31 Jul 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bv3O0K/l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2tgdtPZw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bv3O0K/l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2tgdtPZw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF41B1431;
	Wed, 31 Jul 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430349; cv=none; b=FKdxzVPOow7hxVxkXitej4eoW9JcJeLwQrCO42X10qzHl3ll8qcHVNAu/6MiXEcV1AVl5NuWxcSjuImZEoZtJca8JptjRAAka1th5vmmRRmN9bmTBv6+uDeTSUkwVmFoD3/bc0h/tdRFAhR+m88WnHYFDYI3EGOgHBuKaQKpa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430349; c=relaxed/simple;
	bh=EWSs4ESQrNUGVHtURl0k/psPXi2SM9fwu4kwf9pH6Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Im3Gafe2yzzfmM1rXbhvjmKuxNcFbkT2oAWpS/IhX7qjg3nhW8s4aUvJzc6gTMC+qigPIRtZVyZDg6bXLqcsMsHY7Tb+Q9TwJG5+YxIAIQOzxIuHpQ3tlkZHl2GDvK5sY06DOpPZIDqc3yFe6IrbrNcH42UNcFodjvZYJrdJew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bv3O0K/l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2tgdtPZw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bv3O0K/l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2tgdtPZw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0647021A8D;
	Wed, 31 Jul 2024 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mIoaakNEAhse1HlIYZVpVrnhdHBWu0hbeyhiNEyb4sM=;
	b=Bv3O0K/lqUmXpPOa1j/uZfjCAh/zYKbD8IWY6k1oEQRnY9lxT1lNbPjpsAd6HS6PSzlVt6
	+6TubWNzK0cHNFxqrIASK3RIvWITMYgQ85QeQ6WuSgdetr3HFDuPQXhUZ/iSAlms9tXCNd
	xvtKohXt597PAM9OUlAt72Ua4Hm7nGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mIoaakNEAhse1HlIYZVpVrnhdHBWu0hbeyhiNEyb4sM=;
	b=2tgdtPZwoo9TYPOSqRQb4Ev251ueK8yPwJx8OffxQYNqgoyp/Fp2QMhMKIiEvt4/CGxI1Q
	UwMYncaAvTni08CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Bv3O0K/l";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2tgdtPZw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mIoaakNEAhse1HlIYZVpVrnhdHBWu0hbeyhiNEyb4sM=;
	b=Bv3O0K/lqUmXpPOa1j/uZfjCAh/zYKbD8IWY6k1oEQRnY9lxT1lNbPjpsAd6HS6PSzlVt6
	+6TubWNzK0cHNFxqrIASK3RIvWITMYgQ85QeQ6WuSgdetr3HFDuPQXhUZ/iSAlms9tXCNd
	xvtKohXt597PAM9OUlAt72Ua4Hm7nGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mIoaakNEAhse1HlIYZVpVrnhdHBWu0hbeyhiNEyb4sM=;
	b=2tgdtPZwoo9TYPOSqRQb4Ev251ueK8yPwJx8OffxQYNqgoyp/Fp2QMhMKIiEvt4/CGxI1Q
	UwMYncaAvTni08CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB3F413297;
	Wed, 31 Jul 2024 12:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nk2mL4gzqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/10] platform: x86: Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:50 +0200
Message-ID: <20240731125220.1147348-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.31 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.31
X-Rspamd-Queue-Id: 0647021A8D

Commit a1cacb8a8e70 ("backlight: Add BACKLIGHT_POWER_ constants for
power states") introduced dedicated constants for backlight power states.
Convert X86 platform drivers to the new constants.

The new constants replace the fbdev constants. This is part of a larger
effort to make kernel subsystems more independent from fbdev code and
headers.

Thomas Zimmermann (10):
  platform/x86: acer-wmi:  Use backlight power constants
  platform/x86: asus-laptop: Use backlight power constants
  platform/x86: asus-nb-wmi: Use backlight power constants
  platform/x86: asus-wmi: Use backlight power constants
  platform/x86: eeepc-laptop: Use backlight power constants
  platform/x86: eeepc-wmi: Use backlight power constants
  platform/x86: fujitsu-laptop: Use backlight power constants
  platform/x86: ideapad-laptop: Use backlight power constants
  platform/x86: oaktrail: Use backlight power constants
  platform/x86: samsung-laptop: Use backlight power constants

 drivers/platform/x86/acer-wmi.c       |  3 +--
 drivers/platform/x86/asus-laptop.c    |  3 +--
 drivers/platform/x86/asus-nb-wmi.c    |  4 ++--
 drivers/platform/x86/asus-wmi.c       | 17 ++++++++---------
 drivers/platform/x86/eeepc-laptop.c   |  3 +--
 drivers/platform/x86/eeepc-wmi.c      |  4 ++--
 drivers/platform/x86/fujitsu-laptop.c |  9 ++++-----
 drivers/platform/x86/ideapad-laptop.c |  7 +++----
 drivers/platform/x86/intel/oaktrail.c |  3 +--
 drivers/platform/x86/samsung-laptop.c |  5 ++---
 10 files changed, 25 insertions(+), 33 deletions(-)

-- 
2.45.2


