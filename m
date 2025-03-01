Return-Path: <linux-kernel+bounces-539793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46DFA4A8B5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FF316B7C1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3251C1AB4;
	Sat,  1 Mar 2025 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKxZAF6u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AAD199FBA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740805943; cv=none; b=iSB6TCIDWfEDQiITm19r9Sb0EIS0xijzAN5SJxg0XviUmgL7RGQO5FJxrOwmZeFQ3UJyclBn/3NVdqiwuNM+zLVpJlc7wvGiA6/EO6mk2LZPtLBFmJuvpRCHd6/CMdIrQm+gd8aHteR3tnbWP5xwWC9jhoseXu1OeKXcSMVnnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740805943; c=relaxed/simple;
	bh=XEg3iQKd1ihXw7OmlC0O3eASArbsZqE2yVZeIHi/Wgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThXIb8v9uuqLEbvy7tzJxvRgTCy6aMC2gfTnqkUR6ZPQHcBIyqBM5yxFcHNMBwgPREMIajB0pjIDi7gyPpsB9REkDPiC1aEcl7X+K641SO97/kwfyTbrjAVImN/BdtV/v2zBd1ob+LbVB9R/eX4Mns3+BhX0Ae0/7N2QenRTgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKxZAF6u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213jdWr026936
	for <linux-kernel@vger.kernel.org>; Sat, 1 Mar 2025 05:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HwbXktj+6mi4SemWqhem10JT4Tczcngjmcp+vqZ/MjA=; b=KKxZAF6up91NPG5+
	L8f78T1XaDt1ux2Ft3kJO4osI7CuKedQ6GXr1P3Nc9MRDlNOgvzJle+0EPV592ga
	UOsdomi2vUgKO3q4IgKl3bT/EykiQaC0g2vas0cw/5U8mFVC11PFgU+MvVNYDNHe
	w2ivPuk4EJh80zBiFpVZF7AFqb7pm1CRvPYga3nLyzqLvZ6R97PSQvGc8zsuXY+T
	IA3mf36CxtHmzy5nRzO+pVWzZ70RhLm4a9PmY1a5YTJu6beBuk/UNAP5uRah/ALu
	elARdzqQovxEDXRwrH8RGgvi/SkbmOTbxVDIc7vlXBIb/8QVvDzinNbjw8CgU4V0
	Xzu3sQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tm5g42a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 05:12:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fecd603bb8so1537946a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740805939; x=1741410739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwbXktj+6mi4SemWqhem10JT4Tczcngjmcp+vqZ/MjA=;
        b=FpVHGvw48thsvmR68KIJg10AYmdtVejAVqc7yADkiRsyltxnTL9pb0TXzFs0tgkYqW
         wFVLROV6g29ZIyMS+eOljhkUPecUfeCr9Kxy2TQVD2bu4yJYFNf3xiSblVbK4nw+qYNv
         L1+k/dAigcAL8YxxE64ifyqTHhObc064LxVtgas3i2uczvoxGbDBHxO+V4Z1hdP5+6IE
         th/tsy6qhaZveBR+CV5EvnaCrXt9FsedYVKzKOvu5mgoKqVOoIqCfuCUD6pIMuxenJnA
         ZaNivk/TV4CKjZ6IaGZeNgn4bbTNaTBM8n2962XYZo1xSr+abcultMWWFF7HV5T9QpSw
         /3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVBmQ+n8cEXHlCEwFJhxEWzczL6kqG7OVpIS784sEEP146PEX4xRKHRS2RyjTNywLUXPB7SaRTAQIJO21o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8WiGrGhdzg6sie2QK1nkVcY0jh/cP9wwPxOCerUWZCAEQrHQ
	Nqk5hPkSgLGOgdOh+AznTXE4Wyl1CkZINrwjwZR81orWD6UGNBc7N/8lndKG7AqL8VkAWlZKMIo
	gEekQSbWOZFjqmWTo946CN33tadIKZwuSR+0LL6ZYUzaBGpdVk8SmK1iTB9Rc8O8=
X-Gm-Gg: ASbGncuq3dt5nIDNxXmXOiiFryU2q8Nfil1jUDz/+JNYd7/lvhDb3yBtrHxQupnclML
	p2M+gzipBzB5XpZZkyTnCaGwWteaR62rE+ci5on3vKt7Xouwl31QBTFjf28wxXjjmVq4WFXPY8R
	8Rp5RYkM2QV5pR/gbfz/L2zJgnJcLcXwpNPVbCKpOiNpvvImI6u9U1Ht+qngxKOaBQdkgX/mZ8o
	5kW/lKjCycVOEItA2Pbuu/uO654cIXM2k+KM1lBWxl9uGAFV8pG0VeQ+o2xKVHT+CrxUgijch2t
	G4tW3WQMIYRiYypE8gSS5XOovaPzJlHisfiXjo29kE7+Ztzn2GwgHc3ksVJsh6I=
X-Received: by 2002:a05:6a00:995:b0:734:9cc:a6e4 with SMTP id d2e1a72fcca58-734ac45bb10mr10116352b3a.21.1740805939587;
        Fri, 28 Feb 2025 21:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNzhrvUe1zqnZTxnuKOpo4LZGceKwE6AToEOzijs/WtCX0AmWj+wGbHbT8EyJflTzKTDpMSQ==
X-Received: by 2002:a05:6a00:995:b0:734:9cc:a6e4 with SMTP id d2e1a72fcca58-734ac45bb10mr10116328b3a.21.1740805939214;
        Fri, 28 Feb 2025 21:12:19 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0060037sm4646386b3a.162.2025.02.28.21.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:12:18 -0800 (PST)
Message-ID: <d6d9c015-e554-d821-4729-9e67f1fdc6e8@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:42:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 06/13] wifi: ath12k: Add hw_params to remap CE register
 space for IPQ5332
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
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-7-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-7-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NiXV-TTSmtjw74p6lvKmoXM-bcXjWjhI
X-Proofpoint-GUID: NiXV-TTSmtjw74p6lvKmoXM-bcXjWjhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=987 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> For IPQ5332 CE register space is moved out of WCSS region and the
> space is not contiguous. Hence, add hardware params (ce_ie_addr &
> ce_remap) for IPQ5332. These parameters would be used by Ath12k
> AHB driver (in subsequent patches) to remap the CE registers to a
> new space for accessing them.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

