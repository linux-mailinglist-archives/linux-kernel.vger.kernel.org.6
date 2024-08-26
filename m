Return-Path: <linux-kernel+bounces-301721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF5E95F49B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C69328207F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B4B190486;
	Mon, 26 Aug 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UV6W6Cs3"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184C13B286
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684919; cv=none; b=Dn5xu8ebZ7YcmUNuoU+kaNtgrdZATFi9Xy8t3CT0fQ9zzTkPBxIcqkQoRxdE8c1AArJQTVGOKBuThIpb/ZihFEksmuSVUau1nmhIy1TefdP3Sq6LF0x+g3iIVW7XZBopR0FYU03clf+dmBOSrGm45y2A0QSUx878F4AByjFLCfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684919; c=relaxed/simple;
	bh=QRRzk6+mhsJ4JwH3MhC2Atvzvd4zaOnggwRIlTPhMWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfWo1o6kjDqDTdfrmVP3zfFDh+ohIZ+cEnFb6zwi/eAsq/tIFSNIxmWXm55ufrhpC9Ue+eoWxmA1lNg1fA3zH21DSGsQTKBp38rq+1F0+OtF4o/9h/YmS0OCYPaMiy3PV0BaG2eJ5AvqYeupy5hHPp+N0HoK0nxknFE8qxqmkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UV6W6Cs3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37193f192b1so109407f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724684915; x=1725289715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq3MT2U3Bii1oMqcjLAXejFqk1AKEOqI5iAx/L7MuJo=;
        b=UV6W6Cs3RTnBWGfs0kfkqz5A3QTfC7xybWJbKYydkO3OS++3S09oqnFNK9VvySg/KI
         1XCeJdscNvULKmy9ABot1yxSTS6dGERzfel97NLs1lRnChjd/Hs+if6dfza1OiymeBxK
         UcgeTHyxYTXp3BpGtJvumTgEoIVrlCFKVeKS/cNutHRVuQNPxrsMNlLjQTrO8aQlVUBZ
         R3jBxvCcMAoSVhzkent3ZUw6YoVjtf4X6RzMMg5AA8KG7g5DwRRflb3boNvIjRoG7M+V
         z+xDJwvL8+dKG+gkdvsTLEGB7xYrtSi1pXd5BJrZHCtuEMuK8WLp1iN6HTuxu9x+VsX/
         On0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724684915; x=1725289715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq3MT2U3Bii1oMqcjLAXejFqk1AKEOqI5iAx/L7MuJo=;
        b=BoH3CEacllWKWCVmdjrzVYBV1kU25zotD5GkaADNJpJnrGQQ+l/wPsfWKO/Euqdmi7
         rR2yF9xsOOTBdmb8PNfgv2CLPmGUPRyMxYbHVC/3Fbr3OSGM4Mz6pzPt92gUJqQGi1NK
         8FkQ9p9EBN/rM1jS+nrO1u1HlbjxIiLujFa7yeTIBiqBa0SRRDPGZBfwUCwD2EAeCClr
         Jrsm8PR0ZtDnlei/I4bJsjH0ShD0MtJV4aprAdC9oUwONK7KyIr5hkdz6kX1GC8NcPtK
         20b8rsm0EpE+hJYn/GhA61/GRRF108+dp7kEr3VyZT+CV70alOnPyzoQe0eG0eMG/6rb
         IUgw==
X-Forwarded-Encrypted: i=1; AJvYcCUFfXHqszIqeAjk1bzm+8LslWiVOPsyTHqnRCqVOaQO69xXXDxlYbp0sfYBbjJXGbOMu5N2QATETMb+qDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wixkeMxfsRmXeDC3eZcxgJglvsK3mvfXAEZpUfrTtfYlo5lO
	PbhwEiOBI726kPEZHwrbB0v5IhjKwZzXIrCQD8PdJlJV7la5so6hKsxnij+Jch0=
X-Google-Smtp-Source: AGHT+IGp1HEFpKBlPzvGLdHjlSkL9VLALIn2mdOC9GkDps/j6o00dYXrlTi5d5CGoc1xVMCg+wJO1A==
X-Received: by 2002:a5d:5889:0:b0:35f:1edb:4695 with SMTP id ffacd0b85a97d-373118b65acmr3696789f8f.6.1724684915215;
        Mon, 26 Aug 2024 08:08:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm155040825e9.24.2024.08.26.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:08:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Heiko Stuebner <heiko@sntech.de>,
	Jianqun Xu <jay.xu@rock-chips.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] gpio: rockchip: fix OF node leak in probe()
Date: Mon, 26 Aug 2024 17:08:32 +0200
Message-ID: <20240826150832.65657-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver code is leaking OF node reference from of_get_parent() in
probe().

Fixes: 936ee2675eee ("gpio/rockchip: add driver for rockchip gpio")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 0bd339813110..365ab947983c 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -713,6 +713,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	pctldev = of_pinctrl_get(pctlnp);
+	of_node_put(pctlnp);
 	if (!pctldev)
 		return -EPROBE_DEFER;
 
-- 
2.43.0


