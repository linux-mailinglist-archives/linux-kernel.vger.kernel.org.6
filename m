Return-Path: <linux-kernel+bounces-561048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A0A60CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5365819C573C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3191EB180;
	Fri, 14 Mar 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="iFs97C4K"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15321E7C32
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943838; cv=none; b=lxspDVIIU4yzuy4RbTzQMNEoCCsBfIzn0lA+Oi4ZWpuFn83PYBMvzz9O9zevg74mdWrEXY/+RVXNTR6WJ6YL7Xjx/nA+O/NvbE0cUp8pg+NkBjG3sqIZOBQ0agoQj8VoyuxjFbuhq4iyzPcxigFen1neD/4wWN5j2hAB+/kHeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943838; c=relaxed/simple;
	bh=Sm5xlwLhcodwPiDgY39BbRRVls11wMnauPuse5tsPBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oe6Eua0nuDR9Wkeu10eDzkn3AVcruSzrAR4hhCroJ237xhXnIVHWdTna6xwtnTWhxeIN+uwOJjDYXVyx9CbXr1LPnWnL2wUQkw1U7hgRqrKeDnHyBbXTR/GKuAehT+8nG6JrU7G96TSqh6auxVaXnEQXJwRngWqoshydYVaztI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=iFs97C4K; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac27cb35309so299385466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741943835; x=1742548635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+J6vQaZBbwxU2nxEpFw0lhiNGl2qx6LemoqnB3y8K00=;
        b=iFs97C4KHeK0cW0XMIyqi53qKywzCnN8c85jRNzCoJxmRVTc73UDe0XwCQlzJvbalY
         ftqrFuw297T6VItPvMBb4vimoVESFaJiric03qBeWFNa2hSZkCP9iiuvf3b9LakXZDoi
         0KO4yXaqlwq9Z2y0W259OiHpQzQjv/Aey+cF91rM0YP8fd+16c+sMHrw4tm8pbiRl02i
         4NqcWyJKzkiUcMOB5EshrDrKmeRbPmS8WVgdyYFoGaCcgjaDbT0GcH282uO76cW7RJ2b
         RuodQNpf475JVr0Bc+JMx3BKYRsVVq/jvOBe3uzVz9bhbpBl/UsgUAzT7q/lnGyaOWne
         Wg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943835; x=1742548635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+J6vQaZBbwxU2nxEpFw0lhiNGl2qx6LemoqnB3y8K00=;
        b=bgqj/MsbgYhpjrcqyWtVEU3e3RLIh5iIsDfSx/tGMGLbA0PCB4liJGZt7E1BPB9a+m
         NWv/fKrtNuMcwpifIlwLNYETNPQQrtQCJ4Rl7Yh16caAGTINAW/WKVkzhVho+Fe1mUQE
         jNwBq+6wXc0zvdotMF2ph7eyCv8BwIAZ2tOGCA8BjaIgM3fL+eR/AnsOCjwUDSY7anP6
         p7Dry3YzF3cosd4GMvEa8jRvbOja0CmxjXMr/t02aRdAl01U1a7BeZSov7Pvuc3ognPR
         dFSWIHtc6yW7TogMjHdkVe/NVB0TbCTnrLCC0kXoo3zVF1NEnb1cuKO3BaSYJ6Hp3Vha
         /n8A==
X-Forwarded-Encrypted: i=1; AJvYcCUL/uSo1IEy5XRV8RkB1lHDcrspHXV8e5TGt5ouiHTLEoNY/ZUzULuisYT2KDbYWBpu5zEqMt9DnL6pLe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9vR+BtSqUk8iH3Y0QEe9VN4H7ILwU8i6sqVBa4pOGRZtcpIl
	Cv+pCgiXJUb1+dl2RPtmvAFUQN9YFh2czhSSBprqtspUvk/pgcrZ93ZHi1DWqPM=
X-Gm-Gg: ASbGnct7n2ZbOxzBLjDJJyoO1zPDLftOManyW5kV0dZvFQZ+0yY+qMgVhBvOgWGsAtj
	B5W/AKhXb/jvaA6+kn/8nWZv8PtJYLWcbns7lBngnBcRx2CDl6j1aA/QGUypcrSZXXsF+7N6bS0
	aSzkqaimQt5C162FXvkgE3Dms0zuD79iaH4t4aidJj3UaCSZZvY8jI6yLzpfvCbgW6nzgdgC3oo
	sQRlBlIE5Ok7yBXimqQuV+aMSJ5pnvzusZt57xZRUuQTg7zmtvW5U6MOZVIM5LhqRa2RSDWnDBy
	pu7zOU9lqeO40zEZW0OzMc6wiF8zh/VWZRTl3m5xvldFDs2+x/To3Qlc5F1zTEDH+lYpOelFnbI
	QA8dOIhF/PPKQOcNNSoV7mMpm5HaL
X-Google-Smtp-Source: AGHT+IHA0oJOcUBn44thFYE0L1uY9VB1TNdmNk6qoOLSG1uwio2hXz/e3OOHtr0r7fhxSI46wULg2w==
X-Received: by 2002:a17:907:97d3:b0:ac2:b87f:2856 with SMTP id a640c23a62f3a-ac3303e7060mr181892466b.55.1741943835268;
        Fri, 14 Mar 2025 02:17:15 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeadbsm195582166b.29.2025.03.14.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:17:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 14 Mar 2025 10:17:03 +0100
Subject: [PATCH 2/3] arm64: dts: qcom: sm6350: Add OPP table support to
 UFSHC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sm6350-ufs-things-v1-2-3600362cc52c@fairphone.com>
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
In-Reply-To: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

UFS host controller, when scaling gears, should choose appropriate
performance state of RPMh power domain controller along with clock
frequency. So let's add the OPP table support to specify both clock
frequency and RPMh performance states replacing the old "freq-table-hz"
property.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 42 +++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index e6df0b7dae8baf39bfa7ff3856759e8cd200f0c8..77ca8990c7a096f40aab5666da9f69465f59b71e 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1172,18 +1172,40 @@ ufs_mem_hc: ufshc@1d84000 {
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
-				<50000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 150000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<75000000 300000000>;
+
+			operating-points-v2 = <&ufs_opp_table>;
 
 			status = "disabled";
+
+			ufs_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <37500000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <75000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <150000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		ufs_mem_phy: phy@1d87000 {

-- 
2.48.1


