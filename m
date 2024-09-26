Return-Path: <linux-kernel+bounces-340709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A829876EC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530EE1C254AB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D85453368;
	Thu, 26 Sep 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHLunHlC"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB54C7E;
	Thu, 26 Sep 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365882; cv=none; b=Hg1X/rBd25Opu00oFFwroKsasyqkJTVYcn3eT9h5+PepAvJJCVlpO4vO5VdTVg9ACSNg8Su3jqr8v0AiPrU+xslAayiz/1pTtAZoYCYE8qS5XcDSADiuLQo8uCyMPluZE+yQT8J03kHGXlm+e5ToYI8eYT/jFyWUafQ88mqtWEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365882; c=relaxed/simple;
	bh=6Mu+YMPvlbBaORVQ0gZ41JhwRZDq6iMkN6MOQwDkgT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bnn71LTz0W33lwSQVd9RrcVqiodlm9cTT0t5N6DlK5Cmz42kzWNczko23NZfRaz5VG7UHyfb3gTVUxoTTlHy7Mpr/z6PHmjIPESo7pAmp6yUIJFyzBrmfZb3C7OeqACJdjzgp3PDsulnG05wxfaLdkehENCmJMfrfjFYfwKjS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHLunHlC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-717934728adso895524b3a.2;
        Thu, 26 Sep 2024 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727365881; x=1727970681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=549jvhNUSwmwk8eXbBGBDthSFtsG88x9HMrxQ9/pgi0=;
        b=AHLunHlCqMaPdDvuVMRElQ2n5S9xAvfPPth8zGkVEOtbysSYiwgijg1hv1bSkMgKiX
         Cswg23yTeUNVA3SEMyciiyxKxVpuIv3HS9Jp5TX4Clx2KY94QnTc+c7Qjyw0TpOvUC/D
         3quNRcvLL7+rygGyH6qE1Nci/FpwCFbYqvZT3asQG56Ppet6HyfWTI/FQ47A+JKjS9ES
         EXxMv6fiUHyLuB+nW0I+QCva5b6igm22Mh/rksWyDJSVKbtHsr8/bp7Ety1c9NHBkdUJ
         f9JSdhM2pgtOUuuSOtu7oqmO9C17J3gOIxInyBVil50rkd7IsEYwBdXYEqpTbYFu29gB
         Zeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365881; x=1727970681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=549jvhNUSwmwk8eXbBGBDthSFtsG88x9HMrxQ9/pgi0=;
        b=G3a2tI31PYNYRfbGT8PXeMOWigjC6zfvKnR5w+kIgTwebZXPgYd9q2lLs5vCfD12Fv
         wEAfrIF2DZy9G6UyEEK1F5gAgAu/r1HhUXbsSEe37Cexnh+4opgdpHFFmLn/tbhwkKQM
         hMV4zTaRCDP5dGYT2oqd1XtuoWPm5Od3r9/TtGdANCmF+1jMarmgK/GZh/7CZ0tp84hc
         kyRpmDaqy7SPsbtjoY5tNtF+VbHmKanZL36EtNuqnqREO9jB9UbOeToQ4x4CiIMoqHzd
         P+yhGb6d86Fhj9xNuOWlHCEia6ymrvWWa1aFHvrNMc+es2SJp0XcgDLgDOnZqhadKYVo
         26/g==
X-Forwarded-Encrypted: i=1; AJvYcCUcZjor//2BBjyc9tkoGhNBp1m33hR1ZA8ZTRHR8IJpvKxgok7lIcpspzBEGmBIYZ0YTK55HN8FmyTU5wI=@vger.kernel.org, AJvYcCWIbDnOjjeUQjtqanLuUdTXfS9pvcHhSt7gugBPF7zGXfLpxxx9Ke43F+gasiHx8yHCh0SVZhON4nLDlSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YteBGoTBAprib01cNXrRHby46QuSf9MLIqm5+6JzQh6Vn3Oz
	MYJvLBMp/nxEW1b0ILgSjmwvKGRkxbZenpwdXmyY/bIMcsF0fmAp
X-Google-Smtp-Source: AGHT+IFQFvdF/l8IwPlfBuA1Jc6fzNmrDCqYkEtP4KOoCVi+D3ALqMOzJ4eFY/jsBtanCC4Lpipwtg==
X-Received: by 2002:a05:6a00:2383:b0:714:1e28:da95 with SMTP id d2e1a72fcca58-71b25f45aabmr335398b3a.7.1727365880634;
        Thu, 26 Sep 2024 08:51:20 -0700 (PDT)
Received: from embed-PC.. ([2401:4900:1cb4:e707:a7e0:2397:b605:4104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5eb40bsm51249a12.69.2024.09.26.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:51:20 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200
Date: Thu, 26 Sep 2024 21:21:12 +0530
Message-Id: <20240926155112.8079-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the quirk for HP Pavilion Gaming laptop 15z-ec200 for
enabling the mute led. The fix apply the ALC285_FIXUP_HP_MUTE_LED
quirk for this model.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219303

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4ca66234e561..94125a977f08 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10315,6 +10315,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x88DD, "HP Pavilion 15z-ec200", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
-- 
2.34.1


