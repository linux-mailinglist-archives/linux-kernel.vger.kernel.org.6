Return-Path: <linux-kernel+bounces-279475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E894BDB0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B35BB20F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518318C910;
	Thu,  8 Aug 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="D6EeQamn"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509818B481
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120848; cv=none; b=Kax3e5EuvOnaODLexRDyq6JyMb45WRK90nvCJoojgMImDObxgBZ7a54Wjy0GbNN2h/r388N8L+oferBtWFQAHVqc/EWQfNPbmgwkODoiCgWrnLHd6n35v1bWYmq7eGIU54wWQsbijjsD2W1b6VqESEiBZfvxvt1Bn2SS6nzBed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120848; c=relaxed/simple;
	bh=KsVV2fBPJDERdcfEPQFXxnrx85KBK8pNG8vcS6YeqRM=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=Z6O4sJ3lXkTcpPY2YJaS3LjDmEbSEfgTvAnaIj7uzWFt/U+QJ13aM6ixTSc/uNPf2ftRupUqVmVhB6jA/7cKHFKbmcDNaenzAyqu5gUivPWnjj+AVJdkupt8+RjfRa8NPtZgkp1mMC7JBporru/hi7aa6oDs7tTm52G+WDND0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=D6EeQamn; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id bIWrscIcR1zuHc2RasZXsm; Thu, 08 Aug 2024 12:40:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id c2RZsw5pjYa78c2RasnRI5; Thu, 08 Aug 2024 12:40:38 +0000
X-Authority-Analysis: v=2.4 cv=Db4RqOtW c=1 sm=1 tr=0 ts=66b4bcc6
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
	bh=6mVBh0IM6vLBMp1B64k/EKQM9pXf/Sglzn44S2603HQ=; b=D6EeQamngAAD9b5isroyWWPvqL
	E00PIYpyCdvxjnKDhBHiAASoZ9vGr2PQmhpnLYb/ZJdWp977rm0GFXQWlFQoI0cf+NBeOpfUjD3og
	boAKVMSjI6TfRen2PRUzZRVsmUMgEJBP3uX3i+OJuop0YvN81rv7A8rcfotkDNUpueksa7aSX6lbX
	J/Y5f/LyRMkrlgy1iygXkypnIlrl7KPSk7UM6XFRqTrnoIug3P57/OrKjxQlEiJRoeqNsbUBNjWgs
	2oZWI/ri/E9tOeCsSC6/85lNBpBBIvHgmcBr8R2uXZ+X3YJ4g0IzQxDNStZdQISuvhYMyxOmcxGxT
	Oe5OSgAg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:33440 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sc2RV-0041Wh-1p;
	Thu, 08 Aug 2024 06:40:33 -0600
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240807150020.790615758@linuxfoundation.org>
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <e8d1a5e9-3334-9a74-6049-5078295289bf@w6rz.net>
Date: Thu, 8 Aug 2024 05:40:27 -0700
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
X-Exim-ID: 1sc2RV-0041Wh-1p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:33440
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJsCi2a10pJ7vKy06bB6fZyG3TRrDuzIeCsQVf5x1wSmlclkhGU4qnaKy1G7GGY4rJ5u0swE499aB6JscWwrg5hz9eZcDsIFDDpHszUojpgh7HqU18DX
 mdw3C8CpTYRG1cLnnWwwjvdUBGZzCng7LjCpiKJbn+x5YpnVNoq10c3wHaZTZzKsDeM1/h3IBdg4Yj7hAcNAoKnGdgUbqyPIpQM=

On 8/7/24 7:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.4 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Aug 2024 14:59:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


