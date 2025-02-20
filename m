Return-Path: <linux-kernel+bounces-523732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A5CA3DA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFE819C0882
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB711F76BD;
	Thu, 20 Feb 2025 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AwH+21JH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8C1F3FED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056057; cv=none; b=jPjQ0DN1WsYvJKtQRhwy2lJITPxmdJbHeEinyvK+nqLLVDwMOhfxB43O1LeM19493OiQHHhrQnVMIWHntd5RrQH465RgKXrDYq3jpXThoAhbSoPstPErHiYXLFqFlGSNOn+mtIbgdQb/lbYtcyRNzDqvE7d2AgLmLQX++LoXfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056057; c=relaxed/simple;
	bh=wtysXMXEuszI0WzVDTD7fCVTSQ2uvWGULw7pEFDQ6ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dN0Mh+jZtz2zMhvLc73PYzLCVjBjC3DHiJcqCjEAzaKW+9qt2rD2GXBKnsWARkc9fSKUzAUPnCSMVWq7etaHPIQ2nTu9BmVEihU1cxbOrMHuE1RsarCCLCwSWWaLcQUfGokIAIV+qF0MLTXzVYJsA4QVCHT15mFxFY+8dcW7PJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AwH+21JH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6bvid012007
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dLlMw77hmV78xWDQ3iOlCxtFvrcHCYcUl0W3X2jB4N0=; b=AwH+21JHDoT+3XEG
	wHr3bzatROJCIaap+4cfDPuj+/BP6GLaZVrVgC7q+UKhJCXa7IkQaMqVrp5NUUNX
	Tc/XWrJM2L5W+rPy9HQFG4LNlrsn3WOQlIjPwBstgWAG6NlkFG5NXWQFmrPDTb4e
	98Nor55U9uyKy4uBZDc/ZosaiFugrarGea2rAWZsUrjA8jNlRdC91N43Ywxgcy3f
	xOfBuFrzK89aVRMlRpkjoHP94Rkx5B/9OFFpD3uWGsudp3+vgF7/tNKEuXfINB8u
	jrLJZ6vyh7wetWjnhJ3Gb3wda5S7PJZboEmK9LH119TexkQL9t5HWU/YYQ8r4qkr
	MJ25bw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3p4bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:54:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e65d6882a6so519326d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056054; x=1740660854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLlMw77hmV78xWDQ3iOlCxtFvrcHCYcUl0W3X2jB4N0=;
        b=bpc0xfZFm8z2b3HR6vSek+Mz0cQulS2JmS/z+HrEmhx7EDw/2invhFes6LNlA/j7s3
         E5hJZq1u/Ag0o5kzWOxG5CV2jzpMJ2PcPCMqkZQrOnkuRE5sQKlCdTtxGHpJsauU8PB7
         C/qL9CyPcqtkODN/YGWYzTnCPAvIATG6rxsRgomxFotP8qqTvVdMvp/uyM8E465CLALv
         qlfll2xi0HTahg7Tj0eD97I08K1LfHu+dAVoMsxYgL8VH/kANQpm/Sy/3SmWu+6kxT+A
         ojpWysl64ZZUYFa4KPBSmQoqZPpgY9iZ2ypBYZoaoOPxE3EurwJ++lT8jVIq3t67spSu
         51qw==
X-Forwarded-Encrypted: i=1; AJvYcCWIVc2UbhYweBk4ksL/a9RuZiYm3nixRlr/M5TrMDPA9Hgdg6q5OX/9c1yGbiTnSjWZu3DmOiujlp+xGRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKrhIByPJdgFaPskIukGGo92NDe3zcAbYL9iYJ7h6fq55yv0U
	Q037r0H2Ep1evUjNohIhI1iajoVD4Z4Th/K2/HMtiR3jprABMcxQsb64gGciEssSdj1dUJ/eZN+
	+6bZHiVeVgvZm6yEQz+O/z3hkJwqFFPMvHLd9b3m+ij92gInV9vDk1KIdU5+fu6Y=
X-Gm-Gg: ASbGncuhYPraJ+NdJamv0Uw9o68Acz74xdnVqcCQtjnnPYjjxI7Uyv3kiojAlYKlxVH
	XzCURpuUOmdk06qHHAZCzL1Cr/DWdpIKmU1XO0VQnvyQb1saAGSOZQIEwO2QLRuCWmCWEbeE/Pg
	ZKGHb/Isf7oSGxxWi4apAWcLA2JsLkne/RlCGN4P2h/KrjD6GfKj0DpUvcrn0b6jtEnagJBVWki
	PlFIkxehfNsN0mNiD+WPMQasOSoDlyJIp7FIVHfiDuxcqS9Iuci0A0xcD+4ztNKf+MsXUzlogI3
	BHPenxuWGdYnd+J89CVnW/L9azYDovWEL/eX9tP7L3zR1IwCpoAcp2EvH8w=
X-Received: by 2002:a05:6214:21a5:b0:6e6:62e0:886e with SMTP id 6a1803df08f44-6e66cc89028mr120422556d6.1.1740056053807;
        Thu, 20 Feb 2025 04:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnptsrzjppKeiLuln6O8nckb7GxCd0auF1qo9TE7xd//kh2rJrmV/LSsCVduCWI14Qxlt6bA==
X-Received: by 2002:a05:6214:21a5:b0:6e6:62e0:886e with SMTP id 6a1803df08f44-6e66cc89028mr120422386d6.1.1740056053395;
        Thu, 20 Feb 2025 04:54:13 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm874850066b.161.2025.02.20.04.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 04:54:12 -0800 (PST)
Message-ID: <9dd5f28c-3ae4-4fdb-b00f-8558f756900e@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 13:54:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: qcom: x1e80100: Fix video thermal zone
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250219-x1e80100-thermal-fixes-v1-0-d110e44ac3f9@linaro.org>
 <20250219-x1e80100-thermal-fixes-v1-1-d110e44ac3f9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250219-x1e80100-thermal-fixes-v1-1-d110e44ac3f9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jAms6Mmhxy3IxwoB73EDQEU4XJKxOn8G
X-Proofpoint-GUID: jAms6Mmhxy3IxwoB73EDQEU4XJKxOn8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=942 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502200094

On 19.02.2025 12:36 PM, Stephan Gerhold wrote:
> A passive trip point at 125°C is pretty high, this is usually the
> temperature for the critical shutdown trip point. Also, we don't have any
> passive cooling devices attached to the video thermal zone.
> 
> Change this to be a critical trip point, and add a "hot" trip point at
> 90°C for consistency with the other thermal zones.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4e915987ff5b ("arm64: dts: qcom: x1e80100: Enable tsens and thermal zone nodes")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

