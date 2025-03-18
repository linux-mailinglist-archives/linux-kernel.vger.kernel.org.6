Return-Path: <linux-kernel+bounces-566217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFAFA6750E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2B88842AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA520E009;
	Tue, 18 Mar 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fpQRH3J0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED235972
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304172; cv=none; b=jaVtZ8yP4qKNHpWKQtHFWSfHtORGMfCXSINNat0puqi1ViZ6dOx0CukPykGrL/OvT9lFVFO7+75mUhjBnvyzb5geKyyaDWrc7putOpz7invqvpiKLGxG1dO2SocHRrLp4J+D+buFZSts+takatpeixbq3X+Ozsam7h16eGaMsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304172; c=relaxed/simple;
	bh=T3wzl5BuTKPC/Qy9/OCpWwcFWc5KQVgF1XBbM/fcyYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1ahtZ2U+gBsvPdub7uYESUWGSURWiW8GItIxImfNKI4wxj0mQQnphbguO/K2YWEIdso0q6D9HfmgFX8tDkjAu6CRV2CAPUM0sIHhqw/PKRbUB0gszom4coYoAKRGXXPgqkmSowAjp5uyPANaF6PKyiv5w6gskdfn6QraqxtuEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fpQRH3J0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I92JCP002426
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uGDujaB4DLyabP57ZFAqglGX
	KkKUWQiyDtvod87xHNc=; b=fpQRH3J0JoYCzHouc7VQOZtfva+i9kXlHc6KQ6Ri
	zm9LRm0BfHgdGEIs1EyPgsnB94UHSgVo6Zu9fPCL0C18QOuZ7gOU3kPsXMCmQATU
	aTH6qUrZJur6wScr/l/oBM5OYmteJkVbf1QGitdKL0BQBOyl50cMw4Sfvp+m5jCx
	vzIDHi5sRm5CE/pY5pfgY0QNS9f5ADK7ZsAfzTx4+XQfIod1k5+8NG+bhvLyvWHO
	AyPaJ2jtU+evQT69/vAIQv2qXDvsXgtrIT/zTb6BKGPtjWsnhubM6Y6U9Xi2YCN1
	TIlOT+inw3bx2sjnr2KyB3pquTqS8tP/EZOxjNg81e07Dg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1uu0aqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-47686947566so107663741cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304158; x=1742908958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGDujaB4DLyabP57ZFAqglGXKkKUWQiyDtvod87xHNc=;
        b=ktznQqahSaNAtjkSJ/nB0dVivWgXgqyWzwPKgTCm25tH5DRs4vUBqfM964n9uQhJd9
         74LW+vD8D4QZvpoYGKU6rBsza9SjcKM5Rt3AobvrVQPG06DMsCQ1x8quEKngwUCslUR4
         kwkNXEXvOJgwl9ngCOFbxEqnxmaGKzbBVjFz+jF07ckM6jCVhzkvl2ygTzTpn4hch2W+
         UDEVViRqKegTPQyEspmiDduJvLBqnMYSlDMkoeqRSnz9TiT3YC6j18nRVsvOIvvTJ48f
         7YDdhV9y9wy5HAnOl3QYd33P1eTEfmbyyrFFYPUi1iufhz04tsvNPPCg/hMVxnnwerQa
         RDyw==
X-Forwarded-Encrypted: i=1; AJvYcCXXupaqltJ4JH5tZdUMIocgTQP5ya49jbj3xNgd0U+a95Rbosu7mDS4yu2kMf93N0Rx8tDOi6mfd3EiFkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbVkmnPEdZmwosF3fiV6RyVGXXB60N0pDSGXOgWeb7EOehddZX
	KYhIz/rOuvCNcOfy5mgpxFG45ipPEXTHeofMt1VTA5GeJ6/QgNIT87jXW1X0tovnD8xACr0mOWa
	L8ISUPIC20oxPwmjsJGYUqNIoAIVSA1cfJqKiDb7T0r2wroRAd7F0xQB+Gsr3nMw=
X-Gm-Gg: ASbGncuApE0GaByE+Z40lEk2Ht38vM137rAHBzXGfKY5+begZAIQU9x9QE6hVQaCDsf
	e+zPBtoGocCdPg+yifEKvVXofT4a6x6QK63wnbLjfaTkjBenq9GZDBRGQsnMLSPM5RqMEeax1f6
	uuTbkZ7xlX+XUxZXSdzZ/Vcdcwapaku1ZD0zMep8mO+CpwWcPKFMlpsgx35NnU57Kgy+uJz13qj
	p1tsT4X8dNpZVVdkWrg9YSX6gLiNuRco0Oupgji+FRZ+tJFMFebQPiOG9fSE1zZTsDbtz1pxTpz
	ApLg5FJDOd5UuNKwAlc+UnWLQMXw42dQF8CWK4aoEpHSDBzsu/IfzNIIEBgnjHXmRgfnuhJb8pK
	6L48=
X-Received: by 2002:a05:622a:4008:b0:476:8c68:dcbc with SMTP id d75a77b69052e-476fc96e517mr48613981cf.9.1742304158599;
        Tue, 18 Mar 2025 06:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaNdlc1pTWXWxO9BlgHhquQTXoTV7LfD1gCYHiNW/dPhyGJtf6v2GHBvytRzHabEmyDgw98w==
X-Received: by 2002:a05:622a:4008:b0:476:8c68:dcbc with SMTP id d75a77b69052e-476fc96e517mr48613641cf.9.1742304158143;
        Tue, 18 Mar 2025 06:22:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8944sm1695766e87.14.2025.03.18.06.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:22:37 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:22:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: apq8064-lg-nexus4-mako: Enable WiFi
Message-ID: <g7scnbxbem3xviz5ufuhqakgzgz3y5hpfuo3rbvipcj54aqjaf@7rjwbweokcvy>
References: <20250318-lg-nexus4-mako-enable-wifi-v1-1-e3b4a09d9f68@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-lg-nexus4-mako-enable-wifi-v1-1-e3b4a09d9f68@ixit.cz>
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=67d973a6 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=wz7sF6bqFnhUK9Hc8PEA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 9NnpcoluF-d9vvS7cCqVo5FJICVhmBxc
X-Proofpoint-ORIG-GUID: 9NnpcoluF-d9vvS7cCqVo5FJICVhmBxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=644
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180100

On Tue, Mar 18, 2025 at 01:51:21PM +0100, David Heidelberg wrote:
> The Wi-Fi setup is identical to that of the Sony Xperia Z (Yuga).
> 
> Verified against the legacy kernel configuration inside
>  arch/arm/mach-msm/board-8064-regulator.c
> using LineageOS 14.1 kernel sources.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

