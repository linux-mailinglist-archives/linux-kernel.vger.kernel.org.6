Return-Path: <linux-kernel+bounces-211890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0757905862
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9B8288EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149CE18412C;
	Wed, 12 Jun 2024 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcNiMBr9"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1081836E0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208960; cv=none; b=G46i/akq/E8IDYBIrNETfBKaS5CJftHYOdo/wCZdAqgtYmHk/9cJGq9lAejvOrXVIC2JkB2m8x4RHmjFHnXhe7C/+wnFRTDtlF9g4D15oJG03aJ6uHSYPqN/YcLe5BrqVv+bG9fRPyoxHHtC09KicxQ6Ti0JA6feqGEEKyJXCp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208960; c=relaxed/simple;
	bh=/rK5N4p7lzNbPikFsCFIG2uN9Y+xeaegWompkr8S1aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUx1rwgmBy6jXt0bd/c5XUUWy9u0z3+JR3J3gDKnf2Is+vIZzL7y92Mk+tf4C5ocnrxOMdva9h6/wikvxMxQ+Sno0/lrT39RpYhPtz5bSEgOzmq0bExHxMQFfPZ4NL7SNulS1irnjOhNTsfN3+ucyimVUI3vSbrYTIzThhazJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vcNiMBr9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso7178566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208957; x=1718813757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iEo4Md295/OTL7Myd2RIYbHSuX6XmNxZdXGojd1Rgg=;
        b=vcNiMBr97URpcr+V1oUDNhrphNF4Nq7oV1HxFXiaH5pjpcysYpcLiaKkYSfocp5X6c
         26629P2s3P81Ikcl1YOYmZyo/I9BSR7i1fvbA1E3xreyZ0VcoZYHn8sbZJYFB0OfNY2k
         jtHH2B7p3anzUsmRYcHP2AF1MO/3IqgsDvxwIRWDpSD3cSrjFLZ81+jHm6Z1Z/2/2YjY
         nl1EQjzPfVQHzyk6ZW5cbIb1Q0BxXokobKi2l9x6xO84R/+9Zy/cQdzJJhjEn8fSjoGA
         TpeRNud2bxj88IvWOPqoqj0lbhrMhKAeNqPQAFZ7XJuHSvZxAhTAj7UEtCHE3tP+EGKi
         B0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208957; x=1718813757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iEo4Md295/OTL7Myd2RIYbHSuX6XmNxZdXGojd1Rgg=;
        b=jaJj2ixQC0081bMJ73/DdymmadlQzpV8OfDigoN+qjqZ6cjozDrxBaBngm7M4tRZLU
         sheJWQvRooaiYJFO88BcKC5by9FJM+DiwHUgtm2Tes/FPnC+d+AvgqhP4A8dpU64EWqx
         oLDueLDBqqDIg9Um+gwsPv3sHlRa5YvrxSac1PyXVUTZI7ufRAwhn6P3eyyoy0u91Pt+
         PThppf3tNvonPHNOxhan9TeqMg4DIzbbV55/1ZvjGTxaJ/soNhrxP3C0cCjtobIOVqQF
         pIwhsPt2XFZgSFyksQ4ahPOt5bE5Yr30HZCQAieObnEnn79MjjBlgg5kaRTTjUlMml4f
         rEXg==
X-Forwarded-Encrypted: i=1; AJvYcCV7eiGAc18Y6gtfhQtnpTaWk3x6Cm5+qYI3Jvn9DGTyo/K9LKtk/GTPkojDaqTqi+0FQhWBO+pi40puUJ1S8lL8gUayU4j+60IuZwJ1
X-Gm-Message-State: AOJu0YxOidKi3mtEb/8WFEP/q2vXEzGTL0OI72nmCtbyLFZKN0egbU0n
	QV+bVaR5FExZ3FN0FMUCdAkfKTsKbhP2hBph9A/duJuR04w4qKAKfvBup/Md/1E=
