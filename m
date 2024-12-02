Return-Path: <linux-kernel+bounces-427693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12C9E04D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A78284D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D70204F8A;
	Mon,  2 Dec 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="akdzHQk2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3C202F8F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149578; cv=none; b=nx011pth9eQsFw7ceDSnI1DcWfQs7LGdShq+Ukv+8TyxLK0FqAW3OlSx35nY1+qzxAUa+W0KJ+jlR5jdasAIYuFk/LUSx/pPbK0GFYpPsXzBm5G6aNFGeJ295RjWBgCirxH6dyxgpuYAOrcMiGuRQc10Xi14sepkarZK4B59g1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149578; c=relaxed/simple;
	bh=U5V8w3BHhDumOMT4/n+/DHbu+Z9WvE7y+HF6Y3k+6k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oU8AjvG05NiysGBN/0dKlVzwWTssV+wonMV2fqy9JdFsGpmtS0+3aO0gD25kuW1lwCBASefuI0k3rBpcRmydipB4mcVqPru4jVEEww+r9R284XL9NcmkeuSZkZRrcBQCu3ajbffhQ4mSUAMO5RQ+EcJsm22kCa+s1T2Aao1EoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=akdzHQk2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B29HA5O012770
	for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2024 14:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C9+aPPZFAJemDOGMrrzpUMQVAlKiCGsFemq1XONcpZk=; b=akdzHQk2JJvu6c+o
	cnFE7I42krUUOtwqd6rQMddEcSyZd066KzphvS2c5B8jHDcf8YX5ToDEA/uDVnt6
	hWGds3Ugt3t7R9qfBjptMG7h2noyxlp4Ese/lk4TC5iDt1Ip7ZaqZ3Dbd1uwVSNe
	Yf1fdh74no9Uc3h98tFdTt3NSQws5xi5geUPf1pDYGD4MoUONLk60xfR8bfHfKmQ
	KmZzIRxZfUeG+UQLOB3XBC3owX97GqPJjTarEcsQ/PRE3ZaY7Syg3kkCXqo7ztCC
	4WWR5SAGdxobqnE6fC50Fciu8kPSLUJCtWLZh0uayWxFFcQUvBYOThAWt0Ocdf7q
	YDzpmw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437uvjvwd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:26:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46692fb862bso5049441cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149575; x=1733754375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9+aPPZFAJemDOGMrrzpUMQVAlKiCGsFemq1XONcpZk=;
        b=iXcwQSzQet4TkmTD6/080/phBHQAentlW0pjiR64uELojuTaFmPHuNAij2GHSJSwJ8
         EOxmvlfYkBV+5x+VqCzKQbU096k8MObPKyB58r73hrEor7BRuWNR1eBeFzTrRElY8fJz
         5LEmvxgxEgtn1a4qdTHtH43a97SD2z+bi/dCbWzurIyiqv04833K8CLKy4gh/qJcdVKx
         hxhdI1Cjf6hW/LYrBn+je1FBJn1TgTJGfhZWF3QIXRS7z4c7H+3yOf1ZTLYLTh3jr38X
         JqPbzrdppVFEJ1GJkgB4UMEEJcqRIOktT49JvzzmVofRqW6fMsBmQNcGTJpJx6KdJtds
         PKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYQ9x9vrik+etlB4scNKgS659w0ZyWzDo3yjB7t86/37oVGifJY6jX1653QUxSo1fH4dnk8qDGqwIjNcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEnWaKgikXbBGbyK4AcHVNwH5aHsTgrNBrX1YrqJ5e2uQyEhv
	ZMdlOp68MmCIabBhy/O00guIPnpgKM3cq1qhM+225b0qZBFxLbD3cTMpbSSz13GeIx6CXRPW5bL
	fOEA4kMrFt2LFYnYr4FPyh6n0e0NAE9PF/cFdNULSN/I6h3O32Osys3DtvzDrFKQ=
X-Gm-Gg: ASbGncukZNzZfXduE/dhpPOy+EQYbkCI3avO6e0BYDrzGAfPJ8BJA4mqIstCAvlOdLC
	1fUiD/h/+OLh/IVceA5YeWycLdrOhk7Y8coGk5ioozKQt/cyr9VkCQUbZ+VCuCGK3dBmE8HQMYm
	8YQ4s7QT4qfJj44MGa1TSa4SJADvwfF2k0DFdodHHfMS6PMGqnwZHxjghNuejic4TaZqvfj+eNG
	h5ullHqA5wEanNlZLy7+RRevZPOjcnDgiYEU4Pyg+Ru1ymk3onYTojYix8Ub08ygqrfUAOqxPMA
	WcJFsbIp8Sf04fv1DmmrXAjAu/tfj+Q=
X-Received: by 2002:ac8:5f46:0:b0:466:85eb:6114 with SMTP id d75a77b69052e-466b34eb098mr142606541cf.4.1733149575116;
        Mon, 02 Dec 2024 06:26:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEks5Q89gw/Ra65Tb+SUhB7kvtV72Gy/kgkC1JbMoRUkpqIZ4f3DHNc/WA4iENdSFUUHOA4+w==
X-Received: by 2002:ac8:5f46:0:b0:466:85eb:6114 with SMTP id d75a77b69052e-466b34eb098mr142606291cf.4.1733149574666;
        Mon, 02 Dec 2024 06:26:14 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599800a6dsm515436666b.90.2024.12.02.06.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:26:14 -0800 (PST)
Message-ID: <25873cef-2871-46c0-a764-9b5ee85e9a58@oss.qualcomm.com>
Date: Mon, 2 Dec 2024 15:26:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: qcs615: enable pcie for qcs615
 platform dts
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com,
        lpieralisi@kernel.org, quic_qianyu@quicinc.com, conor+dt@kernel.org,
        neil.armstrong@linaro.org, andersson@kernel.org,
        konradybcio@kernel.org
Cc: quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
References: <20241122020305.1584577-1-quic_ziyuzhan@quicinc.com>
 <20241122020305.1584577-7-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241122020305.1584577-7-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DCOrq7jLA6_iT2FkGP_9XqBiXVk25fmI
X-Proofpoint-ORIG-GUID: DCOrq7jLA6_iT2FkGP_9XqBiXVk25fmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=739 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020124

On 22.11.2024 3:03 AM, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add platform configurations in devicetree for PCIe, board related
> gpios, PMIC regulators, etc.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

