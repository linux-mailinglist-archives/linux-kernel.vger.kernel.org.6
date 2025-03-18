Return-Path: <linux-kernel+bounces-566472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFDCA6786D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7772E7AB8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBAA20F097;
	Tue, 18 Mar 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R9HfiOtd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8F20F065
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313272; cv=none; b=DPH5VXkhCEogN5pi2zewaqYolZs9EjdbaK8n49MOUeuNg6/HL6v6yYWPKLuASGXNq9+pObrCWA0gXs5FsXtLIgEFSxkX6mtRS7KJ+icV2vVrAyPT+auodNm4teqyomJVqTSGk8yIAfT8QGqF+a1p6esjg9erak9ijApWI1HQ8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313272; c=relaxed/simple;
	bh=oxKIBsNlJlT1kPBIzSrXpjjUvcEU3pk5b6B22ySjIQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiLCDPAO9omrJjGagU5PgeLeZOch+WYdxg5YiiyLBpXrU8izIJR9Dm0C0LIMUjyHyTMbZ87NCCjYbvRNlWeHdM5JIP3JMczBPCgzn5pvKZyFAuYZuUx5M3Rvq4IZP4qFRPmfXzRLYk30xECK0LbHH7+SJbLi/pKA8HcZoeHK6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R9HfiOtd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAVgSa020729
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Xa1vIDYqanRUirDnrweIzMORGB+bGkA9Q5Pq6d4ttM=; b=R9HfiOtdAiawBeHq
	8uK7efvQTuoqDnUTdz+mzQ5vGD+5IHXoR/puRh2RGGP0WQCHEh0W1qObJ8jymWo9
	VAGa3eeutwiv/k8jB5xdpi2FXTLeElXN8ZVc2WP5IHWemm6hOZerLQcQxTe5X55x
	yVqOU8G4rONsP/P38zXyStAAxbr8ktv60bwxIBtUknZR89DCjJ8KlnmVLL8dbeLE
	/2R9CTN9WrBvub/o6IZCZ+Ofe/pM/8EUmyY/eWGvvcChU6BuYXnmzbvK9rGlD2F1
	7w4nAmt+xB57q2fpHAMtsBCF7gDAgiIIiM6eeOy/qr2Loucf4yg2x8fWaUaj3vhZ
	0QpFFw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exxbjbq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:54:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6eb07043f12so4663026d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313268; x=1742918068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Xa1vIDYqanRUirDnrweIzMORGB+bGkA9Q5Pq6d4ttM=;
        b=gOLFSSZBxX42camt8FCVf+iVw7OxUI2C0fK5+SkEM4+27vtzxKDMCAHxTj7oOnzNpK
         GB3D7C+gPReOjDUWbANnJ8/G3U/cSBLqxWWzuYHrwClPl0tsRPArVqcH4f5+sPpEudz1
         +S4pwJZwDjqeSZ53RIhejZh9LRa9H7RgGKpgHnKVru+bO95UgTjbVyegO4zahpdx1nNt
         Eh8yh/SiRQmTR3IXtcKcQnHj/fpK92YBEN4EuYpllvocAMlh8a6XQN4o2fo4zehbZ/7P
         VWvOz/DSnnMf+K72/I2EoDIpTvYbJ31rIl2V8asrp65vVdoGjQ1DnzlF0GP8M4hgDE/m
         WDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVIsjGvWfpvjKEW/HEMm+rFDQqkivd9eLB8wFHAbV1RvvH+Fun8J/zT69PThSV4zEgrlhkkSBtl64cnDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NSoP//yrkqMNcUqXVzg2j/crcYilVWuiQltbZps91EuVGWpP
	aCR6FTWvy/RupKKIJYxAQl6ijQXZ4czppzt0vjSwy7ixQnFrGtGm9vxS9m0MpWKcc6RcHXzPa7w
	Zt40QeoraQK+DFAIytA7zlqrqVt4Zkh0/RMfPg6GP6u9svObUXXAeWUqgU9x/qD8=
X-Gm-Gg: ASbGncug2waVS/dTBaxQqlHCTg2Zqw8iGfkzc/vN0spNZ66aPvZPyiAz18ORjX/bHn8
	f8HbILjEUxk31UpBAh1qW0jXt2sWzEJ3NIOgmaV6vGDpFKueP6wrE0vmO993YcJwa2b/R535sjr
	j7aDSIRWu9fEbByzvWcRqAK/zCHEQIRs0PiTSH1+sul9knqFOQ9gOaHvLSs6w5b2ohhGe8zkXbj
	cAn/r1/q62riO1lmVBd5eHNKTQBsOXhGtljIoN+p7hJCySOKnR8IoJ561fNwewKtRmM77Bg6fVP
	QX900BRTOcLOaFM7JMDOQ3tVfeqDjpZSQ76I8KXB+zRxWWIy1BDf0pKxFrBmPl2jnFFmvA==
X-Received: by 2002:ac8:5d51:0:b0:474:bc4a:edc8 with SMTP id d75a77b69052e-476c802e949mr102042791cf.0.1742313268464;
        Tue, 18 Mar 2025 08:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6xTKNeNNhEgwTIfTmczzperJP2O4LGuYPxK2AJYkX+m+z/87TGCFWXQ5mEjZvJDgSdah5Ew==
X-Received: by 2002:ac8:5d51:0:b0:474:bc4a:edc8 with SMTP id d75a77b69052e-476c802e949mr102042531cf.0.1742313268055;
        Tue, 18 Mar 2025 08:54:28 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad27c1sm8087797a12.59.2025.03.18.08.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 08:54:27 -0700 (PDT)
Message-ID: <64ccc09d-7e1e-4c20-90e9-43b36a9cc46b@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 16:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs8300-ride: enable WLAN on
 qcs8300-ride
To: Stone Zhang <quic_stonez@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_miaoqing@quicinc.com,
        quic_zhichen@quicinc.com, quic_yuzha@quicinc.com
References: <20250318093350.2682132-1-quic_stonez@quicinc.com>
 <20250318093350.2682132-3-quic_stonez@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250318093350.2682132-3-quic_stonez@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QN1oRhLL c=1 sm=1 tr=0 ts=67d99735 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=qC_FGOx9AAAA:8 a=COk6AnOGAAAA:8 a=83HhcBTouBSDzsAgFTAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fUDDIviLOfgXvET8ktytv6CC7gkyo2GX
X-Proofpoint-GUID: fUDDIviLOfgXvET8ktytv6CC7gkyo2GX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180117

On 3/18/25 10:33 AM, Stone Zhang wrote:
> Enable WLAN on qcs8300-ride by adding a node for the PMU module
> of the WCN6855 and assigning its LDO power outputs to the existing
> WiFi module.
> 
> Signed-off-by: Stone Zhang <quic_stonez@quicinc.com>
> ---

This change looks good generally, but please align the various stylistic
things, like property order in the nodes you add with x1e80100-crd.dtsi

I also see that board-2.bin doesn't contain the variant string you've
suggested ([1] @ commit 646e008ec53a8bb9ae16ebf98a65b29eaefd6da4)

Konrad

[1] https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware/-/blob/main/WCN6855/hw2.0/board-2.bin?ref_type=heads

