Return-Path: <linux-kernel+bounces-525698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB1DA3F34F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5709D7A85A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4FF209F40;
	Fri, 21 Feb 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M61dVp5X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA032080F4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138602; cv=none; b=TBR00soAii1qsiijzFEwp0EtdyIc3DVp91PzdGNmpPVTbHUSGw0rIr/ambi4wS/uRwZDflR/8FHFVWfFaj9AlC7NQZowVoGcUVGJXBZAo5VKoq4LOmZIwyXvgoaWX3yleREs82xHlwJ2VeFf55urip41vR6vmlMHFOMQFswBA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138602; c=relaxed/simple;
	bh=kTzUljDZfO4SYJEnW61vBtVvH4VVgI26rpadfVxj8w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwHLz3AQMwWJvfBLEMCT/a8IwDyAHkToq+TIrCJVcDhXIEMzE0zZZ6SahO3mKGW6Bx/0bwW7KtaZPjTiySm5Y5GBFXkO0SA5oXHRwJ+zziiorualuUKdek8Wpkdq7d044hihXmi2GjFaqwgRGNM0ccMJFD6R1A1OmQ4FgWdtLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M61dVp5X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L6IMQM018834
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DnXDRqF+7jHzdDMYeLb1GVbJJ6rATcvBORv64B0RqgI=; b=M61dVp5XtBGhkkwp
	8CbLNOfzXQrnd53lUnvvdMVNlkywZ/HhEYrfQN3qR3owj5i+8x3eS4oozFoHw/z6
	+wYDslBszqHDV/EQLZ2M8QPbZ4Odk6axqOHlY7PmBAKgp4RKn2up5hCXI+5RHO4Q
	86j0pwVN1uKvCgZh/EYhuqYF7As4E5PhIbbwW6TJdX9PmBKvauGWKnt7X2ITDgRO
	J0tlfsLiMpyP3RRojHlDYHKG+fGSzB+JJoFarZ8BADu+Rl/jvoltCs8gbnk08s91
	U9D6hrQqTcOgx8kpZiKyGrmvD5uc6SKAj/FeT8bJ6KBVEDlWVhls7levwHJiP9O1
	HCsxFQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44xm3rh41m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:49:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e665343a70so3198656d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740138598; x=1740743398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnXDRqF+7jHzdDMYeLb1GVbJJ6rATcvBORv64B0RqgI=;
        b=o8XN4ZzDkgeEnw+hdPZOMxlGbO+gSqCNh3dzKXLEix9BJpzLSrGgbgX8EQf5jTq5Gf
         CxiVj5SQRm4ITRPlJtffSlMiBO9hutaW05FhRyu1GxpPKiknCMsJkVyNu/vhyCxxOzRh
         +NTshJ4CSkJ3es7r5Ja2fbsFpwVJ1LRcAiciG9pPP6pG/lPzFTWgopD4Ok17e+YqjkHT
         oAMdJSCSM9HnSsfxQ93YSSI9CjIM7k9OWz8M9ZFt49myfuXFYSlBQ7l9XCq/LNEJDdib
         bI9saNWT2y6iPkpmRwtX0oKMYXYLMtLTc7KP+1cCjwKDywpCSjTzpy55ZcMr5qW4C0/C
         +COA==
X-Forwarded-Encrypted: i=1; AJvYcCWjoxIjv7Kf85DkRfgIrkyfmt7YrfeqaEfj/r2NXldXdk9Fy+ifhs/f4XU2OGA4wu7+W4D6Rr08KExinJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKxkiBAPz4Vo3ORAYBdMaDBBRSbPC2ehfW/W0feG8XwQ0kUOA
	8j2Icvt4M9Q8ih7Kebt5N1BAnTlnV4wPlVpNUFD7f4JRmZrGhn2JdMMbdvkXuwiFngYM+BI0hB3
	TCN1pSHNj5ZtfB5zM5Ny5LKShM9BAd8P/zOVHsBX/+PN40f1Em/OWMBbOK9rDf34=
