Return-Path: <linux-kernel+bounces-571720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B84A6C131
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA6D189DCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0F122D7A0;
	Fri, 21 Mar 2025 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dkhnGGp4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302F1DE884
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577653; cv=none; b=VANAcjAOj5bQQW4ukebUQddgpqXwoTKkDRCArkVlq1yMCLjiC7zt84lWIoVYSp/I8rJzezooTnOpRIBGiKtLyWG/vvMJZeYFBDah00agnvuM6B/uF0hnNNqZaQn75O8ye8FONYvMLyCUrUHZIM3GWVo9KHVApX5WYn1UHDTMRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577653; c=relaxed/simple;
	bh=qmKoCAZRoRbHTTOKcO+4PVhKdKeMHGgyeEZ3jlFoy9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbaBMVGwyCFVRWVInn4X73hYsPpIOZXBlbBMXeYvpLEYS206uP5RyHrelQTxGd44MTxF9p7lleODwxvCklVf/hGMsQIB0ThEMhZB9AWM+J0CDnoYy+P3bZnG/5erFLGT+87fW0Xkpm1uPgZMGnu5IQvPE0eHn1w4q+HhTCYCK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dkhnGGp4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCS4c0025320
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uDTpwkPptGdzgbOoxDa8xyDZ
	cduGG5xDhf0EsIsjkOI=; b=dkhnGGp4E36ZPnBzDW9+hVc9fAjGmC5BU860RBm+
	tqmgwsd3pznlFpM5KMgCzG4LH8WN2QOiUj3Ka+fR7uUSB5O4adT7+rVbvjfIWivM
	QfxVz05f3Morlm8DScJyFJMTpuqASsj4lN38RVYxnyGDle+1RxLff7UYYdNMHioh
	FVz59BiX5bQpV0IOEog0kDxHQgL0kKhhIsIYGSB5sNBytRC3EnAeaRtAlpKCJyO9
	y3sF3tv8cnvxbSVfML3YjZ2RH5A0N8q5Wxvr9sIKDp2YgpgiTdSk/nYsfC54o8as
	z5zZgEKLSJWuu5OBi7IiR9X9agyfBVTP0fT94FPIIS7sHQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h854gsfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:20:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-47693206d3bso50420691cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577644; x=1743182444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDTpwkPptGdzgbOoxDa8xyDZcduGG5xDhf0EsIsjkOI=;
        b=S+YKkO3U6o2McVQZJ8HK9m4seyzcdUyEjFQGoF1jEe43uT732K9zZwia1OJe1EYTT7
         NfarYHJrWNufIn+jPWzWaI+DBtaXkQht8KbljWwwmKA+205aPAn6e9NPTGchHWVtRd0g
         s4UhdeyGkgWu69teaMHhwIIdMQdGxXpz6XO9+9b/29aITGIpoXvAPtD0KeDh/sEctvCQ
         2tXlHmnBlMKLeMW04O0iSj3x9DLF3UPvzQHyE55TINJjQ7QxOW/V2A8HgWzrIL1+N7Lx
         kIJ82A84wOikRofTe96G2VkZIp8yT8FRaqWXq2kEDuVJ8ABfQXwUk/G26doCVFPxUqS/
         46vg==
X-Forwarded-Encrypted: i=1; AJvYcCXhhKQrsEItuh4Q5qLTVascw/EVDyeb5DOuvUgsit+5tJ2IuQZ6RP7luR8mJYwddvdsydKMA9eZOD3h6HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6UZvdZt6L1zkAgCOU+oR56K7wz5I0Si+gr8hH51YLVBoEB7G
	r8XVH5N4pYtKQmauwsEr7Uyk3r8isca7oK++R65fvi5uY1i0JuI7JmFD42rRm//nZRz3twNqQ9e
	J66Anu1u3Vfxfx3G8nbG/l+dnVZEyFr7xc2vPkBc+DMKSyvjWyTNvRQM43bs+yZg=
X-Gm-Gg: ASbGnctey+bUfLLFpWvIZJMCqukWFRNWdfewTOGKrKeQdp8BbkLNR8brXHL1NmIAAJq
	8oppaHED+G2dYP5XBJPsN/wPNmlmZGSDsR708Jhw0bcM4Ieo9QhtZWt/Cshdhg6/Fsm6HF2Zhng
	3J0iNZGOKD5DeKT7eBsc9i8EmdsnzszNTCgDgCr5QZfYEZziIXcvKWAcNG2k/pRDnTUBfhZXawe
	a2gIooYd5TNgBgrtNdGKU5RT3DwlSinuIw0jJNr732Zt9B9zei6HD/l5QlKubGbf3XHBYlUdd2m
	0Cj3PUPv/8ljEwKQmTgWcuSIlseyBkn762bV6B+bLwx8q29bHB+WCPPEU7B4Ydrq5qE6JS+iq/b
	TvXc=
X-Received: by 2002:a05:622a:4d8d:b0:476:a7f2:272d with SMTP id d75a77b69052e-4771de8b4b5mr72699181cf.44.1742577644394;
        Fri, 21 Mar 2025 10:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx0VZLa5EFNdEAjuIa1FS+mTNMST/xHfZhUEXNJJ7m5u9qI7CPpdWYXoz0qNcBgm/3w2c4Hg==
X-Received: by 2002:a05:622a:4d8d:b0:476:a7f2:272d with SMTP id d75a77b69052e-4771de8b4b5mr72698801cf.44.1742577644139;
        Fri, 21 Mar 2025 10:20:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647c98dsm225951e87.67.2025.03.21.10.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:20:42 -0700 (PDT)
Date: Fri, 21 Mar 2025 19:20:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: add APR and some audio-related
 services
Message-ID: <aglvc2n5acln7lnnsnoyzyxega3bttz7qrzmmjn2atr77xsvph@dpzcohdphgdk>
References: <20250321-sm6350-apr-v1-1-7805ce7b4dcf@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-sm6350-apr-v1-1-7805ce7b4dcf@fairphone.com>
X-Proofpoint-ORIG-GUID: Jx_adGrwH7aAOszQxKkwLbAS3NFbaJii
X-Authority-Analysis: v=2.4 cv=ZtHtK87G c=1 sm=1 tr=0 ts=67dd9ff3 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=d6hRspmLNtqVbEz1Xe4A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: Jx_adGrwH7aAOszQxKkwLbAS3NFbaJii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=836 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210127

On Fri, Mar 21, 2025 at 09:12:57AM +0100, Luca Weiss wrote:
> Add the APR node and its associated services required for audio on
> the SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 59 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

