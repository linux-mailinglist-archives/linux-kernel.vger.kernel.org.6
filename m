Return-Path: <linux-kernel+bounces-416541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2179D4695
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A66B23338
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E81148838;
	Thu, 21 Nov 2024 04:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="UOHenyob"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC9A2309B6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162856; cv=none; b=GjJ5eV1TE7E9OR3DU/dCdSMNaugdSJvIBmGIzWN5Y5fwsxsuIm64yqYJm9TsfHA0KZROMLGPWgd1CkK1s/r/t7QkEw9gSPQ5Fablab7ORTIUUxnPP+LxCq3gmRCRM1KDs020FSW0dYdfMfXOvOXyX6ciES2rGy4Ct150F9NQKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162856; c=relaxed/simple;
	bh=aArlU4tpz3uBMTCOrMzLqbpBYisIgpk9/gwftKpZWyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BewvcwC2d/hgBReq4JuvO5/x0SMtZirESQ6ts+nDdLjMpsZXco3d2EB1IjYDzmXzODwjiLBTVc+rJvMDlm3Cu4jO87qL+sZoNbEcQ+iwQz0lhhh2tqaxIL7C3FZ2sQ+rgJ1rwku4Jp+by2O0hMyukZmx2VQgp+i6J849GbiHNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=UOHenyob; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id DfWAtlNF3iA19DygStJvhv; Thu, 21 Nov 2024 04:20:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DygStzEDq0YCNDygStPhEH; Thu, 21 Nov 2024 04:20:48 +0000
X-Authority-Analysis: v=2.4 cv=ZbIbNNVA c=1 sm=1 tr=0 ts=673eb520
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Da7nlx-0jZ_hJutoApkA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ydtcdRxwB2ZiytdFSHOrOV/wlQ/taDdubAe7sgkSaBk=; b=UOHenyobkWCGV0OSDbMc/AkjGd
	6zlmguY3AbGGI2osQvoXqWJqBLwBqBau0I+vEyoQnYmxqcTNDQZ7O1Z2ahhdQRK6N/PEi3/Ti08KV
	QFKVzextbWRwkRgRZsfUDYcWp9P3/mMpzrL0sdqx1YpcXs14FL0i12ZCiJYAgQsT8YQAEnTn7A4by
	maNx5W9EIc33WTIHgJizn6kjwg6FIZY8iW3SmYdu03tGr+ImlCxTR70NoLzZwlhilxM/onhsUhaZs
	R59Dah/pxStKb6DrvyR1xvyeyAszVJ5VYfdbyU9jd3+GTnRO+MyDDsEiG0OlexLEdD2xLA20fwRhc
	4CttglfA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:35326 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tDygQ-003Ghs-35;
	Wed, 20 Nov 2024 21:20:46 -0700
Message-ID: <2bde7bff-a41a-4304-b6dd-8d5d62e9c312@w6rz.net>
Date: Wed, 20 Nov 2024 20:20:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/82] 6.6.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241120125629.623666563@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241120125629.623666563@linuxfoundation.org>
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
X-Exim-ID: 1tDygQ-003Ghs-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:35326
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ3c5h3/nCkkQb5SFRTor9gRoVW4fSfuI/hdKmvSKHDRxIAoyeZep1BCvD81kPXjAtc9usF/506jONeScMornsHIgGKdRZs1Degxi97Ld9b4IuQa7kOp
 nmswi7TVNUk4kkF94xboVU2/a593nxWWWsHpm/5I8Yoae/pIF6z24hm9R0s/DzmzDYK8P3v+Pri6gNC17jDMbqVBTs8JHQN06mc=

On 11/20/24 04:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.63 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:56:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.63-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


