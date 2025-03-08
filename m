Return-Path: <linux-kernel+bounces-552549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF0A57B2A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50E116F6AF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0E512CD96;
	Sat,  8 Mar 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzoEYDYM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFC1BD000
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445037; cv=none; b=CVu+eSAgNPvt59IXBJPWnWiIz074rzzpbKMsfUWnfWq3uozfFwfr/6lIZ22DYzxwf+BCLsGIEFlUYd3mvVUfCpDsdiU/2BERlD/G7DCD2rYNN14MmkjlowCH65odrV8+bwqsaf5UYApiMA8fs3a4J6pmEZrFn24T+ARzygc8xBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445037; c=relaxed/simple;
	bh=a6AccKTd3hzMWrFUUvxgu9sE35uOrACw4tH62Zq6Gnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtepPqQuVKEkhW+7ACFy1xmOXq28r9V3N/haFThIXX0VNqyabZPVzYrgukfBoJQZSzyP4NRtUFhTByyx9QkjZEHWvjRRFg/9zv1KVCS+TdK4imZt0Tw4Bcz+gXqmvzpCbNqiH296m+iW1MLiRYmsCwiYiq0l0OLQPXw/O4myo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzoEYDYM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528Dx8dS027599
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 14:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hTvFf2pDl+XrqwaWQVGdTUVg+Pbrdc7UejyBbgMQ13w=; b=jzoEYDYMv0VVt+B0
	x1Onplyye5sBhyTweHqno1XKCzADt44pF+ROEvmqCd1iBIyoX154fNOjDTzLvDgl
	VUDqYwOGDh3lsglJHiQLj7elOyaZOB3n7tYWDN8QfmrCnAQY2croatvaDMSR/PlW
	HUSnL13yQBm/NMzF6lOwpMgpnrRupAAdCUa1VA6JduGk3nZ+EWBUN0HXkBr4d4vA
	fVjJh6/Lwlu1vWkPGg+hlgMbCmrY5X5EkTFk7AX2ELiUGQ0oCh2zHqXxLwpcFJc1
	RDSSqJztJ8IuJiMrGoJ4iiqcnAcsIaSf8JKEBkhjlEs4LRrHD8zeuHrRot2xHBUL
	+PxYUQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex0rqfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:43:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476695e930bso577851cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 06:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741445034; x=1742049834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTvFf2pDl+XrqwaWQVGdTUVg+Pbrdc7UejyBbgMQ13w=;
        b=a1D7o0THZvZHPxmyNnqSGggbUizAeXvqP72Aml/TNRE80aiP1sNhu1WPytK2OrQbPl
         q1i+bb/U1LY79OLr9o0KsfaqDJ7bBPMLTYPz19EPb2sC1I9LIxJgSfIhMFsOg71jczNo
         mvyL9zonfK/jXf3rS/Ddy8syg0QVtw97Cl/asQveHnj6Js9+x91FUNAXsHFZOTpx92El
         WO2uMgFyvsJuJpxq63FtthF5ISmv/aiD4Fguz6AR8iB21hDysOIelmK3xgbr+eaXmYn9
         JxiEVE3IQO101HK1cW72YIH23k5Z1d5otZw3wTBrWwOd0sxb/v0xMQiA6CW/v6Vpw9D0
         S+FA==
X-Forwarded-Encrypted: i=1; AJvYcCWl9wxOAid12Adi5XeLEL1Tqfjfo5An6naPlbfhDShJdO1JjCMYiDZujRsJJwqc/kwce+24YbpFaEmepcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8bUBy4JaEPmRQWZbH4JaRvVmjNaDPahT1OviIA/1jUEcVII9
	ndCn4VDOGZCEJ+LzNXYhSb1MoLHngBdCRO+MjVICk4fJhBvTNejvpQNdRkkPN13/4VKW49s6rSb
	NO5huLWqn7reyYnNOTz9WZfh38dWUBw5YkE//yAayMa1VZDZGnhi0N/NH5AbkQ8s=
X-Gm-Gg: ASbGncvVlVmi31jnRVy/bx1NvNo/vnTGf6hvZTHvJjQtBV3pP3b2guqmgqVTmYUpu9V
	ceSwZf3JalAhsVhwNAaDp6BMQnGna8VYkbAFTzeYt5bxU5fwwKsOYjDbkqbHK9zmUWWVY9Axsi9
	7ktYjjUomn+GvePQRQVPDaEst6oQpk19L9PcBBbQKFI15tKstnLwoCqEZSIPVxsp4bVYEUxd9Dx
	7t6tRIcbr9/mebjB1mL49iLKYWn7X7IiutCclf8mWV7kXSjxzhGt3A1C2Q3nI4i0M/pRWADpZWX
	H9VEHOwMpvW8PeGkOMXQaaXK6wY8jLKyPpdiZaszciwS4KLEU35bfWVq/wTDcuRS05JP4Q==
X-Received: by 2002:ad4:5baa:0:b0:6e8:9fc6:e41 with SMTP id 6a1803df08f44-6e908ddbad8mr15717006d6.10.1741445033888;
        Sat, 08 Mar 2025 06:43:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGUnI2FVM82LalckmE1gIl7KsKmJdBtVdyGmQ0HQO/+XDZwVpqM/Fb4ITYsenrofTKHJt05Q==
X-Received: by 2002:ad4:5baa:0:b0:6e8:9fc6:e41 with SMTP id 6a1803df08f44-6e908ddbad8mr15716936d6.10.1741445033526;
        Sat, 08 Mar 2025 06:43:53 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2523d940csm318868566b.178.2025.03.08.06.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 06:43:53 -0800 (PST)
Message-ID: <4232ba8a-cf8f-491c-8a96-97b16cd4a9ff@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 15:43:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] arm64: dts: qcom: ipq6018: Add missing MSI and
 'global' IRQs
To: manivannan.sadhasivam@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-19-2b70a7819d1e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250227-pcie-global-irq-v1-19-2b70a7819d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IkTvZRGtO5uiGPme5witSrQyCbBAXBIK
X-Authority-Analysis: v=2.4 cv=f/qyBPyM c=1 sm=1 tr=0 ts=67cc57aa cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=DV3kMMkrmgS254hfeM8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IkTvZRGtO5uiGPme5witSrQyCbBAXBIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=635 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080111

On 27.02.2025 2:41 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> IPQ6018 has 8 MSI SPI interrupts and one 'global' interrupt.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

