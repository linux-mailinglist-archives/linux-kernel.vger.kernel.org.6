Return-Path: <linux-kernel+bounces-357882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF299774D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D185EB23CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24181E2857;
	Wed,  9 Oct 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GgcjrlGC"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081501E1A0A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508318; cv=none; b=hQYxeWz1ysOFRjcWma8INc+RB7/90lIaQqwBUKUBkslM6tsREnnrDpzWi3iPa3jXLGqOg8U0gTaYnC7txlGDsdt/PfVo3+4MtreEyvEGEIVZm/n5d5b3TDtVaYchkP9CYhvFt1yqqjVZr19B8w7tvUXHgwHbZzpl6TL+UJVMvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508318; c=relaxed/simple;
	bh=0cV0cyyyQ1bZABKVOC7av6Ej39bBbJtonUrGUcTyX1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRZ7F36wjfvfPTmOcSyoIs0Ud1Y1xZ5ra2EAKC7tzdUA8kJdtpfpYXCPVJvqR1iBtLC7osiQImWfpQsVUpX8N40e1BfKcfBSKphCUAsSomZZO6p/AvQlYmoUMZBf54N/1x+2Nn6wjpkOA4U2l+KZHD3boURhel/L1IXesvURVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GgcjrlGC; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-716ab0c785fso70584a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728508315; x=1729113115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVFF0E6/gb9kFOjmVnyiMsngj2f6Uhyx5US2JDKt1a0=;
        b=GgcjrlGCLVO6ogpw8zjbBJN/wk13EsMrhrDITIgEgf1PhHLP7XeUW1RP1a3tI4WY18
         gvwRf51szIWuZAoemMkT7iugnQWj2ry429A+lN3ttNkDqxTLKn1ApORV4evFqL8EGTfT
         Gmn89D6pbqsoM9oQuJ+kKL8caM1SJ+Jr3DaiUQ9FN5yG0PE3lPdIYGkO37vzvxLXDkhC
         W8L5DoQgxBPvoqo9hIjO19AUrf6vf80eSJQzg1rbiiHctDCxyZlsWDQGHM7kaJD17b9p
         v3yPuBi6IjVozodTflg+zRhO+yU0U8+RULQFBfyXGGa0nxoENXL+C7H2KxVq33EbJC9L
         PvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508315; x=1729113115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVFF0E6/gb9kFOjmVnyiMsngj2f6Uhyx5US2JDKt1a0=;
        b=AoTVQQGZzcxcQ+0n/CRWPq8mgxh9nfxFqqGaoTAO/C0gTRMOn1d/OHvHf0ecQxuba5
         PCMJRDosKFqEduTwTroJIAjb7AYHEM2N4Vmu1XFxQwbeNeWFM4LBJpG0pb/PKn+vImfQ
         vIh1ebQPLCMDMB7JQrzFCYb+U9oXpUfs5unFTINIzl6H22yy4XEjK8l7VqCiL1DGa1yj
         zco0NB1EvAGR6DKKp7ROfDtmisNZs1reAP2CLVzxF7zn2dvFQNWQuoFOxwDlbxvUcjya
         lifIs9jAJjeaxjyI9GHVcllnxwHyksgkk/nN34hFbYEaecQAxMdXEFXy4CGNli4C+1a/
         xdnw==
X-Forwarded-Encrypted: i=1; AJvYcCUVr5o//xRQEQGDUBLYwCWTSt3H7mUtaj7BjLqODsIfIFJYnJdBH24d4rMZiTgXEN6Q6xGCerFH4UGprGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAfnNHEI9RwOIexDpMb2TFs04w72dKehtziLqjzZxHEdqiQwQ
	yc6vonOKawMtIf/lY/mh5EIXGHvG7ldkTYsgrR7sl6/BsBEESHMZkJQlj9+aG6K2+vHwinM8swu
	5
X-Google-Smtp-Source: AGHT+IEvJZngVeGRk73y394qZT0oT0wpSwPHi2bTK3SdGZFK1isXZ+7q99wfWlKZqLS1SWgXBcDzAQ==
X-Received: by 2002:a05:6830:6c0f:b0:709:3b06:d578 with SMTP id 46e09a7af769-716a4218490mr2332056a34.26.1728508315134;
        Wed, 09 Oct 2024 14:11:55 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7155688a874sm2455747a34.81.2024.10.09.14.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:11:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Oct 2024 16:11:50 -0500
Subject: [PATCH 2/2] pwm: axi-pwmgen: enable FORCE_ALIGN by default
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pwm-axi-pwmgen-enable-force_align-v1-2-5d6ad8cbf5b4@baylibre.com>
References: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
In-Reply-To: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Enable the FORCE_ALIGN flag by default in the AXI PWMGEN driver. This
flag makes the behavior of the PWM output consistent with the
description at the top of the driver file.

    * Limitations:
    * - The writes to registers for period and duty are shadowed until
    *   LOAD_CONFIG is written to AXI_PWMGEN_REG_RSTN, at which point
    *   they take effect.
    * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
    *   enabled channels, which could cause glitching on other channels. It
    *   is therefore expected that channels are assigned harmonic periods
    *   and all have a single user coordinating this.

Without this flag, the PWM output does not change until the period of
all PWM output channels has run out, which makes the PWM impossible to
use in some cases because it takes too long to change the output.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index e1ddeaa4998b..4259a0db9ff4 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -37,6 +37,8 @@
 #define   AXI_PWMGEN_REG_RSTN_LOAD_CONFIG	BIT(1)
 #define   AXI_PWMGEN_REG_RSTN_RESET		BIT(0)
 #define AXI_PWMGEN_REG_NPWM		0x14
+#define AXI_PWMGEN_REG_CONFIG		0x18
+#define   AXI_PWMGEN_REG_CONFIG_FORCE_ALIGN	BIT(1)
 #define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (4 * (ch)))
 #define AXI_PWMGEN_CHX_DUTY(ch)		(0x80 + (4 * (ch)))
 #define AXI_PWMGEN_CHX_OFFSET(ch)	(0xC0 + (4 * (ch)))
@@ -227,6 +229,16 @@ static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Enable force align so that changes to PWM period and duty cycle take
+	 * effect immediately. Otherwise, the effect of the change is delayed
+	 * until the period of all channels run out, which can be long after the
+	 * apply function returns.
+	 */
+	ret = regmap_set_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_FORCE_ALIGN);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &val);
 	if (ret)
 		return ret;

-- 
2.43.0


