Return-Path: <linux-kernel+bounces-552665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE972A57C89
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E73B064D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89D81E8356;
	Sat,  8 Mar 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bp8AdKXK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903AD528
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741456221; cv=none; b=Zu0i9QLnaMmoztuvZMwHuq3JRg8YJH3fsn3QRFFDKew1k8eg1WA2YVWzVCrLOEf8yj2/Pc2QTnfsRIL3cuOaMEHDymRM1/Wf3bv57tZsEuwGX5yBf00bI7am2LwK3LsAvZCYMLyS38N1JFUtKDJGZ9Dnfw+iR3nYe45/ZjD1b1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741456221; c=relaxed/simple;
	bh=dQIUYzi4H3jR6gxsOng3CxQaSFYuj4bsVwlonUiWoN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpsHoYBRZtqdCIpxOepsDiokEr3BpImGdwLRd5+oaOZcttKdFght7ZsjqMrycsshjSH55tSZjLUnIXFnf9yuUajITh0GmRXxXt0YFN6Q6/SJ8UeUXRLPIaTApk6R4NCFBLryKof8Rj0Gve8AWmiSueTGTbJfSSRI8BTnw/5Ccd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bp8AdKXK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528FouPd009664
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 17:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zj9BnuPodZObJbGZ4wO29xgzIU45v7SD9LP2K3bAeJc=; b=bp8AdKXKCQU0aZ+z
	PXGOaa0Y9Js0wMBIgch4E82UVeQPjB/LSmoIQwEVkoHq0QFZc4sq2BVX1BMXvR3O
	Ol2/jPgN8zedvuw5Mfa9En87qOZL4kWW+tMY//qZJx3/VjJzerFTUQPElWzCEpBa
	sICvlOE2rvqDzp6RF7C8snMchafCHDzkteSsYHE+BqZzROI8VUTjoKnxOAE3HENz
	XpYV4pU6ajPwS94hWnfb7JZvVo8uCCjAc1pmvogjSmcmSUxy1aYAXiYlKCyGMi+T
	BZq7mZLqLSTIU4xiTHjuMVmul2fS+V0sp1rqtGqfESolodSaHhzebSvd4mDdz19g
	U1Dbag==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewpgwpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 17:50:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e19bfc2025so7655236d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 09:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741456218; x=1742061018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj9BnuPodZObJbGZ4wO29xgzIU45v7SD9LP2K3bAeJc=;
        b=juRk+gZD0Q0WbbyAzT4IPD0819xE3k7Gcx09nLyEVZ9N76U2GnR1khxISFeKfw53hI
         i2A3SHuTPTq4Vi3L0N2Rcx0f7IwbOko4N4HQaO5lqpS1bxSde17FyZbatoQZdn1EM3F0
         E8QGnN9fryoIuoal31e5nINrHYoWKLW0lRy8MiEjH6wzJow+dybpawEvBj0m1eK3Ekqz
         uSE5CJiuAg0WfgLzAGIPTTAP6CId6nGInD21xmO4zK9eEoaYiUl+HmlGEMzawC1dtLHK
         CJlxFoZkGfwtalPEQz3l8Yp+BwjrRNlWnR20Kk7hwsjXRZgn1f0FR0PnbqGDQmcbfHYi
         x7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI57arJ7MrSzLA1q3o7dUIrrKo/Z5KuyXtKN/PGheuyF5w5yP2hw3NYpYPSwB3to7wIPSTu0ZHAUNz3os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfVab+vC3OEGIMoYLO88EZM/Tv4aCRl342/I1mjoettNmUPMK
	iJGJziNlwDZZzZZ5rhZa4GD2u7Z2K1QYPeW5HU4o6EgTWjbr/ZDyxxE78PFTunWovY4LbSdRgWA
	dZRvrWPT8Rg+x4u9D/Nt2AObKQRYKbhsjolUygRrCi77+6yw/dlhAjxtZaAv4Fmo=
X-Gm-Gg: ASbGnct7nTLTjRQ4VKqmHfxrZOyrH/ZuiN1ZOavZCFfVPrw6th0I/4IetTRRWnjpZmN
	U5F9C99LGmI8i9EPRKXd9wBNX3Zw6s6q1diUo9LuhJNW36EckYShsRG/HcAmHeDG3ec4tg07l4O
	Psy8xMtLV1MgQe5bsEIs95VIFjwaWzo+fMWhtFusI4Absc8Q72nRhr5rOqX+GoM5KDkrdqyiFWm
	iwqUCXIRl3QZYeaCSjlXBpR/CDFKjy7r5q7GvPKf0yccoO0UuNOwScvlhq5yC3VLRxoGPXBFbSw
	csP9z5XdCA9hnJZbOb+hYaTGDTz92l4IdF0bUXk7Bh2tNXw9tYW4MBF+JK0AoFBfBE7tZw==
X-Received: by 2002:a05:6214:d88:b0:6e8:fa58:85fc with SMTP id 6a1803df08f44-6e908ca70f5mr20078236d6.3.1741456217898;
        Sat, 08 Mar 2025 09:50:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkXMzgQacIMxKsPPQ0qqQUPmgYGnLd1EMdHSa1p+AZWWj27YmK4io2DsVwwuxR16lQY4gJ9w==
X-Received: by 2002:a05:6214:d88:b0:6e8:fa58:85fc with SMTP id 6a1803df08f44-6e908ca70f5mr20078086d6.3.1741456217568;
        Sat, 08 Mar 2025 09:50:17 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988b64asm462789466b.155.2025.03.08.09.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 09:50:17 -0800 (PST)
Message-ID: <d2db3fc1-3889-4718-a905-9dba892be251@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 18:50:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] drm/msm/mdp4: use parent_data for LVDS PLL
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
 <20250227-fd-mdp4-lvds-v3-4-c983788987ae@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250227-fd-mdp4-lvds-v3-4-c983788987ae@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: C9GrioTbPQIrXTF4MsoKQJOVb7Gtwmi7
X-Proofpoint-ORIG-GUID: C9GrioTbPQIrXTF4MsoKQJOVb7Gtwmi7
X-Authority-Analysis: v=2.4 cv=C5sTyRP+ c=1 sm=1 tr=0 ts=67cc835b cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f9hqsFba6A7s5isENxwA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=665 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080137

On 27.02.2025 3:25 AM, Dmitry Baryshkov wrote:
> Instead of using .parent_names, use .parent_data, which binds parent
> clocks by using relative names specified in DT in addition to using global
> system clock names.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

