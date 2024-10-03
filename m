Return-Path: <linux-kernel+bounces-349755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E587F98FB05
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5711C20CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2A161302;
	Thu,  3 Oct 2024 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="GLZ/49lj"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6784D2C
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999390; cv=none; b=KIZup3w4xmFKXQUqqU0cP74xd2wIv32Tau6V1bDeUOComs/OlmW9ev5JzVx5qkw8igkpUBWEyMLb5qD6QakXAe3QDjEHnSithh0qe2dWQs5Dgd/o0Qi4RpBPW5SEULmQeIRAo+5OQDoIbWsrWw2+Rw2R4D3CMAX0/HKWL2oV4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999390; c=relaxed/simple;
	bh=2oIUbOgjzKHzOPceOAXb6tsAQNgCJT0hx28Udrr7PaM=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=XbnNsx/B7aG4cLGhCytLB1Dma/bNoQOMFTBgQRAyWZTuYQhLNFKJBHf7kkOTQMD0QJNToPmfmxdW5JEKcxc1cniLUUsCPeX65vMebQgtykJhS7uNDIsJPmV63/9diKeYlx2m89qTXOGEa6dZv2HMOinhVqb9w2Ka3v9kIrZsQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=GLZ/49lj; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id vePhs1vDVVpzpwVZrsbmiy; Thu, 03 Oct 2024 23:49:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wVZrsuzvWmNYjwVZrs5PI6; Thu, 03 Oct 2024 23:49:47 +0000
X-Authority-Analysis: v=2.4 cv=fb9myFQF c=1 sm=1 tr=0 ts=66ff2d9b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=fe6ktvqnEFPje61arPAA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rITJTELo8rdhyu7WmnQmhjDArcUkgvgc8ekhsYRMzSA=; b=GLZ/49ljbft2H4awIxPdz0/gWX
	JDx0MjvG2m6LOHU3AE5cL+jlNqKdhYwJhhv1PqVWrpvv64++gza42iL47uNmYruhzdXtnkKZQhw17
	BT+XwXlKLBNrhr4lkyM2ItO/prqjKUhbNoRmefHdUS+zGW1ulZ5zAqutb+rhRv1EpHOnkMZouj36+
	P/VF0XEkEwjfR6N7BY5vo+14M87Us3llZufn9bVqpCaTzf33d/Q4IBeNvDo31vMsRJjLsJUxCdGXk
	BYOTlSxAUmPedoAUPKvR/8YcH0JKQvjh0/FrquIQV149d9mAqEiUYpNS5Jsjyw76xoeeltfj7jYaU
	EltDceoA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:44460 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1swVZp-0016H0-0r;
	Thu, 03 Oct 2024 17:49:45 -0600
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241003103209.857606770@linuxfoundation.org>
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <62c68022-765c-d3e4-aa61-8c2924189af4@w6rz.net>
Date: Thu, 3 Oct 2024 16:49:42 -0700
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
X-Exim-ID: 1swVZp-0016H0-0r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:44460
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCUshBVY7/CoGGX53PzMpUJvzoGjxwAlC/BEk2jyTMTlRCEbUXJs1TJmP0+qK9lGkvexHxOgB2y6ZOcWX98WvrW3TdsrqBEqBb6MkymUWqiDB4lDHNLx
 IhlsQYkJ4qUxp80khCinUV60Ll1zS8aFTFCbqfqaPcXjK3epDVcPcEIvP6eHWaz49EaqzGFVP9AIY6CEgswjh964HgSEhw17quM=

On 10/3/24 3:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


