Return-Path: <linux-kernel+bounces-537010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5EEA48708
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BA03B7715
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1991E834E;
	Thu, 27 Feb 2025 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="TmpSkyB0"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3121AC43A;
	Thu, 27 Feb 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678679; cv=none; b=dQaLAf7XxomlVM+Y3QxuiKDG3sIwturRTILaRpkHbeclg4eFoHN6804eECEEDhy8uyFGNZ03o0vA1DnaanbomN7hf5ETVDhDSYMW55J+e+rRamjX5UHwhO+008I+t4vBC+qP3T0QkBp+rTima0WXcv7WyO1AnyQywnfQIJsunH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678679; c=relaxed/simple;
	bh=Uu53v7OAZd9cxabebPTJCIgKi3GUnTCTvQ8bGTllcBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogqRr50J6GDDgfgPVzgrJZ/Ajm8ys1Tnl0noVYRksZcNsBf2IzkFKRzWuRg4dM2UltzOZoLDnSPlg2euGmYGDerJ5he7TGJXhIC3rOiRYoF9IFnQKmx8Gw9mE2vj7lNjWsAYAyNegazRQmgVb1KT+6Iq9RLKqIASCYYuTXoscE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=TmpSkyB0; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 8CB2C2E08F16;
	Thu, 27 Feb 2025 19:51:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740678673;
	bh=AJQ4Y3BRtnLTcKa09IOwGaYMDWWG5wbyuh+74vdzxWQ=; h=From:To:Subject;
	b=TmpSkyB04uVIcRvIWtg8qk/50NU82ei7XnTJfRISdr/ewl07lOaf0T+AxR1EvBYXk
	 36034Tzce6yabfxf3b7ff56E9mSKTz3Geu2oJ+VdzZ0FBnAFZgjtQtsJiXiwyUsHAs
	 3M7IsKiJABqDkBLjD+1FfUIh6RuOkHgyS6a1YWNk=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-sound@vger.kernel.org,
	kailang@realtek.com
Cc: linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	baojun.xu@ti.com,
	simont@opensource.cirrus.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 0/2] ALSA: hda/realtek: Sort Ally X properly,
 fix Asus Z13 2025 audio
Date: Thu, 27 Feb 2025 18:51:05 +0100
Message-ID: <20250227175107.33432-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174067867346.23193.5813168137912565692@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The Ally X has two quirks in the kernel currently. This is due to the
previous quirk not being sorted properly, whoopsies. Therefore, only one
has to stay. During AB testing, the configs were found to be close to
identical. Around 20 reboots later, it seems they feature a small pop
when at full volume on boot at an identical probability.

Then, add the Asus Z13 2025 quirk to the list. In the V1 of this series,
the Ally config was used, which (see above) is a bit ambitious. Testing
found that the stock quirk works just as well, so use that instead.

@Stefan: the Z13 is a big launch for Asus, could we do something to
expedite things just for this laptop? As far as Bazzite is concerned,
we shipped the stock quirk as of today, and included the firmware. This
is moreso for mainline distributions.

The Z13 was tested with the following firmware files:

sha256sum *
79cc046b2a1a89fd250dadfb47bdcb8a3c3d7df80452079f64e5417b237f4889  cs35l41-dsp1-spk-cali-10431fb3-l0.bin
3027249f8a340a8fb0034d67e5af8787789c83e9b3623664dab744668272b54e  cs35l41-dsp1-spk-cali-10431fb3-r0.bin
a8f3d1735c03383cd8567713e510034b0f98df0264fa7135e6e8186e0ea346de  cs35l41-dsp1-spk-prot-10431fb3-l0.bin
f0cdcf6d72bc591dec8a7bacba3ad8b46742207807c1e3c7787171de66e6f815  cs35l41-dsp1-spk-prot-10431fb3-r0.bin
e4e73d47203e0badc913b4a1317d48cb0e1b54d7d737f339148068f0cde34b16  cs35l41-dsp1-spk-prot-10431fb3.wmfw

Changelog since V1:
    - Revert Ally X config to use the stock quirk instead
    - Use a stock quirk for the Z13 too

Antheas Kapenekakis (2):
  ALSA: hda/realtek: Remove (revert) duplicate Ally X config
  ALSA: hda/realtek: Fix Asus Z13 2025 audio

 sound/pci/hda/patch_realtek.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

-- 
2.48.1


