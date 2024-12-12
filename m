Return-Path: <linux-kernel+bounces-443788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C29EFBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83AD16C12A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F681DED5E;
	Thu, 12 Dec 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T4LaRVBe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879711DED48
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029611; cv=none; b=Qy9WZRl+YUheqOVVcL3GzdHvdGga3iuArLSJtEkQ/e+vsFjqNwEaf/vgf25H7xNeqDK6D5Ici5K9encooPls9GD+F4mWDkg+Np7AoNxJiz2mkaL6PmRycW2OA7EenNmt2pNrWIE01JYtxn31hYQp1tjd0gfBgFyD0IGVZqvwpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029611; c=relaxed/simple;
	bh=EY1UxdK0nsOHWEs59Tw3kCkc5SCtUIiy/NMaOFPikXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZGD45ZSfPsLLrwfS+jTkVxJO2RNRY3nIhnWx1LMa/oRMdCuy8UJvWPKO4TWPBbgPUoEIjofNS7YqlM8OXYyFtUNals+WpVSD777RcBqQqdVmYyx9kLLD3LKkoJY8vbuu+Ze5QozDalry4r1cIvDvYQj5umprNbuJq4h4ij7mlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T4LaRVBe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGaiBD019074
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LdB6cDqzU1MgjnjlzkYNl/VMPEULsRDH732vjHhqf/8=; b=T4LaRVBesWJvnD12
	qD2TM3Gb2rdUa/bb94EDXIG/ZvAjOWVVykXx/VdtMnu1rtsJG1XBPtpSerUPMzdu
	wu8avZ6vt7jk3JnuQy+Sd1FvLO/a13Ddj9EsImjPhau+8s3DDpMtunjhjMdRNkML
	w3vgm0pDMdgF7OvO4Ye5Bt8cOVm7HcLvRjdIbmYnkagdXd/VOxs6USxC9QoUDdSK
	ttZNzRANsQjECmlIVthUzQMTXvmisIsRst5uYrQbljs1yyGVb6zuKvrK6DBFnW3q
	PCBPwwmUGPpwc8Esd3HCCyu9MHZa+3gfV5XUvnR7nQ6rE1DJf7YSXwcy3ALD++Cr
	gdW5qg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ffdyuhrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:53:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4679fb949e8so1180991cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029606; x=1734634406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdB6cDqzU1MgjnjlzkYNl/VMPEULsRDH732vjHhqf/8=;
        b=QYnSp2WiGXBS/JQ/H+B6IC+/dFarMJ7S8JUOL8+3CfCxgPrEc//+KR9IUpbQic5Nvj
         zHBSX7PvYmSIUTZsT6X81A9ip6fx+ZnBIhYy45fCr63MkvZrGpbLbpVjnJa3gr0qyH0S
         dQYDvZYGjc7cfLlSG4b36GYT2evbs98hMdwtHHbI5qULK1hdJk//2DZ/8QhXLZ0gYL+e
         lr9/3CdXYjtVTzN6fF3DS5yxVJHApDhBoxt8cai+7oew9jd9rqS7OFzkckFbpWF1qsZq
         9HcoeArlWnb0XHS7fAicBp1/E9zHlCQd4y0npudS87oQQWdtEe+xqM6sfOqe9xlj9CNX
         c1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPWcRqNxCbRLnKBBKCIMOvPRPv0fMSJGny1ZJf8bk6d5Zx4tNYs5pcXtewRYbRyvN0msR2/v80IEHcNmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0mB+WEodv2LuxprZKWFe0QQiZvNadJO5mFoOi50jFPKOGRje
	1Z3dR6tAbWeGkhk57TM1bhyy/xXO5P468sr9zr/ahyMQSo8azUjppXqLFEK12HWdgXROrPtbyWM
	unsLorrTn5noSPQXuQkA8jDb54DmaCTKtMMxKoUnwKyvdYv5ytgCwPyIN915tIcs=
X-Gm-Gg: ASbGncvI6xrn4CIxjBg00F2klA7ONddrLzRc2uQIfJlGYLRCSJeI1ckJWoZLlVQuHip
	nfbnMxI490DakUbiv9JS9OrdpbGBIbDT1+2Wq/CZ42+jRomtz9LYJ6z2gYSFPa7eMLsJq5rZwgK
	i+nq1NMSTOI8iiEYJHVpAYFygdxW47Lc6YS6mopNs711hdohjXzlTkDzEF2sTRHwcvyqaTcBbJZ
	9VkMteEhkziWM/MxCjLV6nomfQfw2PpFDK/mZ2V6FNe0SVIjEJKxShQX9vpoWtkjD6Dc+TWN+FV
	q1pTjyrWflMm9Fx6WMOHm+oGhavv891ovr+XTw==
X-Received: by 2002:a05:622a:2d2:b0:467:5715:25c4 with SMTP id d75a77b69052e-467a1561349mr9204201cf.1.1734029606252;
        Thu, 12 Dec 2024 10:53:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIfdMJ7rlJDsdt/7e2h3sloDwTE1OoMFI6dE0DJYX/lscuXfr5CeVpufRqW8H/WXoMrQ2pkw==
X-Received: by 2002:a05:622a:2d2:b0:467:5715:25c4 with SMTP id d75a77b69052e-467a1561349mr9203961cf.1.1734029605840;
        Thu, 12 Dec 2024 10:53:25 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm8926282a12.6.2024.12.12.10.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:53:25 -0800 (PST)
Message-ID: <0f9082f2-e44e-4021-8be6-8ca7a999cb2a@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:53:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v2 10/19] arm64: dts: qcom: sm8650: Fix ADSP memory
 base and length
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa
 <abel.vesa@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-10-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-10-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jWkB3kZTv_o7ptGyXzcXQFHN5QZROVOy
X-Proofpoint-GUID: jWkB3kZTv_o7ptGyXzcXQFHN5QZROVOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120136

On 9.12.2024 12:02 PM, Krzysztof Kozlowski wrote:
> The address space in ADSP PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB): 0x0680_0000 with length of 0x10000.
> 
> 0x3000_0000, value used so far, is the main region of CDSP.  Downstream
> DTS uses 0x0300_0000, which is oddly similar to 0x3000_0000, yet quite
> different and points to unused area.
> 
> Correct the base address and length, which also moves the node to
> different place to keep things sorted by unit address.  The diff looks
> big, but only the unit address and "reg" property were changed.  This
> should have no functional impact on Linux users, because PAS loader does
> not use this address space at all.
> 
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

