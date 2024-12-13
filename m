Return-Path: <linux-kernel+bounces-444646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E59F0A39
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC3A16A3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C11C3C0D;
	Fri, 13 Dec 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EG9tTFfm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E341C3BF5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087505; cv=none; b=Brx4hvrgojps9nMMDTZZisQeasd2S9B7gts0FMSgxElzUpu8kISncNVu/xJpQq0YMmHQX8uhGnirkylQKho6Hr6Prw1LoTb1KzybJL63myvvkIm8QvFifcI129v6iZB93SSN3z9JjFw5b/BB7B9kCrzhNVvMpo6/3q+zlYoRUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087505; c=relaxed/simple;
	bh=qPegP8LQZPlLlcXjJutGC9jbyKdfJn1J8L/k3V4SUjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFPSaPafDS61fg2Thb0HZ/au84Icmj3dGtkrDjh/D3EBrpHI4gddpzzhbW+/c4lZSGwBaBspyPAzcO8jLH2jWHdOpiQH+v0zaiipjhTxtOggTHBciUS+Ly2JrjyrAxdbjQvAEp1I3yFGM8ChGO+dsZ6YLM9JQOmaKPLWXgsf7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EG9tTFfm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9o26D017727
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zCJavJQ71PqZHCYPa//4JL9cKiXxNPidx5M706eMzJ4=; b=EG9tTFfm2TloFuR+
	3E01OEJ9VK1ZzJceSpF3cGNO5HdcGNeHBhrWFukSPpRM2uJfdmxyAz9oHcS3UlMB
	t45WovcXkChj2msq6YYuXdTNft7aPcHmOEqkhpjrUBLwUFzoB9AlsDAJ44jRcct2
	mdoHuRUhDLcUV2RIEn7ixNK0gKNQ5PDy+scUaVI7pxp/7S0IQem0JBLydCc4J7Yg
	DHtIRYkyAx56ZYeRkDzwLQawVflhKcHX0YoxSKTGIkHPrt4mxH597yZWOA8sa3qc
	wCyW2Rg6bsHtrdCOq5c7O9bR8A1u0TwZnwUL5AVU3kw1y3lEk+DNL+uSUENP2XXB
	8s8QBA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjmt07t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:58:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d88fe63f21so4315116d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734087501; x=1734692301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCJavJQ71PqZHCYPa//4JL9cKiXxNPidx5M706eMzJ4=;
        b=afT7BAUvoiEZZselMmLU02oNkC82WcXXHEW64uFBdXJGfML/U/cSn/pgpPH1z6tetm
         EMKCIaTIy88gviKzx+YpJgHifEg2ImK0FzPfZNq9bNciN9W5H0jiW+J9VJUFZKhk/1xm
         bp1FT4hpTic4YTT52YqFVNwaqkP5PdG9EQiIpuitCDS+Loyqp1RpD0jv5hrdRjPmPDxc
         3gG1vCdiQ90qAXXjbHFGt7uO3ljNlTrR7aOhZe4cBG254k7RSxFfszYNmjkK/s11nfIf
         mj8PKzWwNT0gfEGFxYa2UiFQbQUK667of41M8e+uXEj7uSjisDY0xao9mNaDZagmQHv6
         P1kg==
X-Forwarded-Encrypted: i=1; AJvYcCU1+fZ5+6JvCrqSy34g/4i8/1OmDt7/4EFYQHl4c1rZEnQcwePSzyJyJrzZwF3A5Ccpht8KKfhRm9n+9nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIseKnG6AVnHUnNr80AJazewfa8cRuEvQ2gbosgCjaKhqJwLI
	hRv3apTjnNXnQjNlNQGqbRWR9flFbUZs9cCsFkfJMz4/cummzZpx/cbyG6tN4fKULXUpqColiN4
	kIfRsxcyhbFrKIhYvY3VwTobyvxjYEJSDAe2QxFve+aBFzRbjKc1IYNjBmU9XGR0=
X-Gm-Gg: ASbGncuxf+tbsO06Zh1W2gdkeSP0qPpQGdGBwRqOi4j3VcICtzeKixRH5meGFtv4xkO
	khnds212u4AmI+QVblLxGuwj8BiGlPDB3fTH/qGaepmK/tzURZW/o3TawIKQXahgX8aDy4bC5ka
	5Oz81AKk1MIUqX6FG1/17OE1/gDl196U04w/uvpdIGVJsnwQ49MWNr+dBW3Kghv47YmLiBeYlnS
	VVTPO/XTSg6ec9AQfVbDmQQmauWfBX27Ts/Eu/0Q0xXEMhMOICrWJq2hzlX4a+8KQdV9uv4/QMy
	Y+F5O3VU/Y1kbKsHiLfQiVn2RZmf/oR5Gu5B
X-Received: by 2002:a05:6214:f0d:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6dc969a9b25mr11838766d6.9.1734087501510;
        Fri, 13 Dec 2024 02:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsGI6dtYfqNBiF9YOclKzsnUndifeUSlM+bUU1xm7lXts86DjAKnT5BGz3KaXNPyr6IOpU9g==
X-Received: by 2002:a05:6214:f0d:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6dc969a9b25mr11838586d6.9.1734087501091;
        Fri, 13 Dec 2024 02:58:21 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab897873d9sm23026666b.191.2024.12.13.02.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 02:58:19 -0800 (PST)
Message-ID: <0cc06b94-806d-4e63-ac57-9d9aed45a3e7@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 11:58:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: qcs615-ride: Enable Adreno 612
 GPU
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        20241104-add_initial_support_for_qcs615-v5-4-9dde8d7b80b0@quicinc.com,
        20241022-qcs615-clock-driver-v4-3-3d716ad0d987@quicinc.com,
        20240924143958.25-2-quic_rlaggysh@quicinc.com,
        20241108-qcs615-mm-clockcontroller-v3-7-7d3b2d235fdf@quicinc.com,
        20241108-qcs615-mm-dt-nodes-v1-1-b2669cac0624@quicinc.com,
        20241122074922.28153-1-quic_qqzhou@quicinc.com,
        Jie Zhang <quic_jiezh@quicinc.com>
References: <20241213-qcs615-gpu-dt-v2-0-6606c64f03b5@quicinc.com>
 <20241213-qcs615-gpu-dt-v2-4-6606c64f03b5@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213-qcs615-gpu-dt-v2-4-6606c64f03b5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ee8xymYn1ZKx-ACFPGIzJ7XhC2t1xL6c
X-Proofpoint-ORIG-GUID: Ee8xymYn1ZKx-ACFPGIzJ7XhC2t1xL6c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=709 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130075

On 13.12.2024 11:35 AM, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Enable GPU for qcs615-ride platform and provide path for zap
> shader.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

