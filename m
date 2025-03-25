Return-Path: <linux-kernel+bounces-576161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82FEA70BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D381888AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC5263F32;
	Tue, 25 Mar 2025 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="K49ym7Ia"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878413D531;
	Tue, 25 Mar 2025 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936563; cv=none; b=WLVNI5NGqzZfsdqNEykCYE6GdoPwCeu4b3gRGBcYyGa1Au2w67Zo4Gg0zGsdEfuCYfHsxH3nGk5frIJXL8c5D/JyIqmNhMmZziLXQe3XQe0NSMpzcpWSmIM9EcbFDxOD5N6uYKfpL3xoUZXPGGSmP1L73Iy+U6KERBEgsk/TD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936563; c=relaxed/simple;
	bh=Fgr1wy7naKHZZ8CbRUiRNWUNfhs4P9coPflLQ33fEJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlM45Y6Ha81l9O2H7USNlO+u0gyxW3WRgoaoB+2b2bdHCFQPOxdr/GpSwEfIhHfHeG1/seN7oli115e08kPcCLSPIj57yxrAE/KJycQ/6Efoj2tR1iNGWHEcJ/W7BV4gKzISWTXpzSpKrRymAblN2pu4bjnpcnmPPFYTCkwnE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=K49ym7Ia; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Juys6g7S7/Vmvszi1JHSXEku5SuN5AmPrSu1+judTM0=; b=K49ym7IaAHGF+H1cqHKkQ+MySI
	xH8hBxW8heALD1/fCrLu8DBLvoLu/v2N4OKGeX1UGG6+/3AhUypxlO+G0SAQbpt0YWBYz1pwyLfOh
	GabLHEpY1VmfmuB9POMevRe7GdQjc+Gchpm74u6PovoZ5R7QR1kinTpHZzV1hSUuUZfkGDx6EW/eg
	XhURA5I0Mru/lBqjzv63U43BpVc35LvX2OheZ2YhgOxpuwxfGqwZBlbfb/Lv3oPAyN+0SlahQDDwq
	vsx2U5h+OBrlH3a8uvuyflgN/b3VUJ4yuIuha+7ezlGtWLYcxZQFeUhpDwYPG5nRnzO0SOOlTJoUd
	AhimLlBg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1txBPv-0044SN-Uk; Tue, 25 Mar 2025 21:02:37 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 12F5FBE2EE7; Tue, 25 Mar 2025 22:02:35 +0100 (CET)
Date: Tue, 25 Mar 2025 22:02:35 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: 1100928@bugs.debian.org,
	"C.D. MacEachern" <craig.daniel.maceachern@gmail.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Bug#1100928: [regression 6.1.y] microphone no longer records (on
 VivoBook_ASUSLaptop TP401MARB_J401MA)
Message-ID: <Z-MZ6yu6oPDw9lkL@eldamar.lan>
References: <174248253267.1718.4037292692790831697.reportbug@x>
 <174248253267.1718.4037292692790831697.reportbug@x>
 <Z95s5T6OXFPjRnKf@eldamar.lan>
 <174248253267.1718.4037292692790831697.reportbug@x>
 <Z-MMsp3XJyNHOlma@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tHN/tPwNKfLebtX9"
Content-Disposition: inline
In-Reply-To: <Z-MMsp3XJyNHOlma@eldamar.lan>
X-Debian-User: carnil


