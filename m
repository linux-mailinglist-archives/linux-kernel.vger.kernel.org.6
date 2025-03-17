Return-Path: <linux-kernel+bounces-564822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0F7A65B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D861E17DFEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D01D1C84C5;
	Mon, 17 Mar 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZgMYlpOR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954B1C6FE6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233519; cv=none; b=uf3XK92ufI60TqOt/KKCOquHVT6exqT7MyWR3/7PrkOs2CumeDkKuw898QgJoDn63mpoz0iZcg6wfs37LycpOhxRWShUL/6t6Mj5mSOSA8JY7PR1i/I83WH1lW0FjjfMaUdoSyRkbKm8ciIvHXTFHMaAwVfnUKFBOkhdd5cQd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233519; c=relaxed/simple;
	bh=cXGjXqVy8K2SBVw5sm4rAWVu9NhYJGWmhFXtjX3HVog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZG3cay+RkoDFk+YcIefMFCFaJTiDDtI/8sJqU1xLdAAonBoxCvHuazxWQ+znLHi4qFa7NmoMx0JKD/5tdwxCC08LGjpOSuBrEO43kW75bH4toUWxOeshJ5RrTWIi2h65bSVOO1JexZPhdTz6cij/HN9kQCXu3PDspjlX9k89K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZgMYlpOR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9uCm1017034
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BIfQsL2iT8Vojwl752N46gCkIs1NOpwnmBShRu8QyCE=; b=ZgMYlpOR55GnVOj7
	fBBw1lk7w+B7mvp39telgV+7q2pQ2PgqVjVzXtvUHuFv2X+p/o4RZTEAKRXocECB
	ouNQo9rS21GzhPkEMNKwjVqfOfkap4OXbFtlcbHuuGwXpbff0bL8RoGIqYUWYffl
	VesEkk3UAmA6qS1hkg7D/KP3uLro1YHlVnRcBzjTUlGr36Od4/oyTrqPUTo7ybeu
	5C8BjLXr4FAE6MEDreSJFznvHEvyZXbf2qPt3sNM01kf23hTZUJAuYhGeQyoilbq
	nptJ7e7gd05Gwk1U9dCvMPpc2+4MVfShexwxSygP58byvgNeiVs6oybcssCU50jA
	PnxU3Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1r15jph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8ec18a29aso60775386d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233514; x=1742838314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIfQsL2iT8Vojwl752N46gCkIs1NOpwnmBShRu8QyCE=;
        b=tSw5MHgShUKaCuSNauGGzby4GnGXUeXnQ+CXqDkI4e4JpkUQM7dp6auoN4wcca5Oot
         fzyXkUXqBSS5vSPif3tMXWZHnMjEHMyJOhzNheW7sOpygF1oivyUw+Q31V9lu4LoViXO
         KQkZGAaX3beu/TT/LJihP8pal3h5PvOZr4gnGxWgRuwynybyqo7PgxOrz976p6jogP+D
         gDBdVVBQt5LBRQGAhYkpJvHq0RCg4JkF0p8gqSILMnvKwofHc6+UAKCjzenjuxa/cCKd
         Nhs9tUIG9YOXd8PhbJwO2poPeA/TiNNd8OhtCeRHLYdp+9TClKNv3ssgJ2+hL5Kim4Zk
         Td/A==
X-Forwarded-Encrypted: i=1; AJvYcCXA1C8HPbp5R94Qgek0E2mQfVUgvndsZvMEsFYw0ZT9oSsh8f2b95a+WbmJPe022gGiGPeSWX8pU2XSrgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNh5PtGxf9hudFxhMRClqhFvRwNdN05rAEuLz2b/UFIbByyqb
	l3+lmV0ykBW86bRpvMH8kNGPO1ZKCDttVYUShbEKEUvs4mrxnA0uNXB8Cro84+iyibtrI32rn1y
	GIirEbmpuuorw9h2kiKeNJgh7Z3+WmHGP09KaomXKi/Ma2D3lCN5eDBtZDD4Ze5Y=
X-Gm-Gg: ASbGncv2E1at59ffNDBbNqYWJtD8PBEWnqr/ANseTghSxKwp5fNjTmCkTfA7EGC+48Y
	W2iH9YK3eCEcFKLS3YKJ5/N76/D+cW6WH77cnQjs9fESRx4ZtcGl8RHPobYqLVlyWouZEIWwmZg
	6+3sE5LDsjdoA+89eON5qvWvUuG7FDUrE+5vjbIU/DgxGBFV9MNVoEme+q3SN+EliNDXp/ls2xe
	vnyvUBtMsdwtg8t4vzNm5YBQ8NkyccTHGti0QAi5NV4UTa58f8BoUaG9dxQ6BAbRPj24lbKEQed
	2xkiVBtJIBz1dmizy7ApBrRF4am9/DLszT7QTFihXEHd2fXxtfiyf4pNoTTvYV5ojJcnbQdr3CL
	IEsWiSD4LOVcI7Qr3yqy4su2cBFWA
