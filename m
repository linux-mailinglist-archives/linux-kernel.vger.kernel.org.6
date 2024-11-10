Return-Path: <linux-kernel+bounces-403316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C789C3405
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 18:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F9F1C2082D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B0140E2E;
	Sun, 10 Nov 2024 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lJFtCLRM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEF1386BF
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731259894; cv=none; b=GgFuCjYLDRSEFvY//C+Dgb8OR/+9JLHoRLveHGPhVyd44zXZYH3zPmTW3Lni9t7P3/9G3r33v+oF1OgG7uXLIJuH8FJYe9NKWWOtqijCuKiLX7113oWN+fJjRf1zgdCu3RowPMIwpqXPsfpF/+uXCZrpJz/meXQ48nA32sNkG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731259894; c=relaxed/simple;
	bh=HkkqzqYZ9I8U3OYgFmCXR7x8x0rR8hNjb441DaC0VZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VK7B1US31Dd83cdJxksY5DcZmo2cA2HQxdMRSdxLKlOJbVXfIa3OW7SR1T3UdtJINs8fZKK8gO6eAPkiVcvrYI6SMp08HlzPIEgwrqnsqwkJQpt4cpjD07+B2tvCYBlHgJffdbWRc1c5DoGHb9ZcFULBtlKvfp0G2IJQ06jqnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lJFtCLRM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AACEvC5017586
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 17:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NoqymUbSuzTfgs3YfQWe8EZeWIHhOdUDYitzaoggpdU=; b=lJFtCLRMl269Usas
	3Ak6ouXeiC6W3fjbyHgv7FZ0OcFExRF4xKmJkBJoYGdhFOuVGovsvohqYUb/7PY1
	L7nscyrjJaICDQkCbNgB3HrN2uAOaO9F6JbLoHSj4pedpFszvc1eIoCokyAyfpcu
	eJ3Vn+DbOlKDCHwCjLL5dtZMSObUVdKbKV95UaXti/XqiH8mweqOXy0wp9bSRFvh
	mszqbBs4LTwyRRhVDA/Jq7z3/y799czRipsw0pSrnxAfhXuPvL5Cm3PKy4KuWi/F
	YzyjcbvIJn+nv+ocpXd/673oVYDs5GNnnsD+xkzB2ONRyWbcHI+TanKi+b85wrRp
	fys5sg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sy2fte8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 17:31:31 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3e5f4437768so3535768b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 09:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731259890; x=1731864690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoqymUbSuzTfgs3YfQWe8EZeWIHhOdUDYitzaoggpdU=;
        b=lt3Iyb1DjC6RSwxaasb6RVtb9maLFJHWL8LUAnxCt57KULMEesJYQ1AaZ/Us8qNAOi
         ADCG4JM1VAPRZvzaNEIIwMGM8/+GBFd9/nZZ9d9DrI/YiQYFeu0LGO7tHgtXENJpVfr3
         S3zZ7BoQcPXs2CTY2ups2PEihsAzK4+7Anfb4bAlMIlJsUty2s3aH3FnsCC8sEPU+fUT
         AjkFgcPWEprw/tr2zao1Z8a7vlVz1DwZ+wZyF43enYs0yfNTx6KzBoUyOwVErn+N+e/d
         wgsffKKdkurHRT/l2Dlv+SmL9ZhppHAfOEwk3jU7GFQQLqL5KHovwfuQPX8n+PBxSN5o
         Z64Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSueBntz9WgSiQcD27B3TtEx5oTBeV0tfYCR6hKR7Vi8liW5TPyBuwP74J6MB0TUz0c+U7xjksj+SwORY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQgmCLQZGi9Vvb8JC28+pvdnrXLaWYRERyf0UZb+ycmcUNvmjk
	NqkTmtJPteXfFm4dOOmFEpNJ2gsTrHi5k0RkSQO5SZh9BNF9rW679AMjl/d30OhP6m8y4HuKg2N
	+9qJ+o11fI38busDoyKaHQJzh6RW67BpVIfBibACGQ/BP93LWoEk+VyvjZptj1r0=
X-Received: by 2002:a05:6808:2105:b0:3e7:6468:1fd5 with SMTP id 5614622812f47-3e794657653mr8350231b6e.34.1731259890668;
        Sun, 10 Nov 2024 09:31:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWyxhZzgV8jj3hMo4wiNEnob3/wxI89e+SDHXIT7eMFyTQmCzwSrCFBhaciMwwS6unG6wSjg==
