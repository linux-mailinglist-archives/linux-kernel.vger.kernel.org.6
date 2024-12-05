Return-Path: <linux-kernel+bounces-433769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A39E5CCD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31643287B18
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE522227B8E;
	Thu,  5 Dec 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KtKGDj2s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C732224B01
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418896; cv=none; b=PO/Dtja8RLmvKO9+WAH9La34dr65Aq64Ps6CfdgHtKMJGwghLGYfrRY2cR3v3my7Zm1QfzbTr4HBf8srCFIbiyTtiwCImAO4QSISF2YV2U98NOy6rpoOdJQ9oN9prlMRezJsvV5YOppl6l+gW/nwBHA1UqqXllK4riaFxyZ3qaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418896; c=relaxed/simple;
	bh=banyuC+L2GNhTvM+FaeTveKxmVu72NKyMITzwe600ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vC5DlU8O+cLM4q21pyrYekMx1Ic1UHO9vbD/Bmk8n4nWYrG7/NbHMSUvKgQA5MpSg/zwjs3gCJyYjLKNFcWk+4ajy+oefDEhMjlv6LPgAk6PrIzxW0YUplUBL/FXnX62zveUrwkuIzd+ODGlKNnxoldTNxlgmYgxUbp2fgRq8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KtKGDj2s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5Bt1rQ025664
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 17:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uGB2VGYlhX305z9jWjglG6rpxzgkZKcg+qU0mnNMISk=; b=KtKGDj2sRAbHxqd2
	HJTodTKpseHicN5sBIFn5SVMufRHF5XN29jh2U1Fnos89L/H88OFWnfuzJwLE4Ty
	DN6Yuhy9GrYyWO5xoy5ELBLCjuHPyoOJ9hOEArFVYpG64aVVRK1DbL8zbbLICqAE
	5lTdMtODQ9FnX+wAymREQTHtJq9oYH2rktcqB1ObwB68k6I1H/vvcT86TisGNdb5
	SPAGDEc7eU7YB5JaD7zZrz3aVnmUfHgH0eJDILlmiTzJR6SPdDD8kelNzTr0tAFN
	Tn1+jL2X/s6LqP9jojq2Mcm3Bv7JTDWqMS5xzTJJ5NLzq2LGnNzyZfvA0AP/8c4K
	A0v7KQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbqm0vg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:14:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d881a3e466so3063166d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418892; x=1734023692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGB2VGYlhX305z9jWjglG6rpxzgkZKcg+qU0mnNMISk=;
        b=f91tl0RaC0RbI7u6OW3YRqX3P6ko3dPlXUbff+3jmY2PGWXUN7IHVyv7aSnsb/ca2y
         pdf/1FzeJAwjTrfH6xcOzPGMfHMwlcyg1v5TqkUqEzX/20Af39C18WLf/NyszXam/u5K
         NBbUYbFlro6EcxccDLPzTP3nKObyCVSWXOlizFyE0Wua1nl/LvVXY9k2lrlARp4Q/Oca
         dv1HQEtMR8Itqsd4WOKptXT9cHoSH9gl7wpmtAo6SDWbVb/i+5T2QSYW23hE1brwDgoo
         DmSJYhNphXSoAJoZuT9csgYruu60z2e+VTodqlRozkOr36a+K/7UNTrCvRDdYbhaTnKp
         zREw==
X-Forwarded-Encrypted: i=1; AJvYcCW1Osjfjr5Xd6kNGL5kEi7Hgc/zEMZCfWuEURP1XNvnTL3ARe22JyGuzmjyoaPM1T++Uu7/4SW4FLnfEVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyqyZeQ0x5L1WVARyyaEzMaqAw52DPPn6sLGNVLbEh81AdxLg
	dQN4mKAd+B7eK/tQb8aNFdIyicWAAk7NVxJHP9f/csyXJb1afCFS40ofN4/D0KOiGcem/YKJ1tl
	lYGJjyw6InJTFeG9NL92C9fK03P37RsLCBU4qK4B9FYFVVNO/lGlFN13Gs3JZP/u1fM++eJI=