X-Received: by 2002:a05:6214:20ee:b0:6e8:f5db:d78d with SMTP id 6a1803df08f44-6eaeaa5a6b7mr224159206d6.23.1742233513498;
        Mon, 17 Mar 2025 10:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYgxdPJBjLMewB5Os7FteoqkvzgM2ai7zlUrwns9EoES+m5mpM+FpX3PxuwQRQFq5RiVor7g==
X-Received: by 2002:a05:6214:20ee:b0:6e8:f5db:d78d with SMTP id 6a1803df08f44-6eaeaa5a6b7mr224158606d6.23.1742233513034;
        Mon, 17 Mar 2025 10:45:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e9985sm16687121fa.29.2025.03.17.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:45:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 19:44:44 +0200
Subject: [PATCH 9/9] ARM: dts: qcom: apq8064: move replicator out of soc
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-fix-nexus-4-v1-9-655c52e2ad97@oss.qualcomm.com>
References: <20250317-fix-nexus-4-v1-0-655c52e2ad97@oss.qualcomm.com>
In-Reply-To: <20250317-fix-nexus-4-v1-0-655c52e2ad97@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>, Kumar Gala <galak@codeaurora.org>,
        Andy Gross <agross@codeaurora.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, Georgi Djakov <djakov@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cXGjXqVy8K2SBVw5sm4rAWVu9NhYJGWmhFXtjX3HVog=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2F+Hk+AmZlISZmVl7Lpy8dz0TRbk8xjIClt1/
 8vj+7Cr/ZSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9hfhwAKCRCLPIo+Aiko
 1QEOB/9oIWXP9+8fWr3P541oQaJjWj4TBJmLvCUTleczJ/+JGOLGxqemoc3v7V0oXDhOpswBqDi
 WEt/pceqTFyCcwIhooUPzKq4CCjbj2bA710wPPkkSzjyZkxMltoHOB+Z1SDWBd9Tk0hjZX4WZC0
 YYPrAUbnKPrcDFPEKpM2Z8Xlxh4xLbwPKvRBzcrWeqCzqgszf/LSY6/OBCWBYJo++JPbPUSDDTj
 wJMCFMNLkg+MWXK0ssjlsEKwEcJ6rlAb6REz/gRwhXTv/XWHUS3F/NwyAykfJ6BPtCR6Lq42bvK
 BndmfW5J9cf4mJoWj1QPk8q9wYriamZbAm+lwV6u1T3zYgbR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=LuaSymdc c=1 sm=1 tr=0 ts=67d85faa cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VZa1NNXYgzzwgHkDN88A:9 a=QEXdDO2ut3YA:10 a=usmIGj8zAoogrc2OpcRK:22
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: jxkIIJ4ItD5usBcyUkw0U3ZZczz2vqcR
X-Proofpoint-ORIG-GUID: jxkIIJ4ItD5usBcyUkw0U3ZZczz2vqcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=853
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170128

The CoreSight replicator device isn't a part of the system MMIO bus, as
such it should not be a part of the soc node. Follow the example of
other platforms and move it out of the soc bus to the top-level.

Fixes: 7a5c275fd821 ("ARM: dts: qcom: Add apq8064 CoreSight components")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 66 ++++++++++++++++----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index a106f9f984fcb51dea1fff1515e6f290b36ccf99..acd94f3ba0350c5dcdd8f80885ee643d8cbddac7 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -278,6 +278,39 @@ scm {
 		};
 	};
 
+	replicator {
+		compatible = "arm,coresight-static-replicator";
+
+		clocks = <&rpmcc RPM_QDSS_CLK>;
+		clock-names = "apb_pclk";
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
+			port@1 {
+				reg = <1>;
+				replicator_out1: endpoint {
+					remote-endpoint = <&tpiu_in>;
+				};
+			};
+		};
+
+		in-ports {
+			port {
+				replicator_in: endpoint {
+					remote-endpoint = <&funnel_out>;
+				};
+			};
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -1529,39 +1562,6 @@ tpiu_in: endpoint {
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


