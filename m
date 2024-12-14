Return-Path: <linux-kernel+bounces-445761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A929F1B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCFD16B563
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF1CE56C;
	Sat, 14 Dec 2024 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M2M2UW1B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B78F4E2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134789; cv=none; b=Jk1oA7VP6voheIqqMPJW3ZzuTfVkRt9w5vkkZCBLYnvIdvYwXSJS9we7WRcS1Bt0V8J2JWkzLtwNvcUrZ5B1NyCaaPhsnpWObvSsyeQaVNkqiC/+3nraiFflkigUbHntXYtCvXTce/BAI0dsPMCIUUS4Jl7txXPV4k+7veQXH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134789; c=relaxed/simple;
	bh=oVdrsM4iSvcVVv59Bq/l3kQZnH2DqSvqGHtaO/V5qFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVKajs9jMWOLW8zMBkVzfOyj6zBGHXneRcybSSXgRwnu6NM46A3+OlDmdi1XO23OAb6RNRPMSmQ397nxirhvncI3Ht0/3BZVZVA4kJzGctZfxsTibHUB67Ba3C+rTrMbsm3SJA801WI+5a+65QYOt3MQDB73srheyBJ4UckObfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M2M2UW1B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBhq6a018447
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	URnOAD7B5WVB2bgpEbRPQyjpSOPc3nHHY920y5f2ebw=; b=M2M2UW1BxPSxaQvb
	anPmbJygF25tMadYTvtItwsBMrlje+k3Xj3EssS7xtfo5wSOWMGTCB2PLLPN4LNa
	tIcTUXlsAxhhqycAACh99VIENndA4K2+e074DMMsdc8gX0MhRshkoej2hO6CScMr
	OE9V16amVfGnvrBVfEhVi+h1HAZT8HKNr2BjLAxUEJnIDoala3dXKJyu45y7Ggw9
	+eWGdfH2aux2n3sDa8r7fG5aXRJqw46tUP/KSyTjf8lOxqK4AMsAeQt3vfWycnos
	8dPnk3GFNoRXRwb46ncs31h3NpDKAvAj08D469Z3hu+9/AeuXdci3LkfzflDLHn0
	sLrOfA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac1k6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:06:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8e7016630so5500246d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734134780; x=1734739580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URnOAD7B5WVB2bgpEbRPQyjpSOPc3nHHY920y5f2ebw=;
        b=Hrnrew9uvP0S+tRRw/DCgXaPsLpLRrJiAHL65kKwJfS5kA92ShuDegdlQggm9tUADN
         zA+/mi6Mjp9x2SLyuV26p+kIAFSULfUTeAVxAnP+rU4sIa67BNUmQD4HorIzbeS5J6r9
         MFq+Lm9Jm0kB/mHA4uXGJd7Wt0vQ07Pl8SOUKcKs+vmM9Cg9iH1NcPmAoneXrIXqWi4p
         hMRkOp/j/mfKEgKN27gYAJmdoKh57muKvhxnAmRn0lUcQMa3Olv3rl2Wtz4W2a4dtGre
         2907oYyvHI7c6MaQVocR8dOaOiyRkr/w4uiSsVayFuoGBNZQ9ZWuD1MFD9iY8fSlmQpo
         t4uw==
X-Gm-Message-State: AOJu0YwO75NBdfhQeZQwOkBoA+n6KKI0AEPiZKsrd+rRHl0EwImuEhHK
	R7xUMbOghOa2fuw6h4u3oYMmAPb3aIOejBf7kuK4V+srX47fTCLahmxkKvPLciNxxfRGtfH4bRM
	7H6stRLD+H85sdo20QXUlF0tTlEId3Vl3jyV7LiBwhm2auDwHGO9G0DYxmx/BNOFuKM4ZFjo=
X-Gm-Gg: ASbGncstfVDwP+OJNSOAelD8dKw5AXAhtfMjt3v275hvUbJKqs6SEaJnEbdKm/iPlR3
	8HMy7sLNCS7TJ4V2PXuIr0KiR+ajdsrJbeCrS4Ob9GkDTCTFqZxEgQ3/OYx9uEwZDfJ+VnmEILO
	N3uRvj18ckbxgf0set33RuEblop7GqJ68lY3CX2qcP8WBGPazMXy+vfpZJ185aO0gxMfzsygT7b
	7DfcjU/g0becL9bKXE5RzHfITFjTWL0YEPZpnTCAaZuA2f4zCcn+Hdm8RDYm7aOg/Brj5KTAT0N
	1Rzlc2y+DMfVlg7h0FeVV9zJ8Ktv8KtUKh4=
X-Received: by 2002:a05:6214:3002:b0:6d8:e5f4:b972 with SMTP id 6a1803df08f44-6dc8ca4047fmr28201886d6.3.1734134780402;
        Fri, 13 Dec 2024 16:06:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4vD7vPLzQ4aG18YUkHITmORVt4lbdTdCFofhZWV8MLNWse7WmiAnMO0rpcbotPtBwqo6Ceg==
X-Received: by 2002:a05:6214:3002:b0:6d8:e5f4:b972 with SMTP id 6a1803df08f44-6dc8ca4047fmr28201686d6.3.1734134780057;
        Fri, 13 Dec 2024 16:06:20 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963b33bbsm25855866b.196.2024.12.13.16.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 16:06:18 -0800 (PST)
Message-ID: <6e9c4ebc-c52e-47ee-b3a5-570e84125e42@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 01:06:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/19] arm64: dts: qcom: Disable USB U1/U2 entry for
 SA8775P
To: Prashanth K <quic_prashk@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
References: <20241213095237.1409174-1-quic_prashk@quicinc.com>
 <20241213095237.1409174-9-quic_prashk@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213095237.1409174-9-quic_prashk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ucL0W7-v8Asi36ZCd0sGNICFLFfE63XL
X-Proofpoint-GUID: ucL0W7-v8Asi36ZCd0sGNICFLFfE63XL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=523 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130172

On 13.12.2024 10:52 AM, Prashanth K wrote:
> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> 
> Disable U1 and U2 power-saving states to improve stability of USB.
> These low-power link states, designed to reduce power consumption
> during idle periods, can cause issues in latency-sensitive or high
> throughput use cases. Over the years, some of the issues seen are
> as follows:
> 
> 1. In device mode of operation, when UVC is active, enabling U1/U2
> is sometimes causing packets drops due to delay in entry/exit of
> intermittent these low power states. These packet drops are often
> reflected as missed isochronous transfers, as the controller wasn't
> able to send packet in that microframe interval and hence glitches
> are seen on the final transmitted video output.
> 
> 2. On QCS6490-Rb3Gen2 Vision kit, ADB connection is heavily unstable
> when U1/U2 is enabled. Often when link enters U2, there is a re-
> enumeration seen and device is unusable for many use cases.
> 
> 3. On QCS8300/QCS9100, it is observed that when Link enters U2, when
> the cable is disconnected and reconnected to host PC in HS, there
> is no link status change interrupt seen and the plug-in in HS doesn't
> show up a bus reset and enumeration failure happens.
> 
> Disabling these intermittent power states enhances device stability
> without affecting power usage.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---

[...]

>  
> @@ -3570,6 +3576,8 @@ tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x20000>;
>  			#hwlock-cells = <1>;
> +				snps,dis-u1-entry-quirk;
> +				snps,dis-u2-entry-quirk;

Oh?

Konrad

