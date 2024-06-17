Return-Path: <linux-kernel+bounces-217335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E03390AE72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA6C2895D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDF198E9D;
	Mon, 17 Jun 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Na8Rj+XA"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9F198E6A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629062; cv=none; b=Uuvi4yJrKrZOuyOrn0dIczvgmvrsiH82zUdB4WoX36q3f+BN65toj032ZS5uFSdvgQq4A7FTb5kZPQhh/qCjmtUFzFroM5jdW5bD7aleDw6EhKL+eFVR2w/58H7IqX33rkeydBbzMngvYAvy/04B1JOfRdQLySTPa5E7eeZP8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629062; c=relaxed/simple;
	bh=/lItPURxNp+cgV/Wgl9KGudHbV4MInxrsKfiHjZnra4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FC2GrkMtyI3PnsbLr9+Nyvp3iX0dcoEM9dcY6232QRSW/ViXo8/mSi/ybqNZMaHYbpT4rb1TF1497rxkvCjJ5vX4XPDgE93EpGjjmmdg8t+MzPVEMz/Lup26tfdde4hBCjAcrUpl19hJD45UXic29PTTpTgfs/HK0FpoYQuqfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Na8Rj+XA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c68c3f8adso5191407a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718629059; x=1719233859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wltUW9+VLrM5U01BwAIqP+6lmMQklBsMXf/514OJe+Q=;
        b=Na8Rj+XA9A1FyHf7bd3U5PxdL/L4CQHc/XUo5tfGGPedwl2nCpfd8K4/uEsqmqP+FB
         s7CHVIz1CgqTYN88ARzgC4Tu8oWVH3O1ejWSuUDIldGl6FZuTXCI2hTgvU6pwwcUBYvq
         szKAuSWVxUFI0v5I4JZ1iKkYLjpLHylZWXdmG6aSlcFOvxaXri0vcGqQ2+rsLjJKCgz5
         TYQfr3bPHeZgjywKH7B09WXsCo6vtinXWPovOzwA/WCQnJSiG7RGZHFwEWQ3WR0UBED0
         m0jIGN/B81b9wyyJvAavXgYVW1BpYe5jcrRCMPz7uzopIJWqrzI1aua/i1xJhMA694OE
         Zwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718629059; x=1719233859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wltUW9+VLrM5U01BwAIqP+6lmMQklBsMXf/514OJe+Q=;
        b=EG4SMI8L7r41gM4IVPgcOs090mx71ztSDVkJ8q/fli3BQbb3vecCUXseLLUUFiYRsK
         hqZPUeQ79+yyIxtUQ7Y4nTaxkykNgSQalPPik/14ngsDQzG2rFFvenIEEf2R/Z5Gt4uK
         4YOyVfVXUkK4s9fsRuMLJubWiKj8xTSFBkk2htOUTpAqSB+jQB7riLn8ewwWXZnh3xrB
         F6BT+B2JGsYAG/NrXgkFf5ZfbWtwUf4BgjAfJKVDCQW2Xn9TinjWLIzJbeVgLD5uF55m
         H+I+hawWfu+pGxZVzycQ+IUzSRvaz+HbTO2PFTOSesEUp6Uoo8/TSOSWr9kGy99DWhnr
         qcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6d2y0SzsmvDQQDcA0CVKDNgpLdNZMlpjdvDiwWHMGkIG5K5cEV0XT0ShQNIHjBiFDv6jQkpfjKfqZVM+RVgfkBFlAFfSuAjz/++Vr
X-Gm-Message-State: AOJu0YwhHxwxm1xS04YOk6RQv343QiguQHHGuJlzWLO79DZCC2EbObEP
	WRH2veV0qGuWQqzZl/fYE/P3RvUSwsmuvNygutmXMIePWcJUefwF7CfbCPmTdyk=
X-Google-Smtp-Source: AGHT+IHGYIv40eueTM2EmQXXq34NC5RI+q9LQWXTkgQPpugKqiNuOI0eJtyNgnoQfTPALXvl5fhCJg==
X-Received: by 2002:a05:6402:5204:b0:57c:db99:a131 with SMTP id 4fb4d7f45d1cf-57cdb99a240mr4397657a12.29.1718629058691;
        Mon, 17 Jun 2024 05:57:38 -0700 (PDT)
Received: from krzk-bin.. ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7439070sm6428860a12.85.2024.06.17.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:57:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] ASoC: soc-dai.h: Constify DAI ops auto_selectable_formats
Date: Mon, 17 Jun 2024 14:57:34 +0200
Message-ID: <20240617125735.582963-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core ASoC code does not modify contents of the
'auto_selectable_formats' array passed in 'struct snd_soc_dai_ops', so
make it const for code safety.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add Rb tag
---
 include/sound/soc-dai.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 15ef268c9845..279223c4ef5e 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -361,7 +361,7 @@ struct snd_soc_dai_ops {
 	 * see
 	 *	snd_soc_dai_get_fmt()
 	 */
-	u64 *auto_selectable_formats;
+	const u64 *auto_selectable_formats;
 	int num_auto_selectable_formats;
 
 	/* probe ordering - for components with runtime dependencies */
-- 
2.43.0


