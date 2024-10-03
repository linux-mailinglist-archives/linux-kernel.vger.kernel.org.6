Return-Path: <linux-kernel+bounces-348522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E298E893
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4D91F258F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C733282FE;
	Thu,  3 Oct 2024 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xh9BdgBq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38644200CD
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727924323; cv=none; b=SYEmvY9QEdVMzMaB/x/0EqQJcPhUX3gYv9PlCq6rPkAty5VlFTk6svgpi1aJeF3nKpf+eDViw9GT8M85L+SOZ2QYC6gpV2PgtX+o/V2fSBYro+tFDfRioS3wOKQa6Qh5RpPtiTHV9qhD2atcjZ04Dgl+9/2TXe1LBAH3Pau1YSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727924323; c=relaxed/simple;
	bh=bNYddmgsyW8zpJaljT25nbUCMx0j2dCKdXD1Dvmcx/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R3DD8BuICVk3uTPmmBCrH1zEchvVBQ6OGqIdEMkWNHboh6rU82qLduLeqJsqHNX030sJfIKcOVFvmQ3PkdSU+RqRpQCylvhnhgA6MEu+xyiKWVxYgT6vj8ih9gIBEFr0/uOsuzMpq63wlPjCGMOs9Eo5QrYh4ImOwOMRrQNQF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xh9BdgBq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4932nqcm025883
	for <linux-kernel@vger.kernel.org>; Thu, 3 Oct 2024 02:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q87Q2dHuDJxAM/tFgGrfhU
	NvO2zsd1XaxZiQ5xUbYkI=; b=Xh9BdgBqed78RooLrts88+5MfXP1B2E+kA59iY
	fTdK4Ao/Fn6AsaJ5v1uP97tglHAJkFD1tvxi+EA3OV9chymXuzTI+vsEOqKaCDjK
	HDETzGokqN5rp8lyTUP8qFyfp6JV+sI0g1PxvrreKE63zJGd4osqtV8tAbkVa50Q
	OTJZui/ekBfeO3BJV5mAKuGOKder1ycZRATijHx9QqC3CigVgPtMylvx6ocXbuLw
	lb4cLYlq8WxTbh2f78ULFELF00J/8YAb8ywcUM/Qngvl2edn/FoGqRtyj8xvojuB
	ndsIyi1N8a5ALnbyQcrC+tJf6ojouxh1N7r1XV21LuvwT3/Q==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xajfn347-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 02:58:40 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5e1c6f207edso1005829eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 19:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727924319; x=1728529119;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q87Q2dHuDJxAM/tFgGrfhUNvO2zsd1XaxZiQ5xUbYkI=;
        b=EHDKvN2ZTHr5XFdmz481T73RYBlwK7OT5JZUa3uC3ywWbh2SlQaxy+X/5tiGrbD9U4
         b/jeTJFAXGCNWTGWYGC0D5vqc12n757YZGFfgMbx6H9EIctbgFUBkJm0kwQ2DyEL98j/
         kBSzTfKxAulXHLJQJYVxOiORzQpwN4MJLFDrcCPQVYgnywmmphnKJPpVu0rpIpNHwZlo
         IWSr3spodZiWeudTQ8x7DnB4U4qRxvPm4i3OiE1NVWyS3nN7n+8M5q9Av8tFm8D6mBzn
         1sKg0gqrtM493sRxx5pwwpIfGpfe/te5XMCcn/UBwWs1Zemj6SBsHmhQCrbRdO7eaHD7
         qznA==
X-Forwarded-Encrypted: i=1; AJvYcCVcNcFk74qmSrWH2u2ys4AQKyUMMUZdoaDuOSKNkJkweVrxQt9lw7Ss2fUY+UAmYMlp0ebZgs+uA/wc36A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8n6tg8WzWmgxB0C6XuGyb7JTScavhzKJEidy5b3FpQKsiVUhY
	GYUCdNAePDwdSs9KxOxfn0YPn68THcNPL5Tl3eE3P0t1q4cjAie6dcmpkN+ud3rgobVkWaCavxZ
	OoRF5n68aBDLr3Vk/BNGvq7Nr1tIhk8pI2ewEWrEGWP5sm8SOvnF1c9mBSImvM9CozXma0NPfTi
	wy+/pGqym+oCI=
