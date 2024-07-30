Return-Path: <linux-kernel+bounces-267293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 644DD940FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4531C22356
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1571A0713;
	Tue, 30 Jul 2024 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WT8RJLWt"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB218A958
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335721; cv=none; b=P8ulsNmMtHnYDZCk9pBpwp1AlORGg6u/FhQZSGl9KfjlKYX6OFc4IpOxfKN9kAZapNQDfr2nlip5YPKvDUHdy5vCOmvAH5Gxo/7cHd6cr7sq3sDucB8pIMjhKTmEib3yg0CuADGHFmgtEpb5EMql5daMz9mkJJ1au3ctik0A3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335721; c=relaxed/simple;
	bh=b75YOHBxm2lQYDbG5iuWV5yJhvgfQruxGNEGB+zBnrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IbBqhwgDzryeb7M3joSnlhekhTp1rV1l48nDNNyCZRts+UiC+qVleb5zpEWyB0cVza/5gEZHbapJd9yqGYOA8jitvY4+VCmrONqtdmm6vgPVVDDbD6dVXlVoKkkbtfjtwt4N1rOPsd/itlcz064Rwnjc17FZ0MJdB4BYDWQCQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WT8RJLWt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so25576355e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722335718; x=1722940518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2k7WfqvNrE7q/baTECjG6uCgYMUMqGAXr8zev5hDQtc=;
        b=WT8RJLWtCu7YKXagIOYx7OpehU+d9157smwQf4ZrarAgu7syI5XKl72z9BAx8LbE7n
         w9pLqpiWoD2/HdS7AQkZBXllPCM1VUHWSBn+RViLn658BH7NUxzR5Gi49jM6EFecYGE4
         5Ztw/MIcfJuOMBgY9BA5e0Aa+O5gwsVfQiNSnMdv9scgEg6aVFkdWH1h/vRsIZdtDRy5
         +Zx6dCzDKFZ3ctr2cnesqPzxvl4TiJ5SJKSMlsJ7ou58LA0BHbiw8EDJTkhxK8AsE2Pr
         rJRzABsdCTBpNasXEyNqI+BD4/FaT1RL9OzbvIltKO3DPe6sRr3Njuds1kk1tpGHpDh6
         u12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335718; x=1722940518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2k7WfqvNrE7q/baTECjG6uCgYMUMqGAXr8zev5hDQtc=;
        b=jY2vPvFOSU9AfXRbCt5vcA+BvIr2pyHe8GbyzM6e4e7KF3OGwa8513z1lcql6bioec
         UUFvVn8f6EJm6JPsoHxG7OCFqS7+0YDO/G3r9jmPRjkrDvmf+aNIbV9GBYbmdgAi+QXL
         Eh2gLbroH2xAMpOojY6XBAeC9HqAXbVqFTHx6QRNKukfSVxjdj7NI6cGgaImt7fTw6BR
         39O6aLGXmZoMAkb/3DA4NNsu1N7LZ4+HBDNfbU9EurOs67g+nknQHGm3690y4/fzrQrJ
         QOGVbXtQ4o3MNKjTSVEEOeMLdk66CKtZqIxoGEGlJfXqbX7/5CCUrb5IbpDnIIWKZH0c
         LH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUu6kThVwlaPMoWA4AgwjL6kVACSz/f/whYLdB41HeHGyg4GDYB6DI1NUSipXqlb2nWmqk6xJ4uinvVBQXRf2p3msB1h0JT1iLj52Fd
X-Gm-Message-State: AOJu0YxfLNiJV1z+Z13ByDn8v4H2VqZgEGvP1Fz+WHXUUuiJyq+d2eIV
	vH6ogxHibvtleNBpwgkzfk0mIACeQSZhQm8WqW6McPcrRdVQKcIn7ydeyF8Gi5g=
X-Google-Smtp-Source: AGHT+IE9D+3MsMR02xuAhjzlxgXskiGjsFnlnKtGunsAe9F0MUMFrjLgF7vKlnZ2xqmjqZZBdUI2XA==
X-Received: by 2002:a5d:560d:0:b0:369:5d7d:ee96 with SMTP id ffacd0b85a97d-36b5ceee0dfmr7519309f8f.27.1722335717783;
        Tue, 30 Jul 2024 03:35:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863d87sm14284048f8f.110.2024.07.30.03.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:35:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: MAINTAINERS: Drop Banajit Goswami from Qualcomm sound drivers
Date: Tue, 30 Jul 2024 12:35:11 +0200
Message-ID: <20240730103511.21728-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was no active maintenance from Banajit Goswami - last email is
from 2019 - so make obvious that Qualcomm sound drivers are maintained
by only one person.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not moving to credits because lore does not point to significant
contributions. Just ~140 emails:
https://lore.kernel.org/all/?q=f%3A%22Banajit+Goswami%22
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8e16a649a0e..43e7668aacb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18419,7 +18419,6 @@ F:	drivers/crypto/intel/qat/
 
 QCOM AUDIO (ASoC) DRIVERS
 M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
-M:	Banajit Goswami <bgoswami@quicinc.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	linux-arm-msm@vger.kernel.org
 S:	Supported
-- 
2.43.0


