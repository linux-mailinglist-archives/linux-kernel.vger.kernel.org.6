Return-Path: <linux-kernel+bounces-370501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0EC9A2DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A3B1F238D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA2E22738E;
	Thu, 17 Oct 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pJVqyaZT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345221BB0A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192920; cv=none; b=nl7t+hYVwpiBM7KKdEZOlUQy8+b2Wm3Ocv5JFERVa+Oi6n1FmJByylx60VAwikpl+dewMzJqT2T3cS0ZkyQ92MX71rtXKdaPO2rjTCIXciklVktimZ97JvMwXwjRjp5v+QXiCDH30MuGU8dS6HffSVMnkL4A3RLHYw0xv69KPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192920; c=relaxed/simple;
	bh=4L7ZmfnqHQ4inB9Z+gpgPm0EocNmPhoPmdAappwqQLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjQ6GCo1ktwvdaW8cKSa4Xbl+XYDEqzeoXreUR7grlHUALZGuSYgPYNk4GKJJJMueIbyhR/p86Ul3r54FCpaHenQOVLvZCVRisZuHMrdzMyUWrD8gzIyQWnvYqkPV78Vb/kSh5S4Vftoc7rleeEiYdYTFqFwaLBddieFqyO8YPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pJVqyaZT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HAMJdS018912
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9nKRF51A7sYkC6yHPM9M+rXSCUKjxjSo4paW2jb4gpg=; b=pJVqyaZT04BALCfK
	P0i6usbi1PTwbBgmGJO3eC49KBUjh2aQmLTpP3p5pfEJi7M+V+IVkTxly93ByOve
	CVKIyCocg54yWdaOCYGDXMRrr3IvPQihqUNsVFpPiflKreFL9y9MHelmWOvxaJNB
	8qpSD9PuB8JToqOPgN9nELT11AFP0K1Ggznc1CEqflh4SKEEZNdwSazzN66kMxVR
	ZRjj4ET/+ZEK65jFP6rh5lrEYx4ktkW7j8eeXbvzm0jFTZqVxw6gy+x6StLlT7QX
	F4f6UFlv8IM+LFPx8TiA/rFLGLttpcKT84Ic0LQWPcJ4T6UnQKEXcQRXOrJ0i5bI
	meLLQw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b0rx1k27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:21:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbf4770c18so3428406d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192913; x=1729797713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nKRF51A7sYkC6yHPM9M+rXSCUKjxjSo4paW2jb4gpg=;
        b=S1+pVxWyfS8hyVTb2Usg6oxcqX6Lb+p6lGfs4CulKDWKbv2ioUoj4muc1YMUaQ8Dhn
         /sYbAwgnR1Dc4g9YezFAZ8tdKA5otFoTn6vp5rcKtx0hSy8BsVx4DsO7a2yOyxQPC4u6
         E8ykfZAX7hx/4QRVuF1g+Essu2whoMfFg1748leVTJhpuOK2VjtU5FAP39aNK6f0tD9I
         8Dwk1GTkKZhDvdsl3jep7OnmWtbvDJb6OuLf3W2Yw1SYOLcJ2x1K2hpraazp5G/9qqvl
         t/15OciLO+br/WXWRHGUT6nMO32kQqxn6ZPgDlsi/UKjB+YyaWlabU57zQE+doHuSX4l
         bH3g==
X-Forwarded-Encrypted: i=1; AJvYcCWUPsyiUrNqcD0G3EHaIyY5OWNblLE9cbSd/OOPpdrz/u/+zGWTXRi4IkXlv+1/V4LNXCsr04WGjdaaMcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIr3977XZWwe2ihR8NOaGEVzUv7DNOZheNBFntn2QR6xoHQWo/
	5AtDb20WEEq8kezmgjL9QrALCDIde7zIyA8JAmYIOr7KkNwgUmxAiGaNgs6cVUKuTG2780RgNkP
	GZztX69uMs9EGJR9+w3MZ7eSHaAIO/FrtXPmlCgQRAHMswuyWljW5e//IlXbgR3s=
X-Received: by 2002:ad4:5743:0:b0:6c5:3338:2503 with SMTP id 6a1803df08f44-6cc91b8acacmr3543446d6.11.1729192913154;
        Thu, 17 Oct 2024 12:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHKkijEbj51hUF0cpr/kUmjSFIVMk5Zw0M37NQQx5G9I5J8ivHoYin+f2I9l4ksy2bbLsDqA==
X-Received: by 2002:ad4:5743:0:b0:6c5:3338:2503 with SMTP id 6a1803df08f44-6cc91b8acacmr3543216d6.11.1729192912692;
        Thu, 17 Oct 2024 12:21:52 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bf621csm1709966b.165.2024.10.17.12.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 12:21:52 -0700 (PDT)
Message-ID: <24b13e3c-5c05-4697-9a66-636a8ef46aab@oss.qualcomm.com>
Date: Thu, 17 Oct 2024 21:21:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] clk: qcom: add SAR2130P GPU Clock Controller
 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
 <20241017-sar2130p-clocks-v1-14-f75e740f0a8d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241017-sar2130p-clocks-v1-14-f75e740f0a8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TTv9EUGDe-3FiSgT903C9RloP8y7d9TX
X-Proofpoint-ORIG-GUID: TTv9EUGDe-3FiSgT903C9RloP8y7d9TX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170130

On 17.10.2024 6:57 PM, Dmitry Baryshkov wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
> 
> Add support for the GPU Clock Controller as used on the SAR2130P and
> SAR1130P platforms.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

[...]

> +
> +static int gpu_cc_sar2130p_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sar2130p_desc);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Couldn't map GPU_CC\n");
> +
> +	clk_lucid_ole_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
> +	clk_lucid_ole_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
> +
> +	/* Keep some clocks always-on */
> +	qcom_branch_set_clk_en(regmap, 0x900c); /* GPU_CC_DEMET_CLK */
> +
> +	ret = qcom_cc_really_probe(dev, &gpu_cc_sar2130p_desc, regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register GPU_CC\n");
> +
> +	return ret;

return qcom_cc_really_probe without printing

Konrad

