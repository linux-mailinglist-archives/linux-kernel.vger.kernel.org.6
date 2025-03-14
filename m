Return-Path: <linux-kernel+bounces-562242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9CA61FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10016188DB6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EBF154BE2;
	Fri, 14 Mar 2025 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMrfETTR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF312B63
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989805; cv=none; b=liqwGmkhhkZD90rviEqN/N0KF0CL47zf2a/BHojhb4N4YcFC7+S+o5/3C8/9QNvGsH5BXG2n+I4p9wGYvhgFYcl0kGnRTBACS1rMDgaVuueRuwn3d0ysw2y01KaFf5NjE6pdNMjco6Fnia7MOhlhH9MBXTEzyGo+Nj8geRJs3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989805; c=relaxed/simple;
	bh=YPYAgaNXP2IIPLWgofpyQneMOCtNp97g1EQ3HHk81m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leJ/N07/2SYcFgegbKX4Wi+DIA/swmmzma/V6qT2jD2NBHdHIf7pI1Qoy+gv4mcwb2dUw1lErSsGd2h92p+guv4qGEw7UOBASIbH4KSdhOpM+ggliaU81SaII5iHTR2lTR0CHWHc8Y6xOzwEO/4a0n9N7cbTlD6lym3i8gklT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mMrfETTR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EJMlb2022314
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dnm2t5CfeS/52MGOLwOHFsVRcUbMcJKyNFgAPRvdxfA=; b=mMrfETTRYc1MtFbr
	cegihmZQto1dlyr23SbC7wUzzyfgoNOJ0Gs8mQhzGWxWCGXeJla7XfXJ/j5VmjAq
	JMaLBwc7iJeHklYpZHFVZKe76u93ZgMr2/YzGE9gR7JoueYH3XS67FjUhYk7QRBx
	yaTN9mHUV766P/2LuAfFM/KUJp7xUyjH8hHHEGKHfLuXvaF13xsjTkh6KvJdjX2F
	5otqNdogdoLixYBmeKfxC4pdVQD3vqALdzmWaLfY1O/9sMh5JeKIafDQ0B+qVG3E
	VXiDZKSgkVShwTsj25dNcnd62oHLbZZuR8YkcHPbkXRsKLnnA2ZByySVEKyGqU/E
	53ltcA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bu07nn6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:03:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c53d5f85c9so34769085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741989802; x=1742594602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnm2t5CfeS/52MGOLwOHFsVRcUbMcJKyNFgAPRvdxfA=;
        b=YaZ7ULWdljIfYCGVwF5efXSmFHqymmu3KhaGNdAsC2zeaaM7sd1KDfC2cH5YIo03kq
         SjjFwUz3BzA96wwFw4eqJnozxJnqf55k+X7506hzobAtAIsMEcSP1mzgHM1gi6FEiqPQ
         61yw0ZtqzBWz0XgGDeHIaU6m2/HIvRHDxPjR7d9E1xLeuAmfhOLwFeaFdYigoG7VpPNY
         4XR50Xm5/nMfB4ahDuLcxzYkZk4tlc3oF9v9rJz99tJKpizXUuHo1h6BLrTlU5N0NiEz
         DPw+34/r89Xs1chqtUzIIbHd9Cya/Cxz+m0TCt/l7dHGXZkcze7sDiwqi0afG1FYrmFW
         699A==
X-Forwarded-Encrypted: i=1; AJvYcCUPTOaB5SvD0v3ITrn3AlJb2sGu3L4wNMZe2y4TXNfZJ+HpCuwWihZvYO7UOFnQyN/n0faNRZU1FqAbASo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRZSH3LfHOb9aJoEEQAxg4fzV59BabkQJ7QM4G3ndFSQon2wh
	xUJKeZVXNtoklt5JYBDPGB5s3vyMxlnB0umRE3AJslulg7y9Ev/bsuq1aqI02Q2S6kBe9vtysFW
	o1Gk7O7c/MEDOkcA5n0eAJQN3oknQdGU2SN1n2tmZONnn31b1N2vHVU5wYmsW9kg=
X-Gm-Gg: ASbGncv0wowpS3O59k+stCLldKPKcCPVzGm1vmy4RUciOo9pJrdgaxVg5674VOHxcjr
	goKosE3ExohdtHUD825eBvwuS3YQzzBtfKuFYGRzwM13wtPBerDM7UZHwlCwKWdPcm20MktcWdr
	1CS8qqW6zF7NOeEOxvbCDXEIFsobKpZMZpBgBxOXx2eezRpvPRe718OycBtraBLNIL3mtx+Hg++
	LQeDJDHgsrbg5U2M+9Uah/VsD3TK1uc6oOV+o8mWubAjWlWvOn0tk1l7xwzctPfeXQ5qSICx6ur
	Ep52weI4C0D5BTJE0kEH6Oy866E8RPy/dnqbJna3uBqtaIESrVwOG3Y3cnqSsHustEmBfg==
X-Received: by 2002:a05:620a:31a4:b0:7c3:c814:591d with SMTP id af79cd13be357-7c57c795580mr190182685a.1.1741989802130;
        Fri, 14 Mar 2025 15:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGTEH8+2F/jBXZWadtElmUZ1siIaSDospZBCxTdVcPZR8v0O64Ck/1fxS27sV0REmM7K0WJA==
X-Received: by 2002:a05:620a:31a4:b0:7c3:c814:591d with SMTP id af79cd13be357-7c57c795580mr190181285a.1.1741989801750;
        Fri, 14 Mar 2025 15:03:21 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afdfdbsm2397154a12.74.2025.03.14.15.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 15:03:21 -0700 (PDT)
Message-ID: <948b3f2d-3834-479b-b165-7191778dc5c3@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 23:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm6350: Fix wrong order of
 freq-table-hz for UFS
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
 <20250314-sm6350-ufs-things-v1-1-3600362cc52c@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250314-sm6350-ufs-things-v1-1-3600362cc52c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zXlz13jy50ExUB0GbPNdc3v2o0AWGZsD
X-Authority-Analysis: v=2.4 cv=V+F90fni c=1 sm=1 tr=0 ts=67d4a7aa cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=08tnehPgh3LRQT3fcTIA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: zXlz13jy50ExUB0GbPNdc3v2o0AWGZsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_09,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140170

On 3/14/25 10:17 AM, Luca Weiss wrote:
> During upstreaming the order of clocks was adjusted to match the
> upstream sort order, but mistakently freq-table-hz wasn't re-ordered
> with the new order.
> 
> Fix that by moving the entry for the ICE clk to the last place.
> 
> Fixes: 5a814af5fc22 ("arm64: dts: qcom: sm6350: Add UFS nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

