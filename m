Return-Path: <linux-kernel+bounces-372354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C09A4792
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9481F2531F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EBD1EE00E;
	Fri, 18 Oct 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EwqrS7+a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7BC136341
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281779; cv=none; b=KXXMsfTll+9REmhXMHF6NXudf+ydgwu8RiuAuewCi9s5CTGcAfp8cf0z14UQ2ZT6HyjHDW3h8Z1DaKOvgcuPgf1mW8qsAk/cf7ZjIPJmeI8C+ZkkDbKAHOhrKd+SzJKOHWaWEzLD5gKHXdRU+6m6gHsEkQ3wPSVxxKKmeSg4EnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281779; c=relaxed/simple;
	bh=dVrOeP94PHqetoQWXoleKeyqsFQ+lb7iRtbNwKsP2Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhsVSbc97uP/g+qvxnS5IrsGfEvXrN6GFbYYyJo1AInW5S04EmlPR0FHA52aPu2vjLvHkR/tfEox9ft/I1fymjM3BfBNzgK6iuvBCUdG2geEN3OdMe4M695vmZb9WkMX0r+Bv9OHNhLhK74dsi2jVCRroVtVJwVGLdDAh+FNPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EwqrS7+a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEVE6U029350
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jx6vsuVGHXJGU5w+/TtA7rM96sThZzOTxbF75866NM0=; b=EwqrS7+aTUV8IykZ
	qepzet2k4oN8wFInCPENqEBBxY5YcaFcNdkm1nRC2b2Fra9VxzxqyExKkZGGj0Uc
	KG4j4nUCpq+jXlssNFkyWPi/cpm8SPQb4QpPpcm1ZPs2wFKw+j7YtlEbxiYC7srq
	UbreOZcT+4GI7wgWC6pQBUYrM8kcYi5wJ/RE6ZTv6KUJMQHQzxaRzBLy29Wn39TG
	JxbcgvVbucuH6P5Tv12en404DShcyyH4ZR5zazmmMBwa70UzhfRQpOmLDNI2pNPX
	1Lle1HsuJKE+ycWiOQhkTCm0k59MQLK66KvryeijxnYXRh3ihzHYESziGXsR5G24
	wI3qsg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bhbqadwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:02:57 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3e5f7f48d6dso83124b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281776; x=1729886576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jx6vsuVGHXJGU5w+/TtA7rM96sThZzOTxbF75866NM0=;
        b=KjtA/tqU4N4vcRnIb5bvCRbtVlZFGajp9Ruln4t0+3kM6qnMWBQYeQ6NiVnHrwQ9Iu
         CKoBW72h3QaWKUXOU1d/FTfU0Z5w6aAGo4se95/SMZ7AUC5o2GBZDcLHNR53sRWe+9x6
         1hp/sMkeNRjR7D07HsEzve+P/0U+mws8KRNWUO5aicDzlRIlY7tdj2g5iL6JEk7VcU/E
         ljIE+BKhBb9dH52gH9Kq06fRWfwbJDixGJpuJ9hoFLnL3OCbrAJmygmBQcpamv3o/B8T
         bmgTM0ca+MCajNgF2A4lf20ogNz8k0z45v5QQoRGDMN0PzJnsTGtI8wnmiXUS4UxYYDQ
         oUDg==
X-Forwarded-Encrypted: i=1; AJvYcCVVrWBvWv39HFwGI6cf46EvjUXxJ1kCF7h5LRu5xKxgQplDoO7lRSCA5iSrA0tmue7lPX+bRT58DGtYbZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/IGb5eXQDxLm7tBksTei2y1PSgFMdRb+mfF0YX0ce36+Eglb
	mozTb9Xd32x09dAv63Yhq0CnVstXxPwZEG6pD7pcS/XS+5XUdBdgeKz5etzkfRMnYBzqParn9gI
	5EKRCdPhvynSb+GHyj97dM+OzUVCBSI6DGd8a/qjY/7O/WnErfnt2gC7b81X48MY=
X-Received: by 2002:a05:6808:4409:b0:3e5:f2e7:e093 with SMTP id 5614622812f47-3e602c7acd9mr719866b6e.2.1729281776527;
        Fri, 18 Oct 2024 13:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9G20t5WM5KMGCFTj67wFZBllJeL+g/oeAGC8Zm/OLBjdLijn7LmX6TYKFdPw0dW+W09DeQQ==
X-Received: by 2002:a05:6808:4409:b0:3e5:f2e7:e093 with SMTP id 5614622812f47-3e602c7acd9mr719860b6e.2.1729281776162;
        Fri, 18 Oct 2024 13:02:56 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68ad4fd7sm133149866b.72.2024.10.18.13.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 13:02:54 -0700 (PDT)
Message-ID: <af289022-218f-46fc-99c2-3ccf027bc8fe@oss.qualcomm.com>
Date: Fri, 18 Oct 2024 22:02:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/22] wifi: ath12k: fix incorrect CE addresses
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-13-quic_rajkbhag@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241015182637.955753-13-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EobHBb0_CQOGPw6C3bV93d1y9I8eON1q
X-Proofpoint-GUID: EobHBb0_CQOGPw6C3bV93d1y9I8eON1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180127

On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> In the current ath12k implementation, the CE addresses
> CE_HOST_IE_ADDRESS and CE_HOST_IE_2_ADDRESS are incorrect. These
> values were inherited from ath11k, but ath12k does not currently use
> them.
> 
> However, the Ath12k AHB support relies on these addresses. Therefore,
> corrects the CE addresses for ath12k.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---

This can be picked up independently of other patches in this patchset,
please try to position such changes at the beginning of series.

Konrad

