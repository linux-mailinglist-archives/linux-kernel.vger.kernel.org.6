Return-Path: <linux-kernel+bounces-515831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BAA36979
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AE41732FD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA491A23A6;
	Sat, 15 Feb 2025 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTATMNFR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45E13D52B;
	Sat, 15 Feb 2025 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577947; cv=none; b=XciDFuuk28fLVdcH9V/HxcCnzoW2uXgL7pP+F4wAnBEsruHA5V8xUSPjsFQPY5B22Cnn3P2QMi5IIPo1WKGF/m4pAatmltV/9h1AmMvNBOXBFkdz2dZpSpzRtX0Eu33AziyTpNWJKcRgLPl6nCBn9S4U6I9siyYOATkH/OwmShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577947; c=relaxed/simple;
	bh=h3JxMDwKaAS4Ilp8m+BiV4LRBVi3038MrI86Ypea7zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJA/33EUmv1a4FFe504xjqLK7Pm+pgnohbV+++mnizfMRCV3AznGB5UMaMs9VLf0zlQWLtNllgxfAdK6NUCzNc8RbQAtoBU/qHK5MqazI2l4SVTYWFP8oebJ83tS78gvDLaTt8bVuLLEjkaFqGQfSQKmgzPyVrad94C2ZnTUPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTATMNFR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f818a980cso42715375ad.3;
        Fri, 14 Feb 2025 16:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577945; x=1740182745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPkSjeZOPc9/OJBNbtlEa91pxyRki+1Mxp+ipEW3Y64=;
        b=FTATMNFReQ4Fqk08DpgiJmSTwAoc9Mt9DdIBCj/oB3BWUsFnq/8EENQaOGYJyu7N6D
         hDYnfV3Imyv5n5r3nZQD5wrzSvY5PN6rt5ulY91kaBueVe5lu4fN2g5tgHd+iMKELOuB
         Ixj5hSvQk/zCxWbw5i/dqA/wivdbMOVFfTNs+x2PdpvO+KXM1WhSAOHRdMmEaydn8/W9
         0ieKD6WXZspr5ayfxU+NQKOb+Sqiy1axbelfKU++VH87r4CKCqbgMhycDayn4ooO8qqO
         J0ULkRslR/hutTJ8XnrrmCpQj5feSXOdIEd236SwY5yH66yf3txEbf0qsws5HkUZlkHE
         XrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577945; x=1740182745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPkSjeZOPc9/OJBNbtlEa91pxyRki+1Mxp+ipEW3Y64=;
        b=AwWNPL5TrsN9wCk8xptzjG4uodQs9nZj6AYyg+n86x5qZn0aeMRKm2vJcgqZhZdIjs
         NN5xf9FzhtLz7XId0IM9Xxg2aMm3yPZoDM7w3WEPwSH63UvQK+glYHMBKEHQGFrKMlTu
         3PZ0zw2u/eYqDK4z79vMeO0qn+qfC0a7fEVmBQFoxK12GgElP8ZNRAxxsByLRxmgrOcI
         NzURHqlVFNeFftyF2TvmDwD7jVB8SlCXTmktuDeZsIbd7s+XZwiFJn4kBUBAoDMzrA7G
         06AKXArWib1Hmj8ojxiIvog77QvYJkPAbqf9Luk9Azt9xar4mZ9Y92nD+bOAruX+t/E2
         u59A==
X-Forwarded-Encrypted: i=1; AJvYcCV8Hc/Zrj8pYBr1BpO+CTKKIGaPTz8+c1gOynD1ygyszhb4dvOIx/aNst0M7SXHKMTmHhtsgX0TO5LmhmmL@vger.kernel.org, AJvYcCVjQ2U2N+6paLz2HTNNS6O3IG/J9UDSGdMycyVj2chN6fLLiPYKFJJTC+wIKjQYEadNQivxSIdSYXxY@vger.kernel.org, AJvYcCXyeo3V+BqAroiPf7IVLJ22fTDgT6N2B+L0w3C+ejU1y/pWYuk9nbwA4JOUmkuKmR49fTr/FRMx+vZgGQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFZkvs9ZnOviZKIN1EH4o8DlsnacOPfsTv20n9vUi9X/Vu44m
	Fi4W0rYAm19RMtry78nD8QC/YRiEFvF2U84ajtJbn6K/It6cbtLk
