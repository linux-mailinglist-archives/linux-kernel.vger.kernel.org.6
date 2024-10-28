Return-Path: <linux-kernel+bounces-385301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DEB9B3547
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E553A1C21CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9511DED6A;
	Mon, 28 Oct 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IcWEXDaL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C11DE4CD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130502; cv=none; b=hKerT86xCYc7fWzA2P5K1rpLTx7mzaAbO46pNmh3nSF5t9qXMfO46zwADf2vbKuH3tscX93htxFObA/x9JVyapUxvh1AoiUif4aX/5YK12hurroKEjF5CHAy/Y++SGcluxWDPylFx/zD5CIrX6F/+9UYEDWvBK1XAgJpJS9G8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130502; c=relaxed/simple;
	bh=yewPL6RAQN/qsQyAN6o6JJcIxZviifg50h1waNJD+Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LS4L4ZYd46SL8XVP/KuKSB7CgkJPE/XU4/nQofX5UUyRiy0NB3m4ULfKztkY8FCYQhAgekcebyKLWzW1S6PmYPf6Pnp0Hy57jYgxchtYJA7+/dXQgFlSuVakm+6fPXYQiWci3Qjtm1dc6QWen+zTmQEfd2ZWJ1DScDZ8AC+twNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IcWEXDaL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBG0A5027417
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/58fdUl81gFK5gfXJtlXmfqlYLl0O3YuDyMeSmWJPOo=; b=IcWEXDaLUGj3CLSV
	A2rg/n+xLYvnptHJB45+zOyFMy3QgaJKPRUEXw/O0G+w9OfxTzj4hmlCLcKNCaKW
	qWSmaNv0eqke3VnjSXcYelzCfsL66cCRTxLqQ/EvVMZfoGw1zMooIljOlZt0ym/I
	t8VPta3InV01IZfIIeQsUgrQCMp+9tuxCFDbyHV+ay0etSNWGIbZ2RLSUgM5EdZN
	Ejid9de1u1IJcQN7zuez872js5j56Vnnw8tyaloQI7J/5prLyXMgr+ThbC7UTOuC
	sI8Xu/i3jWyBCJJSC8PgXaw4uZ9IjggKL/2ERrL8sowKmKfZ2JAH6Qkurc/fI4iS
	So77Xw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gr0x5ffa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:48:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbe40565feso13859966d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130493; x=1730735293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/58fdUl81gFK5gfXJtlXmfqlYLl0O3YuDyMeSmWJPOo=;
        b=tSAZAuPGQsvfbQFduqqM3j9UobYFlTvk6ll58BK5ReoTbOzmM3FynoclbUKTxseiUi
         D3fEpPbhjiuIgNQTi4ZA5v8x1SciJnSDoya4wVowW0u92XG7g5BylF0mYzliq86pgc8H
         nJWRY0DKgCQf191JeKSSR22e3tqrKKC5XXwRumN+PZcmQzjyl9tt+nFIrYwBtgMcVCdP
         iuFFT759aKpdOA+zm/3nul5AhEL6M1uRD9whQGDC1Ub03Pfq2DyRLQtQa7q+0F+FaP6d
         mXrJb9egexjj8NkrmXsypsjJzjteF6J2u0mguOticO01QDCep60HqaekBwmzcJpxp85A
         OxUA==
X-Forwarded-Encrypted: i=1; AJvYcCXA7ebECJMIHuPjxOcTsm6uvBlGGz/76fMqhNLiae4QbqUbRTwOTtq5Npu+or5lgbzOEC/x/8WVtBtgp64=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0ZcG43t8i8Jpva+qvQk95nJG2lMl38LOhuK0qvq2nPGGxDYr
	ftY3MEiUxPTMtCZuvflMJmxw+1ffiUxM5CWZ7JJz3KC3L1oWX1fUD6TU8AyqewqzjoNpRPO63g8
	x0rHv/9cSXSMBbsFk3ThA9c5K2yZwT1KdSdQfKz8Hh62K7cmD5//IBtWzfikxOOg=
X-Received: by 2002:a05:6214:2a83:b0:6c3:69f9:fb5b with SMTP id 6a1803df08f44-6d18557af2fmr62944106d6.0.1730130493350;
        Mon, 28 Oct 2024 08:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYDnCOLJ3BfLLy6KxWBHD4WKEqn2ar7UApj80HRgBEYfdeZhp8Jy7POsKHWgWwh4hH6SEBDA==
X-Received: by 2002:a05:6214:2a83:b0:6c3:69f9:fb5b with SMTP id 6a1803df08f44-6d18557af2fmr62943966d6.0.1730130493025;
        Mon, 28 Oct 2024 08:48:13 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb63197d5sm3253197a12.72.2024.10.28.08.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 08:48:11 -0700 (PDT)
Message-ID: <b45c00c4-415e-459d-b8f6-1e5b0d6b0856@oss.qualcomm.com>
Date: Mon, 28 Oct 2024 16:48:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] soc: qcom: llcc: use deciman integers for bit
 shift values
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241026-sar2130p-llcc-v3-0-2a58fa1b4d12@linaro.org>
 <20241026-sar2130p-llcc-v3-2-2a58fa1b4d12@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241026-sar2130p-llcc-v3-2-2a58fa1b4d12@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: E9Ifv30bERnw4KMXkZ9a0WEdHz5QXB36
X-Proofpoint-GUID: E9Ifv30bERnw4KMXkZ9a0WEdHz5QXB36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=683 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280126

On 26.10.2024 5:43 PM, Dmitry Baryshkov wrote:
> As pointed out by Konrad Dybcio, we generally should be using decimal
> numbers to represent bit positions / bit shifts rather than hex numbers.
> Use decimals for consistency.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

