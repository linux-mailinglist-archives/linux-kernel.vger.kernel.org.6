Return-Path: <linux-kernel+bounces-374560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8269A6BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64927B21BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399E1F9ED8;
	Mon, 21 Oct 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="I7ec5WMy"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853C1F9A9D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520479; cv=none; b=NUAQv7p7OiGSj5EHEsPO+0FYga6SE40wzmNh3ZlckSNMW3tBrL3CphHg2UttXbHH2++TPsyhW3MSlOUdUiM8IH5Jux+7ftoId3F6WR8LqG3d/mvmqycgXJrsln+I3kAVdXJ2ge1bkC+ts9RLvokmabv7Rid3YSNIAtzyNGgodDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520479; c=relaxed/simple;
	bh=Pk7BCk2e6Tq0X4KPVHwA0sk6evakMDLdwaIPHrcoMc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSHh8lTP1sUKIdQmxyGnKDgTmATFhnT75H60CPoWGeTvLU7F94ozS1yxQmzH2LEHjLnIKOURU1oXRi5QoxFKFl0lkB746RusG9y7VA/jtoQnPQ4OuPSPE5gsgCFrqW59SX23Rb2Eo0EYUFhrKfllXXOQjYTFsdWQOfOA0YBMCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=I7ec5WMy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314a26002bso50440875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729520476; x=1730125276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkaTmiyWUTvag4SMcJC0bEMzINljnOfy+tQcywiph9o=;
        b=I7ec5WMymmAfgECyWbhGP20PIkc99sFesl2Z/W4ZXzaE+t5XOiLFogt2qYy8Es84GG
         vvlzJTac2NrzIRTGcHYQ09PS5o0dIXDOIFUOd7Qh6AfgVufT0pHopJ/QrvA3MJ2b/15Z
         SCoJATQE2sZdbl4O/y8bGUMOP6z1nz4xxrga2UdHnMKUggBdkpQrWATMacMxEClqSf1A
         z3A69zLPFMNoth41IoqOY+V6nlnhmjq4crrSKc9UarOu51HZDatHmAbR8ETXbOoiiRXI
         Vmsieq9Y0x2+bJBowdS6r4wg80J+7EzYsbS0a9PLc38MrPmEvF87AdUeZNUxjoS6ocmo
         btHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520476; x=1730125276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkaTmiyWUTvag4SMcJC0bEMzINljnOfy+tQcywiph9o=;
        b=tPc5lamrxYQI53ElP6t+Barz1ecfS2t3huko2/xmvEFDlZk2aOamANWzAUfGWIcDaI
         x48oyVshXWSBRdVUf6RLc4aRVIbdTCeW31PcHnddd8+wkNVg8YZRVeSLMHmtnWUKvLA7
         JDQuOFB84PHgxE6wO27qnqPcVeprd5/MWAjHfFOXdE+cJ4r5DCh0ImjT6krZTJsTflOo
         4zlqAzsuULif3oqijxyet/S9MCrvPOkbmRkb4/ymmDxNWiStHYe83ayZSJ/8ZAXfaC2A
         /Hk0w3B6w+Wsg0Oe/ajxm5bK3miM6EksBUptFoUfZidFP1drTw30BQTA/LVC8mNVdCOW
         Mquw==
X-Forwarded-Encrypted: i=1; AJvYcCUvkBtQqjc6QanCJlrj1H2HAVca5iL4seJuGJQbrhejhMJSyi++V3w4QLVopWscFxzqoSiXq0rtvkaLSWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATH72F2GBSgcDXoXEwkoZyEWGK9TbJk4RcKqiB02XwHfukqAY
	/xYPCtDX+qrHaH7ZjSwoa9GUZ9ysqibDSu/tRJiGnH80SxQ+pOJQmSgjb2LsmahZnZwH2uJCVK4
	A
X-Google-Smtp-Source: AGHT+IHLWSsrOMX/0aibUNkp/wI47N0y5vFtzl7noASKKkK9+W7PQoaQs8bf2P0RENiwFNs+Ip8tIQ==
X-Received: by 2002:a5d:4452:0:b0:37d:393a:97c5 with SMTP id ffacd0b85a97d-37eb488cb8emr8199985f8f.28.1729520475745;
        Mon, 21 Oct 2024 07:21:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b384sm4430211f8f.57.2024.10.21.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:21:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] spi: mtk-snfi: fix kerneldoc for mtk_snand_is_page_ops()
Date: Mon, 21 Oct 2024 16:21:13 +0200
Message-ID: <20241021142113.71081-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The op argument is missing the colon and is not picked up by the
kerneldoc generator. Fix it to address the following build warning:

drivers/spi/spi-mtk-snfi.c:1201: warning: Function parameter or struct member 'op' not described in 'mtk_snand_is_page_ops'

Fixes: 764f1b748164 ("spi: add driver for MTK SPI NAND Flash Interface")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spi-mtk-snfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index debe0e3c1c8b..2166a56aeb02 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1187,7 +1187,7 @@ static int mtk_snand_write_page_cache(struct mtk_snand *snf,
 
 /**
  * mtk_snand_is_page_ops() - check if the op is a controller supported page op.
- * @op spi-mem op to check
+ * @op: spi-mem op to check
  *
  * Check whether op can be executed with read_from_cache or program_load
  * mode in the controller.
-- 
2.43.0


