Return-Path: <linux-kernel+bounces-215885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D5490985E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E97E1F2229A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505824644E;
	Sat, 15 Jun 2024 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqdb24mX"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5D10A11;
	Sat, 15 Jun 2024 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718456103; cv=none; b=Bf2qTCXUEe2Zmeenqn56Ne/A43SbI3lVC7TtzOAGlstZ/vloMeAW7K3/GsNyVfmVwxNiJSExAeudyuUuO6S5QE+tOX2NvM1JI2hvmVcUtrasl/XKKn5ULqmzcc+HtpTvGU5Kw/25qTe0EOW0E7d5+ewXyxzuAvMqMJxfn4CM94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718456103; c=relaxed/simple;
	bh=xqtN5Fn2CfmwZ9Vg/3vEVF2gAzSA/aPI+E9xeV07Zq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=meeRXgBi1fYZwY+DY160QjG0XldOlgFMjvdKyEF3OPWRABEOudLZQMPfcEtSW7vzyvlB3Gwew8i6jWWVj28UB+HRQ6nQcToCiPyOs9UhGcQM+Pj0AHhr3JpH41Hc+09auU3pc1KOvumWOwzoAzWPbt2kZ4ourDtF9bOe2bqKzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dqdb24mX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so30004411fa.3;
        Sat, 15 Jun 2024 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718456100; x=1719060900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PU/plAUB3pXmtvzzj4mwVKHkG90R6S2BTMRSfWbaliQ=;
        b=Dqdb24mXOO5aOSSUIZw8HmajublcqTP7UPdWwuxkOMKS+EMAnIrFTcMmiHKFmVLUDI
         uCr4/mi//OkSVtA3n4YxX0n6gyGW5Ocp8CSybZrnbCFR95emUlWEbBsDo6Wx0ipYMlXa
         CsYGYRTf/ZuuQlmLO64J6fnArJWw++XhHdjWsH/1KS5W+9QNUCZqyJDMpibrAK1Myk6F
         4gSyRCAfIpr//8bU28+Yg4LripkGCM81LDblf/KKLaYSuaex5o9nMAOkSschfMa+4qs6
         0hso3MMjkApzfVxjDdxuhCo7a1UQTrL33iLo54fcSPWzuSEiOqtZLXrhY6socG4cZ4xm
         jBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718456100; x=1719060900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PU/plAUB3pXmtvzzj4mwVKHkG90R6S2BTMRSfWbaliQ=;
        b=OpRclgSIBEiF1uOlpVQzu5PaM9Mvsfvwky5ii+LIdzKXaWXiLR8K7+RCKJ5C2cinnR
         XeKpVMVI0D9CoURRkkUuEOBNBVeSK9zh0fwBy6XYGRBKeRrMOUDzsTENTC+9KrfZ0QLf
         nNR4SHhQssKXhyNNIG4N48xoo/dT37dzjV4YQEtDqGP502B5AZETRFJ19CvEM44CHPD6
         VDlwcjruFo144P8L7aIcIHh7iwv6Ob5+zIi3GqHKfUg9vZn240bv19FgtX9KueGfDVAc
         Xf8UsCGDprM9ZYQ2EIj8EXnUt3c+A+1lV1dMHNKBE0OyYomPOam55VcjqMo3lRct+4Xn
         KJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWeUa6O340n5U/fH84TbgAOPdyVsOeFW2ghLy32P1UYTy3S208npoEBUAIEkN5SdOu30hpdf7Bwba+pdVD38T4r2gvBJnzPZ3B20PeExFmQovJxmlg0JacXim71PETpx76Xw3fSn5A91BA=
X-Gm-Message-State: AOJu0YzMJvwrnVg/SzLn/mUlsyYJ9w+zm9dbOALrTLF/bJ7XqqrujZeD
	qrNRd58RtLao6fDPv79O546ltec6AZVMqcyJdNaDTXKp1YgOAm3a
X-Google-Smtp-Source: AGHT+IFkUf1iBqBRD+AUYYNqJwcR2OAFlTmC2JSGllwYm+hxVyNvW3hpO7WYM1XPZDO9ieWIGEdr3g==
X-Received: by 2002:a2e:3304:0:b0:2eb:e312:5af1 with SMTP id 38308e7fff4ca-2ec0e5c6e65mr35517231fa.22.1718456099406;
        Sat, 15 Jun 2024 05:54:59 -0700 (PDT)
Received: from ajratkogda.malta.altlinux.ru ([2a0c:88c0:2:805::1f])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c898f7sm7622691fa.101.2024.06.15.05.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 05:54:58 -0700 (PDT)
From: Ajrat Makhmutov <rautyrauty@gmail.com>
X-Google-Original-From: Ajrat Makhmutov <rauty@altlinux.org>
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	wzhd@ustc.edu,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM
Date: Sat, 15 Jun 2024 15:54:57 +0300
Message-Id: <20240615125457.167844-1-rauty@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Headset microphone do not work out of the box with this laptop. This
quirk fixes it. Zihao Wang specified the wrong subsystem id in his patch.

Link: https://lore.kernel.org/all/20220424084120.74125-1-wzhd@ustc.edu/
Fixes: 3b79954fd00d ("ALSA: hda/realtek: Add quirk for Yoga Duet 7 13ITL6 speakers")
Signed-off-by: Ajrat Makhmutov <rauty@altlinux.org>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aa76d1c88589..5ec95a7903b8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10502,7 +10502,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-	SND_PCI_QUIRK(0x17aa, 0x3820, "Yoga Duet 7 13ITL6", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3820, "IdeaPad 330-17IKB 81DM", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3824, "Legion Y9000X 2020", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
-- 
2.33.8


