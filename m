Return-Path: <linux-kernel+bounces-513508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27639A34B43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8543AB2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4FC28A2DD;
	Thu, 13 Feb 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PmR6xa6R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2228A2A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465251; cv=none; b=FL2YHN/mIjk6iJwZg3ODcOvTms4cgIcz3wbyp9C4DWSROVNeRcbIJtQAkPvbMQdYKTcnNoL7o+4eX1Zx1wZa/aqATCA0Jh+Nj1dwbx3dR/uz1ClF9snnbJyvoV9P6tGVZ27j+Fz+CzilOxnaXKZJJzBfaCkidrrCBw0FxmoYxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465251; c=relaxed/simple;
	bh=AMKzVi/B0d2Jn9OIPZ2LweH4Dmo3yJ/iCGhV8aOlMPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQt0U3E1InAIO7JYx6Z0juJl/hxyFLL9kcYdPRA23Dy2sBoBrhugw8mVBmu25USWeeYHhUP6H3TNryduwhBdQNaXTaUGpKnxnx8+RSV7dfoLmoVSvqPHsHdyuCXzSmVHkzj1loVCPPMXBeQ0qJh+sFOHiSdPKU613zRZ7sq5lIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PmR6xa6R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA2NmQ002033
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pdPqwdhySUYtLxO6ZXkv3AyokTUz8gph0Rz4I17smjk=; b=PmR6xa6RZSIyGQYa
	1ohpI/2W5xKQVxwfYPJ0awefbsNAr4lfM/CAAqFZteBUfN/Hk7lWv7DgZJ67Q5J4
	c0rzp3k/0BDNkKkZbheK4pWx9AWAuimPWGQ2kl3MU6uY8pepcnELWRO2Utp+QssC
	3iJvGz1SVsAiFYPQZc2cFWZyG0Q1mQkeZU/+yhfEmsa/yNWF/2RnPo/YP4MLkElr
	mb9Wc4i+X9gNSB1zhyDWEAYcEG6eYMdgP87W9Jo+OJ0ZKkeAu5n8kB0Qxk0geN4c
	FBJ3kU3ek6CgDpgJv2DrnjUB3TCBNFMwvjiD6YLH3shOCg9/8l1ZfdjNV+Onap//
	GLxRbA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44semp91gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:47:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e45cd4145bso2867126d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739465247; x=1740070047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdPqwdhySUYtLxO6ZXkv3AyokTUz8gph0Rz4I17smjk=;
        b=vHI1OBFxBsZ9ykRPWTf2vn6uG0+JeAoJvfB+5juItgOHbfyl08sq3M/WXl2uUeGJCf
         rIJsT5rd/0bjxIuXUU2qLTsIGt7UUvTZevz3kb94HbnelSGPeEGlq/JnyMOoEygOE6yr
         bOd4NsqvLW0bHkcuZEmVBxSEdW+bwbJIPu96906dRykG3ZsFziy0o+8YUsADyhus9pO9
         JeC3LOBBTb7xq/1gnTm3SoZ5YnqJsfrCTs+EewEoRup9DLkY56nKGZDbwgSpnAwhQVFP
         WGu15WZp23iM8fO5NPqbN+M69/yshw2B0IH+/dUg9Hyc2BSIsD97tlvZYen5bRojmI1K
         w7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUjJ88GDFtMkKYysBxgOtsRx2SCt6pVKdGpMLVz4gveKHRNqQ81g5X2pfJdzjcQbQKtGdBBOqqB9+0iFd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QGX1xD1NmJ0dRJCKNdoYEFtZ9Eh3Ace26uf/gY05eTzCEe3u
	SD3qSJWzlp6ZelYriDYW5f0ZySH4m85sSpZXT0+isGKfdaOQ442oTx0OlzEmVuQYfDUrpWX6/mC
	w1+liOUEH9ltVVqelhjS/mhlRBv7FckmI1MkEj8SJ+7bSgsnmVLNda0jznZQgMY8=
X-Gm-Gg: ASbGncsSwWRDIBFDBR7xVcmmHdR6WMTI1BNkWtZFsH8K/30MGXo/P3+wAQjoZ8y8jT+
	c7gVtSdqiQVzZ/p94AH/5cXrzNrljIn6HliQDWqgJSqbtfXzCt9vQE+7XgFxHIAL8fG00/5kekL
	mYCJQzbwP0lWNDaJ1QEAsO8A1/NW4xiHmsUz0oEFOrGSohJCRlkAg6Y7CeANWcx776VgifNokPr
	ksn7L8HjKEDsJx/BsT3LuNfCjwpYhoX/YH1OLMJYg3Wr1IHxV2kXlcJc3GpLkD9oIrMYEVAHdVu
	CR5+JG9739r+oNobi2ggAlPEJ9gXzELFmUji/DY1I46j+JszGGIXtEJSLP8=
X-Received: by 2002:a05:6214:1d0e:b0:6d8:967a:1a60 with SMTP id 6a1803df08f44-6e46ed93ca3mr48905706d6.2.1739465247512;
        Thu, 13 Feb 2025 08:47:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEetTXePMyTND5uVB//0Cph5yyIkXDH1QnV5NVQnh4WczSnYALFJyWUjGFeD039hxpYavxng==
X-Received: by 2002:a05:6214:1d0e:b0:6d8:967a:1a60 with SMTP id 6a1803df08f44-6e46ed93ca3mr48905226d6.2.1739465247027;
        Thu, 13 Feb 2025 08:47:27 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bee4asm162967666b.170.2025.02.13.08.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 08:47:26 -0800 (PST)
Message-ID: <eb7ec79c-a9d1-4d8e-975e-30f12bf583e5@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 17:47:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Print GMU core firmware version at boot
To: Thomas Zimmermann <tzimmermann@suse.de>, Abel Vesa
 <abel.vesa@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20241219-topic-gmu_fw_ver-v1-0-d403a70052d8@oss.qualcomm.com>
 <20241219-topic-gmu_fw_ver-v1-2-d403a70052d8@oss.qualcomm.com>
 <Z64fUjIfFzs4R8Im@linaro.org> <b8004a16-6130-4232-91fd-85d62c2b84ec@suse.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b8004a16-6130-4232-91fd-85d62c2b84ec@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BDiiddL2GaT2_txF4HrZT3Wk3eif290_
X-Proofpoint-GUID: BDiiddL2GaT2_txF4HrZT3Wk3eif290_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130120

On 13.02.2025 5:41 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.02.25 um 17:35 schrieb Abel Vesa:
>> On 24-12-19 23:36:56, Konrad Dybcio wrote:
>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>
>>> Log the version for informational purposes, such as for keeping track
>>> of possible GMU fw-related failures in crash / CI logs.
>>>
>>> Intentionally not implemented on the if (gmu->legacy) codepath, as
>>> these registers seem not to be used on there.
>>>
>>> Downstream additionally warns if the firmware version is too old for
>>> a given GPU, but we already pair the binary to a given GPU, so let's
>>> not go there at the moment.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> ---

[...]

>> So maybe DRM_INFO_ONCE instead ?
> 
> drm_dbg() seems appropriate. Most of the time, firmware versions are not interesting.

Unfortunately, in our case they are, given users source them from all
kinds of places..

Konrad