X-Received: by 2002:a05:6870:a551:b0:277:d790:6e99 with SMTP id 586e51a60fabf-287a404ebcemr915304fac.18.1727924319169;
        Wed, 02 Oct 2024 19:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg0JvlIROszA+vBjdJya8knWyGhXAkKydvC9LIezO0qqNQPEf4Qksob0bkVhdDzfAP+Z9+3g==
X-Received: by 2002:a05:6870:a551:b0:277:d790:6e99 with SMTP id 586e51a60fabf-287a404ebcemr915298fac.18.1727924318822;
        Wed, 02 Oct 2024 19:58:38 -0700 (PDT)
Received: from [192.168.86.60] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-287ab9b5ba5sm188924fac.21.2024.10.02.19.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:58:37 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: [PATCH RFT 0/2] drm/msm/adreno: Setup SMMU aparture
Date: Wed, 02 Oct 2024 20:01:31 -0700
Message-Id: <20241002-adreno-smmu-aparture-v1-0-e9a63c9ccef5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsJ/mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwMj3cSUotS8fN3i3NxS3cSCxKKS0qJU3bRU8xTTRMPkJAtjEyWg1oK
 i1LTMCrCx0UpBbiFKsbW1ACRXU2ZrAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=bNYddmgsyW8zpJaljT25nbUCMx0j2dCKdXD1Dvmcx/Y=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBm/gkch2/1mQLQC6vdzGTNgJUZUGqjflYJhWQTm
 hKmRcBFeIyJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZv4JHBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcWDMg//QeesKF52cIqBJpczFAINE9i+3Uutx4KLVAMSvm4
 fKb6Yk+MKfdjkxacJjdJvVw2ABwCXsVCZsdi/8e0kk8HuSKKzQytBdZYLXfGMyot0dKLA/uMjds
 apF2Io6qWCaVZrcy/OhMmpjSenKgw5wgtNaiiYJPJ1Nwq+0AFBka7mEHW4nrAv+X4p/1eWpGT/8
 RUu2rrdAwcKQYP8mzky5BCPr7L0nL1W8JjxbfF16dTWSfhzDNNE/+zvnZfDa2aIGmKNqvOPWV7c
 zza70jdEfgL9NBwIS/RezeNiWWtkxf+g9tcKHmQK/maoeGvN8wRshfhccvJOeqHGDQ2u8p8tTez
 z7Dnw3+rr8K0zI7dFlTmJNJqjmC9TD52VHoq3LNByuZzjOpziJ7Av2Rhx8sgwA4kZD5zXtqGtci
 IlZgdT8oz3vIvcsuAw+6trOZfoSsp7zEURhQmXn3hHmphcK6yth4PHSJFT8ohMyuyWGbYP7cEcG
 l624x48xjLA1qZ7HYfa80/kQnGPs2MDnAoVHN6hrE0v10MLk739fUiinOeQNy/cI2tSCmzjnu5f
 WPIxeqJPl6t3O/wIq6jfFMjW0WNQmEOiN8QAikMMQI8QP7RLIybFItf4DshLDCZS3K8rizTjh8C
 crfPs5/ZSyWA48j5qlO8q4HHEAjP6mzDAjclZA8xXeQM=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-GUID: Ge--wgG7GWurpFQl6rIwJvdn0NDvOGL7
X-Proofpoint-ORIG-GUID: Ge--wgG7GWurpFQl6rIwJvdn0NDvOGL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=859
 impostorscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410030018

Support for per-page tables requires the SMMU aparture to be setup, on
some targets this is done statically in firmware, on others it's
expected to be requested in runtime by the driver, through a SCM call.

Marking the series as RFT, as this has been tested on a few different
modern platforms, but only with Qualcomm presence in EL2.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
Bjorn Andersson (2):
      firmware: qcom: scm: Introduce CP_SMMU_APERTURE_ID
      drm/msm/adreno: Setup SMMU aparture for per-process page table

 drivers/firmware/qcom/qcom_scm.c        | 19 +++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h        |  1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++++
 include/linux/firmware/qcom/qcom_scm.h  |  1 +
 4 files changed, 31 insertions(+)
---
base-commit: fe21733536749bb1b31c9c84e0b8d2ab8d82ce13
change-id: 20241002-adreno-smmu-aparture-fe7d5a1cb834

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


