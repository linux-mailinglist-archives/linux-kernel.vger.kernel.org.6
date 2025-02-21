Return-Path: <linux-kernel+bounces-525118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536DA3EB0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696923AA9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17911D798E;
	Fri, 21 Feb 2025 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Thj7SIuk"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277841E7C0B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107179; cv=none; b=RFYC+dju/SHGRWwxEF0e2i1Um4FXU4iXI7uuIIu82yMPun6OP1JQ/OzhUL83PpByqxqgzRXJ/gKTt5KV4oSPCq+FH9pxuDBM2jV7D34VPwUdxhtdny7zJmJ/CF5ERSpdNE5aqeA9dAYK94SYpUzIjSiI/ZPbfGU2pw2PGHxp0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107179; c=relaxed/simple;
	bh=r63bMyziS5VAUoRIbBTBNVf6CyjstQjiNuFZTwV1jAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EB619FKLR7qqgjTmbpraJmSgOo66OByAd62YcBvLq8wCbDus/70EPdtnlIWO9iNXNEEeU+GdY/kLVF2pPhWfhFpTEkJCNz/dBqpevT0mWXjL+z6F9ZVjuV5G/ALHUMlft/IUkhDFbOrhGh8XlVz/5ImcutdYQXH7+PP5i1R3CVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Thj7SIuk; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-309311e7b39so15056691fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740107175; x=1740711975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=md2U+XG4zVBPU+kJo14bBfe09ZT4A11xAQxscpC41RA=;
        b=Thj7SIukDN7+EJpsNFLHpo0DrlnZ2pll5VT5txODaHgJKiJePmuPW/sJNkFG0VTki/
         FLFfySz9lLxKPk2CpX3ycOxUQPqRv8MIu3nVGdkjqU4gs6+MGgNSmcRfzHhUbHCZRpdZ
         sRGxJRSR3TptDQVFVV+f3A3tJU5FL8C+lOV/tua8IPwa+rb+ibNRgunfsYZCsgMMd2Ng
         AIrk2QQO2/LowCGNJNTYKyMsWtFCKKBnNX3ekrC0mszk1lcZ0mMpp561fosFhk7Xu7XO
         1MfaYGf8TS0dVxrDmrcWo0Akp721m/0ZbLMy9NiX+4nhHNtdlXsTZA5GO44mP5AW7X3S
         1tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107175; x=1740711975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md2U+XG4zVBPU+kJo14bBfe09ZT4A11xAQxscpC41RA=;
        b=jJVCCuqtMWny09spICQwlBz6MEkHnzXKgPENn0j6qVAiOVJiGhDgQ8CJMe9S8KhNBm
         CLAlWLqEWVCRvHmcZHek45AT8XQBjPk9GPNlc5hduSfI8TE0qGjrZYgJp6XoSaRTvqEW
         v3DGAWFvtkrtrRouDYbZnPgkoa/eHgBsg7djTdAH9KESvoNCox4xL37YVuN6X4sCkwC1
         jN+vtxcOr2hqbdd4winOdVCenZJ7Bf+bZtzwGCHo654n59INafvKZCDtAAvbut6YH8eJ
         mygLmb3Ytk9yFkfbUUaycZXhorMZ3LzIVa3iJwmnPHGrhKlMWKnM0sarHAwUfoZFBJR8
         WMoA==
X-Forwarded-Encrypted: i=1; AJvYcCWBGXAGYAni6DANNp8zoo2g3bhX5/72+0VskVjAnL9mngb8z9Xoja7NQDWU5GJ76voMdyA+nCNaSZbEHpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmgA9iJHFR1hF01iiOXoYeT3OvVeXPw7IZlhFYHAR+ljf8QuJ
	9O9E4CKIuoarU/MBufm/FwRkmfauKI/8MrNsUUWOktpSqQnVFw4TPASCcUmIZLg=
