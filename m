Return-Path: <linux-kernel+bounces-382310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF69B0C31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F3C1C20F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B91F7566;
	Fri, 25 Oct 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GQlx4I8Y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F020C321
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878811; cv=none; b=FUzGMjO1g/DhdBp+ficOaBZQLDkib0Ah3LzI+PBGgCNZdnijfX/h60AKl2HGAql7JCj8Tje4lPCZ/wMiEi6X2knZ86fcFxN98bB2kPC8pPFR23//h4mUg4ubyq3yECPFxvQUQ9wfHv/OjvyUnt9tO92ORjvoTmW7dTHfrJXmxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878811; c=relaxed/simple;
	bh=P8w/4xa//RU9lAnPnwx248N6Weq+tR/HtL0ChlTNq/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBbKBJzNbCoBDv/Djy/Z8EnmzGbRsDPJBl7G97Zk5MWXAUyo61wzWFmOwvK6ebhJNGCrBvrVlYmkJtITyytn/hv57L667vAZMIFTU61UNt9hwytQikbuR+r3oWGNSTefQzm7a88SreJe3o2yDxT5ymwbzCxDyAFM+D2b/+UhxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GQlx4I8Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PB20RK000928
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8k7oCA99Z4uKYdd0P8aQke0d0o48r8gT1uqzJnxlXhE=; b=GQlx4I8Yy5ehiz1Z
	kP7r9JPTJ3jb20iV4V2fyiBOABOtwqK0a96pZWlHqw7Rg4qaVAF7a3f5oO7whixp
	K6sNWRhmHQRCf9Tid9SBsgj0d5CQJs6uqb7euEk9sehr+SfsKRks0VNu7GF8/6e0
	eX/4hQsMBRy3e1LlXpYTPSfbVIhu/4gwFtFzYr5BWHyzAoi6xjJ0V2cqztwQz2lq
	3xVmE/hfc0RsY+3V3jASbdWHa7lwijDb0VQ+3QBjAWv+guLjOjqFRwZOk9we9o3p
	qcFRECT314LiKk9ygnjuOdehxjZKFNKZvwISoUcocMQqoalb48leDkoeItDcRSbF
	F50K4g==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ga3s18d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:53:28 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7180405a9faso509737a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878807; x=1730483607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8k7oCA99Z4uKYdd0P8aQke0d0o48r8gT1uqzJnxlXhE=;
        b=ZOQAScTK/poCmXYVDyMCtthAerp5VUnBI88HfN4SLbhp2orO6ev1U1tLJXq6xPF+fy
         4YL/rcodVLG7VNU70pTSeRsaK6rQmw/s0C9+8b4GbfSugPlLVamTFoDHZmnQiLeRHpAM
         fWG/ALnUHxNVUZZQPwjy4LdrhshvVOqztfekublAcCr0J70pHkCmRKNOHZlkjx6PiVhQ
         CKCYD7tljOLXSU+mZQZw5divGAG5kfX0iFooQXEir9jBeqv9M38vjF33VdDmaEhLME9a
         HSVoa0fdZWlNBWiJy0W4mQKdbo7DhTpvQ/k1G5cMGKLfxKfly7kBWJBj8Jgq3g9vxgkV
         4sqw==
X-Forwarded-Encrypted: i=1; AJvYcCVMbPEyy4+jiR+eU9Rm/4LQYlydH0Lrru1nEnlFiZ+iB6/O+j5rrEwJXwcmgV2Mcqbmca1K4lstZc8ohxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNi/UbMcyVtKQTP4i3MkXoyUKoIKwl/WoYCnYa7RD0/WJYGDLH
	zmIZ9DOJ2a6tI4E0wX7x149QnpeJKFg9+C9yvTJtDE9lG9NHs9/xHEkDTr2rswNhxm6bXlI8GEl
	ipOhegdw1YVZN2YNL2k6yprOYye21LA0/jUScD2a2kjIs2E5HPHJ+pWWKfBHFaJo=
X-Received: by 2002:a05:6830:923:b0:718:1f8:8994 with SMTP id 46e09a7af769-718682a5260mr102198a34.3.1729878807501;
        Fri, 25 Oct 2024 10:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcROYxh3KC5kpHdGtC1+anYSiozumDUTH3CW3qO7RQwNgxaRsz0qQ0a5hcLEsoiXRG9svtFw==
X-Received: by 2002:a05:6830:923:b0:718:1f8:8994 with SMTP id 46e09a7af769-718682a5260mr102193a34.3.1729878807119;
        Fri, 25 Oct 2024 10:53:27 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e0b2400sm93622966b.45.2024.10.25.10.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 10:53:25 -0700 (PDT)
Message-ID: <01ed914a-bed8-4d9f-9ff4-56b4fc8bc0b4@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 19:53:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: qcs8300-ride: enable ethernet0
To: YijieYang <quic_yijiyang@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com
References: <20241017102728.2844274-1-quic_yijiyang@quicinc.com>
 <20241017102728.2844274-4-quic_yijiyang@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241017102728.2844274-4-quic_yijiyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: POnRWXdUmrXQg4Vo4pygrGxlAm_e3IwY
X-Proofpoint-GUID: POnRWXdUmrXQg4Vo4pygrGxlAm_e3IwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=842 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250136

On 17.10.2024 12:27 PM, YijieYang wrote:
> From: Yijie Yang <quic_yijiyang@quicinc.com>
> 
> Enable the SerDes PHY on qcs8300-ride.
> Add the MDC and MDIO pin functions for ethernet0 on qcs8300-ride.
> Enable the first 1Gb ethernet port on qcs8300-ride development board.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---

[...]

> +
> +&tlmm {
> +	ethernet0_default: ethernet0-default-state {
> +		ethernet0_mdc: ethernet0-mdc-pins {

If you don't intend to modify these specific configs, you can drop
the labels from child pin nodes

The rest looks good

Generally refactors happen first and features are added later, but
I know how painful it is to reorder changes in a patchset, so I'm
not going to ask you to do that.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


