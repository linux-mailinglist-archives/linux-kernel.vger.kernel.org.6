Return-Path: <linux-kernel+bounces-202942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AED8FD35D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6515A28441B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68E19414D;
	Wed,  5 Jun 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tJe0OxJv"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014971940B0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606638; cv=none; b=DWtJMXsI0vHXF96sB9WHvCCqLDaLhk8BvBTVGfMmUEJ62UDjBlf5PMX/N+K/cN5M7E398H/PBKLatTW67UBZ/E5P5XgGBqbmRcOeiS5fp5xbHWQJbfnSm2sFHxDpKiXGE8ApScncidOQkuRA+t5XdIwn7BBtJpEYRkN1ILKLzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606638; c=relaxed/simple;
	bh=MS2pg1hkUFBkA3HoD5bx+WBJu4p2mdrw8oSNHZTARog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pd17X48mSajQQI1dk8Kg9J/uxgHT/UJ4dyYYgOdXjKr/Lhmmi952XiwMHufu8hLpNNX3+3sfu9m3j+RBJ/PdV+VuOcJzuZYViUun3fk8n4LoaO9gq0A7kIOzi5J7zPOWa9FUZqCyIi2MkK6809nDxdO+BMu9MGHOacHkyIIwFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tJe0OxJv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so7276325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717606635; x=1718211435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pf/ayE1GI1WAlEGzaVo6/9gInOblIFTdfpLa3Fxp3ZE=;
        b=tJe0OxJvixGsb6XcRMr1BXjDkJghDZ/pnj/p3BESV4BHID19v+3oXJaYWl4m0b9q/U
         nxiiRfIlQvP2osUvSgDShTPKMs+F72Z3MCDI06PJLSHiKUudsWQyAa5yAIfqlWTBhTl6
         EJOB5UomebWwZ3U9z3nePRyM63FdvdCh2x7ooAXF7iEVd4C2Rvg0jG7qUzcYvg8Ju87Q
         CZ9G/13bTCiFzURwXSpvd3MvTkyKsPwffrBcS1AV0UFVUGs3kgYL5oCdJhIiNvzu7ZWA
         8p/25OemkgFKmsbiYt4qyW+loquVBfYPauCmRW5exNGqzqtU8kM+54yQ9u/yJIFj3WXZ
         5TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717606635; x=1718211435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf/ayE1GI1WAlEGzaVo6/9gInOblIFTdfpLa3Fxp3ZE=;
        b=I6u7/B6dqkIyc/i2WgXYNUieo17+WcMq//FKjQn3qH3mfnmIyCVcXHE3g1KadLjZgW
         IaFKDQxcv6wIBBp6GKImN7EmaPLTlDbZrCizFsclEyeDxsSx+jebBlyrNGUClq4mGG2f
         pGwgDGj+gJ48TKQvYJnbJ/z24oDxhWIDxbEB+xHHadblTjetqiDGnlTGJeOUQ5+JoTMU
         j/U4C0JWQpgmHLlTvOpSCr8PejRdPUYo9p3wlQcvz1PkseLPXns2E0GsVabbRoig034E
         MRZUFbAf5gAWDryaqOCYrz3vzaXCs7ar5MrO2KG1sNlbC2dTj3zD5T1rLouXJwqWVkab
         Coxw==
X-Forwarded-Encrypted: i=1; AJvYcCXepq9N1uhdyB8t/gnraBa9Xr8OqqnaN8nQke7Rjc2SS/ohcRwsNWHVAlbCJZKb0y0dyVtWSyhOg8G05gGv+/WYk6JLhnfOUs0DOQKH
X-Gm-Message-State: AOJu0YyYqj2QNdaPdNw+M5UZ05bCpCtI2rbHAOq0Vi57/hUp1UTSx+nN
	qqn6VUbjV+dzyp6pJz3vjJjJk/ogQ7wWs3vkXLFIu87cSz+ZMyNKQ+NidOJ9BXQ=
