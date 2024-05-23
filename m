Return-Path: <linux-kernel+bounces-187347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03F8CD081
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23331F22789
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD851411F7;
	Thu, 23 May 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLqvAqAx"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356713CF98
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460964; cv=none; b=bcs0+9ufZKeHefDVKLhV1Q++mqnePsFiJOMtu1woZ/WiimWZ7X+Z17c60ro1VHqK3jxhR3G5x2YXnw5ik5irLsLek79ERNQRjgOZpIwxw49nS3Xsg7IucKwp/+mwjr9NCpOosvjcOWzYuM2hxbX6JFPb12E+Zgqwp8VGK/xIhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460964; c=relaxed/simple;
	bh=pPD2rS1ZgskYhKHjT7ris9b/z5/qXBC9txcXhZDWUvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fs7pen1nXzwtF9WTQGL9CVUvKA2XE29Kx8YbA0PUyH/UtxJic2I3lVR3zRSpwGXEFHTwe//hCElnycqN6XeHUAS5Sv0X5to3VotpUwtH7en1iB4mH8GRRtve2F94YtUbMJT4+QX4Z3L8mPDFHIBS9vLscOS5WYBID4UpeL9cyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qLqvAqAx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354f69934feso447181f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716460961; x=1717065761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DaH0WUaVpR/8gbZR869sa1sk2qXADEzmLsvjAUS36EU=;
        b=qLqvAqAxBAmV2dcEbWWmJ2aN44v2W4mx1zSiv5TYDy8H6inMDeblmMXB1B7H5XtuoS
         rZCrCYXqYQBSCtipj3oPsxwIUN9kGhG+U60C/YMEWXV0IUn1Vz+6Ac0Jifpja2d/aqAx
         2yyKG7Hf1DgodQNQ0ANpGw60WECI8Wlbc/uRSuIo0Jz4iywv2fw+pWvY1msm/0XEZI03
         m4FBDiPVD8gEvWITFjmDqCgqSaFed1DfqRZ+qYnfYCja9lCFGWCfWSQvo/jFaRTFhpL3
         A8hyHVpdy9y1vjyvoTof7YRK9DE9cUhooZeiUoCwWyUIiJJupYVbVd8CsNV1znGfQIGu
         Myyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460961; x=1717065761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaH0WUaVpR/8gbZR869sa1sk2qXADEzmLsvjAUS36EU=;
        b=OJqh3rybXW7DXrolpTon4OnUTq1qbsHZbgdUxuKz+MoQmSvuaKifUjkWN/iV9Xhllj
         40GRjMA46WaqjR1jN+3UU8pyr4S7zLHzwcelSIj/d8YTulB/jhJ/Rmv3MlGbaXqY7Uq9
         9v+4P/eW9GALDxW26nXbtD6PztRTEr/YAUmohEQWokcmU7OaTUIMu2oOo9tAF8KJIN2+
         0DV6T+gdIPl/EhBvG94AZc26O6HuT9uRjM2zlTJAahJ7I6imV2usHUSpCfznH3WH6s+/
         hXPfWpEBj8z1bgEF7faO9H9YsGyAFg6vp4cZGII9Pdsnx+/O68EtimVK6vlg7CMHedpy
         E07A==
X-Forwarded-Encrypted: i=1; AJvYcCWVXHCxzzWY1F4zpJwYMPcqrlHJCjIao2NkRNTYhx2oBj/60G5mCwSL7ee3035sABwpmFlwAWP/NhGSbV9VRM96RcqWjl/h6JnbaaWA
X-Gm-Message-State: AOJu0YyrF13q4Nq92qSAiW7gHKRdwYPMkNGUL7At61AGUst+nSgzmHP7
	SemEOD68TYwRAhVLNU/KUAqvJLZfeC3ZgZraJ9rrwbl+IuRX7rhHXmMouTgN15Y=
X-Google-Smtp-Source: AGHT+IH/fm458wBPdlXEb1gtuOzqmAIVNW1EA1Cak44UuBRZM5nh6/eqhRkhg2PYFkM2VvDBrDPuFA==
X-Received: by 2002:a5d:456f:0:b0:348:7e75:4d75 with SMTP id ffacd0b85a97d-354f753b77emr1706027f8f.22.1716460960667;
        Thu, 23 May 2024 03:42:40 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501491c40sm516038f8f.28.2024.05.23.03.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:42:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ASoC: codecs: wcd938x: Drop unused duplicated MIC2 bias register defines
Date: Thu, 23 May 2024 12:42:25 +0200
Message-ID: <20240523104228.36263-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All MIC1-4 bias registers are the same and the header already defines
register fields for them.  Drop unused, duplicated defines for MIC2
bias enable register.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index 74b1498fec38..df07e92d9d97 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -75,9 +75,7 @@
 #define WCD938X_MICB_PULL_UP			2
 #define WCD938X_MICB_PULL_DOWN			3
 #define WCD938X_ANA_MICB2                       (0x3023)
-#define WCD938X_ANA_MICB2_ENABLE		BIT(6)
 #define WCD938X_ANA_MICB2_ENABLE_MASK		GENMASK(7, 6)
-#define WCD938X_ANA_MICB2_VOUT_MASK		GENMASK(5, 0)
 #define WCD938X_ANA_MICB2_RAMP                  (0x3024)
 #define WCD938X_RAMP_EN_MASK			BIT(7)
 #define WCD938X_RAMP_SHIFT_CTRL_MASK		GENMASK(4, 2)
-- 
2.43.0


