Return-Path: <linux-kernel+bounces-232335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C291A6F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F151E1F274C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AE617921D;
	Thu, 27 Jun 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gomFNyTo"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829FF178392
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492729; cv=none; b=P2sxnNWnlrVwWFsy+hVKGMbnb64tOX1e9dmLUGWjzeSuVD/qbrnB/7FcePkTDnA09Kzca1xBs+aoPpVkDEQU+tf+LpbIjy9Qkf5qKmzFv/PQgOhHnL+YQ/b6wi4wBa/7TQhxfcHsoMD7WlZvsrRRf46Yxb93sJYS6BtSZhOJN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492729; c=relaxed/simple;
	bh=tra7GUSYxOuDci7FtdSU9K1mGynWhG/R6z58PtzsNuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TW/RdVJKwaeNyqop7haRletOVLSEA49ibzrU5rpOYj3IBdsZD8ieqn0e+WbfFc1Tk8sriZPmj80fGCpYWsNCfwDbAB2v5KRzdfJFgRPW2oCJlO1fVc0DPxHHQ0uBONix5C+aw1SjXwHaVklfyeVTf+4zlC8pXQMoEfzb3bQzFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gomFNyTo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d457357easo1667116a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719492726; x=1720097526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3fWxjkujTAEOZu9H+o5L8JwDxceIiaHODnF69xqvKE=;
        b=gomFNyToBAdgDn5PmOju2FhScuPRSWPbSAQP25+y86WCtWFwCAq8/hNixwUsWASf5f
         R7r7dTMtZY+w/ycpAg+wFBq8up2KgQ5TOw6QovgBIdhFTQiLvIDbkV3MA7kajzbQYQZp
         Mh2fZVlEMDV+6ikklU4cku9bjNCcwKKkI0odifx2b0LNFZdHdI63/VSZOiODfXGNO38Q
         TITJmMUx2AAThn6DBci5alD5/zlVx1GkfbeJVC3tM+eGAzmy6wYBRKh3P/6EjUct15OE
         PptfdJLr/XaCU/zzwXzcSa6PVKZzsS9TdFlt+K8Qrqf1P1+C8jmL15yj3hSg8bRZTNUB
         TWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492726; x=1720097526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3fWxjkujTAEOZu9H+o5L8JwDxceIiaHODnF69xqvKE=;
        b=AqdzB/vdVY6k7URNAujPh3q/oSEdoo55zBlH1zo9F40pfEV8VwihH2q0FYChcR//j8
         CuSgitV7g4k5FLEXyTYEw3ojSSdPnrssEfafudMQZbCEmcnyhoBLhjyrEQ6rf7r3LzGR
         x4ciT0vU3A2J3L6hp2/K3puXD43sPSVl09tn6CYwhq1r78nYLRgVlk7EBmJKCKoO5bSD
         tqxaNT/RJhisvz+r4Zd4weaMLJw3X4zFgaj+jmRYfvyLCQ/LDX+Vxc5BdgP4tH+dRs+e
         C384v30HEaNqRq6cZF+Y9+P722aODjF3zZ8PqmsUq/S9Fx2B8BebRkNSMoRHg3ytYDO/
         YM2w==
X-Forwarded-Encrypted: i=1; AJvYcCX6YAvwMJiJYms+V0c0J+3Cce785ZmV7GiyXHsbGGjDTcJn6UsuUL/026FyWIkbQCxWtw2/k+uJdwpFcNfLVIt+8cMAKnnGp+5qfbFj
X-Gm-Message-State: AOJu0Yy9ovijGVcghAlAhgTHOlS+okSa25i3jHQZvP9TNN/CDT4GBB/E
	l3l9QZ58qIH/9slFyEkDo5se/alwccWOYfR5IaUsege8QWLlScU7R697qWrZK5A=
X-Google-Smtp-Source: AGHT+IGET1esYfbROqvvZkY8IDH7ijftBgO2xjdYktEdnF7Izv3Kvy1Oe00gyYjczpk4u/qLWxjp/A==
X-Received: by 2002:a17:906:a8d:b0:a6f:b940:10b with SMTP id a640c23a62f3a-a7245c824admr801852466b.62.1719492725815;
        Thu, 27 Jun 2024 05:52:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d71f271sm57248666b.61.2024.06.27.05.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:52:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: codecs: lpass-wsa-macro: add missing select of common code
Date: Thu, 27 Jun 2024 14:52:03 +0200
Message-ID: <20240627125203.171048-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm LPASS WSA macro codec driver uses now parts of common
module, so it has to select SND_SOC_LPASS_MACRO_COMMON.

  sound/soc/codecs/lpass-wsa-macro.o: in function `wsa_macro_probe':
  sound/soc/codecs/lpass-wsa-macro.c:2767:(.text+0x1c9c): undefined reference to `lpass_macro_get_codec_version'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406272231.th1LtuLk-lkp@intel.com/
Fixes: 5dcf442bbbca ("ASoC: codecs: lpass-wsa-macro: Prepare to accommodate new codec versions")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a99cb26eb280..36dabc045868 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2538,6 +2538,7 @@ config SND_SOC_LPASS_MACRO_COMMON
 config SND_SOC_LPASS_WSA_MACRO
 	depends on COMMON_CLK
 	select REGMAP_MMIO
+	select SND_SOC_LPASS_MACRO_COMMON
 	tristate "Qualcomm WSA Macro in LPASS(Low Power Audio SubSystem)"
 
 config SND_SOC_LPASS_VA_MACRO
-- 
2.43.0


