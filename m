Return-Path: <linux-kernel+bounces-566214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CE5A674FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0D71798A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C6520D516;
	Tue, 18 Mar 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljnAu7tx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16FC20D4E2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304156; cv=none; b=uh9q2icyZboxGdXLpowpwMq4/kw0EMEfLZRGG+HtnpaH5jECMijaGZ5KdaOVSOvEWXQJCiyvqZi+KBexvV6E24rEZpDQtTyl4MfWybusRgEgZVC6gMc19xq8LOODwmg6nA3T6OPaOP5XRpvA0j5NrOHoGXaCr0429I9WbNAzfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304156; c=relaxed/simple;
	bh=YYmo07roKcW7ib7dlxEqOnCz38XSWKk8QyvkfSaIp/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lD0YmGFurA5gdoWtLHMTIOCxqE3DpiJGM9dhy0mFWve4EJGcpQqTK1BwRUfm8NLAz+I/75T3j4gZ2Gv1JDF2cnZxaqK7qjbG4sVKr/DG0Ap5OpulT4zy4cEMHhw2dk96NE3fsXuMqoUiJEvDNupuUb9eNkgkj0NEKhgIvUSoINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljnAu7tx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICeAVg029858
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rV1IlqnHQ/o0RgJA1eBMQdA9vXcN4qMsDFTtrI79Z6Y=; b=ljnAu7txJ66WqqTM
	V0qJfcvAC9VpkTlWfI8L5i02WfpMIBN8s7eBwzNHS/Kmj7nKO5XfdQCseY6+C75Q
	oICWB3uuFf/ufluwrbzF40xFhilu2pCi9X+xo/Xi+4IgnLsxBuWJUcZbWKkfoupZ
	y22q4gMCRgOztpmOgUKlN20cV6/HSFcjMCJiofKCOtoS4nHX0kNXAqN0vqu0XzpP
	/TMmmkzA5SmSUR/UacTi2qWfRZ4ATT7nD7CUnPylQ273KZweVi/j02MJui8wc3nj
	pxtK7WaQrGe6/PvOXC3MNQQZzn+VKY0jZv8pR2XCXh/+ZUWYt5mKJo7NeTcVHqgC
	ExabAw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t04dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e91b1ddb51so114537796d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304144; x=1742908944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV1IlqnHQ/o0RgJA1eBMQdA9vXcN4qMsDFTtrI79Z6Y=;
        b=XUijndPiAkUSUim27CmA8kbfLUnSQcW9ff6UlcGooHcVznCEPQeh1VZc0sYmaiiuKu
         QHTlexF0R/wFQclb+SFCf9q6o0E/s8nAmrwamoyQq2kxSiKOv6JDjewqEvgZdIUgBMaP
         xpEAhAoVvnwGBzpUAUo6lfai+pdgsV1YIpHc2Yc8NQ+Zd2+8iJ9JgsZ7qq8ivORDgcgo
         ovSjBhT2S8kUwCwvan90G4sgZVNGk1CrGcLK55zE+svQVvKDGVri9UO1lTx1EtPGWdS/
         A1hkXiBsuuPl9WznRLwy52aHgpsF2OpvTPxjIFO9cEtC26SY6NE9h2K2rlNuX62hWIie
         VyXg==
X-Forwarded-Encrypted: i=1; AJvYcCVlXi4Z9lKhJaa8qNupKfFgw8LoZYjqormZ+yQHTHYIP1G3o/S6LUmFGygchuw6Bi9Jiec0r8HHJ6ajWjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kTM5e33cMfBmpYcVfQI94mIABOaLTqLQUDKEpP0hBvvgsbWz
	olLtCcqHpjrvZI0Yw0RiE9VnFg5Eyhk41qfPJGKIBBp5SEJNYCGf8K2y9IFQtmpypBNIJya2GkU
	nJvAizk4aq2ERx+rUCiOP81IE6SFQOg6rC4B3dVtrbYP4VtEU/lKrTPtW03Nxi7I=
X-Gm-Gg: ASbGncsOoYKPM7RzJTUTF8o67M2L7EseF9xC2dWbM03lih40O1bFhkIU2kV8mdwop93
	U5S+qQrbUYjemRMu0JgHETVeJ+nygl+I9qllDwsDdFPnFElY9XypvL85cjnzPdMRA3larI06Zny
	NbEyIa1ud/FcErntx5s+DqTzRW4D2wCh3VcF5DGynxHV18DxbwAA6PzcAYB+UWiaff+YVcPfaIu
	bSCtvKEtquwhC2ESbXI8iCOX1Sw++wEyFQ3T7MOiT4vt/YhmyPpMZmMJmtdPW4TgnkPBgz5Ekv3
	do0/ICf2kVHW0J2jYk47yeB+c1GpqeAlfndefXUCDJF1yBnQXo8evbVqjEV2TLeoO0v2cbypQGm
	Bk8U3/Ytw9uLb1taejUB31+Peybj4
