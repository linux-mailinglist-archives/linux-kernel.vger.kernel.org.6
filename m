Return-Path: <linux-kernel+bounces-574599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC306A6E760
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5BD3A4ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325B21F1908;
	Mon, 24 Mar 2025 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NGHhghOM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139D14658D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742860652; cv=none; b=NZCylCSJgvBwumHCxRy/TE0276T1LYDv4n95Mls9Yq38tgLq9kRqOVl/1ZidQWNmOKRRadP2tAkWzaht+LRo/PUALzs5XPHMIGZ746NpERlk0MZm1LgDs/0en54z8TOlkdLz22rID50TYT/YFsGhffw9s+351pvrTX3zmR7xyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742860652; c=relaxed/simple;
	bh=gOuoUKI0iFuR7dyIPRI4sePjhSifvEZDKVfEKNC1WbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJhBPlHtJdH0c0lvDTKE7CojWllDmraJg1XqCp3cb0AuR7GZoxvmOi1sUvz5VudmWLoNVmdHvsCLET6Z4PgMUbxQLwN9O7kJXFVtRVSXBHacaSkG7AWUDA53eQBAC3B7y0cZW9EfUJ5ObqK/bQvca8Cw9AySpITxMGwIsJmFFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NGHhghOM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OJM2Et004885
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 23:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VzyYO1xXBhZFPzvXU2mmKZC7DN135t1mriMQovpRv48=; b=NGHhghOMmv5+4mx+
	tC5XTA/fd51x5bfam59B5mDj1/waWLTn23WZMDDd8Gs4jHXZV72W7GLefwjT3H4N
	ZqJkMWmzvtMf/qzEv6v0aRTkd3HjUGAn1TkKNTY+y4b1cPEL06ICH+2p/fLLC1UQ
	A7CkUJsXfzzxnHE5wz4UbA4zGgC8qC6KVG5L/APL7byrlvciEQMgfYKSQ3rf0eG5
	cO0QqBuaB9GIe6H5HYrJMEIwWnTvNdKoNvixwx62L+CjxnnwP1O90TDl9XZQVF1E
	g0Pl9ykSI/wNK+l1prEchNdOVJMj/Tk6yGbWQYnZtlou72rc1IW8V0mVZ/hXbcmy
	51xUkQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79p03s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 23:57:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5841ae28eso168960585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742860649; x=1743465449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzyYO1xXBhZFPzvXU2mmKZC7DN135t1mriMQovpRv48=;
        b=tNfznl++yPNnvYgSxGtHanEXWL2hk4/jZvwjTGJzxL2jjVYvYaqVttZmJQGQEeAY3V
         tzvayI7TNvzv1ui+xOTebQbjzyKsW7WHaZ15FKmai9OwUBsg7+VmC8Ae1X+gsOqDqRjG
         7WqOOcWHMmMhgg2hEziW3OMzz1ypBRjmQAtHmTcG5JSONFH/vYcdcZfQeshY9kUVo4/F
         JAScQMe4RKDsiZR0aVDDSf9xTz07SwlpCyfVEBB3cmmCN0eEk591SDFmLKAEH9cfOnBF
         xCn7fNwJU70kbqOj0lM+Z5tpioF2m0lA209xpoo2i5lejMKcKRBhYUsX0l814AnQl3ms
         5E2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmQ3bMNLyFCvA/esQBRPPLTfAX6P8OBetGbeNCbovPCPLUHI0LORx3glv/UZk2S7xlF2xbAobJtdzXOio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNzgr6w8kzImEGoWrzQSWNdGJat+coG4RsNaUT16+8UFw3o5X
	xMSzNgJNR5DLCzHvuWRnVA0PLmjoZWiJeqJ4BqGVgy4PZs6rB+cVxQRCZjs/0pS1Fbshlx+SQKl
	EiW6YSqE6l9X4VHw1U88eIiYoqPy4tNl60HLMqqzu6ybNZEw9ZWn8hiSnO8GV020=
