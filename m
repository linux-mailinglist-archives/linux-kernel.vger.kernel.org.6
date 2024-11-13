Return-Path: <linux-kernel+bounces-406923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0A9C661B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC1A2860FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC4BA20;
	Wed, 13 Nov 2024 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="UUmRX7Gw"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F3AD24
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458312; cv=none; b=KCa+hWfYV2dPaqwohkmozpLN76NX90cSrl2WP+h59D+WtfiTR5kpGRegCqaa/V1LEeVdF668q6qh3t1lxomtX85F+dUb4T0USUhCJPif/6wZ2KijGrz2d7Vhz7txtVzcoDVTI8/uLK9Ik5MiHUaUbPDzDdggc/ljayTfgYPNIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458312; c=relaxed/simple;
	bh=0xMGz0x+SCxaSlLRE1zUcgam++HA6UIhopk0LZjXKA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayHxYxG6lmcBIrDwmXOF/TMIgqYX51UthqY8O6nHHmomarVAUVMFqGRSO+8+wOfwt0ZWvkXQYs2mFWTzVgtCYvsow8fIbWQ/JXQqv3adVhhOJEZVo7ABzNLN1JDWufzocdg0Pg7PWeGEKj5+wjAaFD1XCVljsSUWJIyhsGcbiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=UUmRX7Gw; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id Atj9tRmJcrKrbB1OqtW1wF; Wed, 13 Nov 2024 00:38:24 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id B1Opt4JIvOEiZB1Oqt9nO9; Wed, 13 Nov 2024 00:38:24 +0000
X-Authority-Analysis: v=2.4 cv=K4AkHTWI c=1 sm=1 tr=0 ts=6733f500
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Xg3r5l62jPq6txtoRjwA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9W/cPggQvTr2+R22QZo1/pynj3xOKOriTKS3daPUtGc=; b=UUmRX7GwBEbkDgT0pR2G2mwEnn
	z0gjMaDXQB5++y0Peh0cLno77AjByZ3XDb24w3fzE3oW2TIAyhjsNXzotyrferollOgtpbg6F5+Aa
	ixUFrPONJb7cxrIjWEluLtGBvLNq0CxOmVw6c7KCAhdu4qFGC+R5Sk73PzOoim791AvWckk/dOvr+
	Ay51FDq0o0bbzSSzsxfMB6lpv/pqds9nJDqBiSsAQNRc0vhgF72A8GeZoVUY+afq1z96oU0pXVraf
	QBcoOTZHJOeWHEaAmdvqMfrn1dm7xucXhNHuvcs9Q560fg6mUrYnpyLIN9MVkpGzbMT1ZtXkH8vcW
	7lQkwhGg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36618 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tB1Oo-0044eO-1j;
	Tue, 12 Nov 2024 17:38:22 -0700
Message-ID: <4e00b8bd-26e0-4861-a93e-dcfcb3ffba7d@w6rz.net>
Date: Tue, 12 Nov 2024 16:38:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/98] 6.1.117-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101844.263449965@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1tB1Oo-0044eO-1j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:36618
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDQ6/MvDFUs0fJmu+rwW3UJsryUgT2nOwVuFMLQ5UFXV4Oz8tPHrtprFHmjFJz2453Jl+khP9IcNG5cGQmxRhvyMvyQJF17RN9zrFW+QOo+5mKIV/CdS
 5Cbthmrdd2K+U+kzpKrHKfPVjHW2cy3yVH0eNX+xBJk7+4f8AHIRYlvSCQzqEQFcHW+8hBYZ4keYAowIHAmHG/oBz3yXL6068ow=

On 11/12/24 02:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.117 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


