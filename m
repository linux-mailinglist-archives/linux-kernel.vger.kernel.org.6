Return-Path: <linux-kernel+bounces-443281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ABB9EEA21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C5C2842CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977972185A8;
	Thu, 12 Dec 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fx3MRZvf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA921660C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016144; cv=none; b=DjkwUlk+IYzA3+3MB8jxLEZMo9Scfch5US75Elj0uGqHi83yZbQLsI0kZlTiFerPphMRlOQnKHBUED5CmeG0bYTGYeObK2CKjUVZBqgurFBxhePzvMKRNjf34ZBv2eYGGHelTPwMv5GQeXHV2j1cAFFZ90J+dZN9XFdnn3PXCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016144; c=relaxed/simple;
	bh=7k49yoU5iCLQkIkTaX85Jb0wjiQkl/LFPcm06qJVtIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WriOXqoiB5onQ1O1xRk/PacvUQFX+0NTCs3TPpDBpCt3wQEe12WFciTTeQSvatsO7Wz+kC/UfY3cdB6x4xu3xxfab/dRrlS/s+SLQ//0wWHGJMAxwYRm4S8ctUychfd4CkYshGbiUCUEwG1eZbEqNNJ3FhZD5+tFEY6u74klMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fx3MRZvf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDEi9r000539
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tbbmtuIopE68EoB/LCcm2ylXTJ6wVvJcxHK6UUbzlZQ=; b=fx3MRZvfFuVz4idz
	FFciT0GzKA7l0e8WGu3A5W+QnUpXeoRIb62Feyc5tc2Z5fyvu//vPol6GqPYyGAE
	A9s602mCxV48NUcvHVZOrlCX9HJq7PAuhxiWaXvVsa676aWrX3jYePlJYCmzmgFn
	//gtxUnZY/6lqZGOj/eDHtuYKwNetPcdUcTNGBHscdGPIxWgbc3Zhz3QLVbG6aSe
	2ptyzpZsMfYajmWAP709AJXzN75dPY1JW24zS7Pw+iVkhe/PA1I3/3S4wXmrfAM4
	HC9A0qXY5jwgAdrRj1UheLe8GHdkVs1y7mHvZbnz9rn5AaajUoprxZBgN3vQ9fiA
	OefkjA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes1us2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:09:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b66edf3284so812985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734016141; x=1734620941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbbmtuIopE68EoB/LCcm2ylXTJ6wVvJcxHK6UUbzlZQ=;
        b=Vo2WThCXzzP4jaPY2/uQI/xc4U8v24R9QwwB8qsjLwGXjMyxm3bCgx0r2LUCHF3fTA
         MzP1ekaqXCbs6SVHcTGBVRoVN64DxrfIJXTrqc9n0gAkOhm4TxkYJFLUpU7wkn3RYzzJ
         13h3Ns5iYPMg0I30GpXEh47xEkFzECcQp1htwPEccHAPrxFLTJSAbAN16J5k3ilseO7I
         ajwC+ruN529wpc52goE0Ty7SosfbkysrL1Gs+XDTaRDjygDxXmG/2g1ClqJ2VUx9XZ83
         QKbSbbFXYm/YNLooJ45oJV2HrOd3KbHdBq2xKYazvP64s2UC9QJeiLiQdQsXdC+4xQRY
         cmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW29SoCiKey4iyKhL3GZVYIKsVVtK8ZoHJGGp+M5lmKHoM7ZwzZaFapTs62RI2x0zngxwuvik+mfoxlDeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCpIbdxVwuUiP1ZfKhvMOqWYI1UMLb4yjLgLn8Kgxz4Sr4+jnW
	+KNftfHise8gctEBfixfrkvYWhW+vjcFKI12wHVWklxUxb0+jqa29/2eEVCZGe59f8+Bc7+sIG/
	ShXCFq2bZKf8qY2cFkt45tPCdvu58HHvH/kGrK2Ezln+9SdJpBA4mlX9+naXMVoQ=
X-Gm-Gg: ASbGnctc8VXKZc9ExjxGvcqfDqeylS2W6vr/an5tLx9W4UJFQKo6/skVaEErg1b6qsp
	qhMOV4S2VgRZjGna0OloDYaB5jM3iziUcfvrDUzdkcEfFF62IkatWiEe5F6mP46luYLKynfKZsF
	YGA/M8aI2YzAG3oR91rfFzVIREeEu1fDhIIqXgk1sDVvxiOqtpe/jpgh7AGPEiWnti2ELxFAQLA
	N76PPxwrwXnpygtxifv6WfBKe8TH4JJgU6D+M8+/9LIc6EBuccc7KSFgJ+M8Qbqc1u0eAgbUrzM
	hgiP3wG31yrMt2slHpINCyok+KgmRH3GufuxqQ==
X-Received: by 2002:ad4:5de9:0:b0:6d4:1bc2:386c with SMTP id 6a1803df08f44-6db0f72f2e7mr2958006d6.6.1734016140996;
        Thu, 12 Dec 2024 07:09:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECGBD4UFxTS34V4+BN0AUO29FSYDbonTJqifxpjHb1kM0nyKjYMHeI5BXED/P+sXetih2oCQ==
X-Received: by 2002:ad4:5de9:0:b0:6d4:1bc2:386c with SMTP id 6a1803df08f44-6db0f72f2e7mr2957816d6.6.1734016140532;
        Thu, 12 Dec 2024 07:09:00 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6749d08efsm718200266b.29.2024.12.12.07.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:09:00 -0800 (PST)
Message-ID: <26609a46-7d89-4e7e-8513-59cca81ea10b@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 16:08:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: x1e80100-qcp: Add FSUSB42 USB
 switches
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan@kernel.org>
References: <20241212-x1e80100-qcp-dp-v1-0-37cb362a0dfe@linaro.org>
 <20241212-x1e80100-qcp-dp-v1-2-37cb362a0dfe@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212-x1e80100-qcp-dp-v1-2-37cb362a0dfe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xkJfj67OwIyhR1T-izTFAvDqHw-hHpyX
X-Proofpoint-ORIG-GUID: xkJfj67OwIyhR1T-izTFAvDqHw-hHpyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=640 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120108

On 12.12.2024 2:08 PM, Stephan Gerhold wrote:
> Unlike most X1E boards, the QCP does not have Parade PS8830 retimers on the
> three USB-C ports. Instead, there are FSUSB42 USB switches for each port
> that handle orientation switching for the SBU lines. The overall setup is
> similar to the gpio-sbu-mux defined for sc8280xp-crd and the ThinkPad X13s.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

