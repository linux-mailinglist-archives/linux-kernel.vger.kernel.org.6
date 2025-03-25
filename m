Return-Path: <linux-kernel+bounces-575590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A62A70488
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8792188DD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0192925A326;
	Tue, 25 Mar 2025 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5Xv1Thi"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C781EB3E;
	Tue, 25 Mar 2025 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915118; cv=none; b=JM5DaNxXLBuARWBy3JPFgyj+JtdQXzkT4ZSnRFHaQlQU/jhCGdisXN+eUinFKBcrkL6qcW4WDM7XQUM1+NrVPL66X2NC1kuLYZ76rULHfoUGSR4omp1woN8LNFfZNqE9byVIb+smGwr7gxxNvvzYTV76LA1xOHcc4U51CG/tk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915118; c=relaxed/simple;
	bh=xm5YteKI5jO3OTAAhxdRHYin5uAOhZ+7H+TKvjsGoOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZ3/GqILcYJ08mLmoSgKyvQ3M5+8gn7ZdSeDzH1gpL3i97wglL4cnkh1QEmguVDncfqAPmPbYzDYurgIaNZqtc+8ovKAiNOfrBCHosAKp3AcQmjvMPWWZuN0cfTfOQ4vlL5ra1E3eUt1Iya+VHhBt3KIpc8UIeOtphwaKjNj1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5Xv1Thi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227aaa82fafso59856395ad.2;
        Tue, 25 Mar 2025 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742915115; x=1743519915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jWxFqrH9YL7/eofO5H8remEpyysGR/mTITCg0OMFQQA=;
        b=X5Xv1ThivUKh8Hj3wBPTAitwS4f0s9VCiDMIZEhg3D8ivrwxiaO/M0s1PLk4SWBd7N
         TwHoZE8TpK/jgRBoUUzdof5p53UvsS6sSxPiIHlCx3ypXzq1iN+Deoku3kYZGlmwY/Aa
         AXgqUFqmq6f3V92wfQjSFwB18VzWSo9SCtoacA8zSMLNwZhaEGnK/ic42nr6Oo8Cv6t4
         vcYQoaqIMdZR7FQDrWEvHMlt44UOQg11/xb1DkShs6n/8AoSmeCSxXbk13otXE0BWfAj
         3nahJ0ZSm60MLS4pVRoF8qbDybc8Lm4+R3daluhOxhd4WiBjwezhR7X7XHLy94TdV8AE
         zxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742915115; x=1743519915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWxFqrH9YL7/eofO5H8remEpyysGR/mTITCg0OMFQQA=;
        b=ro8m14SRgsApB7gdhIdMPApIwRHP2it2ZluE74+foYj1uK5dk4eP3vpPvo+Szc+WRb
         QmRhlb3BGw1iCpdTbRP463AkCJWkUv8h9G6qQcqRit8TFDo11pozJGqDRwvvAhmtySfj
         wCIwG1lMhCfxgDq0EKHdXPJfAyqEPVtM59zl5danTtbmoHJQ9gRosjqfe4SmkhZ0fxSR
         JbzE09roNy5fG1+Sp6N/9YaCaaaASzjr7f+ldcayUnuXHaf/3moNcNyAS0pP1HKvLoB3
         7pEQxMuWZKClUv8AMz6FxLDxba9t0tY21ZlBV9RzDN3U53yRFKQxHxpSC/Eh7oF58NBW
         l6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUc/4msoTaAo9NgEFk6ttGPVd4qrju9a+AHZ56xDb45tlOcZr2Gxfecz04hR4RxwlECjxZfk18Ewir7RmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/XmxVabk/D3KvefEVLabe6TVihZTlzrsg6kK5UiYx5w8mTmS
	OiRwo0xyInzIr5PZLR7IIDbwH2Zq4fVrvJEgTJuU9C28sFIWyLVP
X-Gm-Gg: ASbGncu6WGs+mOEigYJK2Ee4sFDd4EUuFOkX0lyXSAiQfskpD11m2q5dDUSD4K8G0ro
	PTJWmFFjtIE/TiWY4qjV2cglPVBkyJ8M0Pruj/w9tHW5OqiX2TK2j4F5cwpy5a/Yf+hLWmCrlA4
	b8/XFFFRbOyA+VvaZs287j3srDo1Xbt7/uuHkNTMEljcL0pLYS2LPhUHHmpbkYRz0fJaS1EeEmz
	6c6zf4ed+/qHqcCBlZxtA9P3TvXVV1tx+Q+oLyw5oNKZsJfZNheUwxiDfZ3e1D9kBi8V4kCHBm5
	qbmBqUHsjQtAJnZYgjSZMCXgNk8OsDgA1nD0XwZQRYcuxsoSsw==
X-Google-Smtp-Source: AGHT+IEbgo3Hy66xsrTg9MyfAa0va92/DyNS2eEJDABFCbZ4iS9Zyj4XDtelwQfOL8CYWqpdLvIuvg==
X-Received: by 2002:a17:902:e549:b0:224:194c:694c with SMTP id d9443c01a7336-22780d9bd43mr314595225ad.28.1742915114714;
        Tue, 25 Mar 2025 08:05:14 -0700 (PDT)
Received: from localhost ([2401:4900:1cc8:c20:fcca:cfc0:f5e:747e])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f45e1asm91021775ad.80.2025.03.25.08.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:05:14 -0700 (PDT)
From: Sharwesh05 <sharweshraajan@gmail.com>
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sharwesh05 <sharweshraajan@gmail.com>
Subject: [PATCH] 	modified:   sound/pci/hda/patch_realtek.c
Date: Tue, 25 Mar 2025 20:35:10 +0530
Message-ID: <20250325150510.31452-1-sharweshraajan@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 sound/pci/hda/patch_realtek.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a84857a3c2bf..8c2375476952 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4739,6 +4739,21 @@ static void alc245_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
 		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
 	}
 }
+static void alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
+					    const struct hda_fixup *fix,
+						int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x0b;
+		spec->mute_led_coef.mask = 3 << 2;
+		spec->mute_led_coef.on = 1 << 3;
+		spec->mute_led_coef.off = 0;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
 
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
@@ -7883,6 +7898,7 @@ enum {
 	ALC245_FIXUP_TAS2781_SPI_2,
 	ALC287_FIXUP_YOGA7_14ARB7_I2C,
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
+	ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT,
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
 	ALC287_FIXUP_THINKPAD_I2S_SPK,
 	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD,
@@ -10126,6 +10142,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	},
+	[ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_mute_led_v1_coefbit,
+	},
 	[ALC245_FIXUP_HP_MUTE_LED_COEFBIT] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_mute_led_coefbit,
@@ -10569,6 +10589,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx (MB 8BCD)", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a28, "HP Envy 13", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a29, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2a, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.48.1


