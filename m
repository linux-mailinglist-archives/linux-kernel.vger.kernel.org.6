Return-Path: <linux-kernel+bounces-443503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD09EF399
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7476217AA70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A816622D4C6;
	Thu, 12 Dec 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i4tNv6W3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6A223C54
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021607; cv=none; b=CC4FRN90fzwfGcGU0d5iMrqx5UqpGG2ap/95iXX0NlXzE92zkha+nDB8FpGvVmo80l2G4A3psZw9w48n+DKDnjhUbsCIPjolCmq90+4qnUk9Pp66GZENcW1XyBufmxhcSyWMLx96GYIL07gndc9EsKbMS9eJscoDSBcFJcm0WK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021607; c=relaxed/simple;
	bh=kEb3ESkZIpLBxO6ChQiW2DNV3iem/uNx8Umljn2afxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t++zvyene6igQesWLpFQCOT0+L9CJkX98v3ZsVbO+NgnaqiQfiEvK9Xt3wXTISGN7mIGzF5FE9150pWZ2jBkzrKxG2wFHavlGPTydDOrfd7UOa3VXD/M0/75+4Ri/hj+W5XHpzRQl01t5hmkbJgZD+575LGqf10jw3Vz1m9mPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i4tNv6W3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGNImH029994
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kEb3ESkZIpLBxO6ChQiW2DNV3iem/uNx8Umljn2afxw=; b=i4tNv6W3zFrwF6Lz
	U/YjN2U8CUtzwk18QI3LAExBBwxyDKk65ly/sjvMIkaeUu7cYrlLMiGd6WQDoCBL
	oa3fM/o3kGxJLHLgPzbjgrKyCf45BuktOChaqTl205j+kSqmwAfMDbshikCc+CSu
	l4JZ7gh/2kwnj0Ci/kURxfZjxiA0SF9DJfJolm0eXyNOoWvrLVJLiSQ5Dpxm6Si+
	bTxEN2d7CdcHnCLn4XQFBlf7twbsN66Nxl5+02UrxwlCqzSd6kysEkcrScSgw5pZ
	PcdR5PI7UZzY6J85ehJWHK8Kfr0+46pJ5v3THx3GIvfYkH6aDc3+z6gSmrZ1PAhs
	fsdYRw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw4c11f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:40:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-466a20c8e57so1733211cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734021603; x=1734626403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEb3ESkZIpLBxO6ChQiW2DNV3iem/uNx8Umljn2afxw=;
        b=WNSiOqSL2+sSyb1r4sExYHsxxvyL4Mioo/2vLyIPjeMZfuyjt7hRXo/v9Hq/NQnNVv
         0JXAGohRT9t3qBAu50Qogg5YVnLaOKYrDgPELB5qPJSRVY2hVY4XJNks3A0sWHjVtx8k
         p8HkmkEVagPhwvAxFdpU4NYMdRzfs/mdHIhNCTqmzs8PwkXZFey0H45QWB/8Pp6D5qWH
         1fL8S8PwCa/QZqEJDpdx8+pg7fgvfatNcJs5KsZoc5StKYBumziubvegeE+Bnc3mqD7a
         VfKbtHJD8DpAF8CLrIdY+kqfIdzxqOcHQZJj1G078BFeamfzIS6CHPzwcrjd0Od9D0k0
         nL5w==
X-Forwarded-Encrypted: i=1; AJvYcCW7I8pWhU2upOZvTx4C0dPEezqx4ygsGZJUCZl//G/BUh9e7bh7nWFUOVSYBlyHTJG6CIfETlqVa0Bdxs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywatue1DwwgghsWluuPAMZRJ91X4IoQuOj8lODSUIQJz/Swbs4K
	0aTzPqwoFa8zw1SdZEdJQx0H+M7ctDp8ovBY4elhldpop1q70baCp1XyOIfLq1u7J/3FIQFV8cm
	h+WdKuIcq6Uviz2ipUzW66D+bSlomcTr8Vy9ivt6nKyAumBy9BekXxzJhYESBFjw=
X-Gm-Gg: ASbGnct2pbthpARwuFw2Zc14RT2ORwTW8BZvZ7p4XjrvOKS0+GtwBCvZ73XrAGmB1tx
	UegElTmxCUbzMPk+paqXZoqb4Woh52qS9lSYpzA/Ja5KLfw4FRaFqTJBqdz4zsj6K7WO5GKaG1e
	hQz6cd6OszlXjpr3DR5Z547rOEWkSTa97/G+wJmh+v/bUCbze22LPXKVhJ1efMWbeOUlo9PcpQ/
	AhZBqLkNIibho9Lsevv8JfamPXWVb8D+o6TmWjPy8pB6bvTDM/eEWihfUC7DttF0u9bcnMC0nrF
	XfeFtp0o1SaqVbdE/tX63rcZbmkWhcvVQQreFw==
X-Received: by 2002:a05:622a:a:b0:467:885e:2c6e with SMTP id d75a77b69052e-467a14ceb0amr6505881cf.1.1734021603234;
        Thu, 12 Dec 2024 08:40:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLvFj8TYhHqAdCQaswyICMngZInZ1e+XWLZkhVURT+fAjQH7mI/i/omj8bnfV+3LE8tBfFAQ==
X-Received: by 2002:a05:622a:a:b0:467:885e:2c6e with SMTP id d75a77b69052e-467a14ceb0amr6505581cf.1.1734021602915;
        Thu, 12 Dec 2024 08:40:02 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69dd81272sm450830866b.161.2024.12.12.08.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 08:40:02 -0800 (PST)
Message-ID: <1b25b929-b14a-44be-acd0-b5f4f95241b7@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 17:39:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] ASoC: dt-bindings: qcom,wsa881x: extend
 description to analog mode
To: Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org,
        konradybcio@kernel.org, konrad.dybcio@oss.qualcomm.com,
        andersson@kernel.org, srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
 <20241212004727.2903846-10-alexey.klimov@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212004727.2903846-10-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: A8WB6TVOhOpMJ4z_138beqogKYDyy20j
X-Proofpoint-GUID: A8WB6TVOhOpMJ4z_138beqogKYDyy20j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=802
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120119

On 12.12.2024 1:47 AM, Alexey Klimov wrote:
> WSA881X also supports analog mode when device is configured via i2c
> only. Document it, add properties, new compatibles and example.

IIUC, this can work both with i2c only and soundwire only. That's
not fun to describe in bindings..

I was thinking, maybe something like [1] referencing and i2c host
would be fitting, but now I doubt that given we don't even need a
swr device node..

Konrad

[1] https://lore.kernel.org/linux-arm-msm/20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com/

