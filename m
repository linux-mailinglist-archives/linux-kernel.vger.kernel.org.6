Return-Path: <linux-kernel+bounces-555867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C44A5BD99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B53C18995AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD8F2356AA;
	Tue, 11 Mar 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lKjgeKJL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2F2356CA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688286; cv=none; b=fiGZBSYgVh70vRzWAgiYLqL7ff1YUofRbzp+jcoUCiaiGjmgAmDv/PDujZKPAoCv2SJwPihA85NS8H9XI2/id6teYOcYdsknAEVOPJ9TY2ct/9VBM2U4BkZSOnao5a4XKEgsKrILHljrJewlFUn0bv37OH88lpUHvxjnrv1Nimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688286; c=relaxed/simple;
	bh=aYwvhdYqKk+yMw4kbjnkVREvt5t0+ZNbizUj9s6FnbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyjQG22AgCoeB0o8tjQ7A4yT8QIDfSyTLgTiS1XCGOUym2+PuLoUszkrXyRTlmjGbddCQQX/sj9j0maHGsxjtJJt5xxEUIUXXoSx3rma1mPuG3jY87qsLrIFBMsHP5w1D7/tyam8dtiBpW2jq+dUJ1AKAWpIaUyebANmLI2qutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lKjgeKJL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7m1g3031953
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gLg0XiQLhr7BV81erd1rdBV9tLWyEIS3vPLctOX1NFM=; b=lKjgeKJLX/WEIhn4
	8R4pGOq2vztPel0PPZeOEArS9cJk3IDbIKrB2DBVhXgmR+Ztw7OYxtmzsnQUDv2S
	XNFx9QH+2zzMLrBHZCIGTTek6UqocD0KWeLQQnHA5KUo8TKbCh10ZsVLxhpaXkpc
	/AVX2gRZljbjZNiCQMBg7QZ8glsqCt8Di2FbOuaD/6JLhVP5AC7zA8J+uHLeMx0r
	J9/Y2EB5V6VYqZregT8n12A5WhNx6psQaEpN3KLEhkDVSSkQqlvobpcpMCTgljm+
	ojWku9YzYur8BR8PRwpnN+1ZVnk5fZ3j/Tj4sBKF7EhHuv5RGBwPu7XSqzHAAHxG
	eXakyw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah3krfhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:18:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8add20c70so4668446d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741688282; x=1742293082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLg0XiQLhr7BV81erd1rdBV9tLWyEIS3vPLctOX1NFM=;
        b=CrGMKUUcL5qN4nCtXxYgK0W7vCn8A+3nnSjWsVgM/4CCHSrsZF4HIM4GItowO9DUzN
         RZ+ag7OTyt+yOdfa2ZJnqUI43n2bSCp0QGkUFC6/L0KFMB6luKfh+30EjO8C2pZHduaI
         1nfUF12BCpI2VWvd9U1JkiW80r3QtT27unjuUsd1f4bQFQqKxnpUVOwDxxDBsEqqYF2i
         tOJcrFhJK5zY80Px7QnC4KR7NzNUT0afhLKzs7WB8yiioi9zua30ttML7xfRotp4vRW3
         D8SQ1D4f7sQlmQbFIsZ/Dnzkh2QejfAahPUslWSDEZ551Wb/ag9m0MXjAbGPQzwJ0tUx
         YkTw==
X-Forwarded-Encrypted: i=1; AJvYcCXjtN4Rr3N9g3urha7oPHoguaookyAKuxdTwm/81bm5E4ffr/gj4Pg/V/y61gLqyIqWBcPRWR9NBY+dsuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tPDWZ41JnTe/iFhNPFW9n+2hVS6neGKacu+fhinbVsy3frOm
	I+rd8tPPoOSgyEvuu8srEJOen8kuyITzP/s2W+2gjhpbnxv7jYNhtYTIJ33ldp23iqtI4Q2PthN
	va3NWSTkqRRiH/ev9/uNPxFEfaDESik0SiVSugUlqakvTLi6Jab6isghkXUjPSLU=
X-Gm-Gg: ASbGncuMTVBAhlFLxWiET0SfgZGoer+y2+ftR8oRgUMnZpx7+CRXYJHGP4TsELZIuAz
	a408f44wuFY8zaQ308s/1eemtHZMdtmkA88TznO8sBYZhKZedBjNnNw5mWhTbIAFzIQ0ZDn6kdG
	90STi1hKp6A85iIjstnRmKuqhmxiqhXq13FzwT3fM125c1GX4NGn1SPxo6emiPBOTy0WEV91Fdl
	C7/StvE8aaRrUcFtEd+VcWhMngVr4F2I5uGocwj6ku6CSqS4pQ6rqOheuv2sA0XFnFMTn1V2k9K
	1ZnW0b1YRI9NJO6o1qCSOALz4NgorJTyIC9sX+i0YTZVtr/1GVn8hHMx9/7JfKEE1V6GuA==
