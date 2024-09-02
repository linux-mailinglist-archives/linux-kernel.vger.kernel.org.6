Return-Path: <linux-kernel+bounces-311483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F19689B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1531C22260
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2820126B;
	Mon,  2 Sep 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCs2QwA/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522B13C9C4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286714; cv=none; b=qUyng9ePI+AjbhgzI/Ln1ZN0uy0p5g5i74L51AZ7paBkG6y6uSHdybGttQ+uTfjD2jxxp/TQHObPKDLM2adsWJ45B3ZT0sjCXMpGec7LgnSsSlpt/LvbPeG6UWamXF6dcqg97jQBqVFROmwJhGSmFyhb4Ra3FRvs3plzOsg5JFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286714; c=relaxed/simple;
	bh=aF9PmPruqCeKd3F0YpwZgVnaGzJSbIEe5czrFu5/m/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skwlCRW96A25PypudNxS/ta2bL3c7P9AKRQrw8ffiE16WWSiLNrTZobR9Egjs4KyalWhCCuChAVlVKgWkFOfB6EgtKhl2Uppo10jdRVRHgD+mfQ9xIzPQ0nwmkmkgEbx1lwT43psZwP1pVzN0wFeeAfaZhPLzSuoYHVoT4bnH40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RCs2QwA/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-533496017f8so5725333e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286711; x=1725891511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3ZvE9IMpxuGUiDQ33jO2xnGDU9lOLBsoRe6S7V/ghI=;
        b=RCs2QwA/2iOns7lJD/0Xk4oxV0ajIrCphPFhcEsa7bQnx9DAAznJdHzqe7igja93iO
         Gb9ffb+QWhY/w0HgIO3oX1Tv2VqVi7VL8z3nt8QlvFJmMzdFGzSW7oUFJ4SgxOMDghcc
         IHBoyIchkoiO+OTadMLTruJTNzc5q36z4Rc1dyQO5prAT1+BqcSp/H6IjDogP4KGMzNk
         bhJQmwH60ulkrp01xTyAt8esV46W/hOWVE0WKQxdOHJxGX2+in/FBRasfxLbMlKVLZkm
         0PmND7996winjeMhPS2SH+Xhy0IOZdN9/cTyHj7ruW2h61glaKb4WlwBr5nDtPbojtXl
         DBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286711; x=1725891511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3ZvE9IMpxuGUiDQ33jO2xnGDU9lOLBsoRe6S7V/ghI=;
        b=wX+U416ofDLgedRNXURzXMTt3trzvBXzO70OaQsHfnLZIPxn1ansZrpf3eDGHHmHWX
         oR3jKGLtBE3Vlsv/xRYLsfsvym7xUzwqNuYJ31g5VXqoW67fblQRSS+v3ooyo6Mxm/yg
         dSHUS4Vqm+q1NFm0ODSaJm7pYM7F/By1PUaQGoRVt2RQcGQHM9vTrc7aHYARLgW9lL30
         Sc77akAHIgKRoroD+7YaxlrBqvgkh9l2IUp/3r4B4ut2Par5YwBgCVHSYACKSKzS7C3l
         6RFu35DFZaTg8hQzdg3+5D8rS8Ib2zT29dmq2rl9HcVWolg4Msh+6p4LGLsrBFcd/m8s
         SQVw==
X-Gm-Message-State: AOJu0YyPlCrzbPVaZODRq/Pe/SD5lVjZhed4AO+fdL9cWtfGsVRYN9vW
	H9zKldKoIsBt3Xo2ia19eToY0nXAF1ZVeSVqSkXJlSd0KYn5Kcvz6IC9rTr0Irs=
X-Google-Smtp-Source: AGHT+IExjfy8ZZ0jn1AXtN4THrUjPX/6Nl3PMuDcNQ2kEdKl6ndOmsoDNm4w/C9IstkUNKedVBdpmQ==
X-Received: by 2002:a05:6512:3187:b0:52e:be50:9c66 with SMTP id 2adb3069b0e04-53546b9b710mr5278865e87.53.1725286710957;
        Mon, 02 Sep 2024 07:18:30 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891966f2sm566000666b.101.2024.09.02.07.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:18:30 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] dt-bindings: misc: qcom,fastrpc: increase the max number of iommus
Date: Mon,  2 Sep 2024 15:18:19 +0100
Message-Id: <20240902141821.70656-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902141821.70656-1-srinivas.kandagatla@linaro.org>
References: <20240902141821.70656-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The fastrpc components on the SA8775P SoC can require up to 10 IOMMU
entries. Bump the maxItems.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index c27a8f33d8d7..f52931c0035a 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -81,7 +81,7 @@ patternProperties:
 
       iommus:
         minItems: 1
-        maxItems: 3
+        maxItems: 10
 
       qcom,nsessions:
         $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.25.1


