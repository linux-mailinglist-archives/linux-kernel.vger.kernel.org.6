Return-Path: <linux-kernel+bounces-513868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3ABA34F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF793A8B09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683092661B9;
	Thu, 13 Feb 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkewnj6f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F0221720
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479411; cv=none; b=bbRO4TJOUBczCwP3GfurKjSiFpcPoaLNoWDDAPturzMQRO11D9vRAyMsAk+Gd1TjxUQgobOKnCwmXGRA5mh8ouoAgZq1OBBVUuOn/cAVbWpFTNuzV9yezLXEQyHEez0KdzoNjj1K0OwDuPMaAyAOjbiV+xJ6Qs/K2NNoMIDI708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479411; c=relaxed/simple;
	bh=KPqeKb7qxXVQvHeLPKJNyFw3t5Osul2JY6aETGmPnqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bX5uEcmDPkRzBi/OcVmK0nNW+R7BT98i2w8TN/VGgcZrKjTc5eG7iVjT5LPg/4lO2W41kgWoRC+R9GWUDvN08rD0aKa9gX8AdMjmLbWTeac3UDoMLJKQ6kfuZu3f8dNLkyPUcB+0VSn3Z+DuR7YkVAEA+3vdrPjKSdhaL9weksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kkewnj6f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DBWCH8011830
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dg5FrKktS73xbC19hkpapwjR69r1aE/kmuxGyVnzOJE=; b=kkewnj6fUupujmzy
	wCMYx3IsHo88XP856vU5xBgsOrjdT4OhEuCzddQRDaHYPkI/KFU9GV8ediY+Zc4p
	zBKWyN5mcR0EA0IFJrrE4xxbyzYNra835luYUbyYU/9MIHFcbMNIz9Za8/d+osTE
	rk1S3Zlx540kJEEPe6OwMzfCEOBLo0y9846RcCbM/m1q+kzf9MqEUpNskZVcKD22
	sXQnn2j1fhYHnChyFkNcfHNH8bnGoEAVakaqUD+aQWFCnYs4HtdWvQAveS1fEC/9
	94783k1BzsbB5ff71pHMGDmerfauQBHDCCmb5qPmb1nQa1xXfZbHILrvdCgNon57
	kYCbEA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sfxw9aw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:43:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e4287d04e4so3938236d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479408; x=1740084208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg5FrKktS73xbC19hkpapwjR69r1aE/kmuxGyVnzOJE=;
        b=rrikjEUff2cui9N+kPxXYJCJvQJbzUPkiovKS1KYfKaFYSYEpIm5/FYTCEsLnUiI6T
         k9Y250jAVu2tAs5NFoAANUlahgDr9KJNh6KRtMjLLgMpvqQ4YDzJt/XuHv15FKpKXSSZ
         U+YqcbB6bIckUFhrhzf36Qwg9tAaQaO+5SntFdUDTZNSfmalN5jZU8eknyjszxObn6x3
         6n2q+vF1YR2m1jPO8DPSjzjrG7m4iD1CHaulrrcfJoLiMYhNPj0dMlbDBi99EcIJFFub
         caAFiXY6O2ec8dpGpzbF3vItqiwhlJntOasMwzbmhfwtlg02RQGtc0mTctrQ34bLjxza
         nfhw==
X-Forwarded-Encrypted: i=1; AJvYcCX+5tXkP+tMNT1iwGzVrXXewxxMOM15S7nABBf8YAmFvsWhOFBuMtOT1oU3B1lpWM91PbYUgBsyq6wUuTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhoG9/Ud6zoks3mLTZfFmgl9VLgZMXm34CByoPiKfDEK/r+sOj
	Pvpbnj60lEb6qYpTMqfdpAf29t5tICJNTxSjLmxrB51WOLO8Ls+BBZW4ky0a+QtLsMwvr6a19MB
	JHo4eeG2YhqpAgLFu6b/3r6zPvrFduuAA2IGt/ausXQKf2PufBCtFDHP+XBPAayk=
X-Gm-Gg: ASbGncukFMNo8hlWQG17IoSwX3hJiLUfcd2iKNmR80B83VbNmeygI9AL7iHhywkc0+f
	eG6aJFaXhiKy0Oi9OcFHl87dDx2vjrJtaLUninZUZfpx3O0IqBFUS7JRcVFO/gkLkNKfDg+mFkQ
	Ajqr9yGN9JlEUfXbXkZojarWDIJdcC26UA4T8BNXAoBQYFjUl7bn7zEiZNVM4Eb+sBMw7Nr6a8C
	slVSNvkFezkmC7WaDarn1oLFxLOjJtLXsOF82kA+hT8A19h71TyUipYA2Wm7bWXc0nURVI1VFjy
	w+yZx5Ffj2ipnszF8ueYf/A7t3jRFNv18peoEBWWF8DRzY0h1g20AK/Qn+4=
X-Received: by 2002:ad4:5487:0:b0:6e6:62fb:3504 with SMTP id 6a1803df08f44-6e662fb3617mr9188656d6.8.1739479408371;
        Thu, 13 Feb 2025 12:43:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxHGRR8DxtnIu1R+97/QgPuFG9tFngCfkEID7ATh5FWvv/MdLvRjxbxVs/jM4V/egIV1OXlQ==
X-Received: by 2002:ad4:5487:0:b0:6e6:62fb:3504 with SMTP id 6a1803df08f44-6e662fb3617mr9188516d6.8.1739479408060;
        Thu, 13 Feb 2025 12:43:28 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5325973fsm198943066b.69.2025.02.13.12.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 12:43:27 -0800 (PST)
Message-ID: <a5bcc6bc-e1d5-4293-b671-79116f911b6c@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 21:43:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8917-xiaomi-riva: Add display
 backlight
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20250213-pm8937-pwm-v2-0-49ea59801a33@mainlining.org>
 <20250213-pm8937-pwm-v2-3-49ea59801a33@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250213-pm8937-pwm-v2-3-49ea59801a33@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Uwn57c7vb48ZOjqNxLorRhZCO-_OXz9t
X-Proofpoint-GUID: Uwn57c7vb48ZOjqNxLorRhZCO-_OXz9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=784 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130145

On 13.02.2025 8:54 PM, Barnabás Czémán wrote:
> Redmi 5A display uses pwm backlight, add support for it.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

