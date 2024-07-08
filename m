Return-Path: <linux-kernel+bounces-244733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F129B92A8A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C451C211CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BC614A62B;
	Mon,  8 Jul 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HimCvSTo"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A81149C43
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461950; cv=none; b=cnRFwcpMWNt1KSUTieJZOJDg0wYqWKkL5o7Z13FEotztgnIizVghPW3KIidOtqzOawhe+6EJ3knZdEWsKtVr9dLG5IFopklz9EE+//IWCJbHtGp/9r/Mizxiu34sAYCLQiBYY+TRt+H4KkNoiiUm3rEra0oOpIfUmH/O0rpoOkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461950; c=relaxed/simple;
	bh=8RLjAkvbd9deEwBz/GOWHSJSSqFw/q5XUI9esz1VxSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJnlvOSynutAIuzRTustRuxHBqeiwaXluFD6UiSOcRaDuKWZMfDqdf1oosLoAHIXiqxTSzdW/RIY3kvARIjN8uGRqZ02dQ5DHEF0PbrSG8+wbR97wTAhpDODI7M6PW7Bi6ll1gcxGfYWVpLM0rd1VE4bkD6pfn48wWivhvgB/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HimCvSTo; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7035d5eec5aso1605715a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720461948; x=1721066748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxcirFeeuu0bt0rjz0tmui1G8RYDC+/JunVt8zPPRlg=;
        b=HimCvSToBRd0wyTWybX3iK/ljx9N7x5Kf6z/EztaEn00F9+Rc/ww6NWSERNxX9I4Dq
         u+UtQxi3iXxQNkDgvdHx1UcsqntPliN62vvsQ/GpcQJ4E0ypmkDJXAOVxHxd6mlNy6dc
         MOICnrtX6KhNXfaca8UTv6HI554B4n+jJx1IDSv4xX9gJeaJZsWWfunwwb1hcmouE2YD
         iqs1oXW97dkfpIPtsOx6NQSWjGMcvUbOxSUqfi+dLduw0+Nc6ghLHJvkcSnMMnX55gsI
         aQsIJitQOMgWfJpL9DFN3ZhRmfzZGNEIPU3akNE9B06+1casa95QtMuz3eJfAtGvIH6X
         Y7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461948; x=1721066748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxcirFeeuu0bt0rjz0tmui1G8RYDC+/JunVt8zPPRlg=;
        b=Zd7PgRFpCrMXsaOjBFVANM6yFEicfzqJm6q/yqORNj5DPoUUBBz6SRGl0uh7nc5eXm
         0SiysCvo2jBulJhyGRXgB2YMQMikD2yp1oqH0ZoA/wL212kuRC3H8LmD5Ol+AimjxkZO
         yucZ0+XeOwc3Na8OeSYgvfKCo+GdFNYiIXfpkQvbD4FuH9fvNyzZSPS2pl/p1HolJ/DT
         OWY1HBbEp+yr8ELsV2K8IkRDDBukoV6YlovFO9iRHCM3ODmt0JpZaeNpgEsY1uOlGoN2
         3AF6EuD31t59iasKeeovUW3yJwiSqVQYFzGu4KPBj3AadNIr5TvKDkKNg+HNDkt9R8iB
         OKGA==
X-Forwarded-Encrypted: i=1; AJvYcCWIakAndrSF+gxJ2Uz+EASibQmNocJVFOYyxIl/BwsIgJl4WvglnGG30mRjf6tyVo1VWAj8X3xMiclp9I5nTxB3b0rB7Uu8HSALA3Wp
X-Gm-Message-State: AOJu0YwUiRg4E/ur4AkWeTYaRUQg7DjvsvnxdOi51CBbeub4rodMg3vW
	BbWCX2IQ4BubPm06H6v+oJfyKdXye1uSzoC+nF40jDp6p4l0miO8Pkett1/RZwA=
X-Google-Smtp-Source: AGHT+IG8otGIAka26ozpbixMx1Ghd9XSCzhxkO203rOwzFDNLcLqz5bFlnD1pgUMtGdNE1fgcqq6yA==
X-Received: by 2002:a05:6808:10d5:b0:3d9:3802:3855 with SMTP id 5614622812f47-3d93c02038bmr176901b6e.23.1720461947976;
        Mon, 08 Jul 2024 11:05:47 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:cdd0:d497:b7b2:fe])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff184sm76287b6e.10.2024.07.08.11.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:05:47 -0700 (PDT)
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: qcom: Prevent potential error pointer dereference
Date: Mon,  8 Jul 2024 13:05:37 -0500
Message-ID: <20240708180539.1447307-3-dan.carpenter@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708180539.1447307-1-dan.carpenter@linaro.org>
References: <20240708180539.1447307-1-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only call dev_pm_opp_put() if dev_pm_opp_find_freq_exact() succeeds.
Otherwise it leads to an error pointer dereference.

Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1d36311f9adb..e06c4ad3a72a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1443,8 +1443,8 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			if (ret)
 				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
 					freq_kbps * width, ret);
+			dev_pm_opp_put(opp);
 		}
-		dev_pm_opp_put(opp);
 	}
 }
 
-- 
2.43.0


