Return-Path: <linux-kernel+bounces-577218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE795A71A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2B8189705F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5601F3BBB;
	Wed, 26 Mar 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSLLPe4l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A71F1908
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001879; cv=none; b=AfIV3es7O1TFsnPKwJBgaq23XZEJf4VhfH2cRuQ+D23Fxtztj2tcknh44qJcM1OLYDmTNLdoIWeyfbqN/XW12341yqMnxEb8LsLSlWj3zs9Y12IVqZm3/mBSfbcS9KjoYglGfmNw72Fw7n1TUrpGVuWIbCMt3hIogefTavu6n+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001879; c=relaxed/simple;
	bh=sv85XQzO0TXPvwiRXPzN4MFChKpVzgRuVPWPDiqf3LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5oTpRSkib7YGxufNsddmwzcdeFqpKir6KF2qkHdId1u+brzkc2MyRi0jyWdKmDXysW3W8IhxA9cNKXFnd7jFrxWkt3yh3B253RRxEKepHvqqsww4E8tENSK8PX4zdZOHQbR27R3Y/lSuA0bdgEv/93jm1UVSDx/n5uThsv3HKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSLLPe4l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q737WB028951
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	faRdspgYwzNPUBRC1MsrViHX8yDM7tqPfymKZ9E42yM=; b=WSLLPe4lZpCUWClN
	ur1YDs8noWh8CR+Hgz9H1bOhdfDN1PDeKZoL+pBgak9WSS4E4k2ioWuvDT7ybb1q
	UOBrafs18Lp2cPQbjQsi5GYCXuaGpywq/lI+U9jTCOso4HR4cCqtboIHO8sYjIW3
	Mfo/bCGZovQvZU42tzCr57Bb4scDK/OfleHtS6NaT2nD6gOOpv2oWhhx7RD3GIPi
	vvuL4RHTt8XfczE+YdHP4lYCnr1TDreX4eJRsV9TJ5rfT24wAmYsM8yvG1yzdL0x
	n7ab78cTCGqI0fvHkpVp/7jvv5ukM6BY48v5RUNndxWmwzgnEiOv1PZSi+bLD9wL
	lqV4AQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktenc7hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:11:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2242ca2a4a5so85915175ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001875; x=1743606675;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faRdspgYwzNPUBRC1MsrViHX8yDM7tqPfymKZ9E42yM=;
        b=Y6WqIwK4XivVDo1lYjFDSaD04Zjraz3BF2vnr6JSV375nekN9qUD8YR6eJ8jzYTddi
         IVOYI9++rFremEOFfRtbIn1wHvyrovcD+C5Pp1ZLZ9M0P7KTJGXp4iTVCQHt3+Wk3Dc5
         4blJaVZEijC9ArqDaUcTzD619q4kyKnQ7ELgDbKMUVHEGOq+lqZ7Y99JvRC/0uPBNjY+
         1lbHDjNsjlYY1hNDC1vq8Ue5S/24YgcC8LSWViD3XFFu7ojCnDdh2/OijDP8mlWVMgoN
         NVvY++RzKmfFNLDzvX2g/FgcF533GMLf/lYHZApSwhAqKUNywE6P0bX0K5v7PUPY26hW
         nHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Xvjd0+xTXscVbPEB4Wn27YTzW1oL7FTucIO6KdcCDYKuire+NW78RwiG95RWSSslBSJGnYKh5fqSbDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkwy2V5oIYQPjvq7fre75E6I8moGVul7XY+WExwfrXpebBZB2
	xOubcIln8hj3+ddcjnqiKNqNMNKZSo5olkBvpNGgU3+KtQEfRdm8ZfI9HPx5PE1mrCQ+dLLKofh
	kXK+LcAbeFnlSlQzM85hv9ARCR610BDOVIcG8jZQ9+B3AVc2y2HXOvty+xLo/vwrwgGsmBYU=
X-Gm-Gg: ASbGnctg5/bIIkLnR7SEccOYyKGm/lYCXFeLch6ZV83xyTBhP8vEXo8s9PYo83C5axS
	MYAwttyyenHXVxibNGdeP9csTk8lwZsDFGj2RmBUrahasdfXPi50P7wPXfmGEgk/6x6/qZD1bfI
	Ks57ASjqFI0cUCBYu34hj4H6z+82EzKM7w5ucJ6PH68mtynFHrLN+/YTuqtp3eaGvwvh4sNT5Dv
	+ffIh/DrWNesm2g8UtGZtXeu8Q1spfR+VOSNZL6F4+7jYaLAXaig5b1vb45/Fb9tYmm5JKX+YZ9
	qgtUAGtHhAmrim0kWcHUu1K2O8TgqDoi1lch5wLHL97cdt05iVoZ/qhoI/WshgxGpDxhI8M=
X-Received: by 2002:a17:902:dacd:b0:220:d257:cdbd with SMTP id d9443c01a7336-22780e2a4c4mr364017885ad.48.1743001874733;
        Wed, 26 Mar 2025 08:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYZ0XI95E0L/5NYf6WJHkBEt4e1Xda2uFeWGiePRSJhve/Jd7oj9b0xjAQVL5MNlyD6vuNHw==
X-Received: by 2002:a17:902:dacd:b0:220:d257:cdbd with SMTP id d9443c01a7336-22780e2a4c4mr364017345ad.48.1743001874179;
        Wed, 26 Mar 2025 08:11:14 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b28e3sm110858775ad.156.2025.03.26.08.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:11:13 -0700 (PDT)
Message-ID: <8edf77d9-1afd-402a-b966-d1b3e5b4ba1b@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 08:11:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: extend dma mask to 36 bits
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250321162331.19507-1-johan+linaro@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250321162331.19507-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e41914 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=K3_Uot4QyE093sgO9NIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: A-XUgSV1Qfix2AwE0wXClAOPOFZ7b7xB
X-Proofpoint-ORIG-GUID: A-XUgSV1Qfix2AwE0wXClAOPOFZ7b7xB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=746
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260091

On 3/21/2025 9:23 AM, Johan Hovold wrote:
> Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
> without an iommu (under OS control) similar to what was done for ath11k
> in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
> DMA").
> 
> This specifically avoids using bounce buffers on Qualcomm Snapdragon X
> Elite machines like the Lenovo ThinkPad T14s when running at EL1.
> 
> Note that the mask could possibly be extended further but unresolved DMA
> issues with 64 GiB X Elite machines currently prevents that from being
> tested.
> 
> Also note that the driver is limited to 32 bits for coherent
> allocations and that there is no need to check for errors when setting
> masks larger than 32 bits.
> 
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Please make sure to include linux-wireless for all ath.git patches so that
they are processed by patchwork.kernel.org

/jeff

