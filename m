Return-Path: <linux-kernel+bounces-180288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390538C6C77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE681F232F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7815ADAA;
	Wed, 15 May 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wuOSOXIM"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A50158DD7
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799143; cv=none; b=hPnnbLYO0+5sDKyXRYof+Ffb3a5xhI/hOY79XJAp/NIpi8rkqlPfoUdTN+ecYIDQEA9PqDYDQoU7cDYGCq4VTpVxEuhQznQvVtgEPL9eJF/EQ96lD87PT5aulPs82xelseUGlFNPIZu4ybbzqEYE3eFizdX/dpMUIl+Zpsdzn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799143; c=relaxed/simple;
	bh=Za42TSfcWZzLOdAhQj+UtZ/Fhid5/Cdo+6/AAZMbkuk=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=btJpmY3sZfTntjWT2Ypor3aRvSL9f/vdoL9jCqRzLU2RKbUSY19RA+QNwjCBsLLpLn/um7CCe9murQb6urGJ5KznSH4oLbLRPA5amOD92H0JvCQfJ3dB3F3VotxlUadC1v9yJiB4MDg9VLg952qqspOiG5+x/oVtY9oo+hs9WUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wuOSOXIM; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id 6vUqshCZKxs4F7Ji8skpVE; Wed, 15 May 2024 18:50:45 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7Ji8s13Zcd4oe7Ji8sVS2A; Wed, 15 May 2024 18:50:44 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=66450404
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HeeXhtpvNHrroWCcVeHmY0/29+g9hU646zMWYJ1iwZ0=; b=wuOSOXIMvBJyN21sxkdyQ5F8Sr
	sOwc7wkfQlZjm3Mf5NDfieDsGKxS+fY655b/X1km7tZAImvHZUZURzaaah/w9nJUzkx5dZ/bNjzRa
	woML37VV5D0ZYewPJoxcrTDaeju5H+FHQbHQiDutVRzemtJ23QrzlT0uyfaaFu1indOiDRPvxtkGm
	i3Yiy1aqTTANEwdZMD1jc0Sai+/9f1Ga9kX1ChWXFVMwZ6PsYjr4EvnH4MHnKWQREULCUJQkzeIuI
	8JenDMBqDRu8jAVq9xZTOk7Ca8sNaZjWnl1WrDYm/rIoWn5kE/tVONZ35o55p4afCSOFwzyaJFdCI
	MnuCaXqA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35788 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1s7Ji5-002M9H-1I;
	Wed, 15 May 2024 12:50:41 -0600
Subject: Re: [PATCH 6.6 000/309] 6.6.31-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082510.431870507@linuxfoundation.org>
In-Reply-To: <20240515082510.431870507@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <5a730f78-1c64-e091-8794-fa8f8d105d20@w6rz.net>
Date: Wed, 15 May 2024 11:50:37 -0700
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1s7Ji5-002M9H-1I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35788
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLFWcbfOWwIP0c3b4W/gJH9bp3N3jAJaNVm0g4hi4H0jDO7NXrcxFzLP+EjRPz7GpuikLnkklmjAPh28H32tJOGcVXfWdj3tkNSGakqkjZsT92m6dtQE
 EwVA4H4V35Vf+zBf8fmDnrFnsgLvWrpwtjIZV3Zd1OyfGyHpuNcaT1zD3OHscOtJ1NgI1eaKHC0lUQlNRBEGjvYzALcSXT2nvlo=

On 5/15/24 1:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.31-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


