Return-Path: <linux-kernel+bounces-275046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E49947FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6771C21DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CE815FD13;
	Mon,  5 Aug 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B27O5reQ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEEF15ECD5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877701; cv=none; b=bj6vpa9GUP6Y43+wm4nkOXidvbbQgXtFAL9Ej+ZlMgHhMulMEfyOqTp7AHAbd5kysdgZCH+43uAwwTkWczcjS3uL1Shb7kEzDwQa8Lmv8KX870ktOMw1YXCHt8mjD9esMkEJtlUgsDyn4KP9FCbXviV+ZwS4Fmbc+QlTLamwLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877701; c=relaxed/simple;
	bh=MS2pg1hkUFBkA3HoD5bx+WBJu4p2mdrw8oSNHZTARog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7Lky+OvLcd48vImJcalj+nIzwwZkCdvixbxuVeFiYFoxJqosB8KqFFzP7id5Svpt4opgDnMgTDTec1NcDCm2oAfK9eUn4EHfREvaX8bLLU69+7kZDIZJQBB5X2E6djbq95a8Zrx0KJxs0gLxpQtnjoxRjVEql+px1EbJiW6gyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B27O5reQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3687fd09251so5808388f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722877697; x=1723482497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pf/ayE1GI1WAlEGzaVo6/9gInOblIFTdfpLa3Fxp3ZE=;
        b=B27O5reQz47GEcmSPgKpWgWbMpafuGcbLg1kDZwerDGUddqh6D/FmcFjuKiSqukSzl
         MHbCgJvg6BZ03x8IHce2DelKCwzl0TZt62SZG6KOwbup3vkp3YB4SWECqMROXZhMstAB
         Y0DBCHNp53lgj1W6Mr7+e3zzoDOpU6Qf21centQrR7WBaFQtBpvVGFQYL0vjA88JUuW6
         7OCDF5ZeeVQfDLQ1qNDfs8j+GAE5pz22kc0JaN5DFVRZfHHmXKk2bqJ0cU4T575/AAVg
         FCfBzITizONfzIXKvWhtA6PrHEKCfJev9h6Gm2nmeolRZ2UgvS0TTYKBfS4zpj2BZ6hU
         jv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877697; x=1723482497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf/ayE1GI1WAlEGzaVo6/9gInOblIFTdfpLa3Fxp3ZE=;
        b=I7FWduIwaJEAdHhYRd+UxID7QOsRyBmRIRc27JzyazvNCnVZGSfdwGC7w5MnlYGIc3
         7Y6AefgP17QkTFREHEGkBJS8DXBdSrZC4kslJ7wc7tZ2jdIPD6oF4ri/s84kyGcVWeKY
         He1L4IIBpyQInVpfsy1MI8oB8oCkyDDwCg1qqwGyS1O4BnOtgZ3QW3dhyDckfIgoEQlt
         UqcjLWS3EpWSEi1RNKH1sfcwHHrkjlqmaB9nKyZ/lHegxexJuEs89FlRviCX//SsX8rc
         135IDWmffwj1NZCa2vKD22OIa9LXsSZU6+FA8S4+YbZJLaxivTL605cFBsujwW0R4OIK
         hKeg==
X-Forwarded-Encrypted: i=1; AJvYcCVk57vITJw2Dlg2pzR0KUEAokdTLFnUeY4WXDPXhNP95i01VlmGz/RJ4hiCjgRPNveaYUUxt6hCK9FsjHLiuy1oE4wavG5e2mE6dVda
X-Gm-Message-State: AOJu0Yw7eoJoQ5UqG+9mZ1EGO0u7cQnVk+VWTZs4/mmgUbVCeQGSAeUK
	UrRCdcNQQHscvWT1BW0sExohdAfYBAleFXS+ubYFsekPLYzv+TZ/SaHiFlqJnq0=
X-Google-Smtp-Source: AGHT+IG/VsX2YjO90PsbOVyyp86j0OkVdlv20HcJ5UEbUuIJDQujSBOyOBKHUwibMHyf3uCMfqjpvA==
X-Received: by 2002:adf:ec92:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-36bbc17dd68mr7198288f8f.53.1722877696419;
        Mon, 05 Aug 2024 10:08:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1068:b792:523c:3f73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1e97esm10356486f8f.37.2024.08.05.10.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:08:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 05 Aug 2024 19:08:03 +0200
Subject: [PATCH v4 2/6] dt-bindings: mailbox: qcom-ipcc: Add GPDSP0 and
 GPDSP1 clients
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-topic-sa8775p-iot-remoteproc-v4-2-86affdc72c04@linaro.org>
References: <20240805-topic-sa8775p-iot-remoteproc-v4-0-86affdc72c04@linaro.org>
In-Reply-To: <20240805-topic-sa8775p-iot-remoteproc-v4-0-86affdc72c04@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, Ling Xu <quic_lxu5@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=3xzA+6EtS2RZb51APTtA6l7MBhz4r0SiIFow/JPj6bg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmsQb78RUhtBLOHSNtfOqhMB8K5PTHFwg5KQVqu
 FDQvBOBZgyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZrEG+wAKCRARpy6gFHHX
 coutEACCP27ZPwka8RHk//l8LuvMTup9e3R2nfQSO/ysAqpfeNnh+T4W8USF35ZAgtTys3hRQZK
 MfEP7N0XCBxuXvHVm7wJ4mQLs1ssdn5/YWOv216/4AGJZwzvT+WvCxV4BIKYkxKqonjYzwjDzuO
 CfvSJpURdYu1Ir159CHSwI4pkWWvdg+QcXfYiQA7tuGtAI6Hz68bjEv8rlC2RWETLdV6AdbYWnA
 Spxz7wg092RVTt1SiJnxm0+3z33YVICsyUOBwyuzuh/9n0IIWO41rNk6G6Sc2LJ7GKGEnWeJXno
 312X5GnZ8i4yvQOQlbis30TEh3dbmzbgzymlFQ9ryS9l8WUlIDReSGWfIK2vbLSe/L9A7r6CaJX
 +7s2mjenHCP1+BdA/+mqlS9dKyZt1aV0AP3aj7jBB1GPOIxGXGci0UWz822O6AYhrkBCjnOo155
 ZtTRDTK4Igt2V1HhcErxIejoLaKBq8+AQuhuIkKyscjXnh4RL9eqBJdc6EO0fhvyHOWO4UHy1Mc
 ygiorG2/1wIT0kWTLkdAxH299MyiXbdoeQOnSf1GWh4UEmvcD1uTINBVWH/nmCaYPzs3RFLC1Pp
 C7qauf6MGmfxYW8P1PDuAj65DWKBgzNvf1wK4jCEyJCbE9Cfgo5cc5fGB3jJosUlpUg8lo0FMrA
 GBRDR2EEreqG4XA==
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


