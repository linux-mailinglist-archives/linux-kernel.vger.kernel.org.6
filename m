Return-Path: <linux-kernel+bounces-444085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D839F0092
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0BB16B935
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13D1DEFD2;
	Thu, 12 Dec 2024 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SBe17nea"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29201DED45
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734047749; cv=none; b=CmmZyodLlIB1Eua6dYLSx/PKmq48vXRoCh0cooLNcfBHP8rrgjVRUtCy6JugpE1aLCcJtvoCmCpSZukTq/oqUH5tO6AVghzivJjK5JsWwSkuwSB/74qLBfPyMKKzHHA9iBNtdjA6RObgFSODVMQrdiE6XYReFGhXR4lSc/SDrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734047749; c=relaxed/simple;
	bh=oVg0v3rHyXicuVAXamNoc38i97c4urG7OffM7x8JcOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms5e0OHr9XS1XpBhsmIdSdWU3tglqKG5B3eLvFDoy/x9v3EYCflsP+qXtJm/c8uvAUKANxiC50pRzBGEPhzZgzrwcjcE1VMCmWwitM9hBggSpKhYrVq14Oe/4EC0ptp/xf/IKjC/d8SdjrwZd6ZIWQ3AegERr/Tv5CZ8RvOAjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SBe17nea; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCNlbvo028140
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oVg0v3rHyXicuVAXamNoc38i97c4urG7OffM7x8JcOc=; b=SBe17neaYoTIezHg
	npUBn4agpIQUbGmWUBmnVkw+uFrCxgC83JXvtj666yVLxuJfkCm+zwAJDm0V5fw4
	vnrKeeRVB5n13Bnp11wP0qSwxB/Pv61gl/ijNcglqjwZB8VDf2Dd2CBhBz93A1dp
	pLemcOHbWDwJJR/zT0wt27e/piZdLfEu61TAoxsyBkzuviHWPKlJTboLOz7ASy8h
	R2RLZPTlGluNUkYLn0lNHkwKRcUkiLCzuE1M9S3Ar/NcJLwcv68kptjwk8klNcTQ
	bCmNRofpghb4s6sxfWbB/X/QA3RjwzICXaq0r+4Sv6r6idgwJUKcdRX1/AGcaYwu
	M7ZVFw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fxw4su21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:55:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4678aa83043so2996321cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734047745; x=1734652545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVg0v3rHyXicuVAXamNoc38i97c4urG7OffM7x8JcOc=;
        b=u4wyB49hZPvI4T1vkG3kpgPITLoOzInwpreK5UHZtu6hebJQRBvnrecwsDRGG3nPNu
         Wz+XjBC5BajAxvigdQoWMKETAjMBcyuRW4j2WdqRwg/FepnoRK6N0oG/l6IDfyqL9DLs
         pnYfqVz0iFcflGe1Iqs6W9TG8ehX2OeLui+DtAv+c3HVjAjzPmNAguRKIIsOuIHvds67
         EHJI+lJ0gQA9ZzhUvK99gV/iSbXFM0ONmVG8zQBsBN4c8riSfXHA6ULKiW95UMSc3qPB
         jCItZ7smMMSpJdwY+fGdbPs22wigu8+FULRVR982rCjL/Pm7+hQ4eq3TIL711YPctFCG
         +HGw==
X-Forwarded-Encrypted: i=1; AJvYcCUP2+W3tScwjoyk6kAKV//i/b0jcvqYw7C/a59L3w0AV9iB3QrcTMDb84ShajQWiEXPFw1xTwKWLC4x5BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvKUHVn2V7nhqU5/CMk27dN3s2Ee1n9TWLI4XWY7opoIL02xx
	EV6uZYHzNpEdxenp2nsvU+hZcv+yGyI9XpqZN3v+SicvETHK9OgNq2nC/94kruaWantb5uApoGx
	avb2ft88QOHDeZXUOQB37o+8j3eB5/vGDFV03X2nHnhnEWkoqacrWlex5LYHC7XE=
X-Gm-Gg: ASbGnctaCLOfYHpgal7RCMas+Wkl34caTQhNZSYrS0bCoBJQugtupcjOgCui86KaDMg
	imGQIuS+Ieo4/8OOCm4131oub6Fr3AtTn9xH99Xo0nue945+ushX1fyo8wJFlVu9uMV2ujnXEfu
	rn7DEpGBqMEfwa/gw4jmZwGS3u0O//BCakpSwiRF1bzQlb/n9ppVwCA6D2uBmBxm10N1FD3e+4M
	u6QvaBJbBzlWjAYue1ZDSb0l1/uGIbq+utpbf17buaWYjk2eG1HoQGKASgALrDCFN5rcsSXdi+k
	wEGjqHUiAongocdNKjZwjrajVKO4vnJePC57
X-Received: by 2002:ac8:7dd3:0:b0:460:ab1b:5ab7 with SMTP id d75a77b69052e-467a5802b48mr3256581cf.12.1734047745450;
        Thu, 12 Dec 2024 15:55:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5IGqhNo+zsFxi3FPjf25AKosCgwvN9y8sOX3gGEAOT3U3/kWq+sQTEl3tjq4dpc5mymI63A==
X-Received: by 2002:ac8:7dd3:0:b0:460:ab1b:5ab7 with SMTP id d75a77b69052e-467a5802b48mr3256381cf.12.1734047745056;
        Thu, 12 Dec 2024 15:55:45 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa65d18510asm861495466b.122.2024.12.12.15.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 15:55:44 -0800 (PST)
Message-ID: <a2f80840-75d4-4380-aa85-d83242db08a9@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 00:55:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: ipq9574: Enable TRNG instead PRNG
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241206072057.1508459-1-quic_mdalam@quicinc.com>
 <20241206072057.1508459-3-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241206072057.1508459-3-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6WnrVUmjC8zXQYpu1RXoNJS78cJ54bgP
X-Proofpoint-GUID: 6WnrVUmjC8zXQYpu1RXoNJS78cJ54bgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=652
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120172

On 6.12.2024 8:20 AM, Md Sadre Alam wrote:
> RNG hardware versions greater than 3.0 are Truly
> Random Number Generators (TRNG). In IPQ95xx RNG
> block is TRNG. Update the corresponding compatible
> property to ensure the hardware block is registered
> with the hw_random framework, which feeds the Linux
> entropy pool.

Line wrapping should be around 72 chars, this looks funny

Please change the commit title to 'update TRNG compatible', as
'enable' implies the functionality is not present as of current.

The latter part of the last sentence is misleading, as both
compatibles do the same thing in the driver. Instead, put emphasis
on the wrong compatible being used and the patch making sure the
hardware is described properly, without functional changes.

Same for patch 3

Konrad

