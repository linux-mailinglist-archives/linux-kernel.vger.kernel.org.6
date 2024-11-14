Return-Path: <linux-kernel+bounces-409329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDADC9C8B57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DF52842AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E891FAEE4;
	Thu, 14 Nov 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AnXMRpYX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0A1D79B4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589409; cv=none; b=inAu3FNZ+hAYRsSp2sq6s0x+ub61EDKz+AjkF1KTpkk1ZYAD67ecYzUWEa+gY8g0cEuHd028ZBEY0bmT9l35GTd6GDOGRPA4d9sC1zNP1LmplaTCgXUDnIA76Ko4xkYMwT1Gg0Qo/ROjnO4yw8ZcvX7WbKe0GPPHOztvXbhUtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589409; c=relaxed/simple;
	bh=BZ4IAiqeCshhjK8LReM/p/MzvEiPrZ1nkrkoOjqYk00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq5aP2w3P32PgnWiWqGZt5LQkf3t/kNMpL/ChU0YcfAQJ5R/bDUkoSzFJk2t7qW1fRllqDAB75q6q0/5SNLMyGJh/jL+oP/Y86c1ce+h8fJ2I4XUklO221qhcOB1SX2KhQRqHzNrhaah9iemB7oJXlGF5ejjXKN+Cw30ZL0tpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AnXMRpYX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECpN58022553
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g22KIDEPaoNrEA24yQ44dQ827iCOLGg+LU5vT4ZbZGc=; b=AnXMRpYXM1EZonAy
	iqybdSbcTXmXFiU66rf1pP3HlN0g54xEbTXjNWpqiRxRVlJCH7eQNPdQSr6/HWam
	y4B26DlMQQCPOhNVZfB0XZqq6lwME9KnzAOt8bWoRX4KaewJkuZpfsCT1K7EA0CI
	GtbpVQdOL+5K+t2PtVi21Tdx/KG9j9t8+b7spw0LZ7onF2vgdQRju4xU95mCKG+y
	EWxugoteOQBeDpFTKM55H4tUP68/r1sInbgckNujrnVDGTT2QExlKImSconyh06R
	9SQazv+t8WCpwfwrb5Ijflcsd17z/wcwjTgzSFkElCUP0sImXLAz+go2sOKRjUvB
	Iv/iWw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w9sv2cmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:03:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-460f924d8bcso1095401cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731589406; x=1732194206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g22KIDEPaoNrEA24yQ44dQ827iCOLGg+LU5vT4ZbZGc=;
        b=BEQlsfJZUfTNJ7Ib+G7cB/q9YK7FJ3KsmYj92uz4iz2UZyjrZ2hcWxQI6vJC8MMRTl
         CdKNwqZGDQMGf5jB2EyqnUgD1kZQ18pOZWpTm2yOXIZaZw4GAG1S08WhcWQ8QOFCxpP/
         xqaOEFxF1URWMXsgHHIU6Htfz1UJFmQVwwYO3A1xhhrfCH2QXGy8+OYIDOUtyTYYDNVa
         rNLHkeO+Tr/EQAfFZTB1a7s6kd/3cZk9miqONahzRqNKjEKyFaizfUg6ASgXyNisT4ES
         vTmEQJIOCP9pKC1w3SG5x7W6BsqxEfOUDBYThUzuqoRIGR5e4FZNesWwntobNJXbjYQ4
         ytGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA8PdXeuvlkOc1x3ZPp2jHncJ5Vmg+CrCMKPNtJB34qLwGa2XRdrz0+kpKmMMkowJGC0f5Ye+sNI+C1Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTdTNl0q72/JvwwM9PYe3VtuKtiwANBzQFbV7WlErKB71fifM/
	Rlc/WdRIDK1CyTIUYcbOGfj2RiBMrdIs8mPSb64ylutnNL415H0DvU0OzDtx80NNWXshRIr0Ziw
	YGvdtxbK2hGn/N4AZKrorm6OFfJB8LQ5qJ2TGS4Hj+fGCib/o71hMgIOPEigRtYg=
X-Gm-Gg: ASbGncvzE78Wnn630Md6EvkvY87ZwGE9OgqrNDcuiVVMUtXRMghxuFaKBw/a2dJ2phk
	CwdkGhbrrrdlGaK/2nWcCxwxwM0hGIcHihLKFwsW9RPHMBJ6Xb+0nqhMxDHZBzyhcWIPmhFZNGZ
	4EFUGjm9d4fZMT6tJbEFeYCcUKTTgPK33cuO//zW845Qi1g4EDvYJRAcQD6Hn14dddYLZlDlant
	oJC7DQeMRprk30UIgEGrKMBcF92enlJN0w5hFIKygr99NQAtRpJjn0YK10xpGXhQANp5dIpaNi6
	eLjILICO9w3CqvV8fZUYc/TIB8x+QfQ=
X-Received: by 2002:a05:622a:4b0e:b0:463:5391:de49 with SMTP id d75a77b69052e-46353921c77mr26518851cf.11.1731589405740;
        Thu, 14 Nov 2024 05:03:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnYr/dJ9JI7zdcoIIcj9YSm0IKKIhzv1y8yOR26raCDF+9A/UXkpyuCfsNPOChTVAIJ0zHnQ==
X-Received: by 2002:a05:622a:4b0e:b0:463:5391:de49 with SMTP id d75a77b69052e-46353921c77mr26518501cf.11.1731589404570;
        Thu, 14 Nov 2024 05:03:24 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd6a6sm61162066b.99.2024.11.14.05.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:03:24 -0800 (PST)
Message-ID: <26943ea3-109c-473d-818b-2a08dba859ab@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 14:03:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcs8300: enable pcie0 for QCS8300
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com,
        lpieralisi@kernel.org, quic_qianyu@quicinc.com, conor+dt@kernel.org,
        neil.armstrong@linaro.org, andersson@kernel.org,
        konradybcio@kernel.org, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20241114095409.2682558-1-quic_ziyuzhan@quicinc.com>
 <20241114095409.2682558-5-quic_ziyuzhan@quicinc.com>
 <rg4isufmnhnbsiljm34rfdsn46gfpatbsiscynaqtsnykbhnm3@ovcaulkfj4nk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <rg4isufmnhnbsiljm34rfdsn46gfpatbsiscynaqtsnykbhnm3@ovcaulkfj4nk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _oqmdhHv42GmmBFZH2D65SsX6y8eaaST
X-Proofpoint-GUID: _oqmdhHv42GmmBFZH2D65SsX6y8eaaST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=706 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140102

On 14.11.2024 1:10 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 14, 2024 at 05:54:08PM +0800, Ziyue Zhang wrote:
>> Add configurations in devicetree for PCIe0, including registers, clocks,
>> interrupts and phy setting sequence.
>>
>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts |  44 +++++-
>>  arch/arm64/boot/dts/qcom/qcs8300.dtsi     | 176 ++++++++++++++++++++++
>>  2 files changed, 219 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>> index 7eed19a694c3..9d7c8555ed38 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>> @@ -213,7 +213,7 @@ vreg_l9c: ldo9 {
>>  &gcc {
> 
> The patch doesn't seem to update the gcc node in qcs8300.dtsi. Is there
> any reason to have the clocks property in the board data file?

Definitely not. Ziyue, please move that change to the soc dtsi

Konrad

