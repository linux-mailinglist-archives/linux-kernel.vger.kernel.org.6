Return-Path: <linux-kernel+bounces-511124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4605BA3263C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3732168F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9BC20E31F;
	Wed, 12 Feb 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WbynotFb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7281E5707
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364575; cv=none; b=pK3tuVpnXG0TGqgLW0s2evksGZGbpnBudHEc2mq9yYVoWPwgzjisRD68dH8uQ+6BxKhtI/UmJ3iZoK8yCcL8XLkZkYIBLk0J58fEDhMEFAVmhhfjiPdzVnwAltlIg0qQvSWRspUgsDexeOc5MAQujUSTyiWmYl91TBw8rq+QtU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364575; c=relaxed/simple;
	bh=ccZ3wHwDph8Tvn3up3Fk6WgFSGXex/Hllcw79JUd5dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4vnMe+QZnaOh1U29k1SUXlzpwWhmqkdHkND/eAFzih2b8p9ItuSSU2bVscJOCuz1UVXrWQypEo9SyHB4ItSXPKqVc3ZzYNWkDLOAHh1nr/V31pqaPAvgGYVNqyX14Aw81zdhrTS09hXXwtN8qRqy/0l+9y4R91SH8+CwNd8mKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WbynotFb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C8Jo01007941
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kuUQBdSITaMKfTHHScNQdiAZY5xZBj/1CJ4MXpafH+Q=; b=WbynotFb6reioGKh
	1xF0YKHkh88XUhv0GA+CsFqKEXlV7m7+eXtxY3WBviWpih8tpkx0us8IvLZt1a7B
	sJXFbGq45dvracfDF/UTmUbbRaa2WMqOomly7rIS6Vm5rTSBGZF/ZjshQrIOtCsY
	WGRbDxoMPEWXQPFn9KnhlbB7zQB8SXIe2Bk8V10P2iPivtFlRamGKRMe6mo5Otte
	B25qsR50tWsdoWHCciuSOD5psTx8M4ScOcj17fcYP9LNcvNJOAK969nDC+X8oCjq
	WLcZv3uwTpnB/Xz2+P9QGuEfttIh/+U8jagSM7vEH+sGtvlLLHWOH3xWbKbcBSFQ
	r7bt4A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rr1qrq63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:49:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4718a18521fso6426211cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364571; x=1739969371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuUQBdSITaMKfTHHScNQdiAZY5xZBj/1CJ4MXpafH+Q=;
        b=FqJPJ6hR+Gvep6V70mJM2IRQF6kp/zdDsF2x8t2KFSGo3BnWQrsGYGbdhJWAQgMABU
         HWSXUj8MDvM6ztPqvznxGdglXDenfAOvsMVlCIw2vRymxWY8SbHtX5i5zw0+6l1pfGyy
         keFApQAiVI2ELtSNlRzJ01XLAGU11tDGti0bKe4tM96BubU5Teuqz9oWpa0+2iH20Iqf
         ZIqc4o5r+qfyE77uk9ZmOBWFB/p3+lHMazJxc0Qw+g9yl4S/KdlTRLs50I3C4icT0xum
         N1iXrNUIX/dPfvk3AayB+B5z6emad8OVcGBQK0p9XLjVThvpwgl/BgHv6a6Y7Lr4duC6
         fE0Q==
X-Gm-Message-State: AOJu0Yzs9Qxf6SinZOxgp9wfA4mLqiWPa7IEl9me0UNgTazk+SHTzHGo
	enanUDcA3WEfVVEUz2lMfFvsnHPs2ZXWt/2FR28jH+MjcE9i5UN7C6C573MDllKPcdGNSoCEEes
	elLfuTTnfKwKtNQHMW1DlrqtqVxt7B0DVnfsX1F5uWkgNbsEGCKqTYvWJu1tf02zIset2ge0=
X-Gm-Gg: ASbGncsBczByLdfrR79tBQy37adsCdyfAFgBdHS6HTRMU2vubGQIAe5al5XuIViF6Zl
	27OWzHqXcmB4JA0DCF6kFsv22vY1J1jW7B4UZhh1HJkGAJamx3EWMUEq+p5AKrZYJ5GuSQNbFwY
	IHoColAJ9G7YYaOMLZzOEG7IjvZIKXNl5RcXeAAfoSrxhLpHVwYY4LaasTTAfzEQ0YjRxPwpImc
	s9XDD49Upcdsppz5cCkGH28kM5yk1h782YC8FtLSQSo+YXIiNGHxeITvtYcZdJkJVanopScVaRT
	9BlyrmX/nsbxcZ15shISiRVvCIdg+YmW8fDRiX32M4kZSYgtxO1cHthwois=
X-Received: by 2002:a05:622a:1ba1:b0:471:a14c:6847 with SMTP id d75a77b69052e-471afe44807mr14893241cf.5.1739364571544;
        Wed, 12 Feb 2025 04:49:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXlvtCUv6kxGIVgm1ssWpPWbt6HtmfKifwsKGxI6ycuvSwhztswaJLUf+JCsS2rMyb9J3CYw==
X-Received: by 2002:a05:622a:1ba1:b0:471:a14c:6847 with SMTP id d75a77b69052e-471afe44807mr14893081cf.5.1739364571150;
        Wed, 12 Feb 2025 04:49:31 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7736439bbsm1249652366b.162.2025.02.12.04.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 04:49:30 -0800 (PST)
Message-ID: <9cdeb748-4f60-4050-9d7f-e4ff75ef1834@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 13:49:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add PMI8998 VBUS Regulator Support v2
To: "James A. MacInnes" <james.a.macinnes@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, quic_wcheng@quicinc.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
References: <20250212010744.2554574-1-james.a.macinnes@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250212010744.2554574-1-james.a.macinnes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mfAfUc3VMq24RvX_28IihHjh2FfQyLuD
X-Proofpoint-ORIG-GUID: mfAfUc3VMq24RvX_28IihHjh2FfQyLuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=936 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120099

On 12.02.2025 2:07 AM, James A. MacInnes wrote:
> Greetings,
> 
> Thank you all for your feedback. I have integrated your recommendations
> into this revised patch series (v2); please disregard the previous thread.
> 
> Summary of Changes:
> - Patch 1/3: Updates the Device Tree Schema bindings to include
>   "qcom,pmi8998-vbus-reg" for PMI8998 support.
> - Patch 2/3: Extends the Qualcomm USB VBUS regulator driver to support
>   PMI8998, dynamically configuring the regulator based on the PMIC type.
> - Patch 3/3: Adds the VBUS regulator node to pmi8998.dtsi, enabling
>   USB Type-C VBUS support.
> 
> Motivation:
> To enable VBUS operation on the SDM845 platform PMI8998 PMIC.
> 
> Kernel Version & Testing:
> - These patches were developed and tested on Linux 6.13.
> - Attempting to run Linux 6.14-rc2 on our Lantronix SOM resulted in a
>   hard crash, making it unsuitable for validation.

Please try reverting 57a7138d0627309d469719f1845d2778c251f358

Konrad

