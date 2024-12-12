Return-Path: <linux-kernel+bounces-443515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312449EF42F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C671892807
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571A6239BC3;
	Thu, 12 Dec 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHgFMnCa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C25229692
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022027; cv=none; b=kX2zNDpLsWmfgvQCK2vmYDvperLon4zBM1YBUqDvz2yCYqCWq8pzG9Jv9S7admJ2XGNpVn1LrLxc6SchwS/vobGwqRmu1IxYMqdd0Fif5y5zCuD0WVjrJSgSW3BZQ0YxiLkOBJ4pFyL2Q9PEOGIVCWMaUGF7vc0FeWUvdEyGOjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022027; c=relaxed/simple;
	bh=gakp5Aj3FEv816mtcgel/jdY/v/jGPkhjk+8fdyuKqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIy5o4LEB1sJR+bt2mqMmJSVsPN7nxdeOT4s+lib0X5QG6budfP//h5WssbFe/KHdpgheNv6nnY0Hx0Nrgl/VfgFdp4Lc3lJYx3arXVTEYv5goOTDpM8gPy2Vg83582n/y7nXiTtsVWNhC4l3trFv7ZBAgbaiU5lie3FNWTmGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lHgFMnCa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC8Ll1M026835
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z4OtdDfHtUd2K5YuFPJH9FsYSx7IvdHrXF4yoTvVqjQ=; b=lHgFMnCaTEpWxUcT
	nc+bvY+Y6RoafPPoduGjjTFdoLoXzZHh4Iy7caYmn0uGPuFZ79woF07U9ANdioi4
	tvcTIQrcztcZCof6X6yVDA5HbAlf1sT55m8PyDBLSWHFnsJX2hAVQqS6+kOXZGck
	ThsqK1HmdJBjgJbh4wbUTqYxIAxhmI70y6qxOahsKF89L8qAJwYaqWbBDN8pHhCs
	E33Dm7QMfxKLwW7VccjlIalndkM7CxbNLW+vjbcjCRey0DAHcyBT5ovRG04AgnPL
	bLbm0llXi0Vy+Nur4boAi3HnF0B6MOTwc5TWfqfg3ujAVd2+RgATNk+/BzB0+tQp
	tJjgCA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40knbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:47:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4674128bca3so1477101cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022024; x=1734626824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4OtdDfHtUd2K5YuFPJH9FsYSx7IvdHrXF4yoTvVqjQ=;
        b=Ov/dtXrRZT/R8uXYCH7tecXtxMKO2l8BfzKWRG0dsJT3acIRynVAnPH1W5qeOcWiA7
         1wmp4bLCgRebdHCNdxREgiJ/bOZLPNg/iZSXsLdanzbYfB2iYQEKua0XU13iDl2x3H7N
         d1RCqEojQkbwIaLNRU4/Gtw1PQqMTnoPtQIJ7/UTFgKLDscggZ9xodhYaSHFbhhxplLW
         MoU2gJeN89CaW/pFAbkxkznmiQf6oN0d4Imr4Jm+iBoF/xAdyUnaHHqv7iMbK3iwnKiR
         kDhsWVtdsHhqZ270eBC3JZcesb0JBjMUOmkD8jLkNPSZc1+zBMbwKJNbQkfRMcv/HUu2
         kLaA==
X-Forwarded-Encrypted: i=1; AJvYcCXwhHFIazXoIvMtqbq960t3XRSnsPwXy2P6XnQhvJqrQquw0Hmn9xXzltS3UAxzYhiqzSN/xcW7/ueW1pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysJqQ9+77P0xw58e9wNa5kws0GmW9bDMbOqNMg07D0mrw3a2HK
	anm53Z8dFabeM6BATayb2EgPXcuPCo/AHjqwNl6/s1jY/DHXKPxIxGJiyiudpgiYSFHqOyBjW1i
	KPl5sUcz2ovaCwCZdFukHTdCv2ausv53rfM0w8fawkP9d/1DgOeY7Wj9o5cuQPv4=
X-Gm-Gg: ASbGncvaZiueczUPtQS+RS80cbNq0s+Inm6+noHdxMAJCXXkgh5aftzQmtMxwKWKw/N
	C3WRnhyyPNXzI2Ep26TCqr5RYXFGNkCn7G9UlSm6KAZwwMwsQvpgt8MvwjBRNQvbWP0iykyQOKq
	i3LBg+wAMEYBilKfXsX+BYU48HSZAsq+0YfQ2/aapkWoydMIM11pzdwETsqYE7zLFD68/ghFhir
	7BL94tS1bozI5V2JV1l8+4e95afcICU8/ybqfL/3AqZl7BfEkras4ufdpfGTSfIRla6qhFxIk8j
	NiPej1iztrQwzZIwi95TXVuyOxZ83axPcgHn5w==
X-Received: by 2002:a05:622a:110a:b0:461:1fc9:61a3 with SMTP id d75a77b69052e-467a1556cdcmr6368771cf.9.1734022024021;
        Thu, 12 Dec 2024 08:47:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbmP4pXDhW5EBpXexeneOeQ1H0OIhDr8GB0bZnmXl6AR8XFHt2k4+lrHiAsVPutnSuge9M8A==
X-Received: by 2002:a05:622a:110a:b0:461:1fc9:61a3 with SMTP id d75a77b69052e-467a1556cdcmr6368521cf.9.1734022023575;
        Thu, 12 Dec 2024 08:47:03 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6ab7fe8bdsm311763466b.160.2024.12.12.08.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 08:47:03 -0800 (PST)
Message-ID: <1777f0c7-7cea-43d6-a7c0-4777bfb3f1f1@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 17:47:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] arm64: dts: qcom:
 sdm845-db845c-navigation-mezzanine: remove disabled ov7251 camera
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
 <20241211-topic-misc-dt-fixes-v3-2-010ac10529b1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-topic-misc-dt-fixes-v3-2-010ac10529b1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VK73zCyY73a5t7FnZWj5KWsjHVKdicYd
X-Proofpoint-ORIG-GUID: VK73zCyY73a5t7FnZWj5KWsjHVKdicYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=969 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120120

On 11.12.2024 9:03 AM, Neil Armstrong wrote:
> The ov7251node has bindings check errors in the endpoint, and the
> camera node was disabled since the beginning. Even when switching the
> node to okay, the endpoint description to the csiphy is missing along
> with the csiphy parameters.
> 
> Drop the ov7251 camera entirely until it's properly described.
> 
> This obviously fixes:
> sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
> 	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Since:

* nobody cared for so many years
* there don't seem to be (m)any active users of DB845c left
* /\, even less with this specific mezz and usecase

I'm happy to see it gone

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

