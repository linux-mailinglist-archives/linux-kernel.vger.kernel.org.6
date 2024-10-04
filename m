Return-Path: <linux-kernel+bounces-350086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818898FF8D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8441C21DB6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB28146D6E;
	Fri,  4 Oct 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RxjvNz3Z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F7146A93
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033834; cv=none; b=uh+IW8dB+EsfhlyMOOAlgFTBjFxybekekg/Bb8Ya6tv4goK0X6vSy5ebO8eL1fhetvsrRpWjcj6MREf3vDBywYQg2Lj2h+JAy+hecrxXiqJdasYYdzM70FRKutIxrKyXbjVb6r9kYIjyt0/7s0B85sowvS2OBAUktmbrvJWiTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033834; c=relaxed/simple;
	bh=zF81PZbRTtYPLl316AZUu9aKAygPVvRd/9sGlJIia3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqZo7Z7+qAHpCPssYcwa0R97bgnHkRdARW7QUvgheZpN/2oqJXj3sK1QNzb3S16Pe1wniLgLcelNQgFe15DcZP88m5R8C4u1dmIwundwzybuApIiATj3WTKstxfJ7gSnz++Ms0mSbKAZ3vBCZiA9k7ta9+YmgZ0+N7JP4UxUB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RxjvNz3Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493I0JGb013114
	for <linux-kernel@vger.kernel.org>; Fri, 4 Oct 2024 09:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1FIajSp9MAFRpYz+j44qj4ddmbDFtR8F8jTGb/CgArY=; b=RxjvNz3ZMDOmM367
	FXj/JbFGE2Fd1/khJUdPDiM+303P3mLS/gtsvJIfPunDdwi8XZbvzWE0gtpNA+2a
	GhvkzcYB5qXz1UIYPL3dCXIIelS8d+FD0l121nn+888BgebngbGrHk5LKJ6Su80O
	yTRwI9UMHrYOnIxfOOSBbal4PUGHUfcQVmQi56g1dMHYgC6MDLyVIo25EE7mNRNV
	dqAwYylDhpjrj/5WXKuj/mJdbe08JXG3ejlpp6SUpKhBFEVYHPgsenkCxkipkUa/
	VNYqnggv1p9goaXwWF3mULlyjrAvJXSsMOhjFsJXPZwE1jJ3cLbp5BHI2ROkBLxY
	1bq/zA==
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205k9m16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:23:52 +0000 (GMT)
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a83a29e71so26367166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728033830; x=1728638630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FIajSp9MAFRpYz+j44qj4ddmbDFtR8F8jTGb/CgArY=;
        b=gmerOIphdcohOsyjFmW0rMmXnfhSgl0PVZaA1u7ZRwLXCUkmSqq1ZjnNsKXG0LnHEd
         2Y2UONOHkGOV25OZyoQ3YRQp7JdshLKeOS/ZM1U0Lys4vRhGBoaajZEcMUdGAwWiqfGR
         cYAshUBvSWCPaKOnDJbypjwBP38qKjgWqAe1pj3S6Xkk0d+WvDM0XKwozsAAbQb9u+UQ
         5mf6MK8WNLwEzXa+6TRPw8RuyPmNYMemqjjLZ+yeA++Qx5i14z2b1JL2KmPD25xjlHRY
         T3Ham6nfP6nRjuCfhTeH3WHt5UFfyS9kX0c+SPOLU83gZBnYiqmksPnc0U5dyelMUOcc
         D3KA==
X-Forwarded-Encrypted: i=1; AJvYcCWWNXh0pISuU+21Gq43pXEyx2jFmTx8tgLJXDP8502+Zx0RD/UIpp0JDS/MFDte1+Lo4MYBaR4l5Yq01Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrb7M+jc7RU1wgdi7Oq8DKTrQrSFWlhebIQzJHYR/JiXTiMxcu
	y8Ju9WDqWqt61MU6hjH37MKF19g7daecYuUDZw3FkouLxW/wvuTtMMuEiyA92HBe9RSe+SC7ZqO
	19t8TnyZTLpDehdgnlxZoGM7knguvxkgRi6qg9hDH6hNBxQynOPTl6SZyURx7u48=
X-Received: by 2002:a05:6402:40c5:b0:5c8:8381:c2a0 with SMTP id 4fb4d7f45d1cf-5c8d2cfe1d1mr548323a12.2.1728033829581;
        Fri, 04 Oct 2024 02:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNg5J8Z1YedVbonVK1DkJJLIXofB2Yi/Sdsn9fVSFpZdSMkYXBrS94sDQ7EdFgplzm1UDt6w==
X-Received: by 2002:a05:6402:40c5:b0:5c8:8381:c2a0 with SMTP id 4fb4d7f45d1cf-5c8d2cfe1d1mr548309a12.2.1728033829127;
        Fri, 04 Oct 2024 02:23:49 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca4d7e5dsm1622502a12.61.2024.10.04.02.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 02:23:48 -0700 (PDT)
Message-ID: <4cdc804b-6b33-4420-a245-1a6db47e17e3@oss.qualcomm.com>
Date: Fri, 4 Oct 2024 11:23:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Enable MSI interrupts together with Link up if
 global IRQ is supported
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_qianyu@quicinc.com, Konrad Dybcio <konradybcio@kernel.org>
References: <20240930134409.168494-1-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20240930134409.168494-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EIVSeZoINEylLWl29gUvARyS177w3zo-
X-Proofpoint-ORIG-GUID: EIVSeZoINEylLWl29gUvARyS177w3zo-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=721 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040068

On 30.09.2024 3:44 PM, Manivannan Sadhasivam wrote:
> Currently, if global IRQ is supported by the platform, only the Link up
> interrupt is enabled in the PARF_INT_ALL_MASK register. But on some Qcom
> platforms like SM8250, and X1E80100, MSIs are getting masked due to this.
> They require enabling the MSI interrupt bits in the register to unmask
> (enable) the MSIs.
> 
> Even though the MSI interrupt enable bits in PARF_INT_ALL_MASK are
> described as 'diagnostic' interrupts in the internal documentation,
> disabling them masks MSI on these platforms. Due to this, MSIs were not
> reported to be received these platforms while supporting global IRQ.
> 
> So enable the MSI interrupts along with the Link up interrupt in the
> PARF_INT_ALL_MASK register if global IRQ is supported. This ensures that
> the MSIs continue to work and also the driver is able to catch the Link
> up interrupt for enumerating endpoint devices.
> 
> Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org/
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # SL7

Konrad

