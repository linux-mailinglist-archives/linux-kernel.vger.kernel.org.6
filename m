Return-Path: <linux-kernel+bounces-312756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9326969AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC36D1C23A34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4CA1CDFA3;
	Tue,  3 Sep 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="FyjzjssD"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A641C9871;
	Tue,  3 Sep 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360784; cv=none; b=sh0BMdyz0z9sjp6j6MuLNIi+NG5LpdWNJ4DMTRaLGu8Ig4dlW/zgT1XsK86ilUpbyzVbL0/081vD5ea+nfrjnpGWGW49rQpk5SthUjlA4oA9aEy+MbIdaa9EVt4FmdzoQ98ucGcjGNPj1KH16kqyFp3Kw4b4yUzBsJJJ+HydzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360784; c=relaxed/simple;
	bh=3AToH91I/8CTPEGWpcFWxh2N6vC22/jz+GfETbET62U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n4XJYlDYqlGDz/+pqWJ0ghthCiKDTCYS2Kw5X0MRatuV3N8WoEW1OnBCgH7bOoSeZYjaECWtnuBF1LANz10L7dlZKosCpjKy4SfKiqlgKVRZ3/Qp8d2LSTtySwTWGV3y9ZCdp3CluUwRyaxvrMXuVM/dx39m3tSGmtdF5DkIMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=FyjzjssD; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id D6EC84347A;
	Tue,  3 Sep 2024 10:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1725360772;
	bh=3AToH91I/8CTPEGWpcFWxh2N6vC22/jz+GfETbET62U=;
	h=From:Subject:Date:To:Cc;
	b=FyjzjssDqGUP6vS9+mubLjpOyNxZuMYLJVnEbMvxSpgHVfUHp9S6Lw/cx5vDonHpK
	 gXKl3Hzy93aoasuMnVD7ngC1qpDePYQuWVOT72URC/bVtJWxoQ8megKvlcbZHC5Yxn
	 OAQ/aqEcHuZr61Yac2hGbJqhNeM+E0zjqxcoajrrlfeJnchjGApSjNdNVvtrSd9CRz
	 OrTIicGbVv5yyeHb9k4nIzo8HjDiIsGJYNOirC3uEM7CMSjh+BVv7wZQ+0B5BOnzA8
	 EAJjyysXB3bI/3GSwi+uJhWWv+1xQG11GW8NV5ddL25ftJcQRl6djRnPSek3xV6xZh
	 jXg2tA/XXEJ0g==
From: Asahi Lina <lina@asahilina.net>
Subject: [PATCH v2 0/2] ALSA: usb-audio: Add basic support for RME Digiface
 USB
Date: Tue, 03 Sep 2024 19:52:28 +0900
Message-Id: <20240903-rme-digiface-v2-0-71b06c912e97@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGzq1mYC/3XMQQrCMBCF4auUWRtJhmCqK+9RuhjSaTOgqSQlK
 CV3N3bv8n/wvh0yJ+EMt26HxEWyrLEFnjrwgeLCSqbWgBqtvmpU6clqkkVm8qy8N9Y74ydkgnZ
 5JZ7lfXDD2DpI3tb0OfRifusfqBil1YX73jokdNbeKVOQh0Q6R95grLV+AV5gncOsAAAA
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "Geoffrey D. Bennett" <g@b4.vu>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Mark Hills <mark@xwax.org>, 
 Arun Raghavan <arun@arunraghavan.net>, Cyan Nyan <cyan.vtb@gmail.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725360771; l=2378;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=3AToH91I/8CTPEGWpcFWxh2N6vC22/jz+GfETbET62U=;
 b=rZ4QhKcI58kDeDjNSvs7P2FjEsG2d2RIkXZCDV2AGauPPeAVy/VY+Pq1P9P43o3jFazvwKsUU
 sWDyjU94S6ADzoucAhIqACZ7oZiYkC/BwifeU0KZBlF71VtRKfeyLDC
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
Changes in v2:
- Fix BIT(32) that was intended to be BIT(31) (for 32-bit platforms)
- Rebased on sound/for-next and rewrote quirk using macros
- Removed USB_ENDPOINT_USAGE_IMPLICIT_FB since the sync info is explicitly
  specified.
- Link to v1: https://lore.kernel.org/r/20240902-rme-digiface-v1-0-6e88472a2744@asahilina.net

---
Asahi Lina (1):
      ALSA: usb-audio: Add mixer quirk for RME Digiface USB

Cyan Nyan (1):
      ALSA: usb-audio: Add quirk for RME Digiface USB

 sound/usb/mixer_quirks.c | 413 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h | 172 +++++++++++++++++++-
 sound/usb/quirks.c       |  58 +++++++
 3 files changed, 642 insertions(+), 1 deletion(-)
---
base-commit: a2f5a48557e856a4d166e0af054490893d767d18
change-id: 20240902-rme-digiface-cc14c71cd2ea

Cheers,
~~ Lina


