Return-Path: <linux-kernel+bounces-409293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AF9C8AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72736B26042
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1C11FA257;
	Thu, 14 Nov 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="geSCMfng"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F71E883F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588468; cv=none; b=rH60Z3/wAz2DGhwkPCiBJhEjYvsfKG7DzBwX+ZlqYWiNRx8AziD8Ojlj2NupmICc2mxsGDjF0S0dE6HPEEFZdeCEvL7/Mo/bb1UYDSUMXw61LDi5ZL2xB4Z7YUGYh2rFZAkkFCIZxZ2sOyeOHbFLEzxIDpWW+QuCnWQeLlAlv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588468; c=relaxed/simple;
	bh=RTAd+3XLwNxGPeXfDfmBJBGafJ8wLyA2P1qPpPAMZfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dbsMEykMp0/BfZjwrrjA76hiUEVHA0NXJkPc9bWJFsJpedKYJOw12MMEZVNIgeR+uG8gmJx5rQXxBirlqpzFvkjvm2m/jkYv8Cj+6RnQ/7xD81Qh/2GpSPJjwbasYekupuM7wAgf0qWAyISztmhwLl7SpFiIhr4ywQwkO3CXt8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=geSCMfng; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE5oE93015394
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TirkE3p4MW042XA9VvghCJxqECC+Uiw5LWNZTmDaOsw=; b=geSCMfngvs5+4/9Z
	5nLUGeut9W9AmVnQA8ac3nFsFJdZVelclqF+2DLmuOjlfo8AF2ZcIQSZKwm5XDcw
	DiLoyz56XfsGzNCe30SDAYx/cnF24SzlN8FSy8QTcjWVi+D+90+SZCMs4kxrOQKJ
	gN/Mn5PkOSdXPSh3TbAJ/DYXF9RqvtMh1mgoTUrKAe6PzZPExTwCgArFm8rvSowd
	wSpXbMcJPcePuWQamp3hwzEhI9yafSbxRBxDnzREyWgslfVAOEQDPnkwHlGl+tCm
	WW6fpPBoijit6+GGssj8ua/ruJTpJIbiKUNUxz1NmoYiFl3uFx330xZbiUALkT6R
	2j+TWw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vsf350u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:47:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbf3f7273cso1384876d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731588465; x=1732193265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TirkE3p4MW042XA9VvghCJxqECC+Uiw5LWNZTmDaOsw=;
        b=q1x2WlW3w9Qq8b1JEnracnreed6Sc0k2QyNAn+J1L7ps4OMsu4NThiT2I9BC5mgmbZ
         fpjxtsxaZgba6tn5Yi4SREMucCY7+B/Hc6ZmrGcygzh0o9NDCAcJp4tFNUrfjDmA9LQs
         xrnFFHQVcKTWVSBYWeSzBpu2xBR3TxQ1PTOt+HPWDksIUbw8vhUoAKtU8JbAoOdvXBnc
         ofBg0zkZ9JQ12IkT7FV7cC/YDobDX6iBPu4oo6iSdUDWi/Ng9dPCfIAnYdB5q+03QdQV
         9GMJATiF/4J1+8s3XoXcJyqCEUmriEinxKFuLe79n5ZqCyBPd+b8GsYxhCQ3lZtHqfVs
         VMzw==
X-Forwarded-Encrypted: i=1; AJvYcCWBPJSRDDxO6FWcrZlBE3/D0nHB99xUbUZPBgkLa1hMq/PZ2/qpIr+/4Lr2tco+6GIaagLUwr2S8CZO8rE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cluzDVndD29PEHg/xsE2PB3Jo2n310U3dl/PNIXTurUFtmH+
	xJoJzCFPAk62Ofl3SWNVwsGNEqv+dn5ijxrhCvcOCrivJuXoPaXR5DJbS2KA+fxsj2iDq5nqcxe
	6uJDdZfTxaFZyhUuGUTF8OUCGJUExSqzKFhXnXAsbOL0T4x32rPTgpnm/BkX+uxU=
X-Received: by 2002:a05:622a:281:b0:461:5f08:e680 with SMTP id d75a77b69052e-463094018a8mr152959301cf.10.1731588464737;
        Thu, 14 Nov 2024 04:47:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsxDffnRImxMQgqIQ8TXOem5agf/yFgovxPS825RyYZPFwUerfkyI2ebwr6OsoRlLLmIc1hg==
X-Received: by 2002:a05:622a:281:b0:461:5f08:e680 with SMTP id d75a77b69052e-463094018a8mr152959011cf.10.1731588464407;
        Thu, 14 Nov 2024 04:47:44 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046c68sm59057466b.167.2024.11.14.04.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 04:47:43 -0800 (PST)
Message-ID: <7e293d68-73c1-425d-ae52-e0893c8e0a61@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 13:47:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] phy: qcom: qmp: Enable IPQ5424 support
To: Varadarajan Narayanan <quic_varada@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@linaro.org,
        mantas@8devices.com, quic_kbajaj@quicinc.com,
        quic_kriskura@quicinc.com, quic_rohiagar@quicinc.com,
        abel.vesa@linaro.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20241114074722.4085319-1-quic_varada@quicinc.com>
 <20241114074722.4085319-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241114074722.4085319-5-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uL80moKmaDuRGRJxyNkFFlxrR9JcUjNu
X-Proofpoint-GUID: uL80moKmaDuRGRJxyNkFFlxrR9JcUjNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140100

On 14.11.2024 8:47 AM, Varadarajan Narayanan wrote:
> Enable QMP USB3 phy support for IPQ5424 SoC.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Add 'Reviewed-by: Dmitry Baryshkov'
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index acd6075bf6d9..f43823539a3b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -2298,6 +2298,9 @@ static int qmp_usb_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id qmp_usb_of_match_table[] = {
>  	{
> +		.compatible = "qcom,ipq5424-qmp-usb3-phy",
> +		.data = &ipq9574_usb3phy_cfg,
> +	}, {

If the software interface is the same, can this just use ipq9574 as a
fallback compatible?

Konrad

