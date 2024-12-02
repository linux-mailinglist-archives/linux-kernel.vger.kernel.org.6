Return-Path: <linux-kernel+bounces-427781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC29E059B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874B628BFA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060FB209676;
	Mon,  2 Dec 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XbJAVN8o"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD682040BB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150871; cv=none; b=QGaO1tWV67lBVjlcg/eV2LA3watv8DUQXuO5xrDom4WeZC3Srg7zURFth4Z6oMePJZ2x6zYHGDOpGYdMj2ZX6zxbk5Sd6K0lIxB4unonyTTn7nhzdMuty16KNrOz9Rj6X7zrup3mDlixPSqk+zpImW+4qNeWNpkF+OBnvJ/8OTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150871; c=relaxed/simple;
	bh=RL/E8p/vq14VYyGWfXE7LLz7N5+AUAggoi1gcwblUtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qq+BLeWeWuGc6iiFpocP46cQGZyAb29VZST8jM0fTGb0X93/S6iiRuJZhaWc0rqidMxiyASZZpxayN9WV0wCCHnBCLSB195+vk8TtdhQUkJTAw9LPu2+Bp+JP0QL0ylCd9ECCK/Hy8kkcBZPqQHTzeCutAPVRRIaNYMR6u115tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XbJAVN8o; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A841A3F135
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733150864;
	bh=6P3Fdo+///gJH/BN3CJ3yDbZwPHYCyVUVVf4gRdUcys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=XbJAVN8oRnZAqPkG+LbB5c9PoQWKjIW/ra/xyvkl31QzSgvbpqObrGcR/H0ovZFy7
	 SWqmwrOtitGg7ip5x6AjU2VAqV38S4JtlxqHdQZ3+hzKgIFWohHhFFU6WCMYBzTvsO
	 +L1epUMtwUhuSDObY/ArOYbyE8J20hoQUo7m3Z8f2NPU1dkGCkQxNCKpbB3bMPHs1Z
	 HLWFNRV9hKX2feW+d3jWNXB+wBIYOGoiH0cZ/CtfzMeXa9RCrnyTiW5NtQhoXkwzh3
	 HR66yNyEbhVDWKhDGXGjDy5NkBlVIYd08xAjecJll0qBEbvjdGaJBuKrh3TyzFzv9I
	 Xo0WWbC/rA5Cg==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-724e7c48678so3605228b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150863; x=1733755663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P3Fdo+///gJH/BN3CJ3yDbZwPHYCyVUVVf4gRdUcys=;
        b=jFAN0e8G4/fdeNKkSIqSGZQLiJakF0ClsCx4mPU4QL0sI/JCJ+D+osl0TopWskOdAE
         WklaujnSfHbkcXg4WJEn8XqE2kZ/ZtGoeP4Hw05YW0gME9h47id1jwYUifYYWge0EE1y
         Dp/7r3VKX28oq3CTFbJ8TFEUlka/0IsHSo1IQOdV/xQDEFi1+sPrwu7pkDZ9lVXlgLbl
         ax/4OZY40RYV10+O5htLWE/aCpVx410Fh/lb1wDZLrYoWZPCQMPKqy+uSOJh57fA/fWw
         Rl3inbmw3KJzcRbQOYFpiq6FYhmOawLkDHfQioMtJHfMWy23HgJ14P/dLRpsEEALzQfI
         67ow==
X-Forwarded-Encrypted: i=1; AJvYcCWKSIeZZq2eyo6CN8DJFnnxhqBqdFAk0ctHo7w9e1evLtKSMbfuBH1fJUehzlxoAYguaw4DN0Hqq9j1P3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmF9QqSN5STXaYXhHU7/m6LjNsNCjuX4tz/7nSPMjuicOGFUVA
	arXu2t9NegLyTH2UeD3K2EIh1dhulTY4/BmYWZ8Gqoo68am3DpZ/mSxhxa8cPOnbfgG8exrF1mS
	skfxhupKq4w3mwa6FKsjogpxK28jLlWflfqZCoS4Y0AtriiDfqV5OCIo7V8seDuj0aESVnNtuXN
	mm6w==
X-Gm-Gg: ASbGnctuoatFh0/884EFQ0SOB9TEjjotrl4zHbpiGGGW5Q59shpIfjgWWK1/5CgIEn/
	DQUP+8rJdjl9phk5CQ+E02jb+hiuVGSFm3EVTgzj1oV+IDeN2hLnqyxMhFx+gH+AWMbgDmpLZv/
	EypbS2rmE4ghngPwIp4YUEVTc35UAXLb9Nx0vKF5ENmDBMNZ3cd4xqmd8DGIqOw+XTdyJzX9Brz
	2fGOTGTspEykqoWwM6/+Vi3hBfC3/5q2up+G8l/GwtyMvl3tscuAUYmcwNuFonNFdY+Chm1bNQy
	MNobSJIq9/P1sCfPk4qG
X-Received: by 2002:a05:6a00:2e0f:b0:725:4915:c10 with SMTP id d2e1a72fcca58-72549151038mr24880747b3a.10.1733150863165;
        Mon, 02 Dec 2024 06:47:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlatQFoykXyD2ayOlog4ehRSY8QHZGUqutjYhJUxA+LmQiaeuzp3+GFfSR8BBU6VE7UVtLPg==
X-Received: by 2002:a05:6a00:2e0f:b0:725:4915:c10 with SMTP id d2e1a72fcca58-72549151038mr24880391b3a.10.1733150857946;
        Mon, 02 Dec 2024 06:47:37 -0800 (PST)
Received: from u-XPS-9320.. (114-36-208-180.dynamic-ip.hinet.net. [114.36.208.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176145esm8566321b3a.8.2024.12.02.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:47:37 -0800 (PST)
From: Chris Chiu <chris.chiu@canonical.com>
To: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops
Date: Mon,  2 Dec 2024 22:46:59 +0800
Message-Id: <20241202144659.1553504-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These HP laptops use Realtek HDA codec ALC3315 combined CS35L56
Amplifiers. They need the quirk ALC285_FIXUP_HP_GPIO_LED to get
the micmute LED working.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2bf5c512ebaf..237e0c17083b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10521,7 +10521,13 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8cdf, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ce0, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d84, "HP EliteBook X G1i", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firelfy 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.34.1


