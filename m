Return-Path: <linux-kernel+bounces-574673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5091A6E858
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD8316A9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CB18A6A6;
	Tue, 25 Mar 2025 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhG+Vl8E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB65228
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742870085; cv=none; b=EBMhQ9l8ywlbX3D2WSNzBasUUl4Ewusr99PGARuVbXOW18XPcR/SuvQOxf+Ctmi+dHNezjVazNt64m665FGIjwzrKnp+ZdiEhXm7qRMK+J4p72hkV8qZVBzaLtuQkpkhMWqbKI5/cJTEQrdLrlW+DEurL0G+uYYR4s2JDg0VGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742870085; c=relaxed/simple;
	bh=KkQuSB42EopfbNyPJrFi0ehp5Zybb7jBsTcaVYmizz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYXWPkYoRvX87ja9UdbmdTgc/ZeGpu1hWR2UvHep9kDUHHVRY1HPDgOsg9Jqa7mkZY4j/1RXxbn7ytni2p+dV+mEJPQQOv46IBWeX6EII5LXeZSuaQSNQivWo+U8L7fS1LoRB/b3SBmOfAss+NZJZC4W1OuDBzwrLza1uMJ8uOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhG+Vl8E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OIjaSE004243
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gx/bcLzLApCrdO46UIL2ys5ZobL4CJdbfiEVJVfa6F4=; b=RhG+Vl8EVG3inXdk
	0yEfwdwx3X8LlqrB1zyFv+37Ym4ZIZ2U2jhbi8T5v0Yw8jHyVhcx0WEWTfuHT++G
	US+7baehmnLospdL89Xi6FDyQaNOp8qy/akvqSEl3TgpuiEnpByXY/c3kEaYMAqS
	bcI00W24jDadXE5TxEHe/BiM5sUGSViZtK96NCZXtwKMhdqXe+I8gEfe4VKpHHK6
	23pW8eC0uQJ8YFJmqOFM0tPDCmFhU2SSBftjHsccQ0v+C7hGA2qK27P/ZP+Vf4Zh
	+MMP71sHZuGLrjcQ8u2XtvjCcXHIVj9/NbMKNFIlIGWdQlNObUzZrn6pHyo92+OI
	LlFeeg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnk8p8dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:34:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so7934776a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742870080; x=1743474880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx/bcLzLApCrdO46UIL2ys5ZobL4CJdbfiEVJVfa6F4=;
        b=oS8Co20xGHJ18JpTfdJxKEslz5yLG/E+jqihFgOuiZkOtBVrQOn5ZAB/M2mJrB63D6
         6wNB73BLw0fAbSlzFjWx9HZbSvZvYqHxa0vF8h9UWvcrC+fXoytbd7QqNfUkDAnbjYFG
         32DboEYjkBTcfhHHqH7r0T+HjIR380GtWwQkqoFPvb6A9bH8ewRzs2gk8uW8vTKTFTPJ
         RiwwtOv0cYCVpqx3jTUe6WEBCKySzrGClmsmEMqsGYfxIKLqbWBwpyEiFBRGmG5gwb2R
         93G9IsRVLN2IIi1qb20ri2TbvuJvIFKGPQNPr6oKwf/i3vniDYrmwqJhg2BCwNU7E2be
         8DLg==
X-Forwarded-Encrypted: i=1; AJvYcCVJiB+idiVCIr+on5QKh2uC0Tmbq21UdUOmDI/g9jiH1gYSjALIPXqohsuuGH+BrUyn0s67tnTKzZG7ubo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2yJw/NonqT37Pc5pioOl0WNISRmAQ7DCUCue6P3g6GhywAErT
	pquX8fmajpI65BbB5XmDTsIldTVFVo6uQ2JgcTYZodlFnCp6E6TXjDB/S17T9mIwTUd8eKb4PNl
	VdTxT6E3ShZ9j/yvEreU2hR+ydjj2Qwrm7zySmSgeIMuqW3Q7ZXJ0nX9cdwBQuwE=
X-Gm-Gg: ASbGncubLGEthgpKf0aEg17a4P1bLRY6S1tbKkRqBQcCShJLn60sZXjRqD4+IcTbk4A
	IfFdGeyjKMhea/oKx3nQwkgxZCro3IIGgAe8KEeHWfrPGo1R50erKrb/zKL6r9H/c0dBukTDbHY
	VxOv3APCyhS3Hvlfn/H0Elh1MSCNgjlSNWPTEW00do6FrTo4+tGvUM4DmfyxieZIUQqjugjyjj9
	yzvk5vuuWY/SyETFQ4sSOWYvDZynn/MB+gnDNpi/CkLGJpyDYagNYjffwA4dxJY+4fTQqiFg0OS
	og+cjxURc1/pEJUCZwA/+ccDvjZ93yOuCifu5dhDfs7Q4K++9j3+KKg0k9CQ2t0=
X-Received: by 2002:a05:6a20:430d:b0:1f5:8d8f:27aa with SMTP id adf61e73a8af0-1fe42f08eb7mr23764440637.8.1742870080243;
        Mon, 24 Mar 2025 19:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAAi+oaCdrO1YOyjbRYM3m591RUcKPjvpOZnwOZMak4jHmmX1G35XNMN+4j8+y0CsAIx8bLw==
X-Received: by 2002:a05:6a20:430d:b0:1f5:8d8f:27aa with SMTP id adf61e73a8af0-1fe42f08eb7mr23764415637.8.1742870079856;
        Mon, 24 Mar 2025 19:34:39 -0700 (PDT)
Received: from [192.168.225.142] ([157.48.120.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611c7e5sm9157000b3a.99.2025.03.24.19.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 19:34:39 -0700 (PDT)
Message-ID: <807477b7-aea9-d4f6-6d69-3b5eae272867@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 08:04:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v12 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250321-ath12k-ahb-v12-0-bb389ed76ae5@quicinc.com>
 <20250321-ath12k-ahb-v12-8-bb389ed76ae5@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250321-ath12k-ahb-v12-8-bb389ed76ae5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UxmhTCCUuQaydRUMEH99eQ_5TOB13PN6
X-Authority-Analysis: v=2.4 cv=KMlaDEFo c=1 sm=1 tr=0 ts=67e21641 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=XdtSFjId9hQakZAf7T/01w==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=cKnEvPqYOVkaVG8RjQYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: UxmhTCCUuQaydRUMEH99eQ_5TOB13PN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=768
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250016



On 3/21/2025 4:22 PM, Raj Kumar Bhagat wrote:
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