--tHN/tPwNKfLebtX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Mar 25, 2025 at 09:06:10PM +0100, Salvatore Bonaccorso wrote:
> Hi Craig, all
> 
> On Sat, Mar 22, 2025 at 08:55:17AM +0100, Salvatore Bonaccorso wrote:
> > Control: tags -1 + moreinfo upstream
> > 
> > Hi
> > 
> > On Thu, Mar 20, 2025 at 10:55:32AM -0400, C.D. MacEachern wrote:
> > > Package: src:linux
> > > Version: 6.1.129-1
> > > Severity: important
> > > X-Debbugs-Cc: craig.daniel.maceachern@gmail.com
> > > 
> > > Dear Maintainer,
> > > 
> > > After update to kernel image 6.1.0-32 on Debian bookworm my builtin microphone
> > > would no longer record
> > > anything - no levels detected and I checked for muted channels with tools like
> > > pavucontrol and alsamixer.
> > > 
> > > I found that my microphone was using the `snd_hda_intel` driver in the kernel,
> > > so tried rebooting and choosing
> > > the 6.1.0-31 kernel instead to rule out hardware issue. Previous kernel works
> > > as expected, mic records and playback
> > > is fine, so some update related to this driver, or the driver itself was
> > > updated and no longer works correctly with
> > > the builtin microphone.
> > 
> > Thanks for reproting the issue (leaving boot log context, hw used,
> > below for context).
> > 
> > I think this might be introduced with 3b4309546b48 ("ALSA: hda: Fix
> > headset detection failure due to unstable sort") wich landed as well
> > in 6.1.129.
> > 
> > If you revert that commit on top of 6.1.129, does that fixes your
> > issue? Would you be able to test this?
> > 
> > #regzbot introduced: v6.1.128..v6.1.129
> > #regzbot link: https://bugs.debian.org/1100928
> > 
> > The solution might be similar to c6557ccf8094 ("ALSA: hda/realtek: Fix
> > microphone regression on ASUS N705UD") from 6.14-rc5 (which got
> > backported to 6.13.6, 6.12.18, 6.6.81 but not yet 6.1.y).
> 
> In case you need help in trying a kernel build with the revet applied,
> I'm attaching the revert patch. With that you can follow
> https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#id-1.6.6.4
> to build a kernel using the `test-patches` helper script to test with.
> 
> Is that enough help so we can confirm the breaking commit?

And now really with the patch attached.

Regards,
Salvatore

--tHN/tPwNKfLebtX9
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Revert-ALSA-hda-Fix-headset-detection-failure-due-to.patch"

From 99eeccf9207811eb07986f441020b61beffa759b Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Tue, 25 Mar 2025 21:02:57 +0100
Subject: [PATCH] Revert "ALSA: hda: Fix headset detection failure due to
 unstable sort"

This reverts commit 3b4309546b48fc167aa615a2d881a09c0a97971f.
---
 sound/pci/hda/hda_auto_parser.c | 8 +-------
 sound/pci/hda/hda_auto_parser.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 58b2e25c448e..7c6b1fe8dfcc 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -80,11 +80,7 @@ static int compare_input_type(const void *ap, const void *bp)
 
 	/* In case one has boost and the other one has not,
 	   pick the one with boost first. */
-	if (a->has_boost_on_pin != b->has_boost_on_pin)
-		return (int)(b->has_boost_on_pin - a->has_boost_on_pin);
-
-	/* Keep the original order */
-	return a->order - b->order;
+	return (int)(b->has_boost_on_pin - a->has_boost_on_pin);
 }
 
 /* Reorder the surround channels
@@ -404,8 +400,6 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 	reorder_outputs(cfg->speaker_outs, cfg->speaker_pins);
 
 	/* sort inputs in the order of AUTO_PIN_* type */
-	for (i = 0; i < cfg->num_inputs; i++)
-		cfg->inputs[i].order = i;
 	sort(cfg->inputs, cfg->num_inputs, sizeof(cfg->inputs[0]),
 	     compare_input_type, NULL);
 
diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index 8bb8202cf284..df63d66af1ab 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -35,7 +35,6 @@ struct auto_pin_cfg_item {
 	unsigned int is_headset_mic:1;
 	unsigned int is_headphone_mic:1; /* Mic-only in headphone jack */
 	unsigned int has_boost_on_pin:1;
-	int order;
 };
 
 struct auto_pin_cfg;
-- 
2.49.0


--tHN/tPwNKfLebtX9--

