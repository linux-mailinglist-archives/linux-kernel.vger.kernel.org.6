Return-Path: <linux-kernel+bounces-566206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8BAA674DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8C73A5549
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9320D4FF;
	Tue, 18 Mar 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ds8mcdfA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E02080E3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304124; cv=none; b=P7UccNQw7eNgkZPQcXlgNloN2P/UehmU9fb5ZCHx12UcDtkMicBZw7MjWwgDVLCa5XLJ5IPKLGynP+x1hKAPetcaUnfVWOgwottzFbMi5/wDOyXtGtCWXMtXWdZT/UBrKM5mhAL5wWC9IQ12LtPIwGgfLAIwjQwsynBB0igrrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304124; c=relaxed/simple;
	bh=pD9nQ3S0AV8e5xPXa4OL73t2TUcVpEgZCEjRkziAolI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kXTk+DJI/q+a5dlQHKcTkHL6f8iRuxVIR5q0p7DSYNqd3J0Dm8XIPe0JMrFl0QUAZ8KcZL/eFCitViS3vPTiPEHt2Tgpik1MiiGCaatE1BOc2Kp8M/Q60JYEKDHDlU1IkWialBaGtHEZ7/mE76PJCWkewHcZndtdxlhX9RGUuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ds8mcdfA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAr3o5019834
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=foAa63J/b9MKnOgT2LeXgH
	Am8HGxgkFUQH2neAuo/u4=; b=Ds8mcdfAosnl9tQ6IHX9YmkghuV6u6DkEYYvvU
	EejzIPeBvOz+joqXb2eGUDvCXENu+9/u9aPJ9hOyoo1emIPzwc6t37REsk35WQfp
	iSiBsqC6sFv2pE9VnyXrd8trNvBzQFZKb3TYN2EgzH5ZHVRiqrTIR19NBqKUy3gP
	1bbJxg0vcdtr7AQM0/fRM7oLVbZYwPJYOTJH00I+WNG99qcmhfOa0ziqnD4out33
	0ItQnE6tNSqbmOK3AdrBGcjHIrkud3QrIdX2TSeRqkwNhpl5CaaTt/BeTepzQ5y0
	H/J1VeGSgVZy4eNrrSM0Z3Ofk+9v5jQgTC5kV1UKvdh1Cfng==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exxbhxf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476900d10caso134262901cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304120; x=1742908920;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foAa63J/b9MKnOgT2LeXgHAm8HGxgkFUQH2neAuo/u4=;
        b=acIo/IKK01HPE8338eXnVKIQtHrZLNVm9RrIzbRe1t7S/dnhyXzZ5qFy6bIQRwm5cw
         ZqHWI+KxwuchdWS1OG/6vwpD0b7U25NUN6hBbVpfOmzyzs2YPrT/BQ1xZ7ju659HUz+A
         boOt6uJ9+b+7P3ZEGbwoESp+lbMqiuCi8v+1LtIJI5ITbVXNcGOAh+Yu2J4inPBOGgd5
         fEdLrmb4jjNJ8h6K0i1i1QEDCLp/cONkstP0jVTvQCqVlMA0vRctP8duvANxOR4P5KAr
         yBERADut0nIOtu4uUT9RGgmlaEPyOX0BgZfMtPvV3TJoAO0U+hMx4Hcq3wIByr6Xw9Xr
         VCGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Y62RGEF3kRCZPS325UFMZMoRSPlNuyUnAROBZ5tgrDGsLOL9uNlgrSWtZwGmv3GQNWUzomv6zaGoZ7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwu7OD32QRxZhvriiPHyekc86/8jtEa7F5bjimFR3Vp5UPGgPe
	Bj00c1UlEDZ1ybpPGdW4BTqkhsNKTZ8OwukFPNQZf53PZeNcKIMyveuSUdC1SVsTApekpRkXjmK
	M8e1wkj08V9cQiqw67Xzh2RgtdlMRerrbrXamOUEokZGXfGDyrh/ULIRlrLujZbk=
X-Gm-Gg: ASbGnctp9HiS40XNXx6FOYTrN1ch8KXisvK8/AlrBdCivXR3fMt1067szWztUx/MuqO
	h114huBy1D4Ag9baceKxvj3IowiFof9kB/uooE5KtFDtLfXl2si3BeTRbJ1gzDWfFEbN0TZDJSi
	0XKknvrY+bSXm8FZ6tJu1RQ3sDv0L8L/cI7Ko1SifS5gHjaC58W7YyLi0VB2dcH9MFQ8SJGMtT2
	Et5QaOvml4U83fRFrqhOEpmnYln6gsKoZPL7dIVP9wm6JzlRKBRyOZy9meKzMPoipI2ATa8T+dj
	dlBa5K20liqIaB/y3jbxPWw+Egpl+SzIdTojoJPwbbjB4SVyTzIOz9BR/E//pT8U66iUZ2q1Lvi
	htPRlnz9be8lHXQIvasCf71dQ8VRK
