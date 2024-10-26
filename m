Return-Path: <linux-kernel+bounces-383079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C19B1723
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E8D1F22FDF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42831D0E23;
	Sat, 26 Oct 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VXO8DEZV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1517C7C9
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729939116; cv=none; b=hX5DmYAnd+c/UbMwjsIX+bb2Lq3v5GYyyg+CsKg1hGAKxGyRmsaT7aSLs+/Zgk2bAzWKE0i1VZ9S+TwJcMtZ70WVfWQFoczxDyBG8ZSy2IAKc74s94aYTncYMvrYqqcl+Cba2pLxsAzoPsJbpZZuhP3HIppNz4ItqXzeVzWymKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729939116; c=relaxed/simple;
	bh=+xRgg3fhgPIP1YSnRr4yzS2JuOYoT5uCAMmYIIJPZEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sydQE9/GfKUyCrdOt7P5cx3FC0kZ1II82KtDpTC7b5zQkABfT8ARdQEAJqn2PPevHCmM93OproEcVqPcpMhB4ZShnRd4lG/cyW6GdxA+qOMk1HCdHnvnFrksk4jIDEmHFipsHsFSKYfP2Wr/RnvRvgc28WF0IoZ0qdAi1SrrwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VXO8DEZV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q5Q63L014146
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vKgaBz+OM7kp9ryq5wJa26tHjWqT3i+ncuTFm68MDY0=; b=VXO8DEZV9jrdPtkc
	V5tpN0Ca+iEItuaxQz51+cxDBTkPQLldwM+r8FZB6H5EVaZMukKWw49ceQVdrSBX
	KGd+O9egcVtD1+XZewNsSTq4cQ1puB8lIyCCqFWbu8WKeMLlO3rxjhMiIkCqZBAV
	cPo/Cu6ywiMEfcZ2zJvto3/2eLGP5+z34XejHtSQxZn02oFpeJuwOa3GgeLoQKjl
	bEiLK50K6gYhDxH38BjrAS1dXe4tNkLZVeemjCXa/XCmQp7XqOfuGL9iZqyUpwTO
	rlHD5+EuMEu9hqSy0UNHLF5MDKgk2xTee/dhngLkpjiiMw7uS2lwVwo4IIJWTDE9
	EfqdBw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqrggsau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:38:33 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe91571easo8731026d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729939112; x=1730543912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKgaBz+OM7kp9ryq5wJa26tHjWqT3i+ncuTFm68MDY0=;
        b=KIAZrd51s75YLFKjK2Jdw3SOGxz2S3MytZkoXyRaPRmI44w2Ik1swuGE1vQ2lxL24k
         LUs0JS/JwWy9WayfS5tbjlUOQ5gv0rDMqx8g+hhUHOhcIb9O073SdqVRLq2bADkNV3eM
         nnMoSebxpTbk/rfdfMXJpMrM9nF20gtS5D4cxgmDhd4YxsFBNmY15tw5AvgW3LmjcEB2
         xGnXQ99kl9Gsgsu7V1W/P6raj5w6DBEqIvs4ackEpyE6mWYXV6B7t5va8oK6Bjr7ohgM
         yjsT5L4HoIijMkXPXARb5+LVcLAehwN2bRUoE6r6fqTKotvQTTPixUS8xDc+XIAQiA4l
         3ayQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5V3RM8U7er14Izxm/X5jxR1tgH4ozf6LxHC/FaAW42qStHery+yhT44+jR+51FJMUeZV5DhT1EGtwbmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRZkzPPWLCDWcJ6EjKsGbiQRmJ6JHBi03EN2OYzFxGsgeIyvk
	Y3wApzwmpxlKIacm7KfNnsOuoIi9Jtk3QiSEpT35o6lSDLoAKMy2+JhcivUtpRi2TMINlN9pbM5
	g0WWgt2v2ubUTKtsGA2UNLvKrlZN02RPJJZNasEhFaF3rpUJolrbXOPtJtgJjuGU=
X-Received: by 2002:a05:6214:2583:b0:6c5:3338:45d6 with SMTP id 6a1803df08f44-6d18583be81mr15399766d6.11.1729939112532;
        Sat, 26 Oct 2024 03:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG48TEsenl/gfo2wEJ90YljffGk3CYZ1kvuJyTTVgNFgy3R7Zl1hGmz1Ocb2KYB93KAmKnzNg==
X-Received: by 2002:a05:6214:2583:b0:6c5:3338:45d6 with SMTP id 6a1803df08f44-6d18583be81mr15399686d6.11.1729939112244;
        Sat, 26 Oct 2024 03:38:32 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297335sm161298866b.121.2024.10.26.03.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:38:31 -0700 (PDT)
Message-ID: <9ac43c69-b3db-4f0f-a562-b8ef7d30530c@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 12:38:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/12] arm64: dts: qcom: sdm845-starqltechn: add gpio
 keys
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241008-starqltechn_integration_upstream-v6-0-5445365d3052@gmail.com>
 <20241008-starqltechn_integration_upstream-v6-6-5445365d3052@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241008-starqltechn_integration_upstream-v6-6-5445365d3052@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gn2IbZiWnOjJ5croXGEtUas9PIdk2gwA
X-Proofpoint-GUID: gn2IbZiWnOjJ5croXGEtUas9PIdk2gwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260089

On 8.10.2024 6:51 PM, Dzmitry Sankouski wrote:
> Add support for phone buttons.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---
> Changes in v6:
> - refactor: s/starqltechn/sdm845-starqltechn in subject.
> ---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index 5948b401165c..a3bd5231569d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -7,9 +7,11 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sdm845.dtsi"
> +#include "pm8998.dtsi"
>  
>  / {
>  	chassis-type = "handset";
> @@ -69,6 +71,25 @@ memory@a1300000 {
>  			pmsg-size = <0x40000>;
>  		};
>  	};
> +
> +	gpio_keys {

Node names must not contain underscores, use '-' instead

> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		key-vol-up {
> +			label = "volume_up";

This is passed on to userspace, many DTs use a less programmer-y style,
like "Volume Up"

> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +		};
> +
> +		key-wink {
> +			label = "key_wink";

What's this key? Bixby?

Konrad

