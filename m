Return-Path: <linux-kernel+bounces-305478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B45962F56
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B0D2849B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619E71A7AD8;
	Wed, 28 Aug 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rL4ULSGf"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500318786F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868510; cv=none; b=WiM1G+usB8goTALW140UmTJyw5M6vsNeStzrU6suMASFFng6Dfjvqmn8kM1ulSO2b0wz76eZ4t7YoBopWeLZp0FMCCd2JvPfwTRKPi4cDa5frVZ7H6W2QrdegJ6gJvbHPdXhcUgNQLR7TGz3QXgiPCP273y6OGbV72WcFARG6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868510; c=relaxed/simple;
	bh=SCLV8wd7X7ckBXak/0X6ibU6CYrjKDscx+KQsbhVC+A=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=BRv00U7tcZN+cmjyMOOYGegizpnTWjEFX8bs6GWpn3aVqdN3FXBakakMPcrWB7BdJRxOYodS18RruywWaqbLaDQz6ywuq4lV/RUwNwtlOBaUAHjyzoflJNWxHa5lWw1mEnDrAWd+e+hWKUQHKK2ET6zZCaoVnFfqdFh0cvPMkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rL4ULSGf; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id jJz2sZeZAqvuojN5nsep8u; Wed, 28 Aug 2024 18:08:27 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id jN5msuIJwX56wjN5ms5Tqb; Wed, 28 Aug 2024 18:08:27 +0000
X-Authority-Analysis: v=2.4 cv=MY6nuI/f c=1 sm=1 tr=0 ts=66cf679b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=pvbMRhK_gA1k-AccEgoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hfsNqh9p0Ut36mnWdHM7bvapJh+juYxlaROAU5v0Zr4=; b=rL4ULSGfzapvEmO3a+sfxHiYSU
	EYNSHtgQfLyevf016rYXHLZ5OIyrBNqCmfZSkmDJTG+zO17MkNCQCxvMZ9f8Q/FAul564mWh/EaLh
	GQC7oOXgkdmXYs/ZdZ1pap0SnJYCkNplwVe5ayZFhdytBQ0DA7y2LIdw/aaR4VwkEQoUmS0Kkr4Ap
	B3MmkwzxlsOKyw7Xw/8wJn+wdSdZhxO1DpTfGv/5lp56op86jz7zzEAwLgUoQEcFufjIDOs0GQFiW
	B6PdwNkkmPrM4Z6a+qrIZ4vIAmHy1BVZZhOCIsxGMsYXEpqFATS4sdzxq8V9lTIuWQvLVprwY8sQV
	k/2+BLZg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37086 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sjN5h-001FJE-1j;
	Wed, 28 Aug 2024 12:08:21 -0600
Subject: Re: [PATCH 6.10 000/273] 6.10.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143833.371588371@linuxfoundation.org>
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <108efbde-9cab-1c96-4143-bb80fe72d796@w6rz.net>
Date: Wed, 28 Aug 2024 11:08:15 -0700
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
X-Exim-ID: 1sjN5h-001FJE-1j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:37086
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHsZCwkXVVbmUvyViUwkTII808JAlT43gqG0fu5qEyZf/Sp2XQNhIUmli3ifQTKxm0a92pvcxlAuL1RkS6R7MWghivrvc4qRpohk6nVIwyHR5rzK9+7t
 dmQu+Om1eeWjt3t+ge2eb2amOqVUElZPwLpFsGeTZObSiQ263eHh1g6lYYZaZpdtGb1tYQsRtD1FnHgo6uXsp8FFc5fgGsSzROQ=

On 8/27/24 7:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.7 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


