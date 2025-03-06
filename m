Return-Path: <linux-kernel+bounces-548193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4476A54164
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C913A8E9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE1E1990CE;
	Thu,  6 Mar 2025 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BqOlPHxo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF55EC0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233081; cv=none; b=d9QKQ6VsnyDhuODKXs0AVKRzRYskAaXDUnvspMTf1w8UYBf9rwufUpV2lm/1AQ0xZljTHsBA8eSK5Xzmuy2QZBrDMQkDGajkz97O20YjcuM0t9OUA3d1TofoIJCOzsSRQzxMaeZgpqQoIwsHT7nRD9j6iZI0QqrLJathYNv3kLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233081; c=relaxed/simple;
	bh=PyDSWogbuMLwJJUkiRPbuDwXzHUhvl6OXkNbENnYVbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwrfkJpCFPIj9FHEHNDh/rW0hhjZOr5LqWD/Ppnn+y1RRQnE5KQu2et4h0ktBQloWA0QXOef3BBz+02DRxXQfCHWI0dDavRb9F8Z/LFmKpWHhkEMTJRaEj8HHo3SvjYfI50R8ZsufDWrqYpufxQuPChFT4pWWuw9IpNyuPdjSiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BqOlPHxo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IUScB030806
	for <linux-kernel@vger.kernel.org>; Thu, 6 Mar 2025 03:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mp/6YXxA65JIhOvOJKohYGo0S11I79RtwIma3xS3OWo=; b=BqOlPHxo1eU8RaL7
	AgemsoKD6fdgK98jr7xgjnraAnWZgusgB1wv0VuvpKjEsnehYSFzoSFhMOXhrmm4
	2Ixsm0VlzIrw3Ed41hdDR/DlOpy6tZtCs2HelB9Cfy/iLTvpbUROyvLmx/5hC+iH
	RDQZmfVBJB3UMySDBFtm4PCShfzSLJofRL7A16JuBShqrlZjCMT/xgHYFxm3dF14
	t9Gpv62krCmTJ8/H/D1rR0bnpZ6YblimzHBIj5NS/wfg0BbPtU6omSRb9wKIRAcX
	gf7fdDDyMuQ1/oaZTxuxenKqIjBGLnN9nruDScJeswYE49YTXGwN5BjOI+Tp+BSy
	6GK2VQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 456uy09845-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:51:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so520804a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 19:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741233077; x=1741837877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp/6YXxA65JIhOvOJKohYGo0S11I79RtwIma3xS3OWo=;
        b=e4sLfkBTfqEO5f4tFgKi08sHCty6lJSkfKHFDkjsn0xLMiA43MMs46MxVAqix5Lrfu
         85hnv6+aUzt79qn4Zqn1hYyDtKt5X7a2ys94FUJ62bSKeFRI2RGSeviTd/DLxnig5beP
         azl/cnLeZs+b0Dgyys9KX198PrFOrkE23gYw5ReUiQrAxb/9dxHvDyc0ayrY6EvQYNOu
         uo2VO8BdXU6x4ASqrfMD4NMmn4sjYjj30a0zDnzxuN4G42mFaYcmjenD2Vw10BBIBJHg
         nNrK+ml4p6jiY3wfI9DQcHYa0NrbmLfsOZ+nazaFQrUsipEjkoiTtcpYVncrKiNQ3+vP
         T3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhrzEiKIltMTzlH4SMdsNzPJU4YsxgY/jFv0vKQKeXaPlz5NTXmqHNpQ33gEcySwcMNDCTBIl820Px5VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/F18s1qXnhrLRcDZmQIvAf0k4PqZXCQAX9FJu/okHtG/bAy7
	4hf7HNXZDgwK78zMCebtpUrU9dcrbp53Q32qK5ZEMUe0Amxf534YZpEa9zXCyi6iP4l89FjZ/SY
	BMSyTa32EfnQc3du/mGRrMQkDAtxl6F9IxVq+NeE+pz16WCpGwTX6PyxIz6TQ97Y=
X-Gm-Gg: ASbGnctkcksv1mC2sRYwcqKBLqzG01st2NSSh+4grmT88a74/cSo/afjcxo5W4pP1NH
	qQtNQSuC2rBtZoOxDyifoPUjoNbYs/YtHFOtKXxWVMQs3PiE4iTDWDWrJ/NMye4wHIqE4zT0PaY
	Tu0SF+SRy/xAFBtow2DtE7evByzTABI9CoPACNK8bqRASaX4FuqAhktYMGNWzfx5BEM9epQa/y8
	IyWv9s0p/QOs3sTX7ETamw2K5ziBH/V9R+T54ye53bwpZuhADOlncvtxwpUtbzPu0dAQDq8wtsg
	0hs9gxSw5GvmtuJFTjIAY37UKelxE4aouoyOzKpuQcPcOSsk7I3STnZNLQ==
X-Received: by 2002:a05:6a20:2444:b0:1f3:2a83:7548 with SMTP id adf61e73a8af0-1f3495c01aamr11494978637.38.1741233077599;
        Wed, 05 Mar 2025 19:51:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXCFBh9xo033zrGhysb3PJP32S0ZetoTc3J6B1zaxoFsgl/GvE1z20/MNB4ugW5rmtFHNnQw==
X-Received: by 2002:a05:6a20:2444:b0:1f3:2a83:7548 with SMTP id adf61e73a8af0-1f3495c01aamr11494943637.38.1741233077208;
        Wed, 05 Mar 2025 19:51:17 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698244180sm256743b3a.63.2025.03.05.19.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 19:51:16 -0800 (PST)
Message-ID: <d0433fb3-e8f6-2f5b-6c6f-490aedc5aee6@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 09:21:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v9 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250305185501.2400888-1-quic_rajkbhag@quicinc.com>
 <20250305185501.2400888-9-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250305185501.2400888-9-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Pq5pbxM3 c=1 sm=1 tr=0 ts=67c91bb6 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=cKnEvPqYOVkaVG8RjQYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: COT4vVXhXXnTlOUSlqUjqSHHbeViqJ16
X-Proofpoint-GUID: COT4vVXhXXnTlOUSlqUjqSHHbeViqJ16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_02,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=766 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060024



On 3/6/2025 12:24 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Add Initial Ath12k AHB driver support for IPQ5332. IPQ5332 is AHB
> based IEEE802.11be 2 GHz 2x2 WiFi device.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

