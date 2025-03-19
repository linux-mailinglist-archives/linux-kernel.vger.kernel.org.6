Return-Path: <linux-kernel+bounces-568614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B829FA6986A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFE219C0DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85F20D51D;
	Wed, 19 Mar 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jM9pGQM+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7F20966B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410322; cv=none; b=lWWOo9HKa/9t7vx5ksJPT9ILI1oRxhEK+L6kcitN/OKHHnQKXkDE6dJBm6Ax/KvSnhXfQjVJSbyQ3rKlWzxKo4t1Rfsw9CfLb/xCiFtep+p48dr9w+wCrjaQN2HcU0RG5zxCkGKjzvDKvoW3sd+d23irNfNdrVyOCsmvGqxqM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410322; c=relaxed/simple;
	bh=6JlIQoLrBT9HmWF8H478SSbnN+wN+NqOvfI/28IM6X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQtdccTJc61xVF3Olgo70hBh5RnjE7RIQ3QTtvkAiKBiej3zz/JcGhWJ8YpYowOoAgtuNsxemnOdh9qGAo30ON8PX4hJ2UAh+C4fELrxZ4xjMALj/cuvnE1A/4pVlCkI/VEWmJLc3qgTXutDrKTFT3pJ9EP4GOUoiCD/wn77Nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jM9pGQM+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JEEX1x009917
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bd0VD+Z89GZOIwSmPL1RSkLw
	y1bJZ8RWCQ9HXEytMqQ=; b=jM9pGQM+3yznijF4zpAh82FEcQyjuuvF2soIdMjW
	PKlSz3mTruyC8mTD9LMhwPwbQnqpTtXHi38gfmwPeEo3NIqefzJ259fjl2Lr3orS
	rO04C83/wO1UMoqzlb8mV4LNNS8ka1MWYtoiPJ4B/Dnnvc26g0SRgLPEreXwL8er
	q94uguVAv0X2JQEOuSPRvtjXCr02mIfgQY8dOOy4PHq8NxZe4iu2Xqgn0P/L/I8k
	xycZ25qGrs6mx/QF0mjQtNZA7NiHfnXKp8AabCHqU0oW3y1qgle6/MSre2qULnED
	Xjn9qrIb+W2rov2xKRXMRKeF7cQpxcBx/NsY/gQZ/RnQ4g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdvxkken-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:51:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c593ce5e2eso2696385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742410319; x=1743015119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd0VD+Z89GZOIwSmPL1RSkLwy1bJZ8RWCQ9HXEytMqQ=;
        b=jNILaTj1vTUCexdo2BJhrdYC2DCEy80ILI+SKDhbAEEXAa56QQhG4NitbQnxMbxhNG
         pFL3jjx4KxVUqOGmSuRhSNs5+y2qhAOgukwYhy/iwWJDunSEHEvu+/ERWqQQ+ADfGXSK
         /TC45nHcS8LbDAli9j+AznyhUXu1zvVwozQggILFIBrl9+rB1J9Psc3BLnoino5Xclz9
         fbHA9V3VhgC+q1sJ1Fu6PGFZfyyLIurb1W/x5KnRhQiaaEM+dZ16NXImN+zWCg2Rm3am
         zFWe2zOGPMkSuo8molRKbzEAHeFCmXoq3FxJ2jf2x4scr0d0d4TQrg5P+xLWcBA8U3Gt
         zB/g==
X-Forwarded-Encrypted: i=1; AJvYcCXb4NpMBXdoYdrLfmzDJgHW1o8E/ZP3O6WGyf6KLc0NeTkjKZfuXLWEmZbi+MOC66C5E7rykMKZRXFqee8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFjOg9EkW9QOLctliyd1vaX6dJ1ZVgn18Tr9Huir2zRDj+2Qy
	99tNtNwZ2lCb0p9jUzC9IG502zHOZGrf4ks83uiOmPIHXOLB8y0feuaPlWhJ/OukKrgtmtJOBYZ
	hquce9YiUiG4080Vf9Cg7B26OlhvCaM7LYsruQzTx85VMaFx0WB2ytPG8aA/yfmM=
