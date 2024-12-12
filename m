Return-Path: <linux-kernel+bounces-443749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952439EFB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E22A16D16C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20621891A9;
	Thu, 12 Dec 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fLhmAXEZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D318E047
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029282; cv=none; b=rRmmZiiApPR6BltO4w5ilTF0PnHKZ49BmjiIrC4W3YmkJDbUfofufydLwKEZzvPN2gAHDNb88NXaCEndG5vykwwSnPcbnFUdHlVGddFhHquXZhSh3vzcn/pFwO4cNKlzHTU3FFLp68d7D+ciRMn7zegQAdVQ/yN0BwbgejF3ZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029282; c=relaxed/simple;
	bh=KlkSWLS0Qd/mfciP5UkDT25gBWSNSTSCByPeDrKJSD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+AYK3CIpQ61YP+sVuhhLDLmEdN5LlQnAvs1untaQUybrGQ2RK5UJ6tyCR2V8nBbYmdjlh7+JRfGCMzvy9esvhZ6xeQ1rLRFr3LrRQYtx5bEU02CHLONhUBYRBsXppHopYj8bOyE1MtJ9l3AiECa9TDEi/fTP3nU6Z5L40RFrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fLhmAXEZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCBM2lg028212
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ALq+X0uDXx9y3Xid0ehyViPpa6r2R/TSZzWUGNi/JQ8=; b=fLhmAXEZeVEMBALq
	TkeSvcA1HtPZiNwJ/SSYzvg0kA4Bmf6IxjR7Ex7bhmZAV5CKwPB9BYjr+3KRy9tl
	xImOFLRLH2drf2fMMkbKhkfMD0cKHldEtLRDKeRc17Gq5uEhbiRUoJ+Dn6l+0tDF
	INEOPWvPXTipikKsHoT7oQtYYheCAI4zBYSwm82RlbZaWtqEwbIXDhmRzEJ7wMWG
	yJEhTQ1FTFC4Yfz2O/FXuwJ6GiOEV+BLxAaPMJtL5Uapr4nQZrCWNrfIZhkK56XK
	pQgUjE2KKmzVLsN5qcyOra5t8MUcPrBzLxD0sHRzAFznd/cdoUGHdTFtdoiFBMmJ
	fwlW9A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fxw4s82y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:47:59 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8e7016630so2339306d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029278; x=1734634078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALq+X0uDXx9y3Xid0ehyViPpa6r2R/TSZzWUGNi/JQ8=;
        b=DMr/oSLnView10XOk/YPMoFIg5iOW9VJNjp4e0FuIoic/9gbMv+SVAwYbkNriCALME
         ZzSzIzoO3mBQciOmOKFcr+JSAhJIL00Wp4RGXkFcT1f0E+VQQhUoJ3c1n2TTkqV7rDTq
         7pe7SZoBpdyMyXOyI8jGvodh/5adZ3T6lizIy7GixX6WX05/hRCE6Vz8PBhUn3hr8hHR
         cCUBBS/PrxHyMNMWxWEsLJN/CXjYNWgeaMVMq/ehhoJHcGuf+53wsDGqJs5XnQttjzRk
         FKLB3dHJjeLQS6qICin7Wud11N3ey5sxlurCakn0+DPz15SX+pH4XvuSlU/k228gfqaJ
         Kqog==
X-Forwarded-Encrypted: i=1; AJvYcCUFOXi444FZFg+O/y+ONg9ctzrc8hupU/D+YFlb68Ot36KWgzpw708Qzq0kx/aSiCIE9OJ8/s0vyfbBmCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmDUlRPCddyKt2exAscljZ+ru2jIGP3VNreYa+ebQ+M4iDYvmQ
	QuqnFGqATvgZ06RPsz17W3VsCuuRlTU5WPiDGlc2SqxkYu3YyYWGZsCmRnSvj9Ko0Lppq1r8ZtO
	RtgFjYMwO3oogNQpHamblIyBWZiYCk2OI+177xnfmvHQtv2V3L+WxrD9aL5g2q5k=
X-Gm-Gg: ASbGnctR/0GUiGsQ96hfLfugGXD6X8dd7Pe/nqLSMaMJLXcm7kCkMysdPik+4wsw2QL
	rKnYW5QA9i35RjjZHX6wQs6OREbyoOOyIjUEIcklbA95ldfgLcCOvPjB0jyo3K8rHTyPPq2zr31
	As+086QXXSQfiCY2Yq8zZpRteNWdX3egArmTLa1uWOezElLbTI3txN1NjUrEyBaBJjikwFKZ9Cj
	b4SSIpnmn/aHS+n5PWZpQeuSteiffDVE5TElCZsf4l8ijwdWoN9abqeLt+2bskNMNzhYWb7Luk9
	3er9u/tP/xs4nINC7uA0bPlTDLV+BdLlALgJCg==
X-Received: by 2002:a05:6214:21ec:b0:6d4:216a:2768 with SMTP id 6a1803df08f44-6db0f82f0ccmr8310686d6.12.1734029278617;
        Thu, 12 Dec 2024 10:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh+G1C5zbhHrm5ABg6kM6JkUvZ5KKIo29bktjk85BGikSGESW+ovgWonPs025EJAUyydbJTA==
X-Received: by 2002:a05:6214:21ec:b0:6d4:216a:2768 with SMTP id 6a1803df08f44-6db0f82f0ccmr8310446d6.12.1734029278313;
        Thu, 12 Dec 2024 10:47:58 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68e800a9csm569897166b.34.2024.12.12.10.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:47:57 -0800 (PST)
Message-ID: <27eb49c6-c81e-4792-b49a-904cce95cdc8@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:47:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] arm64: dts: qcom: sm8350: Fix MPSS memory length
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
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-3-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-3-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TvNDB9MDZQllRQOWmU_UINMmSz8-idYv
X-Proofpoint-GUID: TvNDB9MDZQllRQOWmU_UINMmSz8-idYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=823
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120136

On 9.12.2024 12:02 PM, Krzysztof Kozlowski wrote:
> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
> copied from older DTS, but it grew since then.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Fixes: 177fcf0aeda2 ("arm64: dts: qcom: sm8350: Add remoteprocs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

