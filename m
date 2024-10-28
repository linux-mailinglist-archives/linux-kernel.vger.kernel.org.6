Return-Path: <linux-kernel+bounces-385310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACE19B3570
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7BB1F23203
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF561DE8B7;
	Mon, 28 Oct 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF3E0t/h"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792971DE3D1;
	Mon, 28 Oct 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130926; cv=none; b=uCF8grg+1Lk525gZJDclNdCLLecaGmveKK7Juaq/WlG+FT+gmSqKNrNgB34EQAUm+CwveOOu6E+pbDMzC9IvP60eyG9ziEphSUDvbm5aPkhfJQOFPfEkhTwDq7ICg3Rt8SaKeLnbg6KvwJpTj0wlR/mQJYyg5pvL3PE/0fnSf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130926; c=relaxed/simple;
	bh=oGPN80qbKjwSppJ/U6TVsMTO1C1mG/KjaipR+Ky4Rus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vg6yn6baHzXwcWmVaevkVyGQ/tH1gXaANEwbYfu27lYRmzY6f7yZLhKjopl90MoGzt8S5S2V615pmp/USU4omA4JW68t0T7U00TSOIT8tAJ/tsIzHXPp3CYxrQ3NAyavs5yl9rWXeGn+xOLyZoT9hQj3Pbzxw+vm6T5Um8GRZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF3E0t/h; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ede6803585so1043922a12.0;
        Mon, 28 Oct 2024 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730130923; x=1730735723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+avY+0FraZezaA2ZJ3j6/+NsGewm/RnEb+AyA9oKYCU=;
        b=HF3E0t/hyrfKSo43gNZvAIFkPucIbgXIhIxtToXiuLSHGeKVgKRYtAEXqdAysPM/cz
         FRbyVgwMYamh7j7LZRAyj6yAPQduvTpiB1FPCuaEREY83jFMoMrqJ7lc9HwsvsuwqAx9
         CA4CjNGqaRXoWLBoTFB6WbNNC+c8VyiquSxnFZFHOSYDcRmIZInUdJr7Zs6b4H/pVj0E
         aKYW3z7dZTyGOffzccpamTXA8GlfipE9QOpGr20w/L9grEm57dwtC7/BW68PksdExN37
         bixX+evExDPJoh7sg7wMJL/PlbryLCeuSQTml+R0i526XW9xwGRiiNm1/Uke+IFdDWlv
         RMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130923; x=1730735723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+avY+0FraZezaA2ZJ3j6/+NsGewm/RnEb+AyA9oKYCU=;
        b=PXGVm9Gar4hXKHsLGHlT7FZQY5ACgsdwE2m1hfx+tSAmW6Hqg5cyAa7cSP9zr45D8J
         pk2V4RVP7XGlch9WROd5aODI3euJ4EJkfgkMqpyAiPYXmARMXgA4vp25INSIHOrM0rv/
         rj4H0Q3myxaY28hrE7HiJixwZU5vbynS1jIWfDsL2MgUoR7hk2eBF0roJEji57RGjnrD
         gGqAQoNrqcYhLzyOjRyJGX+CAnrP1Bc4tZiO/zk5a2BWtAuncz2nWQIc961jO/1aqucZ
         gxupwOL9nOG5XuOmXl5dAXLGLCIiWqiLLlUVCIkXIKZkcEIEwmksgA5acQUPSa3PS6Zw
         dk8w==
X-Forwarded-Encrypted: i=1; AJvYcCVL//jB29oP1xq3ZqJHh0pFmVgSuAzI7OCkeJB4zRAF0FqYc9wSmghOFHZMjTgOgKcp75X2d6h4uZKxglM=@vger.kernel.org, AJvYcCWoWSX9IY8Hg+0yhw3iEhuMEJTh4IXs618KpjVGnrR5+1CrpWTe3cG7+SXgU2wJjndqlLUvSFElDPPwuWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5t0iSd9DzkCjOi91E3gs7EML69h7wySMojXzvzRXw/O8rjuv0
	qTpIPlchI6ET+pa7OaZu8rguJZeZvXGXlO3jSxjEpVe2jwt+XXQ/p7+YH8Lz
X-Google-Smtp-Source: AGHT+IGf5oOGN6C9vxAsUtBS/oSx/LaZEx7CgMwc3vpxc8EjXI9w7WWE1LAXjpLS5Xt2LWC5TjoBiQ==
X-Received: by 2002:a17:90b:3505:b0:2e2:a5fd:7e4c with SMTP id 98e67ed59e1d1-2e91e824872mr105242a91.8.1730130923364;
        Mon, 28 Oct 2024 08:55:23 -0700 (PDT)
Received: from codespaces-c8bc9f.dxrpqgqhlb3ehogrxrezr215ye.rx.internal.cloudapp.net ([20.192.21.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e37490cesm7431977a91.37.2024.10.28.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:55:23 -0700 (PDT)
From: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>
X-Google-Original-From: Piyush Raj Chouhan <piyuschouhan1598@gmail.com>
To: =inux-sound@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Piyush Raj Chouhan <piyushchouhan1598@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13
Date: Mon, 28 Oct 2024 15:55:16 +0000
Message-ID: <20241028155516.15552-1-piyuschouhan1598@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Infinix ZERO BOOK 13 has a 2+2 speaker system which isn't probed correctly.
This patch adds a quirk with the proper pin connections.
Also The mic in this laptop suffers too high gain resulting in mostly fan noise being recorded,
This patch Also limit mic boost.

HW Probe for device; https://linux-hardware.org/?probe=a2e892c47b

Test: All 4 speaker works, Mic has low noise.
Signed-off-by: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3567b14b52b7..075935707f8a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7551,6 +7551,7 @@ enum {
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
+	ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13,
 	ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO,
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
@@ -7996,6 +7997,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
 	},
+	[ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90170151 }, /* use as internal speaker (LFE) */
+			{ 0x1b, 0x90170152 }, /* use as internal speaker (back) */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
+	},
 	[ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -10989,6 +11000,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
-- 
2.46.2


