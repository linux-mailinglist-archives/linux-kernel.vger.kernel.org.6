Return-Path: <linux-kernel+bounces-418228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B99D5EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBE91F237B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8121DED78;
	Fri, 22 Nov 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LGK7fAGG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31F1CB329
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278926; cv=none; b=Nq6ctQkNXZy2ab8UYtZ/5WwvGDgbUEbkdnNUHXj8pa3le7zSDTpBdVxf6K5vEu4jGdn9Tblx8tU3pCar/idd9tLHBaMEmBtxykyT60QKk1J+DcOJt2Fm8W5JEZDGSPksPDRcIoPh0yNdZhN221dmaMx3VVJUBw12x088UQczJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278926; c=relaxed/simple;
	bh=/bSeenWD6NQdC1PBVIiMjftf/dqROH/FvwdD2Hsyblo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCy1QrkayKLQ4l1PboZHyDHFdULo6z3U0TMAubuMzNpWYk/vjOiay/pzxqdH1YXb5JshrE5PGsBoLNVJ3lPr1/XuqtjrtfHXePf71IN+m8cS3t8v9YRWfaub6t25YedJBcR5mYs7wLOWX4QI144YtUv2/rWtdxPHPpHTGOf/fpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LGK7fAGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM8bmX5019251
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YmBijtaeUIMD2Q4qws8xURzuS2h9kjPL7kzv3y/aSvM=; b=LGK7fAGGXMuDsXuu
	PbvILGJVBbxKQFy2xuPDyoq2o0SCdnKnqo9tJx8L0n096n4Vf+UzS9STZFTuvGyE
	DRdmf27hQeWcu5k4XIiIPG6VfiSACX20A3lYTINN2O8ud1ej5LPZIzt5kfixGS34
	VJonUSFLZL6rlV+lmEpEKXr9VdZNyHGhdJ/HTcnjt0xcSUdVFKDYJUZfmpjlR8dZ
	rdLUPo9tSREuHMxzMKRcZtYEs30bG9tSU4mMicXvq45zkB7RiCBScJXRzNu14fBp
	qZHrJj5tx8YonBIZ/zAmDLid7fs+hSYZpyLAzNDRWjZmVr7FKMBVvr9qFOCBT5cb
	e0ahUQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431c7hqdwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:35:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d40a926b91so5235876d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732278922; x=1732883722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmBijtaeUIMD2Q4qws8xURzuS2h9kjPL7kzv3y/aSvM=;
        b=mJL73ixq0jPx+McR1TdsHAHG9i9ztYJdWH6ko2ulE8FsmZe9JpFXKzVBuKJ8T9tjmj
         K8cQrc8zf9LKxCRn9f6f7rwO/d0KrwWhYBKpr4poAiErGBhVzBNCIBA1Sq1Vk9J1NRqs
         qb532d8Q+bCYIYIZBDF9EXDrSTMisG/kM7g+434kiYITU5XH70+13qkOc6eecPU9wxIS
         VZs8VxeWELoWD5BgJ2y66p5IX5QNLYWD/AjtHPwJHhq5z6KysPig9SuQmOwskVPmG0Zx
         91Ru9qYA9P4SI84HvJwyIb/Yi14Fxm/TaBV94nPh/hMjV8PWF7a1e14pziM+w61HAS8F
         Frqw==
X-Forwarded-Encrypted: i=1; AJvYcCXbl8HbYfWvyiGwvm8yMsI2vbmFEIjxVbUr1fuADoUOGrH8NdV/mz/M1dHhdmi8i5eew/3vokz0edCjJ8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+qdp3KeRMNnNktNUg8KOWUFE3ePPOoqflYSURIc2CAtD1Jan
	E+1vF597FXZCQJtm5mC1E1lsiCeKnrkrcnAR3DzrWYYmhgMLwRqGYTtV4v+mf3t4e6bJIhCfgVH
	DsLCN80O8LPchHCcpwZfWMQ0Pp/FnSaSL/1Rc2p45qwM2Ss/wm6I032Vi+0rliQw=
X-Gm-Gg: ASbGncsjq6Ht3Mx/Q9823ka/WVSi+Lsj9g0vhuV2/FYj9uXcLmpT6f9vhaqmPdvKC+6
	dI1gzoV7aYHsKWyDy1htBwdnF/XkcJJYmv0aTbcRgdMz5NRPpcaUHp6kTuOCXMxzZbLPFyPQFgs
	EnLtgJoewjOOlotVP7PiS3a2bsFES/e0xeghZnOEUFso4e1av0w5bO0Ff+T7PyMhLRVye1wGzH2
	og1Kgv5hkOZPCLM3WPp14AzxqgtEzFYZSSkFuBBAuG/O+Dk3W3Spwsctazs+J3UUIvQL5iJCFlA
	xscf8CUvimxFgc5rRtK9TAojTUekQWA=
X-Received: by 2002:a05:620a:6283:b0:7b0:6e8:9508 with SMTP id af79cd13be357-7b5144ad110mr161955985a.5.1732278921646;
        Fri, 22 Nov 2024 04:35:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8uIE6oiCtMgsiJkE35Zoovx430qO4c5U0D4F91/nuFLw5NZvdNcCQH20F0lI4XhKW9QuIIQ==
X-Received: by 2002:a05:620a:6283:b0:7b0:6e8:9508 with SMTP id af79cd13be357-7b5144ad110mr161953985a.5.1732278921290;
        Fri, 22 Nov 2024 04:35:21 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d02062428fsm754087a12.40.2024.11.22.04.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:35:20 -0800 (PST)
Message-ID: <bf27f92a-5fc6-4b09-8653-4ac3ef438d4f@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 13:35:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
 <20241115103957.1157495-4-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241115103957.1157495-4-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: doNE0t9gohQNztSiogCjcOJhtWVu77Zb
X-Proofpoint-GUID: doNE0t9gohQNztSiogCjcOJhtWVu77Zb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220106

On 15.11.2024 11:39 AM, Manikanta Mylavarapu wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> SoCs without RPM need to enable sensors and calibrate them from the kernel.
> The IPQ5332 and IPQ5424 use the tsens v2.3.3 IP and do not have RPM.
> Therefore, add a new calibration function for V2, as the tsens.c calib
> function only supports V1. Also add new feature_config, ops and data for
> IPQ5332, IPQ5424.
> 
> Although the TSENS IP supports 16 sensors, not all are used. The hw_id
> is used to enable the relevant sensors.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

[...]

> +{
> +	u32 shift = V2_SHIFT_DEFAULT;
> +	u32 slope = V2_SLOPE_DEFAULT, czero = V2_CZERO_DEFAULT, val;

Please don't mix initialized and uninitialized variables in the same line,
I think it would be the cleanest if you initialized the ones you want on
separate lines and then declared val separately as well (and preferably
in reverse-Christmas-tree order)

[...]

> +	}
> +
> +	val =	FIELD_PREP(CONVERSION_SHIFT_MASK, shift) |

tab->space after '='

[...]

> +	/* Select temperature format, unit is deci-Celsius */
> +	regmap_field_write(priv->rf[CODE_OR_TEMP], RSEULT_FORMAT_TEMP);

"result"?

Konrad

