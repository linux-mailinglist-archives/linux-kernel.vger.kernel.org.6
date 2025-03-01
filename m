Return-Path: <linux-kernel+bounces-539796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F149DA4A8BE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F08D16C665
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CF21C1AD4;
	Sat,  1 Mar 2025 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3caN278"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD70322E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740806158; cv=none; b=pIWhvGDXVgsrQ8lUe3HpZgyKqBk6LYNkUoZcaSNsQGNzT5QONWLxUAdRkE7xba6GmIjRB8Umotpzv8fwqpO4wwTMVbaz0Jf9pxvhTtIA1DE8OM872qHn17SqDdoO2qEVzQRvN/BdTikPW5CeMpUwyOkeE+DancZs6Q2AJ0gmwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740806158; c=relaxed/simple;
	bh=w3JPTo1X7xuDHLlZ8a/6rNzRq60vonQcCBdiCGgJoG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvFy2+SErqdedyixYDKm2RFsLGbzCdYD5aLHJLWGz3tqIEGN3kRejmNGi/I+nE6T0/oqSnkD9PeYR4t0FpjXHY5sT1o7n8z1kPlbsuL72df/7thai24/nmsgExelkhqVqTY4H2CHCZAgJQ0gXTwLy4aGkOlg7IFpsV13hJwGvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3caN278; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214rugm014562
	for <linux-kernel@vger.kernel.org>; Sat, 1 Mar 2025 05:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BQ7oIoj1Kqr5z8/bVwYBJwuROLD7SBJp1FOO5JjySAQ=; b=k3caN278fJqtyWJw
	/SbNTrIzDEX42EAMR7UDpohxyiVtiByi8MXHTehpLWHBl/dMGNXeCSIPNzccB0WN
	CgL4cOvrGdF9UwyWKTijOvPVl796APgmuHgelEdcauIyq3nnw5+sxYWg3z50PkSf
	Hi95ph3Yi8DRXR5Sh0PyZydtZShlBjNLCM5ZqlaRAWWWEfsAHydZ8W5LpvQu5Dbc
	cjqHs1u2Blz7215PHPxYddPk4EOMwXiK5n7EQVLZSAvNOYdPZ+0Znfzal2wXljGO
	C5bWe7uJChe7hWl2kgKhiwyuEeYKhvkp/rXG2tpq3U8DvshhxltrSQBko+edZoc8
	bdh/fQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t99051f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 05:15:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fed5debb85so739901a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740806154; x=1741410954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ7oIoj1Kqr5z8/bVwYBJwuROLD7SBJp1FOO5JjySAQ=;
        b=f7g+TV6qBXD+9/QYoLf0Ge2A42HnhoRdyHLpbmDDctMF/khXDPtMoPAxlqnIu2fTuv
         o280+HuiYVfvSNYc5lLIjX9Rc5tnFByWAc+WUJ06xKU+P0cNCXlu2Hg5L7JDDLzgU/QU
         rWKpZt39Hty71T5jvTrbIuneQzNReau61bWaRz9p6xKrEBUywpoNPio5IQaNWYgovEI0
         jsjnxA9h8ndJmwmFRnTTW9OClH5p/w0wfKmIeNG82YDctGOK0+6EUOnfv499OhNgyl1y
         veExX1+WHk5NwGHAQJ8Y3A4vK4gFxxt6u5rAA0G1y6r0KmM7DC/lxFBFGYx16A8KatiN
         DDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGbLRvTiqwpvj1s7KzXUAGCwUyEVqdDXYYPSx7tBJxGIRkktVjQ2U0+9JQrHNPpNCB7XzzqFiNGXdDHFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeM0gLk0Ejnl0wGW7+4WXsk5rNZeCNhbjn2josWdazxuxeo4P
	bAHamy10lb1zWzLOyeyNyVt0alg85b8smXhErOcz7WquoFV4b4gi2gWc5sDUOTGEnWGSZzyWJ7V
	8+KK4ZJ2O2JvYr+Y+xLlqlHGIiUBaG6aRq0n32yo1F7COq0isWe0b1yhiIDYTtC4=
X-Gm-Gg: ASbGncuMu28Pl7zbUNuNa0lZ6uHpIjfMybzXr9gu+i9u6armaLAvFLqL9/u1Sk9Zgp/
	P+BzxdWsu2o5tEKu7FgEqKG6d1pW5JUHqHa21gSg2QHKWf+8mO66kCGYJgCW8lrophE1qMHqcoc
	5/HamLcVBBV7dAYM8OFBxqGDd2VH2+vXeZhA8B/JcM/y7G+Y5E5Y/gkZKRB5l5y3r7ric8x25mD
	0w+bshc1xKvOaYF+VqX3m4y+La1oL/ftvd0yIDQr0Zp4TqBF8wXZS4xyoJF3eerKGiQbO/SzBFV
	Jp9yUP/jkvS4GlHHbVaFsxxwsPOU7gVziq72l0Rr+VP2gmN6NC7v/lE9PjMy10s=
X-Received: by 2002:a17:90b:4ac8:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-2febab70682mr10656994a91.15.1740806154543;
        Fri, 28 Feb 2025 21:15:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOxcKKcRuFeIE4LwnVNuO3M5Y/CqCenqjMe0/49M1rib5aLtbWxJGNDdDM518EtbC6COo0Fw==
X-Received: by 2002:a17:90b:4ac8:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-2febab70682mr10656971a91.15.1740806154218;
        Fri, 28 Feb 2025 21:15:54 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea696e39csm4719697a91.38.2025.02.28.21.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:15:53 -0800 (PST)
Message-ID: <88f8e029-72e6-06de-34a3-beed36a57451@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:45:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 09/13] wifi: ath12k: Power up root PD
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-10-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-10-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ixINV0PJD_GC0LSUIqGrfpOkPYkpWt9b
X-Proofpoint-GUID: ixINV0PJD_GC0LSUIqGrfpOkPYkpWt9b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=786
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> 
> Q6 processor acts as rootPD, other hardware like IPQ5332 which are
> attached to Q6 act as userPDs. WCSS driver handles loading and booting
> of rootPD, while the ath12k driver boots the userPD.
> Get the rproc handle from the DTS entry and boot the rootPD if it
> is not already powered on. Register to the rproc notifier to monitor
> the rproc state, this allows ath12k driver to know power up/down
> sequence of the rootPD. Power up the rootPD and wait for a power-up
> notification from the notifier callback before powering up the userPDs.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

