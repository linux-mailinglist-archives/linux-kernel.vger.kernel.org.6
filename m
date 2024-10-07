Return-Path: <linux-kernel+bounces-354288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A4993B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D211C235B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920F192591;
	Mon,  7 Oct 2024 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwQnu9Ks"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D0191F9A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344231; cv=none; b=Bd6+/tV+eJqhUfHUpd9JM0vsNcDd4d4DA5pkW42Akv1yasRjrCRYX1H4xk99hOEcuDNPp8v3XaHUQ6OTguC3pkr3NvEAuHtXC1RdGzfedU5Y1dTaFjGsB941PHsnAZ8Yhttq25c/WZaKg50mVfR8WcnC8gbuN/ShKnoIbCMNFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344231; c=relaxed/simple;
	bh=YQocvzYtQugoKxgD8nHuIxgQRJHdd9/v/IZp+pC+8dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGFN2y5EcpOZrmhOUi/yP9HqBIEeYjP84N/ZGufnRuqbnGiT6/v29fofLfZR5mqIkDEytji6p/DRZkqX0Y0ToaQXVKd7/Yenm6mAPqSua8MZ+Rtm6nHVOsFK2v1ElGlH7g78AKUytG+Hu/tcQm41nQibgo6K00J/i1IoWnI57y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gwQnu9Ks; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539885dd4bcso6189596e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728344228; x=1728949028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQLfPZ1C+8kI9P19huvG/Kxk4mb+t0/CSSYBX15+NYM=;
        b=gwQnu9Ksa+XsBCX4oLTowk5M8ZXVlKwBgXwB3yzbnOIsuwcyY3pZel+53uwvgp/h+7
         3FQth4C/MVPbUBTDxkDwUdw1SBzH2Y6GiSd7PEtiaNPqX5iipAXP5FDpp0eJhJh0uHEk
         cYEOXWpbvuC8ZZa05yynHK16qPXItkOYoeUDSrcuiuBLd+t/v/Z6QkTkdryosU7o3TRF
         R9xQ3ZHoxcU/jDYnEN62rYTXnNMInLA1rRl6AkYCIe+CnO+AWGAlgb+Dm7khFWQAsHCn
         PKcPG3GSPKEwwttAQfl+ZkvmNboZkLNBJD+HaLJCHu+/AIISVCXrUHSvjE0oFEkfQo0B
         TvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728344228; x=1728949028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQLfPZ1C+8kI9P19huvG/Kxk4mb+t0/CSSYBX15+NYM=;
        b=HrcR+A+f6OWkzu9oamJTNnSOm2o4/k3z8XQ9eHA0N2uV6A105H9XbjB0weMuDpon35
         vg2AgWlo/oQ+pBSkxmUSQTHBaYQ/dRL41dkxZ90Ftl+UjW6ypZtZK6V9gQxrw4HObx9Z
         Wh3x/CVQSzdQaHF1oD09HNkUKe1lPNdUwVudpM39maq6NtzP++hVsZzoXwQLk3Oyo01v
         8IgG181vnTcgJWqfw67sXWCKcDylapn+PQnyra113r9/kq/go6lg95YM2yp59SzwsvCM
         rCg6NoFW1WFVjMcguvKF44DFtY/1zdDWi5bNHq+kQrHAhSMd6PYMUlaiEMAcw+Wei8Qd
         L55g==
X-Forwarded-Encrypted: i=1; AJvYcCUgSEZLDMRe6MmtU7iIHbfQ0aTT5uitdgeXU1tTuIfk84vFPTkcfBA9rtpAcJW7oN7Lcc8e1wOgcaZYd9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/LpGSct/EjFpv8VODIGN7//IM89tcr89Dg1wVpuAZ+YAgY7Zn
	TYXOP+IaUuJcu5+apyKu5YXP35K6Lp8MdIbKedli5wwd2NuqhffFMuS5JaryYVs=
X-Google-Smtp-Source: AGHT+IHAafBH9iXxZ06NKjJKiojqYjIYWAGrzT88XaX5aKORPvqqhBENvj5aMrFvDMFNdGahwiqgLQ==
X-Received: by 2002:a05:6512:3ba6:b0:52c:d645:eda7 with SMTP id 2adb3069b0e04-539ab87712emr7373147e87.18.1728344227991;
        Mon, 07 Oct 2024 16:37:07 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec1300sm1002256e87.17.2024.10.07.16.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 16:37:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 08 Oct 2024 02:36:59 +0300
Subject: [PATCH 1/2] arm64: dts: qcom: sm8550: correct MDSS interconnects
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-fix-sm8x50-mdp-icc-v1-1-77ffd361b8de@linaro.org>
References: <20241008-fix-sm8x50-mdp-icc-v1-0-77ffd361b8de@linaro.org>
In-Reply-To: <20241008-fix-sm8x50-mdp-icc-v1-0-77ffd361b8de@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Rob Clark <robdclark@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org, 
 stable@kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=YQocvzYtQugoKxgD8nHuIxgQRJHdd9/v/IZp+pC+8dE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnBHCeEpL543RrUo9Z7rVDf0efOxV1fnhzZJITr
 iRfdb/o/jOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZwRwngAKCRCLPIo+Aiko
 1QFXB/4u855teCcg8ExURYV6FCQ8peftzz6joCv38Tr0CKTKHy2CcAG8NbBxqvAN2J2PSMPgvRD
 MRwHus6hw2GV2WLtoCv/IiAMY4c7TpHXlsVWjc+hurwgqgay2NWVJ7gBdrqlPpYPcZ/zpB7BllG
 SR2fqZgfMUwh2RrauwjF3c5xUxFcq/WzmVHvRg54zdDOEjQ8e1G9ANQJ8WHA6RLA/g5piIddWI8
 NfO5PqNErESUpBZEuSZJaGZa/4Z5/Lcvm+Td20f8q2wY/z1wwW9ncvxdjcO9dOPzuyoXPZMceQU
 98N0JCD9zH9JE3zzcJji6Shs1acdd/aVlqgkHQLt1A6OnhH/
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

SM8550 lists two interconnects for the display subsystem, mdp0-mem
(between MDP and LLCC) and mdp1-mem (between LLCC and EBI, memory).
The second interconnect is a misuse. mdpN-mem paths should be used for
several outboud MDP interconnects rather than the path between LLCC and
memory. This kind of misuse can result in bandwidth underflows, possibly
degradating picture quality as the required memory bandwidth is divided
between all mdpN-mem paths (and LLCC-EBI should not be a part of such
division).

Drop the second path and use direct MDP-EBI path for mdp0-mem until we
support separate MDP-LLCC and LLCC-EBI paths.

Fixes: d7da51db5b81 ("arm64: dts: qcom: sm8550: add display hardware devices")
Cc: stable@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 9dc0ee3eb98f..cca10f9faa14 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2871,9 +2871,8 @@ mdss: display-subsystem@ae00000 {
 
 			power-domains = <&dispcc MDSS_GDSC>;
 
-			interconnects = <&mmss_noc MASTER_MDP 0 &gem_noc SLAVE_LLCC 0>,
-					<&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
-			interconnect-names = "mdp0-mem", "mdp1-mem";
+			interconnects = <&mmss_noc MASTER_MDP 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "mdp0-mem";
 
 			iommus = <&apps_smmu 0x1c00 0x2>;
 

-- 
2.39.5


