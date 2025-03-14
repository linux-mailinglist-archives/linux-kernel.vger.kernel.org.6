Return-Path: <linux-kernel+bounces-562241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E313A61FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCD64627CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B996205AA2;
	Fri, 14 Mar 2025 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AzKToMXi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76992040A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989637; cv=none; b=JrG0HC5I6efXsSoafBz6iyojXWaXXteSRXtZsX6vdfvd/AvrPUDv3wMI52D0WElcjSLCbhbyfMRWa3VRcFrNmS9rFijmoBOQQ8mhyEFs2p6OISZnMrcXFgBZbhA4pokWdPuV7qTtjgQ+rsRykGh+2UuyqomvJW7GJ8qmTtoXnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989637; c=relaxed/simple;
	bh=F02AKkUaTlzJK4g0YtQD8ijiADWt6Tzos2Yh5nMglHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJW75LcQIer5KGRa5mil04eh6jYfM/veMR4d8iLWAzo4MFHtwhTubJQFyAc59iBYJi3qRYqBgatN2T6wv0gl3IKncceZfWCJgsdk5k3eZegQ+y2DnGi7kiA4MpI/wgGLCxMZWhtLHZoC+XYRLBLnetz6F5KBTlWKtwx1ShLveSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AzKToMXi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EDu6cV024861
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+S1x35o0+RphZNHTGFMos0lvmrnsghifnHcTnuDmnCc=; b=AzKToMXiceXu5WH8
	rnbpcAvdNZBQeGxEquwC5vVnpv3mYBzEaCHcBsXBEjXFubWxUWFkGzEvHvzEaEQc
	ItoAGKPfaelzkXerZsNQY2yIT3Skp776q8pG6th6QIhPou0ZG+gOoggMkO8wio69
	z3NLYO/xw8cYKfjZuZUVu0/WUj0w5G9wAihEtHVeIC6WNvkdow4Syw/siVRoaHpx
	eyiMekciYS0Wef/zPhEzxH9o2VH4DLQUlsYS7h6/oMqAc4Dw1Ch8jLgZBfo4wkl3
	xMrkcGYRk8Dp566g8SLStvZxb+zXPfLatFMpjMzrWp1JTtWb8d2Sujx899A9IAYM
	fCJy7A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45cnscs8xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:00:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4768b27fef3so2944031cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741989633; x=1742594433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+S1x35o0+RphZNHTGFMos0lvmrnsghifnHcTnuDmnCc=;
        b=oMyubArhz7pCRRdJ2HTkeJG1ibOuYF02VsPJ9x0zm7ob6eTngLmVknPBhhKiYu9/Zu
         VOHodmT4dBhCdUOHGhLi8gL2773jPtUQ5snQZCLjUXHL4MLQpdnscZSxmG9JjRG16BPH
         B+oe6Lp1YgulbTNlLtCwBzPMFrQR7a6RtZ2tRASfL6Cmetcwwk8sIz8fZ4SEwaOpd6sw
         IPO/ELf/W/9/HrhW5Xqbjz8cRwHKwoyDGhQlMGtdmzaJheEAyg8BTuAm3Vqiri/w88yX
         ytbYH/Op1UysMWYaHj4I5gyvcfcf2900YX6cfP46QQ7aWcegWiizLdPmBP3/J/+A5h9r
         q4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWl9DQ4FvDiTg4pHnmvc/GuvxUFmuJbhCRYPxKGcSlp/me9eYn4u+wUW6jsVb2yjTf/aAjfoaEJPnHZ3zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCroxC5c4Z5pc1bUG9mlC2Izeo4ooAeFubEK9lre5VTs0OcdSo
	ryCMBtAuUjpoXuOWwvsH00ue1rvKTtAU8kqgOJ9DameaBVN6LHO9S1/FOaAdGL89xXZBlNILx43
	M4rrsgjE82T96k/Oqp6O6BL3WqQpO4i3PR+UabtrisSq4lNjSgcmbOWLlULbV+Rc=
X-Gm-Gg: ASbGncuHp+MibevDLR7Ya9+Y1BXst/qOcwfaaKokFj/HTLyzad1zEK3DKig1E0pPnx0
	NAacZUCjlmITGfcVZtFCrU/dehpW6UBMbk+NwMM7KHmomg7Oqze5acx/auEpteaxiVIhAzP3QV1
	Od5rdJPwsbFvVryziSUKgcCiA6Ba5GsSLdeS/kxEaBQsWfDmA11kntw2DoFS32F4mGJmi4FyOie
	ZQl90wniAeP7z5hcwW4cd5JVR8CSZcHyV0GAsag82dM98ygHd08HkMcntH5S0Db8MEIVbXLXjvB
	rA95+ekvP/pqtWVGJUWrX8LW493qJQaP6LF/1ihgbZdPY/BlouNYDEpAHBJUi/L62ej5pQ==
X-Received: by 2002:a05:620a:1914:b0:7c3:c406:ec10 with SMTP id af79cd13be357-7c57c92fb9fmr229582385a.14.1741989633709;
        Fri, 14 Mar 2025 15:00:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHihXQb37dkTZP33cmAIecNe94bbPFEDLSIhRXMbiQi1aPGV4bULdUCeeXm3pISvZTk9kv1Kg==
X-Received: by 2002:a05:620a:1914:b0:7c3:c406:ec10 with SMTP id af79cd13be357-7c57c92fb9fmr229579085a.14.1741989633255;
        Fri, 14 Mar 2025 15:00:33 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aec15sm277125666b.34.2025.03.14.15.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 15:00:32 -0700 (PDT)
Message-ID: <c5ead68a-f108-4e73-aea0-d6cb562092ac@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 23:00:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs8300: add the pcie smmu node
To: Dmitry Baryshkov <lumag@kernel.org>,
        Pratyush Brahma <quic_pbrahma@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250206-qcs8300-pcie-smmu-v1-1-8eee0e3585bc@quicinc.com>
 <aau6kgdbsq5mu5h4kqggzgua26o7dwc6hbkpmtgcnqx5dqhlgd@qcm2xzr64fyg>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aau6kgdbsq5mu5h4kqggzgua26o7dwc6hbkpmtgcnqx5dqhlgd@qcm2xzr64fyg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Qbxmvtbv c=1 sm=1 tr=0 ts=67d4a702 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=vlatggBPyhKtcxP6hQoA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: APiqW4PocVsgIb2pprLoz-HeeeGIE0wW
X-Proofpoint-GUID: APiqW4PocVsgIb2pprLoz-HeeeGIE0wW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_09,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=724 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140169

On 3/12/25 7:53 AM, Dmitry Baryshkov wrote:
> On Thu, Feb 06, 2025 at 07:13:17PM +0530, Pratyush Brahma wrote:
>> Add the PCIe SMMU node to enable address translations
>> for pcie.
>>
>> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 75 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>
> 
> Reviewed-by: Dmitry Baryshkov <lumag@kernel.org>

Please hold off merging this patch, there's some internal investigation
required

Konrad

