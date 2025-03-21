Return-Path: <linux-kernel+bounces-571093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55731A6B908
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1B6484D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455022069A;
	Fri, 21 Mar 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nFafVQiW"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2E1F17EB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554166; cv=none; b=fNkdP2SWigL+28SSkSFvMxHrS24MoSFXe6cu5sS4Gixe2ee5cXSa2LNPOX7bpK4e0GeloPoCgZjE23/IP9zK3OzPJBNcEIw+GfOjL/SWc32Bt+vset9LNUKf9EZ6pCnKVRZrCUtZ7wv/rG9K2LrpPjqH6shUzHSb8ZoAjd9HXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554166; c=relaxed/simple;
	bh=AKiz805D4eOoRMrIxzZ76eB1qkCaMajH61Sf5nmAkB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/3eVE4TNiHR8wA0SQfBWGrB0SqK+z8CWKs52asMGLNWnyjcxqlYWN96xTit0BO0K9LqJ195238W3b6ei07XidkfD96zOSgKGedLVlCEezSCCKO6w1n9FC1CrJhHxDlKb7k7hcYyWiZ6O2DrXR3E7nqnZ8oPSaVA3xle954LIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nFafVQiW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E90693FCCF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742554162;
	bh=wk3p2RHEb7IC5cBg8qDlCuH+i3pQ0PXB+Ife22F3hrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=nFafVQiWMoSZW5NH93A64h6Wp84VnyYMgY0tqDpsvX9Kh3FPFO68ZoizoTBzwoklo
	 LtCYEAF7motp3QhwaHgEIhaBR4sydjoSpeQuo9TM6Ob84NqVmIeeTY1Kw/WQl3Qvi3
	 dJ3x4DZIV0K9QhQo9YrWg+OMKYtNnb9Xak2qHEyI+wo/FXQxu0FgrxaSMzCWu919zn
	 v1baPq3m3YzR2ajfEcPPuWtNan3rriuGtZVm2ljC+4ni7cZB9lUONxQqVFSqIN9owH
	 PDOW+Q9f8TnwMvdxflW10dOEU9RW8hqVOKoWLTiU7kbaY7KIFpG90aLcxaTyazqSrB
	 7SDNvBV6ioxSg==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224347aef79so43774935ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742554161; x=1743158961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk3p2RHEb7IC5cBg8qDlCuH+i3pQ0PXB+Ife22F3hrE=;
        b=pQZVi6kMbuwLgNiIlSGJEUO2oVEnSPs4IJoMcRkUcAGNkHyppphUuyzZ3IZWaPQEXE
         shaKVUH1+++anQSJnHVwg0DHDul76MD7kWkRnvE+wcKqWHsxnKB+/HY3dp4rN5iXY6Yf
         ybs2ZC94FmrmpNK8/xiDCwcjLimFH1GpfDfUuwuFrFXHiwspDH5iESKRClAyE3an0BY1
         kYu5iI3A4Bu7VQF1PJH00qOnyphseO5xz+Pb2HyFz7k5nhFzLb7mBu51dnU83YjoxOAV
         4FFWdOPJhz3CY4SszRSthpB6Wt1vBrWABDGVr5pukA1dYeJPFI7Cu6HKyahIPpr7uLVa
         yPGA==
X-Forwarded-Encrypted: i=1; AJvYcCXVJ39jR5Wlnhspzh8QxqOtuPwRQd3lrizZmnPrvrXAtPPXqPACWZ0hs7Bm4TxrgTjo0YErXAJuEw6tW9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz707ZPXTw6qWbMJ/YuaH6zV0819Kykimu+78JBmqfqgQwIKqgM
	Ys3lMd9LhaXU85K1LiyvuZJ8k9NeEeTji+xwLGs9X2En04FfLlkHVg8sPl8rMazgth4LpAPns/b
	eIeM9S2C2fStQG3iWwJklIkVK6wW8RLvBBkT6lgkYtATuF8wjL4R3RDxekZHJyj1ZkX2Ag2lDm/
	otVg==
X-Gm-Gg: ASbGnctq3wRWzVeKAyJJDzEB3SdnCneZzL9Qwu7n6/NinsQE9WjYt8mZpiMFRYPpq2d
	lnoO/9ftYhfJX7rjfAJsNxGRSz6ao14CkJKehHdcZcd5N2kGXrpKTNilMqiZR0YR1h70gfHG4vw
	2eXCvH9SD81+71JNwn6dwqccKrU3Bdp1FEtQP4o7RXZHyehssB2mnCXStTQomEpMjy9nQRg1TCP
	HeAm778hVRZJ7T5e3lAU5+ia2xyL0A0C21bvNu/mtL4awN6CcvURSjHTCkKSDBriTXkGtc3CEpY
	Zn0HAK6qwzzA+7BwMIBhYg/xCB8xuf+8JuwOkSJGL5Z51sjzjQnWyDPSAwF+SA==
X-Received: by 2002:a05:6a00:808:b0:736:55ec:ea94 with SMTP id d2e1a72fcca58-73905a5255dmr5427977b3a.20.1742554161313;
        Fri, 21 Mar 2025 03:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8CE8cLdwjqNwnbScAp+7k6TEaCT0uf3ktobtaMxTgvHAj1XlubrJEYiUV3y0FvyGo2+Xq/A==
X-Received: by 2002:a05:6a00:808:b0:736:55ec:ea94 with SMTP id d2e1a72fcca58-73905a5255dmr5427947b3a.20.1742554160896;
        Fri, 21 Mar 2025 03:49:20 -0700 (PDT)
Received: from u-XPS-9320.. (114-36-251-180.dynamic-ip.hinet.net. [114.36.251.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa92bbsm1589353b3a.16.2025.03.21.03.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:49:20 -0700 (PDT)
From: Chris Chiu <chris.chiu@canonical.com>
To: tiwai@suse.com,
	perex@perex.cz
Cc: simont@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2 2/2] ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3247
Date: Fri, 21 Mar 2025 18:49:14 +0800
Message-Id: <20250321104914.544233-2-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321104914.544233-1-chris.chiu@canonical.com>
References: <20250321104914.544233-1-chris.chiu@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More HP EliteBook with Realtek HDA codec ALC3247 with combined CS35L56
Amplifiers need quirk ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---

v2: fix the quirk order by SSIDs

 sound/pci/hda/patch_realtek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 30d4cd93dae1..5bafa8817bad 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10734,6 +10734,11 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8dec, "HP EliteBook 640 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dee, "HP EliteBook 660 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8df0, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e15, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e16, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
-- 
2.34.1


