Return-Path: <linux-kernel+bounces-529534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0714A42782
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C4E7A8DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB5D26389A;
	Mon, 24 Feb 2025 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="gxA+h4+3"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D3262D12;
	Mon, 24 Feb 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413432; cv=none; b=fy6Yu1pNg21xkeO3a4e2+jZnFnHadMIjR/4hVY+OFOKr8FkFuRD5GGwNSiBH0Tu2tWtk/6AM72FGuO9o0HMvMGMAp/tiU8hHPSXmawklXI5mtEaIEfbbW76AjLWH2kkQClUWkaKLazLQ/tWEPInnh3PoDatPwf1RTS01HIp7O8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413432; c=relaxed/simple;
	bh=yKdRvRo25o3ZEIn0yfQFVhloO1NAWCC042BvPmUkIGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDUAkOUV2F6pOpozE73Fy5hvq3aqHtQatznYOoyqKe6esjxWH97aW7+mdCG/+7AE+FPT9tLzVvq6C4dNSy/c/sRF4Rbi/XDT6IttCOuYka/qyfxxvaTTS4GWPtGp+oz2/8XFDQvqIQfYswaU+kCDI4qqR6gvMImr+Rro9F+5qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=gxA+h4+3; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3427D2E08D08;
	Mon, 24 Feb 2025 18:10:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740413420;
	bh=knz0cFd0SehN7PycYnbTICFDQLa0kOo8cNDOCmoF6Kk=; h=From:To:Subject;
	b=gxA+h4+3A30TLFAOtC048TKcJ2PJ7kdc4TSw4Wk/6ILn4rF7FfWHLXfzcjKK+nLDa
	 SvIXLRcxHDiJHthVLUBE+iN40aSmfYMvpIJUfvCi4wtehy48x0kNwhdujTetAvDbTv
	 L0sIN8RgYD8u9Ge9zcc0oJUjz4mdSSuq5MFFJ868=
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
Subject: [PATCH 0/2] ALSA: hda/realtek: Sort Ally X properly,
 fix Asus Z13 2025 audio
Date: Mon, 24 Feb 2025 17:10:14 +0100
Message-ID: <20250224161016.439696-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174041342012.22498.13092803084524339242@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The Ally X has two quirks in the kernel currently. This is due to the
previous quirk not being sorted properly, whoopsies. Therefore, only one
has to stay. During AB testing, I found that the Lenovo quirk makes a
popping sound during boot. Therefore the better quirk is the previous one.

This also mirrors our initial testing last August, where creating that
custom quirk fixed the popping sound over re-using the existing
Lenovo TAS quirk.

Then, add the Asus Z13 2025 quirk to the list. When looking into its dsdt
file, it was found to be identical to the original Ally. Therefore, borrow
its quirk. After using the quirk, sound works properly. However, the kernel
loads the default firmware for it, resulting in subpar sound quality.

After looking into the Windows driver files, the following files were
identified to be the correct ones for it:

Playback_6.83.0/Firmware/CS35L41/RevB2/halo_cspl_RAM_revB2_29.85.0.wmfw
tunings/ASUS_GZ302EA_10431FB3_241018/10431FB3_241018_V01_A0.bin
tunings/ASUS_GZ302EA_10431FB3_241018/10431FB3_241018_V01_A0_cal.bin
tunings/ASUS_GZ302EA_10431FB3_241018/10431FB3_241018_V01_A1.bin
tunings/ASUS_GZ302EA_10431FB3_241018/10431FB3_241018_V01_A1_cal.bin

Which the kernel expects to be named as:

cirrus/cs35l41-dsp1-spk-prot-10431fb3.wmfw
cirrus/cs35l41-dsp1-spk-prot-10431fb3-r0.bin
cirrus/cs35l41-dsp1-spk-prot-10431fb3-l0.bin
cirrus/cs35l41-dsp1-spk-cali-10431fb3-r0.bin
cirrus/cs35l41-dsp1-spk-cali-10431fb3-l0.bin

where A0 corresponds to r0.

Therefore, +cc Simon Trimmer who often uploads firmware for these devices.

Antheas Kapenekakis (2):
  ALSA: hda/realtek: Remove dup Ally X config
  ALSA: hda/realtek: Fix Asus Z13 2025 audio

 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.48.1