X-Google-Smtp-Source: AGHT+IGl5z1tyrVUwbagT4h1F1xns3voGBprBrHmiwNvEjIRNRKVH3O/hQh7M4ZhGb2PBTPjKdJaUw==
X-Received: by 2002:a05:600c:3b84:b0:421:28e6:9934 with SMTP id 5b1f17b1804b1-4215ad1f8a4mr2255145e9.15.1717606635312;
        Wed, 05 Jun 2024 09:57:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:d3dd:423:e1eb:d88b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe343sm29099175e9.6.2024.06.05.09.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:57:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 05 Jun 2024 18:56:52 +0200
Subject: [PATCH v3 2/5] dt-bindings: mailbox: qcom-ipcc: Add GPDSP0 and
 GPDSP1 clients
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-topic-sa8775p-iot-remoteproc-v3-2-a437355b8c7f@linaro.org>
References: <20240605-topic-sa8775p-iot-remoteproc-v3-0-a437355b8c7f@linaro.org>
In-Reply-To: <20240605-topic-sa8775p-iot-remoteproc-v3-0-a437355b8c7f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=3xzA+6EtS2RZb51APTtA6l7MBhz4r0SiIFow/JPj6bg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmYJjmEBNU4cdxwWxX8uQKP5BOEePsRvep0DmDC
 htvJ3CTBFaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZmCY5gAKCRARpy6gFHHX
 cuGLEADdKacHBjFqoR/Ccc89v7tCyYvT/cyzruGsB4o+DzYndibzPvlOejXYIwxWjCOBgTopuxs
 HD+pn33+eMJK/KJyB7Utbdj1C3mpFBN3XEnIv/Jq0iTdySZJGuX7xsk1CC5BYDlbzJIBJG3aEku
 Ch8VwXtQ9NVKS1xIG3fs5zwDWn+gZCDmuVgiqE0LDxRuaxVmiUGSmmf4c5y/VIjVD+RC9j8VE+U
 Hw8eTFmOG5bVTKI9px0Z4gP92bpWE8YHN/TTS8jkVRJ0wtYbTe4islIuPfi3OGVzdws6mL+o2z/
 z+U3CLjEeJCpdzMi2FyfrTlLRR2dc3x1ShFCuoRqOXnXvnfQoqWhn0Ai1j1O/E0cMryU0LNbV5T
 ZYstwDMElWBT1IJvl22BUKT2omZGSd6y/A6idszJtELMddLQ9RPwwEDU6mHCBcAT/tjFWxUVIbq
 k/gi7Lr2B52IyLZKnTOTKgXNbSLRcBYRHzSYPbVbNr8bn6zyxE/eCP8dI3ZlioUttJB7ilvOpvR
 KBUOgrvPjdtUIvBjBVLnJvtaSuGBddTbJ5ncZR/UbzJm1S9n81ZE06c8NzlviVcX8lzDbkHtkRP
 vJMoiBiS/alUVrljHwiviK46t8ePYjpisQkKuOKoN8wz+VgCPfImCqPFdSS9carCwFVtvcIkET0
 CewBQnZwrteGHqA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Tengfei Fan <quic_tengfan@quicinc.com>

Add GPDSP0 and GPDSP1 clients for SA8775p platform.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/dt-bindings/mailbox/qcom-ipcc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/mailbox/qcom-ipcc.h b/include/dt-bindings/mailbox/qcom-ipcc.h
index fbfa3febc66d..fd85a79381b3 100644
--- a/include/dt-bindings/mailbox/qcom-ipcc.h
+++ b/include/dt-bindings/mailbox/qcom-ipcc.h
@@ -33,5 +33,7 @@
 #define IPCC_CLIENT_NSP1		18
 #define IPCC_CLIENT_TME			23
 #define IPCC_CLIENT_WPSS		24
+#define IPCC_CLIENT_GPDSP0		31
+#define IPCC_CLIENT_GPDSP1		32
 
 #endif

-- 
2.43.0


