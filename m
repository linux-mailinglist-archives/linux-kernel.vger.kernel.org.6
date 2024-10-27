Return-Path: <linux-kernel+bounces-383855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F2F9B20FB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDC02814B9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFA1885A1;
	Sun, 27 Oct 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCq10erw"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59718EBF;
	Sun, 27 Oct 2024 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730067425; cv=none; b=EvYV7grT9OOF2dzny+uvcIYl1NJMhT17sx/hoUsXNAM49nb/jIO0iuEDb4mujIaF7SqAHcKkc0esA3EMg5rpoFZdUb7dmr3nWvZHsCZYa/eX45uqiWqAE3oO40Csw/vHAbv+aSXGN7CquaB7mu4Dskq3dR03iTku366R2tJS3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730067425; c=relaxed/simple;
	bh=FfNk8I+mjQn3bM3n+9hlR4/TJBS6DhNfRocxYzTffS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIKZzGNA98xVtR/J697/pv2Ko+SaH5Lc5IBefCKpIa1br98LmcXAfMCYFmslozXk00oyJtmFWxpzlkz2etctEfnydnDzAORZLn9BV4gDhQQD2BH0NVH+0VoiQsZ4gJlKXTNygBO4jQqvHh4z8L482wzcbxPsISaHVcKgM7raPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCq10erw; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso2476950a12.2;
        Sun, 27 Oct 2024 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730067422; x=1730672222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlVBKyzyVEcrMiwiyfAZvoqJg2MA2IkLbNP36j/gEss=;
        b=VCq10erwNyCy/uIxrlPd5bQY+sciuAcQNci+WD3Un4hWeHQ7R31gOtyrH7F41QR03b
         H3n15RV+7T2avucsw6K4unu1hr+s0OqKyS38cOOid2OET814f2pesNFCDPqvSQzM+1GV
         6k6ZxxH6b3JgLFE6JlbIj+oEr40LI/dloBkpl3QvD+5eUZPRabNTANsgnXg6gFtcMij5
         PepljHWa+RfQKHadULLIElgA0rCjFYjqkigx+zV9s1+m0mupUS5jb8pbOH8NuJGD0PWV
         6Ff0hKovuV2PqL/kednHgO0C7i3TT5Y0T6kvLBT5eDadWJpemhSOMFV8hvrYU99f8uyv
         qNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730067422; x=1730672222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlVBKyzyVEcrMiwiyfAZvoqJg2MA2IkLbNP36j/gEss=;
        b=hrvEFZhDihQHNcUs1xiucrb+VWHlDF+jQHTmsx6hK0y8koG+N4FzOAXzZnFIyG68UM
         dE7HjpxD0LmKeWbEsRuG32LaN4hFwdCkysBG/Xu0y8hK4Klqgjf8vjhlK1cAiCeFDZXP
         9Ic+vQzn8K4zzxzx2k8MUo48sLYzl160qEBI+ub2/aZ1BcRhjN202zQ5+YqdV3Z8UHDU
         0o3DZW0B18vPnroykxMpRcbh78Ug0HgqPcdOT/TXl1FLDQwlgTBqZkM3Hi8txNPNXi38
         eqDiXC0ACtfUjQ/bQ/FvLTfKo9IOXnLIU/SG5RcfQ6PeCXfjY2j/8sTzZAi1r1ViuZcD
         CNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX50dwT1MgXsfowu3zds3++l5EtN01f9wSrjxgkR7Ce7ngZ1ArCSf4nRjRd+HgCdb8AhK5JAL/eB6GT4ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Kx2kSkhiM90kQivXv/hlI8uENK1quET400LaAcloZIk1s3Tg
	xVCm4v37YkFGn7ZDKw8QnSrMnGzI8LqLsr37IDAlfx8GupAHNgyYKDwWkhtw188=
X-Google-Smtp-Source: AGHT+IEB70GCebAhFLvFL16d0ZUPWVH08atumYvquHryLNwf9YYWZfC5o6C2i612B/sijw2eCz9B3Q==
X-Received: by 2002:a17:90a:4e0a:b0:2e8:f58e:27bb with SMTP id 98e67ed59e1d1-2e8f58e283fmr6404631a91.8.1730067422109;
        Sun, 27 Oct 2024 15:17:02 -0700 (PDT)
Received: from codespaces-c8bc9f.dxrpqgqhlb3ehogrxrezr215ye.rx.internal.cloudapp.net ([20.192.21.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8696918sm4590721a12.48.2024.10.27.15.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 15:17:01 -0700 (PDT)
From: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>
X-Google-Original-From: Piyush Raj Chouhan <piyuschouhan1598@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	pc1598 <piyushchouhan1598@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13
Date: Sun, 27 Oct 2024 22:16:55 +0000
Message-ID: <20241027221655.74885-1-piyuschouhan1598@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pc1598 <piyushchouhan1598@gmail.com>

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


