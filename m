Return-Path: <linux-kernel+bounces-553917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BAEA59092
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60C916C44C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0332D2253F8;
	Mon, 10 Mar 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pgy2XlTx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C2216392
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600834; cv=none; b=Y2ndoJ80QelqXQF6Huta9ZSnf+Q/Z5WwHrJqeb1IUxMnMKkqVNzlCY8n6qmZxSctcw+kJjkgsDytk8doHl+PFfQQLRRCvt1V+QOdDGz47vI5faxZUn5cBaKvlOma2RTPT6qKjRYOC9V81Wzp/r2RGjVn4ptARoVklIh8bZ/I8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600834; c=relaxed/simple;
	bh=/WFGkSucmQQVqC4YRwLmx2Q0dcE6jZVaFroVNYU1Qnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YI52qXcrhRmZ72xe0Z25CQOLUdbdPuDubm13NekFjwhGahLGEsJ1lp3PAD/xanNLWgslBj9gQmnGi3hN4wI7zVBB8GQ/qzq86e0DsWbuhfx1TyR5nPOcM2vbK5GFP6Qc2TQ7KRNe3LDF3PphE+s+Ogn8SvsNnYBxbz0uHyHbaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pgy2XlTx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9eOXW023054
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o/gEoqv9b7eMEoqWazb0zYafPZy1bYCDNTUQlmA/QxU=; b=Pgy2XlTxWpU8uLAX
	zx0dbb9Qc1lsGe2Zxn+RenQS+DywssgNwDKqey4AnlfDrU+ZF6VQbInYJ/kurxwi
	nZ+oEUbStS+u8BgvBzCTEBcT9s4wrXpvn6OCXPbfC1Z/IyFMMyDnsBgt56I6EswI
	BfvTFiqCqqwEflpVkPyrozuJDuM8pW3bqyFl7EbySwU2SiByZvjtfwtyoB6QkL7O
	bkLD2rT8JMsgmpn6Vqc7qXiDUpE1jKPVwgTVwzAvuJ6cQYRnD79cf7wyzJbvewbP
	OLzt3PzZwwSjgzDbnzdMS0hG21/9kv22gxMLgby2iTU3Eg+C+o8MBBrV97Y6WOH6
	w7dCqw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f6acf8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:00:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so4759154a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600830; x=1742205630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/gEoqv9b7eMEoqWazb0zYafPZy1bYCDNTUQlmA/QxU=;
        b=egIYMxsUZH7ZB0ovAeuBNO1hFjg4KuENOL0yGsCTHsjghl1vhRC/LO/ff9tmE8KVJA
         IcP9IPUEBIxiu3gE5pHUZ6rv5hi7tbk++xgRAan7+Vb4rYkvCAdyce+CQVM30/D//lLt
         TZAL5NavRTwQF26/83EuC2pUzSf480vs8qLYd8qOmFZlQvARCSLoFUg64BYs4mfDViX6
         2J7wE3w5VQDZV33k+FMc7YOXRhR0jIp07BcI3+yqLq+2FWDb0oQoQ9tK0xHANKzK5FEM
         wtLZhJM45RCiYti4fppI4myS+uiUY2swvmkNUnUvqLrWxoxmoSRszXr2ntHvPKtcQAS0
         xJPw==
X-Forwarded-Encrypted: i=1; AJvYcCWDnbG3ouaE/pZPcfaUgz1hgqp8Ir4FYIhJ5f/TMMzZ4P2CTlAYMATPHQyT801ZyZhYIc3RlujgxFPpYaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQufV5CToF6+7rlvQ3WPrfImqqWYr1CfswXvmvu9EkAfltx25a
	bJPETKtQpLI2olSjgd6WrqJtXhRBF80NYIC1BDGipKObR+QqMV0k2otZsxcLQNbiOEfZhl+WhO+
	gRCcF80rw/f8S92vTTOw05BDoB3Hb+mmPHgXUDnGIG/IXZus/AjwIXIhN0FvmrZo=
X-Gm-Gg: ASbGncvhvb9eUTWeKOIh9/LqPlN3ZadWZzr4s8XJzbKL7U/Rf8gTlIwAOch7hjwlNCq
	RP7lHAMVzz0iJQ0ZcFUGTM19tfKdDHZN5Y+15it9LOeV/hJOBP6eYtdwcn5Eswv39d9E81oTXqC
	ke1DeKOj/5ZCtv33a64u4v3KP8hboUGnQ6TylQpPD9AXqMSrM+DGPjLcmmopTNaA6HX6zYZLLfI
	Uh436r6X1n4nFib7VhRQwaUMxY0GoOyjo1LmnNSP74RWYiD6TGPKk6fj5rc9Qh9m1dAUqf/Lyw4
	LuHc2lioFPjKDNdYaC8Z2u+/qS9nQXYmP06eEVYtf5XINtUfOeMiv7pZ
X-Received: by 2002:a17:90b:54cf:b0:2fa:f8d:65de with SMTP id 98e67ed59e1d1-2ff7cf09609mr17131117a91.22.1741600829612;
        Mon, 10 Mar 2025 03:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2PnlBORgrtsnN495wyn9nxcbur0ZbfXPq3v1ScLmErAorXFDXK/mJYeYf0Bj2DhaFWSa+2g==
X-Received: by 2002:a17:90b:54cf:b0:2fa:f8d:65de with SMTP id 98e67ed59e1d1-2ff7cf09609mr17131087a91.22.1741600829242;
        Mon, 10 Mar 2025 03:00:29 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f9f9sm73645885ad.125.2025.03.10.03.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 03:00:28 -0700 (PDT)
Message-ID: <bf79cf5a-0c50-49e0-b930-1ec5028e7d0c@oss.qualcomm.com>
Date: Mon, 10 Mar 2025 15:30:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drivers: clk: qcom: ipq5424: fix the freq table of
 sdcc1_apps clock
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_srichara@quicinc.com, quic_varada@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250306112900.3319330-1-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250306112900.3319330-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WsDRMcfv c=1 sm=1 tr=0 ts=67ceb83e cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=o3auzIaOksCvpTgIIaIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: y1Oc-EdhwUBuxsqj12upBljeI65L0PJk
X-Proofpoint-ORIG-GUID: y1Oc-EdhwUBuxsqj12upBljeI65L0PJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=795 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100079

On 3/6/2025 4:59 PM, Manikanta Mylavarapu wrote:
> The divider values in the sdcc1_apps frequency table were incorrectly
> updated, assuming the frequency of gpll2_out_main to be 1152MHz.
> However, the frequency of the gpll2_out_main clock is actually 576MHz
> (gpll2/2).
>
> Due to these incorrect divider values, the sdcc1_apps clock is running
> at half of the expected frequency.
>
> Fixing the frequency table of sdcc1_apps allows the sdcc1_apps clock to
> run according to the frequency plan.
>
> Fixes: 21b5d5a4a311 ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5424 SoC")
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>

Reviewed-by: Kathiravan Thirumoorthy 
<kathiravan.thirumoorthy@oss.qualcomm.com>