X-Gm-Gg: ASbGncs5vJQRf6HIKntDZ0O6gDYxvYlSOVH4+svJjfR0GHHodXO+MMR+wwko5XVm3Jw
	+rk8ISGAaYUti68HmERy9mgVwPVtaDbvRfwQk4NeIBfPaKtDjTrp1dO8iP3VXbMTRFXXEVpDRrV
	jxwrGosXAFStRJlLahbrnDrI9UxUFDrungv7YFZlOXYIE2I1G4k1dUa9Qinm6jHf4r4GGabS6vo
	79V3n08pRT1gDU3OV/pIzu20Song1bdLjwyMC7Qq8pvFuKBrRkWSVsA3SRxXhXGG0L0PQhHLPDn
	nwUV6FPxk11mPYuSiCp9HWvlDK2mKQknJ+xWhjgbdPOz3EIWu1AKUoyD4NS16+Re7CNUew==
X-Google-Smtp-Source: AGHT+IEkCKO1qHn/CLGLJrlkaW0VmyfjmyJLlNnnkj2GKxT28k4CdaGsFTxMvNT8RgAQ7Nxch7LsGg==
X-Received: by 2002:a2e:9e13:0:b0:30a:4484:3ee4 with SMTP id 38308e7fff4ca-30a59960525mr4536621fa.23.1740107175293;
        Thu, 20 Feb 2025 19:06:15 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2be45876sm16021071fa.68.2025.02.20.19.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:06:14 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 05:06:03 +0200
Subject: [PATCH v2 4/6] PCI: dwc: pcie-qcom-ep: enable EP support for
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v2-4-cc87590ffbeb@linaro.org>
References: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=992;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=r63bMyziS5VAUoRIbBTBNVf6CyjstQjiNuFZTwV1jAY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnt+2aLBoqC7gDH2lR6m3K+MOfN99dXco+FQOjY
 Z7D5QrZfN6JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ftmgAKCRAU23LtvoBl
 uNpAD/4kNOZSOtJdaVWeVbYNca7r58HQ6qqCh6bHGhy2ow0CqxOf3rrkU++ZvfSR+uU+7nMIOhB
 dPIj/V1OG694l1g6LN0r2mYQGAwzhkGID6G1A30OQJg6Jeb4qCGOIBrv0GLKdeppxVk4O9k5Euk
 X85HA795bwkpC95P9r4jYNMFr1oNagHER9g1KKlUOJH6fYOB+llzsCYVNaCmad5of9zuMOkK6Qw
 8PnYX3uP+YKUog7y52RIca5OC/v4WRzzp8U8fNcxsjuEtngK2igQuvsMaZLM46jL9rP4wbr6Gtt
 OZ5WK78E+a0lqaUM22kkOCFkmkZ4gMM1q08hQFZOi0snXM5WCRJvIJOv1dbTBrtJ6x0xaAV1HKp
 yahVAV+hB/DiUlYvB6KoxAJjuixvSz1v8ZmZcCKnK7awHOYjVKgFTpb0BNab4VfHol1xUdc+fUx
 DWQOfBb4uzMPQFr8LRgMpVrumqf0gNrm+Nf8SJCHYAq1LPGqVfomkKWGtq05gsJ6OFQlHTeQLA6
 g1mq7f4ZRp4m6jAX6d0yLeJDdLFZdftnlAhJYrF+k61kqr7fIHUIWKi7PS62nfWGoGQKEvfbWZn
 k5SCY/74hHLh5Ii8iFRYLoSuCtsrPw8dNTBirjYm3XL1ysv0OIkoQnzcGk9z937Vc+SrZjecIY7
 SmyMA1H7CsmeeGA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable PCIe endpoint support for the Qualcomm SAR2130P platform. It is
impossible to use fallback compatible to any other platform since
SAR2130P uses slightly different set of clocks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index c08f64d7a825fa5da22976c8020f96ee5faa5462..dec5675c7c9d52b77f084ae139845b488fa02d2c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -933,6 +933,7 @@ static const struct of_device_id qcom_pcie_ep_match[] = {
 	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },
+	{ .compatible = "qcom,sar2130p-pcie-ep", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_pcie_ep_match);

-- 
2.39.5


