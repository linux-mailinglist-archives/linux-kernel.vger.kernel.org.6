Return-Path: <linux-kernel+bounces-182974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED78C925F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126BCB214C8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59936A8D2;
	Sat, 18 May 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alzShfi+"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC596A8BE
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066729; cv=none; b=RgNubdSFvs84IsJCWkZfI3fNHKykU1oN29nTI4gb/ZlP4SWAPASHRiBHNEXYhJoR6PicsKVU4kv70RsSEr6g8nrMGFWRBc+q4pQcn08/hOiNYwkxd7apRQ6HgjfAjeFoyLo63ImcOTyTWfvgpfkPuYjCVP6CGccUT6jfeDn+7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066729; c=relaxed/simple;
	bh=qPp9SxAZJBrbSQRD2v5MhCsIEvpdXfFd1P/ZyXhM9O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mze6JhRzX798PTVR+u0+BgmXnwo2c/NZzdfeZm88Z0GP9GAuErh0ixK+RlUDGOOaIkkzbevyUpvSod+42bYP6tKW6TEsSEDA7RRAKojKZcqaHDKh2FJ/08hR8Vp8k3I5+saRJl27fkCxnNQjBJIohGY6XcqFMlnQfsNh/Y/0jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=alzShfi+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572b37afd73so6907196a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 14:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716066726; x=1716671526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTZvw3qn2Frxz4VlPUYhrX9Pfbol7sh+tfbuq/yEHo0=;
        b=alzShfi+uXwgjYjlhfnMkzdwiCoVsCDTEuevvpNd/lEUM+rRn6caKKbPvfL6lVfrDm
         1X0641zYD9LKJOTKMpzhMsh+f5yhftcTrSloDyUMx7Go8QGFuPUnQOjK5hZ3DSVp6efm
         d+HG08j/wkVLwZvzkFYQHMZPWZIrzY79wru/8kuINhnSU6juuIb92Hj+u0WtFTBUSdIX
         9wJx5mannrC1+AWdyXtt9d+Eo+q0tYljxC5xP8H5jht5UN5u8lkFazOmsBgXBvCKQC5Y
         TD96UHCNKsdRIMLoG06RV6f8BTdLelMuvYbfibIZxfueGsxGphg2KiK7EMrBUm2QGp74
         waig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716066726; x=1716671526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTZvw3qn2Frxz4VlPUYhrX9Pfbol7sh+tfbuq/yEHo0=;
        b=N40CbM70fHHsib4xYQBsnPIm347Y+0vrm9kv6cl6q3BV/v+chuF4IuvF6YV6EwpLqP
         a9hm2AisQBh917a6zzQO77BKHChe8+o1af0UTwMH+ll4+ECtt9aRqSZLONOipJ9eH1Bx
         AHW1TWZDUOClhpOCEMe23Efm4W39XLPEv6W7WDI+6OqQojHm0rSggJ/+ojXCS2WVlly+
         +uu5iDZby3RPz0jxs5GsN9GE/IZoJ3VOYl9+50gbtaDrv4QEj8LEOC3CiaO6A0QDfvhV
         j9DL0P502JOAmLlT+IE+OTQF7fr1QIqH6AjXQ6dspVgheIgEW6h6goZyKIvkKQYCNNX7
         /z1w==
X-Forwarded-Encrypted: i=1; AJvYcCUS7cMqxoj/M+yH9AjvnDCPUMKiRdFFRaGZeGOiYig9gNOCtjnIp5RK4vQVHaTvZNV+yAAWcHW7mvoLV8A9rb3uaZZ4M/9VTFM6lvNv
X-Gm-Message-State: AOJu0YwqM/dD9p/fpn7EncfGKk6LhmZ2gcSEfe/9HNabeSldtsemkNoZ
	AWuR6Kq1pYBCOIm4IXXvcU09+xci6kKIT6Z5RRseKZk3a+FT0EZeHO+JqT1/LeA=
X-Google-Smtp-Source: AGHT+IFo5u3guueI71r2jMppcT+wjcslXSGXNTnebOHuxXpsGhc2ZBnApheROEQ5Hrwarq+3P1YMxw==
X-Received: by 2002:aa7:d450:0:b0:572:72ff:da34 with SMTP id 4fb4d7f45d1cf-5735a1c68e9mr16324495a12.14.1716066726140;
        Sat, 18 May 2024 14:12:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323d3asm13151340a12.90.2024.05.18.14.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 14:12:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8365: drop incorrect power-domain-cells
Date: Sat, 18 May 2024 23:11:58 +0200
Message-ID: <20240518211159.142920-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The top SCPSYS node is not a power domain provider.  It's child
"power-controller" is instead.  Fix dtbs_check warnings like:

  mt8365-evk.dtb: syscon@10006000: '#power-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index d3da5a22c2d2..eb449bfa8803 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -302,7 +302,6 @@ syscfg_pctl: syscfg-pctl@10005000 {
 		scpsys: syscon@10006000 {
 			compatible = "mediatek,mt8365-scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			/* System Power Manager */
 			spm: power-controller {
-- 
2.43.0


