Return-Path: <linux-kernel+bounces-187133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 188298CCDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBE9B22B74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8692213D520;
	Thu, 23 May 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ea8UkXrI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191B13D282
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451190; cv=none; b=Ft4ULe59szY+UFiUMsiK2zM8EEE3Hwbi43qiUNGq2DgVSTR/N1TARN73qhfXVr1nidL9k6SPEr6D3C5/bG3CQimQuUoFUWelYm2jIIDr0n/qEEgmz4Pnhz2kxcZu6onjKTWcMi8if6y+oHW6Z8lmWVBGQsWi2M3gY128n1kWrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451190; c=relaxed/simple;
	bh=ilS9/urat3r7x1lnhAo5NEEctqUaqIeh25qT8NExnxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFrjuN4W+Tkmwor+GER85AB7DVq3A+cxYXW2aZwQqoHSCg8wFag+WkEdaU9jb5zkgxANs32btDQlkhEHr6r+ItzHhxRwRsHFgvtA6aM9U82NCRe9hYJipXMH/hL4x7pRbC3BXm47dg8pRNIsxxnVOpSjgqU8nC7YMLkCh78aV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ea8UkXrI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59c448b44aso1093537366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716451186; x=1717055986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1l8AveQIqcO0cLiCCKIDbAyj5545roxssowTDaQ8/wY=;
        b=ea8UkXrIGDw+6Z4rBxiIh5p2p0gPSNkdGE1lY63KJhueR+5FmEnxViPozz+NNKwcjX
         X+ijDi9VSPdvBdbr8he6iKO35kE/Dk+8LNi+eZsaQEqDW57FFMjGXygjQJWvIr7WBMUG
         T7OmLUCs/ANmsje2vIWnjKv6Y3Em8EeR++I/KNgbbBSoZ3mKy88LUvLQSkvwiHu9Dsmq
         yCok/6mecfiMW4a2QgzB0nuAc97QFscWKKNmPogycx/R0+wkkeFqYoOouEv6p1Yme4bt
         0N9WgfxMY4f1aVGqY+NFCLBDlOsi33sgE8uRuE0TL6995ZwKW7y1emrR9soyfFapNO/t
         wYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451186; x=1717055986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l8AveQIqcO0cLiCCKIDbAyj5545roxssowTDaQ8/wY=;
        b=uv+DvjWpfShuXZ+tCbsi7qKHjgu26RQKGhpqmdIn2JJU7DOuaRdRYM98JRzs2Mqb/j
         VeXrkav4rjDi66rPsw2z1KkbViSRt1mr8AYrny4TDIPoXvqtAtVrJdy2jEpIFyQ89aD4
         MdqOVIAtGrDOHc3wChDviBvuz/glHdypl7prOMF1sDEFKJwAt+Gz6l+ZC+ErbH5nH+FB
         wvZGJUNqFeUuXZv1e6v8a3EfK1tWxNab1A4BwPbJGd7/C+QgceCjlYBGFVmmzmCvBftk
         ovyinkyx5uj+sCKwdgFexFQw1FCZqfghmplpkedQj+EBpz0aGf26NE08kxKP0U9W0pQT
         Px4A==
X-Forwarded-Encrypted: i=1; AJvYcCXwmUBPi8LlSyeQTJSABJaTnMX/audADyvturBq792a7O4xvW0w6fdeJnLy5uDJxAdwDIRwT6ufPbcVYisCTH1FmV+nKeUx7sXD/lsJ
X-Gm-Message-State: AOJu0YwbKd1RNaJOvXmXgxjaGSd0t6L7PgQvA97J5IBAkgdWkVuUrZOE
	DETR73m+bkDM/O7BVGwIttcuZPer0Vj1mXeM5ab/AGc/LGPpkS5PrimvS5f1K60=
X-Google-Smtp-Source: AGHT+IHDUDGPoRmhzc1y+HdVOcNh03PVPRDhzhnYtKagrooXx9KHPlgrjlbWS9Y1S4MMVW4mAicMaw==
X-Received: by 2002:a17:906:8d3:b0:a59:c9ce:338a with SMTP id a640c23a62f3a-a6228055763mr265081166b.2.1716451185963;
        Thu, 23 May 2024 00:59:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:825d:600a:c16:a973])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5ec2a8f320sm719100066b.170.2024.05.23.00.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:59:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 23 May 2024 09:59:34 +0200
Subject: [PATCH 2/3] dt-bindings: iommu: qcom,iommu: Add MSM8953 GPU IOMMU
 to SMMUv2 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-topic-sdm450-upstream-tbx605f-v1-2-e52b89133226@linaro.org>
References: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
In-Reply-To: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=866;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ilS9/urat3r7x1lnhAo5NEEctqUaqIeh25qT8NExnxU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmTvdrgwWMsuwD5nqBiyBc1hr/qz7nPDXlwLE6C
 b0zXVm0OcyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZk73awAKCRB33NvayMhJ
 0f8aD/9exaigPI5V82THskUmRLc8QOw3F+N765LIxtZ7qjjK4d1h4nmbmOpW+gmbJ62G2XJzr1L
 RAgHHF1HVrR9QdLJc0n11LCmxam08hb6ALcGrG/z9W75bemeVewyTDptxjFplQ00G9yPUbhOJBC
 ecDt5zHVp2J0gZQZHdrLpk94REOlgNKGAxmFye7MY89ZkE0rlQDByKpMM+8LhrOReyr8WzIxpWX
 33LfDaQz0pUYAdJfcJ8B+A5M3jJbX+XMcS96GRdgNYVPbMZoRn6c7gycqdoFZmRp4NfuAcy8XL7
 ImoZ9QIneF1QYkCrME2j+uSbPKFrcgzApXu1EqEnN7vA0C4frcowKJ8tS9vvzBTEZpUfm7S69xW
 Vxcyoyor9R1FAkx0Xm8pz6rUEx4nyqE7zVbAarrkJD6JrKFj0TeCAAN4t6kS9vAxuTKBenQFqot
 wIxFxfvfiOlBcFO7/+RdkadD7mn0wDm288zZbAMjmcVDDhTwM0kgiMmEexwtDwSERX/6Gcr9vWg
 D4M9j3yMTuDGHZrRko9C708x6e0OagpK96oNWtRvy4gC9p8OpNb6aZ6DOvHEGvBqLurCSJOVDyC
 LQgjS1awT5iC+fnt3N5kKv20bXnop0mDqz46fIrdrrd6sMBPZslKiXrG5olSpYeI9dzHj6V+SMv
 QBKSazFEPds+KLg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add MSM8953 compatible string with "qcom,msm-iommu-v2" as fallback
for the MSM8953 GPU IOMMU which is compatible with Qualcomm's secure
fw "SMMU v2" implementation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index a74eb899c381..571e5746d177 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -25,6 +25,7 @@ properties:
           - const: qcom,msm-iommu-v1
       - items:
           - enum:
+              - qcom,msm8953-iommu
               - qcom,msm8976-iommu
           - const: qcom,msm-iommu-v2
 

-- 
2.34.1


