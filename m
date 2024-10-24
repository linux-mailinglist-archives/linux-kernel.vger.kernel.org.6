Return-Path: <linux-kernel+bounces-380354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588359AECCE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8001C229A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31121F9A95;
	Thu, 24 Oct 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tj9gzG3p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713A1F81B9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789096; cv=none; b=BZWFvprcY2CPZyMjTEkwSok+DmFegnmQWqoASQBxRbfnLYTmAugH781U/788ncnuB00+Y5Knm+IqdQf5UKnxjJvMUEqK27q5f8pHRlV1rFKP4pATbpyI+HgmOW2xuCZhAgGlrqSgB88iipmkiBVd3w2FOSh+L1vZsDaXkKgBZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789096; c=relaxed/simple;
	bh=1ukhixbsRM10mg626bcx8W+5wyHs3c5XfsQxfCNmfJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3GpDtV2eDwxVyUdPfGY0VTLg+lAYu/yrDPJ+yKYXNLJVWI0cAfZVobbIjPFKoV9GypdbW4OLciMfSZpplSyLucegk7+Fcxi91iWd8Z5T8VSTRKKNoFOAcIX9XP/01myP37qGTrhPGX/gfJA98VELsTLYBxn7HkBJvhytgtQJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tj9gzG3p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O8t2pw007791
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eKqKzvww689YAw2d/2F3W68UpNZy8tpNAmm7bIbGXSo=; b=Tj9gzG3pn4QQzh5F
	+MxZPXG0ntDXue3VFE5/6gOpec9dtBmXHJkW7CkfdZN1Nz1MOELVYvCyA34Q7bvK
	UAFhjfgJSBSIZ5xEexlnFiszBFpKtxftqCeN0B7Vqokm/r8QGlEuvI32kR1xWocI
	LDEIXHnpxF+Kq4zUAMurEy6s3zZinMD1Pk2zaPyXWOYrSy2170p4hvl46b0/eYip
	b5vTxefJpTGaGyWRoc73CV9Y+UB82dN9Mzt4VVjFLv9mmdMYjRcZNvWKzMlBp5wC
	j1hqZvLPVJnfxKbaLH/gXElkNXsKqfgzczeCyIz7iWaMRYvvFaPy8HQ1jMoSG29R
	lFJubQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fk52h93g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:58:12 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbccc4fa08so1414256d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789091; x=1730393891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKqKzvww689YAw2d/2F3W68UpNZy8tpNAmm7bIbGXSo=;
        b=Gca4HYhkhTC8NnSm3AuW/wgmCDr/Tmkwid/nCfWtBgWvKidOBRl2wMGOAqNXTlhccb
         OjgTLd9IBDnAMLa0iz2KxkVL+ihBDy0FmqK7/cO7srkx+0tRD+/AwWQeRvqd6d7bQwlN
         hdBCtAvqoaR6taD0jbSqQPm/EEGwjsVTEilxn3/hxLhduGP+zV8YnWdEh1gplyYy3BtA
         IHTltB/8M7S9Xv6lc+WRjgpLmgLbZmVSoO9gqVoyiyLbKt3qZV59Oa6kReHXA3IbeRcG
         ncI/raCaKW9ACJgt0dXX67YKdqUWnofEOvn2SGOEpfOsZONOMsyuilkL8cWAwqU6LGt9
         8PFg==
X-Forwarded-Encrypted: i=1; AJvYcCWN0SuGBJlPxMU5YbXiLNbvsdoD+d9cQukZ0e6dxLBK3+G0YGvgeZmtr4cb6FpL2IZfPm9viB2GZzoFJ28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8olgMdR40mQm/xTzr3eg8sWVWYIOtfezdQ6toxg/RjxOyY9p
	okACF9lGgd6ogfhi5k7WLQj5AeKvDtfqgxCYHejvvXlXCMeqrlvJt4lGV6TFv+UB8fv9jAvk07W
	CJeRUwSNAc06eED8DwN7M0eZisROulgNYFXaLNEo3UQGDnH1rogKktVVhTblyZyA=
X-Received: by 2002:a05:6214:ccc:b0:6c3:5dbd:449c with SMTP id 6a1803df08f44-6ce3413a69fmr42215176d6.1.1729789091250;
        Thu, 24 Oct 2024 09:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHagPfwGhymYTLC2DieUs52AhME0l1R+evfg3zw/XQ9ZepjC8tChIg/HK6pDSWSb3nqIiI5IQ==
X-Received: by 2002:a05:6214:ccc:b0:6c3:5dbd:449c with SMTP id 6a1803df08f44-6ce3413a69fmr42215006d6.1.1729789090937;
        Thu, 24 Oct 2024 09:58:10 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6547esm5941232a12.37.2024.10.24.09.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:58:09 -0700 (PDT)
Message-ID: <882d92d3-57fc-4f71-a48d-6e53b6b6fbed@oss.qualcomm.com>
Date: Thu, 24 Oct 2024 18:58:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100: fix PCIe4 interconnect
To: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak
 <quic_rjendra@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>
References: <20241024131101.13587-1-johan+linaro@kernel.org>
 <20241024131101.13587-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241024131101.13587-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xmnCTkm10Tn3cPtFLLnZDkpbOUDfPpbh
X-Proofpoint-ORIG-GUID: xmnCTkm10Tn3cPtFLLnZDkpbOUDfPpbh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=751 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240139

On 24.10.2024 3:10 PM, Johan Hovold wrote:
> The fourth PCIe controller is connected to the PCIe North ANoC.
> 
> Fix the corresponding interconnect property so that the OS manages the
> right path.
> 
> Fixes: 5eb83fc10289 ("arm64: dts: qcom: x1e80100: Add PCIe nodes")
> Cc: stable@vger.kernel.org	# 6.9
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

