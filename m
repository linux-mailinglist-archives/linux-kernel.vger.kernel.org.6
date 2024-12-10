Return-Path: <linux-kernel+bounces-439527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CE39EB089
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E76F1692A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF01A239B;
	Tue, 10 Dec 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOHM7UND"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F11A2398;
	Tue, 10 Dec 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832694; cv=none; b=ly0qk9VqptnUzg/ohUg2CKxhUcUOxoOSpgVf1Iz4lo64WLCQSWM+tLuibuywohOKZGcykS4vI8NE6kQjQgoLuOw0H9Jfi5NoY+YU9WY7eCpCpDLqLNK7BjlQbk4G+SYhbFyxxksDc9uPnr82ud3XLZnSH7m4syuXKtb/hDSWyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832694; c=relaxed/simple;
	bh=5QcZLHny0olE30ytkp4MH8IjgwzPeDI6yCw7Kv0u32s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8sxigPmc+bqXptxRFUV4gvTlBnxNozZeq8V3VDof9XDlQO78I0uopLFdhNlb3GvMkAsJjf8y3BCkLz2zrfcXtiRoH21Y5imyZ9ZvmW4higRjVviBrYINW3xA6MLEd9NdYGgIgz7R7DCNDdAaGT2kcX83+YOndW1iUHOzgOC7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOHM7UND; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728ea1573c0so66946b3a.0;
        Tue, 10 Dec 2024 04:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733832692; x=1734437492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SbFr1LH1Hb+rihMpff4bIPu/Em9rs2b4NG+Lm1rqxg=;
        b=nOHM7UND3K4apnh7qaoWYrwsqJy4XkVa6Dc5qRRgpti7yMRqNOdC0dwbf3gFczwQBR
         pbBvZfWtcefDpsumDtHTAhK0ZQCMOq6XoC4oBEwaDtrzl8P/ymOC7NHBLMohYOMdL4Hl
         8C4XpFiFOc7qXtP+ZvmwKt9oNG/AcSLhhrAG5BVXz6zzRF1Lyr0u4MFPIzuw4UxBo2Bn
         qU4Ym4jCuvLtA2lnU4clUYijhrnm4qTSC/EotvVQWi8MpfFf7xSn+hUiflFon/LIzgxx
         unAdJcU+hhG5OHYHEzd/7ucdtPFKbLYuRjRlnhpJpco8kXzJ3VOTk3u9vQ4f5SVH8EHt
         f3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832692; x=1734437492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SbFr1LH1Hb+rihMpff4bIPu/Em9rs2b4NG+Lm1rqxg=;
        b=XVraU5rvTs1fKeW4C1vxKdP2CKTJ8ouxAm9208Nndm1V4d+DF/KCK0X8lB1AfpqQq0
         w6m8rX3O57s4tL0Zlm8stW5VUoaPOmALwu9A10J5mKfdTQ3Cvad5oQ53nyMDRWh+768X
         XM6TCZuAr68GHFIUrNJONpOMk/01NrWjWliKVfrM/fxwj63eKT2Z7QX2N0B9Y72uGW0S
         YBIR4Dw98ssKfomlb+zv8i3I2rhdGEdDNJsm7rkyY7tqkZd+CW1IjpD7abrzoM9FFbZe
         RX5T3pl7vs1896rFbthtP8ONd+ul3RdICqedsgq5Gf8yXCk47nlPqNbZXagzNfOwoVvd
         zlCg==
X-Forwarded-Encrypted: i=1; AJvYcCU3UC0rilfqvJGQHqzr1xAeQHVLJpaKdjgXrX9ahVi7E1uC3Md9Qd6xB0Rbiwtl9ZWvoMCZwwUv7Y0izCE=@vger.kernel.org, AJvYcCUocE1yGVmyFbm3SsPI70Ng3W7t2HorbsgUTy8BKAOc4uCxc/Fd0RqEAf9gYZ/LiiU5uvwc3ZPL4XOSD4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdD3jI7Q8j17hrVTURsu0Lr9+Af2aPKM9H13qQnG6RDo1FtfUR
	oRjHZsHlfTfF28EiXHNK4AVjQIHACTHpujFbBXcn640v72FBmpZc
X-Gm-Gg: ASbGncvMbl21sez4TBGsHzknmg5h1tGRrFiO2IQ/i14f+12ezprBRe5EpsFZSf/8gvG
	Y753lhtUIjdf2WYxgcuwsrIpYeXkQZ0xF8r6vq54aIM02e7W2/KANaFdIx6JCzTm6Oms+naf45D
	F8HXompVaCJkGeYBGjtetfiVrjv+F9WVo7MhJl710w8E7UlNN9o3zbeq3lYzHP6Y1zgpPfaaaXZ
	dsTEf0EcgKd23Sr3gM//z9tnZLcPfEhnzu3HxohrkCnO5iHrgfLS5SRPrwBTtHYriQ=
X-Google-Smtp-Source: AGHT+IH+CqGieM7HRhOP1D3Ye7Ty1n33UunTr12BrSks4jwDDtU29vqdMfAogEVH/6S/6l/Zcv19Zg==
X-Received: by 2002:a05:6a00:3027:b0:725:df1a:285 with SMTP id d2e1a72fcca58-725df1a17a1mr15934686b3a.12.1733832692014;
        Tue, 10 Dec 2024 04:11:32 -0800 (PST)
Received: from localhost.localdomain ([221.221.237.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f1fba027sm3065316b3a.3.2024.12.10.04.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 04:11:31 -0800 (PST)
From: Yang Zhao <etoyz688@gmail.com>
To: 
Cc: Yang Zhao <etoyz688@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jiawei Wang <me@jwang.link>,
	"end.to.start" <end.to.start@mail.ru>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Fix bug where quirks code was skipped due to early return.
Date: Tue, 10 Dec 2024 20:11:02 +0800
Message-ID: <20241210121106.497223-1-etoyz688@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced the early return with DMI quirks code.
This ensures that DMI quirks are executed.

Fixes: 4095cf872084 ("ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD entry")
Signed-off-by: Yang Zhao <etoyz688@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index e38c5885dadf..9dfbcd00b897 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -23,7 +23,7 @@ SND_SOC_DAILINK_DEF(acp6x_pdm,
 
 SND_SOC_DAILINK_DEF(dmic_codec,
 		    DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec.0",
-						  "dmic-hifi")));
+							      "dmic-hifi")));
 
 SND_SOC_DAILINK_DEF(pdm_platform,
 		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_yc_pdm_dma.0")));
@@ -583,13 +583,12 @@ static int acp6x_probe(struct platform_device *pdev)
 
 	if (is_dmic_enable && wov_en)
 		platform_set_drvdata(pdev, &acp6x_card);
-	else
-		return 0;
-
-	/* check for any DMI overrides */
-	dmi_id = dmi_first_match(yc_acp_quirk_table);
-	if (dmi_id)
-		platform_set_drvdata(pdev, dmi_id->driver_data);
+	else {
+		/* check for any DMI overrides */
+		dmi_id = dmi_first_match(yc_acp_quirk_table);
+		if (dmi_id)
+			platform_set_drvdata(pdev, dmi_id->driver_data);
+	}
 
 	card = platform_get_drvdata(pdev);
 	if (!card)
@@ -601,8 +600,8 @@ static int acp6x_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		return dev_err_probe(&pdev->dev, ret,
-				"snd_soc_register_card(%s) failed\n",
-				card->name);
+				     "snd_soc_register_card(%s) failed\n",
+				     card->name);
 	}
 	return 0;
 }
-- 
2.47.1


