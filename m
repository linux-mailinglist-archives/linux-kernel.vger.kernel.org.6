Return-Path: <linux-kernel+bounces-275045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A745947FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE1A1C20DA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D9315E5CB;
	Mon,  5 Aug 2024 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zCinmV2z"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0115E5D6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877699; cv=none; b=ZfK/jssOSQjf9l0MvysWapLGZ0WKyBAoAOqMcxj2x58pkLxv6QiO721JweTPik780gKTtNlizlcNmRqekSB+VXRADmjNQtMl0pQCyiSLgC+Y0U6i/+waCdyFHOn8KuP8QPQAMghyMYFPdom/Uj+bOCObTN2++OVusPHuI3zqu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877699; c=relaxed/simple;
	bh=U4Yrkr/1FUA9utaWksFQRdKv+TSMQh6qHaPrPqBBdcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRPY9Hj2ITEr+hRh8Wnn5O4mwgEDUi2tGhETqt+f6YS6KHvKR7QWMg4AVftN7iLsl1GFXqQN78MPapsc+4AdrVXVeKMXPJYEDhd6GQJKr1XlOvd9ib+hVDwt8QDnP66093eLzkcmWlkeoraNoa8zTldNDSpc7kxFLJMcuUm6SBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zCinmV2z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3685a564bafso5559209f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722877695; x=1723482495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dn2RM+ZDso5lrlzPwSs7Bj15YQ8/HyMl9b3r4MixpG0=;
        b=zCinmV2z8bZjjEfBShLefYwu2DmdVp5rD8CtrlaaOrp6AfXvPwbiEAhYv8EW4quVTb
         7c6iFXm8JUis9gwKrDcmuRZ2hnvS24WseGzkzy47LBHzNg8E1XTOUZ8aiQ4yEe+rZw+9
         j8hkxFQcSlVSbh3fBxKNg1tfQ7j/5qsngokccF7CpqDWVjr0DVQka3gEj4+7jikDRx1b
         37UnQSMlWJkfWG3OUWUT/h7ZriWdC1/G3leUVxLUv24pgsdsrs9+rKPLluaCpI8bedu5
         RkgABlcq3gPfBPq4H6z0GODfZoEF18pUGwm8ZO7Qwf0Fpi7DK8czX7PLc+HTjGdZVN1I
         C6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877695; x=1723482495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn2RM+ZDso5lrlzPwSs7Bj15YQ8/HyMl9b3r4MixpG0=;
        b=nAsDmytNdqWEfFWGMWjdUeN/3uxpaickykxRCU+t3CGk3S1BLXNW16NSAaYuwG+LqF
         6/mla+M7eEWt/7ls96hok3aE0GX51JUa0hvNYhYPs6wtt10gvK4djdJBXX5lU7YYvH3X
         frpDlSlhT0E2qIEl+jKGnaUf7ZjnwYJf+IJoKJqNidwwEpdKIZqtejjVuG4ZI+TmqqSj
         csAfrFy3IaTmHLr/wDWJ3yn9x6eVsEpR+iEd3YRki49tKVu1blgPSAT+IHIp4pt64bXY
         1bZWxZJvUKkGnp8CGq7oj/N7rlAoBLf9PRITW8J7CDX5lTmFP9Tr3huj/Up5FnAbmjIz
         TLAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP4+kG1PxOVP2qBTiFF1AInGL9rVUq+3nciTQYl4cGXAYGCLQgGAj/EQkHhZ0gJvsxzATBA79+VGiSViM8v0iSqAapA9ML+2P1hqgd
X-Gm-Message-State: AOJu0YxvFc1E/d7hxWA8hChRpDPsPQjdeXlRn5lLbiced445OAouasWh
	ECafMZHTgmFH9NWgT2jeN3Nbt2TcE2DgzZNd5Ap0bPV0hfUEdaQEs9Dk97pue00=
X-Google-Smtp-Source: AGHT+IEKfqaTzsTmB3rUhwgud6SL21dlvmemD/eKkLdcJi1HLciZsIFIr1IV1IKmjvrbV+ISF/vxfQ==
X-Received: by 2002:a05:6000:1184:b0:368:669c:3bd3 with SMTP id ffacd0b85a97d-36bbc1615eamr8534064f8f.48.1722877695222;
        Mon, 05 Aug 2024 10:08:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1068:b792:523c:3f73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1e97esm10356486f8f.37.2024.08.05.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:08:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 05 Aug 2024 19:08:02 +0200
Subject: [PATCH v4 1/6] dt-bindings: misc: qcom,fastrpc: increase the max
 number of iommus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-topic-sa8775p-iot-remoteproc-v4-1-86affdc72c04@linaro.org>
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
 Tengfei Fan <quic_tengfan@quicinc.com>, Ling Xu <quic_lxu5@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=812;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XpvuieHO1Z/MLgIPyh1T3MylMHngpBvRq9vX5mwxZSc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmsQb7wyIX50x8zuR6LgQJLfn5HL7DJIr+01A8A
 ULFPU7Qxe+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZrEG+wAKCRARpy6gFHHX
 cgprEACxx/KpzkMNKR7wVSDY1Jhtb9RdgoDl1Aw9LGfqHdlfEvl1kmwTfvYgU+LlrHyUuKokwIG
 Xo8NbgB2vadUePQ32uvQjZ+5zr0tJIzalFtgAgc3BwkbMcVnt9/wRVkHByNuZHjE/3dBL1RzQB1
 KlhDJLFl6HIr88OCHjEELA6xdQ2ivABdiw8dpnoFyCutUEbWGfMJVd3BpjFum3vpjY1Ya7R234f
 vTzrZsbcE/Ea+FNU93s4VRslAy71tRcBgEPCxBXe4wRN1pvNk2VIe69R//xx8G7suZRi3YL1qd/
 zxjHjzAOP9AF+2TND4daQekDbQ0XMXcpf9mCkgncYz9e83lREcRc/8AH/5hQBdBUimD5n9cnowb
 vJ+ztfWws6i+YqNP7y/+jKYXYbTF4zfOMg+4Tfe7c98MCRKA2KFplALp2njy/o1oGBaJRl/C+fN
 Q6WMTnNAwtHtVUMCXpZ0cZblg2yT7LQ9Y4i59cvqMSk0J1wfG++RoDUiys5Wm0jDp4fsMgUnAOS
 zxVUesEajLtKT2Phum44owvQaH1WrjhoWeLqIY612lLStDYWOGaS4+cXTEdyOsMyPyrqfZirFdk
 qiSRoFspIYLFVgPt49IyZNrl81vJrqmFO1o6OoRT6ac7vDTYVkXhhCWYQxyALyr4XJ0MDF/DM0W
 oXI1HjBh0/NEq1g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The fastrpc components on the SA8775P SoC can require up to 10 IOMMU
entries. Bump the maxItems.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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
2.43.0