X-Google-Smtp-Source: AGHT+IEy50S8SITZi3bjq2DbDVZcQs7pImUEBnzlSKFFftxfcGZSuVKB5uF7YIpLQwSbQnYIWU2E/A==
X-Received: by 2002:a17:907:6095:b0:a6f:526e:5f4b with SMTP id a640c23a62f3a-a6f526e6074mr3480066b.14.1718208956973;
        Wed, 12 Jun 2024 09:15:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:24 +0200
Subject: [PATCH 11/23] ASoC: codecs: wcd937x: Constify static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-11-0d15885b2a06@linaro.org>
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/rK5N4p7lzNbPikFsCFIG2uN9Y+xeaegWompkr8S1aA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmgfrAvN9jmrz3zOenScYVJk3VRxnk6Op1wW
 DYK4/Iv3s6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJoAAKCRDBN2bmhouD
 11nsEACB2gWgRhL36G/IHrTBMlWrvaaF6KR0xQBOPCetIqklAbL8fvnh5L+rf/eDEw7kCYPy3i1
 i8mw4seuiZYhJpCwAWrJcD4hogyGtwa3B+af+/pXC7YaaKJBAuKUlo4uj8dbcpc+yFml0P5VXiW
 /E5xGbhl7xlKmkIHhB3Fhip/r37Mlj38RPzTVQexKwR4Foys73xWfcgY5e5ZC0FLjdLlhI9wptF
 0sKCLx9Es3zFxAl6S+nIqF19JhYlBnNDTmHHRw6zoDhVUCWbR5aMbqn8srovfpnMJd3c4rDRMw/
 jMbnGB5l6LJBo8nzc7ljuV6fo4Wf2/0egGaDmLwXw+VjxX6gWBKgc9MK+OvuwLacXrBmkomApL5
 NvaCJoiITxa0P27g0tEm3XiHJcAxICk9t4ZcqIF101QeYnSi1k7abnSRczKemTS/AeqwKIo4olM
 elHbe21+/y0LLq1L+f3313qf3BqcyygVeNR0gZWyyr/S2cOwJ4orxqkZegRrYxi/WygfbXzNG2y
 xvyW9YaAoxf6/kCLKS0mfOrkGF0HTNwBI1QA6IBDUOX7gmSOr9vs8aWzqh9H56ZB9e3mDAlt7cg
 YxQTfHb7S5PoUeo6vU4qJnER0AmKMfuLS23dc60tDw7AsRQMiiZ4ag0tFKGX378yuf/yTE7mdRU
 Iq7SaBlQ+Oks0Vw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify few static data (MBHC reg fields, IRQ chip), so
make them const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd937x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index ef649ed77fb2..4cf17d62a0bc 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -133,7 +133,7 @@ struct wcd937x_mbhc_zdet_param {
 	u16 btn7;
 };
 
-static struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
+static const struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
 	WCD_MBHC_FIELD(WCD_MBHC_L_DET_EN, WCD937X_ANA_MBHC_MECH, 0x80),
 	WCD_MBHC_FIELD(WCD_MBHC_GND_DET_EN, WCD937X_ANA_MBHC_MECH, 0x40),
 	WCD_MBHC_FIELD(WCD_MBHC_MECH_DETECTION_TYPE, WCD937X_ANA_MBHC_MECH, 0x20),
@@ -227,7 +227,7 @@ static const u32 wcd937x_config_regs[] = {
 	WCD937X_DIGITAL_INTR_LEVEL_0,
 };
 
-static struct regmap_irq_chip wcd937x_regmap_irq_chip = {
+static const struct regmap_irq_chip wcd937x_regmap_irq_chip = {
 	.name = "wcd937x",
 	.irqs = wcd937x_irqs,
 	.num_irqs = ARRAY_SIZE(wcd937x_irqs),
@@ -2503,7 +2503,7 @@ static irqreturn_t wcd937x_wd_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct irq_chip wcd_irq_chip = {
+static const struct irq_chip wcd_irq_chip = {
 	.name = "WCD937x",
 };
 

-- 
2.43.0


