Return-Path: <linux-kernel+bounces-433710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A326C9E5C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1D6168DEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7456022577D;
	Thu,  5 Dec 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j0M1OxOo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE28225782
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417116; cv=none; b=Ypu1LaJDhEI6nKrFazgKgucsXBfdtX/0xxO2P8LJuUJoJMSuHxK16YF6rRDfc9CAkkc/+aPjsuRPK7GGy46dYKcuGRLFaF1SBf4JIgt9jlRiAdc8frfb9pWYJE3ESvTX1V/wVYmGrm9hVVV9ncZ6NktLfAWxR5rTfN7Xl7H5/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417116; c=relaxed/simple;
	bh=pZ172ATfsfJ2BQ37XPU3FqEzURxmxw/78IvOUTlorVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSaZj+jse/zt0GPON+v59k6XQ7y3zt/ILQ4cAPiCd6eWN5fmKuqchLNclzUKIfWJSMcn8mNHqybxXnICL269yAroF8AK4hTJ77m3f78Qn45RMTzrS+EJ2+j6YQqRIAQ5Z+m68VeachzhUpHo/+Q1GSt8J8L5N7CcpzuMO3DdibM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j0M1OxOo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5EobkC032120
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 16:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/C/FWedH2R8A8Hc+9FjqXWKobRD7gLjrdaMMk5hTAQg=; b=j0M1OxOonQqe955M
	gmabG0U73860SAAdv3XU7eEwgSgPhIwHGS7HQZTA5SQw6TQT5/rTFvgUZpV7j9tK
	nVZN60vdwWL8iwTp9oVKdI0drxX+j7IcuoszPJrlaapQ+kWvnVPD2v885HpgwrnJ
	78zKYuOAg/2GUDnAnJC7KW1FCPJucqYM5EemYAWNRDdlUkS5m/y6uXBp5H6aE0fT
	JI3xI0weJ6RtFpI7UQi9I4fa1OwcQQGQ3MaeKaO71qPGpkc0nbh13aOI/suwIniv
	jR6ZULQweDZdh5uaoRdeerVwvwysnZ1x0nazzLHN8oq41CYP6dU5/7CG69jZH2jV
	N7Us1Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a3fay5mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:45:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d885b3003cso3282706d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417112; x=1734021912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/C/FWedH2R8A8Hc+9FjqXWKobRD7gLjrdaMMk5hTAQg=;
        b=RQ5v4KXUEXAEeL3Ktz5v/64pqDkuWsYTwhSlEdtQw4TRLwArDPjGkFL+Tefpd3MpLQ
         RVT4Fq4dfb3DLwKilagqCBU1oTCrhXiCLCfqPhGjEM86mFPixjqaSsJxGkb0jJtR8IA6
         LEanlygBCV9r1AKXejQZ/RWKy6upupARmy+uvad8o7SWVp1F7J5fq+ddNMm6q80fzEhM
         rFBQihno8ofOwmGgeY40tBc7O5vwHxZg0rdyayvoLjnY7acNGopKb/UHmB4JNZKzXjgt
         VhqxECXyu/fAOrhZBSKN1CnA76P42Shm38e9qkVnqXF6rNATKSpmqWzBhqnbsSOJB/ZX
         8xCg==
X-Forwarded-Encrypted: i=1; AJvYcCVxMgoCBS04sUOT3yVkTIGRX73KMIkIWGrVf1/poJnqd4ea+mfB9X6gN7rzg9qo3UDWlc8I7Pq3H2TzBl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXgtm+RYiE0BQOoqx56oMHkT793T+KumNYrxF/kexQM8r6BhZ
	huib6sefFbc/JDFGpLoU7sV362TjvHGKPM+a5ugAJEuBrEVbChMLeI+5qoUF++EJ6sCdHYxxXLO
	0J+K3lfcH3sJV1nHdLcdjvcVQxVG458QzNjo9gMk2EBvJoS3WS7/u5wMcxhdekhs=
X-Gm-Gg: ASbGnct+7ZH6PC5YpslCPBJljc1yHjG/2xaV+mSjnHbYocW6XAcGV9suJKM/L2zi2Yk
	qndbyt0vNi6vH1nB1S3VNZW/OK5Gyck0vSQ+DklpPqb23dmCDHuJPfhOJIKKng4daXRQs/3h9Qq
	SivhVnRgFOCeyUWI4DzA7XsrrVRx2CX72a42Gz3Li8Lam9RZg8okoGr1hKOcLLk8oAVBMlsct6c
	iAcZO8F6Fts8QrEI4WgmqNG0jLrrYjwkc+8OHZEPoy272pdLO5TpTiMd7lvk/QDwTh2AxuQZTz0
	HrF//G5XD1ccxf3TbQa8zuWeqi4V6P4=
X-Received: by 2002:ad4:5fca:0:b0:6d8:a5a1:b14b with SMTP id 6a1803df08f44-6d8b72eec6bmr65772306d6.3.1733417111871;
        Thu, 05 Dec 2024 08:45:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm0uGog8HsgJ3rIQBC9bvmmITCftd+KZF3JVpTwKemdKnbxp9/YQCrIOez+txCW3LKU/3shA==
X-Received: by 2002:ad4:5fca:0:b0:6d8:a5a1:b14b with SMTP id 6a1803df08f44-6d8b72eec6bmr65771926d6.3.1733417111373;
        Thu, 05 Dec 2024 08:45:11 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5d2sm115958266b.93.2024.12.05.08.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:45:10 -0800 (PST)
Message-ID: <c703e70a-c705-4010-8f12-bb55d67f2255@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:45:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/14] arm64: dts: qcom: sdm845-starqltechn: add
 initial sound support
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20241205-starqltechn_integration_upstream-v7-0-84f9a3547803@gmail.com>
 <20241205-starqltechn_integration_upstream-v7-12-84f9a3547803@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241205-starqltechn_integration_upstream-v7-12-84f9a3547803@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: t1QBD-LfwkX56IwI0QAKg6eYeQkbvQNm
X-Proofpoint-GUID: t1QBD-LfwkX56IwI0QAKg6eYeQkbvQNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=963
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050121

On 4.12.2024 10:34 PM, Dzmitry Sankouski wrote:
> Add support for sound (headphones and mics only)
> Also redefine slpi reserved memory, because adsp_mem overlaps with
> slpi_mem inherited from sdm845.dtsi.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---

[...]


> +	audio-routing =	"RX_BIAS", "MCLK",
> +			"AMIC2", "MIC BIAS2",	/* Headset Mic */
> +			"AMIC3", "MIC BIAS2",	/* FMLeft Tx */
> +			"AMIC4", "MIC BIAS2",	/* FMRight Tx */

FM - FM radio, or "Front Mic" / earpiece?

> +			"DMIC0", "MCLK",	/* Bottom Mic */
> +			"DMIC0", "MIC BIAS1",
> +			"DMIC2", "MCLK",	/* Top Mic */

Looking at some pictures, I'm guessing these two are the little holes
in the top/bottom edges of the device?

Konrad

