Return-Path: <linux-kernel+bounces-382355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64469B0CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B37D28155E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3464187332;
	Fri, 25 Oct 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cCzYG8l8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F03170A31
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879566; cv=none; b=Vz//VJKbQ6dRjtfQnRQzQNWqhj5BxTrFqdZXE52XwlZPpOWgJ2I34yYfbPXmLHqYszx09YCa4n5OCuaVPld1/N1RCNfqSzxh1PoY29Zemn3RgwaJUPfLo28XSrHlFqEVbvk7cNxkgVp6YhfRBxt5PGYNkKqLZwqEAXXjEcOEhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879566; c=relaxed/simple;
	bh=mz+P1tAK2p3uTct0yT1WY3q8nvQegJKjKEEGXEXA08w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+kjyT7JSafMEknd3pLTnoUfHlsIL+muW0qRIW6L/kLEKziK+i7hBOvWNvLvGQUtJHNNS3Yo5XoDhN29rKde0Mf/ixKXwkFZ5+rCCH8/P6yAEWJNNyIxQDuYgVF8qlIDJdwWs6IePpCcQ5pmzVi8PK1ZDzETzo3p9fr9ToMFBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cCzYG8l8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAops3007869
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UinYnpz0bX3TlxY76tXTI2GPpiqAiG3gmDFk9qESCJE=; b=cCzYG8l8NTJt3y0x
	9tawGkHjNOoKCFVPiD2beO5sEhFkohnuytTrDFio3OVN9e1LeZ3zB1mD3FsYgoRm
	VKUj/hn7vVaWb1wxlzTnoF2h66Xnr4o9gGAuwVfm5GvXwR5FZLNaI9YhuPPBtWfg
	tVTK+hB/WFYmU6MGTm2RyRH/pfLtYGRYaoBA4ct6CsVBwhB8D2XUAzv7RhzNBLU3
	pmHBjS8Fxvp2npuC2qlxQbp/BotAcZ1RNGBFMBrSRi+5UI373XNCE9sTQ5iHZ1mO
	73YSxW8uV1KCt1VsZ0twilmiwEOfAnMhVFthwQBxbP9XwH9FDLJbQyFllP00aBrQ
	n9aeWw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g9x6hc12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:06:03 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5eb87df274dso189141eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729879562; x=1730484362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UinYnpz0bX3TlxY76tXTI2GPpiqAiG3gmDFk9qESCJE=;
        b=Zw127thLRCw40TuAZFVsFufbt/8wS0pePQ3bTxmSLQTLM18dZvhU/86UHOSAC0Y8zF
         g44ulz+Jz6f1y5OAaU5/FmPmvdo/yZoWiwmmB/e1xicp+/vuxeBXsnE8uMAgGVL/2pBp
         RH1qxnIzu+XDPQQWf9sizd2Tg+txLfmlB3QdrxQcYAZwQyw+mA9hphaPSsPqj8/6Jyzn
         38+d9CIRM7GqmNA/8AjSQRCHP7Ray5IUN15Ju/nGg9KmIxEpmGeZkgiDYiPxHOjmzmR+
         KVSzM24FJGsZHgyyiGA282hbG/ewCWlV6f0LARjLHfKR4lnke6KIF+kR8QtjQFvW22UP
         Bj2w==
X-Forwarded-Encrypted: i=1; AJvYcCUt2wvMOAvbYizSOAZ8ey+f+GSRjvzH+myS7Agrac2xvrKYdUqQ3qWLoGfVodPD1SuH4SYoZJXnvYeDuAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sMJw1ThwHYKQgAEDxB0rWhbsEs68gDmjtSmeNE6KQRYLD7Yp
	0qQitcEWJFWd7NQjpZrEtsrncuCco41OSdyEGtmC9gi6nh2F1+pGUKCBSJSHlUxdC4aK8oSoM1k
	JU1D2naE6gNCu6Bosh38YLwKjyOaukEvlZXB1KtsmiC/h9rvhvgduBcYkFmj7v8A=
X-Received: by 2002:a05:6870:b6a8:b0:288:8fc5:aecc with SMTP id 586e51a60fabf-29051f750a6mr60782fac.14.1729879562336;
        Fri, 25 Oct 2024 11:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4teqjn8eyv8j8nwoj+93RybLf/p9NG1WxVNggZ5/zlR1h9G8K8OnVanPksxEpinKNN9zbxw==
X-Received: by 2002:a05:6870:b6a8:b0:288:8fc5:aecc with SMTP id 586e51a60fabf-29051f750a6mr60770fac.14.1729879561994;
        Fri, 25 Oct 2024 11:06:01 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6347f20sm832942a12.86.2024.10.25.11.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:06:00 -0700 (PDT)
Message-ID: <cf6a67a0-29b2-4a31-99cb-4b8bf583219d@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:05:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] soc: qcom: llcc: add support for SAR2130P and
 SAR1130P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241025-sar2130p-llcc-v2-0-7455dc40e952@linaro.org>
 <20241025-sar2130p-llcc-v2-2-7455dc40e952@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025-sar2130p-llcc-v2-2-7455dc40e952@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: l5DPvOl8kakO1Mm2OV_DO06PW2h3zWWj
X-Proofpoint-ORIG-GUID: l5DPvOl8kakO1Mm2OV_DO06PW2h3zWWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=858 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250138

On 25.10.2024 5:22 PM, Dmitry Baryshkov wrote:
> Implement necessary support for the LLCC control on the SAR1130P and
> SAR2130P platforms. These two platforms use different ATTR1_MAX_CAP
> shift and also require manual override for num_banks.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

I'm not going to verify each and every value, but this generally
looks good

[...]

> +		.max_cap_shift	= 0x0e,

This should be a decimal 14 (as it's denoting the bit position)

Konrad



