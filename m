Return-Path: <linux-kernel+bounces-426231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065EF9DF09B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2CC281869
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C3819C55E;
	Sat, 30 Nov 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VK10XMiY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1E19307D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732974193; cv=none; b=J/O5/pC2QRTWjQ5KkJCxAoZ4rtmKlbWgT7pl/BQJWz/E8pmq4KIrqXUVmm9BqdjFL8mtfq5CvGrmA1fjkI0lHyvVdocLVuvFBoSg6QaSMmN4Wt4RT8/NpqUQjI12ZBzJJ48WWcOnBzWTDqPUDbm45MYUKANamshxR47hCQ6jy4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732974193; c=relaxed/simple;
	bh=grBrgWFBcLUOaiRSE3/edYKfFqN2iEQy2qQlclkTI4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ty8hOp79fLGULlPMBPr+RLDXazpl06BN9/WUo9tHCxYyX91YtTmnlT3zXfnUGs0Pf2hsS0Gar3oKIeRY03gt6EXCYRzqUlqY4kA9PTY191YbU7gXvxahJiuyz5JYdPYP6TxJox1YwVVlWN29lnjaVpgHQT/JcbY/V4F6tRLaBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VK10XMiY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AUC0lSv030874
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v1hS0vcVSga+NYrQR8U/CivFXM7UEZxTji0ocr8yqOk=; b=VK10XMiYuCXFjxS/
	eAqZ3dfXq8qKyu/rrY43Y3ZJGwx78ZoIRWSvjMImoJBcRwDnYUHHdSnYmY3cxY1I
	m23ZYB7KjmMjCZd/tNlJV6noIHfJ+ye6BUaGXFzKwnJQLmAeYdch6ngUwrKjJXkl
	gjpoFyI2LXrm45kut4peL6cHb7E9U05B8db3gn5PpXn2PHedymU/4xDuSNfSdLx7
	podsbl+zhxffV5SFP15AmV23vqyXqeF0zJrFeX5mTDf2Z7FnsHsT+lxlERER3WYa
	mA8uL5Zw4o7XqBA0wAa2e3r5Sh9yfVpTzOvnnSh83qpHAyU35E8hOW6CArRa6PnX
	BtxL/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437rde903d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:43:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4668f2d0e50so4523731cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 05:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732974190; x=1733578990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1hS0vcVSga+NYrQR8U/CivFXM7UEZxTji0ocr8yqOk=;
        b=SZnqp+TtFwjxKbA79gQwCe1KuTNwJbECdjA2DZpsUwLqUbIK3UEF2iNC4Gf97y05w9
         Oaq6acUil//aM1crHw/birO3zftl9OgMWSaJ/du5HJGBDOvfHBrHrw8CKRe35TTcya03
         2C5uJMRzYwrBo+xqDZUvgy2NXJHmobsUB+92jkFNQiLVffFARyuf5XHm+XytSPUBWRva
         vQX4CaSF2qpXR15OGZgkDFoOhI08DmseKim8KOITUifIHL61FkHvtwJMHnDhzqgXMqFb
         MSw8//B7UYLjWI6BHNzE+OFUhmnmSEq6gfEmNU1THwscXQd1G6lPCUf10Eeb2DZSEiC4
         +3mw==
X-Forwarded-Encrypted: i=1; AJvYcCUgvNGtexCfWZSRnPBWITPNCdsWN7jBP4dDZGvBOpt63Zc64yrgUwtkXsJkYHAOrP1QOe5BzOuWUGrhbbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ar4/KoHLVQ34M9S0K1cN94YrRpFRGVSpC/NmDY7nZAh+0BKT
	VAIrig5NOo68IXVP/7lGihoobvZeXcdfGVblKar0PiR+def4Lw1wYcSwwl5QE+EDW1N8BFCnfGP
	yvKPQOCUy/9wLHcE0CeSjtTyI3Tcrifw/nZ6KWNUDGeRDWJFKgrrW+pALteP7o4w=
X-Gm-Gg: ASbGncuFXF/psI4XMHWt6mZSisGqNdbcf5XK8rAZaJHE65jzxuvfpAkzoYN7ZZqYJBs
	/ljlk3YnwcCgfXNKxyr7JNp+WSp0CJ4ddnLstT4wfARMKQjanX5uFMC0ZBcEHOICcJjUfYXNdbk
	rakhIeGDUH+l5YPdFHWrbUT5BKOZV9jGJR99TzcHxjgSQ5s+rNWFiGfUUSaOuQJt31zBSgyPO/H
	krinT8ni6tS6whVrx8XoObO/iMWcg4FEx0E2WV9blfKtYHSxVYqbbnwxM3g2uWxHGz+Ib0dTY77
	ewPuQDXuSh180+c6hlgYP/iyOtimTGQ=
X-Received: by 2002:a05:622a:19a2:b0:460:9acd:68be with SMTP id d75a77b69052e-466b34ed7b1mr95186541cf.5.1732974190127;
        Sat, 30 Nov 2024 05:43:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdQkV3XDgMM42xOm0M80R9Lb5K62gj/42Xpq3XSJPAi+a1WhSXxCbcCgvSEKn5dX73E2jDew==
X-Received: by 2002:a05:622a:19a2:b0:460:9acd:68be with SMTP id d75a77b69052e-466b34ed7b1mr95186381cf.5.1732974189776;
        Sat, 30 Nov 2024 05:43:09 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59994b837sm279071466b.176.2024.11.30.05.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 05:43:09 -0800 (PST)
Message-ID: <7dc72269-63f0-4370-9564-e329bf53ea66@oss.qualcomm.com>
Date: Sat, 30 Nov 2024 14:43:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: qcom: qcs8300: Add ADSP and CDSP0 fastrpc nodes
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: quic_kuiw@quicinc.com, quic_ekangupt@quicinc.com, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241119120635.687936-1-quic_lxu5@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241119120635.687936-1-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aaQ7JcjSp37zhBQgiTrdTI-Mk5EmyYxq
X-Proofpoint-GUID: aaQ7JcjSp37zhBQgiTrdTI-Mk5EmyYxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=699 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411300113

On 19.11.2024 1:06 PM, Ling Xu wrote:
> Add ADSP and CDSP0 fastrpc nodes for QCS8300 platform.
> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
> This patch depends on patch https://lore.kernel.org/all/20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com/#t
> Changes since v1:
>  - Remove duplicate cdsp fastrpc nodes
>  - Add adsp memory-region and vmids
> Changes since v2:
>  - Remove extra duplicate cdsp fastrpc nodes

You removed effectively- duplicate iommus entries, no nodes were
removed compared to v2.

Also, I hope you gave this a smoke test, as some platforms in the
past had very strict sid/mask matching policies that didn't really
evaluate the effective value.

But it looks good now

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

