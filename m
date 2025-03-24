Return-Path: <linux-kernel+bounces-573897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D8DA6DDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D2B7A26DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A1325FA0E;
	Mon, 24 Mar 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N7Q4LOYX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A34B667
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828601; cv=none; b=RvibIXrQ8tOg+efGVbXb0J2YwSN42mjrkTZLCC/eHWi6P5gjbzDe/taFarHS8YKUln57zZ98vU4V2OKAuT3ghcgtQu6qMASIXNzxal1OrEbgqqKrZHR/Xq+HaS0d0TkRPvrkkKiaA1yeI0TRNbnEaaeDkbWXfWeiL8OsSrP6HBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828601; c=relaxed/simple;
	bh=65mc09JnOzcVvzzTPHmhpq+II+Xcs2gKiHWnDOta5Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xza5ELF4D5QRA7gShPaT+DKoWNVsJ9CC5Md8cHMY9W3RujdfyjUyNzJrNN7Wyxz61pwo0VeYY9GdWDRjJmxok0hNpyV3ylkpJQtMLLxVudieIf5l7UiGbyehauIC9Wseqk1nfdHMCdN89IhN6no1N+bJb90aZPTj2VKoXjAKiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N7Q4LOYX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9Pijj007713
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nH4aeoaJ2bY3RhjpBvj4Vxj6NTdJ/AFDG5izM2nQcDw=; b=N7Q4LOYXUuaaVvgi
	l1okrk8+L6tEVc8sAsxHzYetGgDplc1MWqBxjnTEowSOjZEgv8QGguRmkZ05WtYb
	R1mm2WLw0wdrJHTatytur6YWKvL1r2QAFCQhDzhcev9gxk/kEd3tzr63UXa8EMdZ
	ieYH0z7dYOy8CBc/TfrD+N57+pzYyDkYUmiQ6SiBYZP9a0nii/cg/HraHMLU/RqH
	ok3LtIVzOKEwDW1mTNoGn8hBQnnvZQ5QBZHdDWf7pxY8IiDk6l2tgA17k64vtKKg
	dG7c6ezC3oFrXpD+BkUx4C45w6OPZxg38wmz574mWg9ts3f5N1BIrRL0iD+NVklw
	x7Uw5Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnyjcm9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:03:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2240c997059so101758085ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828598; x=1743433398;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nH4aeoaJ2bY3RhjpBvj4Vxj6NTdJ/AFDG5izM2nQcDw=;
        b=hQs35qG4SXGRZy1Wd0ePW9tYl5zpWXNWJGL3yFKRcAuFeF4zwvC2y+064Hcf0eabKU
         bxpsUaNC6GcOfkUu77ADz4u0KdLkqRMosCeep8SblufX0q6o75e8kXay5xr7qu5Fpdh3
         ZG2dA3O+O+QWTpS3uE3ooP7ymrO1BEsMShM5UzRgP3PC8U1yaYkxe7VPwaZL75JkKPEs
         VkwUx6XIU2NhzjBPhHtlCVKmQIMQ6QqSO/V05ryF0PNrX8KOnQIpHUKZ/knkHMvwSU8q
         QojWCanVny6cxCssTAtA4iGtDNjdq42hAvUs6QjRWW/X2rOou+Be8jM2QHd+DhOzbGhe
         ygKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDwlXb+kC0emitdW1THSD/Zou/oUtm17vl/QIpTCncm+DvI8Uhjjs1oAUTHBwX1zTs9d+9QiWL2TbBCvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmSM46EwmXl5G8myJHmQxTQuXVyrsFluBju3IZdBumyEttePO
	hyNw8IuBenu465m9BJI3BARh2FdyErMXAZoHXqXg8uWiBGUGoaOmIBtyTdpMtY9pxzJiOzFsUAn
	tZnqx7tOnyhdQ2S+pwNO0GUEZ+VpPFtieRBs3lnTt/l2urHHCGkbRt3ndUyFf2vk=
X-Gm-Gg: ASbGncuUbQKgGGUjt4W1IG6FOFC3o1ttg7o2ZI4QgrWsig/RC4SWo3zuSro6afR7Uzr
	rnKtZvD2ra9YVaiahq0/XBPlan+1rh7wXFXjHeZb5JbfNZy79sgWCrXR/uWmU6JpoV6oVw/IxH4
	/xl4FAD2My5blF10KIbq9Oanu0hC1Cq3SHJzTIc/HqQPXsomAQHzV/yrNOIvfoT3jCcXVezDTx1
	eLFdJoTv9DxW9OW+fHO6ifFPyNUVWxl5LqeHkK/htvRJIouTcJ+FHebwCvZH9Xza5UWgh7iDSqJ
	XqmIPTFPQvq7xLFF21X7Jpdy6hWE/M8eY9MLcivdZJXL8FOnwexrXkFOMLMqUVth89rFXKY=
X-Received: by 2002:a17:902:f70c:b0:224:c76:5e57 with SMTP id d9443c01a7336-22780e02a4emr237465385ad.39.1742828597677;
        Mon, 24 Mar 2025 08:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH828wzul6klWb3XsCB3+zMsH7vOJ7XnnAtFTDduSHSdwmPgp6DaMF6OMFiOhDbgCT/iquEMg==
X-Received: by 2002:a17:902:f70c:b0:224:c76:5e57 with SMTP id d9443c01a7336-22780e02a4emr237464745ad.39.1742828597066;
        Mon, 24 Mar 2025 08:03:17 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f459fbsm72138365ad.78.2025.03.24.08.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 08:03:16 -0700 (PDT)
Message-ID: <5d872cf0-ca57-4017-b06e-fce9c11813dc@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 08:03:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix rx completion meta data corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        Clayton Craft <clayton@craftyguy.net>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250321145302.4775-1-johan+linaro@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250321145302.4775-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ybu95xRf c=1 sm=1 tr=0 ts=67e17436 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=GSe8ykzKO7dVpNIIvtwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 5XG3r9ONJlSog9GLmyZ4GuM-B45JPuIr
X-Proofpoint-ORIG-GUID: 5XG3r9ONJlSog9GLmyZ4GuM-B45JPuIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240109

On 3/21/2025 7:53 AM, Johan Hovold wrote:
> Add the missing memory barrier to make sure that the REO dest ring
> descriptor is read after the head pointer to avoid using stale data on
> weakly ordered architectures like aarch64.
> 
> This may fix the ring-buffer corruption worked around by commit
> f9fff67d2d7c ("wifi: ath11k: Fix SKB corruption in REO destination
> ring") by silently discarding data, and may possibly also address user
> reported errors like:
> 
> 	ath11k_pci 0006:01:00.0: msdu_done bit in attention is not set
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org	# 5.6
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218005
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Does this supersede:
[PATCH] wifi: ath11k: fix ring-buffer corruption

