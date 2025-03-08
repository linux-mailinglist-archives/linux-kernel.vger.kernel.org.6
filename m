Return-Path: <linux-kernel+bounces-552568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5EAA57B73
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D1E16BE01
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CACD1DE3DC;
	Sat,  8 Mar 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pm3Q5tMk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671E1A3144
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741446537; cv=none; b=mgnngxDeYIfdfL6/Cr3IxuDjjYbMbXA8Thu2rV00M05IbSHDcJdhJH0c4nrxbrod1qo9AMkhTUEKnBwD4EeTR/gDxzT193C6D3bLR/sAjwcxMipp5lg9FnzwZrX5mLW2wGkxkVgdQRR66eOUKMdSmX0BHpPABRau9f3gx7PXuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741446537; c=relaxed/simple;
	bh=3GFm4luup+pqEjZgGHZ7drgx+phEmjUyO+rtAkf0gdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrBcztlDB7i4BIX6lw+zEusWtzScFpWFg+wk1NeBQ5qUnJg4VW1ouO8Cs9BYWuKnLpNUua911UztY7Xt7s3T+5ZnvmoK2FE4t9je51QcOgfw9jSL2UbYCMlERnuTnTiRRBGn8/pxCD7YULkbiIbLDVxAK49oJbiwnAivIrLFeek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pm3Q5tMk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528Co26o019596
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 15:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9WvEgSQ6fjLHoWS3Q+wrjvW0AGfYG3GKpopCgkxp6Ro=; b=pm3Q5tMk7TXVfjAr
	voItw4cmezcg4cFw7t8NmsUkDERgQUACEOGihn7lbmphMlWl8PPxm/jQPN/kzsxg
	pv2X4eHso0gs6UXwfFIJI2V+L+hpvTSzOMh5tD9PH1Kr7s8JJd3+vbEelu658R/9
	fENn5xZd63C8/+3exPGG2M04E0i2mJJJAdI0BqLAFLaq2ICqCryftaJmioOePiNg
	dDsmDVoeO/M3hjjvFDz7K8MGAkTFlNWei7No7oHiYGse7an6rhiJBM8QKDJ0OUsI
	BmJV4l9rtJJPLtzeUkBw3qRcZDivDihFbLTRXMlQSiecK+WhGQzAsvLR3Zj8R1Sk
	URtFKw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewk0qrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 15:08:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8ff8c9dcfso6398126d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 07:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741446533; x=1742051333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WvEgSQ6fjLHoWS3Q+wrjvW0AGfYG3GKpopCgkxp6Ro=;
        b=K0qJbIaEIgQt5+J6s6q0amgrE/UjLkgHfuI9Jt18CgtNKnsrPry2OXHSWHimnw1U4e
         Q2p3ITea8zGSRrJgHxwNMJpBzdXgCUrkTbTZL0ZG2EFXLcueIL5/qNCkpHnUtGFA8qru
         3f9qJHOEVjDqdNnrjMc9twJjZtAIFckC6DdiUZh0VAHzjue+ItcJ4IUtniN4qA3dOFY+
         lCDnSGzSIG4zQgXroBDG8cg34kw0L9/QT6LpECP64+pE0gjNlJR+WattbCZlcieCCthV
         xDDngpT5lLmYzqT57ZMAqlNjZ6+N2cWBwwImzvcAbCNbrfKYRkUOfpOoW4IVIZEmg7HL
         S2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU34y+5L6gSqW5Voi4xNEVhnUO3/6zL7EN3A36MNcbhvIlms9JodcoBE6qz9NM0rRDJuxKRlpdjrmPo/DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSH3fMS0Zjl0Ef1TEbyKzjOYvNgLD7jMpprNIVeMfsgNDVvogG
	SqXY4ts9xoKHBVT3Xbpu8I/pPaEIsMnK0N71Wg+TRClVQOcdCcZAuD+MmuIce8YxlsiZ0d7JT17
	yLSBT0tHkQPtvykGgIUb57vH1ACfhh57VB0ROOrdiQ0niDeJLhdWJD/3z6ofrPeI=
X-Gm-Gg: ASbGncs4CGoHoUe1tFb6MaFY6xaYsW6QFAaV16H0gibVWvSeSdHGAxMXNOMpWtjUJpc
	7LymTdpyKlg6XlbmPALR9A8Od5PiJ/Um5Q0UY6z7XPaRcvm3exKBPiQG1lCvOaUGKnGpAQM5We6
	4e1Alzg3BSETFdKVbCZQAstPZ+vLoS9IPR3G0bKuhzZwRafcomcSvtCuADF3ZKuHq8hOukxu1iz
	jKQCrPxLjuL7po+Ha7CqGGyDDBVsQ5ZnoCg2yhKYAamgjASDrtJoFnW/v2Sh+UR/CcgZKeauBED
	lCMSNMrCkNoVU65oidcjUhhQmvZSQSb3D/d8HAXpn++OlK7cro73EHLmj7+9ie0wcASyJw==
X-Received: by 2002:a05:6214:5289:b0:6e4:2975:ce54 with SMTP id 6a1803df08f44-6e908cb5248mr17585446d6.3.1741446533308;
        Sat, 08 Mar 2025 07:08:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7VzZfMJABr9wvGjQaN3mynWkb62I3My6wlogqF3sUcltn/eOJ0ALm9h7T2SCMQYhNBFiMvw==
X-Received: by 2002:a05:6214:5289:b0:6e4:2975:ce54 with SMTP id 6a1803df08f44-6e908cb5248mr17585166d6.3.1741446532965;
        Sat, 08 Mar 2025 07:08:52 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943878csm443575066b.23.2025.03.08.07.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 07:08:52 -0800 (PST)
Message-ID: <aff4fd18-59a2-4378-bfd2-840bcd1a2392@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 16:08:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
To: George Moussalem <george.moussalem@outlook.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        kw@linux.com, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
        p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org,
        robimarko@gmail.com, vkoul@kernel.org
Cc: quic_srichara@quicinc.com
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Tr8chCXh c=1 sm=1 tr=0 ts=67cc5d86 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UqCG9HQmAAAA:8 a=eQ806-ShdUuXvpoWo40A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: i0W5obC8q1yk7I4AimpY1Zn27JXzXphk
X-Proofpoint-ORIG-GUID: i0W5obC8q1yk7I4AimpY1Zn27JXzXphk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=542 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080114

On 5.03.2025 2:41 PM, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add phy and controller nodes for a 2-lane Gen2 and
> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
> one global interrupt.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */

Please all the comments in this patch, they're not very useful

Konrad

