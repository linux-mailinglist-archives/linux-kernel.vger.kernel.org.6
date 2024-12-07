Return-Path: <linux-kernel+bounces-436012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12D9E7FE1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 13:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05ABE2821D3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80E142903;
	Sat,  7 Dec 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ekSiNk2O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389B13DDB9
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733574762; cv=none; b=mrK5zRw+bkiB66EI+ONXOm7vvaiWefuHDW6JUXMeLb9QfXGtZKIWvkEDKSNyaYWOBAVFBkjqZFd0GMlicuMbkSQuUlr+FEza/8fpTBIpmg1UQb03Arcun1/vKrxS7N7RgPWauu4XzfCE3Qpnu1tdh8w186B0Rdv9FYC+IeZz7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733574762; c=relaxed/simple;
	bh=azUX6QjhKkZXkY6xijKfOhHqxkK6wJmGsZLPCnqm44c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrBSU/VE0FqT4+RA+138douzV2hqWbH7yxKqDVyCi/qiA2y+8TGrlarkr7ojX7a0/bOh1UVnrKTbqOBMDrT8p5Na3j0LZDLc67ZbX1KtBszIgBW8uViwzlDBGv7UFHAdMBMicUbiEa1ifMDEqeEeaxm5kfGJAbBQXRuajor3PhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ekSiNk2O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B79p2tK013881
	for <linux-kernel@vger.kernel.org>; Sat, 7 Dec 2024 12:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M92CAdkic6Iwv4reDSMoGjp/K6oYfQp/wrqMiHWSzvI=; b=ekSiNk2Ox6mo4Y81
	3mzkonUlxfEJAYcBwP0h9jYedTY0ks7CLKOEhnK97G6vEEFOS9kvnyc7NndAdwRN
	neTR34x8dM4CXeZpCkiM8YhgXDxUKGW2ZO+S+8i2oPJwZgXWSK8SL3qTR2JePIWC
	hiMRGZ9BlO8FSDc/UdivcLvaIxD0wqwkU059Yyb2OFALVJFZaIa+GiZ+DnGBq9nh
	kcvMQf6fQSZdl3+nEZxyGMPniKVhJkJVjlyXZv+yssKLaqcA+E6tP1R2LtyymY7m
	S0xNw6eI2QP/zWeE7RaP0t3bf/5j4vjDzoGJCETb6AyDibZokVPDLOzwFMTqIi+z
	YVglTw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ceetgmey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 12:32:39 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d880eea0a1so8035396d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 04:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733574758; x=1734179558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M92CAdkic6Iwv4reDSMoGjp/K6oYfQp/wrqMiHWSzvI=;
        b=Ipi6oU5dxaYDAq1v3RxVBJgfi7dd6YrlhU9Oks2GQyhI5BubVVekBvUQhLXoWF7s5G
         JEvbEKBY1kmKY2f5407BwOOA4+biylFHPDrTqJeJlHv8Omt/bzbivEsq0Vc+ztXRYof7
         Jb4pDB3kLGQB/JOM4la48YHL+IgZD3Bd42DAu/vECCtzIOzWbaIf5+enSBO6kGZ5KJn+
         23RNMgx36XtA8PCZtu/SV0sPbQ8y78Px9jDvtsVEE8Z+l9ILGtB3JjsraVGIdGnbwNnm
         4gDEL8e4DyH753j6nRGHJzhNRHSkvDo0v6do6L7zamF0xwWErbqCfn3GdH5P3B/gHTk2
         QyvA==
X-Forwarded-Encrypted: i=1; AJvYcCUlS2ho47NsBF4IhfTFicSHRIzM78C0UCdL5xrLmHVwFECYMJ3EI+jJHUAkI9xfhlxGFcHN5ky1vs/TkKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLB94l+M8n7vqO/vt//eWHZ5tM5bN/2HhS8DW3wLpur+Ldw1i
	IqRQaqeLZkUQC2/PuyL/rm6vBFm9fqJzbKT2F92Gq48ca+1Bu5nyUXa6H9dyjcYkRh44Fp3+5Ns
	5FppuxtIL4Ewwx3bOc4nk8teME3odbXrvAiXGSwKt6SvQfMUXHVUCBLUGLOi12GDAKHAEsXg=
X-Gm-Gg: ASbGncuI+R+JNu3TdJ+0mc0ZpYAxoECtZvPF9wecZ2MU9UalK9zXMKA5Bgrl/sAuCYA
	pHZz6UckPNVDDL3mqYh4xpvC9MBupRv7vEYeh8GTT+CVU76B9XoZ03JwkIgqmqSPEy5HsBOKQy/
	8KJoQH4UN04pl0dd0R76+SkvrlMNxztkMFSRLkB0Bfl5uD31imBJA1dtXCYZMCbFTxEoOUJK6s5
	TNbg6hCFHE38nj4pyg06Al65JSBxe2FQ69DMsda9hY2qyGTeD9HcJht2VeB/xIVIJLRSOOlkGWq
	KHlYLK9y5pqCYlrDwxG+tGwlB6eQ4CE=
X-Received: by 2002:a05:622a:1106:b0:458:21b2:4905 with SMTP id d75a77b69052e-46734e23e91mr47843401cf.15.1733574758470;
        Sat, 07 Dec 2024 04:32:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3wWXdprg/kZHC+CBFAeMYZnaaMhc8iBKhfLMgGFCoCHZ6CdKvwoIOqu1ehiQUHy2+VrE+Xg==
X-Received: by 2002:a05:622a:1106:b0:458:21b2:4905 with SMTP id d75a77b69052e-46734e23e91mr47843151cf.15.1733574758072;
        Sat, 07 Dec 2024 04:32:38 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62602cf52sm374919366b.115.2024.12.07.04.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 04:32:37 -0800 (PST)
Message-ID: <05e15b8e-d7b5-4af0-a811-4222bce0f99f@oss.qualcomm.com>
Date: Sat, 7 Dec 2024 13:32:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5424: Add watchdog node
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241120055248.657813-1-quic_mmanikan@quicinc.com>
 <20241120055248.657813-3-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241120055248.657813-3-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1g-XHGJSmFqYQ0uShJcJR_oVcAipaHu0
X-Proofpoint-ORIG-GUID: 1g-XHGJSmFqYQ0uShJcJR_oVcAipaHu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=859
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412070105

On 20.11.2024 6:52 AM, Manikanta Mylavarapu wrote:
> Add the watchdog node for IPQ5424 SoC.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


