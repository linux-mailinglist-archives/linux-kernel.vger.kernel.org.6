Return-Path: <linux-kernel+bounces-394733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39139BB347
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA11A1C2126A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCBF1B4F21;
	Mon,  4 Nov 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKCb5aEI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0751AF4EE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719443; cv=none; b=rZCG/POrSsYqHR2YEcrCbrT0TElWBa1Dr0tY1CbECjv+7tCPiICny4CY5einn7SEgnjECSeNmSadG4e1InQQn3pLvNVGDT44xZBw/jJjVGwpHsfkDb3gLkaGarqE69qebsqhXoJiSsZksyj/Nry3aEfqxK65WllncuexGLESWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719443; c=relaxed/simple;
	bh=xLzCK0gJ1iwWKUvurBIKQQtzsGZGYgwutypt1J8FGNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHMEIzg1sS+FNksbmvmAUfZT5Fv3ONEVCG9+0yWcyZWFiyH18IQ641osytqoorPmj5RImD23Ok8xTlJSUjkhljOFIzXEGyH3DwhMRvjsnlnOiYzHKJKn3Lxbd/Hbrp1aQ/moSmNNPNEuQkxiL/pEZMrG2l4pxYyGLnHx1IaPMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKCb5aEI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3LR02F001350
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 11:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TF+iiDcvK+zCyJegCXN17oSb8UYE+XcwDcU3Zz59S2s=; b=oKCb5aEIL3RMlioR
	qa6Jk0ECHpAlh74CH8u6uPvxd34+mkBwEidnYLk7byz+iXo1BkIS+7K7f/q7zL4b
	VrMgVcJABrFfFUCG9/09uPhbHThiHHkxw/5iOp+iYBN40PWyOovVa7YaiYctwPOW
	7qg864oYiyy4aJubfIrQl7lRBMqhuQvh+h5u2jqkeffmnff0DqwZYX7rVr88ORmX
	tnx0Q5oI0PaX79vDJHg/rJRVsnhyYO7ziS13DtCyFzHslb9YKsNfgPIUZoNFBFsV
	aaGqS6gh+Ye9aXsC7o51GxGP7WCWRihsnirpld4ROF74DnjlSeh3oMZhcUMbRWAc
	Q9N04w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2s406p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:24:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d37d9868b8so129066d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730719440; x=1731324240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TF+iiDcvK+zCyJegCXN17oSb8UYE+XcwDcU3Zz59S2s=;
        b=GDUH4QFc4FvTCURL4iD1XTX4E1cBcc+SCxLcEcA3qExunjQ/pf8zAO22Z0ZOoqMGo5
         gbA8AYZ8B21ZMTs2Q5zNswGlSYMcUo5xgx42jDgGgJiLrdPzZMNo4OxXgz5uwxJcc38g
         1T86kA1VWlGzyTfz/0eOUYTWDsKHM7NZjTbTKUjEySbtYO2HsuQ6Za13a2jFJPmTTf9D
         phrvbW8vrwQyN9SlvpBDETQmRymuUhNxZoQL4ODKKa/s5Cc12XF6w0wHzEZbQh3fo1D1
         Ct0UnYAz8UHJ1wIYIQwzrRmSfNoawc7vsYwVeYMngnWp4CsOjgB1EiUidU61H61Fh8MZ
         9rGw==
X-Forwarded-Encrypted: i=1; AJvYcCXOnFkz7wgWahmPJCXuElrvy9fHtxe0V13Bw/iuyE0IjLAW60Vn1aGDnYeCbeLP3CY77cVCaFt7nN9SUcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTRjJm2kAkfdIUmo+/FcfUiesgBSe5fIeAtRZsElEmhjdBRUZ
	vUetERhI57gJWsVdGoiectfArE5f4bteLHrLpCEvC3GBqkTJ3ftm++lEg38ti9NGnJYvbiM4h4r
	q84OfcUFkf7mrmRzkzM5DMnIkMP8HVAHlKR2v4F36Tyw5zG41yHeD8eJAshor6mU=
