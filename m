Return-Path: <linux-kernel+bounces-563190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7E1A63805
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CE516D8F6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60731A3146;
	Sun, 16 Mar 2025 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfZ68ByC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA9199E94
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742167484; cv=none; b=d/mPQtS/b0wsM6NU1l0DWikcAzD1Y/qs4DPLKcjkV47temSA1OOn/HAcGT/HX+KiJFQpUJuxLuT6EHzJpZS2DbBsHxV3reNyPha7acojFUP93vdMUycHLEHoGtiUSp4PtcurAr6l5ZFMX2yDPfVC5fdefSEuKWRms3aO7AbKcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742167484; c=relaxed/simple;
	bh=csBmAWx4188LdtqFCso38hP0iT5E9pWN1eYO45SYy2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLJrNi8kdcv7bkh1PT25Omrfu7vgyn5eMpbmPotPN0OTlSQUmkrH2dokZHP2qG8eLJDeT7Bb29xEmBx63yEk/3mEEHP0xfQldx2GuJ8sZ/gzqkGGW27428H+McQFu2Uk9jZB4Qs5GwjGK9ra4LXSFRCvMfgR9fH2AjYz3n7uup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BfZ68ByC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GMftBB001892
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IVYXHxBH6seE+vmi8RgMEu0w
	KLEvS3tZo1XfgA8OXEw=; b=BfZ68ByCOmnnxz10F5osrpHSbDwiSji/extGaB9A
	8deqDFF1lB+h25FkuLwl50I/oP8MsdI+kJdtRKebamF1XjN15NJE9FgdRmlp74Un
	u8yX7JIjX2E11K+d5OdT2n/Oo5+NbDgepNaFowVyu5dlixsoNKSXZ4eWVrUtRvzg
	1qGROtNOOOn1F2RNVl77fxY9CNDAzoyXYgllUj5Y4DPgPx3LPRAS7tZNk9802yqZ
	veIUSdlKfKo3Tde96tBjVrYaWjfZpOEaeWnBN3zAYu+aKxQZJoO6cAsonU5Sf5qn
	Kyqxed5Z1BHW/XTfvcT9PA+DHbYGZpBjFv2/JOT8PZCrbg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sxtu3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:24:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ead629f6c6so83494286d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 16:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742167479; x=1742772279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVYXHxBH6seE+vmi8RgMEu0wKLEvS3tZo1XfgA8OXEw=;
        b=pVbhz4ua717oN3pw8ARRCOe1WFkakjVk9s0A0ZW0JJ6nEExuf84gfeHDG7Zwe8JD60
         Ca9OCKF2B8VkBezdK/DUqEM5ciyM4zD3teaEbalJsmlMHdPf/HXY+eeTBzPtMIAt5byR
         on8qqtEvh1IH6dzReCStVSvEOnmJzuh4zQf48MjTQrIwZ4E9Y2iwIjo1phvd6S5bgHnf
         yxrGelB2D2rbwUAehY1YWSBGDWajtKjAC/58EXzIHQWMILMqbX2LmZ9s3Ec+opQ+zPTS
         1y+SmIKkUzNLu0OgoYH+azFIn9mdUuH4HM3Yyphgvvb5SJ4RLvsA0GX8bn60NGTLb0F1
         pw7g==
X-Forwarded-Encrypted: i=1; AJvYcCUc93uIsZD8ZoiTI/rKBiltQRcPnN1FtJ6+jLO9zVlFaILL7IRdtTyNIrde4zggXo3JslQ8Zre3o1hEFgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfiJiUDb2prt+QnoLDrPplexxqAxenjCtDNKDPtFwH0Nlr+9wa
	ZP6UYyDHJ0X3FZGSPVI4ikm5ApKplmFR47UcwLweJkBB5usYWz75I4m+SohOx5/fTdQ00gYqfNO
	VpiA80+5dNoS++dvSrr3bVHQ9oY1vLS2bNpx3k5DKbtiOGUNGwTMu0Qa8spaF1Hs=
