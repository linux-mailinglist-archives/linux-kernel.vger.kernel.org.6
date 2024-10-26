Return-Path: <linux-kernel+bounces-383064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900EF9B16FA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5906E28369D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD171D1303;
	Sat, 26 Oct 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JylniRDk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84913B294
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938090; cv=none; b=TVqKoqixV1Dg9SO+EDEBe9uqlGOnAWcfyWvrOF2eRwOXnITpFggH2glnKBqzASlDZcXoN+2uHJ6s5rFn0NtOS6OkEg8sxPrelk2s0awct9MwE9SMh2KKBMf8rIlVg8/iyNqSStil1ViIRMQrLeJkA/FJX9Ez7fX6j5kjbunW9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938090; c=relaxed/simple;
	bh=Yfv740UWa7gKMwYxENKZmjKVAKKyKevu6Hk6c3n5T1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuCDLWkiyR3t/NOy3Kdizw0ViC7naZkNWyLCDo5WWion8NqPhMc2tTN3ZD+lNK/s4tmIKDNYEohcGe5LNdi+LtipCX5jhk7JYmAQOT1ldj4H558PkmfY7LoVxrZ55AyiaJNQaeoAj0qodYnTAnUWscGfo84oHDYaqZRAeR2h77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JylniRDk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q5oJtP009247
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tomHv3cJoWMXpia9so1GTrTz4n+3J9UrFVaAhauD8SU=; b=JylniRDkHWDJ79cq
	HF3Ifs6T5/VJmacRlfQlOVTRlZ+Y2yREt+aWjXe3PphhYjUFys0wV3TgEIrdfIqp
	CtPk+zK3chJUZ7dHmdcNLmb7GPHqG80sKrD/VVqrxlNO151SZ1FQUmBNWJzOeS9i
	loHio2djJqb66Ad2yO8WIVoG2uUVwI0whzDbSajIVv2J9DFuDMAoEHteXmL/gO2L
	sK//6mMiids8Jph5Jgu4+ksE+dR2yuE9QqKe90Am+g5F6yCJRcGxDC8jJPhD68GE
	26LpPTPicrAueS/0pyYAA7fUvAPfPG/AFcFH3q2EtXI7NxCEqTTMkUcy9dyqAe3B
	HPQ+5w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grn4rq4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:21:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbe5e8658fso5886036d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729938087; x=1730542887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tomHv3cJoWMXpia9so1GTrTz4n+3J9UrFVaAhauD8SU=;
        b=AXJ5kefJEiQeYFKo9J9J1m+MTNAsIiKgGbE7pBlxu85dPc0hRGZFa7MkjXaYOt6xeB
         bFbbj3D3XS0UzzyII9sisr78msw/taP28k19kXX7rAtNiU/7z9Zt+iy6o8NGyp42hgPt
         UI9GyJlRwNT36+aR1lQDo/mV2g0eDunj0rGuFJ3Zr5rLwLTGcHTTjQMNZJK87aAlpNOy
         IgXfVEuXYxYCQkTTi47ZU9rNPv9AU9K3gxItGsdUxyzYUj1n65HI2/jMdwX2WR55kDaw
         P/BvURehneP1xOlVUujcsWYidU0TNA10igsYOfqNifuXAsaNFlOMbCBEJpl2l/R9uCP7
         VbwA==
X-Forwarded-Encrypted: i=1; AJvYcCVpeqIpxI2/fmYrCcTRoemyavq/REu/OOY6N9aC0eCIjpZq/5KoGh1VT+jpr8eiDenp1+/dBg3hVD0MeIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIr35iyQurXHHjPg41NyuKfrVX+t8zLbhGM6bJ888+LhDSGaTe
	mVrPKuyGtZU8Y9euJLwYDHYFwt3Zxz+n5cE6Nm9gzEWMDXdHN4Bcl3ZgayW7vZ3YlSnuyHEJLW0
	JVKCVZgXhxkc0ZC3ZZxhnGkzHGZR60axKbDJEPVxUb7BtO3J7FM6aWMq9uOM8L9M=
X-Received: by 2002:a05:6214:1d22:b0:6cb:4fad:5215 with SMTP id 6a1803df08f44-6d1856b77f1mr16856076d6.2.1729938087179;
        Sat, 26 Oct 2024 03:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG65NdIbQ/VjPecB5n7Ai20nBIwQ+01iCan0idA4LU5MQ0AXhGikPTHqFdB6SgkeKSGEIPQxw==
X-Received: by 2002:a05:6214:1d22:b0:6cb:4fad:5215 with SMTP id 6a1803df08f44-6d1856b77f1mr16855996d6.2.1729938086783;
        Sat, 26 Oct 2024 03:21:26 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec8180sm159285066b.22.2024.10.26.03.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:21:26 -0700 (PDT)
Message-ID: <f3378e6c-732b-4be7-98e1-3ecb80e6f45a@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 12:21:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] arm64: dts: qcom: sdm845-starqltechn: remove
 excess reserved gpios
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241008-starqltechn_integration_upstream-v6-0-5445365d3052@gmail.com>
 <20241008-starqltechn_integration_upstream-v6-5-5445365d3052@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241008-starqltechn_integration_upstream-v6-5-5445365d3052@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y_0Xem_xlkfPy79-n09jTsBEv5sTYo3_
X-Proofpoint-ORIG-GUID: Y_0Xem_xlkfPy79-n09jTsBEv5sTYo3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=806
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260086

On 8.10.2024 6:51 PM, Dzmitry Sankouski wrote:
> Starqltechn has 2 reserved gpio ranges <27 4>, <85 4>.
> <27 4> is spi for eSE(embedded Secure Element).
> <85 4> is spi for fingerprint.
> 
> Remove excess reserved gpio regions.
> 
> Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

