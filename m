Return-Path: <linux-kernel+bounces-511579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4CA32CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA8416BAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E902262817;
	Wed, 12 Feb 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfwEZOHQ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951726156E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379869; cv=none; b=eBYIjvSUlZSK5ZxVRI4VyIBpkZo8Z+OTTSFqEMWH1xz5Om3DWDPEHqKTqxO82xKpRIPK7ipHIQMdae6Rtj7MCWFvplxeKUAwY3mjIT3qQcFUOz7PSSY2phLrPyZ144bakRhJv6y1n4j68hjrbNN+jpLOhbQ1tRNrRfugYnK11W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379869; c=relaxed/simple;
	bh=gm/du2YybA38W7YJqV/I0UhkP/ii9HBt6Lhq0K+G8zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jkb4znKZOFnrXRmSartNZbZOC5gxgQffGOv9DQjfTptlBDPVvb3OYFN+EXHKhxwLZjJjmFQPvH8DI08clrVfsllSmsYU9mfWGW1vbGE6WbOd05y20jNQeTwxWWXOxPTQBieByncEP+WTcvN4HDLxFyJB6Rdvj1vde74vLOMEtcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FfwEZOHQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so943822a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379865; x=1739984665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImRVu3AddUI/G7N8wE6yWqCv2pDeO8zZgPLOwwAUrbQ=;
        b=FfwEZOHQ5WfoIzMz/vMtt3jhfvrybbKssShql2Z4raVq2oeUWvBNQSNgbwv8X2DRot
         d8rWvrXbZXXdae5XZ54YlP/7cDZ5EZZ0Nh9vgbPYmML7xL/qj4NXuwOWzzePKX5HAQpb
         RGgGN2JILGHceifqelmt5Z8K5wMthd5g12gW9HpyLScSkrUp2FnNoizA/fMAfh8eVQx6
         yeE4+bS9RsFDvYknZ9YB4lavp2FRqqWZvpABG4fWWUXMnn7IlfLGkkpiTV3kCL8y97Zn
         08GiqlY526PhhQAY4nwig49fb3smD83/shfIaKAaZMxznC+WCFJvy4SPXL4F5PR5XjOk
         N+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379865; x=1739984665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImRVu3AddUI/G7N8wE6yWqCv2pDeO8zZgPLOwwAUrbQ=;
        b=X3EQjstTZABoRFxq23JneNreqFEs2IFA+CkqORko2od56/wW6qryXIGghfATuwQLzM
         PoBKki2f3s4SLOAFKsMckRtLYM8daoiX1kSMzMatouuJERESZZg8Cpnhdci7ROzWyHMb
         dg9+bS9OPUI/ICzk+5GX+PB5+BV3T28heTY1CYy2lzRI9jrVBp2vmkhAfGT1fbZNRGXT
         TPVCKxgPdLcUMdTLbONihLUB/uvmkXWJ5roC+U9uPbHEkn3kaqTE0IHiKvwUspUNgcnz
         GTMfLmT+8ednCJzo/TVa9XTP865YwwzUBS+0XU296ie5s/ekM7YpdLfjhngEMnAWwuds
         K8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUwRuLvE56i2+v/YJWienYtxTBrqe3PATyxpyS95n7zF4WdfRFuIkZNkiqoe9aE6eGVwbphB6psmJF7Kus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVG7g8cXDDppCQAtxYKTpykCM37MsMshQOLzttJzEC/nrHVEYQ
	ZicgNVFMsbHwCZT2R5RfjakkzDwUSAjH8PX84o5lA8zTC4NUVZ7KwYKEmBEjZBc=
X-Gm-Gg: ASbGncuJt81EQh7ZHrezgzt6piHgo8JTKzy+bZdU76cjltR3Z7GKmVXcYUw38ndZuLq
	p/AvQhM5vACuU8fezF+Wga/wjH0P6OwcBg5zj5trtsvHCu8tQaH5BfuEmEGnfA97gT7XyL9baL2
	gl4XnrA2pY5ixpLo5Ys8oDG6yzryG1X40e38TtNnXp+I+akSR0gLD+6P6vMfBcm9WcCTjnhQ4E2
	b3dcqEwfWe7/Al1arGArycWIUOwBIfOIe0GxgZazLucWQoMf8LcLyqW8R4qXOB/UuwobBfuM+mE
	uvrYllzpOSPiQ+vrBrNudalMDve6
X-Google-Smtp-Source: AGHT+IHcYXuecofg3yiMP0NUjYpDinedFykVXcImtUN6fTzgyJOzlkYtZX415Z33x8WimpPahFb58w==
X-Received: by 2002:a05:6402:2755:b0:5de:5939:6c34 with SMTP id 4fb4d7f45d1cf-5dec9950b77mr20409a12.15.1739379865117;
        Wed, 12 Feb 2025 09:04:25 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:24 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:53 +0100
Subject: [PATCH 7/8] dt-bindings: dma: qcom: bam-dma: Add missing required
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-7-f560889e65d8@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
In-Reply-To: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Yuvaraj Ranganathan <quic_yrangana@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

num-channels and qcom,num-ees are required when there are no clocks
specified in the device tree, because we have no reliable way to read them
from the hardware registers if we cannot ensure the BAM hardware is up when
the device is being probed.

This has often been forgotten when adding new SoC device trees, so make
this clear by describing this requirement in the schema.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 3ad0d9b1fbc5e4f83dd316d1ad79773c288748ba..5f7e7763615578717651014cfd52745ea2132115 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -90,8 +90,12 @@ required:
 anyOf:
   - required:
       - qcom,powered-remotely
+      - num-channels
+      - qcom,num-ees
   - required:
       - qcom,controlled-remotely
+      - num-channels
+      - qcom,num-ees
   - required:
       - clocks
       - clock-names

-- 
2.47.2


