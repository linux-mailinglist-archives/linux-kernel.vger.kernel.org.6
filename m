Return-Path: <linux-kernel+bounces-443562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DAB9EF61E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CEF28CC52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616A4222D46;
	Thu, 12 Dec 2024 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HjesebgB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91A216E2D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024153; cv=none; b=h7Vvgn7uHtVmCf5Nj+GGG0jdFvZmqbEl8JAX2eXzB637O7mw0w9TB9hPfPPZ5ikQ4TKriikzvazgxzJBez9N/AJAkxZFZkW8Y1yypGCRZEKSCs6ibKnmNlWZ+0R5bC6hoH1w/GwlyCPL8WAsdA+NjM9jD/eiElzVETh+n9tSEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024153; c=relaxed/simple;
	bh=RzhQRZVFYQhLnpEqkHEQLdhOVQLxSSPFxiLWiauqBoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxvIZWYJBVpAbF9GwH4Qbhk2afyW4Pe7orLohTGvu5We4gJ7ym7aIWbAnTsEf6mdpWH9buWtZri3twGuVygNq45yoxHEBwTFoJN0X6974lahMbSc1d5LnsBmk9mAACrltMGf02nR2+Fu9djHZeUNSGQOLvwsk0wpe3GIaAupSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HjesebgB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGVOTp015216
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXI/rMwXSEtNCPJzmcPZTN62CU/qS5wBtOEw8hBRpg4=; b=HjesebgBHZtRhf3M
	VPqsjiVCwCD6w7SkCqMshw//P2dgEPvm/RdVYUt7SLj/m6tK+Y4Qg8opOCXPnRjY
	bjk0x3fR9G0y1a9nZGCvPIybQ1/ERSafIVxMbFtatoUOAuTPdqwgK5RDW87/tT0W
	+5Mx4D+2+SuI/6VJL/u46vAkuwL3IwzjA4sInrzSWdRxKQDKnEc3BHPT9iJkmxlE
	TLGGACVeFvaBoWvhP0XVDPcq7OZYKETts4u4xt4/hFs4rPd2Z7KhBH5PcM64dbhF
	jTsarWDgleoepFHWYN4bOdk2pAJnMQIrOBejRFWIJR1ZoDMzIPZbMwBYe6vCbSR2
	A9ErWw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f7dpn0tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:22:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-466a20c8e57so1823181cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:22:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734024150; x=1734628950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXI/rMwXSEtNCPJzmcPZTN62CU/qS5wBtOEw8hBRpg4=;
        b=dOQXPrCwc3j6V3FdcPy2B3AfrxlJX/6hB//ZHcZGX3stBCAcShrE4LX2gM0oK3ZKEn
         hLfVvvuN+3BW7Pa6CTCjRCpbR7AMzaGCwe54k404OxL8CGRtzpitXPUR2nEE4Z5kwT5y
         9ntDtt/lIweDiqBLHvjvRa1oQPsc97JW4Nr7WFq/1YKcESijBS94jbI4GFGw8urH2zRp
         F64TDzRKljmHTfQ66zfnr2aEVC2eaH/1vju4grYnd0G3LRkos98deD6PgsLKx/2C/g2D
         S7G935QsS0wwem9SA/u+Y2yPyutg4QR0yhOmK4s4c8mBoQ6t7tabqbDHQhWHhoOXMW7P
         BfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaEei0Kg9r9kjSPYDo8xX7jM6FaNJwFTUkfPH6k4ZxyN5gknkrXho+xFoSkQwZ0ZHPzrgt9pAVUpqxj8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSlB3hfFuOblOp665sNXuk2Azdxdn/aY62icRDDK7i0+bfqS+
	u+WluNFgaWdIFqqRfryAofeGCE77qSMNBWDS5Wooi/AFO61lx3YZ8GX6yK9mFw9q9+paw2iU67n
	q283dqHvAR/BlyG+7kvPkHMAWR/+yehC2+1OgJnAY+i8cUFm4MYa6GGexYxIBZWc=
X-Gm-Gg: ASbGnctZwx4yiig6eHAWJVrxen8c+BK6Gk2YwHvBVa31bkEmwuynUA2+H1cdVwTX5Va
	U5sIXkpOgdoDnN6cuhIgIX6LQe3aXk/3PLQXvPKYlfz17leJZA1tDRPux5eG6yXR7U2cInzy9w8
	ec9Kf7zPn3AhL/5l8Lalvl+4l4Nxj4S9+aU69Rn5tBcqJzKNARDd7Bc7dnDBiV9l4N4vW9MgMFR
	fHVPdLZxuc9UhV4S7DOZ1QmEHO/kkpPnrb0f5WMRyVpKw7Hs9wBvtbtj77y37Qoey45alJoo/Ct
	4D9TKOXGunQHKi0/ZNOJfhb9TTUVsBO04nzWpw==
X-Received: by 2002:a05:622a:14cd:b0:467:5931:f6a8 with SMTP id d75a77b69052e-467a169b447mr6580041cf.16.1734024150516;
        Thu, 12 Dec 2024 09:22:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHudtOde+f8IPYAkK5rDmanvroRSGDkZDifNKDKSR1bTTXjCRopc+9Li9B48WzjRmEYTZPfGA==
X-Received: by 2002:a05:622a:14cd:b0:467:5931:f6a8 with SMTP id d75a77b69052e-467a169b447mr6579811cf.16.1734024150105;
        Thu, 12 Dec 2024 09:22:30 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3df2fc65bsm7743885a12.54.2024.12.12.09.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 09:22:29 -0800 (PST)
Message-ID: <ae57068c-5d73-459d-b319-46a582ed7f3e@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 18:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] ASoC: qcom: sm8250: force single channel via
 RX_1 output for qrb4210
To: Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org,
        konradybcio@kernel.org, konrad.dybcio@oss.qualcomm.com,
        andersson@kernel.org, srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
 <20241212004727.2903846-15-alexey.klimov@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212004727.2903846-15-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _80mTPtbo7qjqJ_Dw1k6M6PXbNYeweBS
X-Proofpoint-ORIG-GUID: _80mTPtbo7qjqJ_Dw1k6M6PXbNYeweBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=773 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120124

On 12.12.2024 1:47 AM, Alexey Klimov wrote:
> In case of mono configurations we need to enforce single channel
> output. This is required for audio playback on QRB4210 RB2 board
> since it has only one WSA8815 amplifier.
> Implement data variant for qrb4210-rb2-sndcard with
> sm8250_qrb4210_fixup_params() that does that.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---

Would it not be enough to set channels->min = 1?

Konrad

