Return-Path: <linux-kernel+bounces-535890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22CDA47898
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15C93B1E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D322618F;
	Thu, 27 Feb 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mpsib+GG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA722652D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647054; cv=none; b=WqOnwTDQHvnstM2XncioqTGED4w7iXRfW34xDpIz4A1q6OTE9MV+c5GxuAEFEA8F4PNFhuWPypDNZmCQi6jcS33V7hayJ0tedt94TkHx3oTb+kdABDg63lno5F4oZ7kJ9XIk6MKQ1lcAEBrFkGMdmg2yrTs25klLyNLbW7FD40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647054; c=relaxed/simple;
	bh=u42Ak1Pq8Y1bErL2ZVfxQnVap2YnXcFLZGDObYLYRiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lP/BIcven3z9Q5WHnFpwSbUw/NqkMBiJhSoTe+HQINr6wkGcKIk8V3gFO+dp8+sJTRyDVhFg4Zk4qnHWLZHrq0IoH/0VxW2Ta63Hk7N3RwqUw2cDfBS3I7xM7lSar+YflofKvvpmtNYbFTArz/9U2fnqe2hx6N2S8g6b3soISnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mpsib+GG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R7kdlQ023823
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ISIpvDLr4nm46G4XgdEgTIb0RhLt9O3O1FoP7hEvHq4=; b=Mpsib+GGht62Gc7s
	n4NuZ3WOyVpgMdj6M+UTLJDKu880SS3jOBz0EIFOmxEOlE8qAfgfHWxYhkf3yd58
	u9kCWOJqEOfcnNcV7Qh+Yluv1LVg58aIPocqsZBGL04NdLumH81bDwM+LGfIBBg+
	DGdailFSJ1IctjUA54FPRsJEU9o+C6xpXl56PcSjJ8iTc5SMGAYNbwQOmRW//iU6
	bFBsEioWiFJfWe+IPtGSA/kBxPtS7rITJhYHcw5lBfk/d7/svqT9jeIr3TAsUfMf
	WkucAuUflQEe3ghGcyg8SO+W/sEAdKkdFlhTuTGVcY0bFYct4yN+8w9+vKGR1Axp
	FGhu/A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmn08n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:04:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7be6f20f0a4so15152585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740647051; x=1741251851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISIpvDLr4nm46G4XgdEgTIb0RhLt9O3O1FoP7hEvHq4=;
        b=RCUwVnBvZppInb7Rn9Xh/ZJLqaJKOaho/E1MHcaX7S82WDhdMgMZhoXLZ3JEuMDoia
         M8tbvFuCf1QVd2r+giUJAlliHXNkMqJxVkEV0ypVduWcatBEP45NEhs/deKGNtvjvyFq
         fiDwJq67HfHiAX7tUXiScqAqJnSDRdOYs6HCtsRohs2SmvtW5XIAvPJ/KHltLCEbDFsY
         Gn1hxcr8yCblnb8KXYJ3v4//E9pEAErVRFoIq02sINuss4ihjTrfN1JtpciyK5e15qTu
         G0hCYRah40+CMQ1ZyJzLOqXu3YhSHADxITZl9ItlWLtC/HivUET3y55RQlyUAPNCdhf0
         EJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZYuNJ8GHzwoEWMUVFv4mZINPj1E/j8VWsf9mlJJGfo5+GsiWS38FrTafdqx7eR7S8gbt0uw4hQgOdFG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUu3hqhjGZyC5Il0fEPcrNdwRnlin6ttLhi75xN8O0Bz0U9FYS
	aUARypZOCbrdVVhu7GFz06YotKc4xPvh3rasFSjPIaikmAigVljrbQCmirbfwnigGLOdCsJkdSn
	kIbHknoiIHL+7WjscS9oHbwDIWjZlgtp6D/45yLTpzCuaT3BI8L8LDmqM5fsKbCQ=
X-Gm-Gg: ASbGncs88QFGSlHuluKNmxspOBovNUaUoSuqH3so57XLFqCTcxRkyIfh2bzKR49W27z
	cBR0PNdbcBJUu8AGlHT+mb7QimM7oBC6fCXXsG1zAmiONHun/4aHUKDLZA74Tmo7PUBkSnjF8jE
	RWALotH+qmRgdKx4NGiAtanGlPmLr+AHvorelUYgwk8uJ6s8XZ2Jxf6b5rhrd+KDtuoY5Wobf0x
	rpF0TcgETqyXfMahdmBhunIH5P5Rpf+gGJypoqcE5vd4zC9E8X9XvvK7KBv4N7a1KUbgVUmWdwX
	RFAbFeS7hyktUfsbnqOVbkvY24slFT/Bh2OVQEXzv7FAsuqQr/qZn/J07fihU9VxLsf+GA==
X-Received: by 2002:a05:622a:1a96:b0:472:147f:1dba with SMTP id d75a77b69052e-472228d5fdemr128421521cf.4.1740647050845;
        Thu, 27 Feb 2025 01:04:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR+YpAMmMQyxSjZPXR+O/quj/d9e8NAkyiIF0cnW6DFrG6HqpBefPVaVbaehbYTKv4y3sMnw==
X-Received: by 2002:a05:622a:1a96:b0:472:147f:1dba with SMTP id d75a77b69052e-472228d5fdemr128421341cf.4.1740647050539;
        Thu, 27 Feb 2025 01:04:10 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c98sm89714266b.142.2025.02.27.01.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 01:04:10 -0800 (PST)
Message-ID: <1687d1fe-a9d2-436f-b219-6e7cb3d2414b@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 10:04:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ARM: dts: qcom: msm8960: Add tsens
To: Rudraksha Gupta <guptarud@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wctrl@proton.me
References: <20250226-expressatt-tsens-v3-0-bbf898dbec52@gmail.com>
 <20250226-expressatt-tsens-v3-2-bbf898dbec52@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226-expressatt-tsens-v3-2-bbf898dbec52@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rj--rPAh39jh71dEeN_M39A_pDyCCy3b
X-Proofpoint-ORIG-GUID: rj--rPAh39jh71dEeN_M39A_pDyCCy3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=931
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502270068

On 27.02.2025 4:50 AM, Rudraksha Gupta wrote:
> Copy tsens node from apq8064 and adjust these values:
> - thermal-zones
>   - adjust thermal-sensors
>   - delete coefficients
>   - trips
>     - copy temperature and hystersis from downstream
>     - delete cpu_crit

Oh you most certainly want a critical trip point so that your device
doesn't become an oven.. I can't unfortunately find anything that would
definitely state what the max temperature is, but I guess that you
wouldn't want this thing heating up above 95C anyways, so we can take
a conservative (likely undervalued) guess like that.

> - qfprom
>   - adjust compatible
> - gcc
>   - add syscon to compatible
>   - tsens
>     - change qcom,sensors to 5
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---

In your commit message, focus on what you're adding. The fact that you
copy it from somewhere else is secondary. Describe what (and why) you're
doing in this patch, and only briefly mention that it's based on another
piece.

Konrad