X-Received: by 2002:ac8:5acd:0:b0:476:9d42:72b1 with SMTP id d75a77b69052e-476c802ba00mr258510691cf.0.1742304119949;
        Tue, 18 Mar 2025 06:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5xRrN4P7GgdcdFfWSEdn3/eaA62cu+TyWInw5rMY5tiGZiIeh/hVicVGEIvD/iZOks9Vx1w==
X-Received: by 2002:ac8:5acd:0:b0:476:9d42:72b1 with SMTP id d75a77b69052e-476c802ba00mr258510231cf.0.1742304119537;
        Tue, 18 Mar 2025 06:21:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a79c4sm1664831e87.226.2025.03.18.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:21:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 00/10] ARM: qcom: fix APQ8064 schema warnings
Date: Tue, 18 Mar 2025 15:21:53 +0200
Message-Id: <20250318-fix-nexus-4-v2-0-bcedd1406790@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHFz2WcC/22MwQ6CMBBEf4Xs2SWlWBFP/ofhUNtFmgjFrjQY0
 n+3cvYyyZvJvA2YgiOGS7FBoOjY+SmDPBRgBj09CJ3NDFJIJeqqwd6tONG6MB7RWtFTfTe6PTe
 QH3OgPO+2W5d5cPz24bPLY/Vr/3tihQJPShklSWrbNlfPXL4W/TR+HMsc0KWUvnH9RuKtAAAA
X-Change-ID: 20250317-fix-nexus-4-dd0fe3bca987
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
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pD9nQ3S0AV8e5xPXa4OL73t2TUcVpEgZCEjRkziAolI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2XN0ZHkxukViI6yox2GwpD5iZDFL5r9YvlOsq
 YZ4QZ48aRqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9lzdAAKCRCLPIo+Aiko
 1RaECACc9n4EphtEZlVZI9PNl14eZvqvZzZclORPyLSrXQ7u2JHYSsj/xS5jAW7JTredLb7ufMS
 7q/yKgGwuICclKXffMIQ6eGkFeNNFyM5mcn+MYgX3Jas3MlqpeUPiBFhvn4aL/f+MTbxzPzYf7p
 s1MTedwj/CBTkeU2EkGukV6ltA6mWavhuQDimy7ceSnCw37UjXisYIFyfuwM4T/WuVYqP4y2cmW
 1PtUqR177WL0dwVv1J6FRjzu7fro16VCkoqFViceyOnyPvNou+vNR+9fIwfaNpSdJouy4I9b4+u
 GfRIJ8XUl6lZWtV2IG7rqyPMeEFogaPB8aNfZlasWx7z44W9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=QN1oRhLL c=1 sm=1 tr=0 ts=67d97379 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1L3cfQoGvoLiuUpdNDMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: XW0xS5qtQkdLIreYzFs9vVD2IsIaA50W
X-Proofpoint-GUID: XW0xS5qtQkdLIreYzFs9vVD2IsIaA50W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=979
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180099

Rob's bot has reported [1] several warnings for Nexus 4 submisson,
however none of those warnings are specific to that device. Fix all
those warnings for all APQ8064 platforms by extending existing schemas,
adding missing schemas and making APQ8064 DT follow all the schema
files.

[1]: https://lore.kernel.org/linux-arm-msm/174221818190.3957236.3364090534153729086.robh@kernel.org/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Corrected Fixes tag for the clock-controller patch to point to the
  commit which introduced qcom,rpmcc schema for APQ8064 (Krzysztof)
- Switched to syscon.yaml (Krzysztof)
- Reordered ports in the static replicator node (Konrad)
- Fixed hwmutex node address (Konrad)
- Fixed clocks in arm,coresight-static-replicator.yaml (Rob)
- Documented clocks /clock-names in qcom,rpm node (Rob)
- Link to v1: https://lore.kernel.org/r/20250317-fix-nexus-4-v1-0-655c52e2ad97@oss.qualcomm.com

---
Dmitry Baryshkov (10):
      dt-bindings: soc: qcom,rpm: add missing clock-controller node
      dt-bindings: soc: qcom: qcom,rpm: add missing clock/-names properties
      dt-bindings: arm: arm,coresight-static-replicator: add optional clocks
      dt-bindings: mfd: syscon: add qcom,apq8064-sps-sic
      dt-bindings: mfd: syscon: add qcom,apq8064-mmss-sfpb
      ARM: dts: qcom: apq8064: add missing clocks to the timer node
      ARM: dts: qcom: apq8064 merge hw splinlock into corresponding syscon device
      ARM: dts: qcom: apq8064: use new compatible for SFPB device
      ARM: dts: qcom: apq8064: use new compatible for SPS SIC device
      ARM: dts: qcom: apq8064: move replicator out of soc node

 .../arm/arm,coresight-static-replicator.yaml       | 13 ++++
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  4 +
 .../devicetree/bindings/soc/qcom/qcom,rpm.yaml     | 15 ++++
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           | 88 +++++++++++-----------
 4 files changed, 75 insertions(+), 45 deletions(-)
---
base-commit: 9f789dc174dc1a40754507a962a4e9e7c593e2d8
change-id: 20250317-fix-nexus-4-dd0fe3bca987

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


