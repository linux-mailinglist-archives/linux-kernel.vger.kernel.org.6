Return-Path: <linux-kernel+bounces-564818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08A4A65B53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D29E17D2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ECA1E8332;
	Mon, 17 Mar 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dyrhuZS5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1D61E1DF2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233506; cv=none; b=eDYu7qjS8ORO/xNC7eWUSUGj8ulvQvCfvVXX+16vG+wCRI8Kmknbgz6FHIUlT6fuGn5osXoCDPXz5p4IES4Ixo1NA6r5Cy4S9VNVBfnO/0YKyXlTUzNzWzwCGRGObawazKyuTOVBKvAuIiMpeorhqWdpGyFl40Xii9jF36Ayi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233506; c=relaxed/simple;
	bh=txiRpz+F35oG+X3p1ZZlBKKL0xEtuncaqk683Q7tOLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GX3vdaM4BuMwU/PyJ3W8gWbY7TlV8U9r7z3xdlI3uKqrA00F58/4yoJXFVt8Cme3PrmEnwmnYAqNeGbnhHZLPJobtYb0a+YE9XzRz9NP8Ug55eolnvYOwOAJeNJWjon0YmASB9/t6KGB/fX8FjWptcGziU5dlpjVnZgQRu8bTms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dyrhuZS5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9tY2c002508
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5RUXefn1qNNUFYpYyqAwzEaojm3EYakk9J0kKXfCQO4=; b=dyrhuZS5BJE9o4sV
	07Ky9QlmwDtTJXbKA5chvgKzd+XzN7LdgB+hx2lf42tfKyZq4XAUofkh2ZZoKaua
	+BZc25fNzPT0upHcHpW/uiW6Dl48ielUZoSWQ7xHVMLINtIiCNEpuV/UEbUJDFBd
	Omq6Xl3ZiqbTItRk+Gr7Aiqo6rducoaZSjIop/AW+aiPZBv1PxAFu2FD0qZjlnuy
	i1zqucgS2pda6+tUiukHz7fub4MIQYYY5i+N6MNSbd9W71Gi/B/IeQBRg2GLsGSl
	/A8J3HeBrPSlqIM5BbGX3fuhUEq2f+QkWYBjJwPyCdQDOGjqrBEetbuhJgP9xowK
	1yvs6w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2ahdgjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e913e1cf4aso137311116d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233497; x=1742838297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RUXefn1qNNUFYpYyqAwzEaojm3EYakk9J0kKXfCQO4=;
        b=HWbGPPQ7J/ZKxvA0iYrJ+giEbbH1Vw5Z+M5JU0/S5+6ntvYNVQzPZBIgPRupXgMNZl
         s8kutpnTDoYeRhYXnouLoJj9Qz0JplRmv+X+mej7DtTIP8xZn+ODQp9dYCB07bHaG68n
         fLgAL2IVBH38TDsq5ajfpsMMwi35nPKJWWTs/uezyovhnd1hKCxYUFCIRKRHyPyfODZH
         F7xEMbbl26+q2Jo2+4cOL1CZdc7YtTKUFf6kpDeiz15BcYBdDMZtrjBEV2jkRjnMj7Vr
         yKGtupGuoX0PFiK/boRjM7jqCyA9u7xQbGKlsx6mY0H68ixwGBKe5lqdEEPVxR+c36HR
         OBYA==
X-Forwarded-Encrypted: i=1; AJvYcCXQRkL4hNV7hPGa9ZdcZJ2Szizb8WdDQB5oCJL6lQXjCRNRzuArPVGvzRWOol2GisHb4eJf+djue3LskSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19NrDOWbDDBUeXPl0dzGW4pdZpjAPtDzctOq/6pCjOa+CaFIW
	g8CCnW/O4LV/zO9kkbEjU/SUdkbH5hw/472uf3lLS8QlkJOBs+5ALW/tKVPSts+yOA/J1gECA/z
	APIzwAHBlpG7ekQ281tv8TESTexNVO8V4Cv/aUGZfYOYhWknLhpIaeUiHK6g62Ks=
