Return-Path: <linux-kernel+bounces-552666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FBBA57C91
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5993B0AE0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E5D1EB5C6;
	Sat,  8 Mar 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TKkITgoZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3F1E521E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741456695; cv=none; b=Xcr26f0/1xv3fug/LccW4K3QEKvqj+kGxv011oasD9ALa4bvYJv2uTz0uZmcrwdKp2iRP4mXpPiHCrt36BvfLv9uAdGYyhvq2AllvcDZCWXxylvHjWDM1aRaMAXqsztBjqFttDz6DYdU8+msCGTYNyGH56RfoMgEeg7J3fG2nWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741456695; c=relaxed/simple;
	bh=DTwxP2GW5T7DulwloGAKdjS+EfeDO0vUSjlUc8CnGJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCkpHU0U8ANmPhwdXLvyFKT4ICtznxaarTtaDqp+gCHI+ljelhzQHwvSm9+Coa+DwdH04MT4dQ770lDKKVKUfCGBs9F2wdW8YMWrYFwvvGlu39Zq/G8Ea2fEmluGLKvniCdQ7jShIxEiu2ujfRfmHEyZfn73O9pIMO24gKGEqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TKkITgoZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5287Uo4c003480
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 17:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndoPm+wLhTR15mIqP6fWmUhkHpLNXcNulvnJ9Nq1v/g=; b=TKkITgoZ5L62rZPh
	bz6Cplt1ieq0AROpN2hdXQWHeTuRwTYQKxfMH+TnThQGPfL1NujmXxtuk+TFoxdH
	2jxpLTU1DvbfM0cuyAWVIw47k7oJxps4RUtk95J+ISoc2ppJx19X3cfTe+6pFel8
	InG4pzAd9SlsNPdHlcJDDOWIl8qG7OK8ZW3eJhSHdtGNDcM0DCiOdsLzjz/uTb3L
	OQ+0GlUvvFM47IjN7ABMpOd9cIX3RQhUsORuSnXq9kwRQLgPZt+Unmn9s+7xjzsl
	6ajTKzg8oWBrx7xzQQ9XWhleQPTG21AxYojaLlLBgRao688FBt51UiRXZhuG92nJ
	AxS63A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f6a8wwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 17:58:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46e78a271d3so5180191cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 09:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741456691; x=1742061491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndoPm+wLhTR15mIqP6fWmUhkHpLNXcNulvnJ9Nq1v/g=;
        b=OkXjrUSt8LpvgIKBB0Xjp7RunCQOZ/CBBZ+mhnRTS5hE60Rdv8KC2WQElZnmZV8aKO
         sRByDVgbJ1u3I6tLNYH8wDoy0MXsyllvsD/UhEru9WJtOz/CFuulaCJ6ios4Y1K1abKg
         b1HNiMzv++OnuT/YqUwbgEVKAPmkAtB3LtulIxVsWLkyA1ympP2xNO3b2qS3p5o98lnj
         iuYYjAGciZfx1Nx3tpxImyfqYvMS2fyM6mX3n5gIWaBhLG2zJJ14Fh2XbK+OinUebxTH
         2I+VbddyHBOPoAjWMKpO/I1WK4ELW6FGy/8H1hE4y689TVnRx70U8VAn4/MxrHmg4u0t
         jdAA==
X-Forwarded-Encrypted: i=1; AJvYcCUntv5BSun7bH09NrP+GUUuW3UzEUwL/3H2a75HuVLfN1GM9rN1sx53s/t+7qGmRUt/yFcle+SvSLEsqak=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8Nvi5AosJjUsUjJl/dUNc9NJ5WtelRNjL1Hiqg7W680YMyDO
	FDCfEyvm6sTXy+REcuRl+bE3NsOnJGc450jIAOqdj3bpLK0sljK4VLKsW8m8VAnwJ6VS/P4HSh7
	wlW3Bg5WR2VhZw8nyjaozjMDwuyEsHI9o56aYhqqNoVgY/LlYSV1OKOjPyn0fJT4=
X-Gm-Gg: ASbGnctFYXs5AJGj/plKdUw1ufZK8xFEEKThIkhexXywtjy93+hDhEwWIhSUGx/+D05
	U/3fK/LK8AWjqhkMkxsr6O6KfHrU8hobQEzH1oaW+ot9b9pdssFO57jDGVWTlVVzjaD3RPaRTbw
	BeM2f5ySspOaK166fGUERH8pqpVUyo9+5fbl9MxhKTcVq/cgrxIPERR0Diuzs0oYbe/uNwOG10p
	orK7vY/fxongFK80ttJjdLW+se0HxFuRRlM9rYGJXO8bTFaQQku0P7A7Af0ttW/8yWlnXZcIpX5
	yxoyb2fVe8Z7nKst/Lk8hPvQM23/xYq6CppJO5dzn0r+0kNlweJzQhNvNkblu0QbDQyOjw==
X-Received: by 2002:ad4:5de6:0:b0:6e8:d9b5:4131 with SMTP id 6a1803df08f44-6e908ca81cemr18109306d6.4.1741456691239;
        Sat, 08 Mar 2025 09:58:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwWnxVYC3JH5zrCZZSA7cwgUX9Nj/k5VDUse5wQOlChTKjJAlW3O9RMHr7yqSsRMJeeDCyQw==
X-Received: by 2002:ad4:5de6:0:b0:6e8:d9b5:4131 with SMTP id 6a1803df08f44-6e908ca81cemr18109196d6.4.1741456690860;
        Sat, 08 Mar 2025 09:58:10 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239438117sm459641466b.26.2025.03.08.09.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 09:58:10 -0800 (PST)
Message-ID: <27c48f41-dfc3-4fb0-84f2-c9123d2fef56@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 18:58:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] arm64: dts: qcom: sc8280x: Flatten the USB nodes
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Saravana Kannan <saravanak@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250226-dwc3-refactor-v4-0-4415e7111e49@oss.qualcomm.com>
 <20250226-dwc3-refactor-v4-7-4415e7111e49@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226-dwc3-refactor-v4-7-4415e7111e49@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WsDRMcfv c=1 sm=1 tr=0 ts=67cc8534 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=08ITDv3IiRPUJx8zK7wA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: ZzDIUrHzX5Y3PPXTbV5srUrVQRUkpA-m
X-Proofpoint-ORIG-GUID: ZzDIUrHzX5Y3PPXTbV5srUrVQRUkpA-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=723 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080137

On 27.02.2025 1:17 AM, Bjorn Andersson wrote:
> Transition the three USB controllers found in sc8280xp to the newly
> introduced, flattened representation of the Qualcomm USB block, i.e.
> qcom,snps-dwc3, to show the end result.
> 
> The reg and interrupts properties from the usb child node are merged
> with their counterpart in the outer node, remaining properties and child
> nodes are simply moved.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

