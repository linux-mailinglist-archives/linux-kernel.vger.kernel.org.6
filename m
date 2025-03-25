Return-Path: <linux-kernel+bounces-575101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DEEA6ED86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B257F16D7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826841F03EE;
	Tue, 25 Mar 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db4/JWG0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A178F24;
	Tue, 25 Mar 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898356; cv=none; b=UUb1jYm8oQpxjNjjFp4zSu6KkY4oky6xaj0Pkm0Ye4nlM1JGEZQ8elofYgegi1ASghI3O6P0lrdB2K7nHB8U3xdamZ/5NCzUu7gEnUuzqKumgK3WDZRElLbTvW7443mlmszOovnqxrmtb4Jrc5uLWUyniHRFIY3bNmgBgGqiWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898356; c=relaxed/simple;
	bh=pPYr2AHRKW9t53TYJf/9ZrFy4ScNeMvk2ssp+Q9q49A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVfCTwifUaj6zGD2oNOzmxYPQxr86JLZ7NAGGKBaeeiPJNdjV0RY+gvf88Rfpqiw6rXPvHh1cT1jJueKyMwJKyer51qMvEjpEzEfhsHjfVGknCAw8ikR8TOnO+kCMATYpt29aoQcyvR0YXBmHM2p2hGgNxFX8rCPWkaAl5YHyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db4/JWG0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2255003f4c6so102439645ad.0;
        Tue, 25 Mar 2025 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742898354; x=1743503154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TQZ1mJnI/mAePfWZskq+M/BEdwOR8KjNOwJYBWNuFU=;
        b=db4/JWG0fFhcN36DUdT5AIaQgHQ2PKB0gVC8B+ZLzg686y2z6rhmZvhOlLjt6J8ZHI
         6kX7l2IKWzKSxhkytUViNTqdI/gSXhBDSAX6H8UmLI+oJbM3xlDHSQnvG7wM9rQbr31R
         yiJ4h80NV/fGAyG4xNcvxURJ/JU9BEX7Bw0IaJIeBbbGXIZmS5RgKY/QYKKcUYWGxjHX
         okVtpr+dGE6aE9ADwVY+bJSf+B/jbGWmzO9YNKVHPzpqahgW/6SLUbsr4jVNUPYQKKVf
         D9YfB70oayDiAMpC1hQ1/iqPV3dLzPtuofb6H/A/NZZYmojY1KkAeELjzjHIsWFGRlld
         dFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742898354; x=1743503154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TQZ1mJnI/mAePfWZskq+M/BEdwOR8KjNOwJYBWNuFU=;
        b=eBNxQvvsLVjDZlpCdFsgkDlfEhHTNAjjY233CqXX7AONT1uFUOviZLELhG7VqDRpFp
         dSYZjuM76Nr8/NdpUz0zMMvncgVYR0GrfzzkvLpzQWtEFw7dE+5wivXlgbUoyMb7DRJj
         ssOV+IVX6oiUainbH29wYwoZuVDnJThZf58XU1UjzfgHoiUI4M6ZyLwY6b3ZIYVfMcyH
         6mfaGcKzhn0dXRqMkdxUiSegC7lXGAMwJh5qC3O1KjZqNo0TA0sW/mUnr9pGIbx6K1ff
         0YTj0yTllvMv1XbXm6MlV6vn9aN2pZfY3REMkWEYCVoM1yT9TXZUNq0fV840XZpgQWU+
         gJqw==
X-Forwarded-Encrypted: i=1; AJvYcCVUcC2rnxhNsKglVTe8HEMFtFXl6IBrApfHoYpwX/MHZbFKH6M4lcD79MD5IEKKP+8OCARJpFXPGQKaXEo=@vger.kernel.org, AJvYcCVgGZnvgAUzaIXq32mYV2JG6PC5gQevRRhDblr1x9VhD+t74glGUopU9bd4fM/85Hv35ly0beSmt9fri64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRaNUbNMbEu8VB6cuIEqniTftl9INvKB8xArzqsG/dCYOJwwpa
	LcznND36/JA7ZH/ysRmuSEN+NqjYmsVIdGy5YXUcdcgLmmTF3Mn/
X-Gm-Gg: ASbGncvYUJtL1NEpQe9Zn4zWu7OxWiZLfscFycm2N4anrBWUGoOS6+RCOcc/R3UcahC
	KS/9DcHA5npzeKCtaAhstkey3g8bn1KFCl71YRtu2D3iv1V8dnRlIYlH/97DfOxBjX1qy/nFVOw
	RSidbIz5eZm6vxUFxJe7zBiTfyhXsfpq1wKPISoDklJecHUSVCxcKPrcn0knkPJmODlxldHdfQ0
	GRFZImJs007KHEqMjpiurKQYNKMDv0D4E1nmIsFR/qhunt3Nd06ErbK1+FEyK3xlvox6LDRxAvi
	9d2hqZD61iirih+emK78q345BZB4byzoxWd3yTVersTDk433zQkumoM/zlFbaei/0/xMAKx6DlQ
	B
X-Google-Smtp-Source: AGHT+IFp4W9MioP21Q0bUey2FAzrWuQgB0D3Elg/a81AxrqjWatuuSruZPC8YfCpE4FUaELr+gttBA==
X-Received: by 2002:a05:6a20:43a7:b0:1f3:36f7:c0d2 with SMTP id adf61e73a8af0-1fe43319764mr28856857637.41.1742898353564;
        Tue, 25 Mar 2025 03:25:53 -0700 (PDT)
Received: from r.www.tendawifi.com ([203.95.197.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d1dasm10063253b3a.106.2025.03.25.03.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:25:53 -0700 (PDT)
From: Andres Traumann <andres.traumann.01@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Kailang Yang <kailang@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andres Traumann <andres.traumann.01@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Bass speaker fixup for ASUS UM5606KA
Date: Tue, 25 Mar 2025 17:25:35 +0700
Message-ID: <20250325102535.8172-1-andres.traumann.01@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch applies the ALC294 bass speaker fixup (ALC294_FIXUP_BASS_SPEAKER_15),
previously introduced in commit a7df7f909cec ("ALSA: hda: improve bass
speaker support for ASUS Zenbook UM5606WA"), to the ASUS Zenbook UM5606KA.
This hardware configuration matches ASUS Zenbook UM5606WA, where DAC NID
0x06 was removed from the bass speaker (NID 0x15), routing both speaker
pins to DAC NID 0x03.

This resolves the bass speaker routing issue, ensuring correct audio
output on ASUS UM5606KA.

Signed-off-by: Andres Traumann <andres.traumann.01@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a84857a3c2bf..286ff8c57079 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10783,6 +10783,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1df3, "ASUS UM5606WA", ALC294_FIXUP_BASS_SPEAKER_15),
+	SND_PCI_QUIRK(0x1043, 0x1264, "ASUS UM5606KA", ALC294_FIXUP_BASS_SPEAKER_15),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.49.0