X-Gm-Gg: ASbGncv7n2/BHT17o/9YDYQcf/PaaxXdAbdROyaSKT8i1qCi+jSXqH9feieau7Afaz2
	LrHy51WZ7b1a8nnDoDjhug3AJmcFbnDpo5jORtxduxZeglnQUkP6CTA2HOCDcQNBm6Sum5LigyI
	4h7ZO/wYQSAr+N14JsBT9ggIvU9rRMJnpOcmnlAk4bqDRa5PcjzgUg2I6s0pQN1Tx2fruHQjfcR
	131HdLzKqTDVUHwqreXRxVNulDzo+6VJ4aK4yZ+cVnbJIwVlTCRX/I0mFV6maaIvkbPIjlay7lO
	i50G+NZL6KCJXRMep0xy+bOY2Qft/m0vyDwjsza/zOcV8bbDC6DPqtrXM5YQ2j1SlZx2Yg==
X-Received: by 2002:a05:622a:3cb:b0:471:f185:cdda with SMTP id d75a77b69052e-472228d9e7emr15401681cf.9.1740138598209;
        Fri, 21 Feb 2025 03:49:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz6tjScwFqnyjtrUPjnhi+ssj2b9sF0tanjJCBHYaWqQMsLgwvd3nnPdcpK3+hrUaFc9rY+g==
X-Received: by 2002:a05:622a:3cb:b0:471:f185:cdda with SMTP id d75a77b69052e-472228d9e7emr15401471cf.9.1740138597834;
        Fri, 21 Feb 2025 03:49:57 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f59sm13554823a12.6.2025.02.21.03.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 03:49:57 -0800 (PST)
Message-ID: <3bfe9a79-517d-4a27-94da-263dd691ec37@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 12:49:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/6] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
        quic_tdas@quicinc.com, biju.das.jz@bp.renesas.com,
        elinor.montmasson@savoirfairelinux.com, ross.burton@arm.com,
        javier.carrasco@wolfvision.net, quic_anusha@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250221101426.776377-1-quic_mmanikan@quicinc.com>
 <20250221101426.776377-5-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250221101426.776377-5-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: z9-KHHnBKt2uihNNqKd7uu6uZMIJTWnO
X-Proofpoint-GUID: z9-KHHnBKt2uihNNqKd7uu6uZMIJTWnO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210087

On 21.02.2025 11:14 AM, Manikanta Mylavarapu wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Add Networking Sub System Clock Controller (NSSCC) driver for ipq9574 based
> devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

[...]

> +static int nss_cc_ipq9574_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_clk_create(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_clk_add(&pdev->dev, "nsscc");
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Fail to add AHB clock\n");
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;

if /\ suceeds

> +
> +	regmap = qcom_cc_map(pdev, &nss_cc_ipq9574_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);

you return here without pm_runtime_put, which doesn't decrease the refcount
for core to put down the resource

if (IS_ERR(regmap)) {
	pm_runtime_put(&pdev->dev);
	return PTR_ERR(regmap);
}

instead

Konrad

> +
> +	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
> +
> +	ret = qcom_cc_really_probe(&pdev->dev, &nss_cc_ipq9574_desc, regmap);
> +	pm_runtime_put(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver nss_cc_ipq9574_driver = {
> +	.probe = nss_cc_ipq9574_probe,
> +	.driver = {
> +		.name = "qcom,nsscc-ipq9574",
> +		.of_match_table = nss_cc_ipq9574_match_table,
> +		.pm = &nss_cc_ipq9574_pm_ops,
> +		.sync_state = icc_sync_state,
> +	},
> +};
> +
> +module_platform_driver(nss_cc_ipq9574_driver);
> +
> +MODULE_DESCRIPTION("QTI NSS_CC IPQ9574 Driver");
> +MODULE_LICENSE("GPL");

