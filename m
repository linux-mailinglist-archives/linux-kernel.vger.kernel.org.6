Return-Path: <linux-kernel+bounces-526725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51149A4026F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEEF702351
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9432046A7;
	Fri, 21 Feb 2025 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VbYdz+rm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01918DB0B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740175430; cv=none; b=Oaf48/BqSUwWjXAgWqgVPJk3NJbYxoq4SFIXIOmzqFVoQsBnyQ7vAlbrjAE5z6Cek6zDACNX8RksLkMreAen6cf2L8GFsjNWykesAlQxkdb1gkwwkM6c7GPbWcr63fFEf1lKyFB3P8muC1abLPQyPENPghj2IWlFvm2dr+Zviyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740175430; c=relaxed/simple;
	bh=otM4pVilEJQ+Z6ARx2EyLLQgCTG9XEl5i6JjIyrxgB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kM1NQkRlL1GxMPjkT3A985uMbmp6j8s3oathso0WbrYkgRisroPJmFnjHeQ9Wr9vzU/sh1d8lTZPZhlTBH+pX2nUMHceuRiLfRg4Wyq85CTfiT14TGtZz6pKlDGkb07qzx7lqGwsZ4SE+guwyxe+K8EMI4Y46v0UNGPTMBw23vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VbYdz+rm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCYtoD012259
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mn1elD3IHQjpApM4cUuNBscJHGKeSRDBzEug3ElCCWE=; b=VbYdz+rmFVW6a5uw
	U6f3+AbD8Yht23gx7bWz8lfrOxLoHQQe0aVFNJ1Z+ae4nCvevzYRwrSuzDFFiauL
	LGFNyB0GfmzWbpPdH6LFRnPeIKj6PHF6kFI2EuggruOmo0GvUzGe29f2r+tWnnqJ
	UhH3DUGz7OKJOdyQwocJL5HwtBugq0xYgx6iTCYxOS7S51/4lQ9/De9zqaGiL6Y5
	Z6siIz0pJWcX+aGK8OoxyRFLqZ/Gsinz6at1jOeRd/36favwyIzeLO74/8DurfPu
	QAGMXaPBqfilUQ4mGH6orujXrEw5uX617ggM3ObP5oaYpnwTmniTxSwTB+8kOGrz
	7q3t9A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1ucsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:03:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0a9b6c146so23210685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740175426; x=1740780226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mn1elD3IHQjpApM4cUuNBscJHGKeSRDBzEug3ElCCWE=;
        b=mgEZk4Idado6PjezwpVv2DUXiDwcnYOnjf9u8ZjN/0xLnia+h51R6N0TvwTCr8Quxx
         SAPCUUJ9CBBc+VHcRjpte0ExDovwbOLceRl5NXJ2w6OKZw3oE0Fdnd/rQjiKZUghSCNw
         0Y6M/ztlRYdWqQZ48h8vn+XamBXDF5jfMA02rhBHZUTJT51btiUAimUSjteg2JyrUn91
         o7LR+3pMslrHdoNzBx0lqsGsUmb2KhL/g0JzeXFVXAjrju2czIAVSDnw6EQkMhNfpRl7
         1JieaVHChHzGjIZCKsPYJW+c/budjq1vl/PLRUnABVLfHv+9iDoAp4mw7LbviUzGGbQH
         4t8A==
X-Forwarded-Encrypted: i=1; AJvYcCUX0OTXPUVyZCFCO9n2Xrp3OFWveyLjCJ3xazSffa0keCcqxmQ7FbsdNacoM8mIc7Jnl5Szt4YecX3NJ4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWu92h9zzBkprewzym8NUatCRh/D7cZ2t7P21zF8UdIY/41R1c
	cpjmlIpwRAgcZCWzOG07SH3/VVi0bTQC8qeH+l0CHZN988epnEgkA8p9nWTA5KSbSi0FPWziL5e
	jZa2WMOaqLDg8PwZNm5ULhwbcND30VipALF9YpFglqk7MpCevhAxm82Mn/4Fn7t8=
X-Gm-Gg: ASbGnctIo4Gi0YfI1i6kyRTO6oEMGmrmhWUAgA714um3SP938dAFnI01XPc7PxLzhYw
	LMQ7IRY2xk2Cjy065Vmpa62xVy2ZaVGRjVqgR1cXKhaqDLKCJonfsRN2NyMun5mwRnYukczN75Y
	efizybsE7Uy6oFaU2znYSezHRbRJHa9J4usGuZeHGxeSYEp2qraWq8vthFEBpN3HJUsvslTWEMH
	X2mPbGmv5EkQXydWUwVf0Q6hHewEPZ1nusks/0nhp+2rJZOosYLntomlAEezBCy0K1OZtMWtrKx
	r1xibBWUZpN0NGnWdcDcQy/D6ezB42Z/8Lu/04omnFq1dseygEB1cIx1xv3b9CD9+68hEw==
X-Received: by 2002:a05:620a:46a3:b0:7c0:9ac5:7f97 with SMTP id af79cd13be357-7c0ceeebca9mr295777885a.1.1740174970780;
        Fri, 21 Feb 2025 13:56:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZvOu0eJXztulv0V5Q7f7sK5RIJKM6aqAnzhe71Fe6vNwS33Dm/VlYp62UvFkTF5N75nE3eg==
X-Received: by 2002:a05:620a:46a3:b0:7c0:9ac5:7f97 with SMTP id af79cd13be357-7c0ceeebca9mr295776385a.1.1740174970332;
        Fri, 21 Feb 2025 13:56:10 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c43b6sm14401910a12.26.2025.02.21.13.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 13:56:09 -0800 (PST)
Message-ID: <eb78eb2b-e35b-4744-ab09-6aa350ec81bd@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 22:56:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM: dts: qcom: msm8960: Add BAM
To: Rudraksha Gupta <guptarud@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Day <me@samcday.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250213-expressatt-bam-v3-1-0ff338f488b2@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250213-expressatt-bam-v3-1-0ff338f488b2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UOT6D6GMhEpRnP-kD2DPtmVdVLRAyVp5
X-Proofpoint-ORIG-GUID: UOT6D6GMhEpRnP-kD2DPtmVdVLRAyVp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=700 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210149

On 14.02.2025 7:28 AM, Rudraksha Gupta wrote:
> Copy bam nodes from qcom-ipq8064.dtsi and change
> the reg values to match msm8960.
> 
> Co-developed-by: Sam Day <me@samcday.com>
> Signed-off-by: Sam Day <me@samcday.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

