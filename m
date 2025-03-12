Return-Path: <linux-kernel+bounces-558092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2BFA5E192
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83FA7A3574
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF01CD1E1;
	Wed, 12 Mar 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E5TmNG+C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FED1C5D50
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795968; cv=none; b=tcSvcxQa1wizEAWcIotKuj1BPYF8Xdn0eL3FHNPnDleyzebbtSW9Ax/uwrRdmvrOPb095HscSmz1XkMB4xmOdaFGfC/DMw+PgP0ujXeGT3q5k/6xJ+tWIcwB68FnVf1lPDrfRoHFILrXcJJN37gARMwuB9yhBAA5+C2Pov+R04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795968; c=relaxed/simple;
	bh=6hd7rxQEJBRWkVWtNZOc6NGDa0MS+r/N/ofCsnrZ8og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQQCv3xIG2fs09539H/upGVsXQnXHih5wmsCYuDqcp8LDHslCx0P3bogf0eQ7fNyavnr6Sb8ip7gnmtHwoSti6um5SOrENxd3m0Pd4/lx9zWZkpgZFAVuDw5fmUE5lPacu/beZzkUs4jbwC5qnjfaF/aGlfpgCs62bx9P4YckSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E5TmNG+C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CA8TvP009129
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5/1RpKzdOYchhjQaev+P+46NhEzCeI0XyMwDm3zJ9dY=; b=E5TmNG+C6u2U1FYE
	+CQ4/JBMxaC6/1/IOuySdpXR7Fovbga8ccSb734PFH6QFPCEZzDGC3GC713ZzDX4
	USIKR4tVqNaUypum7kLfdLsqIoUJS1UWdm1DhFRwqiJeiNNgD2EYIwmYorTnfOc5
	h2E9lVNkkxsI94lg8WBXQVjjTbd9HnLlrzhntl99fmIBWtZ7y4Az5qUioCf/1Kyo
	JJ5VSbNQgnw7bMElp/e7crO+FIqKgthgOu3D+SMAaewWTivYLe6HXifRhlxpkpvR
	Xpq+gcdptdXcX13Q14wZNKaS//AxiEFUDp6CadDqWryPMlAjfkcuHUHugx03cvq/
	UIYGag==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2raxwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:12:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so99365a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795959; x=1742400759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/1RpKzdOYchhjQaev+P+46NhEzCeI0XyMwDm3zJ9dY=;
        b=V4YsziB9MYpdRj3ZAcMvZ7qRu8hnwmXDi3wVmS/Gp3jwuEiuc4QmFmB8FDOH7NBaOP
         KHXobUaJNmwXSFF7FdTqfH84EK/pvWX6Ts+e3Kgy0vQiC0qSx45tYzdfgTQdZWNZF6DQ
         CHKyi8WnNJ0IL4hk+ZTMBLEy7R/GygZJO11/7ZwuVlSLsPMAE4y1h0k2ZbfMWb0/hlJM
         XvTSwW32K0HsJOXLZlS6qKKm8BNjZ2+GvZCdMihcSabWLzjqW4zyUrGxv6ATxAeleb/A
         ybSwhaTYqkeTE3xuvs2tgoDlfAVpCy+ixtiunMzJLMTSM2+ajmRJHSd0ykncmSdEpdIs
         eYuA==
X-Forwarded-Encrypted: i=1; AJvYcCW8fZAr3t2rDqG/cW8YD/IMnNtk8qn86TAYnhyuz7dMHITQAwyuGwqhfQ/FZQ+h8XPvodhdEknA8JeMWeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnG4i0whpcksJdEZWAKBfkrRCgGTRK0NkoOb1/HnnEnMkcIm+a
	g4WUScUiuKH1Cv/9ZsLpjez+KezTYMNXTEsWRsG8INPuo/V0gPiCyYGQjhGnUaNrT5hlk3Jmr8A
	OWunj+H2XrD+5/QC346YgLcMhlWIJUcm4qfmlrDHio+M+VgDuO1CQRD9vK4rqb75kFhoyv80=
X-Gm-Gg: ASbGncvj9/v0QbRETNjjuNIWbu8n28dpBax76KvM5w08rGlzOXJPOhGOYJkErSpJXWO
	YetR3Zp2WIVFG2CT1LetyP1YZPnvwxDrIqPqPPBv+hnjJoFU8VF9o/UFkwFdKDfPOlwXcgxK+T9
	I+NyigAQ57KRQKC+8PefCPkQfIcMo9AMZ9UJ1sruYXN+ebNvp1SyGEUdmcJbowgc7YeOh6QMOG4
	aFVXCZmrLyS6MOs+m/ldm6K6l40aTtY4zBLi4IMMiItLVtTvcys8134+FeFSkciInK8AmEnXmyD
	5pn9+MnqqyvMyrU7yba3jXhCQ0dWcCiXzKorl4wuU2bm+JUE7UScpgg3cw==
X-Received: by 2002:a17:90b:38cd:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2ff7ce8e5dfmr33019614a91.11.1741795958681;
        Wed, 12 Mar 2025 09:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsJrVBVvsHyhb69yiGojX9yNVwRl1fqH3O7J84B34D/C7flq2CKu0AwOv2Jv9wq0SwKWnDCQ==
X-Received: by 2002:a17:90b:38cd:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2ff7ce8e5dfmr33019572a91.11.1741795958249;
        Wed, 12 Mar 2025 09:12:38 -0700 (PDT)
Received: from [192.168.29.17] ([49.37.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190bbd78sm1984931a91.39.2025.03.12.09.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:12:37 -0700 (PDT)
Message-ID: <282f1470-bab7-4f1c-8ffd-a6037736489d@oss.qualcomm.com>
Date: Wed, 12 Mar 2025 21:42:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: add reserved memory region
 for bootloader
Content-Language: en-US
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20250312094948.3376126-1-quic_mmanikan@quicinc.com>
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250312094948.3376126-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D6NHKuRj c=1 sm=1 tr=0 ts=67d1b27c cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=d+lWxUpqeNYAcJEdQAshKg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9vFMFxKz7TJhonvdC4kA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xRS8MatvddJZXKHApRX22KOda9XJsvT_
X-Proofpoint-ORIG-GUID: xRS8MatvddJZXKHApRX22KOda9XJsvT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=499 clxscore=1015 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120111

On 3/12/2025 3:19 PM, Manikanta Mylavarapu wrote:
> In IPQ5424, the bootloader collects the system RAM contents upon a crash
> for post-morterm analysis. If we don't reserve the memory region used by
> the bootloader, linux will consume it. Upon the next boot after a crash,
> the bootloader will be loaded in the same region, which could lead to the
> loss of some data. sometimes, we may miss out critical information.
> Therefore, let's reserve the region used by the bootloader.
>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Reviewed-by: Kathiravan Thirumoorthy 
<kathiravan.thirumoorthy@oss.qualcomm.com>

