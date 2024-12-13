Return-Path: <linux-kernel+bounces-445055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF799F1077
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DF516B433
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2781E22EF;
	Fri, 13 Dec 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HLh6j38D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF31E04BF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102591; cv=none; b=kZ9yD9l8szKA2g6mUuNog3le/w5f/YL3+7s9LSdxmCPNEbAUhNjhQg4lQZjVN8YvsH1xvzMivDZEaeqFm3Fsp38FuEWdwIjn/HwvHHrcHW3iFKJQwMXgvoH0bD+fzWWkwQNuBHqN6vIdDwL/JcQtOgATjCMaCWn0BiG+odpq07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102591; c=relaxed/simple;
	bh=mpFykbivlJtZ1anyQnIkiiJi7mV0Gsy5/+S8fgqj8kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDCHCbrSuQ37kj8IplifCyaEI35sCwKtZZ1vSM7EBLTnNSiQ2/zJRZK4ccbZOAxVJewygt/6NVChrA529aji5m/13VtPRwrOTQLrqD7OEBYbHH64LVUv5izT3FC3OGFDqVFahvloVn2MXTIv/j+YNLCTdw5+pB7mOLd+lToS178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HLh6j38D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD7VQ6U032414
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RUGCbElRfwnoPpxFnu1ETCSpv33WWX1zIEDuWigaaa8=; b=HLh6j38DcQ4ou29Z
	zg6t44nmuDnYNQxPMmaXJBMdzexH+BRyUCloz5+QbUZtcZzjva0PtLWusTMzBBQN
	eMN+rPhRJ8xcH7OhDpMmb7zgQARiGCG4LD+ZnKxer8L27lwrfFFpFqjJaZ9y8iR8
	Kt3IVUxKXrVmqLNvaQTxddrLCdz7n0CS/+4bjbd+3ui/lRYjYvEyTT66ozpNDc8m
	ZrCzSMT1+Ew/vCBPkkCUlV3h38gdNDaxrVRAnTHyfpTCdH/8JqR1IpXy1EeS/g6L
	pJEliXfJMHBl80edHXPefAxe5h6jYn6WlYnpmRtqwfhEGxs4zWXguN3rkDiwQNBu
	jc1fgw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tffyh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:09:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8e7016630so4466986d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102588; x=1734707388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUGCbElRfwnoPpxFnu1ETCSpv33WWX1zIEDuWigaaa8=;
        b=GnOaxs48kekajJScLMRFZ3bbF8pWlexi3qQSC6AhJkGupp2pVNpNkkNPDlvTXllrcd
         RHyn8UzxSyObOajarZUl3HPCti6vkw3J0TQCEZfx7tZk0UJu4MxMoKbsGVQKO1Jn+hEG
         SVxPdM7JN4lYGmXPxQnRvFuNkuAuI5DQa8ofCyjW7bCgqc8sZOajQyrmQMhUr38TnMWq
         lTpOvH12jKImCdH5DNZvwh2a8S/WDB8K8/B0BfbbotG6k5ha/fhhR2OafzgfkHxhVKlI
         nat6F6BDdcodfdp4crO5M9XUFrXC+ofX1TfbvfDuSLLbml3crufHnSiH4Yvh4T0fznVE
         17Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUFufqxtABozoT5Rox3b+bxOoU8F6ULzZRJtYZULmEE7VumfZ7XVd3X/W41CcJx8SHZPmCBd8iWRtmYZ80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVx9CSQADdqvIn38cZQF7G/CemdKU3gf2XXQgwnweHtV7W2Vns
	Wbjz6fLJyPlGoluouTeksx9ErKJh6WWzPkzKghve1W8VNTTkaLiwaTywSfvh3rowVHvcJgKSSbv
	XFHCjo5jUAt2w8Ne2tdRC/YOWOYBp6dZxrw64xFpx8VtNGGEsXiQxhL+4GH/pZRs=
X-Gm-Gg: ASbGncsHxWaMyxDJkRIe1Og5gGabnid2l7CHV6a1mmaDIAPYM5i5rO/AZjJUQjqKUhN
	XZHnbGl8iA/qK23bGptnulOFvb2qiTXRc5xM9AwCiWHN+XMAnxMpMIEc3eP1kimGsJLjCZnb7Lx
	yclu5OV9Xn4z99i9sciXMpK2Rr33J2QAlUdoE7PX7nXB3Xg8pB2spKRy4DTZYeMzBqNxjdWN1NQ
	j1C7K0Jj72/TgI9H5nzULfDgHWELNSfs6Fshi/7h7P3rmpjxL7E1EQs0ufZcMPmUIxFTb14jSIv
	tCD2MLcTh64V6jPr+jks+u8veefL5b1YfTo6
X-Received: by 2002:a05:620a:2993:b0:7b6:c3ad:6cc4 with SMTP id af79cd13be357-7b6fbed9855mr159798185a.5.1734102587797;
        Fri, 13 Dec 2024 07:09:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCNOTuH/JeSKj+950krsW+duBDTSos0kfQOVpuA6pb//nTscPC9RvF8gzspY+TD5ARI2Du8w==
X-Received: by 2002:a05:620a:2993:b0:7b6:c3ad:6cc4 with SMTP id af79cd13be357-7b6fbed9855mr159795485a.5.1734102587439;
        Fri, 13 Dec 2024 07:09:47 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68770c481sm708781266b.110.2024.12.13.07.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:09:46 -0800 (PST)
Message-ID: <a41eb4ab-2045-49b3-b571-b49eb5a05057@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 16:09:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/4] arm64: dts: qcom: qcs615: Add gpu and gmu
 nodes
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20241213-qcs615-gpu-dt-v2-0-47f3b312b178@quicinc.com>
 <20241213-qcs615-gpu-dt-v2-3-47f3b312b178@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213-qcs615-gpu-dt-v2-3-47f3b312b178@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jBL111xt5grw5sij8crmr6YNj7sKK5Ig
X-Proofpoint-ORIG-GUID: jBL111xt5grw5sij8crmr6YNj7sKK5Ig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=666 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130107

On 13.12.2024 12:31 PM, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Add gpu and gmu nodes for qcs615 chipset.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

