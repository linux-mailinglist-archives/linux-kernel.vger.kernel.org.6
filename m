Return-Path: <linux-kernel+bounces-222844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C956910886
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA531C230ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99071AE0B3;
	Thu, 20 Jun 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="xpVpg/rH"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284391AD3F5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894101; cv=none; b=ts2+D7JRiTP7CRymzTz8STfHp3pGSgPHSWUZk/gAm2O9ZjefS5/guwMyEWWRWbP3zBwoGou51o59FseRd2Dyi23k2ZjyxjviTlTengPtmn2+a7Rd7OR6jgXLhrRxk8hjR+FJWaF0rDU9aZattnIUY1ZiKegHkmYNwbFHmwf2eqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894101; c=relaxed/simple;
	bh=RVThDafy3uo4pg7emhG9LvZxYfFJ576f9DT/KxUruuk=;
	h=Subject:To:Cc:References:From:In-Reply-To:Message-ID:Date:
	 MIME-Version:Content-Type; b=sp29629kE7auaZ//a+rvtj5ooHUGDOyYkTLqqcXguYXmzKyWVElZ2GxSRZY8aDiOXyGUTMUAa7/RqoMk+WSnYyXXOiow7BXvhAbbz9Pks7uAsi+piY06vhynVZPPbWsGaAUBy1bZD9c+e31IUBAwN+p7AjmkMxuMd0RZJcwBmiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=xpVpg/rH; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id KIKisr42vjfBAKIsGs3jzh; Thu, 20 Jun 2024 14:34:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id KIsFsg6AfDoe7KIsFsHPIB; Thu, 20 Jun 2024 14:34:51 +0000
X-Authority-Analysis: v=2.4 cv=Gq1E+F1C c=1 sm=1 tr=0 ts=66743e0b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:In-Reply-To:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tMc74o+tTpNs+4XE+x0fYcX611m4Lf2fIXT5GrOocLY=; b=xpVpg/rHvOCoLG8blbg2M9c0rj
	8CJpTBvQZarZrZYoltKU1NwXQhcfiNaN98OoTAYqnT9TmPDTU7w2Ud9TyioPvVdrrrybOVXkhwCWD
	h0p77YiUn0Dbyc1ruIH5cd1LVbBhlCJXNAujYO0ZX2aZmjdQUkDhhulY4J/C40GflD8bSz8zhGEaQ
	LOesGHphfKC2Te39nmC9wv6P2b6Qz6Ij6vlDYUGj9Wrk6mIbyPN66ZovQBsy5tHYn7KUH/Wxgt2QJ
	1Hhr8ee2ieFsNzTwSJuv8yx9RPJBf3wPARHiQC4DeCDsbGonemPPRcHRih99x0g6TvaIjBk6lIoXV
	sRsaGQCA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:44958 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sKIsD-001k5i-0L;
	Thu, 20 Jun 2024 08:34:49 -0600
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240619125556.491243678@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
Message-ID: <3e96b216-383f-6e0b-b62f-6fccbe45b0ba@w6rz.net>
Date: Thu, 20 Jun 2024 07:34:46 -0700
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
X-Exim-ID: 1sKIsD-001k5i-0L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:44958
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOiuNGRC4rxt23AM+GD3IsX3AY5jeGfzrXru4JyJ9n1xZm6t3Iuu5LOiM7iaD2TUIgDk3qlOHVzV5NnAc4NM6SxaovOhfzDzy5wNWUbUzwbfjkpx+lXu
 K6h/p7Yok8jGNcqwYEiMWra0qiPgYIpFwOlIOTlVylaJo+TdYHJm/q/Fr5/vk/AlL+YRGzti1SJriaW8Evv389OcOSocPvWzOVg=

On 6/19/24 5:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.95-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