X-Gm-Gg: ASbGncsIgt3MwC4hLTALn+k9PsKRL/2sJa78adWZo1dYfENpE0VdPopwXFKHbLRmMke
	372ZszSK37XbY/pWEB5dzgICZZuUg8VtEELaR06enJFUJDfQOiTTxYONg73jW6bxWHsLlxzqwEx
	h7cc1OPDP1iLREoouPMN0/7T4DtTyYdN0KYfpmLpIPKQUXSXXXfi7Hno8FYnqBPVyGH22r2SK/v
	lS/jPMaUmWDxpLONpm7F+D6TxBNnXr73+s1h4lDk9Si7jrZdBNy867rixTqi1jOa17m1AdllE/A
	s+gfyE9qeOR+sLvneE5iy4m6YMfezxs=
X-Received: by 2002:a05:620a:440b:b0:7a9:b8d1:a26 with SMTP id af79cd13be357-7b6a6c31924mr667658785a.9.1733418892281;
        Thu, 05 Dec 2024 09:14:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpQFNNqg7rmu42uahD/Dvr7J0nOr7rhzd/cZhlhHw/kjUQf8AX6RuhDb+fboOYZ38o76LA/A==
X-Received: by 2002:a05:620a:440b:b0:7a9:b8d1:a26 with SMTP id af79cd13be357-7b6a6c31924mr667656485a.9.1733418891922;
        Thu, 05 Dec 2024 09:14:51 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5d2sm119571966b.93.2024.12.05.09.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:14:51 -0800 (PST)
Message-ID: <1ca062dd-8910-4caf-a133-0e5717b43540@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 18:14:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: qcs615: add WiFi/BT nodes
To: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: agross@kernel.org, ath11k@lists.infradead.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, kvalo@kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, quic_jjohnson@quicinc.com,
        quic_miaoqing@quicinc.com, quic_vgarodia@quicinc.com,
        stanimir.k.varbanov@gmail.com, quic_jiaymao@quicinc.com
References: <20241203060318.1750927-1-quic_yuzha@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241203060318.1750927-1-quic_yuzha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: k07DOIcbtdCWuMyhr-2lkUDvEcbWoy5H
X-Proofpoint-ORIG-GUID: k07DOIcbtdCWuMyhr-2lkUDvEcbWoy5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050126

On 3.12.2024 7:03 AM, Yu Zhang(Yuriy) wrote:
> Add a node for the PMU module of the WCN6855 present on the qcs615
> board. Assign its LDO power outputs to the existing WiFi/BT module.
> 

subject:

arm64: dts: qcom: qcs615-ride: ....

[...]

> +
> +	vreg_conn_1p8: vreg_conn_1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_conn_1p8";
> +		startup-delay-us = <4000>;
> +		enable-active-high;
> +		gpio = <&pm8150_gpios 1 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vreg_conn_pa: vreg_conn_pa {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_conn_pa";
> +		startup-delay-us = <4000>;
> +		enable-active-high;
> +		gpio = <&pm8150_gpios 6 GPIO_ACTIVE_HIGH>;
> +	};

Are any of these boot-on?

> +
> +	wcn6855-pmu {
> +		compatible = "qcom,wcn6855-pmu";
> +
> +		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
> +		pinctrl-names = "default";
> +
> +		vddio-supply = <&vreg_conn_pa>;
> +		vddaon-supply = <&vreg_s5a>;
> +		vddpmu-supply = <&vreg_conn_1p8>;
> +		vddrfa0p95-supply = <&vreg_s5a>;
> +		vddrfa1p3-supply = <&vreg_s6a>;
> +		vddrfa1p9-supply = <&vreg_l15a>;
> +		vddpcie1p3-supply = <&vreg_s6a>;
> +		vddpcie1p9-supply = <&vreg_l15a>;
> +
> +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> +		wlan-enable-gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;

Please move these properties above supplies, to match the style in
other recent device trees

[...]

>  &rpmhcc {
>  	clocks = <&xo_board_clk>;
>  };
> @@ -262,12 +363,42 @@ wake-pins {
>  			bias-pull-up;
>  		};
>  	};
> +
> +	wlan_en_state: wlan-en-state {
> +		pins = "gpio98";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		output-high;
> +		bias-pull-up;
> +	};
> +
> +	bt_en_state: bt-en-state {
> +		pins = "gpio85";
> +		function = "gpio";
> +		output-low;
> +		bias-pull-down;
> +	};

These should be sorted by gpio idx

Konrad