X-Received: by 2002:a05:6214:f28:b0:6e8:e828:820d with SMTP id 6a1803df08f44-6eb1b923b9bmr61022556d6.36.1742304143812;
        Tue, 18 Mar 2025 06:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT29uNdkPTC8hLiSVJtVNM0J6OKkSWUgcwgv9PhSfYfcfwdVm+rFQt8CN7Y3i8guabZwOiLw==
X-Received: by 2002:a05:6214:f28:b0:6e8:e828:820d with SMTP id 6a1803df08f44-6eb1b923b9bmr61022136d6.36.1742304143454;
        Tue, 18 Mar 2025 06:22:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a79c4sm1664831e87.226.2025.03.18.06.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:22:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 15:22:03 +0200
Subject: [PATCH v2 10/10] ARM: dts: qcom: apq8064: move replicator out of
 soc node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-fix-nexus-4-v2-10-bcedd1406790@oss.qualcomm.com>
References: <20250318-fix-nexus-4-v2-0-bcedd1406790@oss.qualcomm.com>
In-Reply-To: <20250318-fix-nexus-4-v2-0-bcedd1406790@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Lee Jones <lee@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=YYmo07roKcW7ib7dlxEqOnCz38XSWKk8QyvkfSaIp/I=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ/rN4rJlBtasApm/mjKF2LnuXGs4qqIg9kD3B++9H/NTh
 TI7ztl2MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAi13XY/0dW7P1w8e7+Ovf/
 ek8PxHXZybRLznNQdPzAsKfs4O6o/dJC2q1KC7j2sjc+eVTZs2Se+R6tt9nT3JIDTgQwB3cWO4g
 HngxSOO73x4xlQtnq+qmzU0RZjPZvlLm1YwtLmxfrm9nVzNrlEryTFblrP5XyV0yJ6RCbb8ZWPV
 E42dX+xT7eM8nhMfbyL7m2Gt7MKJ2t+yGCR1bR8RTrb643Xea5Zwt2bg90VRTaERjpK+3dN3NuX
 NiNL/frDnlrtJgf+uX78n4E3znpEP+lslGzFh65wSq489v8+Nbs7IBkxmsdKzIN/DYfK1yzaJ6E
 3xK99EtqpyewbE626Nhy4ppY8bX/uxc4iK+Zs2H/jFuhAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: XVRNCcBLL2d82_d9Z-fHtlDV5l3B9Lc7
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67d9739a cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=LFh-nz-jDHZ_m6HcgWkA:9 a=QEXdDO2ut3YA:10 a=B72P2sQ2WZ64KWKWCyzG:22
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: XVRNCcBLL2d82_d9Z-fHtlDV5l3B9Lc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=919 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180100

The CoreSight static replicator device isn't a part of the system MMIO
bus, as such it should not be a part of the soc node. Follow the example
of other platforms and move it out of the soc bus to the top-level (and
reoder ports to follow alphabetic order).

Fixes: 7a5c275fd821 ("ARM: dts: qcom: Add apq8064 CoreSight components")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 67 ++++++++++++++++----------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index b6533630e347c8fc5e3f0791778cd05760b3f3c8..b02e6739ccb20a287095d8c3e212040e4ac50fdd 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -278,6 +278,40 @@ scm {
 		};
 	};
 
+	replicator {
+		compatible = "arm,coresight-static-replicator";
+
+		clocks = <&rpmcc RPM_QDSS_CLK>;
+		clock-names = "apb_pclk";
+
+		in-ports {
+			port {
+				replicator_in: endpoint {
+					remote-endpoint = <&funnel_out>;
+				};
+			};
+		};
+
+		out-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				replicator_out0: endpoint {
+					remote-endpoint = <&etb_in>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				replicator_out1: endpoint {
+					remote-endpoint = <&tpiu_in>;
+				};
+			};
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -1529,39 +1563,6 @@ tpiu_in: endpoint {
 			};
 		};
 
-		replicator {
-			compatible = "arm,coresight-static-replicator";
-
-			clocks = <&rpmcc RPM_QDSS_CLK>;
-			clock-names = "apb_pclk";
-
-			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					replicator_out0: endpoint {
-						remote-endpoint = <&etb_in>;
-					};
-				};
-				port@1 {
-					reg = <1>;
-					replicator_out1: endpoint {
-						remote-endpoint = <&tpiu_in>;
-					};
-				};
-			};
-
-			in-ports {
-				port {
-					replicator_in: endpoint {
-						remote-endpoint = <&funnel_out>;
-					};
-				};
-			};
-		};
-
 		funnel@1a04000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x1a04000 0x1000>;

-- 
2.39.5