X-Received: by 2002:a05:6214:5192:b0:6e8:f701:f6d8 with SMTP id 6a1803df08f44-6ea23b414ecmr16717406d6.0.1741688282148;
        Tue, 11 Mar 2025 03:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW83xBYS/+ns5BJXqeVLeMUipXXxeFLW0QWx8QN5GkkDNXt4yXik/fUudE+ZYwMdYnZzYWfg==
X-Received: by 2002:a05:6214:5192:b0:6e8:f701:f6d8 with SMTP id 6a1803df08f44-6ea23b414ecmr16717256d6.0.1741688281842;
        Tue, 11 Mar 2025 03:18:01 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d4edfsm907415066b.171.2025.03.11.03.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:18:01 -0700 (PDT)
Message-ID: <44553d96-d1c4-4cd9-88ee-5d3bd7227715@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 11:17:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] soc: qcom: llcc-qcom: Add support for SM8750
To: Melody Olvera <quic_molvera@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250304-sm8750_llcc_master-v2-0-ae4e1949546e@quicinc.com>
 <20250304-sm8750_llcc_master-v2-3-ae4e1949546e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250304-sm8750_llcc_master-v2-3-ae4e1949546e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _Lp7sNf-zoBMFo3oB8FVZxCrxFxcQvop
X-Authority-Analysis: v=2.4 cv=MJiamNZl c=1 sm=1 tr=0 ts=67d00ddb cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=Wn71LMW1St--75GlNFMA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _Lp7sNf-zoBMFo3oB8FVZxCrxFxcQvop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=698
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110069

On 3/4/25 11:23 PM, Melody Olvera wrote:
> Add system cache table and configs for SM8750 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

[...]

> +		.usecase_id = LLCC_MODPE,
> +		.slice_id = 29,
> +		.max_cap = 256,
> +		.priority = 1,
> +		.fixed_size = true,
> +		.bonus_ways = 0xf0000000,
> +		.ovcap_prio = true,

ovcap_prio = false, alloc_oneway_en = true

> +	}, {
> +		.usecase_id = LLCC_WRCACHE,
> +		.slice_id = 31,
> +		.max_cap = 512,
> +		.priority = 1,
> +		.fixed_size = true,
> +		.bonus_ways = 0xffffffff,

.activate_on_init = true,

[...]

> +		.usecase_id = LLCC_LCPDARE,
> +		.slice_id = 30,
> +		.max_cap = 128,
> +		.priority = 5,
> +		.fixed_size = true,
> +		.bonus_ways = 0xffffffff,
> +		.activate_on_init = true,
> +		.ovcap_prio = true,

ovcap_prio = false, alloc_oneway_en = true

[...]

> +		.usecase_id = LLCC_VIDVSP,
> +		.slice_id = 4,
> +		.max_cap = 256,
> +		.priority = 4,
> +		.fixed_size = true,
> +		.bonus_ways = 0xffffffff,
> +	}, {
> +		.usecase_id = LLCC_VIDDEC,
> +		.slice_id = 5,
> +		.max_cap = 6144,
> +		.priority = 4,
> +		.fixed_size = true,
> +		.bonus_ways = 0xffffffff,
> +		.cache_mode = 2,
> +		.vict_prio = true,

.vict_prio = false, .overcap_prio = true

> +	}, {
> +		.usecase_id = LLCC_CAMOFE,
> +		.slice_id = 33,
> +		.max_cap = 6144,
> +		.priority = 4,
> +		.fixed_size = true,
> +		.bonus_ways = 0xffffffff,
> +		.mru_uncap_en = true,
> +		.vict_prio = true,

.mru_uncap_en = false, stale_en = true
.vict_prio = false, .overcap_prio = true

> +	}, {
> +		.usecase_id = LLCC_CAMRTIP,
> +		.slice_id = 13,
> +		.max_cap = 1024,
> +		.priority = 4,
> +		.fixed_size = true,
> +		.bonus_ways = 0xffffffff,
> +		.mru_uncap_en = true,
> +		.vict_prio = true,

same

> +	}, {
> +		.usecase_id = LLCC_CAMSRTIP,
> +		.slice_id = 14,
> +		.max_cap = 6144,
> +		.priority = 4,
> +		.fixed_size = true,
> +		.bonus_ways = 0xffffffff,
> +		.mru_uncap_en = true,
> +		.vict_prio = true,

same

> +	}, {
> +		.usecase_id = LLCC_CAMRTRF,
> +		.slice_id = 7,
> +		.max_cap = 3584,
> +		.priority = 1,
> +		.fixed_size = true,
> +		.bonus_ways = 0xffffffff,
> +		.mru_uncap_en = true,
> +		.vict_prio = true,

same

> +	}, {
> +		.usecase_id = LLCC_CAMSRTRF,
> +		.slice_id = 21,
> +		.max_cap = 6144,
> +		.priority = 1,
> +		.fixed_size = true,
> +		.bonus_ways = 0xffffffff,
> +		.mru_uncap_en = true,
> +		.vict_prio = true,

same


Apart from that, it looks like there's some sort of grouping / parent-child
relationships involved in this thing - do we need more sw changes for that?

Konrad

