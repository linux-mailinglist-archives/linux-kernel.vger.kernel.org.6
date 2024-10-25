Return-Path: <linux-kernel+bounces-382154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269AA9B0A25
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5EA1F21492
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1C11FB8B3;
	Fri, 25 Oct 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EVKSvhZD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174114D718
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874431; cv=none; b=LloT45NqcTjeRB8mombdefmAqdxsVrXEsKd5olZDXvxLFjPSCCd8folbej/a4nQR3FLu4QSAYBQwYOzkCsGhWJdE+WZG6ByinnNqXkdOJncggoPZmocHNHDEKQAfOtlIFlkkUu3nj8V9MxVd6MdzhbFzH9lRT7ILDD7ovArmBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874431; c=relaxed/simple;
	bh=9QkoIKnzWDMsJDZ/aiRJ6/QxktnwGNkGTlqimlXTEOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpqXRK291LdLA4SVfzQojzdSeJRnYmLvNGMsDPdY9RfY43zoxf1KXoi4SP/l+eW8sPHUXhepIW+R4g/bcvU4Tmyougbzm/s7gResC7XYAIxlq9hglD7YiOKuiJewP5Pipo3fItNH0NwlAFHNtSiSbKfdbAkECbdqEbiVUlN45jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EVKSvhZD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDTDkQ028832
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lEaOQU9DBgykCf+oZ3CPQHYKbHLSQn5HNHOz1fmswvo=; b=EVKSvhZDXM5IXWI7
	X0vHt7x18fecJQn395yHuhphE+vgRKHIICyrtOlEGmVYWAq9PwbwCa6iC8XU0Xfc
	a+0grR2nHyT9LT8Ae/A9CxQBlK3lrR7Xafdij9AgVLwqrAl+InyjCWkY+b34ohJe
	Uhd3m9Thl8CZCK/u5tI4PocyEN6W4UHIlU9h1y0wdDl53bcqQJ1C7r70i4Fsfj7r
	BUMi4XsgqSKX0nhWWxYLl4vPXr1l6OjqJmDm79MqRxFXj03O5Mr4l518WOlR2Iv6
	3yCaKt26TvLSogac8vOBXcUy7U3mTYqcXnIbxk3KZIQAFsJQ7oXjJx1anievdalg
	w10EoQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fdtxnp2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:40:28 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-718071a2128so475170a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874427; x=1730479227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEaOQU9DBgykCf+oZ3CPQHYKbHLSQn5HNHOz1fmswvo=;
        b=iioaN2Gu/p4/8mkcPY7FJd+GatBC5xyMYeu3TzP7p2PmxbU08ylQwu4TFKzuZqtOIJ
         Om1EjPsKFvcwX+9ztFe/wtKYr8uV0SAN4yEWCDYn+ofOutanWyv0yqCfGyjk5Fuh9+Xd
         nCEU0iHDGF1rgzMZjYpTlrYT/15L9X319jFBRVCOUjKG9x4pnEeP0CzPb+4+TLjPf3Qk
         y4jKYQeWCoHIARMuwWMqy2u844fmFrM/IXL/JLV15Ea64VoXIzG7UvcQ9SG+2kYD/wZ6
         eE1nXtqnR1q15YPL2gwkg9wKLSHyDTRPnOx0UGqrJuABLe4TK8SKglKEfedXxSl0DPFm
         4J5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrYI2+SykyxGzFFFfvRH7OEUAaKQXU+bH6CWBoxhUqlIPeqqOeLuHG9RxxtdVA/DcAXXpjCsig3JNK8oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2CeBAnOowssvWWZwXc4crXe3fKcuNHHkrr3OKqI73/OJm25yX
	b6cM+X43x7+V4I0UuegAnHJ2o9IxqOgcsiQdfQ+QS4a2zTyOBLIRP52/tYC55NDoB8RT2uux2X7
	zo3Ptk5Si1Sk3RxH6hJJVjRsNg89nkGxXelFDBBhFbvcGQnTPXvVjrgZGu7QkNJY1yx502To=
X-Received: by 2002:a05:6808:1294:b0:3e5:f2e7:e093 with SMTP id 5614622812f47-3e638248bfcmr49149b6e.2.1729874427070;
        Fri, 25 Oct 2024 09:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4uoNX6if15zlekW0g/RpZNt3t1OLJyPRCQ0lff/PXV6If5GJ55ORq4YzN4HD1bXV9MwK8zg==
X-Received: by 2002:a05:6808:1294:b0:3e5:f2e7:e093 with SMTP id 5614622812f47-3e638248bfcmr49140b6e.2.1729874426771;
        Fri, 25 Oct 2024 09:40:26 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b32455a14sm89168866b.178.2024.10.25.09.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 09:40:25 -0700 (PDT)
Message-ID: <867d7b15-6861-4300-83aa-55a6cdf87f58@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 18:40:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
To: Keith Busch <kbusch@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: baRm_QquvEuAU91qU6CNlZmoDcsqTjUp
X-Proofpoint-ORIG-GUID: baRm_QquvEuAU91qU6CNlZmoDcsqTjUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250128

On 25.10.2024 6:12 PM, Keith Busch wrote:
> On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
>> before the platform can reach S3-like sleep states. This is very much
>> similar in nature to the issue described in [1].
> 
> The "SIMPLE" quirk is only supposed to affect kernel managed runtime
> suspend states, s2idle or s0ix. Shouldn't s3 already be using the simple
> suspend?

So on these platforms, all system sleep states (incl. S3) are entered
through what Linux sees as s2idle, with a separate MCU doing a lot
behind the scenes. s2idle of course also covers the runtime cpuidle
cases.

All but the deepest state (which Linux doesn't differentiate as of
today) are effectively somewhat like s0ix.
It's a bit hard to draw accurate lines between Intel terminology and
what we have here, as there's way more things onboard than just the CPU
cluster that may be operating independently..

Konrad