X-Gm-Gg: ASbGnctgLM/OWEIxa/CEPPLj88PTcF7X4YrhSNkwKoctWVVMx538N4dtYaVPdlwa53+
	3EqZ65SxeQHIrArM+2dcL96CM3n0TAaOZgY7kaRvqy4M3lZteD5Rnp8Olp8wenU1+O/mDlaEFi+
	D+xf/3Cq1FwiqSIVvkrIXaO2NazL0p8rEPPmHwMbfX+azQpkxsFWO4FJ1xkOBZ+M6YfkeyFz/qJ
	AWPHtq9OsERmUOCtDKXOrJ8UnjhoUX1HkoDx2YyWN1hVvn0F80DA3HPLt3kKw1XXW7z2yyinEJT
	RBw7mH50nZr7zlf5B3W8eYYgToRenh1WmWwLkdihJXplfvDSh34td0OVTa8+IghJlAMR83ITbnj
	gqAw=
X-Received: by 2002:a05:6214:20e2:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6eaeaaaa4f6mr174117116d6.32.1742167479498;
        Sun, 16 Mar 2025 16:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDshq/n3e4H7Bf9jNDINDm6F1zU4lmWXf3G5XlWq5YljQ4EqxJd4/CbFMcXmB7cUAootLCaQ==
X-Received: by 2002:a05:6214:20e2:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6eaeaaaa4f6mr174116746d6.32.1742167479107;
        Sun, 16 Mar 2025 16:24:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8516sm1209750e87.31.2025.03.16.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 16:24:37 -0700 (PDT)
Date: Mon, 17 Mar 2025 01:24:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Ivan Belokobylskiy <belokobylskij@gmail.com>
Subject: Re: [PATCH v5] ARM: dts: nexus4: Initial dts
Message-ID: <qcgdpylp4xxyb4zhazbur3mq6sayvftdl7b3ekpkrjdqmjuvdt@rrmu5nolqgan>
References: <20250316-lg-nexus4-mako-v5-1-79feae815a85@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316-lg-nexus4-mako-v5-1-79feae815a85@ixit.cz>
X-Proofpoint-GUID: N7T7-HQ2d_fvv7SmHFF8f2TcZZKSR28K
X-Proofpoint-ORIG-GUID: N7T7-HQ2d_fvv7SmHFF8f2TcZZKSR28K
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d75db8 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ZTbHHU_yaQzv_LtAvXsA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503160173

On Sun, Mar 16, 2025 at 11:16:55PM +0100, David Heidelberg via B4 Relay wrote:
> From: Ivan Belokobylskiy <belokobylskij@gmail.com>
> 
> Add initial support for LG Nexus 4 (mako).
> 
> Features currently working: regulators, eMMC, and volume keys.
> 
> Signed-off-by: Ivan Belokobylskiy <belokobylskij@gmail.com>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Changes in v5:
> - Sorted nodes alphabetically.
> - Link to v4: https://lore.kernel.org/r/20250311-lg-nexus4-mako-v4-1-3916c8ec7edb@ixit.cz
> 
> Changes in v4:
> - Sorted regulators and added regulators compatible.
> - Corrected pmic include and references.
> - Moved &rpm outside of / node.
> - Moved and simplify pm8921 keypad.
> - Added chasis-type.
> - Dropped incomplete WiFi node, will be provided in future
>   contributions.
> - Link to v3: https://lore.kernel.org/r/20250309-lg-nexus4-mako-v3-1-1dc2807df296@ixit.cz
> 
> Changes in v3:
> - rebased against next-20250307
> - dropped backlight until driver gets converted to DT
> 
> Changes in v2:
> - lge vendor doesn't exist anymore, rename to lg
> - sdcc@ to mmc@ to comply with dt-schema
> ---
>  arch/arm/boot/dts/qcom/Makefile                    |   1 +
>  .../boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts  | 341 +++++++++++++++++++++
>  2 files changed, 342 insertions(+)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

