Return-Path: <linux-kernel+bounces-351635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18041991411
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02DD285181
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B1F1BF58;
	Sat,  5 Oct 2024 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbyfcNqJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A239FCE
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099053; cv=none; b=Y+4PkuUxhqhj9YEopY6sW56rkJhSwlWOwxUPZA7/EuiEubnUI1DO3Gaj3DzzvuI5Woyd5ML1RQuM5HrSJRy/Qy2fgou8jXFBAC9/CB22dftgEq4ER2pKtdVZhC/sFm1Om0NNTCoC4tmamN6VCNDongowkmAQn1FITN2xS5FB/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099053; c=relaxed/simple;
	bh=624PC2/YeCklCrsaKJF9R/XP1a89jSgHzqMS6/HcZZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gw32TXcRptPAD4TY6wHheDd5sAIm6zh4uR2mZJvvBJhTWEctNryLLqpPXwuAbe2Zo5VYs1Ut3JVSDM57Ox+6DQsXXDfrJUt9S8Aq/qQS73zuYCMDF+JPNo8NwRmSMIc5MQ3p6pM31yWgD5iwWZTQBVvyhbiNZZ9hAg/SwgdM3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BbyfcNqJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4952XwGP005020
	for <linux-kernel@vger.kernel.org>; Sat, 5 Oct 2024 03:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5ZXdZKdzX5aehFUDSvHNgos0NAGqQLuaUaeziW9PV+s=; b=BbyfcNqJkUEoO1d5
	EJANwbt6E2q0hRuSJ1rsUHYmoMZTq7sj+mAKfnEdViI/dYaNINIcspBzooqBHtQ+
	2jG3O8tnDXHSad5Dq2KVdEmHm6qJLCy4zhy7fUdWNPNHoTklWG5ukE/8XzqIzYqv
	i3c3uaiRuCyrw5kM7E7BbJLCe+K09tI7MdNDs6TalwLxChPC5j66bBRkpVVGAn6y
	Y8tHY5lS6F/E++P6ZOJwTi2IwXtklLqPn+YWNneZS/R9p/5WNsoxFgE3W97AowHZ
	TVoJOM8RUv9qh732Hp9k1V+82fMENeJZO6W50+gLwAcgwLgeifvkldMmZy8qjUt/
	A20iWA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422vsgr1wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 03:30:50 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5e1c168b583so2218952eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 20:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099050; x=1728703850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZXdZKdzX5aehFUDSvHNgos0NAGqQLuaUaeziW9PV+s=;
        b=RLa80XO233igcJOU1CD8ERtC3Lu+xOE9RTdB8Stu5w/xyeFKd/3hq9DxG4b3VcAXw8
         y56Dl/sYO+gpQyOmFclpNFHSX+vQuMWHRkPI4aia422FSaTY71/7hiwqKVqCLXWRcSLr
         M1IEA2NOav9Xt7EqhH0xnkVodQr3k+z2rwN+o7YhjHNDaKRuS+MrMbkym1nz/+SV5wpJ
         DcUFnxG0/Rq4kR6CkETpesexmQszXS8CEd4v6obbIAy/+IN4uM1DPY+CxvmYc4Fvx/a3
         ynoVBxvDNuwvWvBc9pwHeUxEEAPIFB/bBd2aNYQOV855gOBVcjXs7/tmvJDDsQSDACL5
         D59A==
X-Forwarded-Encrypted: i=1; AJvYcCW32ezWGgxaMNRzmaK5N/R5N2M0w5oaB1rcmHGulic4iE9RVpjQtnhS6pve+sskC6nD3yOqRaZrDAYldLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlG6SiQEzSLwCEI4Qyu9YKSrmVwt87mX6SAlOItWu+qBVrdDBb
	+KzeA3Hr8ch8Dof1tGLQHZVMPg9IAdbQ/0FKmEScMZ9jKntBB5APlfHr2+YR9fgJkktxNYuMXFo
	HqBHvAGlUmN9+TNS8d0/D0opBEvosaqPA4nB2UCOW//0g6dIfU4R2+HNYgTkPl0o=
X-Received: by 2002:a05:6820:16a1:b0:5e7:c504:1fba with SMTP id 006d021491bc7-5e7cbe442e6mr2654089eaf.0.1728099050033;
        Fri, 04 Oct 2024 20:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3l34ZgEPznuOfmAxY0kkTqZgUxtJoZ3sVPLQ1+V18IWPi1BLM766I054ic8HnC7evrXubxw==
X-Received: by 2002:a05:6820:16a1:b0:5e7:c504:1fba with SMTP id 006d021491bc7-5e7cbe442e6mr2654083eaf.0.1728099049751;
        Fri, 04 Oct 2024 20:30:49 -0700 (PDT)
