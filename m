Return-Path: <linux-kernel+bounces-418245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C19D5F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E341F239B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E65B1DE3D6;
	Fri, 22 Nov 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="agfKauXL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F379C0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279765; cv=none; b=WYYJdlz3ZOoihvqKhOnQnJ8v0FefyXkEzc7Z9+hptR8pGFr/QMuz18eb9142HP8lPVMm98ACOc98v/KHSwmYORFfypaj3Mw8/HBDn83bQx6JVhJt0c1Oec3rZi873zX+w7jRHpGHEnNVEpyk1Psf/ELCbwZYOb4holkIBhZpFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279765; c=relaxed/simple;
	bh=xTRCGfdo9Stp0wOOB5Wca2fRGwtlSue6W54YyXL4pLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIjMrMc2PbhtquktZy9FL74HlhmtBVmggjWjnXhPTNKdjU1hkJxTSH6QlVzI6Q63A/5Ubn4P+YNaC4n4TKpPYulTSmMXC/azG7DTfqfj154HeyGaeGw7CZvqlXeqGD6AMaHjxdnpWnDxt8q8GDL9SZPl65zoTxeZsh3LguKP5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=agfKauXL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMB5fPK020148
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	REhoF/nwIa3Kpo75R8zIL3UghWzoKNPJpxarEg/VIoQ=; b=agfKauXLW0yly76D
	6AU7ux7+iO0SQeiCkJSz3+m03P6/GwZVsdX+u+0siJUmCefobw0EcT+HI526zqui
	TXXcYKa/0RCGx5YxIG/9CwSV5EjhBwOJ/X6OyMDQzyeLdqrzgg+2VFLlRgi7ygjA
	HZVW5y9zZYKKOszkALtU7Mvzr+qTVZY/B+kNpfZ0GcGkIwYS2E8KuXb9REQd8+L0
	FPNyhP9Ap9W9hEguiYZVjWdt9vN3D4a5V4zyTD/NbpJ0IbW5pPCkZkqlh+2ueyFJ
	nOT5ReU2o+DonEU4FiLreGwZ/E+0PT2REqofFwcNmA8wFB0iHU566sgvKP9078n9
	713VAQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431sv2n6p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:49:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4609c883bb6so2272811cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732279762; x=1732884562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REhoF/nwIa3Kpo75R8zIL3UghWzoKNPJpxarEg/VIoQ=;
        b=sl4OfPZWIkVkQ3FOatGRT5ARF5g9XRDS5RVznyunf7gr8I3vFC7Ve71+KekCanK6fe
         bM9CSF9IX4PwmfRoptp6nN5pcLwUYFXQpbH5R9vpx8zieq3krn9F/Nmmu7lkWzkqpSHx
         04KLCTOhR3qEugqQhKeyK019WTN2KsQoXKyTMccZhSxSGDFSQiV18+GTWXFU77cXPYVI
         VMI2G1zWqVahL3A/8Fvni5cOKVIzVGQmjoa0IEirbkZzkDuy2c0CobZlLhrOTDdRFiRK
         FS/YXbsdvhS4iKdKTctzMd/N8zfjV37hOaWeLUgrewpnG+2Nw8uTrwYZvpbrpG8f9l35
         +jkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXquYP31eypA6QR/9um1Zbq6ziwJDrjp6IUsu/DtHdR525I+wA4747zmgjuyN9feSfyxdMvprPuzk7wn3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+w1UMT4LCKXuopYGY1U1s1UjSkcwTLA6BJEypTHJrDhfi0T/A
	tSxcVSEbgO2KzzOzCYI3V2msF17VadVNK99K4DHLrmIoWNfV51mhwZLZGSOGYy0nrmQm5B69nu4
	5S/ioF75T3VaWJ6ZT0lieM5mJithB1QuJNl9XoFI+5Evtrm3VeL50wGbmJN5LpOI=
X-Gm-Gg: ASbGnct0ify8934bhkbCctA96F32E6jEV01NmDCxGcjSxd5N48CMDwjlgWeCB5Nt0dp
	AxLovxC/Ug53JCSithA3787+8erhDf6hGtLawiQsdY9Uk0uN3f+UJXwidUZs5yFK+22hc9acQcS
	Vr5/NpN7m8oXR6qRGI95UVbvM6VuFS7BDPmvzuzRCLLT7Xill9aoJAI21DuNdl4biKyZ6sbku0t
	6wolz8OKir6tY3M0WJC0ot1eU7bs6O4TxHrcltKj9hRt/9mGrYHyBK8+auu8AHpQ34n+Er9eixv
	j3ICa4zBELfLtwyOTqbtCO5Hu6hkk2c=
X-Received: by 2002:a05:622a:11d2:b0:462:fb51:7801 with SMTP id d75a77b69052e-4653d5abc5cmr15545011cf.8.1732279762607;
        Fri, 22 Nov 2024 04:49:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvTuofNSWDF4XHyk9KPOXen13nDRCblVw4oh2lWtCdhH+Pocb6lLIp0CaDfGr+jmXsdDiKKg==
X-Received: by 2002:a05:622a:11d2:b0:462:fb51:7801 with SMTP id d75a77b69052e-4653d5abc5cmr15544761cf.8.1732279762160;
        Fri, 22 Nov 2024 04:49:22 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28fd44sm97378066b.26.2024.11.22.04.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:49:21 -0800 (PST)
Message-ID: <083d53c7-58d9-4e36-93b1-36e5696dd495@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 13:49:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add 'qcom,product-variant'
To: Cheng Jiang <quic_chejiang@quicinc.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_zijuhu@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_mohamull@quicinc.com
References: <20241120095428.1122935-1-quic_chejiang@quicinc.com>
 <20241120095428.1122935-2-quic_chejiang@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241120095428.1122935-2-quic_chejiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: etCOLIoYSmgzhOzgDuFAL6QFDfdDXP53
X-Proofpoint-ORIG-GUID: etCOLIoYSmgzhOzgDuFAL6QFDfdDXP53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=992 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220109

On 20.11.2024 10:54 AM, Cheng Jiang wrote:
> Several Qualcomm projects will use the same Bluetooth chip, each
> focusing on different features. For instance, consumer projects
> prioritize the A2DP SRC feature, while IoT projects focus on the A2DP
> SINK feature, which may have more optimizations for coexistence when
> acting as a SINK. Due to the patch size, it is not feasible to include
> all features in a single firmware.
> 
> Therefore, the 'product-variant' devicetree property is used to provide
> product information for the Bluetooth driver to load the appropriate
> firmware.
> 
> If this property is not defined, the default firmware will be loaded,
> ensuring there are no backward compatibility issues with older
> devicetrees.
> 
> The product-variant defines like this:
>   0 - 15 (16 bits) are product line specific definitions
>   16 - 23 (8 bits) are for the product line.

Product lines don't exist in the kernel. Please describe the actual
differences between those files instead.

Konrad

