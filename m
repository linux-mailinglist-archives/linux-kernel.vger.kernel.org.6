Return-Path: <linux-kernel+bounces-558233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B5A5E324
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBA118978F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A1253355;
	Wed, 12 Mar 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TCa1usWN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B41D5165
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802081; cv=none; b=mnizBNAT+vTETXLQ7rwAcCVwFEjsi9SFA+NHYOZ6OZdNUkKZMq5WYMlucVodPOwhlijH+MdlAAO0vylJqivHDH2fCz3f/YA03HVQJjyc5K5wamtR8sIU/ZnEVQjXzf9jA6xa1++yakQyMChJZ7Wdh6pzl8ynIZBZSfirsQh4SJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802081; c=relaxed/simple;
	bh=zwqVmLodsfl+JVFY1LzQmxbMBGzfN1ym7c7asAxagbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDl12txlH8q2glVXzwjq1ZHzI5/CsHweAqYHpoknPdMFEkD1irPqMeOwjZfwDPAFndKcweKTnoxxdbWjhv5o4ZFf/xfT9bH15lAVh7ZrbZ/EIB9d7nXuOt40wxQeS10Z4HHD4sl5bRR42TkNFMZM2Y+eFiNjpElRx9wgAHALuTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TCa1usWN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CBDC7H003492
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nvZ6pQSfPtCdBsC0Pf71CwoupAzu73V8XcCgUrzkfQc=; b=TCa1usWN+bZ96Bwh
	l1mf+hEhbFWKQMq4YxZ4b11cBkPdwvGxGJ7+gdBJyFP356AEAzl3hAuveBfqvXxJ
	pOQE9sRNEK/R/hiejb4bo/dtDMO8SlJhPyWFncEhj5nduSt6gEekssj/TtxwFnKU
	KvKlB0dt5oIKsR9PztlCWrfOMfOEIjKv9DqA1ZJIzqCfWNe57RNhyFl5yV0nafZP
	fgslSc+V9srETtrrm0ocSrJ54vm0LvpcAYidtSAvj7BREPotUqJR3AcbwhCy6sJ6
	VHaaqRV+HfdrRnfep8enCVRcZChUwjxRYpF+H1A/+NNsl0M/OMBBECkHzNu8eOUj
	P5QuGw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45b96y93a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:54:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4766654b0c3so114221cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741802078; x=1742406878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvZ6pQSfPtCdBsC0Pf71CwoupAzu73V8XcCgUrzkfQc=;
        b=TlCOx2OqEjJX4FaTAuqKC9BC2OKT85AqnXhx3uNPiXrBWk6zkO4V2i3b7SM+IEWdse
         8YL0TP6E3MkuPMRobVEsM7zTVB4GNWH0adsVJTK3X/a+4mHRgZz/LOBFEDh7YYBHNKqz
         9/GEStbxC4EPYRYCCjmk+YKqzxuWOE70nlR241y37xZsoRSEHoP1uf+5W/qPVUsz4maS
         vVsAAgb8nvtKYcL20/Np1THQTNoiUXwXykdpNgmYtQ+s9rqZ4MFrvQ5KuTv4NtTILa17
         AcdMS5aBhpWhm/WHF/5FafPt5YrZky2+8OU3ZIbCu+vdAI9/TSHtBO6q/kqpH6XeComc
         8BkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFbz5IFPj7o2noiOVJLCEQ9XRM+She8UyaThp03/MDZ8ae/8CfSlZXLxWPyPQ6VJ5xC1p9bd/VIs+S7FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwispeZWtWnEucdDk3RgwTo+XI7ksMwYcFM+Ceh9EIOOb5DFMDl
	z4mJdEM+YUEtWh6S99/U97RvCCGdA+KSHBV1HMZjCwPXtDsoJs/o7h1A/ZM6GIKqBP9TWpqTESX
	6GxCZx2cqFs9EDt86c8E/bO6+fGVuH4E2IWjYAz0zd6wvlIiLIpWBJ6M8TuRDs/g=
X-Gm-Gg: ASbGnctIGxPrOeHWg8v2IHmKvNogtOIEx7a8haiSf38j2CEUy6OaqevRhDVdwJ722ae
	79acq2PJ1y+jurpAYvCe7xgWLq7g7A43Jn8ZATh/cPfY1ICSU33+yUgsmKdn2EmzD+++f7Rp4oN
	cEUuR4ZqHiae44W9I1ashHaraDc6aIZqXsb8Faj9Y5glKsgUaHwgwukXp3FaHedw5JpqfyCtQG8
	xZ719N8NoHBAGfTCgs9EnBsEW+RUhMwK8E0zy23MP5mM8CdqPIoOYZcjqQfrQDZImzA+Ow1JBJl
	7+ny3gOpzXgrTlYu0ZdLQdRLkl4UN5gUlveiHrcrmh53h5fy2f2egRq46uYLjJMRkySZHg==
X-Received: by 2002:a05:622a:2b0c:b0:474:edd2:11c8 with SMTP id d75a77b69052e-47699621f1amr46843781cf.12.1741802078143;
        Wed, 12 Mar 2025 10:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0eqQz32HcJaJRaDTJC6gdf4gsgkF7rHNp23QdOHpAdvPCDesCeKRw96+c4IYou6wtwDfzGA==
X-Received: by 2002:a05:622a:2b0c:b0:474:edd2:11c8 with SMTP id d75a77b69052e-47699621f1amr46843581cf.12.1741802077828;
        Wed, 12 Mar 2025 10:54:37 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac288ffe157sm656364366b.132.2025.03.12.10.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:54:37 -0700 (PDT)
Message-ID: <9d16204c-40c1-4936-8cd2-5246966d844d@oss.qualcomm.com>
Date: Wed, 12 Mar 2025 18:54:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: sm8750: Correct clocks property for
 uart14 node
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com
References: <20250312104358.2558-1-quic_jseerapu@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250312104358.2558-1-quic_jseerapu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S_atNEy5PIdMEJuN_0iD15sWGFkfbt8G
X-Authority-Analysis: v=2.4 cv=I+llRMgg c=1 sm=1 tr=0 ts=67d1ca5f cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xkG_gMnDietyO8DCwaMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: S_atNEy5PIdMEJuN_0iD15sWGFkfbt8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=872
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120124

On 3/12/25 11:43 AM, Jyothi Kumar Seerapu wrote:
> Correct the clocks property for the uart14 node to fix UART functionality
> on QUP2_SE6. The current failure is due to an incorrect clocks assignment.
> 
> Change the clocks property to GCC_QUPV3_WRAP2_S6_CLK to resolve the issue.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

