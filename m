Return-Path: <linux-kernel+bounces-409334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3739C8B73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F284FB2EF21
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2071FAEF5;
	Thu, 14 Nov 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SM2dCkef"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004818C32C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589604; cv=none; b=p3YCnDxK6m2RSKKW4aRprr0B4z/RmYxkxlXmpu1OAevTcyKZC1X/dW69jyoKd8e0Plx/d5nU33XVCO22OmVTmSDzZTrUFPnBVwPfJ7p8oCYOEk/tCQqwvOoAbYUQONJXTByhNLEOiVTnWSFf924oKE2o1FtoHhYGQuWvf3ZQwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589604; c=relaxed/simple;
	bh=U0GhA3/+aWy9Xn1Tcitpj/Q/54Mwewvjxq/u/nQPg3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMRHE5z7C2QNVVAk451pDbji29k9hjEgiKSugRElMPIWEtS9ef+I0jbOComoRPa3KfNKZ6L34yaSFmQzDaQmwsTumSEVaEPNUZNvNv6s1Gkbye5vkXfVuhGl7aI1IhBttBZm4LbYdDaiUTWb4epOiwCarFhtQXtEc0g5eJs/7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SM2dCkef; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE5XXPX026909
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wMKapcEu/BDec5OW1UblFViRGaMfwyVFJ5h9OM1dLHs=; b=SM2dCkef5e1pwVvK
	90I6ZzY1CsiUH4u3o6A6XNTiU5U9mRK6RrD2/yap1XtlussRPRfmD3xu9uE3Gu5q
	jAzIAARwYK2sonkeFVv3LpAx1iUEOoLB1cRGf18cjFESDUn7cg88JeyzkYXqSeTA
	CvKuf+FznLX+lCQX/4CCCmIvmQG5a8rW91+YMT4GjunlQlnjtDmH2Mt5b4UmqrWe
	lSyQELuVYLyPjMI8QgH421AzlrUHJbIsNpoOw/zueMkGsWADawDsjkIOpX/EQrKN
	Yr37/UAohP38R9nnTZgazhc3gtK7v9aDamdXWHJ6iZ6lysn9In0sA6VJ6iIfFILN
	BBm2rQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vt734xcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:06:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460958ceccdso1358561cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731589601; x=1732194401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMKapcEu/BDec5OW1UblFViRGaMfwyVFJ5h9OM1dLHs=;
        b=XYGSDN8OFvSx+s1sAttijGeqpU13A8GQVkq4bw8HWbUgSpp536puJRvfVAJiOBESdZ
         JrB7msMpHAwKFd9cK+vVn2HKytcMwNCkrgjYIWYyVUtWKiJaxngB6GERC5v+eHs8PC+6
         Ny2903Zew6BQv2PKOn2PrXhci5PZjgpJqTsStY2B5Rd5D0BM8r9hVBKE6o2h35dLHTbl
         yt4aTZc1e270zX8zRHqQe4/hvPsV2QLAtgtQ2to1Rm0Px5TAySTDyFnCbVILPgdYoI+K
         ygRoJMyIi791+hiDi/z9fpfOCMgi4Wx6z48musRUeUf9i5HXRadOhsgDH3Ar8cpWKOW1
         6kZg==
X-Forwarded-Encrypted: i=1; AJvYcCWV+NY2xbuDX1bvhHYtxM/X4ndjm0NeyoQWMFxW2hPktllxnLbw2QZPywnR6DrnvCQcuVzzaJs6fdPLNcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1D188PjD/MaPDEUphIFTi6PsZ3BfszQgVKdgihUjVlWOlQuE
	dXf3NjaOZ9oEkgnAxXOkCn9sytsU/hCwIkzGZ+/7QwKogkIWQ+DIqB8GDt5AXB1twrXGt36vDgk
	0+y27VCBCRjD0uiMV/6A7M7NKqgbfJ3ci+X9QPQk4YXZyuJJVSatNkAiG3JAiBH8=
X-Received: by 2002:a05:622a:1a1e:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-46309428d16mr146342711cf.14.1731589601681;
        Thu, 14 Nov 2024 05:06:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8BOxCDzfhiRn2Gz53nrznJn+QmhXe+672DgqS/U6htSiQxQfJEIG0thXCkJW1n2w3CatbDw==
X-Received: by 2002:a05:622a:1a1e:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-46309428d16mr146342521cf.14.1731589601372;
        Thu, 14 Nov 2024 05:06:41 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df2664csm61675766b.7.2024.11.14.05.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:06:40 -0800 (PST)
Message-ID: <ef598219-9114-4c9b-8a57-5384ee0747d4@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 14:06:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] arm64: dts: qcom: sm6115: add LPASS LPI pin
 controller
To: Alexey Klimov <alexey.klimov@linaro.org>, andersson@kernel.org,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org
Cc: linux-sound@vger.kernel.org, srinivas.kandagatla@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        krzysztof.kozlowski@linaro.org, caleb.connolly@linaro.org,
        a39.skl@gmail.com, konrad.dybcio@oss.qualcomm.com,
        linux-kernel@vger.kernel.org
References: <20241112025306.712122-1-alexey.klimov@linaro.org>
 <20241112025306.712122-3-alexey.klimov@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241112025306.712122-3-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y2s4EKEZwWZEloQfHKSFHYuWbSXsfakc
X-Proofpoint-GUID: Y2s4EKEZwWZEloQfHKSFHYuWbSXsfakc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=812 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140103

On 12.11.2024 3:53 AM, Alexey Klimov wrote:
> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
> controller device node required for audio subsystem on Qualcomm
> QRB4210 RB2.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