X-Gm-Gg: ASbGncsTLyRBWTUdnY208Qy+uPe6Gajci9vIH9v1wohkFblHROCca5FzJEPSLR+7VRq
	V4dvBD/AZZOtf1OfviyGM4v5MsVT+JPZhG9x+YAbQAf479x9oy6tdelfOAbUVarq6R7U9Ng+5YT
	T9OmIR60YDirQT+wwy6NsVbFpeN42Oj2C3hY4emnB9syyRIoeiSrERGOlJDF5t+O8tozxrWdKgn
	uiUbqh66qIcDHbH3tGI0lv3zBgnqOE2oAtrIcUwag2NDYHPQiV10AspA8aqnDrk/ywy2T+QAr7H
	yFD9o+bThYdTlmyPiV6ZMCcJuDNem2fsxJZiMjNZb7jVJ4fgIXooQtJEwAkciUqP6BDpWg==
X-Received: by 2002:a05:620a:4509:b0:7c3:cf04:112b with SMTP id af79cd13be357-7c5da0235a2mr62117285a.10.1742860648526;
        Mon, 24 Mar 2025 16:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaFtH9KUWc9LD6wIas9DpkvOm6+JLrFjhmFXE/g1TJhp8kZqQKZ+plaTaZ1TBFyF+MqraBLg==
X-Received: by 2002:a05:620a:4509:b0:7c3:cf04:112b with SMTP id af79cd13be357-7c5da0235a2mr62115485a.10.1742860647972;
        Mon, 24 Mar 2025 16:57:27 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6511f66sm1336863e87.226.2025.03.24.16.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 16:57:27 -0700 (PDT)
Message-ID: <55eada15-222e-4b97-a519-95b5e3aa7c23@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 00:57:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: clock: qcom: Add CMN PLL support for
 IPQ5424 SoC
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
        quic_pavir@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com
References: <20250321-qcom_ipq5424_cmnpll-v1-0-3ea8e5262da4@quicinc.com>
 <20250321-qcom_ipq5424_cmnpll-v1-1-3ea8e5262da4@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250321-qcom_ipq5424_cmnpll-v1-1-3ea8e5262da4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YW7Sev197_sl3hWO_-q25xfuet6T6S-6
X-Proofpoint-ORIG-GUID: YW7Sev197_sl3hWO_-q25xfuet6T6S-6
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e1f169 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=4Km9-k4PQp5KR6WkhUoA:9 a=QEXdDO2ut3YA:10 a=RVmHIydaz68A:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240164

On 3/21/25 1:49 PM, Luo Jie wrote:
> The CMN PLL block in the IPQ5424 SoC takes 48 MHZ as the reference
> input clock. The output clocks are the same as IPQ9574 SoC, except
> for the clock rate of output clocks to PPE and NSS.
> 
> Also, add macros for clock rates that are applicable specifically
> only for IPQ5424.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../devicetree/bindings/clock/qcom,ipq9574-cmn-pll.yaml        |  1 +
>  include/dt-bindings/clock/qcom,ipq-cmn-pll.h                   | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-cmn-pll.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-cmn-pll.yaml
> index f869b3739be8..bbaf896ae908 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-cmn-pll.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-cmn-pll.yaml
> @@ -25,6 +25,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,ipq9574-cmn-pll
> +      - qcom,ipq5424-cmn-pll
>  
>    reg:
>      maxItems: 1
> diff --git a/include/dt-bindings/clock/qcom,ipq-cmn-pll.h b/include/dt-bindings/clock/qcom,ipq-cmn-pll.h
> index 936e92b3b62c..e30d57001c38 100644
> --- a/include/dt-bindings/clock/qcom,ipq-cmn-pll.h
> +++ b/include/dt-bindings/clock/qcom,ipq-cmn-pll.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>  /*
> - * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #ifndef _DT_BINDINGS_CLK_QCOM_IPQ_CMN_PLL_H
> @@ -19,4 +19,12 @@
>  #define ETH1_50MHZ_CLK			7
>  #define ETH2_50MHZ_CLK			8
>  #define ETH_25MHZ_CLK			9
> +
> +/*
> + * The CMN PLL output clock rates that are specifically applicable for IPQ5424
> + * SoC. For IPQ5424, the other output clocks and their rates are same as IPQ9574.
> + */
> +#define NSS_300MHZ_CLK			4
> +#define PPE_375MHZ_CLK			5

Not a huge fan of this, such differences are only relevant to the driver
part in my view - bindings only let a consumer reference a specific piece
of hardware

Konrad

