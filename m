Return-Path: <linux-kernel+bounces-285423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22281950D48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D329D284645
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8A1A255C;
	Tue, 13 Aug 2024 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="D9m5Cx42"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B519DF49
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578135; cv=none; b=vDP5nsxLAuNgyszlxmz+ouheXTrSH6Ta0cq7hNTqFmdYsAFIeLKRpjHSVyYBuzNZ/p/eekzZp53S4INgVRu30uHU9ahEUmc7UKDxoNZHBAUxll+Te5zutXvLzH9Cw2kF/zDOuH5Gv81jOw1AHEYKHRK5/VJthWSy+pzxwckCVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578135; c=relaxed/simple;
	bh=n3BKIAMwW/k7u9jJ2Br6awULA6z0UrnTHCVhnCZxAxY=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=WxUqlz2lXo+Q/RYZBf589bhB+/kww58ZcF69tLF0xmRukyw/TsLcQ8joMFITO6Pn6Dcz2N+p/ki0q+tCbLDSuVjVKeVVFglj1nDMEVPm5CZQXTnZAIPzev0eCM1pnxJZNNezgxpaiQ8sf5hdNhybvzUozhDF4zW5PP9KlM9Nt+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=D9m5Cx42; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id dx9fsAJ7o1zuHdxPBsFaw8; Tue, 13 Aug 2024 19:42:05 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id dxPAsnISR0vWTdxPBs9Rzm; Tue, 13 Aug 2024 19:42:05 +0000
X-Authority-Analysis: v=2.4 cv=ffZmyFQF c=1 sm=1 tr=0 ts=66bbb70d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L77ZF+dgOMyz8eIBfIoH5lLrozH6GjQOVZCmGJn8IWE=; b=D9m5Cx42XYENGeQ4S4GW1SKUlZ
	LUKa2txW3/Q6Oy3UHcXSBL8HP4pSyJUmreppNkVXmZB87SnTcZSHPW5+TWyzKmLW0rvIM76ZrtTEN
	d+7vvFCEj2zxfaF4ldgMJkQiPd9HvC4OPQwZF8QM6DIVkaeeWVDh4bo+bJU8wGFH2FM399uBc6OTK
	iWQh3KSaaXNifCMNeS5dmEhp/yodosksEUamEI2n6FGzQ7FSUMyh+IxU1u8OS7ZWEE1zNMIGO5Gmd
	hKoG6Lk/vtf6jrADkf0UeC3NN3MAjgKdRnhxuAMrRLNPXhiHWMBeDXt4+MrifWXdIq5M2G5VIlBI5
	9/CLgAEg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:34484 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sdxP6-0007AZ-0y;
	Tue, 13 Aug 2024 13:42:00 -0600
Subject: Re: [PATCH 6.6 000/189] 6.6.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240812160132.135168257@linuxfoundation.org>
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <7192d9a2-d857-0201-d864-74393d34d959@w6rz.net>
Date: Tue, 13 Aug 2024 12:41:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1sdxP6-0007AZ-0y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:34484
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB6asRia/KduwcbdNH5JD3YyRRUXrq6TgigLkTqLkisme/LImAeXxqRO00sUZJdp3S4cdL4nPLahFSI4uNYUOK/WIxVSKR6ALLZiP5KU+hWMc8IeJhix
 j8sqIJv9h/sEyx/9+bfUcUVi9iyyO1vcDLZ8tPjwqzcMg9wAa3OTxAwjuOp9gd2j29ga+zpNNHmNaqPNuGrIMAzfTEPsj1hOApM=

On 8/12/24 9:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.46 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


