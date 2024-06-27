Return-Path: <linux-kernel+bounces-232296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B324691A678
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C52284DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD36C158218;
	Thu, 27 Jun 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbSekzxP"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4917156863
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490825; cv=none; b=K6y/AEoi1kyN9G+Mgh0WCNcTWV3WQW7ydlNKAJL0NbLzk3fOYiDexio39r6HqsYDeB+qPST9QxlE4gAzVaK3L8Icjjv+03emCyWkyBJH7js/fscEyLDFXU7hTD4iX1JM1luCNM2kNOuyoWQ263yJMAse5nNNJnVEshOfyhcdhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490825; c=relaxed/simple;
	bh=sUkdPuQbPyTADqcRllGyHnJ7Vi420C9DZGnZln1HFGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/5SdyffR66DY+3hONadf+QesC4tqxeB+WWfQvvZmSbriyW1kevMkNXeaUUIEILuHeqj+Bjf2h1dqU++hVnv5kCr217Z+ECgKm4XmNWduBSZzIdBsfDSH7TKSWOVnLgs5mHL9BewT+YLs33eLy9X+72Cr3wZSmINsV1a9mawtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wbSekzxP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42565670e20so3410165e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719490821; x=1720095621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzuRu3TYFUavJ3fIbGrdOxztoebeEOJ4/hLXJ9FwGMw=;
        b=wbSekzxPnztQ5CuzVX6FiYkyBle2uwLKMtJ6Ffrkrc/kn/iWgzWBtILHoKrH//4Dgg
         /M/fouotxviBfHeTbILWuF4cI54NvBonhh4QV57wiutpdJiTMthiFU3BOYMcxEYf92zM
         ukal4uN33zsweb1v1AcUEj42+1En0+DL88TjPy93+w3WS8rWwl3X38nlHJOkqoa4uTL3
         2AC4QTFpE2HiocB+3sYkalH0MZfXVrq5LfwYCqeqx0gaa/V3hbda+Io2GrKAvkYeT0xL
         U/jNKcEd4jwpwWjWZp4BKU6IRledkCbKN8uIx8ncgKeunISpnSG6fCpuLNl7Tg/42SCH
         oMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719490821; x=1720095621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzuRu3TYFUavJ3fIbGrdOxztoebeEOJ4/hLXJ9FwGMw=;
        b=uvWmMhUJLgfRXBJl3J8ANq2eJHNEmfBTuBFS39pSVFvWYLh2a/GBG2/MjXk5upvfmt
         Vcsm4wqQIyW7TjYK+HUmEI3XLMiJE7rXm+8VTXwkGNTZDb961/1VJtX1aJQMiRIXep2K
         3/NqYe8QRcjmKPNYQTYx/0uXPge3BtBtRTDFI2G8kkx1MBYlPl6L3Ge2NwVKFnB9zRKG
         T2qzL9zEQ+ZQQpJlDHNP4jiUmum76sE0IgQ/6o8onjcRTAds5+OExKKD+QoNi+qVGzBi
         qji926EJk1l9JU3yc5uyrJN7ytdXEVmBUBUBmpkjC7L8bZRNYUR/lKBYneBh5UgGTpDc
         Amcg==
X-Forwarded-Encrypted: i=1; AJvYcCUjwHXXEmutZJ5GdLmh7UZzI0Srev7T+y1nAGxzh6zURcDxAwqYkG73YM0JX/rGIq/EJpKcz+EP6UfWJWz1GTeMUOhZKA3u+gkwErJL
X-Gm-Message-State: AOJu0Yxf+XWqfv/7RhR4EimIDvLeTqtPD2lNUDRxHzLeexcXXaABwpQv
	7kHKXfSTXCdc3cv2INVcPRwM5ZrwrT4LsSLBtPXZ9k2c5hVcOqJEbxu8Op7a8b0=
X-Google-Smtp-Source: AGHT+IHXhFgxyEkcJCCrWQdO9Ydbw+jJMliEDlzXzFMU/AuCxMArjpiJIM4PdWhK15j/MHAd79vk5Q==
X-Received: by 2002:a05:600c:19cd:b0:424:ade3:c6b7 with SMTP id 5b1f17b1804b1-42564502cc7mr15766815e9.2.1719490821344;
        Thu, 27 Jun 2024 05:20:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8424b43sm62692885e9.32.2024.06.27.05.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:20:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sm8550-qrd: add port mapping to speakers
Date: Thu, 27 Jun 2024 14:20:15 +0200
Message-ID: <20240627122015.30945-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627122015.30945-1-krzysztof.kozlowski@linaro.org>
References: <20240627122015.30945-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add appropriate mappings of Soundwire ports of WSA8845 speaker.  This
solves second (south) speaker sound distortions when playing audio.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Bindings:
https://lore.kernel.org/all/20240626-port-map-v1-3-bd8987d2b332@linaro.org/

Can be applied independently, if bindings are fine.
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index d27820fb5fc0..de40cb623c8c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -935,6 +935,7 @@ north_spkr: speaker@0,0 {
 		sound-name-prefix = "SpkrLeft";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
 		vdd-io-supply = <&vreg_l3g_1p2>;
+		qcom,port-mapping = <1 2 3 7 10 13>;
 	};
 
 	/* WSA8845, Speaker South */
@@ -948,6 +949,7 @@ south_spkr: speaker@0,1 {
 		sound-name-prefix = "SpkrRight";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
 		vdd-io-supply = <&vreg_l3g_1p2>;
+		qcom,port-mapping = <4 5 6 7 11 13>;
 	};
 };
 
-- 
2.43.0


