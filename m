Return-Path: <linux-kernel+bounces-444199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E29F02C3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF09282E26
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13018EA2;
	Fri, 13 Dec 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="m7u65/rr"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AC22071
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057954; cv=none; b=P1MBSX0vQn9+FHocOqCIqWb4QPdoiY9GnfjE6DMR4WDdlmi1jJvQoflHqNk0M+yu9QcybwR4VGbXsXdkzPRqMOIox1rnbxRt7J4FzhvTyUuxJevkLVFzHdrXbuCoQWWR3jVfuJq2CnSYiYpFEdjp7729x2L/kpCQoJ+C5eBsrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057954; c=relaxed/simple;
	bh=Vi9Gsh/7IVGxZo/6j2AMkKbElclCl5FtEWr3aRVQAh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qY/tgeqMoSD8CmlvMLgvggon59bYEG+QRYOUwofUgXTD7qLCsMU7i36+juEp+qbyguihe+lDeydwROCUhwmFGqRT4bclO4sHqMtEszzUbtZr7dSyYH47HLbeFJaGwG6FnWCJA++ButOVY10rck4hNTXxPUOecrzGNzNGUknCxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=m7u65/rr; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id Lm0ctofdnnNFGLvf4t5zvf; Fri, 13 Dec 2024 02:44:14 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Lvf3tN1mOfkSoLvf3tIbMU; Fri, 13 Dec 2024 02:44:13 +0000
X-Authority-Analysis: v=2.4 cv=dtLdCUg4 c=1 sm=1 tr=0 ts=675b9f7d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=46b2zNrTT39c53egbTAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UBBDSF2xA8SfX8ruJkx65cZPjSoN19Y2N4JJGcVCvW0=; b=m7u65/rrkEVtxFz14j87dVYLdi
	FmIw2T8Q10Mjr6VGuCvT3yyej5TOx0/azhc8Hd+6DSj4uak1DX+/noqFI+p6iPom7PrbsLP7Gem9h
	c9LIbCw3B1+m/8Ed3gKULtkrQmwTl2KYMt/kn9H9K72jlVMiPPwK3Pju79LMU8SxL9XIBSgwTujVY
	XMK3WsGpcQSp4VyFUn+HFQtQ3cUbNc38YE4NtmK270yY66+9xeaOHABtAfMt9fj4x7bkbH6DuikVC
	xHSJeINkzu1gX6J3EO8bKWjUcGy5rQBRwamoY0bvh9XpXL0rrdo+jJapi9YneaXut4kKcpCmh85lU
	R2TOKjXQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:48864 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tLvf1-002xu6-3B;
	Thu, 12 Dec 2024 19:44:12 -0700
Message-ID: <0a41eb94-445c-4497-9c60-129142a2e362@w6rz.net>
Date: Thu, 12 Dec 2024 18:44:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241212144349.797589255@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1tLvf1-002xu6-3B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:48864
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI3s0uqh27WNcej+amIOiULylMcOn/YtqNtL30ABa7Wrol66TSZZ/SrWOn7BuckqpnGUxPGzZ3lSNRqOdidpPS6XvIwLSR5SXnV1edr6j8EUwIx2oDO0
 t7GeKsohL4/PxHjnT0gPC2jS1D/0SpM5Q7ywwOIhHqZXKgAmTougKgRq+mhTXji/9qVmu2EHuI5MskvsL5Tosm6kbg9nGXkkVLE=

On 12/12/24 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.120-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

New warning on Linux 6.1.120-rc1.

scripts/mod/modpost.c:969:44: warning: excess elements in array initializer
   969 |         .good_tosec = {ALL_TEXT_SECTIONS , NULL},
       |                                            ^~~~
scripts/mod/modpost.c:969:44: note: (near initialization for 
‘sectioncheck[10].good_tosec’)

Caused by commit 20e6d91ba71543164151fc63ef978f28dda75394

modpost: Add .irqentry.text to OTHER_SECTIONS


