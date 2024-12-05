Return-Path: <linux-kernel+bounces-433711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2129E5C13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326E718850E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDBA226ED9;
	Thu,  5 Dec 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MmadT7w0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF5225794
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417119; cv=none; b=QTRmbgVXP2vghQwcgTFg2CZQ0VCvT0utfVmUA5I3E9oammfnCuLhhEqFc0LeZrTWiyjFzlZm+OdHCvz5QXBViStrnmudh+AWP4QehX1CKMGwwOzxeRaJwZep06g0W35ctDO+ne/blhUSkXWGhG5MsgO+LF4zxyINxP94rjaGkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417119; c=relaxed/simple;
	bh=zGxUDR6c4ZU+Y5Se8IU+zzOYqXF4mfTOL3cNhJL7c5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caQqpC9Lr+8uI40DB8hKtFkqtY3cC228wpEfh4yTQb0hFRpziWy9rdshsz5XRqi/qDwOzJpgbdGtGHZ2mlE+6BlK+579EbAnJ8maOuTssPc+eUHMX1mEOpxs+rUWSzfqu1ijb1iOy8S+BgecpSpI+AKdGNDfQZ8DwQM/QLNeOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MmadT7w0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5FEuUb003962
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 16:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L6x0KHCQDiAykCeDoL6SPhnPeHMpJmBzuR92rcSSHCE=; b=MmadT7w0t4FI82xy
	/QDeA8tEaN4ILLY5OyZZ9btHhflbxwFDE/wj5RAIHom883jTYjujOJiZdG9Fl6Ux
	mFlCxztrCxUvSWwSKs6l421UBlr4U7LjQeYzCEoS0XdhJUy1NGIBwXH2u3hW36Tj
	x/vol0xl2GJEmgpORubvQwpbCmw+7qtJFOao4JJlbLR1VUPArGt3tmGrOUIWoMQH
	hDYL9GPChX9QVtVaHnmeDY1TeeFDyGrJHsjULT+XtkF44tdLkEGgQcNzP7VGM228
	ZcWhznX2WNYGcMLvRXQWcTeCYZ3lXPHOkMHvwsb3tB2TWUYi0Hzey9pXO7NWm8Jq
	O1fdEw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ben8896x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:45:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8878bbe9aso2863586d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417116; x=1734021916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6x0KHCQDiAykCeDoL6SPhnPeHMpJmBzuR92rcSSHCE=;
        b=RJAzFyOGhTeRP5GcRi5Swl8Vg7uJJh/rrQKhQdAeHxweEWfcKlju2kwhUExJOZNc2E
         k9guzTkZ05YZ220LF83cJvzHL3Q+gjP0/N2QR/3JAaRgalbF6R2DyoJ9chhMTxs7NLhe
         05NRFGGntNdWzLU2FIdpWHRVmXCG0pOhKHq9avORH/F9t7oMQgMtaeZohOMvwaIo+mH5
         wGG+5o2xCZaO79oYUX/Fmr2OpNUFI9zuWNsXo5vefcMFfRy1EFZe+y3QS9zGmnRnAg3f
         u28qlERMTFQlCChSgQzkRSU8qB0QvFgPhLYxxoG8OixX0lcwDRnW7pOW9LxyvVMb17gm
         LU3w==
X-Forwarded-Encrypted: i=1; AJvYcCUWcsXw8MXDRNXE7Cf6XxuwBsQpJLkxAaHNXVw/t5sv8Mr+D0tynjiEJbaTQwNExa5nRySYuo5q8ZZtUyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybPiB2hBfUrQx5YVpf10OmElGPKsSrWRFezhDHhiDkmqH+I+bk
	0S7Ha4rk6DcA2tO+Ju425dw0lywqj4o97USx8luS8IkRhuoW16x5pYfv3AwWZDkEHJs6zqV5KVH
	dAP/QLlJkzwjOwbpyh0/haJ7JOyRmKtQjmpz8WpJferLZA8TNGg6rzmwn3lYF6BU=
X-Gm-Gg: ASbGncvRBxfo4AW08HeRHuUBvsRtg6LSWJYyfQKtBVculifxqP2yM8ysPNs9OdNH0Ok
	I5G/GVNv5kHYi9PASo//G5csR6M8RW5/3kvgnYyLbu0P9d0OUPGMbWKCZDlYehelNRuGBw94yVk
	a2cafMERJBrxQZq8LcOl5RJjJBK5AMWRwHmjOtNZCg477NfmPRC5G8DdMtIEGizmob3axiZQiH1
	pL+StNLFsByGZlfEK1Z+WoQchQcklNmxAUYW6FiFu+tiIvvZuHcITU1IN1hGzK7YDlK8B1g3lG6
	M/2EU4HTQzr6YAWuHP/ScLnTfA6Xgmg=
X-Received: by 2002:a05:6214:2627:b0:6d8:b562:efcd with SMTP id 6a1803df08f44-6d8b73a489cmr65325346d6.7.1733417116177;
        Thu, 05 Dec 2024 08:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMc4CkwAoyme+72kcypxiH9g4yohl2nQ8tC0nVxXgfCDWMGWk+Bw8wSqwheuFgPrHSioLgfA==
X-Received: by 2002:a05:6214:2627:b0:6d8:b562:efcd with SMTP id 6a1803df08f44-6d8b73a489cmr65325086d6.7.1733417115832;
        Thu, 05 Dec 2024 08:45:15 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5d2sm115958266b.93.2024.12.05.08.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:45:15 -0800 (PST)
Message-ID: <b9225284-7830-4aa4-aed2-7f58fb7320e8@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:45:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] arm64: dts: qcom: Add board dts files for SM8750
 MTP and QRD
To: Melody Olvera <quic_molvera@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241204-sm8750_master_dt-v3-0-4d5a8269950b@quicinc.com>
 <20241204-sm8750_master_dt-v3-6-4d5a8269950b@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241204-sm8750_master_dt-v3-6-4d5a8269950b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gelTRDAc7uMxld36xdvLgmr8cH4ygkZQ
X-Proofpoint-GUID: gelTRDAc7uMxld36xdvLgmr8cH4ygkZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=835 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050121

On 5.12.2024 12:18 AM, Melody Olvera wrote:
> Add MTP and QRD dts files for SM8750 describing board clocks, regulators,
> gpio keys, etc.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

[...]

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

> +&tlmm {
> +	/* reserved for secure world */
> +	gpio-reserved-ranges = <36 4>, <74 1>;
> +};

Any chance you could describe what those specifically are?

Konrad

