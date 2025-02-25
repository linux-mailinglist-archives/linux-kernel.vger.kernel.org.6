Return-Path: <linux-kernel+bounces-531533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5D2A4418B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE6819C003B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979C26D5B7;
	Tue, 25 Feb 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B2eNZhub"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3028267AE5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491763; cv=none; b=en+INS1M4so6jC9xraCz1Mw1fEsIb4Xla0F41YaDOSWbbMK0qV5fcplwt8Zriv0yaTPDMG3cbNo8bTsodaSe4vjy3lzfKzdLAlpasCgKk4gb2d+sFg/LMu/rCh6PqXenveYC/0akNDV5QPrbq9d5y3wSrAJ3KHChT3u9P8QvG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491763; c=relaxed/simple;
	bh=x5xYuov2dPtx6AF6gGPO0PE7JLKs264+raAs4XbHo6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmuJ27j3sb/P5dec1wiVOqFWS6YBA/vrzQBIcc+UzISRiQbvk7Ed4G7mVWu3+UeauKMeop+wqKF+6pkTO6JMsm8+xTbTObygrqXAImJhRPalUL3k2qGBUrll8cSTA8k2hkt4bjGOafquS8I+VrrOCg4ktNIfw7PG02n/oPEK4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B2eNZhub; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8dnhB013317
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vBY5RYMViCND9aWHIb0vvyXsjgb0Fn3HBfOa7+4/rtg=; b=B2eNZhubz34/eSks
	cckq449GJPS7tEuL/u7iRFFjz99viuZvVhiJw5nduwcLqacLfu0CgkDWkNMIdyX/
	CAkiCkTazrlj2uaANecC9fYEZSY4EyxSU3wuHtIdY0Lmq9fzgDweoVgEecaQOntK
	fnQufaDLyXnw8Ga9uNN5TN1U+6lvq5GW8xBz4tXQqD9cn0kQdLcgBa+902ox41qc
	noqaKq4rZGlhKZ9fpQUoX0qvjeIwnvTHlVl7Ud0JphY/OlcOHoNGHwYFIY1XyiFO
	CpHb9c3g/9Wta/VRqy2RpQwvWhBw+B4sxhMN2QZHfz/lvnxHo2nbBVOu1i13U/qC
	6MPr5g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgs470-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:55:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c097c2e602so112182985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491759; x=1741096559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBY5RYMViCND9aWHIb0vvyXsjgb0Fn3HBfOa7+4/rtg=;
        b=OGeHycPXuzmKcqb8t6IKODbv0TLQRRgMt98qHru4UKqHcIsxdzGWl2dPnx2PdGLF5x
         nVBoH3Lv2Irwst6tjk9QVJ3mG2m2OUwkvs7dsbvMcwqbrVFX2CqnoRklgnebHsel+tBZ
         LCwhJcqnyGIhBxFlFTvJf+4Ic/98c1aXFV8wEhYXbzqxlMAtQ4pOz51yu9quFROTjRWD
         lD33mSw+UOuy+sUt3lmeLqfRiAgi/aDdYgeYT4VAIFiSk7R9MulGtCvf2yfhYPE1hUnY
         XyXJcrAzxzRdpo+5e6TaW3j8Qsa7wARS8ugaZxaoXcKZqi2j/LVex4wywqqOkjMDv/re
         nLPg==
X-Forwarded-Encrypted: i=1; AJvYcCWRG6bLQE/Qlw9FMMGLDyiOZBHRz8rM8y65OSE9/KcRlHT8srJgqe5KxhSBuBj0wKb6kYHjAbVi9vVaxEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkEWEHl8HYMtq9TZxWLMbyd1pTwK0UWDxLvAJw0aLQAzNrgPx
	pQRBeg8XXP+WzovvXvicfqCgLDtJ7PFkvggtqoKNSk+vZw8nmm/zSAw2lrsfYWjFUCc31KijBWf
	jLrtYKoO1zC3blaPuhPY2ZhuHaPIf3fjjLw/R12SNBa8muDffQoqpWR90QtnFJrM=
X-Gm-Gg: ASbGncvhUcQu3mvYFADOujqVWooeOxRGDTI9UULECiyro8A7vE9oGBLFKpJQpkkYMYT
	As5sOxHsLsA6u5ClE1xUXRKAPSrxfz8zMzZScGVpUaTZA5+siTLzTUJScu2/XURlBFDgtAeJmaa
	WKRD9hD1qSUkRtSevfvdj/cqPxmLs6F+vU1ra6TfdieM59JL+l3JSrduzHQT/Wej8b6qMLYE/b3
	h1yblZ6bVLeL5vwfdMUcnYbTBGWRxRjGHofo5sZG4f+wMKXxvJUKUrSYxelY9Ov+c2b4oPHHwln
	RvfA2TGOPf7GhathSAc9hKDJPm1wyoycFzmUAISC6pfPrvZN3KpoFIEbhClqW3YSgn3Ctg==
X-Received: by 2002:a05:620a:2444:b0:7c0:a1b0:1ef3 with SMTP id af79cd13be357-7c0ceee99a3mr916340485a.3.1740491758845;
        Tue, 25 Feb 2025 05:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/PjnVD66AJHeVDtIRjlMA2STxMYD46o5L45WU8s5YvllCmc0/7XQePe7pEpigxyn6R/Byng==
X-Received: by 2002:a05:620a:2444:b0:7c0:a1b0:1ef3 with SMTP id af79cd13be357-7c0ceee99a3mr916337085a.3.1740491758404;
        Tue, 25 Feb 2025 05:55:58 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e460ff863esm1239615a12.62.2025.02.25.05.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:55:57 -0800 (PST)
Message-ID: <b5ccdc2d-5f3b-4a61-8e14-697468dbd62a@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 14:55:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drm/msm/mdp4: register the LVDS PLL as a clock
 provider
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
References: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
 <20250220-fd-mdp4-lvds-v2-3-15afe5578a31@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250220-fd-mdp4-lvds-v2-3-15afe5578a31@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sr6-GAYrt1ndtXAHBjrWhimYhSTwy5Dw
X-Proofpoint-ORIG-GUID: sr6-GAYrt1ndtXAHBjrWhimYhSTwy5Dw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=764 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250095

On 20.02.2025 12:14 PM, Dmitry Baryshkov wrote:
> The LVDS/LCDC controller uses pixel clock coming from the multimedia
> controller (mmcc) rather than using the PLL directly. Stop using LVDS
> PLL directly and register it as a clock provider. Use lcdc_clk as a
> pixel clock for the LCDC.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