X-Received: by 2002:a05:620a:1a24:b0:7b1:49d7:85cb with SMTP id af79cd13be357-7b193ee1bd5mr2223295185a.3.1730719440167;
        Mon, 04 Nov 2024 03:24:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGInlOz/Y42e9WPGujlcn2EJYqzxHGUS5ONoZMnslvOpro7KQzonYFvCMnoymHwPLtzE5RZuA==
X-Received: by 2002:a05:620a:1a24:b0:7b1:49d7:85cb with SMTP id af79cd13be357-7b193ee1bd5mr2223294185a.3.1730719439852;
        Mon, 04 Nov 2024 03:23:59 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565df8c2sm540383866b.102.2024.11.04.03.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:23:59 -0800 (PST)
Message-ID: <02171841-acd3-4f26-987d-1376caf11481@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 12:23:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: qcom: scm: rework QSEECOM allowlist
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org>
 <20241103-rework-qseecom-v1-2-1d75d4eedc1e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241103-rework-qseecom-v1-2-1d75d4eedc1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XVvnhlhFz1s9t2eqHKeSTF2QpUInkSoK
X-Proofpoint-GUID: XVvnhlhFz1s9t2eqHKeSTF2QpUInkSoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411040100

On 3.11.2024 4:37 PM, Dmitry Baryshkov wrote:
> Listing individual machines in qcom_scm_qseecom_allowlist doesn't scale.
> Allow it to function as allow and disallow list at the same time by the
> means of the match->data and list the SoC families instead of devices.
> 
> In case a particular device has buggy or incompatible firmware user
> still can disable QSEECOM by specifying qcom_scm.qseecom=off kernel
> param and (in the longer term) adding machine-specific entry to the
> qcom_scm_qseecom_allowlist table.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 9fed03d0a4b7e5709edf2db9a58b5326301008b4..6f70fbb0ddfbf88542ff2b3ed2bc372c2f3ce9eb 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1743,28 +1743,23 @@ module_param(qseecom, charp, 0);
>  
>  /*
>   * We do not yet support re-entrant calls via the qseecom interface. To prevent
> - * any potential issues with this, only allow validated machines for now. Users
> + * any potential issues with this, only allow validated platforms for now. Users
>   * still can manually enable or disable it via the qcom_scm.qseecom modparam.
> + *
> + * To disable QSEECOM for a particular machine, add compatible entry and set
                                                       ^ a

> + * data to (void *)false.
>   */
>  static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
> -	{ .compatible = "dell,xps13-9345" },
> -	{ .compatible = "lenovo,flex-5g" },
> -	{ .compatible = "lenovo,thinkpad-t14s" },
> -	{ .compatible = "lenovo,thinkpad-x13s", },
> -	{ .compatible = "lenovo,yoga-slim7x" },
> -	{ .compatible = "microsoft,arcata", },
> -	{ .compatible = "microsoft,romulus13", },
> -	{ .compatible = "microsoft,romulus15", },
> -	{ .compatible = "qcom,sc8180x-primus" },
> -	{ .compatible = "qcom,x1e80100-crd" },
> -	{ .compatible = "qcom,x1e80100-qcp" },
> +	{ .compatible = "qcom,sc8180x", .data = (void *)true },
> +	{ .compatible = "qcom,sc8280xp", .data = (void *)true },
> +	{ .compatible = "qcom,x1e80100", .data = (void *)true },
>  	{ }
>  };

+ Steev I think you had some unhappy machine

And maybe 8180 Primus?

>  
>  static bool qcom_scm_qseecom_machine_is_allowed(struct device *scm_dev)
>  {
>  	struct device_node *np;
> -	bool match;
> +	const struct of_device_id *match;

Reverse-Christmas-tree?

Konrad

