Return-Path: <linux-kernel+bounces-537009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B650A48707
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B93A165ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA61EFFBC;
	Thu, 27 Feb 2025 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pRVAjDua"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49FF1E51E6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678639; cv=none; b=Npd1rWdfq1Ifu0nXhoS08ev0VYgPtuWDy1fZ27/O47/i3ZPdSq5zEkGcYEteNz2YnQSz9AX+YaFwBg9pawG+2qif289tFdOK0zbtGQacvTbWKda/ifzhppC7Bdzkar9r9DGP9B7sVZcLEoGYsi3eE5yrDNOlxaX2G7ow03dYoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678639; c=relaxed/simple;
	bh=33MWytW6HIuaaxDjPHCFlFyhNbDd0yneGwZlJ9C9rvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTwoCtDPmOuGf1DyJq8sKe38CIem4jzAwjqkBXGKQmBK7UU0VlLwR1DmK28QrxT62yg3QU+1i+RWDJNeEi5FDkHjDLCpA2AkXWL0RhHJGzlQx1r6dglGTOiYO8nzsNVKzZU6HKz/4iwoxpWd05X5W5Ix1u6/TE4qLrC1z5Px7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pRVAjDua; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAHjDW001341
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MltxrynpbJecGwXtsRyAlCXYQDFnB0d7y62GzHgM7Pc=; b=pRVAjDuaTzAwU0Gj
	ruhzZUdjtAsC7t77hQQTxYgOeUWEnXj0uXaqsm477/UfAcYcny3rnlb8oA6Z0KWw
	Yu3veUSEyYp+pA0+uH4eAy9ZcsJYFNCR3tI1E4102L8Enp1Gv5zWTCUACKwMJTu4
	oLArfejnmtmKt0jgdgh3JDnIK7GRXWVHBbhyvBQitODF4yHj8yM7ds40MSbGG+MF
	OKzZTVwMZQf/P1vGeoWh9W4q0Dmg+rY0Loiq5muWA7058LxAG70PXuyZ7bcGpmGN
	s8RDxGY17yCPYDiY2QoMsRf+HCDDvkfRIzX6KlYsjfs/J3famtH9KJi/fmbCXINC
	xzUZcg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4522skvnpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:50:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e89b5746d0so1548816d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740678634; x=1741283434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MltxrynpbJecGwXtsRyAlCXYQDFnB0d7y62GzHgM7Pc=;
        b=J6N+Yu5DzFUcspTbXhIB1637ebzM/YcCTDkXqq795gjXWwrTd5KjqGXc/YGQ6otx1m
         aATIwi/jb7GOznyKyoed/KF5x7Njhk6yMclj1SgY3j1FcE1xq3tp42W9wpeCMfUrddRS
         zlnRYbi3th6QZ+JGM8+OU70J7iAgqUWkDM+Owc+D5ZRIaC9RbUiuSJoyiAMUCUy2q/fL
         ER6W05PJzPs4km6NvgoQVWEGVd89JwMNJVT+av8NlraQ1HyDbWPf6G+fa9cx5mCxpsts
         jdFk9wKHgT9/hmkt2pfPaDNc9QusqBMmYFFR3h8DOls+TdJ7mcjHVIW4lYHoCzYVL4c8
         nozg==
X-Forwarded-Encrypted: i=1; AJvYcCX384AzkIlB2goQ6ZWlkvjx2AQAsBgUrvqV20NZmlDxZ3MF1eWkpY41JymodtoE97QkTWDoDYOdErexQCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB2of6gDg9OXAfG52Og8fttVQX8YxG/s2jNQEdksLQqFJyHROS
	ZFaq1coFqTHd2L75c90NAAJYoQenhpAzIDQA6yN3XgdKj7vNSDY387DRTFOiQnPgRELSv19sjH6
	SW7ugJfSdTHfC/zgDfwzCcwiR3Qv0QXBY1eSk4wxmJ+mczBT8hAXQQjmfR0/obXY=
X-Gm-Gg: ASbGncumDNMcgaHfYc4iJ8YYy+4pqAEsML+EXE7dR55qSEy3WLPRDddoYLDTXo12Rc7
	bDpvKQiocYh/OGWin+mPNHDCZDZZYYhcLMK7jdZbVmy7v8Qb931gjowhhBRDTwpb3+bZn3pR2cS
	zsm36jHv5KyihhpLaSXTjOe6wdGYlNxWMS/6Fc8lznCc6z8GFbhLQW/DIxwsmSZlPRadBZKYe4b
	SVi7GqNDFYEIytuGBIZ/vZOPifGd03FpHQ64yUGvFbwo9TE9/Bc69E6h+wOjUG+7BArJ2cDjqjZ
	AZ/kvT+fv79ZlVXuDRSp1E9j9CHXQSj4lDca78XgtcxkTpjqDABf896QTEShqpr4dqUftQ==
X-Received: by 2002:a05:6214:5006:b0:6e8:9ac9:55b8 with SMTP id 6a1803df08f44-6e8a0c7d646mr2019406d6.2.1740678634702;
        Thu, 27 Feb 2025 09:50:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR9yh+nwQNmYMZCa7oAW+LC0hXOHsrkYIwVv+j52xps6QPpXEAgXwfuzweMxFIW+GPJv7wLA==
X-Received: by 2002:a05:6214:5006:b0:6e8:9ac9:55b8 with SMTP id 6a1803df08f44-6e8a0c7d646mr2019246d6.2.1740678634375;
        Thu, 27 Feb 2025 09:50:34 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9990sm156046966b.35.2025.02.27.09.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 09:50:33 -0800 (PST)
Message-ID: <7535057b-b6fc-4831-ac5b-b68903083747@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 18:50:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sm8650: fix PMU interrupt flag
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250227-topic-sm8650-pmu-ppi-partition-v3-0-0f6feeefe50f@linaro.org>
 <20250227-topic-sm8650-pmu-ppi-partition-v3-1-0f6feeefe50f@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250227-topic-sm8650-pmu-ppi-partition-v3-1-0f6feeefe50f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dOtHXZQOiybDeeu7RTdZss6sA2onD41S
X-Proofpoint-ORIG-GUID: dOtHXZQOiybDeeu7RTdZss6sA2onD41S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=823
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502270133

On 27.02.2025 5:04 PM, Neil Armstrong wrote:
> The ARM PMU interrupt is sometimes defined as IRQ_TYPE_LEVEL_LOW,
> or IRQ_TYPE_LEVEL_HIGH, but downstream and recent platforms used the
> IRQ_TYPE_LEVEL_HIGH flag so align the SM8650 definition to have a
> functional PMU working.
> 
> Fixes: c8a346e408cb ("arm64: dts: qcom: Split PMU nodes for heterogeneous CPUs")
> Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

I couldn't find anything to back this up, not inside, not on Arm's
website, but downstream agrees, so..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

