Return-Path: <linux-kernel+bounces-445756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB979F1B2F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA0D188EEA8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F081F1900;
	Fri, 13 Dec 2024 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MYNvWB6p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4161F03CE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134266; cv=none; b=FLwvRUPuyNf3qEujOW2rujdTFeOmz5w1qJpYGCxL9d3GI4Og7hPXLsTtFn12tMRhs83/trWrq6ztJi6juAPdEJt3U6GvAxFO6JIS2+dSuc/Cyat+EkYDkh0VBfcZUQ5sJTaECyv4y7Ffrcge1lQJJXQzfV0wAYId9J90gfpsA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134266; c=relaxed/simple;
	bh=LYdPQGswu8DVIF+KYEYRGj/aA+V4ms+9iQMh2rqG9ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRNjNB9a4c4tY0NhKK8y/r1hSqa+YiHE47QJEiJYICr10ZQDh+/a3IYwEj1GNQW9IvuxTP/RLYZNLVeYRDcIyXI3c9dkz0Gcwnh0L6suEhY7n28FX/ODs6LuYXhtW2kidddB5n5ZIvLbChjs765DEs7PoVBs++BP8qwzhTiVhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MYNvWB6p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDJUdPs022791
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n+UpY+SzgpLuXHX5fnR2cKEgGvVPipA5R3mDTkxv6gI=; b=MYNvWB6pqzA8YBtB
	U80Hl76jUF9GzAkU861jk1vHXCRQRGEX0Gup3B80NtMqA15PnzZtKonWPnDxxa9p
	WBvaakAOGAP3PHUh3ucFIaVhNtLSDcO3bOhp2GTe02FjqppNSkOhK0rTccxHWfiC
	xAjreDceXuGIICi2dDGKh7nGtf8mUqnwVLmIBDMakrAes8fykOTY3V91MIG3QM8r
	Z27cr2U8JzXU3uNR2j5bQnoF8EVgvR0C7erAxPZX+l+2ejYEVtKBj7G+3Zk+/Rig
	q3GtxHiltpHPShWsuWduZhNILVFu7F17M9xKRc0gIXlTyv3FOahcFxWARwOyukCA
	ZOuHdg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g4wnbw7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:57:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4679ef4565aso4646091cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734134263; x=1734739063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+UpY+SzgpLuXHX5fnR2cKEgGvVPipA5R3mDTkxv6gI=;
        b=ojSgisKUl70Zj8647lJmq52HJGDXKEWmaMIAQmwhlGyv2vm88ZlMfBWuqV5LT1NKMl
         vsRkogJMMmGEwRawJKAod+xWuoDtoO76ebVatgyG6xH/ikewhLkufLPtJetTLnCSmZ+A
         7O7IYZIDFLWRst8Mle4Fu+1O4J4KbI9UYygCrna8hvBGnPlXmXNotdFfm1thU8mGjpk0
         uO043+5+7t4x1e9PquFKiQSHdmVpKs+xZJqeD8F5KHIbbFrUks7+ThG9okHBrkxLLtHr
         vGOnLAAo7nMk2JA+venzAC833hxccRVNmaeHC3eiBM/JbkgvH9AwyOJ1rDs78iHWmHZB
         vMdA==
X-Forwarded-Encrypted: i=1; AJvYcCWhdXZeJmUIfVTgxZ++yh4WysgSH49sqkTixOuLjnriQ3F+/nA77m5cSnVODLsl3UlNjQPcZSAMCE0EdrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtmeXaYdEy717BNdz9/Xnr1oI0UFkdDAs1xCCpxRUuutlaxCP
	8jfAYXKODquI1A6Ol2M9aaZdMk5ru0uxe9V2wmp5JntrFSwI3beFVLBoP0tMd9NB0NVtD/7tfMM
	3hsiMqHADpfVujn+OBQooZj/4P6Olta1ediZeXazsrmlvkBxcuhBUW7z3eT8NNV4=
X-Gm-Gg: ASbGncvwjl1BANuKFJWwIHj99SnG9jnuXaSphudvEwbfdAvP9ZGH5AZBwda6/SZR52r
	ZqqO0oMMFIMuHG3U8jVsCxxiVUF9cWDPfC5Uzu4t3WleAilE5Y2nf9IXuSxj515qgSHAyclWmAX
	6E4L7vTWEDSPa5FQoZ4w1aqXnrVDxq3QNXMjqxGNN8STlET4ChT2hB1HRjixQRGWy4KAPI6X3nf
	jY+sbkB2+0prKq8JqFOx54AHlycVtgslMs7M0IDZA08+H/3ZNcYaX9DeDDvdAAX8Pm/Zh5ne0fr
	XAYXREF5SDaoVAAeRkGAUagpWlD3+CJ78Go=
X-Received: by 2002:ac8:7dd3:0:b0:460:ab1b:5ab7 with SMTP id d75a77b69052e-467a5802b48mr30420301cf.12.1734134263196;
        Fri, 13 Dec 2024 15:57:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdf07u75lgXuB8ZdoFrHC5spOJU69BJNvJrmuLa08Zpi6Yb/7k7QK1DNmiKZHesJkLk+XaRA==
X-Received: by 2002:ac8:7dd3:0:b0:460:ab1b:5ab7 with SMTP id d75a77b69052e-467a5802b48mr30420191cf.12.1734134262883;
        Fri, 13 Dec 2024 15:57:42 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae11e2sm329712a12.39.2024.12.13.15.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:57:41 -0800 (PST)
Message-ID: <db6ec08a-7810-4624-92b1-ea922a2ee103@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 00:57:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/14] arm64: dts: qcom: sdm845-starqltechn: add
 max77705 PMIC
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20241209-starqltechn_integration_upstream-v8-0-ec604481d691@gmail.com>
 <20241209-starqltechn_integration_upstream-v8-9-ec604481d691@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v8-9-ec604481d691@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JoYdIB484CB-0J0dUOn1FbskmMXVJiad
X-Proofpoint-GUID: JoYdIB484CB-0J0dUOn1FbskmMXVJiad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=723 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130171

On 9.12.2024 1:09 PM, Dzmitry Sankouski wrote:
> Add support for max77705 MFD device. Supported sub-devices:
>  charger, fuelgauge, haptic, led
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

