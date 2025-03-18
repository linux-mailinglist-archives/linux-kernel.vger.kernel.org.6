Return-Path: <linux-kernel+bounces-566210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC9A674E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626944237F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7E820E310;
	Tue, 18 Mar 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4eceMAW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4A2080E3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304133; cv=none; b=DBPkRauZ0lwvb14q3tQdy0xJ1eHpv4DEaK908/LF2rZ0zt6qtTxXfem2Kit0EIyuVGAbYNMAFS3Q+BDWHCfqet7qeIn4A4sp7dJTXkeKFxSwoa9/S+qnnPvJoZxEDw5ds1XISJzk/f1KclSZOZ83D9iKvL2Xh6Y7jhsdi3lXYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304133; c=relaxed/simple;
	bh=IdMb/Vr8R2JezLV37Ye2IGcmsaxJ+uBDzF5RZDuLf0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WG0D+Sd4Juxcne9KuixpVgfV90EPRi2NtcpjV0oMkxVhcpwBdyynkARR7yKcM5aMiO7UC59dhdazpMI6Au243TDZSwU3FQqkyO7Mg0XM4rOuXcnUf36eX6tjornUou33oAvtFwjrNnUyV1/H6c2Pfyn7dwcJgjaQ2O9bgMKL2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4eceMAW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAWsjG010361
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SAtwsxfUy2gTpQLlYYW3ylpjqCJSP0QrrvqtqyhugxA=; b=E4eceMAWwjE3gn+4
	9k9PXcWyA1AgiR8rG/BDnM4GkpCN915uBzaOab/8/Yzw61Vr7b7LYsidOUj/N+zR
	wP9tiRXVhEaHE5ivJ/3ba5fxnNVt7BH+wTivDU7WNyPiosJwROModnqlIw9sVlWG
	TYA2Dni8QUtsGIQStl/qNsKm3leuTbDYrpGaoFOB92laJSDlU/+ADhyJ3KKehWtg
	Ay8jo1h+RUKoLbRzQxFh9Qiu5nLs5dAFHqKcSXl44Dbbz8VO8G6UJHkunZ/jF7HW
	laBSw6TthaeYhLy7KVDX4XVFhV+N7wVbNFF8MvPZw55sxZYhupIdSeqaTD0ag8F0
	tmnQ3w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exx3208g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4769273691dso119267331cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304126; x=1742908926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAtwsxfUy2gTpQLlYYW3ylpjqCJSP0QrrvqtqyhugxA=;
        b=rOk+DQx713gXKH9ymoV28dr2HCjYlT2QCs8g7l9mnnTWri+pcbUS77xBL3hR2CpbYg
         Zmq0mk3C3JnhVV5ymdRgHefRkN1XuLph8JoS8v3TR3BGs3o8K+nm8nPCjddHy/9aXnB3
         xDgP2/cIaSQl3gyyF8vGVgS7IOWtxps6su42sW7uThEbZ8uLIiZCkd/Wntb0iN/yiP8+
         6Yo89EJHVHeLLgT1R8Aag8NuzguXANj056zZhxKY6PQe4S6rUu/KQRR/LbWHuWOWjT0b
         Eh+3VrVQH/vNwDILM0UMIPD49M2lYPGgCcglyAokO4DYYj7s9XJaYPfuDjjkdSNdUQdD
         8BTA==
X-Forwarded-Encrypted: i=1; AJvYcCXijvsAazSdKo7KkjNiBgfezXr72x7TGhsVcQ//jCyzYf4n08GdD7PTIZ+KLTclFGDmvre5NAmmHZp3M4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaS5Mneo1wOqBZc3iDytcYvWAxGba/gDGem1Iy0/UpVXgmicm
	BNZgKajOfdVHVfNlme7KeJIZRAJot1i3AbCpzng45dZL3gLtTPMEnL2dAvgyi8FLfgu2xxP+sOA
	7AQNM/OWJ7S6/06a8EvEWkXsz/pdz9yPnfH+VQr8epFadXHAYlzEsIgj5ls/0Wvs=
