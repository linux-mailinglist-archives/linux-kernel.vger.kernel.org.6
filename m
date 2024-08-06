Return-Path: <linux-kernel+bounces-276075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C0948E17
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D17B245B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC61C3F17;
	Tue,  6 Aug 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHJhtWiB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C461C233C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944960; cv=none; b=Aqn3yBKmdsrhdh/7DDkiF8r694vGDJ0Ow3/6fZqGMmunbps3HCb7PmVJzD8nCCdwM7wejpS5eu1OQKXDjfCFI1LQrkBLFw5O/8iarfoSTbLTizLBJGyVVOXwocJQBluzJ3YVD/DLffuYeNIaEXUHaHg+IpsPjgiRveVvc2pfmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944960; c=relaxed/simple;
	bh=HK69OtcF/Vf94b5GhLN5TCYnV2gFptY6A3zc3NCas5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJ8FJcoK+ZjL7VaEEpD0/NlbQOGGALrgphbUQN5gJHUlNy3EIs00TLiVCnPSXf9VuOGF7mM9dddTbKo8Gb4plALLiGhVKYGK1FskNeHPTbKg0NUmEfIgEY7/Jij3KpBC2D59R2cUZE8biLEwADBWSSmhXLVe4dG4ipzB/7dOXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHJhtWiB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428119da952so3915195e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722944957; x=1723549757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXVpYau+0lr9R+A94wXB50FKZnvpt0eTOY5VusN/TE0=;
        b=YHJhtWiBMuEBA1sx9mWsKQSG8KgA2U8hzYVTChGZa1GE9v84iSM1j2kLcwJQuHI7KX
         TAbWpKfeTntfrlzjT7IiOoq02UIP8eWJn33ZsWwhhyREqqnqCCgoQiLvzMeaMvDVMotP
         K9qycpyFYPSwaKwidIG1JyqoFk69OuK7efFEqqQuKLHWyzq4/r+Le8FqqBq1+lmCy4zL
         9yLRXV4AI40aqXBZSbelqzjruqTu9I2SIWD2eDMi27BNJNMRpNDTvicj0beZtOiuHcHq
         +ehXASoKwdSRf3xjvyZX/0yxb7fMVM7xYZb/8P7SDhM8LRk+yogFnfVdBouPIQpOGY4e
         jGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944957; x=1723549757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXVpYau+0lr9R+A94wXB50FKZnvpt0eTOY5VusN/TE0=;
        b=R8faJNjpD32DPM95Zt/9ULxpve5LtGhlHpxDe4MQUd5gVGNQRJPmDjENXh5eBeejKw
         E//586Ewf7F4Zqwl5W2TwI/aZYRxVbFcHgmLFjLKZR13iRWoyP1oEuWGGdxDgOqnYwpe
         zUXBztwTK436FeWZWfLILny4wg+8+oaccC9MYRgH1UbNcMaXbZD1m8aJz92qFl1s0MKk
         BZ85Ti4exJK4rUBAQD7dO8pA55rJuF9vWK6CS7FXNHqPIcz3vnNQhk9U/4TkrJfC8SDN
         4VCHI0Q1pWrtoSiiDOddMTh3oKszGniG2h6EZavttNrVeQsBNVviKPpWYpgJtTiwb+Q/
         DQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuubFTHjE6rzQ5Uo2OePsQmzyKSysKtwdFyee7W3N3fZLA5wBau0W8thoJHp+3h1eL8lgKax95iEFr8R8g7LVYNI0EohWu/UF+SqaA
X-Gm-Message-State: AOJu0YwZQNuHzlxVGoVyLjdj/P4JQR2XJsBvQQGY5xwbN9xDmZ0Q+9g3
	MFLbfyuPMbslEdEGAAktW3aySbM27lT5F52ZMqAplQkuuNbe6mGv3XmL+IEW6eI=
X-Google-Smtp-Source: AGHT+IE57sgPG7MXWgWPSR/NBtN6707/MUX7FS0F0l/Q4cnzEb2aq3Uun92NAyWQJVWdu2uJJE8AgQ==
X-Received: by 2002:a5d:51c1:0:b0:367:89fd:1e06 with SMTP id ffacd0b85a97d-36bbc1312c6mr10073817f8f.36.1722944957105;
        Tue, 06 Aug 2024 04:49:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9d887sm177773605e9.43.2024.08.06.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:49:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org,
	Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd937x: Fix missing de-assert of reset GPIO
Date: Tue,  6 Aug 2024 13:49:13 +0200
Message-ID: <20240806114913.40022-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device never comes online from a reset/shutdown state, because the
driver de-asserts reset GPIO when requesting it but then, at the end of
probe() through wcd937x_reset(), leaves it asserted.

Cc: <stable@vger.kernel.org>
Fixes: 9be3ec196da4 ("ASoC: codecs: wcd937x: add wcd937x codec driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/codecs/wcd937x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 13926f4b0d9f..af296b77a723 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -242,10 +242,9 @@ static const struct regmap_irq_chip wcd937x_regmap_irq_chip = {
 
 static void wcd937x_reset(struct wcd937x_priv *wcd937x)
 {
-	usleep_range(20, 30);
-
 	gpiod_set_value(wcd937x->reset_gpio, 1);
-
+	usleep_range(20, 30);
+	gpiod_set_value(wcd937x->reset_gpio, 0);
 	usleep_range(20, 30);
 }
 
-- 
2.43.0


