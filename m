Return-Path: <linux-kernel+bounces-433688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392259E5BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CB31885D42
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69177225771;
	Thu,  5 Dec 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KA9M18l2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A322259A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416946; cv=none; b=KXKjkDELpPMDZy2/XrMCK2RqXPr75F9KhWU4JdByxEO5VmxQ0LJstupX6f/TDuf3xZ3bbgCmQkwfg+RBNEBqpsff6Se0W7YCmcAy6nhxSfm+6UQEoUGcsOwHHdrNyliSWYmwu+C1Lm05Y7xzUmkaDm+0YpPbrmrO9nk7c52g8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416946; c=relaxed/simple;
	bh=YoIne7vvuQzD/krGsNq203kmkbajQ888PwHlJ6Utetw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ5+o3MFI7jVNdTOwLY7jQVzkfFl79EuMYtd9T+GKrhkhuV8GzAGD2HWOJqJ1k++hkwGjY5vhPKZgd0GP3nDHRljbce9b3aEJJGqAp1k1DobiBlU30YVzdtr62OCxhTwKZDPfOakdSfqJBN59MwLTPGSen9qXcvEMW0YSTZkJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KA9M18l2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B582FuN031005
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 16:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	195rNMnFRFqaI+PV/NYZby6CtC//SxLeu1vnpcp/L1Y=; b=KA9M18l2X392TXKo
	KP/NHacav5XdCb0OeSbwbOpidYjhL5xIwd+DKVpgd17FoJC1D6GCWBo70Sh7Udqe
	fGq0X53A0dvG+VCjmSg0MIdPTwpWw4wV9EaNkS9BjDcrMGMsUQ6phSHom/gtoJJ8
	JRYN8j4IQh0zjP70RhnuyGND/y+W+0RuFXXu3XEQZAohjZ9HwbAJDM2bMtAjrjg7
	TnwJqQi5SRELrd9IOlKDwdeFRxuBioBEZjqIl1NmwvVefWykqWyaC3EhojloLQbz
	+qwK0kFPdvwmRmt3cVpai/V/OiW+mEMJ1z4qYn2/JzovCIWeB7rBfbB9+VI+u/Rg
	2tOj8Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w9108v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:42:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46692fb862bso2290571cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416943; x=1734021743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=195rNMnFRFqaI+PV/NYZby6CtC//SxLeu1vnpcp/L1Y=;
        b=T2LfhgGpa4xQDlLgvHVFDjY7j8FDPCiQ9OgGtSbw7o1wJWuT4M7wFndhSy7xLYzZ4g
         xSHdB7f3HNbucIoFx346U20oEGBZpvamF2Shq45phOnsOBqLcYx4LyBkPj/hplagj8CU
         Ivm011iKreHl1WjsAAXCMvuI0fHL8SQw9/asVp35GOx9pt4DShjMmzv1Fy+5Dp44hJ9+
         wTaLpXl77xPt73VrMHO/BXvfDwSpTSea5MHyFDvKnyJp6bz4dacA2EquH57alwQ8dKd5
         4FIvsFGeVbZGmqYIFoF1QGiBb1h4uDw4i/2e/hLalVrQ3Y1C2F4aHRlGVgPSD4SOepAR
         /pVw==
X-Forwarded-Encrypted: i=1; AJvYcCXGsnoN0C6/qbHFQayybknvC7xwly27puFyMi50ghMBdUNXY9ocCb2S2ZpW2mRT18hEaFV4rc/+ss/efSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvFAfmdUMXmbOM4K4gfbrUUvORD2rTWqBgF9OUM9mM/SGDHjY
	kQlIaGfZu1qwp+EXwCfMctjrU2otFhQou5tdkOsnajQkbrLWUqbG9Jk3v2a2xw7aX1FL8OPienu
	Q8b2ffERkQnVHJ2oQe9LadDhGsN7BhlebPH0nRKmj0pUtqxCJYJ5XxBReycAa+tI=
X-Gm-Gg: ASbGncukDJCqqNEhkYBZSUkTuL4IVoaNfEnw4r7NVHKrRqDrlHmDXCstKPtSu0iY5xK
	6jD/cmJjOLRRlUUHUckow8YIx/j3onexeqVKnnDIYpgUtVMqXQ8XTRsjBZx3RioD6xfZQvvaZyt
	bI55jFjw30OLKE0ub80TJPHW7o60TRMeb/zf+325ZpfvRXkWpWcB1Hgov1ff+5FBV3FN1xoDXfJ
	by70XlKnLUv2nhRw/fo26gxhvAx17dlO8S91cco2KhiCNI0EGvE7clkAJGD3yJ/E8B+4OmXgPZP
	Bq09PhMYDx9L0P96eDDl23VDFhKw1qc=
X-Received: by 2002:ac8:5d05:0:b0:464:9463:7475 with SMTP id d75a77b69052e-4670c0e87femr78657321cf.2.1733416943327;
        Thu, 05 Dec 2024 08:42:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF6Wp3sPBMj5Y+ZW5+UIOvFWsYeIm7XMQDpvK+k/dFdEkf3tlHHHeo1Dqk42jNKdyMbri7qQ==
X-Received: by 2002:ac8:5d05:0:b0:464:9463:7475 with SMTP id d75a77b69052e-4670c0e87femr78657031cf.2.1733416943000;
        Thu, 05 Dec 2024 08:42:23 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601f4adsm117466466b.128.2024.12.05.08.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:42:22 -0800 (PST)
Message-ID: <cd121bce-77e1-4139-9317-3a43c7e24ca3@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:42:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/14] arm64: dts: qcom: sdm845-starqltechn: add gpio
 keys
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
References: <20241205-starqltechn_integration_upstream-v7-0-84f9a3547803@gmail.com>
 <20241205-starqltechn_integration_upstream-v7-8-84f9a3547803@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241205-starqltechn_integration_upstream-v7-8-84f9a3547803@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Hgc2cowT6BwIpYNoqUDElxQwoej6qD9w
X-Proofpoint-GUID: Hgc2cowT6BwIpYNoqUDElxQwoej6qD9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=825 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050121

On 4.12.2024 10:34 PM, Dzmitry Sankouski wrote:
> Add support for phone buttons.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

