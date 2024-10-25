Return-Path: <linux-kernel+bounces-382682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD09B1202
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C96B21A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67120BB5B;
	Fri, 25 Oct 2024 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LBJrvLIP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3F217F52
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893192; cv=none; b=dfxzMtdM//HrYvZc1yuI+rQkrqCFWcJB34iIWiKoT2p7uxVyHoy3l9zPeRlLf1rkNhi9uMyYfMPwzDNR+EE0FUJtliwWicEGG8xIq8F9vvYjJ+MTDgsqFl8VoAmJQNb8zZix6/exCk8E6igeueJjV9GSEphRKHbp6R+MqSj/LRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893192; c=relaxed/simple;
	bh=6GeOWhrjGYCL982yNJxHpDEKNaEsIOQVVRx6HDGXoy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFZX+RNdYKwsY4rjFB1RUnRb/5/LKzAQWOTZEkZyxz/sGJeDFE+qrE2bmekrqIFp3/P2T+/iQQbnNtZFUXFC2Tns/xQ64EE9rGiLFLzzWVobpvzSQbESPEV/tlh78qckprHZrJWcDxg9wRdjpFcBvTwruT4ZTTP2R1nQKTwjT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LBJrvLIP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PB2Aob001022
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6GeOWhrjGYCL982yNJxHpDEKNaEsIOQVVRx6HDGXoy8=; b=LBJrvLIPQTOZFtHh
	4hNeIqNAHQljwDqMckAz+j9xzXbFhzs6+Ak+hcga1GzDYihTW6GgQZVwkywHM7M+
	nDn/cPRGIxm5/yWo1T3AmOwPxiGeChnR40h94NiVlRIjqPyD/icXniRsRCuaJXQO
	a4nwrOIqHJYH/DQyK8U4km7EEkqfYwC6A8x9F1ZH5U8cK34waeduC1Q5wAxR126E
	vtZ+r4vTsVnf0c+V09jyS68THiCzNyr3GCSbE32509KGdbTltxuL9iwleH3IlZkX
	NjRsSuiP1zeKt0wmSCsjiGcq1uDn07RsJoid/pejxkNaL7RkS+6HXwPuEiQd+Q3X
	/UWiIA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ga3s1nnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:53:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbf4770c18so7338836d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729893188; x=1730497988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GeOWhrjGYCL982yNJxHpDEKNaEsIOQVVRx6HDGXoy8=;
        b=FyaSGSeHVxbXPWiiW/JEA9Gu1mK0HELdEIhdHQSOuDleY/3KaLpVThx+WNVnyO3tK3
         uSQ9hrjGPHPiI6qzLpmYq1tK2A+nkF9fShUFR5X0y8xH1s7cilIWX9Q6Z0BDhNhoT1LO
         HNqathzQN3xvY/PpMnnhiApJ/ot8QpQhlZB6l/NPSx/xYolFKBrzPuIt9VmvEyM+atks
         LRjx4IezVGZrBzMblN59+k9HXQN+i7khXPQsNOD2Hu5+8PrhBSBze1CgTT7Fdg5G3fEw
         R+JqlczWwaRtVKg/rsHR9h3JcxQKfzqXkS2q1TVxDcuRnOf/dL7Ce5KSsFyVVM6GVZ9H
         /rGg==
X-Forwarded-Encrypted: i=1; AJvYcCW/VeLtwFwn9/THvC1sz2SwUR41HObyLL9Xp4IM+D57EhnIgWZWJ11RaZgt/6K7P2sBiERbXy6vsFh2Jdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnR1eXDgqQ/TdXa8Pg7eRWstw29f6ptvVVz4msLXaDtH3o73J
	+qfaIlSK5hym+Ri9BVcYMcuHxxuajGlkoLKzGZ2VmL+KpPKEQAH8pGJyrXYgxSCZbtrSMnDj3Jx
	OvZecpnjlte5TB0YWBfkwp8HpqlyPaWZEvhLHqgwHRJxMVo8o6d2mDFf1Wu3b47s=
X-Received: by 2002:a05:6214:19c1:b0:6cb:e7e8:9e88 with SMTP id 6a1803df08f44-6d185885e9fmr6384236d6.10.1729893188124;
        Fri, 25 Oct 2024 14:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEslwHHx6dighOzv1/9OBtgqY0Tn3FagIVg8QIn1ToYUExPrzN5qxZ9a8b/HkXDPpIXqYsBHA==
X-Received: by 2002:a05:6214:19c1:b0:6cb:e7e8:9e88 with SMTP id 6a1803df08f44-6d185885e9fmr6384016d6.10.1729893187795;
        Fri, 25 Oct 2024 14:53:07 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f29744esm110069366b.130.2024.10.25.14.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 14:53:07 -0700 (PDT)
Message-ID: <2cf6ca44-3a7c-4561-91db-5493414d61ec@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 23:53:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: correct MDSS interconnects
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        stable@kernel.org
References: <20241008-fix-sm8x50-mdp-icc-v1-0-77ffd361b8de@linaro.org>
 <20241008-fix-sm8x50-mdp-icc-v1-1-77ffd361b8de@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241008-fix-sm8x50-mdp-icc-v1-1-77ffd361b8de@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Xz4IOGhOOnWKN0fcPQ-8lLpRWxZB-atM
X-Proofpoint-GUID: Xz4IOGhOOnWKN0fcPQ-8lLpRWxZB-atM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=751 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250169

On 8.10.2024 1:36 AM, Dmitry Baryshkov wrote:
> SM8550 lists two interconnects for the display subsystem, mdp0-mem
> (between MDP and LLCC) and mdp1-mem (between LLCC and EBI, memory).
> The second interconnect is a misuse. mdpN-mem paths should be used for
> several outboud MDP interconnects rather than the path between LLCC and
> memory. This kind of misuse can result in bandwidth underflows, possibly
> degradating picture quality as the required memory bandwidth is divided

degrading

> between all mdpN-mem paths (and LLCC-EBI should not be a part of such
> division).

I think it's just for power savings, but maybe Abhinav would know
better

Konrad

