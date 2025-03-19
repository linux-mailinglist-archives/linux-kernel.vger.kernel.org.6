Return-Path: <linux-kernel+bounces-568498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA95A6965E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C719C0316
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0661537A7;
	Wed, 19 Mar 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i4IKUdhV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763C1DE3BF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405162; cv=none; b=Lip6MvSG4yyWO02WTQvMA9EK06wrXLdpXlN/EDaPO1g5kupquDl7i2DR+6enc/CxWqCehD1RUWlcJ2OJpoQd3Or58RKNt82V669K7ONpJD1WWhQmj5lm4bWfaHJQcxkI8fuSA4Cj/MJb3QrRnISGtnXMdvs680xCzmMZQsNNDBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405162; c=relaxed/simple;
	bh=xWlwplV+ekInbFsUxRgTauEuEgk6dMw8nIVG3sysQ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqdTO6FK2pChs5frv6zS4AYIgYb7fHMxvTNr+b0Vbhn+hSRJDcY1KsWTFJmoquersUEkj7bS9wf7fibOa+aNKj2dyVHBU5OSjT/vIX1ctnrxYflKusaoRvWiR9pzA3VKTLh9PPsT3fDOIoo11bycf7MbUrT+aoFt4SdUgGOMwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i4IKUdhV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JDYJ94020468
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wxTkGbnrj2G1AAERlXkdXjST
	vimabqMigiyhzGpcsNs=; b=i4IKUdhVb25iQqlHQyI4tVrN6igUBit9UBocggcP
	1a7AnHYWIcOPTbuHdMANqFkBy1Por4VMEVmLcrde8N34D3RJobN90CmEN8+gW5qP
	xBpyCCpDTlVWC8GLejse8Ih33ueswRS7ey2dFimN+w9Un2lF/YpDikChWoaC6iFP
	exD7cZEBY0RsiabXOldUuB9sw1sF9xxPFvyny0VSDnej4HtkHjSElpkrD3LSTyhs
	AGARsGvBYXtbVvqkBbrCyVTB67rTjSOMCBNzTo8qNVk+Kj2pV5ZmaHPLFQ56DPwZ
	hhLrEHVjyE4XSbr1GSMqWEEJaYUzaw7nOGn3vo2BnqDBMA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmwuge4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:25:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e91d8a7183so130309566d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405158; x=1743009958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxTkGbnrj2G1AAERlXkdXjSTvimabqMigiyhzGpcsNs=;
        b=d1pxt1/YqXlQwI9ioq2YcsQgh/Zafxjc+BZGVFcxnR4qUl+Ua8TFVTG7rqN4BgIAG3
         iCT/xDope276p10n/oRiWfHUqYAjQDhlidQasI98hahb7Ulgd8ygh959NmCedfzRt6U0
         QXzBfCW9lfkI7SUEQGJlAq6+IHPIvIDJJVNBPXxG+Pd2ubtGTywuW96iIHviAvietiwm
         J7m+VL5E75J/0CM633N+oEojeZDllH3X1Ofca/pJqmjK10LGA5+/qs8oEtYNFYLh0TmR
         Z1aPBCP6yUZxCvO+PCFYQbkfSr8tA/jWKzZ7Bau9rcquqPNxx3xyTKZP36mdUmNIheb7
         BrnA==
X-Forwarded-Encrypted: i=1; AJvYcCXLOttPzH+J0IZbRit9+IaTZvlJosi3908E89gu9+nfKYejpvcRbvxgKPH0BYrLg/dPa7l7KXUSPvZ0h+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWyNipGk3tg+o00PRzTOjgg5sP2C7Zd95WtjaZyvq3ws9pj7f1
	RgFElDbvTMtaaByDxkA9TuC8oaaO8Ss32BRV+xwZPsbxzjMnmQO8aL9C0HwRDp1mJvRV/aQLkKn
	AXd7T9SxaHOHSqEm7XO7YR08KL+qW7RkJUOSeHXO6yvz8hDfdiBR5LUvuVLqn5O0=
X-Gm-Gg: ASbGnctiaf8nQJXINi4vnD0YRVB+h+QSH8ettkSPizFmEu3Tk1JOg3jWXCS6sKFo24r
	0/smS9KGJ9rySkgC86eQy+RPgKksLTCP5flpGsVyjhISdjkapTD2TDGdJbmNp0wGZffo5Pisw0h
	qD8AWbnXw9NwISaVMYaDoTfro6v+jyuVcATKQA+ILD3s+/V7kwWl6OiozlwiwvKx2TIHWyIWFib
	q6sa0hi3CFXZL+mh9HjS+Px4n1PUpsy2eGi5irJSj+RbYQ7dAXfm12JUcVkgHYCp4tMtVOjXh1y
	iGHOkTbn5xswTxOS9I12Um6TBubSTWecUNs1rOL1JCl+mHpNdhW3+ACNjIQym6iHW5F/OJjptCq
	1emk=
X-Received: by 2002:a05:6214:528b:b0:6e8:e8dd:3088 with SMTP id 6a1803df08f44-6eb29446070mr53033436d6.37.1742405158308;
        Wed, 19 Mar 2025 10:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcStmY6qruGD6vBp50x0OySWHCpSi6v3rL7uOiQJh632CHkOyH81K+9C72wFo4Ponx60tgYg==
X-Received: by 2002:a05:6214:528b:b0:6e8:e8dd:3088 with SMTP id 6a1803df08f44-6eb29446070mr53033006d6.37.1742405157828;
        Wed, 19 Mar 2025 10:25:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba888039sm2002361e87.203.2025.03.19.10.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:25:57 -0700 (PDT)
Date: Wed, 19 Mar 2025 19:25:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        Dmitry Baryshkov <lumag@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sc7180: Add specific APPS RSC
 compatible
Message-ID: <rg377etwxv3yupth3acak4ycthahi7sennm54sbah55yqj2qdk@vip4xxkbsp7n>
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-2-cb36882ea9cc@oss.qualcomm.com>
 <l4vd2xmrowmmtefieb4cbirq6ntkvnwbhtpxcyzwdeok2vgtt7@zqgqndumgecv>
 <881655b5-30c0-42f3-863f-5b6606a3e2cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <881655b5-30c0-42f3-863f-5b6606a3e2cd@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: L0vrRbMy8eawoVgPuc7nRuo0x_ug8tA9
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dafe27 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=p9JctohuHJosm6c4YDkA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: L0vrRbMy8eawoVgPuc7nRuo0x_ug8tA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=939 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190117

On Wed, Mar 19, 2025 at 03:14:42PM +0100, Konrad Dybcio wrote:
> On 3/18/25 10:30 PM, Dmitry Baryshkov wrote:
> > On Tue, Mar 18, 2025 at 07:35:15PM +0100, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> SC7180 comes in a couple firmware flavors, some of which don't support
> >> PSCI in OSI mode. That prevents the power domain exepcted by the RSC
> >> node from providing useful information on system power collapse.
> > 
> > Is this behaviour specific to SC7180 or only to ChromeBooks? For example
> > TCL Book 14 Go or ECS Liva QC710, would they also use this compat?
> 
> The hardware and firmware representation of the RSC is identical, but
> I wanted to alter the bindings required properties based on the specific
> possibly-chrome platforms.

Should we instead have a separate compatible (?) for ChromeOS platforms
only?

-- 
With best wishes
Dmitry

