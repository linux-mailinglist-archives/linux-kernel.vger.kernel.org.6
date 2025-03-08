Return-Path: <linux-kernel+bounces-552662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0D8A57C76
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2C016B165
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B251E832D;
	Sat,  8 Mar 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hr8zAAT7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1387B1E5210
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455882; cv=none; b=pCBIkeRUqMX92A3d+i5ShB5Lsp9FzaUQ4bsd4OMbYQAmMi04myVNKCZC3FxtJtqCNsys/kpea4tN+aDftgNBkNutLCcruEibvt2pXSYHOlMjy2uBjq2P4C1UvdS3pVGR/5+gsXMpwC/3rzEBGeUJuk1zt6y2PW8Fj+O+1PvicA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455882; c=relaxed/simple;
	bh=q5uR06cY+jAnDp/h7Pi7MuljuNi05KT1CKa+bgbKDWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuXEBuknesDBdfSQHDE13G/VzOHcMP/cOvn0Qt/3yjeRqol0FZCltQqzAYCByZwMwiPaD4uwXCHlQ2Il2Wf/u0H5El144nO1QLKevS2EsBRyds9ItYeQNKvcj7qNy69Jn2gzuHalZa9g13fH1HhRzdrQhC0GeoP796TKbiW302o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hr8zAAT7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528Bo3gt022465
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 17:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OLWsJUYVMSW/2p1uHoMFxNSZXw/knEpq6SZxmuPMxgk=; b=hr8zAAT7JxWPuumA
	0dsejk28swJhxG9us4KApZ3HAH0vnZ+JaaKCMdX5DQOKTv/SbirUDTXP0W9Tr2zr
	HI6sBMBkcylxyr1b10qwAegmq5KnXUUAvfyEmLiZrH2GUhbyGv31bAL4HmuPSOXN
	6i9qzqbXKTeLdM/J2rpzG05uSsdY7D0FOHy0BrjV7SNO5rytaH9Wzpa2bzFN5bTQ
	5aXvtt1gM0VsYs+qPqCFlIjyrMpMoFJiD9wotMAc5LOxPu4yamIW9JC4nNueiYUr
	rIhmttB/tUQJVu8lqnLoi5JDSGyBNmDDZNGiNNHYgP317bj97ddZhGR5Fkvesk/V
	Aq/+UA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f2m8w6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 17:44:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8fec7ab4dso6185146d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 09:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741455879; x=1742060679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLWsJUYVMSW/2p1uHoMFxNSZXw/knEpq6SZxmuPMxgk=;
        b=C/6XaEYBL/8RFD3NPnxvn+5GV2NN0nyC7D8WLzkf9sxRxZUmcj3NqGtsM9ZvoY/9gc
         cK+cQwfXcYaVKzYD5VIH8WsQz5laWn3zUUMNlfvd+2YlfL/wueUOPTMU81DTfDkZ2DVv
         8kLFxFvNjgnBrm4O9BkX98fnXVabhvC7bp019+DnBJ9lwtIDwKOUAxgxgS+9sREOxaIM
         CrE1lotJv+KZTHMjDZho8LBFDB2Fyq/43ilJdrJ120FUmE/0cM5aNEgOFYVFnrpA4ec+
         o/N9NN+tEvGMJLGgHQpTnUpP2vKuWyShcg+0m9taPw1mlG6TMT6HAkDbwQci4s76XtZ2
         Y93w==
X-Forwarded-Encrypted: i=1; AJvYcCU4+P3WilD7LIrVvEMovLmqFu07+HYgsXiYybYioSPE4o4RuAUmX16R14oc/QmaA4btnptge13nBz+M+qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx90QZeg17Pvht+d5vCVCJ9GaWLB35+tq7l+86l2lQKw3NFjVhy
	XvqPlLSkNPgEhfbmLg+eEwTG3Y3lq3ZXnAttj8EjVzkU4DguigNhfKKsVtKnC8HeI5tPHJgSRmP
	dmQrvAB4A7e7d3BJBZ0FV+0XSEhpN+BaGMRI02L22VrO2ivBe4jcPU6u4493M1cs=
X-Gm-Gg: ASbGnctqxfdeC9NwF+CqvAxYLzPRIW5B+BMwocBf7UXLMon9FPUgh1m1JMC4NbIAJGF
	2yt/lL/HA7TLiOraA4Wf5V897Q93vmr8syb45+w0mKlTtePH8hRDiPthkomBuvAovLykbNxBOFB
	1hqMVRl/TW7Z7o4SIUK6V6rerLcuF5Y0M3Z9RhrCjWDoo71rupVWjomkoLXFN7KAadvk24m/jih
	tZ15WLSOJvVENfIZmqc6UDQysw/6TovZXEWEmKFH1zJlbZuA3f8YrYKaccjgE6bGbQVsfjg9EFS
	aGnDcWrsXL7nuAnZt7IjpPNrZGIHNW6oiLB/YkhUplfmod1YvetpcIIv+x80/ZcOkgX5iw==
X-Received: by 2002:a05:6214:2b0f:b0:6e8:9ed4:140c with SMTP id 6a1803df08f44-6e908d5c1e8mr18056526d6.7.1741455878895;
        Sat, 08 Mar 2025 09:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLalPszjzFHr1vq7EvScP5oSkuDVHvvjG4hrxJmmcS9aB7d9TRhg4dfW47CYFQsaxmjCd1ng==
X-Received: by 2002:a05:6214:2b0f:b0:6e8:9ed4:140c with SMTP id 6a1803df08f44-6e908d5c1e8mr18056276d6.7.1741455878331;
        Sat, 08 Mar 2025 09:44:38 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23973a74bsm455697666b.123.2025.03.08.09.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 09:44:37 -0800 (PST)
Message-ID: <028cb159-badd-4dfc-8a67-35f12cb1a720@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 18:44:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] media: platform: venus: Add optional LLCC path
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
 <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-4-279c7ea55493@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-4-279c7ea55493@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ouA_oPY1Y5D1wBMdv7YenfRIzjVI_zaB
X-Proofpoint-ORIG-GUID: ouA_oPY1Y5D1wBMdv7YenfRIzjVI_zaB
X-Authority-Analysis: v=2.4 cv=ab+bnQot c=1 sm=1 tr=0 ts=67cc8208 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=lSgUl_dL9m1uDwSaNSYA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080136

On 4.03.2025 2:07 PM, Bryan O'Donoghue wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
> 
> Some newer SoCs (such as SM8350) have a third interconnect path. Add
> it and make it optional.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Link: https://lore.kernel.org/r/20230731-topic-8280_venus-v1-4-8c8bbe1983a5@linaro.org
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---

I'm not sure this is any useful without additional code after all,
as the LLCC path is a subset of the DDR path, the downstream driver
likely just increases the bw to LLC itself which then may be
a bit more slowly

Konrad

