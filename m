Return-Path: <linux-kernel+bounces-300512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF795E49E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 19:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891901C20B40
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959BC15B13A;
	Sun, 25 Aug 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmuhGwUs"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3391803A;
	Sun, 25 Aug 2024 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724607839; cv=none; b=XfUHIRTOiFCYV0vmamYkA/5+AK3b4UPOndOWS3qt7VwiWlWssuFJqqzSp+ZWGaCKcsU+nuZhkRY4A69ifovWer3w827G2lRoQUuc7nmXxxitmLvPSbWtUaOn+G2q+g2t+sfdmzjpGP/TA7pM/u8+zbNlsK/ZkQ+7yCRJq2MCbnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724607839; c=relaxed/simple;
	bh=tKIrY9vn3z6LNujXfBqlGozfnYwtzbEWmL8+LofbC+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3Na7hrj8N/oMX9oE+NXJ7vu9wgSHnINo33vVolbfeGm52BQlpcCb/zzAYxts+XqDmH4WGB4pEuk6jM6d1XJvFTb/F4gFbwxiZJ9IUHrTp9/qGjSC2b7s0OTG0Gcn2Aj5OtkcKZNPdrsHhemxp5k3XlAI0TjcJq+oWeuWajJ9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmuhGwUs; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f4f5dbd93bso22865781fa.2;
        Sun, 25 Aug 2024 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724607836; x=1725212636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n97HTeDja9TJP0PmQQQgTXIn0NWJLdIlG+rUOkXSS2I=;
        b=PmuhGwUse0m2mQLBtzXrCCHJVf+26+ISNYIgzmr3FkhHwTXGyNSKJfAmExc7wtZaNX
         ezscQL0k7bA1HxmBqd4kBxRXtvOZ8zQfSH5u9MqX5U6DUOaR6dDZEKSnIVtgaK6KGI7X
         UYEXGbB8Z3gc/1pLEweI6kIPp+v/kPo5OpW0jXfxGu6zOOJHwaEFlnP8DDMK/T+D2W3U
         HKfc3XTmBktABfPliHqus7XutodC0rLLmsAUBGeFzFGHTWYeuJQdrA6Cq2R8z1NZ2gJ6
         hnLboyolNV5KUu2uShyLI6XIIJhifW0P62VKkFgwe1ep0dxYevEssVe9bxMZ1DPvc2nX
         3nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724607836; x=1725212636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n97HTeDja9TJP0PmQQQgTXIn0NWJLdIlG+rUOkXSS2I=;
        b=EL/nfpxllxd/zz0MsazYW/M3+vWnCw3k+Stlnsi6vAZRwmx2y6I3GhUCcdpwXeOiIL
         NuOdSz+gYcwx/0FIb+gQ7qIcmx6o7jbZfAWO+EreBuo0O08E1nr7pVjo5DEJH1YrajEc
         QCRezjQYCkczZns5IfK7pm8zSFbHrPo9DfreGl6ohUg075B6NBwDI5vhkD4g8rZ/I309
         TDUlZzifLhBQwwJaAGzWoGco59hoA5Ce5V2LFz5+OqgkPcWi4skKfieCxVLfukzIHt/L
         wZ2BN0i1bzM1K5300yGg/vyWc3Pibwk04O49dnBshUeLscioQVOI0v1+jHWQFwJt96Ew
         UxMg==
X-Forwarded-Encrypted: i=1; AJvYcCV4TsVdh+e/1kiQrJL+g3a57TtDxHoYG3FU9090gcRN/qjJy6Rz/SrVcljEl+7Czr3uPSYj5w9yOrR9eVc=@vger.kernel.org, AJvYcCV9qOyQcE4lMKJnoAMrX2bzpOyr5QScQgoDkzSfr5Iu+FC+T8VlpX3yeyXceokb7vXfpbhVNQwqVU/qBPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDIQ/qUfr1a5mX5MLI4yWrGNEyz4030RKNqvPgFmhL9GC8oLA
	6ZQvUE69C6CGwL8VvD1gv0Ezz1E2fH1YKfqA+T6KEfpxyJXtBr80wZEVs+vX
X-Google-Smtp-Source: AGHT+IFix4mJ9YQnoNivRXEC1puHh9yACsNeFCbPTyO6HcwDCvzjYN4N7zQjhotdqbTqB/raW/eE8A==
X-Received: by 2002:a05:6512:33ce:b0:52e:8b15:7c55 with SMTP id 2adb3069b0e04-534387853e7mr5259509e87.27.1724607836164;
        Sun, 25 Aug 2024 10:43:56 -0700 (PDT)
Received: from hendrik-laptop.borghorst.space.borghorst.space (p200300ed771342104eaf2a6a78487f8e.dip0.t-ipconnect.de. [2003:ed:7713:4210:4eaf:2a6a:7848:7f8e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a868f21fe18sm555520366b.29.2024.08.25.10.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 10:43:55 -0700 (PDT)
From: Hendrik Borghorst <hendrikborghorst@gmail.com>
To: 
Cc: Hendrik Borghorst <hendrikborghorst@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] alsa: support HP Pavilion Aero 13-bg0xxx Mute LED
Date: Sun, 25 Aug 2024 19:43:47 +0200
Message-ID: <20240825174351.5687-1-hendrikborghorst@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240824183445.6610-1-hendrikborghorst@gmail.com>
References: <20240824183445.6610-1-hendrikborghorst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the HP Pavilion Aero 13 (13-bg0xxx) (year 2024) to list of
quirks for keyboard LED mute indication.

The laptop has two LEDs (one for speaker and one for mic mute). The
pre-existing quirk ALC245_FIXUP_HP_X360_MUTE_LEDS chains both the quirk for
mic and speaker mute.

Tested on 6.11.0-rc4 with the aforementioned laptop.

Signed-off-by: Hendrik Borghorst <hendrikborghorst@gmail.com>
---
Changes since v1:
	- Moved entry to sorted position (by SSID)
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d022a25635f9..fb250bbd3041 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10353,6 +10353,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8cbd, "HP Pavilion Aero Laptop 13-bg0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8cdd, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8cde, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8cdf, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
-- 
2.44.2