X-Received: by 2002:a05:6808:2105:b0:3e7:6468:1fd5 with SMTP id 5614622812f47-3e794657653mr8350216b6e.34.1731259890376;
        Sun, 10 Nov 2024 09:31:30 -0800 (PST)
Received: from [192.168.86.60] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cb53843sm1718506b6e.0.2024.11.10.09.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 09:31:29 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Sun, 10 Nov 2024 09:33:41 -0800
Subject: [PATCH v2 2/2] drm/msm/adreno: Setup SMMU aparture for per-process
 page table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241110-adreno-smmu-aparture-v2-2-9b1fb2ee41d4@oss.qualcomm.com>
References: <20241110-adreno-smmu-aparture-v2-0-9b1fb2ee41d4@oss.qualcomm.com>
In-Reply-To: <20241110-adreno-smmu-aparture-v2-0-9b1fb2ee41d4@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=HkkqzqYZ9I8U3OYgFmCXR7x8x0rR8hNjb441DaC0VZw=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBnMO552UOCpdvNfPRiy9GOkjK7Xvxw/DaFyCNyp
 jJhQw+LOgaJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZzDueRUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUORA/+JTP943OIpYznMXjcUo9YS9qQBZF3wzGvp2JZEcJ
 ClLWvzOfnzv8dYtF726azGr8Ww82GcjAhA7KnjubhyHOGZ2hkWs2dxIs35kdf2z2MCcLJ2nekTt
 eeopFGoypHfhjACVSDFLGUzPApt1Gjpp2YTO9a0o/kYe6L33kC7d6WDcKaTxB8TIWRbhKZCHxKZ
 OoB9b1W1nnfRt7XRnWJIHtctPLqL3sJ7Z+0IS27cudn1UMoxSc5J2Oz5HgOroLDTuZC9UCryrS5
 x2T3xBRvBgpICaqHJ7QeZefLfYSoy/9OGsMYPkUoYrXvMNvtWia3/HtFM3sBq0kweUPuzB3uVLQ
 lgnxZp2rf0n9mBVx1pSykK0cLFqzMcPktXLcMHAUPEX/jh6IizZzhiODgGbV3wNUge5QUkqu5pa
 Tonj1Vfj82AEDvtGkNcCGPH8tlv6SfetBONB0lHY5sWlIjT0z3bj2G9T8CLINtWRuoyRIxWSs5l
 RfvaIi8OOUiKKF4DwW49JCdmqsIuF5ptcPNwyT2qHB19Z8pGrcbwsOzm+9gH7XUCdeKNkw7HgUZ
 KfMmODvxKAsi8LZITL6ov/T6mqdGSurJp1b8VJ3wCHiBIGU6oiq/FBpU47+clyETjoIW/+OYy/x
 etfA38hrTphrg0AIM7PPlBglWVI2EKO/NFMAqHuUamc8=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-ORIG-GUID: FWcmQPvcvJJNGSMrHxa4GI4rzCCtavxx
X-Proofpoint-GUID: FWcmQPvcvJJNGSMrHxa4GI4rzCCtavxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411100155

Support for per-process page tables requires the SMMU aparture to be
setup such that the GPU can make updates with the SMMU. On some targets
this is done statically in firmware, on others it's expected to be
requested in runtime by the driver, through a SCM call.

One place where configuration is expected to be done dynamically is the
QCS6490 rb3gen2.

The downstream driver does this unconditioanlly on any A6xx and newer,
so follow suite and make the call.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 076be0473eb5..75f5367e73ca 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -572,8 +572,19 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
 
 int adreno_hw_init(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	int ret;
+
 	VERB("%s", gpu->name);
 
+	if (adreno_gpu->info->family >= ADRENO_6XX_GEN1 &&
+	    qcom_scm_set_gpu_smmu_aperture_is_available()) {
+		/* We currently always use context bank 0, so hard code this */
+		ret = qcom_scm_set_gpu_smmu_aperture(0);
+		if (ret)
+			DRM_DEV_ERROR(gpu->dev->dev, "unable to set SMMU aperture: %d\n", ret);
+	}
+
 	for (int i = 0; i < gpu->nr_rings; i++) {
 		struct msm_ringbuffer *ring = gpu->rb[i];
 

-- 
2.45.2