X-Gm-Gg: ASbGncsHAoYQhin2GIvaOVDS0YYVLdoCgvVObKcIOX+jt3s+UL4HJVodzAeCiUKNRQA
	41h5te/ZuAMSmUxODTm4qaeb7kEiLp+RrnFMc2jHhWdt/J4qEfffcOycBAqFJSnrPAfRdSbAO70
	tjZbymN0XUXtEDmBXvi5TD1tAnL25B696je17GDDoqXbd1T26Osmgz0H7GvosgPgb60FGPngBCX
	Le7bkW/KpbhucIzjUbbWfYfoJXClqDtDG1cUG4sgcfV7Oz9SRSWXYC63Hg0Ek9Nvim5HnlWtuKi
	be3moscA0aWqzMpuutGCjhD/H2jlzkspJSv/oGCrqvDm67hK3bakrXg9SRMMohwzAy+k0m6hNMj
	OsoH7Z3pnLQ==
X-Google-Smtp-Source: AGHT+IG6+3nLmsHdx1RmFdm91Qjq9AU8nruLrezbvXoGg+uGvb2vJNqsgjTQtxQnEV74jVfqHyDnEA==
X-Received: by 2002:a17:903:1d1:b0:216:760c:3879 with SMTP id d9443c01a7336-22104099423mr15221945ad.46.1739577944909;
        Fri, 14 Feb 2025 16:05:44 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:05:44 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:55 +1000
Subject: [PATCH 22/27] ASoC: tas2770: Power cycle amp on ISENSE/VSENSE
 change
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-22-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2645;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=tUylZZQOHhwL6PpQLa/BzEAlJvmGxPEni0WVBgk7TPA=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb25/vOKWxd/zZp+mdkt/aohS+pETnb7rfsopdeN9o
 V3/JuYe7yhlYRDjYpAVU2TZ0CTkMduI7Wa/SOVemDmsTCBDGLg4BWAiGhKMDOvX5uzT1zIqEFA5
 651kJlJqtStuU0Q0058qsdgQi4Z/PQz/jGsfHnQ0mLKLUd5qyt1vFznD3ztxTtm5S9HkM/uL6bX
 neAA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

The ISENSE/VSENSE blocks are only powered up when the amplifier
transitions from shutdown to active. This means that if those controls
are flipped on while the amplifier is already playing back audio, they
will have no effect.

Fix this by forcing a power cycle around transitions in those controls.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 30 +++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index bac34e1237ce2a5e25face47e0597617308f1343..d74bbe12dea49da376fc577dd144912468fe163a 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -163,11 +163,37 @@ static const struct snd_kcontrol_new isense_switch =
 static const struct snd_kcontrol_new vsense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2770_PWR_CTRL, 2, 1, 1);
 
+static int sense_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
+
+	/*
+	 * Powering up ISENSE/VSENSE requires a trip through the shutdown state.
+	 * Do that here to ensure that our changes are applied properly, otherwise
+	 * we might end up with non-functional IVSENSE if playback started earlier,
+	 * which would break software speaker protection.
+	 */
+	switch (event) {
+	case SND_SOC_DAPM_PRE_REG:
+		return snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
+						    TAS2770_PWR_CTRL_MASK,
+						    TAS2770_PWR_CTRL_SHUTDOWN);
+	case SND_SOC_DAPM_POST_REG:
+		return tas2770_update_pwr_ctrl(tas2770);
+	default:
+		return 0;
+	}
+}
+
 static const struct snd_soc_dapm_widget tas2770_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("ASI1", "ASI1 Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_MUX("ASI1 Sel", SND_SOC_NOPM, 0, 0, &tas2770_asi1_mux),
-	SND_SOC_DAPM_SWITCH("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch),
-	SND_SOC_DAPM_SWITCH("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch),
+	SND_SOC_DAPM_SWITCH_E("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
 	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2770_dac_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUTPUT("OUT"),

-- 
2.48.1


