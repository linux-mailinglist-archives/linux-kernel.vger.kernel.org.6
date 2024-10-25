Return-Path: <linux-kernel+bounces-381317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DF59AFD93
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE691F21E86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CBB1D435C;
	Fri, 25 Oct 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LTikHe/i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226121D318F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846997; cv=none; b=lH1UXXjFBlIPrVbk9p5NPPWk2Y1WYWDXNg1MfjQ2YBT4ihNC9DWN9EtekBw20EBiDW/j63G1OcvZQXxdY1T/8kgndZB7ts92Qejfxdg3UaJEfS2YykYEx26DiMhnYLwTAzaUdt5EhWhxWcuZwtl/IunaxyYm5hGMBRHuCSq6//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846997; c=relaxed/simple;
	bh=jHYhHWD3Xj5+wXlnNcistsa5N1NbiAqU0VT1H2LBhX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvS9J02hkExJiwEFQdGfsKzr0jf8LTaQpAsuFph3os2zGHJPklZ3gdAy2iTdMBFoZTvsJb9CJEA8m7wGxm2EAI7MTryVG45/sJhAOhrSZHw1rKR2tv0wEvwq1MI2lq1c6CkxUflWF1fVxAwdFT/Xv8hF1C4agqnzzpPyY4MqCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LTikHe/i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P47gQh028664
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hvhs5CvaUXx9tdFQHE16vdbNwHsAjwYgEe7/KvNaR7A=; b=LTikHe/ixfshnhq1
	EStit7aQIrtTYAIz0yV0/DGtBaA/Y1subIMy7QVbpfmQj5m1zAV5SfH716hwlvxJ
	hsiqCB1fpJ1TqBP0gp3/Ed/b6sCLfFlPPOzaaGc+Tpz4Og9DSP/nMSODDwU6y0L7
	FrqFOgY+sU8o73vipI2MmZ17zSg5SrYN9lxRNpu7laxRZEMhxruL1/IhzB6V8Vsf
	xOqOjgx6Ax741fyIhaaTUqD8ffEfqBIdU+raXeUtrRPoyajbQD48fNEgufIrYFll
	XfJq+NNKqVrZPsNIpq2y9zquWC7ZEvHejlmbxJN513VNArW97LNsDNGUvhSc8G9w
	HzKa+A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fdtxm86k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:03:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe149b1cfso5301266d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729846994; x=1730451794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvhs5CvaUXx9tdFQHE16vdbNwHsAjwYgEe7/KvNaR7A=;
        b=sYCEySfdrIWc27OkSsMyoo74nxCfNU3gF9iS5KdgSLw7XmNaqowx1nF6p2isB3JGs4
         f/JdC9mIiCE7mG8UJQPjJoGP5EkkhiEMF1XsomutCyYKbdJO0TSmrebxuwmdLHJiGFre
         HZNl3ZJIfD119/ckxHR3lzLwZVhvQmWTGsliI2nMnTFfyAdRLvuXBy9Dx2WDb7Xj3bnH
         3ciUvQDggTYlKuO/Jbk/g1v3rYV4+SJ4hQ8yE1jDIV8XqqI+pk4AksGEFSog7Z9hfiq1
         in6sF4iUcKTtrIW9+NoeDuLY8BYP/Ydjz+RH8voZrZjwfwzp8e8n69c1ffBFWl6Hmc83
         ZrLg==
X-Forwarded-Encrypted: i=1; AJvYcCWRbTw9mminmuRou0JDWBQzc11wgq3ruOcu2ItaSxVkMyAnl/F/mLAw8oRie9c7+HjNQ5YmeEEl8qOqizU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3bX0Zndmat5tj3k20aeTwz+Cggbg3JISWJhBYzr2NM+i+WYDY
	7tW9Sr4XcXloapQNpnYJMg3VfZDDnEH8m6YrJl/NmG0L4vQsmFL+oYUW9B+zDc4zoglFMFwP/ee
	+f+VaFmXDAhWmKjeFoDZMX5KUCSe1H5KzhyWWdo1r6ENLEnRxznpxiJ+RGfEwtoo=
X-Received: by 2002:a05:6214:5283:b0:6cb:4a88:8cf5 with SMTP id 6a1803df08f44-6d17dcefb27mr3093366d6.2.1729846993996;
        Fri, 25 Oct 2024 02:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPoaFY4NuMUdT6UC7aHSQ4gmyr+ruu2H47w697MikAjvXx0EG7IdwUwwTyyAPKKUyqFJflKQ==
X-Received: by 2002:a05:6214:5283:b0:6cb:4a88:8cf5 with SMTP id 6a1803df08f44-6d17dcefb27mr3093266d6.2.1729846993735;
        Fri, 25 Oct 2024 02:03:13 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631a3dasm393276a12.65.2024.10.25.02.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 02:03:12 -0700 (PDT)
Message-ID: <c1d4c2b6-85a0-467a-930c-ac2797c72699@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 11:03:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: Rework BCM_TCS_CMD macro
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, linux-kernel@vger.kernel.org
References: <20241025084823.475199-1-eugen.hristev@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025084823.475199-1-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3iOxjWgiFNQR57rWPnUobOeaVzRa7j5o
X-Proofpoint-ORIG-GUID: 3iOxjWgiFNQR57rWPnUobOeaVzRa7j5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250069

On 25.10.2024 10:48 AM, Eugen Hristev wrote:
> Reworked BCM_TCS_CMD macro in order to fix warnings from sparse:
> 
> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
> 
> While at it, used u32_encode_bits which made the code easier to
> follow and removed unnecessary shift definitions.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  include/soc/qcom/tcs.h | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
> index 3acca067c72b..130ed2582f37 100644
> --- a/include/soc/qcom/tcs.h
> +++ b/include/soc/qcom/tcs.h
> @@ -60,22 +60,19 @@ struct tcs_request {
>  	struct tcs_cmd *cmds;
>  };
>  
> -#define BCM_TCS_CMD_COMMIT_SHFT		30
>  #define BCM_TCS_CMD_COMMIT_MASK		0x40000000
> -#define BCM_TCS_CMD_VALID_SHFT		29
>  #define BCM_TCS_CMD_VALID_MASK		0x20000000
> -#define BCM_TCS_CMD_VOTE_X_SHFT		14
>  #define BCM_TCS_CMD_VOTE_MASK		0x3fff
> -#define BCM_TCS_CMD_VOTE_Y_SHFT		0
> -#define BCM_TCS_CMD_VOTE_Y_MASK		0xfffc000
> +#define BCM_TCS_CMD_VOTE_Y_MASK		0x3fff
> +#define BCM_TCS_CMD_VOTE_X_MASK		0xfffc000
>  
>  /* Construct a Bus Clock Manager (BCM) specific TCS command */
>  #define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
> -	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
> -	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
> -	((cpu_to_le32(vote_x) &					\
> -	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
> -	((cpu_to_le32(vote_y) &					\
> -	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
> +	(u32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |	\
> +	u32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |	\
> +	u32_encode_bits((__force u32)cpu_to_le32(vote_x),	\
> +			BCM_TCS_CMD_VOTE_X_MASK) |		\
> +	u32_encode_bits((__force u32)cpu_to_le32(vote_y),	\
> +			BCM_TCS_CMD_VOTE_Y_MASK))

FIELD_PREP/GET?

Konrad