X-Gm-Gg: ASbGncu/S/+C7oDQMQLGh4uXGme+9kRombH9XBzzdPGAc8UEdA+Sw/J1vx80mF4CDdz
	V9BvQxJlIgR/I1e4CmCicFQcxZAMemrRVmAYNtFGRcoLjzsomGqpmeAl4CmFnJ2H+JHY8r3SrdM
	BX6aAMJKCFBSYAzKfr8b2k3lcarNJg/piiWBRd4U3HnlM9vNavqDppUJ2ygaPTLK7087L4FZn6H
	deUKfiqkgh5zif2DEMxNk3LbwfrKa0psWikhmhZYXjTK++zZdw6zzKTRsuGSv4OFNvVFT/QXvxA
	MAMdSztPK5cYwMwYr3AY2obwH607CI2zoEsb6Cq4qSc7vln8RFbx6pkexC3RWpwO3zlPyB+flbW
	2Ifw=
X-Received: by 2002:a05:620a:3189:b0:7c5:5154:cb2 with SMTP id af79cd13be357-7c5a839688cmr596417885a.15.1742410318836;
        Wed, 19 Mar 2025 11:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKs+5JAWKqiFJhrdh1o5LxJ5U2ih1r1dDHkZQus5c4iAFFxZDbpKkjMYSe0+Q8tZqSYXJikQ==
X-Received: by 2002:a05:620a:3189:b0:7c5:5154:cb2 with SMTP id af79cd13be357-7c5a839688cmr596412785a.15.1742410318231;
        Wed, 19 Mar 2025 11:51:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a9b56sm2021534e87.257.2025.03.19.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:51:56 -0700 (PDT)
Date: Wed, 19 Mar 2025 20:51:54 +0200
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
Message-ID: <m4oobdgqvilcwqrtkdlmcttw2peqgtxregrfve2stwwsp3gbr4@3obh3xzy3muk>
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-2-cb36882ea9cc@oss.qualcomm.com>
 <l4vd2xmrowmmtefieb4cbirq6ntkvnwbhtpxcyzwdeok2vgtt7@zqgqndumgecv>
 <881655b5-30c0-42f3-863f-5b6606a3e2cd@oss.qualcomm.com>
 <rg377etwxv3yupth3acak4ycthahi7sennm54sbah55yqj2qdk@vip4xxkbsp7n>
 <05e082b5-6ae3-4d25-af81-f2c3b664ad7b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e082b5-6ae3-4d25-af81-f2c3b664ad7b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SKhCVPvH c=1 sm=1 tr=0 ts=67db124f cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VW9jq8_29rA7j09ZBFYA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: HGrI0nHYEw25I9HklR9r7TyPG6UTAN_4
X-Proofpoint-GUID: HGrI0nHYEw25I9HklR9r7TyPG6UTAN_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=998 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190126

On Wed, Mar 19, 2025 at 06:28:46PM +0100, Konrad Dybcio wrote:
> On 3/19/25 6:25 PM, Dmitry Baryshkov wrote:
> > On Wed, Mar 19, 2025 at 03:14:42PM +0100, Konrad Dybcio wrote:
> >> On 3/18/25 10:30 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Mar 18, 2025 at 07:35:15PM +0100, Konrad Dybcio wrote:
> >>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>
> >>>> SC7180 comes in a couple firmware flavors, some of which don't support
> >>>> PSCI in OSI mode. That prevents the power domain exepcted by the RSC
> >>>> node from providing useful information on system power collapse.
> >>>
> >>> Is this behaviour specific to SC7180 or only to ChromeBooks? For example
> >>> TCL Book 14 Go or ECS Liva QC710, would they also use this compat?
> >>
> >> The hardware and firmware representation of the RSC is identical, but
> >> I wanted to alter the bindings required properties based on the specific
> >> possibly-chrome platforms.
> > 
> > Should we instead have a separate compatible (?) for ChromeOS platforms
> > only?
> 
> No, the RSC is exactly the same. Quite frankly, the expected power-domains
> entry is just a way that's convenient to Linux to signal the platform going
> off between the drivers
> 
> I don't think there is much to overthink here.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