Received: from [192.168.86.60] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d72bdbb3sm366390eaf.38.2024.10.04.20.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 20:30:48 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Fri, 04 Oct 2024 20:33:42 -0700
Subject: [PATCH 1/2] arm64: dts: qcom: pmk8350: Add more SDAM slices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-rb3gen2-leds-v1-1-437cdbb4f6c0@oss.qualcomm.com>
References: <20241004-rb3gen2-leds-v1-0-437cdbb4f6c0@oss.qualcomm.com>
In-Reply-To: <20241004-rb3gen2-leds-v1-0-437cdbb4f6c0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <quic_kdybcio@quicinc.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=3RCgQBVmMuBIE6iRoybRDv1bWdDCpFM5vKKTpll1NHw=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBnALOh/NfGPPSpSJRikfYH2Qf3wjVCQIPwQLlx7
 SIWvKxwLKeJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZwCzoRUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUYGg//Xesg8Q7Rat7MD72z2fmQcJXMonj/Xnbfv8R+Ty9
 2LothoerIFqDION3ykA6IPQxRFO7ZDJwhJh5jDB1UGwpXokVNHvl2AzZrDyfH/YqteujFYaic/m
 mH2BBjevDPq+GXEWGydnBjhhOU/hITFJNbDepXMYVZ+HGM7gN81WqiK6w1CBnITTU6I7epWOfat
 4skt1q5EJkLFTejCF0znqFNfIMInnDxRb4TDvUEUSneindjpl7wLvRjSr9CMKkARKSA4GucVPtO
 YNJ+q0fwF0YXqZyyYBgF/lwNc/3NkcJAjmywSVzPPZfuX/mltZ2bwF6nWcRe9+xeDmVX2ypEu59
 VivIK85SSmHdURGSxySWJ+QFK43sDST/xRAbnjWsjME4eXV/ENJarloYVnbW6K+fsezg6NolmP2
 BP3vWaIJI2X+HEFgw9nmybXrUaxOz4LxPYmyQJBfhe//mK4STgizSeY3tXygkzQLko+DD2x74NS
 QvhAtlVCBK5O6s8TSj0Ad3ouFiDkO3cF0LQQUZL2luIV13PzNOu6Vf1+qOKbKC556Yac66dnNxy
 fBLq+5vSLL+DFPTNQVaVAfuKfbfwoQIWAsOqyUcGWUcoOtYYhQkMP7xup9pqbznHdvFlT9ZvAqI
 t5/FIbwQmzOmF68YZnffirrFjHQbkPWOzTBKh2VlhQ0o=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-GUID: 2102E2ItHNC7RSEfpWh5yWTD5MJThVnk
X-Proofpoint-ORIG-GUID: 2102E2ItHNC7RSEfpWh5yWTD5MJThVnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050024

From: Konrad Dybcio <quic_kdybcio@quicinc.com>

The downstream tree described more SDAM slices on the PMIC. Some of
them are actually required by other peripherals, whereas other are nice
to add for hardware description purposes.

Add them in.

Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index f0ed15458dd7..565752af2204 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -76,6 +76,14 @@ pmk8350_rtc: rtc@6100 {
 			status = "disabled";
 		};
 
+		pmk8350_sdam_1: nvram@7000 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7000 0x100>;
+		};
+
 		pmk8350_sdam_2: nvram@7100 {
 			compatible = "qcom,spmi-sdam";
 			reg = <0x7100>;
@@ -89,6 +97,70 @@ reboot_reason: reboot-reason@48 {
 			};
 		};
 
+		pmk8350_sdam_5: nvram@7400 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7400 0x100>;
+		};
+
+		pmk8350_sdam_13: nvram@7c00 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7c00>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7c00 0x100>;
+		};
+
+		pmk8350_sdam_14: nvram@7d00 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7d00>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7d00 0x100>;
+		};
+
+		pmk8350_sdam_21: nvram@8400 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x8400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x8400 0x100>;
+		};
+
+		pmk8350_sdam_22: nvram@8500 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x8500>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x8500 0x100>;
+		};
+
+		pmk8350_sdam_23: nvram@8600 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x8600>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x8600 0x100>;
+		};
+
+		pmk8350_sdam_41: nvram@9800 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x9800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x9800 0x100>;
+		};
+
+		pmk8350_sdam_46: nvram@9d00 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x9d00>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x9d00 0x100>;
+		};
+
 		pmk8350_gpios: gpio@b000 {
 			compatible = "qcom,pmk8350-gpio", "qcom,spmi-gpio";
 			reg = <0xb000>;

-- 
2.45.2


