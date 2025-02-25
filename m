Return-Path: <linux-kernel+bounces-531174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DEDA43D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A509816DB47
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898BC268FE4;
	Tue, 25 Feb 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWr6hurJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF5268FDB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481611; cv=none; b=Yh58ETco5oeoijwdfXKy0PvkrL72m1umUPfx4nXnld4LJ0EQBe0HN398auGL2YDxIj/4rDRmRA5rVn8wCZGxaWR5S2NsqvvbA5E6HUNhzb2eG9f711KAQ3wt/P3W54n2viegGHVGGZrVNOGRYk+63v/tq6JeMQDSUbybmzKMJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481611; c=relaxed/simple;
	bh=XkYGmuqddTj8oK8dZdu+4fdiwObTc32dreqIG6VgV+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNctNbrtI/y3yEHfzyd2Nej1Y0Cm6MG/O/6OiyTmGORbm39hxTbVNtpSLQuk97ohAhrXbQfTo16eTX57V6vMYPPa7Vk+fTEM26neVT59xX2606PvRKrcfQjG3NniaMZjjDK1dAlu7kFZlNK0gLEJ0xDDQYWhpn+koHD6szoHvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QWr6hurJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P4EN8u002485
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vmr3+jNBVikraxFllbzAvshxw5rAgQsiv8Obg2rHUPk=; b=QWr6hurJNwqzWRwI
	XaIRMvmFWUTXnrxp+r0bAIMTGeiXKQdkDEPOQo9CUVeHFyFcwhVEdfvhXygbrH2b
	veOp6DCBQe99ImpwO6h9IqA7FPKpL3MKZyOTMhYxE1SsunHDDEnCorPBGRfLshgG
	TWpVXSwAjMllqiJqjXkNqnu6hBC42gWrt9DyetYViANSyHpDWrinQjPRq5In+nV6
	vaempD08q3SSvgsLEzVCg9byQrWP+qmITZcVqb3dwlnnnJ2P+j0P6Cn/3IZ/WoIR
	isY0mRs6p/NtY+qfoTZx8jCRiCQH9a47rmyl6G8/eUFMTY73Er2nY7/8IdDg1+q+
	nhKYIw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4516nm96mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:06:49 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e662a02f30so16148476d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481608; x=1741086408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmr3+jNBVikraxFllbzAvshxw5rAgQsiv8Obg2rHUPk=;
        b=M4R5h8kimfXyRxS1Bb/fh+uY7kJO9DJSVZJDqUku/uOmvswAbiYcke6/pRgCqFtSed
         J7FuNdJvW2U3TC+yRN1Xx8gfBlowNmeyGBSQAe+5pR/Ov1yCckhUa1uOheZdocTLAb78
         Yt4uHlLU9BH8hchPIFu1PytX/gtYTUXhZqfaRc42a+3DG2Vu5KRUEOR87jj8vMIb+7Tg
         rEqV8hojB2vkjdzdRWRopGvkckz5plEIQT7EIiIDTquBYC5VKHRhNZSoffp+DUko7dmM
         HD0//+ym3nGsoAO5u65MwVLbfXSvGZiCKJK8EjDY9wa6YK1XjAQgBooGTeb5Dr9Nydv/
         Rcvw==
X-Forwarded-Encrypted: i=1; AJvYcCUeDsqwtxe7Um0IAWGu4YGLO+9CfbRf2LzKV1ZAsMPmxHExcURcUTLzdyNeFkZ8jM5tY3gG+4ZbzowX+fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9upOmttBsLFL+CwO3YiZJMynLECD/leW5crYD/JXdlJbbb+f5
	dtA2ahG3u0Y/6spvaoTcc4S7mkW70wJk4xkHz0GTJtwxLW/YjMHcxAFAwV+CRM9gwIzYnlX/fGG
	DtUF9lC71fLDYhdirLOcvxhu+N7YwTi8wPLkb69yPYDGEMoHTb9UIgHCkz9aZv98=
X-Gm-Gg: ASbGncuovHIpjPQZmy0wcpqIi8c1+UAm4vpPIt9BGJqg+/G+h568/Se2R8lDE1dDkU5
	VuwURZCP0MgNB1S6ICwCJVTBLPkD0cZD5i8/+us2nGDBw8s2KEkcf6zZJDespUANPXaY8dp6Xe+
	q9uutRwhNsAaTTJjzLJiWA5IWpKTVrN7hVOm3flKq84056XQRdGRcac1i+LPWInAUvwi0tJ7hQ9
	XtMQtTDHhHXVTGpcCCXCp56AqujGhv3x9ysfTaradmRzroaRfw8xe0MzrQ1KHemwrym7xObFQEZ
	fS09v8TJQpOR0eB3fzI+o4FZ/MqnzcyB9Or/ULSNqgE06qGe8W2cYjutkOPfNBXOKjBE8Q==
X-Received: by 2002:a05:6214:262d:b0:6e6:6a6c:79fb with SMTP id 6a1803df08f44-6e6ae5ff006mr84483186d6.0.1740481608161;
        Tue, 25 Feb 2025 03:06:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpCizjt+FZyk8bw+ARjsYXsPjZ8AeU9m/iRlA2SHZyfGOnxjBSvYobvw7U/JUAWrjEvCtKuA==
X-Received: by 2002:a05:6214:262d:b0:6e6:6a6c:79fb with SMTP id 6a1803df08f44-6e6ae5ff006mr84482986d6.0.1740481607816;
        Tue, 25 Feb 2025 03:06:47 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2053ec9sm122476066b.137.2025.02.25.03.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:06:47 -0800 (PST)
Message-ID: <253c497f-5c52-4f02-a477-478aa3ee35ac@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 12:06:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8750: Add RPMh sleep stats
To: Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com
References: <20250218-sm8750_stats-v1-1-8902e213f82d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250218-sm8750_stats-v1-1-8902e213f82d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FUxZfXFuXZWHp3yZatMMJk3CI3oWrTU0
X-Proofpoint-GUID: FUxZfXFuXZWHp3yZatMMJk3CI3oWrTU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxlogscore=919 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502250078

On 18.02.2025 6:51 AM, Maulik Shah wrote:
> Add RPMh stats to read low power statistics for various subsystem
> and SoC sleep modes.
> 
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # 8750 QRD

Konrad

