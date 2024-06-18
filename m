Return-Path: <linux-kernel+bounces-219186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0DE90CB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C970B1F2624B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7813D888;
	Tue, 18 Jun 2024 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eb3HmoOr"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1713C3CF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712101; cv=none; b=tNDbAufYaNsDiEPaDKJTf9diEK7DxJ12Uwd9zLNU/Z64nd3UubU8+I8olBQ1YSijWgY8ucGo1GSJFWcOunhDSX1wvUCOu47g9xg1TY0mspdxdIigteHoHYg5xB7ri1+HT0GODZLKWWoAmqekhHxNc7OacfI/QoD53y9biPGrMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712101; c=relaxed/simple;
	bh=E+n29sN8P5AtkOG7yLFIflLhEA6KBCE5a7tUsSeMhLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rln1LdZbpOlvroh+ZVA8PpJTr+NVqo7FQ1kKo+gdXLkKOpuIopHsmg4ec8WPulDX6heCTMOqP7WftYFVbBWEZuWxqhOQaJ8s8va52+gA/eDRrTLL6TtRwuDTh9P+RzLRga9IWx6rGnydMoeEKgJs5D0bOk2nbSYaSg1r69q5cbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eb3HmoOr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so6042393a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718712098; x=1719316898; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsU2v0wJVmYuApk1E+Da8U3hDf+aDRCuqM6AXndVSqc=;
        b=Eb3HmoOrUrzExGR9XLh7LXBhbELNkppZ9sr9aBk/2wApznQofFIvkAkBhbYVRk0tlw
         UhQ08X/LVCOEFIsVxLcBnAGbQHH210RX5omv+Ro0tm2NpCBVkC1o6Ymn0V8UEWiRKPBE
         Lc19DCX6KE6hJWOItx3oEhftYR8QrBu97Vi+vcK3hz/fbiUll9E0S1KKiIS1DoR56t15
         YBxjohbnTKP68bUsSyC6/5O8Ukgl0x01J+2QBVYoKjVBwcptvEO432bIQtVX6JbAQIuc
         2pFO4JdeyjqQEmlsm1H7frtRPngr2le5TIwLVaqTukF70V8VI9H3h5+Wa6pEye3d0wgX
         Nszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718712098; x=1719316898;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsU2v0wJVmYuApk1E+Da8U3hDf+aDRCuqM6AXndVSqc=;
        b=SoIs2Z7yQEq2N7l6lm1CFocQMQNNJZvSTF0K5DGZ/wfF56zHAzUpQayxiDN++mxYfJ
         XqsLet6dMsYIAvPc1jxuhUkWGCcunNaIPRccpxJR0bAEQJZwE8kUmujHg8DHvlLBjCYa
         yr3Tc1DsXMdkyfenv/V7QhFeI8CBDHBF7l7fHvl30RPGDN+nzeWpTf8TmBz1bLUp6Ajn
         bYo6RDTOf/IiRYsICni53LOiZ6T47AQoiEmIjF+bdgmnWnetehtRHXyfYJhdf1Cylsg2
         Pj9+5h5Owzo3D+WfrHOpjM4OBO9b8WGVCqYm2QgDjtIlcc74uDCcFyxAxHT2HWVulEy8
         omkg==
X-Forwarded-Encrypted: i=1; AJvYcCW+SFmHJ4zPVUaJhkwYUUbkpkBKIJo215b6QuNmh4DmHNqK9dWtrEk4v6pLLbT0WArfEUtCJTyOri/s7oHCZEYtzTncylxGHxOD0S6m
X-Gm-Message-State: AOJu0Yzb36+Mr4Jpz6tsNIshfRwRcuDIwiPYg49NFjiblSyACymM8AVG
	Tn1Ndj96ICjrD7WVMea/bYYLaz0svv41LvJ/DH/9S6sWRj4uoA/AwH1e2TtuS20=
X-Google-Smtp-Source: AGHT+IH0b8oA5xMFYhzt6HAcQqpSKpHgFsl2/nwBFkxeCKNkT7og4BH3dETMqQIucEPQvIDcNeEx2A==
X-Received: by 2002:a50:8d4c:0:b0:57c:bd49:9969 with SMTP id 4fb4d7f45d1cf-57cbd8e73f4mr8093550a12.39.1718712094559;
        Tue, 18 Jun 2024 05:01:34 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbbb5576csm7062638a12.89.2024.06.18.05.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 05:01:34 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/2] pinctrl: qcom: add sm4250 lpi pinctrl
Date: Tue, 18 Jun 2024 13:01:23 +0100
Message-Id: <20240612-sm4250-lpi-v3-0-a8dce28f20a2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABN3cWYC/22NQQrCMBBFr1JmbSSZtAVdeQ/pIonTdqAmMpGgl
 N7dtGuX/30eb4VMwpTh2qwgVDhzinXYUwNhdnEixY+6ATW2ujeo8rPFTqvlxcob57H31utOQxW
 8y6S8uBjmXRGPO30Jjfw5EncoCENlM+d3ku9RLeZ4/gWKUVqN5hKsJRNCT7eFo5N0TjLBsG3bD
 1YRQry/AAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alexey.klimov@linaro.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=913;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=E+n29sN8P5AtkOG7yLFIflLhEA6KBCE5a7tUsSeMhLQ=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmcXcdNw6jct0B3z1KZuCHHH0cAnrZAiaogX0dX
 pSQmtRK5OSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZnF3HQAKCRB6of1ZxzRV
 N0iOB/sHC+Kaxf5HYXWOMmSear72SxkWL7t2ACKmlj7q2swijawD++MkwR226FHcnApAUYdynMi
 ovZOaUZzcJEMPayKV+eM16IEuYHTZllUgBxX6UEsPp/LzrUQBwcxepLDHx8TzJoJhCOeoR7syNF
 ZAyDgQ7cKBzpm6z3/u2yZVH6hC92kqff+LE/IeSJiOa/Mirch85MZ6/oMs5tfIcwypw9Evr9fer
 maehiD8PHTcTKE2cRTylwzWCE458vKAYaDSjAwHEZBpliJuz2Yvjt/zSG4iNldc9qPaomiAX2T8
 2IXUqt2bXDUDrmRa/X088DfK9/4vBw0uCUrXZB123I1l8PNE
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

Add support for sm4250 lpi pinctrl.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes in v3:
- updated dt bindings with suggestions from Krzysztof
- Link to v2: https://lore.kernel.org/r/20240612-sm4250-lpi-v1-0-f19c33e1cc6e@linaro.org

---
Srinivas Kandagatla (2):
      dt-bindings: pinctrl: qcom: Add SM4250 pinctrl
      pinctrl: qcom: Introduce SM4250 LPI pinctrl driver

 .../pinctrl/qcom,sm4250-lpass-lpi-pinctrl.yaml     | 121 +++++++++++
 drivers/pinctrl/qcom/Kconfig                       |   9 +
 drivers/pinctrl/qcom/Makefile                      |   1 +
 drivers/pinctrl/qcom/pinctrl-sm4250-lpass-lpi.c    | 236 +++++++++++++++++++++
 4 files changed, 367 insertions(+)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240612-sm4250-lpi-b1ab26b3b050

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


