Return-Path: <linux-kernel+bounces-370407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3E09A2BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BABB286256
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906411E132E;
	Thu, 17 Oct 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ja5jutce"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200D1E0DDD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189010; cv=none; b=cvC1Y3fE2l/UPWQ4Se7OqBsEvNw8328L/N031aJEOJ7zRzRVe4MBJWAqqCQUYtJFCQvY9HsaSlaQGvJI6nxJFHM+1Y9/lDX5hKIWmuqPnSUAiUo59dZPhnpSAZbaseluDCkQ3mzyo2xR1VAfiV2BXMH0wom+wyBeI3D8hPCF23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189010; c=relaxed/simple;
	bh=ZeRMjlnVRmUDMpk2EIrTz9d7+YE0KuktlP3WHGpYyNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m1w9+wM/cS+cye3fPISejhSUWMtYptmLohzAWETCA8kQksVNO36ae10D1ZiNBm36kiQoKRKy9874cViweJqQmmNStDA+KeR5sZPSB2xm8shQPWqRRwzFuCKarEGWeqoJC3b9KLCNeBbvlLvrpyV2tKuFS8kGRyE4xmQ2xN8C21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ja5jutce; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f72c913aso1619383e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729189002; x=1729793802; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/T7dWrrKHgZSyTLwnbzb1jxT+fEL4K0nUEDN61fcwoA=;
        b=Ja5jutce16WsxffkFyMmT2s1q8Zm3hD1juZWWq5SfK2Y9bEKGgwWxpIHw+RHQvsxn6
         b/6/cDVI8qyw3woQMwYBy/0RA9+a+N3rUF1pl0vA2lBmxt6AFA8eY5WwPdaMAM8q7Egv
         32WZAwRJsofB/8ErCVPCjFynxwozuifVs5Uj+bjj77g0wv8y5L7Vgr6XpBqkI49d/jPI
         419OI122sfaBEzQ8LZtNoshlS22TaxUFngoHKClQy0Sc/rBWOFCpFHRQqOc3MkCBdYGQ
         qNpig32qHqmraWSBgk0+tQrONs69MsFncK671/k9a7gPRfQGEzEVOduVeOsqBC1HEmKT
         v93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729189002; x=1729793802;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/T7dWrrKHgZSyTLwnbzb1jxT+fEL4K0nUEDN61fcwoA=;
        b=f4ngAKYXizJlDHyvg7jlOG3O8DQoBVSVhjB1FAbDXz1Sh1AsS+us4F47O1bvHLBEFI
         phWI81gmEZGAaWw/gHhrVn0eT1at9PwHp3l8h9VmoYgHmgR53zmw/DfEOtoXRD+nVdlN
         KRF50IMAZ+V6RsVijDuC+KasczyEzRAlwtm1H4khNMenu9vVz5OEyOe1MlJZhri1W6HO
         KVfhHmsKxX25r6mvsSvWAF2OJJ8cyYdzUOTxhfq00s/+mb2mAWJP32Xq3+X0MH/MgbwZ
         b2PCxsXrXBq4YRUfMsIkSLyPBzzttvGWbU/d5FKekdHFdiUR7cd9bAsuZKOE066nyK0J
         H7gw==
X-Forwarded-Encrypted: i=1; AJvYcCVIS2cBbi1cgbQmlTV0RXL02Jvh3BK9XkSJhMp5czK0y7v+j/bjG3/5uZ5C+qZc0rM81m7aNzgjSERgllU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLZ3yOjhabYuZ2YieY/6EKYpOHJcVmMlCmkoyr4WvHUMQX/A5
	Evek3VXQE7IvBYgkO07LgOBun03RVmR90gQfeibATLg3KuQw5Yi7rQS+NOCZngY=
X-Google-Smtp-Source: AGHT+IHAsmORAs9oNS+DfVSc3081ySAtsUrU2wNzoGE/lFlV3it3q1KaF5n6uqGqzYmopAsRyZtklQ==
X-Received: by 2002:a05:6512:3091:b0:539:f65b:401 with SMTP id 2adb3069b0e04-53a03f96b1dmr5898841e87.57.1729189002105;
        Thu, 17 Oct 2024 11:16:42 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffb1f81sm834571e87.80.2024.10.17.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:16:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 21:16:38 +0300
Subject: [PATCH] dt-bindings: usb: qcom,dwc3: Add SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-usb-v1-1-21e01264b70e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIVUEWcC/x3MMQqAMAxA0atIZgNNFUWvIg61jZpFS4MiSO9uc
 XzD/y8oJ2GFsXoh8S0q51FAdQV+d8fGKKEYrLEtGepRXbLUmIiXLmh48D7w2lHooCQx8SrPv5v
 mnD8cO3h6XgAAAA==
X-Change-ID: 20241017-sar2130p-usb-0e9ccdef61d6
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ZeRMjlnVRmUDMpk2EIrTz9d7+YE0KuktlP3WHGpYyNQ=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEVSHTuXZ7hxnJUrblpVRDQMedes6L+ioPa2bT
 AVnUOSvDMWJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFUhwAKCRAU23LtvoBl
 uBqMD/4i8l1zbQwsVc65HTzYq+0wYy1q/PtfjhAlG9fyT/O0jkCSdg6Xhrg4n4u1ZaBoApfgbRt
 Y/Z4yQj//Imt4JTwWg8npog6Hq8P4d8iAdTZMmAMNIxwo5cOnzoOlnoSuRRkT6WXs2zf1lZsap2
 8MHBVW+OeeSZMqNEu+AN3iiH9TMyFCzv4KnvKjd8nwyd3l/HkUHxEuxTIdGa12XhreZ2yKGITdE
 eP/rkPXh5HC3AN6S4IAtuPOlIHBJPFsFBcNwSO+bLtQkSHQQ4N5acQEJal43ZaWTE+cJ6EmqYRV
 YmBOqiLoGPzLY2+UP5wqHmHoG7b9zkgGr9DWhQliluw6J7sYEMpMDo2K12Pd/o2amf/7LDBuh8t
 4cdbMjN/N1SjPL0ks1jM7mVCt9NIq7twsY+Ak28cZoF/dYPuORf1nBOK32XNuRC6qeAT16Seh+p
 Ph5IPVJR6FijuB3dpntB7iLR7H3Tjm2Glf9VvsLR+t6kU/NX29ZEb2fOGnvL5v5pv1xh+Dqwpqu
 9U+KQqHq/7Urw5NQzfKHquq7rMGKpCzt/gGfS/zbrc4xqpOk/EUc5QRbCyQloIg8v8YQz9NMNtU
 mIcjoMPiAecH5Ihwa/2+qSqbV3cWUnPWnEEXeOhrwIQFouF5TWUi8DjX5edWgLWdm0I6ucT/adE
 gzVbCmKWhXBJwyQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the Synopsys DWC3 USB Controller on SAR2130P
platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index f7be056419307069c67b8f2d53bc88417a19b9ce..935e204b607bbd3bc9bfbdcd03519202197c9eb4 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,qcs8300-dwc3
           - qcom,qdu1000-dwc3
           - qcom,sa8775p-dwc3
+          - qcom,sar2130p-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
           - qcom,sc8180x-dwc3
@@ -340,6 +341,7 @@ allOf:
           contains:
             enum:
               - qcom,qcm2290-dwc3
+              - qcom,sar2130p-dwc3
               - qcom,sc8180x-dwc3
               - qcom,sc8180x-dwc3-mp
               - qcom,sm6115-dwc3

---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20241017-sar2130p-usb-0e9ccdef61d6

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


