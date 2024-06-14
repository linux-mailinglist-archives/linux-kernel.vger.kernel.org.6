Return-Path: <linux-kernel+bounces-214858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB40A908B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA831F23328
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CB719645E;
	Fri, 14 Jun 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="c394cIol"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAE1922EE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366427; cv=none; b=sokYpQOGEA0l2xUrLEqrkfkBvzqJgw8sNPnChrFgWfMIczlFOQSwlbxdpFZiQXgjiDxTLw2rN4NkXSEeZmVLeHtdVr0sbSpTsh9Nq2wF0EhQZrxkSrHkQdQtUotX4tFpIIwdMVJTXXq3TiCW4Y87vfHfJrLKb+xjPkGdIEyxENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366427; c=relaxed/simple;
	bh=LPIgAW7ifC+de2M7i4L56r7Bddt6JbpEMPcmEQsL8dQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=nICscc1tbvmVMU7X2tEkjd1oV2c17I9qCbsLnoxb6VAiY+f0cjFB5ZAbFVIQTokU3LmfP3e5pkfpzTTehkTHtAgBUg8j2pWppxOaLjaPpCIuS9aZnEp84mJr4l7CwYnT+9LCCSNSz/syyvqciii5ib7aBeVcGFusuExYhxW9uT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=c394cIol; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id HfFRsemMirtmgI5bOsuNiU; Fri, 14 Jun 2024 12:00:18 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id I5bNso8c0EEsPI5bOsBknn; Fri, 14 Jun 2024 12:00:18 +0000
X-Authority-Analysis: v=2.4 cv=COUsXwrD c=1 sm=1 tr=0 ts=666c30d2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=k_VYlBbNjbJsBR3UXVkA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U1oTSayNQFpdMvC+joJqaPWd/79bujuvwSuomzHJOMs=; b=c394cIolw4IhKvhi6M2EzjVk9x
	AE61WNV4rcywswsneGKWFly7ZLCZD2uMqa7lpbYTjc5jEePrNmtuta0kRLESCGwz329uwpYFl4vCx
	KPFZVcpENXKyyEjPppZKPrydFMMyvA/T7xP9V9rnWth+NMoL4o6GPyjJ5jZFTupqFe3kFm93sa570
	KHm9Ku6BsXxgt/lUCDY581rZAQtw7VcyBcDigR+O08mgETu/X4JKwT0GOV5Hjlq1SS3y+2XV7fGk0
	E67AU3ZpAEhsEJWo4RWBk4cApB9cQlerzwjtAfS0Zhm7rwa2iQPPjg0jFyl2uDfjQgEWrLn1VS+EI
	TDMBozaQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:43682 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sI5bJ-001j6w-0h;
	Fri, 14 Jun 2024 06:00:13 -0600
Subject: Re: [PATCH 6.1 00/85] 6.1.94-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240613113214.134806994@linuxfoundation.org>
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <14eb0b11-e125-6c86-f9eb-fa41647fe9be@w6rz.net>
Date: Fri, 14 Jun 2024 05:00:07 -0700
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
X-Exim-ID: 1sI5bJ-001j6w-0h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:43682
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOS7oxky+j8GDEPcawfXJCFyKslB64gsOXbjAVcop4Tn7naXDXDyXSSk9ZU/I/04X9ky6vsjiULx/rFJmf5DaiVzqWf6GeFiq1ssgvqZ6cOCuSyv4y+1
 Idck5q44Cot3chR9qgAvkpOCvcBUJ3HAQ/6yv/Nff919/ExCMaPfwmvp+Ls/uE0Ml7D9T3rXJe2ghFGbAH6lVEBm8+rD6C409QA=

On 6/13/24 4:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.94 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.94-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


