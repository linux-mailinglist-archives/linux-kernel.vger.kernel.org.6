Return-Path: <linux-kernel+bounces-245374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA5F92B1C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1392CB22343
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577315218F;
	Tue,  9 Jul 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud6+g4M+"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3113D501;
	Tue,  9 Jul 2024 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512476; cv=none; b=cdH52J5CRrrjWS7ZsJSfxhuIuGX8V0MbzdkWOL8gCaFIPTGnzs4wZomfEoXVHctKRwKHsksT/3URb0MDuH+0pc3qQX/I+plY98UJCgw5IGRZPuz5mgDgRjKzEGljLOR2rewKHpncOUMy47/AFKtJWTMAy8GjJMPdciSF46kH+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512476; c=relaxed/simple;
	bh=4VYXG575vsuFDE0Ck5ILOQlfJw9aWWwTdAVO/JE5lyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+KUQZ1SofTOLbN/FPRWLRS9QNYs9gjk1eGDlnchuRn1WXTJQn9/56SgVjYur5yUP2WImSMGY0I6RHSJX0cOHAWLKfFy508IJfIoA7x1xZnn6RbMdgA1ZJ7a+FGyYgYQC7zzU3LHxfW0LmcFEcCkUo6TFVB4NSqxCB+CMKzdQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud6+g4M+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso273820366b.0;
        Tue, 09 Jul 2024 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720512473; x=1721117273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmvRV2ggoxO09rhHj4T5aXUjNwfGnDRzwVuCRGax5ME=;
        b=Ud6+g4M+/jIoeoQ8x2xp/bSiRSxEHGra00Ul2yirh7cRbOtf/yw6reWlpFTOwQocLv
         p5H87h8LapuFACtrqMKWpaNmU3g/T4f6LGiicN808dSYYdPfiO8hDy0ohqg9zeR5Q+jO
         M7VJUuP2PFj+kpSIrR+pbuBajLUuAHOBpzLtDZ0sU+idtXabdbiMnNma81r12kbBTRpa
         o4ifq3YAvIbcNhrwh/LLCiUWa1J2T11aYjemWtOAytwPEeFSUtwU1aTImhD1T+MnjCUM
         Pukl52xcQ6+OYcPXCogJaHEDGt4RgyJFb3TNNhjuVDSit0DVOuo8p3u7KYIOPFJJS2wO
         d/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720512473; x=1721117273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmvRV2ggoxO09rhHj4T5aXUjNwfGnDRzwVuCRGax5ME=;
        b=LnwyfXVQleci2oeJEMezXWDYb43J0uhKk4unmvfcpUOQOQSd2ZYnscP8wd+qDNqlF9
         fXVQ40E35uXdiRRO4SjSrExDEbd+7DDd7eg6nv1UAm3p6czAdVJJ9TWwd4888L1giACg
         RAggFyeLMjHzXDvQGHpu71FxsxRC/V7A2CmKCO2subV4H/QGYsUoqREQq4QE9n+gACbn
         uE3ccxU3rDqMClMHbIgQIXgWDJQzOvjs+p6OWFr8exkTelElll0G2Kb10DFuw9Vb3Oj1
         umbJYQ+a4tjOS7CrO/V8N2WdYbJg238nBgDTOB80aEmb8GhSEDiejaX4CodqqhtxU91g
         5HyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvDgvCh+x9V0JzRaCsegwytLutBeV/LX/Ta1IePuv+VbzZ3HR++oTYaf1iWwnBYMMhVgnKDcjQwv1OGLfubptJBBjC8FJJiYzYDz7b4OgOoY/P3ADMux8L7g2Uzap5YFd++BP/DGTOJjo=
X-Gm-Message-State: AOJu0Yz0eVmowAyQefHI+G8q+2QTfibutBHcmnz9AZ/A/R+BqWoZd//e
	m7U7wFAv4CW85ENM4Hm3HAxzkVYNPbQtkcgpRaQNXBbZlXf40n5v
X-Google-Smtp-Source: AGHT+IF4ro5yi6hn4qhy/Hzry6x2EesR4+h/zoLPK0I4aOo++8fbyoFmy06calfDx50VXZzeXoS6bg==
X-Received: by 2002:a17:906:6810:b0:a77:e337:b1c with SMTP id a640c23a62f3a-a780b68a26cmr95664366b.15.1720512472483;
        Tue, 09 Jul 2024 01:07:52 -0700 (PDT)
Received: from localhost.localdomain ([109.207.121.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a86f62bsm56795766b.199.2024.07.09.01.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:07:51 -0700 (PDT)
From: Nazar Bilinskyi <nbilinskyi@gmail.com>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nazar Bilinskyi <nbilinskyi@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP 250 G7
Date: Tue,  9 Jul 2024 11:05:46 +0300
Message-ID: <20240709080546.18344-1-nbilinskyi@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HP 250 G7 has a mute LED that can be made to work using quirk
ALC269_FIXUP_HP_LINE1_MIC1_LED. Enable already existing quirk.

Signed-off-by: Nazar Bilinskyi <nbilinskyi@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 811e82474..57eb67f05 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10053,6 +10053,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x841c, "HP Pavilion 15-CK0xx", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x84a6, "HP 250 G7 Notebook PC", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x84ae, "HP 15-db0403ng", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
-- 
2.45.2


