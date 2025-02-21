Return-Path: <linux-kernel+bounces-526699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1113BA40229
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB23C19E2004
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786DB255E57;
	Fri, 21 Feb 2025 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bbEmgMW9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD9253F2C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173936; cv=none; b=RxycOH2ydFSHYJ0pGcFXq9lgylNYJQ4hgUAoYnGb/fSP/2ipFuqVp0+7lN285u1k2cj7fEN+xAPop2Fn3O1QG8ZqVMF+qPIXBfOUA0+ZxOktkUFzb1rrJn/zgiJjOeqhrbEelpaovqemD46vNz6zEJiM0/P4rbFr437gx4or4p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173936; c=relaxed/simple;
	bh=M/hcGQyoFwPFqirz/txizQCfEWA8XcQU5hY54LZQlVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1muoujp6mT8y2p5Rjk7Spx1U4PnGOKYH6kiIlMR9H54R4JVgc3fmD8Vw2Bpcx4x4mchwMdjmZISvGIvDP2I7PWXoHdz0hPcfr6bLv+O6bWd6ePcHpwiMD5ZUSB4PDkfba/+HP00D4rO91qre0mQBLVYodkZOB+MC4kXrfjxe2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bbEmgMW9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LDoQ2W011714
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v++WnZUnpWOgAMA0wIfH/ID14IE5ovXRwz5f3ehfMvY=; b=bbEmgMW9lWB1Auz4
	IW2ePG2bp2qwT0Qgu600EJZh6QJkxg79+JwMmpMOgO1LK51s+SbQU5AHQyOtaoTY
	HQhGZYFIMRnSwLq4VdnC4P8//EZUqQuoJZew7AuWua50dPQeaEgsadlWPsyXWUx8
	EpHrWFIdMhNK8q/cALvV+60uSyxa5SM4eMn0kX/CffzK6NMNDUsRQhbqU3PKLSa/
	KkCilc11vfou2cNtLMq6eiT8A3yOd6q3AaMwqih1sPcY1KjCnse/iN9eAai7ZQRF
	oCLkjbesL1+saD02pvWQ48e7C421I7rl5MN9QOyJSL1cKP8vPDnLDkhogIZvd9Er
	j06FUw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3u7hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:38:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47201eab1f2so3813871cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740173934; x=1740778734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v++WnZUnpWOgAMA0wIfH/ID14IE5ovXRwz5f3ehfMvY=;
        b=AV3HCqCaMZAtS9mOAa7Wq3dy8K5rMsA3DS8OzDFdtPJSAclioKazuD4SdcFKvYTKgC
         KM0Dzgc8Ma5y3IcXftPpys15jyUAtxdg6nF8YauYsPPHmfc/TWFQMub89mJlBONU795V
         uGBmj8t7o/gM2MmfhihQfhfPBEBN3+lHsj2miJIcGqs4uCrWIjFAywu3Hr5s0ERfEWAK
         SiePiZzBRdZ4mPOg+m4PWt0AS7MGlBRIfz8VhiSr5yUrsPnUvICdYKIgn0THXCu13Iq5
         gEmt2oj5a5n67l4RBPhkwnH9Vje6BckDNGL/CwKPk2HBJPIRQTkQXzQELfxi/COS6stk
         CAig==
X-Forwarded-Encrypted: i=1; AJvYcCVxtwhyy4y7DupUmnCP8u0wqW7BuG9F1hzoAzpGshuQnzWwQQbEXcZuquB1n9ZO+zpRJWj940nXYJJ55Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyhnBuenQcha9sGb1qrmmyJEFGTqYnqD4zABqzT7E9ECc6Nl2o
	AAC4Z7X7A46vkDu4gcswkCvhwGLQvZHhq5hn4tS14rTni82PCxQYYjX5hMZkW03tyHxI/dKi0bx
	NXHVPsOrKMq5QYZuBi6DaPXLE3pK6MYd8fZHrc5fKYqMYzYawC4k+G9tILKO0rnw=
X-Gm-Gg: ASbGncuwLrqSxPwXVBUYpJyRd3Z98I+XM/Jkdc+RWciLzDyUuSoA6iu0eW/tu/i57zf
	YaYSTaHEIujjggn6oSh5wqpBMBYArYnMocRGG82T/QLDmGcfgjcRV7TpStC764dY1dY+ToufaJn
	LlVzI/XcyZig7HDuWuMgoDlHtYRt6VyjGa2idFg+K9/e+elTA7rUgKV9YepGBUTyafQ3HSwMLYM
	nLKiGnF6cpcZwRHm01D61c3vLdr6MN1MIxtvIfi7xyqHdLbBBlngATsgUDfpJjkAkadQlCVlM9C
	UVkjzOqpPj6cpWSLLioGzvbCYoPU4FjZkeEIcSMxjfPsdsiKNdqIZQw/LFiVL6FRgvSwIA==
X-Received: by 2002:a05:622a:104:b0:472:1861:fe13 with SMTP id d75a77b69052e-472228d5becmr24240411cf.5.1740173933588;
        Fri, 21 Feb 2025 13:38:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7LFnmHnBy/t33605DNQYqWNsZ6WQxWF/c1cepGHBy1JILe4jOOnXsKOEhp8HSt80yjo7/oQ==
X-Received: by 2002:a05:622a:104:b0:472:1861:fe13 with SMTP id d75a77b69052e-472228d5becmr24240261cf.5.1740173933171;
        Fri, 21 Feb 2025 13:38:53 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb98ed07afsm1067043066b.102.2025.02.21.13.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 13:38:52 -0800 (PST)
Message-ID: <dbd99d6e-e8c4-4b03-98fe-8faddecbf11c@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 22:38:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm8750-qrd: Enable ADSP
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250220-sm8750-audio-v2-0-fbe243c4afc3@linaro.org>
 <20250220-sm8750-audio-v2-4-fbe243c4afc3@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250220-sm8750-audio-v2-4-fbe243c4afc3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kpYouMBeC1qT4AuT_GCfAb5Trdwb_fiF
X-Proofpoint-GUID: kpYouMBeC1qT4AuT_GCfAb5Trdwb_fiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=573 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502210147

On 20.02.2025 9:49 AM, Krzysztof Kozlowski wrote:
> Enable ADSP on QRD8750 board.
> 
> Reviewed-by: Melody Olvera <quic_molvera@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

