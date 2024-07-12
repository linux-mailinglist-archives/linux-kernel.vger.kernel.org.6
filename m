Return-Path: <linux-kernel+bounces-251046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B993002D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 777DEB212BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0635176FD8;
	Fri, 12 Jul 2024 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi2bw6vp"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D11426C;
	Fri, 12 Jul 2024 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807629; cv=none; b=hGDHkvOBo3qqyahQ69uThFoDBGfX9PFXa1P7d3pvfBqO6PVKyEEhJcJ2aYcdaE2u2A6hvSIqvbv7CXyxDQR4+uAlafLXpANqg19IvWVQs34frL0YDjj3/SHABJcHcwwW5+/KpKeUBJ3oAduZ2SM3nP5v/vebqjBJte7MGoRkwUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807629; c=relaxed/simple;
	bh=vsfX2dO6Arg3oSXsJxfGBpfSTooOyOlxt7F+JaA1HMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d343l0KypJgC1AKKgLEQPOy+74cEA8m8UG3SrxgSAlL2i8YxF3i4sqM93OtpHRkAkB269nANrOjVLIA0MB7Mow/sfNub6XsZ2bLHxlEq6F4MSQA7u4BNcAXukgvld+LwGuDPoJlDeh3e1pT/ZPAutVwzTqB2i5C/2etvBqJKQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi2bw6vp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb05b0be01so16448265ad.2;
        Fri, 12 Jul 2024 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720807627; x=1721412427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aiB90U2wXLnecL+PHz3PwRGrDUIgjvhch/dJg0IVRXM=;
        b=Wi2bw6vpiBtnrl9B1RqEIWQUHqUjvx6Dc2im1qCjRRp89e2mXBtZuRVPUGqwl74+tu
         Y7eN8kiENPKjiiuSVIZgbU8QBamU2gO6hPKbtWp48LJPdwuDOO9KEQlnDRm+fDXhYJ9h
         il9eC6CWekGCWD7K/iZaQ1wcGhVzQQXOtWS1U/sWgItZTmbDfZyoDCsoXWJF2zVRAkMC
         7wcUl5b2lGcRqZ6d5UUlUYxqAyg3y8GlWjzOyqlMQFBjD1Bzj0tqqqEb8T2gHgVTKpzY
         zag6VEL6yrO6vLmG4q2aStAjsSrBxO5aLkm1dGOBnqZzKnF7O4PF/hPk5ExVm2r3Sus+
         g9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807627; x=1721412427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiB90U2wXLnecL+PHz3PwRGrDUIgjvhch/dJg0IVRXM=;
        b=PMZg4X4G4lgBazxcU48Zbiq8LNjpFH2hOZnH1I6tZEM2DmtchQmQy9YIbZlu0lkgk5
         36dPlihXLpuKwfzLUHdCO1uMdZyB6W2eMb1tzJCocfZHAQucAaYN+khdvXAfB5f/e8rj
         qT1FrYRUgJki3agxNsiQaKMz7FsrkG3VPr8WVtv+Fb+WbsiZZT/gMWBDtIl+Be1FkR1n
         ZaFqoo/3WQyIlSsWXY310DNd+zkcU/kDrW+v4EJ8qxABaCMj7n3lj/aogxDuzD0HE515
         7vLX5uZzOjgozOEmAGOZBdxPzLJxtVjEztY3eoOQwFb9VO4Yy/LEMLOp/gnoLIqX1J8f
         NptQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvU3avxl7gAUZTHV9KHXoZKjInU+Xdnvaay/7BXLlOlSgL6ZVYrXvB5h4+O0LC619XnThvLtFtIccM2zC/QnL47aWkMnDzX37Wk0Xf8v0++pr327ReZQ4JQRLgYq2gcHDxL75NSVEw94w=
X-Gm-Message-State: AOJu0YzfqvZZcOYd1xaBE13yaDq3DpFO0DSu7wao/hYB4xe3pJ0I5Nbd
	gFumDtsJxMf/5GEpoy4xvq+Xxvq88qkGXRWCiCpYesGNtKhfmfYS
X-Google-Smtp-Source: AGHT+IHjKjYrkPOa/jPXpOKQoCQBPygf6mc8a0vlUpWptHpRO24LnqprJjd1fUAjp/jZ1qCMScHibQ==
X-Received: by 2002:a17:902:fa10:b0:1fb:9cb0:3e2f with SMTP id d9443c01a7336-1fbb6d53fdemr73542525ad.27.1720807627071;
        Fri, 12 Jul 2024 11:07:07 -0700 (PDT)
Received: from localhost.localdomain ([187.17.229.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac54d0sm69763235ad.230.2024.07.12.11.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 11:07:06 -0700 (PDT)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Enable headset mic on Positivo SU C1400
Date: Fri, 12 Jul 2024 15:06:42 -0300
Message-Id: <20240712180642.22564-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Positivo SU C1400 is equipped with ALC256, and it needs
ALC269_FIXUP_ASPIRE_HEADSET_MIC quirk to make its headset mic work.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 766f0b1d3e9d..34cb731b40bc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10384,6 +10384,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
+	SND_PCI_QUIRK(0x10ec, 0x119e, "Positivo SU C1400", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10ec, 0x11bc, "VAIO VJFE-IL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
-- 
2.39.2


