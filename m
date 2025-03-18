Return-Path: <linux-kernel+bounces-566454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962CA67836
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6767F17CAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2E720F080;
	Tue, 18 Mar 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YhVTOffV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35034191F92
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312688; cv=none; b=ZhlsBxLsO0HQ/nP0KKcRsUq3h3YDFFrGc/hgMFcsyT0kSDAQFVHBfmqfmTEuwZbzO51RSWl3vBoPm2jfaVo3voLqwm/WOT4mUPVLOeyRHQMDuq2dgMsT6sUjxg2QPCN3zJ9SOohfdtbeHjrDHDvTbe161HLYqN+31NRtKkioFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312688; c=relaxed/simple;
	bh=ZyrAsfG49DpGrkR8H0kzvP1bytvhZGZoDf14miCEpnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FghoDfYHVL4CELVNhyziy+hvAW3DvVeM4xbdaTeZZCPw4Ex0se8737yJHkqMZm1wtlvlZHsFf5yjZY1sqpZ0k5vhSBBLok/8lwh6MZ3xYhCfeJQe2dXXLmLxQJ+LG0WeJTue0kNr7wwjlNBkMByv5TXMx/wrJLzo1Sdq3XrHkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YhVTOffV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAWsw5010361
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SAVIkA2nJaCLd5wAcdILg01ybenTh1RV6XjKZhSWOTk=; b=YhVTOffV+TQlTTy5
	Idt5nfGNUPYHSpbS9a7570JwGHmhOBtWPl6B+rk6g8I5J10SoNk2BAhLZeaSAqlq
	D8Y4h7pXldifp2MFhgA2TzHVY/XAKvtso8M484z9VMrDyjRnjLAbR+/p1svnRkXN
	LXzAozz4gpQC0w1OsKCEx0LW8wHbwDUu8m1aY58ot9WYmXlqhUrZR8HnSBuEOTH8
	oQwaspgm5GinYXF0swQbYHfj9V54d31BZI31SPQgWGAqFAKjxqgIzwHmsO3wLkqi
	OPkad7QCOl39wBuh0ELSwhJsqSSARI5+ShtBR7F9kPd2OE4bNmfR2woKdMEf9Bm/
	Ypt56w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exx32cms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:44:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-223477ba158so167486605ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312684; x=1742917484;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAVIkA2nJaCLd5wAcdILg01ybenTh1RV6XjKZhSWOTk=;
        b=tu9fHIDo7/I/MXUHThllJpt0oH69a9E3VbsECOem0PbSWRy7FH0BwJ2tNjtN7a8S+R
         nKBJD6lSXTxcDRQLPSJoQCRbmM9UMovDR5VmD01JaK0DX3MZEuSg5Ez43rFGgp/9kHXi
         HjuzgXx0vf3sS6X4slzt5DcbX5CMvu2l4WxQbpQQ3wALOr3nfKkLpszxJPoKkfr1ukJM
         CP8GwZmEA3SA7G7IsrxbHqfkQaSeLtuutD9w4shIMgE2HRJbks35mqh0A7VvPcXKjyhn
         ma8I2ek3ur9Y/x0bDjQUNXXH0IQx2iMNAqTDOIOwWaFh6hysrvUpTfLiif0AeL37PVZg
         yWdw==
X-Forwarded-Encrypted: i=1; AJvYcCW0YdpntcvoVIWi68hLHQgKOYWWOQErRgTnU+yXNPMrpAGeUZTXhvs4EOjqv1Fsvf/L0AwjN1hyFLMcCTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1kVfwsGZqXUlK+U5K76GX62iK4xBDVKdGcYP0nXICI8jVUmCr
	AlOobdaf6NWxDSQHS31uDu3l9m1rKGlUyP/r0tgvnTAnvjhkrctZziPrrp9sgJ0yRWFFKQ5LYor
	xqI8MuHEprEeicha4/+vJkliVf7WXxZSPeSIbVaAEXPxFwCh5Pl7Iz1UTm/QacY4=
X-Gm-Gg: ASbGncsMCYzqyrLVjJICTId/f3mP8nqNQ7BMxoXv1gS+u8JAnwbi/G8N/hrIPr/SQcu
	ZkknrywX6ZbQccRC/z9bKBNCoo7idLQHhZAnIBD4RL6WQlQKOl0duXxOK1SL450JExL9Q+XHOVV
	K2pFHR0H9WeUmabCJgfkIWRG1RVHNptxLPtO2URdPFomOSwjDcsGG7GZgVsA7d+MbshBgixABHr
	M2Idthe5ys1gF4mjBm0KovEVF4q54qXix7LjjXe32jY0jwE9fFRAEJ4UpLkM/1eNsPakWZ3T0hn
	3OAQG6SOOLIiSXvC1HHkDVv2W4GkVsVcWX3INJBGuC3ewq/87AVDp3tSybIZ9XAU18zq29s=
X-Received: by 2002:a17:902:ce0b:b0:223:668d:eba9 with SMTP id d9443c01a7336-225e0a15945mr234859945ad.10.1742312684408;
        Tue, 18 Mar 2025 08:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4lLp5t7+ZMhTjiUg/ojVkZKcM7/NIU48U90wLJENACatjgBlOPc+VKldix4F3T50fec8NNA==
X-Received: by 2002:a17:902:ce0b:b0:223:668d:eba9 with SMTP id d9443c01a7336-225e0a15945mr234859595ad.10.1742312684072;
        Tue, 18 Mar 2025 08:44:44 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116af372sm9716397b3a.160.2025.03.18.08.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 08:44:43 -0700 (PDT)
Message-ID: <683b16dd-a3e9-4cc3-836a-95f3747d3c0a@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 08:44:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v11 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b+uy4sGx c=1 sm=1 tr=0 ts=67d994ed cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=E5dAun_1JQ9YDljNTxIA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: HhuhRLqa3AjR7OI3gNmEgFFgHzDTET3G
X-Proofpoint-GUID: HhuhRLqa3AjR7OI3gNmEgFFgHzDTET3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180116

On 3/17/2025 1:46 PM, Raj Kumar Bhagat wrote:
> +	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);

kernel test robot warns:
cast to smaller integer type 'enum ath12k_hw_rev' from 'const void *'

looks like others have fixed this by first casting to (uintptr_t)
a few examples:

tsa->version = (enum tsa_version)(uintptr_t)of_device_get_match_data(&pdev->dev);
model = (enum ep93xx_soc_model)(uintptr_t)device_get_match_data(dev);
priv->cks = (u8)(uintptr_t) of_device_get_match_data(dev);
rt5677->type = (enum rt5677_type)(uintptr_t)device_get_match_data(dev);

not sure if there is a "better" way

/jeff

