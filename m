Return-Path: <linux-kernel+bounces-310408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B28967C59
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 23:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1604A1F21757
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F7C185B49;
	Sun,  1 Sep 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="r9KKKGI5"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D1953E22;
	Sun,  1 Sep 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725226758; cv=none; b=cQEhGNIj9e1tlSydphe1Y6jdvulkH0lyWJD7sk6q1M/QgyBgzLizj0MgUSDHDxaoZxF4tTxc8AlhmQp5FyKwrE7POL6v+oAJWWqMA4NKTPfvlB/6kf6EYKclcOUBBUyBS/mCInir62Hrqpk80LpIWsDciJ3pqyJrGSFqrFGh3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725226758; c=relaxed/simple;
	bh=9005hIvO0B3tQdTeJlc1RChOBA6FhZL33VJhjP5iEn0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tkikdZD/5Zg1mEqNSSAH1y1ThP6YLme5wN6NiCJWTXloVZgXrbJB3z+UWjsg1uYI2cEUiL60+mlYP+ZVEEhDB/YW8x9fWHQfzrgLrcWdeci2/bnjVdUvpKn4y14p/nSu8nM+HRvCysfLBFvLxW1nTmoD2F+8twJOIlDEVktqTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=r9KKKGI5; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id C4B7243F13;
	Sun,  1 Sep 2024 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1725226325;
	bh=9005hIvO0B3tQdTeJlc1RChOBA6FhZL33VJhjP5iEn0=;
	h=From:Subject:Date:To:Cc;
	b=r9KKKGI5k9UVV4mh1TbuNVrqC1IyNPTtP2TyhJgeocJct6a9kdgrZ+TZvq7B15+im
	 ulfaWjwW2paCZRDF1zXC2oKKzY5+XtvpWNi6yCeFwEyJx8eb27XEs6OSPMn4bUFqqA
	 PphkWfZJ0Zgx7/nAvDBnJYK95NSFT6X2JKHAFKB5Ksj+YvrLP15gcmBjC99n2K6Gwn
	 EpiXTPlTLsT1sallqbXWhsO/p1VaaOv2CjVGa0hqL9jd9iFQ++WY0OkmeXAi/UWap7
	 4Xb1f6T9ssiGoPexCsQ1vZuLNb41K9XsdvWoAetw4PuG6BLxG1ORWxO8LO5YZgrpHT
	 YzoyTR754TJTA==
From: Asahi Lina <lina@asahilina.net>
Subject: [PATCH 0/2] ALSA: usb-audio: Add basic support for RME Digiface
 USB
Date: Mon, 02 Sep 2024 06:31:49 +0900
Message-Id: <20240902-rme-digiface-v1-0-6e88472a2744@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXd1GYC/x3MQQqAIBBA0avIrBNUhKirRAsZR5tFFiNEIN49a
 fkW/zeoJEwVVtVA6OHKVxmwkwI8QsmkOQ6DM86bxTgtJ+nImVNA0ojW42wxOgowklso8fvvtr3
 3D/f1b3BeAAAA
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "Geoffrey D. Bennett" <g@b4.vu>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Mark Hills <mark@xwax.org>, 
 Arun Raghavan <arun@arunraghavan.net>, Cyan Nyan <cyan.vtb@gmail.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725226324; l=2042;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=9005hIvO0B3tQdTeJlc1RChOBA6FhZL33VJhjP5iEn0=;
 b=4EhSkc6NT1AchTHnoKaRNKta12AcvWrS161BLV8vz7wYtSUhsd76Gr/UTAqaLX3wXQMUj/G+i
 ZzUKwnNIFhgDXaL3NcSBFp4x4KwZprFK78Z1wQxnQxwdpdrAHJ99Jy/
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=tpv7cWfUnHNw5jwf6h4t0gGgglt3/xcwlfs0+A/uUu8=

Hi everyone,

This series adds basic support for the RME Digiface USB interface. This
is a 4x ADAT I/O interface with an extra headphones output and support
for S/PDIF mode.

There are 3 streaming configurations:

- 32in/34out at 1x speed mode
- 16in/18out at 2x speed mode
- 8in/10out at 4x speed mode

The appropriate speed mode is automatically set based on the PCM rate,
and this governs the available channel count.

The first commit adds basic init and streaming support. This is enough
to use the interface in its default settings (ADAT outputs, internal
sync) using the ALSA PCM.

The second commit adds basic mixer controls to set up the I/O features
(output modes, sync source) and report I/O status.

This series does not implement the output faders, matrix mixer, or input
level meters. These features are more useful when the interface is used
as a router (possibly stand-alone), and are not really something that
can be exposed via ALSA mixer controls usable via something like
alsamixer (the matrix mixer has up to 2048 possible mixer nodes). Since
we expect users to use a dedicated control app, the intent is that the
app directly controls these features via the libusb API. This is similar
to how things work with some FireWire interfaces (ffado-mixer) today.

Of course, there is room for extending the mixer interface to add more
controls in the future, once we settle on a mechanism to expose
complex/large matrix mixers.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Asahi Lina (1):
      ALSA: usb-audio: Add mixer quirk for RME Digiface USB

Cyan Nyan (1):
      ALSA: usb-audio: Add quirk for RME Digiface USB

 sound/usb/mixer_quirks.c | 413 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h | 194 +++++++++++++++++++++-
 sound/usb/quirks.c       |  58 +++++++
 3 files changed, 664 insertions(+), 1 deletion(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240902-rme-digiface-cc14c71cd2ea

Cheers,
~~ Lina