X-Gm-Gg: ASbGncvGpCtNUnM9XsPti2UgtIMDo3B+X6zZ2Qv0UQYy6Pnvdhds82yovsj8dRh0TR6
	HrfDBfvSLlWc53xCKL2bytEl+UF4pXzcL/YLM6dljvPyz1Pkic/ikCFAJaYdzFTJg6U8jPqS+om
	Wv/dBxH6zMp3kwRUmQRQqjGZ2yUxKOBBBz7WAX2a0dkH/3oRw9iIMG5fmBEfD0OlyQIf5tC5m+c
	GY7LYfWHRFGMwB/4idgSNjZx2pDmojENFqyitss2L901408t1PrPNbK07dIgF5daV1sJKjzAnJ1
	4mh3wz6IbaR6QI57D3qwrwtqOJScJJ/j8qTufe4JdAp0pZkFj/DtNktagUKmLXkHLZczt06I53e
	jqeUPqW5Qi/TQVT3OnZwV7BC1rCZC
X-Received: by 2002:a05:622a:24f:b0:476:671e:debc with SMTP id d75a77b69052e-476c8130f35mr281110701cf.5.1742304126008;
        Tue, 18 Mar 2025 06:22:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEU9lOj1qTTE5tT64YpKYWwG2VXGSpUsxU9+d1bPT5O25rH0OuaNfzj9yTte96HdsNCPMm3g==
X-Received: by 2002:a05:622a:24f:b0:476:671e:debc with SMTP id d75a77b69052e-476c8130f35mr281110291cf.5.1742304125686;
        Tue, 18 Mar 2025 06:22:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a79c4sm1664831e87.226.2025.03.18.06.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:22:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 15:21:56 +0200
Subject: [PATCH v2 03/10] dt-bindings: arm:
 arm,coresight-static-replicator: add optional clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-fix-nexus-4-v2-3-bcedd1406790@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=IdMb/Vr8R2JezLV37Ye2IGcmsaxJ+uBDzF5RZDuLf0g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2XN17aKshhsSq364oUAKz7IWL16ZLciyW8lw6
 3PLr7UMEoGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9lzdQAKCRCLPIo+Aiko
 1WirB/48li3Xo85DmFuuSqUvYyudkl3nFOjZdyrXT8CTQUFjVXr33H0I+LrxKT/h6ahJPTmvclu
 8qLKBN6w7qlO1fD6FslYBto5adSHC98+rCFoJBqY4BDvD9zv0MKAqHV9A9m/jWPJXXI1+8gKw31
 J7XpGbRtEB7d3tZW6T7vEuGtI0vQmE4WVb3vQfzvCk1ppnb+3x0XNdt+5D4Pwf0t1ssQqkm5o90
 WgAxgLQG7IfToEYLCu9gSgNIj8xP0LSgADzSRaJpLnmvsJy0YM0hgsskNEQ2vxKNeE0ty8R1zeP
 4Aj1GNoLW928Kt5COlhNBPqJ2EKkqnW9dhhFjo6xfKi3PXaE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=b+uy4sGx c=1 sm=1 tr=0 ts=67d9737f cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=kFHV7R2MqMk9-nUzAmsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: WD3-iNPj1xoUG59ZKBmoZRm7OY845tyL
X-Proofpoint-GUID: WD3-iNPj1xoUG59ZKBmoZRm7OY845tyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180099

As most other CoreSight devices the replicator can use either of the
optional clocks. Document those optional clocks in the schema.
Additionally document the one-off case of Zynq-7000 platforms which uses
apb_pclk and two additional debug clocks.

Fixes: 3c15fddf3121 ("dt-bindings: arm: Convert CoreSight bindings to DT schema")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/arm/arm,coresight-static-replicator.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
index a6f793ea03b6c193fc0ff72a45e0249a63a2ba3c..0c1017affbad2f03892b250ad864d9a5dc8d02f1 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
@@ -30,6 +30,19 @@ properties:
   power-domains:
     maxItems: 1
 
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    oneOf:
+      - items:
+          - enum: [apb_pclk, atclk]
+      - items: # Zynq-700
+          - const: apb_pclk
+          - const: dbg_trc
+          - const: dbg_apb
+
   in-ports:
     $ref: /schemas/graph.yaml#/properties/ports
     additionalProperties: false

-- 
2.39.5


