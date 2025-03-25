Return-Path: <linux-kernel+bounces-575203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E9A6F3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1249E3AD4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA2254B1B;
	Tue, 25 Mar 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hswChsry"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0972517B3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902184; cv=none; b=AFZ18SLoOLhlW1r/6VpRMb5ihz0ThiGAls8RNbPsgG3SyhRRxOAbU7QeGLYy1hBAe3likzcnj6VKC0u7RroS/hPCuyyuAvsx/46YZ78EcBaHfMH8GF8sqBC8oVxEO0PH1yPK2e2/beBbUgyjI8YrhBmesGAnYX7jf/J29/N5Svo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902184; c=relaxed/simple;
	bh=jzaTLKgPXg/1h8OKaR7eOqQXP1uAjIG0fBFTIjt9+D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+Eqnk4ag3Cybio/nnNprM/Lj+vo1MumTfYPtojrc0b40liFBzC7ZIk6BvkxI82qrXRmtctUYSNAdZ5xk7NCCA/y1Y6J0/weKKrZTSCup6gaT9aLHNkOWeiGj75AxZ3vvMKRBVGixZKqdqapm49GtbZn1LfH1EZGCi7n+xL6AHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hswChsry; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5vwEu002776
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wVFxJzi8/lwuxxcRq8n+KCJaooAZuyuxIjSQGw+9Oc8=; b=hswChsry8l4kA4Lq
	ayFgqOyo5APynvZBR3PyUbfgJvFa4bbif0xZ1dHWQ4iGN2wwFipjDmc0vXUZW2ij
	fNntv0F2fchrkoG3Anp5lHa2f0O/L+x3RP5SZeXqEgMJjovtXpf8EIdw97yLqVuX
	6y9OBiYVhXKOzgHsr+cCei34YE8UXBXu56VZB3/ry998/gE0LF9auDpuXfmghDl/
	r9g8A2bqwTK7ZPJO+xKI6MHNv2EBesE5IIDLjqTAyA8JG5M4G1kxVEbCHVavFj3r
	z6gi8Ovg8m0UQ0yl3enw7wQdptaXzzjsbtDOmB4lp/Qf+6P5eJTRIiv3WHetTMok
	+/Ne2Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hn9wfm75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:29:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5ad42d6bcso160460685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902181; x=1743506981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVFxJzi8/lwuxxcRq8n+KCJaooAZuyuxIjSQGw+9Oc8=;
        b=O3NbFo+2NsUXJGl5SodACuG+Rbze3gog4LzB+6Fdr1PyBwZf8aKgf4cBAwgL2Jxalo
         JO0zBvY/QVVpZVscbVXPq7sE5rcqlx+DsE79ILYiOaKbA1B8k3y+0OdxHNqDK2MFB7sA
         rbkQICTr+d1ctyXi3iLed6UUoDTIEWXhNccwjNP4k5cxypJj+i95ylTJFnvbGxy6f4Al
         2bU90VDyNPFhMMZxZ2i0kwgPwK+fSAnk/RbPbs0dBrdDdeprjlr1XBYoS3Y5qG7i0J+q
         /w0qOKbSRZlwECT/NLR1QhIoJozTIIqs05G7K+VLPd4BXy0neRwqaxmv4s1S9XteZH8R
         lj6w==
X-Forwarded-Encrypted: i=1; AJvYcCUBgMaWcgx/rUGplTBiEg9FsRO7eTU4HjxKUaOU0FFCl7xX3kbTurYheQ/dpk7MQrOwepJ9E3JENHG3pkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzviTX7fg0G74LvVGsVYFd0Z4Lu8mgHOuQO6AR5T78hnKu0oJsk
	dD3ff41Rxl1yn2vlM+9ixgjNhMACxaToUoWrFYkcIta+9cPNew28VdTr0ZrEjGHebfEoOlNuyIW
	f2GsTG/1XGlubbjMGMu+eouRIzgB3ZeFsiiJIaGCH6lq2UlmJ0V81shPMbwIzckQ=
X-Gm-Gg: ASbGnctZn79lqctVDIDsqlLCd8vcCHNgV+IgrgyQCdcrlJR24VUFLCIoCGqtkHwpmJo
	AVY0uupcgLJDZnKwz3D67nbRXKo5qIOLChrMsy7GTZHGMj73X7oq75zXv1lLq4B7PTUzg/fHQ/a
	Y7LJmg/Qle6Be3JMJcMwK7x24iZBZOYhwSj6udo6yBvVYEF+UZepMXmHX2+UVAlbkL31TcQakg9
	YUpG6dz8mLxychk7qrSjf3AnhyKPFIIVoMAMwIj7tjctt7HHAKFuOveXURvhDxQfR0xDQYNL8nN
	Wu6P2qVr64id5mjuttZLKfOVMLcA/WIwGUmNLnwavWmSQF8WN4PxuyajWipQOfYDP+hfcg==
X-Received: by 2002:a05:622a:28d:b0:475:6af:9fc4 with SMTP id d75a77b69052e-477513d8167mr14908551cf.12.1742902180495;
        Tue, 25 Mar 2025 04:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMmiF13ilq7yTbZW1TEyvgNhMVeaBnQRt6C3sGaNzXAK3mTk/weoMaltViWpUtxtDzSTL1hw==
X-Received: by 2002:a05:622a:28d:b0:475:6af:9fc4 with SMTP id d75a77b69052e-477513d8167mr14908311cf.12.1742902179977;
        Tue, 25 Mar 2025 04:29:39 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c76c4sm7549423a12.56.2025.03.25.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 04:29:39 -0700 (PDT)
Message-ID: <7d74ef63-83fc-4c19-a247-d779cdd4e482@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 12:29:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: fix spurious DP hotplug
 events
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Clayton Craft <clayton@craftyguy.net>
References: <20250324132448.6134-1-johan+linaro@kernel.org>
 <7f161a25-f134-44cd-a619-8f7b806a869d@oss.qualcomm.com>
 <Z-Jr7MifpkR8cL5B@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z-Jr7MifpkR8cL5B@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: thDMhGQaTINxN0IXxbt4Klabwlacb4ij
X-Proofpoint-ORIG-GUID: thDMhGQaTINxN0IXxbt4Klabwlacb4ij
X-Authority-Analysis: v=2.4 cv=CPoqXQrD c=1 sm=1 tr=0 ts=67e293a5 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=u3giuUM6ARgIoqdfjbwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250080

On 3/25/25 9:40 AM, Johan Hovold wrote:
> On Mon, Mar 24, 2025 at 08:21:10PM +0100, Konrad Dybcio wrote:
>> On 3/24/25 2:24 PM, Johan Hovold wrote:
>>> The PMIC GLINK driver is currently generating DisplayPort hotplug
>>> notifications whenever something is connected to (or disconnected from)
>>> a port regardless of the type of notification sent by the firmware.
>>
>> Yikes!
>>
>> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> That said, I'm hoping there isn't any sort of "port is full of water,
>> emergency" messages that we should treat as "unplug" though..
> 
> Seems a bit far fetched, but I guess only you guys inside Qualcomm can
> try to figure that out.

I tried looking around, but couldn't find anything like that

> An alternative could be to cache the hpd_state regardless of the svid
> and only forward changes. But perhaps the hpd_state bit is only valid
> for DP notifications.

The current state of your patch seems to be a good approach, I think.

Konrad

