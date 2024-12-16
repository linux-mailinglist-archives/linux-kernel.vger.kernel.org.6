Return-Path: <linux-kernel+bounces-447327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8D9F3092
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124CF16488C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CE2054FF;
	Mon, 16 Dec 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lAOz7yPO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72641204C0F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352318; cv=none; b=KKtXi1AVdHh5X9pfHzG9TvNJxcA2Gku9ocLN4fmkmdi6A11+xk2xk1K03j8Fuj6cUr3bKbjwR59HbnebYm4WQZ7cHPOVPayTcbNfxc+CA+Ph4W0n8KNdntz2F+Pl0UTEA9YkfbgKn3EFg0Mb+QMDPoRJuS4KDKOE3Vcf4WDZQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352318; c=relaxed/simple;
	bh=NOGmwuUhx41uLN0wHBW0LLXHIBm/+VxTjHL0qIfPIxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lb522tbxtb8e7/Nxa11o3gZdN9W7kxqxI3Y8y4eyjLJ1F7uoB45zC+8JVYBp4RpxllbjJP2xtCpOWHUQQcFQrTzXyC20D5HVwZ1UAxwfAnnAogHiC1Bzb586wKCSTEimlI2lR7AO8Zq+yv5F24H8RWv8xGlXhRFc98RwD8pud7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lAOz7yPO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG80c21008342
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WeqvPqxs/zm+neW3dpwcGc7WggbqVo4nB/s2S/wzmDg=; b=lAOz7yPOamfLxjv/
	ODjMV5+2Kb003nv5eIAiAcD0qLYO56rc/VB+tbw7aRnoUGG8/Dm1/0Et8FZuYcm5
	aoPo506w01Wt5nshlTRiNec3s4xm/Du435v9FH7MISnroT/yAwcubt80H3Bae6xU
	NMok72cGviDIFgvgNmfeKhNTAtvqi7XI7L3pbByJXhhR11/pGYo6PLArEZDeQ8hB
	FbjV5hP9LuDWrmriFIA0dV1E07txNVzzjLEbIpjljX6y6MomInUIZFeGBX8oCOzD
	WACcOX451b1oLqdycuhiSLNVMGwmg9jjSXeWErLlWrAN49md/bv0HIAw/Ew3Ti8j
	U2RfEA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jgas8r5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:31:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8f77bf546so14114686d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734352313; x=1734957113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeqvPqxs/zm+neW3dpwcGc7WggbqVo4nB/s2S/wzmDg=;
        b=GKd1q1b02g1cv8hQCf4zvIGcikpxakuLlnTsV+Bi0hLIlfk7nzfFqrLO9FQ0XoI+G5
         eiAMi1OblJtM4mRmseP0tMWf2TnpS7nid2I7XFyepjDGFRwf8+jobIQJLjo0c1J4Svw1
         m4lnFq5puYTWgwZNL2dSHXnvqcy12u6vbpZuY4nYlCKKsEYUk7L2Y/7zhNMCDswGDk7s
         MT0lmzQwcy0g+9e3n92wms0jAm9k/VL9RmtEHmEjF38Bqj8UaS0V0K05Nx+QDPPIQPpA
         NGcwkm9zEut8jpDbOX2mHuqzeu9FIHci4QNHlCpPEY436zLprqCXF7xBFk6WVX3+KGjv
         90yw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2xHe2J4NF6b1WOd3K+OVyiz3wmaGieueSx7JLyCdr0+fDT/0Gcw9Cz50Cnp7hQ4466VgD4ltQ/hcF1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2jJ3YVwG79IzBXa61JiPUvKr6QuVJld31RxIkWAfMXiv70TF
	DWScWDCJ047gUBK/5Ghu02oV77Y5u8E+BRGkSNiVXQuO//Hex4MAIlTY2rQC8QKUOiJMzv76sW2
	3CBjSCMBKgu7/IYVIXxsDmDmT+SXmqapQLRuqGgDbVYf42I+pPx85n0EYYmZ+vouOOa7+4W8=
X-Gm-Gg: ASbGncsqpIStdL9j1lsTPSQU+rvjIWhMQdJTRfnE1kNdj6gP6Wi2PGZvZf9BBr2Sp2t
	iq6wYkYn5ONZRNmIA1j2wlZw0liL7FFjh/xxDD8dH0awXl8O2UboAjxmsSJZpsJxzmh7+kJaH24
	A5plcjr4kWa4oo17H/3fauVQWzQE1mimVfQdsFrAl9YACyg+ian/HH8bg0k7/GYOBK6KdCAUiQD
	ebQweRpKSXyPTijrk49XWwzDZMH9LvjcG034QamgCVwj1yfHwzenw8+TTgNWFt8VR5OvKwW+HPy
	CZz5xmkPLxsbrYSd97lRASZBxIRNj2IbCXE=
X-Received: by 2002:a05:6214:c4f:b0:6d8:8db8:43a8 with SMTP id 6a1803df08f44-6dc9683b11fmr74596696d6.9.1734352313560;
        Mon, 16 Dec 2024 04:31:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdrHVfyoU2etuQqyfIbiSLQe3FMVsNgCETbPhLwAWfRSOxp7xzi9URabDJLwUjep6ho8lswQ==
X-Received: by 2002:a05:6214:c4f:b0:6d8:8db8:43a8 with SMTP id 6a1803df08f44-6dc9683b11fmr74596476d6.9.1734352313221;
        Mon, 16 Dec 2024 04:31:53 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab5198sm3112039a12.8.2024.12.16.04.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 04:31:52 -0800 (PST)
Message-ID: <ee5460db-2459-4ea5-ad35-e9520247cb98@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 13:31:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] arm64: dts: qcom: Add initial support for MSM8917
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
 <20241215-msm8917-v9-6-bacaa26f3eef@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241215-msm8917-v9-6-bacaa26f3eef@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4sy6lkfhhUGP44Gz3X6ndEPXx5jD9Nuk
X-Proofpoint-ORIG-GUID: 4sy6lkfhhUGP44Gz3X6ndEPXx5jD9Nuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 mlxlogscore=974 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160105

On 15.12.2024 12:15 PM, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> Add initial support for MSM8917 SoC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> [reword commit, rebase, fix schema errors]
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