X-Gm-Gg: ASbGnctAD8cU0bveCosk92esOIykfewdHOY1k0WVs5Q93aWNfVgryTzOkpjZcMwDpzk
	2PxWXztUcwn/dyxvGaBHI6p8YSFscnyvcGBqM6zB1b055N84nercOYMy+366ahJUoHXbGiuxG9j
	WuO6tpTHvpxXcZWn6Uts5d9gUdDmUfbG9uVz+/KN6Ou+nZ3jHRJ20XBcC5XnyciuNN8odwJVBTr
	aYxEvgGU21r9TVgcfhZvly6wvwC5hs9RpM9FDsja50UU7nmfsyQxUHQAcqDK1Vq7vISqdB04wH9
	aHNS3bfrQiAayK/r+r+ORUGEi4xWvu7VmnhQ0wBsEPHGq0nVHRy/YnyRPH4EQ4ndiS38BJQ9mOP
	HJdHHygpdgaHhgQFhRSZ/npsN3yRV
X-Received: by 2002:a05:6214:ca9:b0:6e8:f3ec:5406 with SMTP id 6a1803df08f44-6eaeaa1d006mr201930216d6.19.1742233496935;
        Mon, 17 Mar 2025 10:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3cSX1c6SJ9kLCUiPChpT3soohcu4UzGIqx2wB+7KFeneHQMOwxrAqObCKaKdSyWhaKcyCug==
X-Received: by 2002:a05:6214:ca9:b0:6e8:f3ec:5406 with SMTP id 6a1803df08f44-6eaeaa1d006mr201929896d6.19.1742233496615;
        Mon, 17 Mar 2025 10:44:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e9985sm16687121fa.29.2025.03.17.10.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:44:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 19:44:39 +0200
Subject: [PATCH 4/9] dt-bindings: arm: qcom,coresight-static-replicator:
 add optional clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-fix-nexus-4-v1-4-655c52e2ad97@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=txiRpz+F35oG+X3p1ZZlBKKL0xEtuncaqk683Q7tOLE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2F+Gi3a2yLvvEDKt7jd0IO+ZfP38GqqgQok1B
 tT9MqSCwTWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9hfhgAKCRCLPIo+Aiko
 1bv9B/4/pumYqZ/XAfocif+U1tbBb3jivCcFFyihCjH2rt+nL0YHk0nuFKb0ECkOKK5WxkkBdnx
 RFT4KI2aTmHnVBMEUs6JSijZgYpAHmi2DmGxOc6t8Pym61paG6IkuHPBWtjRYJLmUK7bcAuZXED
 CC0gCwzR+bB+indzwn7Ze0CU87k7xnym3FfdNsSIviNE6j1kBW3Ez1395Lx9G4l2aLfP3b/OzPX
 jGbkMW0bRFPewsZigG6l4WU58XfNyL5SGq7OCK+UPsKfc7HkBAAka8Xkj/D8f4hpqPK3Qzar3uG
 hCGLHiWRd1Qq/We7axyNNHEzmg4LI9tInYk/7Ykiaq74W9zM
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: vSdsaRxqeeXwuqwVycNT6o8kWta0WB5s
X-Proofpoint-GUID: vSdsaRxqeeXwuqwVycNT6o8kWta0WB5s
X-Authority-Analysis: v=2.4 cv=R7kDGcRX c=1 sm=1 tr=0 ts=67d85f9a cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=9GbQm46mxl9eb08TZg8A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170128

As most other CoreSight devices the replicator can use either of the
optional clocks (or both). Document those optional clocks in the schema.

Fixes: 3c15fddf3121 ("dt-bindings: arm: Convert CoreSight bindings to DT schema")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/arm/arm,coresight-static-replicator.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
index a6f793ea03b6c193fc0ff72a45e0249a63a2ba3c..56e64067ed3d63c5e293a0840858f13428bacb45 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
@@ -30,6 +30,16 @@ properties:
   power-domains:
     maxItems: 1
 
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    enum:
+      - apb_pclk
+      - atclk
+
   in-ports:
     $ref: /schemas/graph.yaml#/properties/ports
     additionalProperties: false

-- 
2.39.5


