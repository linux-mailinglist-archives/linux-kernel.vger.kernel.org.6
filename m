Return-Path: <linux-kernel+bounces-300527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0D795E4C3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58EA1C20D27
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16EE17920C;
	Sun, 25 Aug 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ek1A+rv/"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECC16F831
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612001; cv=none; b=DpDavHr50Jqe3lE4+xA9Q0LoiV92Pe2SCnkhQgBfLyVIf0kGe0tmkoQTtHBn+ckaMAcZv+7idTRdGQwBoqnLGyCCJ5wXgQSRcXiruAdFVpv1m+Y1R2AjiRjeZucKUEfBfzqs6vJSJcVx23sGq1SMCI4H+ngUw3X2pBUOTysDUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612001; c=relaxed/simple;
	bh=9cJgFjD/R7mUY/jBwLx1PxnCORxDvEzzYDQVq9k+sW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfv11sH+LKzw5VIvIJBtYHAWUW27k9r4YDlIqXUg/AxVD+C0+gABUAD87iGlgr/vDpbhGCAJ+CYLyvdXTc1iDm0beNV0qJZ0/XPPR9Al6yKPnlOiwVKvve5Xocx4kwgkPpWhB5YqU2lzdnBjY0+SFmR9Q13iR97hNJ46BFjohts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ek1A+rv/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280921baa2so4115875e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724611997; x=1725216797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEXiFF9+y1AtJUUe0lBIVMSQ2gFJFplRHBS/b2AQ058=;
        b=ek1A+rv/90T4eRHVmwqdno11Yn9ukhmR6tCqZ371RMafC/kHkxDKhV3yDgxBNktKF2
         o3Q+qCBkSKq4xxXx4gD4FMCzd4CS+FiJqxzOy9JXvrQors0NMUVhb6UcJ30T65KaXTXK
         rQfnrn7IrkRs1j27e+EdXK4uROTMU+q/+Jd/uMpV2yBUVWg0Yvm5GEUEJfDhqYYuLQIz
         xuJBHTZA70vr8LByOvLNf4R0jjsAUilxvs5TmcTyY65teR47+3DgYBSwGWR9Yp9fxmcf
         9rQC6dHMNeimAu9jpc3GT/yWacnOfFTQ4ue1I42XwWoGM3IMufmbQ+x5RXdXDzDubwuO
         yB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724611997; x=1725216797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEXiFF9+y1AtJUUe0lBIVMSQ2gFJFplRHBS/b2AQ058=;
        b=ijO0//ht0zVYbtisFV8WDSqQQZuqNiATKcLTW7NoVpdHYYuFZPpGPnLx+6VuybMheF
         0dc6tYod0N5gpz36XnFaNZVx1ZJe4LAedNH5riDNnphpNYPYevnwE5F5atloo38nh8kH
         b14EjljQMqETXkMWbIzwbwO7x7UyfnovR6wA8Q9/b+UnfvI8wKZDFHRTwNB13lh2ao/x
         DlvS/RAn1nqiniRtjcJcceOlO/ATQZNeb74t1adjJUh+qATjDrUeaQSd6AFROxjg22Oo
         hFPQRTdK/6qKu9KUbKQaU8FeyR/1uDT4XcrdfaS5QOvzNNMyLhn6oSIS8rt911fWdQqw
         O7tA==
X-Forwarded-Encrypted: i=1; AJvYcCVLj9fM6NoRH8mEC7UAJOWHjp1+B3geCGbOb4An5AUB/eNPOenH7s5ZhfHipsD0Ncy98YedIks5I0dBp3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92CNrMspsKO+fwFl6uF1MBN/dRcOLBwiheiI6xr1oXsWcM605
	2iCwZbVhyoGICIW8p+3R/UOaEIuJQg4sKX2TvXuUTsbQcLJt8SfKSDFmcFtFZjs=
X-Google-Smtp-Source: AGHT+IGvJu1uTStE429KGizX7Np6vKu0qyORKUUbmahR0xi5cPSpk3z7yhO3iKHVOSjnRdWyGYnX7Q==
X-Received: by 2002:a05:600c:198c:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-42acc8da99dmr35097735e9.1.1724611997042;
        Sun, 25 Aug 2024 11:53:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb76sm9130963f8f.8.2024.08.25.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:53:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] net: hisilicon: hns_mdio: fix OF node leak in probe()
Date: Sun, 25 Aug 2024 20:53:11 +0200
Message-ID: <20240825185311.109835-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
References: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index ed73707176c1..8a047145f0c5 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -575,6 +575,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
 						MDIO_SC_RESET_ST;
 				}
 			}
+			of_node_put(reg_args.np);
 		} else {
 			dev_warn(&pdev->dev, "find syscon ret = %#x\n", ret);
 			mdio_dev->subctrl_vbase = NULL;
-- 
2.43.0


