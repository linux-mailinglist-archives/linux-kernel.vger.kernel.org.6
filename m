Return-Path: <linux-kernel+bounces-382390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669F9B0D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881BB1C22782
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8D20D4EA;
	Fri, 25 Oct 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8sYcjM5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9B18C90E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880636; cv=none; b=KGBnYnYqdARDLZ1pwOGMu9bVwhn97loqkAseYZnDI+qpUbUjW0kcqXaEhqw8kCF6mf88o9+hyyNvdMaQ5kqSCOJkc9vv9ARtVXh7ihj9396xyi0UBB3w9sJ2fjLosB29vzjxoagSL+C7yxe3rtjFgiwfiL8Nv/BKX9cDI3/RfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880636; c=relaxed/simple;
	bh=VuYfXZbXysbh25PQ4lYW3IZ7zhG5XyHxt5bS/C5tDKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z//GAWoLEk+4gSa9S7nT6X2g9A9fbEjZNvYSNWRZtoOeYsgAuEjDJd58kFM1u/yrF962UOAcXjAu6XePHsdikLKGoO8lbp99KPQ8HRS7vJRwr+orr0zYhcb/mkviBJGE6Hzq6dn6fNhcudaaF3+b3/ceTRO/0s5Qj2ExhFeDBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M8sYcjM5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PB24vQ000997
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3beKkZbEARnsxmifHxpb705DaWvn5ZgjjjVxCqTJTSg=; b=M8sYcjM5fJ/jXa2z
	9hxff1l46aHfnI/W+Mr2KY9mftX8xgo5eNNgN96IsRINun8ARviRaQgCSuyPNUe0
	RhRaWtmamCJnvlnalhZXxqtD6o7UNMALV5ud2S0K1tf1jxk6iRXOJ7lRHvoTyAJe
	B6B7CjIeO6VFYpFRHA6Ghg4Lp+Lh3k2Ax1l/mgbMk+UW/E1Ornf30Hv4/fZ3Rkph
	Iql3/GpSHEnIs/kLP3IRmzNtv/1mEo/lDcRd7CsNVCoB8N87zpokOFKevse+JmKC
	iKgFCPSlLfmmk2DH74SLwxmDWWodkXDJXN+EusRrDFFXXcSmkGtEKABmhzLBcSkD
	/n0sZA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ga3s1ajq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:23:54 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4a5b5a9c938so47113137.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880632; x=1730485432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3beKkZbEARnsxmifHxpb705DaWvn5ZgjjjVxCqTJTSg=;
        b=HZlFOAhSvhUUHNsPJLotQD5NQ3T81kRQNpqBwUaY4WgQjyp25B+QvGyRH7aDa1ZTE5
         fSXh+HLZCrncIL0qQCOQeHSE6tiWXDoLtXY84kcEOVPH1xOS5+sJ8eTkE2qRf0jAnUGF
         7sPp6LwwZVdSwdKWKWirM0zONH/73mew7WY6U6UIxypWIQs7BKZp7tLa6k5aE8AAbJA0
         Ab8k+OJw0wuTc7gYrDNrIeGLOWtZHbRkejaKnW9CaJO6mblWor/GnZek6+i0eFXnR9/9
         9AaiCqJd7pRDBXao7III4lpUa1Boi8nSBsI5U6dRLJa7vamha92CdbhWNKwRE8R0OheV
         sisg==
X-Forwarded-Encrypted: i=1; AJvYcCVk23uJuUk9Iex4n1qPPWGXYdJyhKcwrCeWz44WRvxP/c3UUjfKMJZ8lgAMI8oVF5I9F5bBk1gg/xuqZKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc33p+BGi2FXX2rwa0JMXfJzMOTsBYNnxIyIMMz1IlEqZjEvyn
	bzq+3BfIRqwm6/vKTj2NhtBdLM7cnIkK9zSfeDKheIUtKZ2wUJuPl6SgY50ZO5hSRV4YJqCVGU4
	2cKlTGkwRfWxToZ52hvHaf37l4FodDu/4j6yMopY4YKCDaR6/6onZXMpPGCCfMsw=
X-Received: by 2002:a05:6102:1610:b0:4a4:7928:6381 with SMTP id ada2fe7eead31-4a8cfb2cbb1mr246624137.2.1729880632477;
        Fri, 25 Oct 2024 11:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/EV2cJbkJddZttFd9z9JB9kp8Bb/TyAtZgttyKQ7XAZIMKzi2FFIjhsg3QqvsnRbaODGO+A==
X-Received: by 2002:a05:6102:1610:b0:4a4:7928:6381 with SMTP id ada2fe7eead31-4a8cfb2cbb1mr246611137.2.1729880632106;
        Fri, 25 Oct 2024 11:23:52 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a0834d9sm95176766b.190.2024.10.25.11.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:23:51 -0700 (PDT)
Message-ID: <9761224a-08e7-498a-a052-adca6bc405e4@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:23:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] clk: qcom: add support for GCC on SAR2130P
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalpak Kawadkar <quic_kkawadka@quicinc.com>
References: <20241025-sar2130p-clocks-v3-0-48f1842fd156@linaro.org>
 <20241025-sar2130p-clocks-v3-8-48f1842fd156@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025-sar2130p-clocks-v3-8-48f1842fd156@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: StahvHUouaBeS53WrmX7NE6htl0jYCIO
X-Proofpoint-GUID: StahvHUouaBeS53WrmX7NE6htl0jYCIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=632 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250140

On 25.10.2024 5:03 PM, Dmitry Baryshkov wrote:
> Add driver for the Global Clock Controller as present on the Qualcomm
> SAR2130P platform. This is based on the msm-5.10 tree, tag
> KERNEL.PLATFORM.1.0.r4-00400-NEO.0.
> 
> Co-developed-by: Kalpak Kawadkar <quic_kkawadka@quicinc.com>
> Signed-off-by: Kalpak Kawadkar <quic_kkawadka@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

