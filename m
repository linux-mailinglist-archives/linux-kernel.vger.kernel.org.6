Return-Path: <linux-kernel+bounces-567687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC7A68902
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DAB1899663
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65759212FBC;
	Wed, 19 Mar 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BqBTkA69"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7331F8BC5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378594; cv=none; b=KB2WkgSgcw41SnHPdPk+wqgKjMvBHT55z6AjWEEeyGsTUQ1ld9ZBjqtJIs8/DL9jtJl8tfnIKxaC35sVEzSsEikXgBkpIaUEtgDfgfxiVP1j0vUSrV1NUTgfZmpdd/mJEvhnRwhCi4bHU3P4bZEAp0r4yKTFVvfZQyauJB7hN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378594; c=relaxed/simple;
	bh=jtxsEGScLiDZqdRASBnRspe0wt/Vw0O4Lr2pCux0cvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8imDXB3oumyXKtDtFcqb3U2andLWqSqDVNLCEBAPSFamL4WvrRSWHGVSpDyssno8Ph3JWx8caHE9qIBV3Om2lx8FeZDiFK4onoc9DgqzI6WHms7GiSIkhPbVxn/A4h2jw0zKuAU4dhCNgej4bfnc8KiYvEbs2c6UHPyL3lnd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BqBTkA69; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lip4020761
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pzEcf4HDAvKkc0s10NYP45UQ
	VQBRG8PAuzto9PKZ5Dg=; b=BqBTkA69eEZI/G1qqN2BtMg+oAQEUMZ0gsd/tALJ
	j+sBfzlVQjnqzDD72OhH6AfLkoYa6M0wsevjAAqbYv+a4LrkYOIbzC16Tyg7r3b4
	cjzX2/vXGmLuHryxCmTqPg2Lzok26AyZjYtbFORNtGfbYnjTfHzynE7tLBLFywnS
	Td96SeiljGTK9JS90W2LPMLFVR07KEGNYEhP46akC6sgrWyqTPNjy1tONJqrx3HB
	1ayeqx1cLQNQlfu3PGowXP/8sKBl2vmBZmqWoaNiK2ndvteNKU8y7QaqqLHJLG9A
	+aYbFwUo/fpiicTTsLQFD2EQhposPggt2giZfaw0Nt8WWQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exx34wmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:03:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0b9242877so1551269485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742378591; x=1742983391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzEcf4HDAvKkc0s10NYP45UQVQBRG8PAuzto9PKZ5Dg=;
        b=tqyW8OC3j1DiZiy9EkaySQxSG8KZwSV2MD/ivPUsLsXIU30wR852UuNOYEtlH0wq9S
         Ob6Veyz+S1t2ZNsl8PFI6XtZgucpGmGtrsX1HJXFM4Z1p7dLztGhnYF55/h2DmnNKqLI
         B4/lwD2deus0R8FaIi2TJOJf4zvHgfpBXusbO0Lh9pfPRxn4g4jfkEAMk7zc6ddnkxBi
         JYFaZhc4Y8nUmLQWGhzZoHg8jGFFYus6sfkQFBvD5zqc4jzuu/js/aoiP4v8J8spUgiv
         MwUxXphSDckOKEScflAVDvICFo1RhpVygfTWqmwvv96CwI7CSoZv1qVc+lFpI1XrFz6N
         zhCA==
X-Forwarded-Encrypted: i=1; AJvYcCV8q8wyn5T2s6JPt/YAaFaGcbEidK1HZbysBuvpPKkafn6WHWsE8RQYwoQ2pzVRV9kJt4H8nnC2E1o5NG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgqhScjbVIgfJ4yfXTKEwJ2FKCdqMR9Xi0lz9Ox8b7VCCMFST
	0xPk3chII9EiylpaDtCmujDZhv5POux7tmyAe8C2c/dQM39fw64CyJkhDlin/3kzYEdz/sag3Ra
	+jCgr8/+1Ak1216HgIbEUw+BdLBgAiam7v8d6elF+XxYGBODjkpJUxy3vtHd5TSc=
X-Gm-Gg: ASbGncsLNZ0Fnyu7RpKQobs3/vStyIZk4Lg6DWh/bKp7AL9XBxN0OJBOxekMQOT5DQX
	5x9ltt9uNzJ1vzn0/P1lG5gUX9tgY7CnF6dJB1KZQf0JmUlwnLhW8gLJodT+4wnbe1Qb5coJcQe
	SXS/Rz4KsuPY9WwPj5wn16+N3JPDCEE+8/YDCVuBr2Cp2hTt6YSPoTsOcPW/MdXggeQfv2v9msy
	vHEkpQrnQu9pzI1kXFoOf+ps5uCkICKWhFLF7CPxD4nFwvbGt35rrBbLux22dYC2JNiIs4oQl7J
	1D7pT7YWkPElQqe8H3dEnClFg5jcxhiguJYuwVtge1+5fIXpvlgFA7OWNS2QuuyQE5QFEgHWKNO
	eVNM=
X-Received: by 2002:a05:620a:191e:b0:7c5:9a2a:aac1 with SMTP id af79cd13be357-7c5a8469da7mr296598985a.46.1742378591342;
        Wed, 19 Mar 2025 03:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH36w5UmUaf1mc4I6TLyh2PvcyPbnoFFFtkRaEIewokWpjJyi3q3jXD3wRgymlu31aI1qnIQQ==
X-Received: by 2002:a05:620a:191e:b0:7c5:9a2a:aac1 with SMTP id af79cd13be357-7c5a8469da7mr296591985a.46.1742378590754;
        Wed, 19 Mar 2025 03:03:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ac4c02f5fsm431400e87.61.2025.03.19.03.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:03:08 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:03:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom-msm8960: add missing clocks to the timer
 node
Message-ID: <k5oehu3yt6fn6pabvjze44inzeojavznsv6xzipvb47p473un7@zrslz4kv3oph>
References: <20250318-expressatt-solve-dts-errors-v1-1-14012a4bc315@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-expressatt-solve-dts-errors-v1-1-14012a4bc315@gmail.com>
X-Authority-Analysis: v=2.4 cv=b+uy4sGx c=1 sm=1 tr=0 ts=67da9660 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=HvA0BsX6I2lc9pbQE7YA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: w8W19eNMHGrI3lwXN9sb_ekUJUD79WNP
X-Proofpoint-GUID: w8W19eNMHGrI3lwXN9sb_ekUJUD79WNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=745 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190070

On Tue, Mar 18, 2025 at 10:10:47PM -0700, Rudraksha Gupta wrote:
> In order to fix DT schema warning and describe hardware properly, add
> missing sleep clock to the timer node.
> 
> Solved by Dmitry Baryshkov on the APQ8064 SoC
> Link: https://lore.kernel.org/all/20250318-fix-nexus-4-v2-6-bcedd1406790@oss.qualcomm.com/
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
> Running the following no longer returns any errors:
> make ARCH=arm CHECK_DTBS=y qcom/qcom-msm8960-cdp.dtb
> make ARCH=arm CHECK_DTBS=y qcom/qcom-msm8960-samsung-expressatt.dtb
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

