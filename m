Return-Path: <linux-kernel+bounces-400916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4DE9C13F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8DC1C2198A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E519309B;
	Fri,  8 Nov 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="NilH7rSr"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9EE1865EB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032129; cv=none; b=NBXWoVz5X2yE09uJpOq5te/PuhgYY0EIBKt0+GaTTgjjDUewBZPcs1dn/UGCMhYV/xP9m8Kc2K4D303dw/l4pjta1eLNTD1b9NhkNiwP6NTKTxvkuZORexGTBwT3rupdZRLM3kHsRe1ABHHqwkeBIXjsIdfRKlG6/EuC5c0bAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032129; c=relaxed/simple;
	bh=mcW6+xOxi5H+Fnarbhz9jhIyKG9wThfQ05v0ecmc5rA=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=XO1z8yMm4X6HxcN+bDnKud0eRF96VinGWsZ4pHWzOb5p4p02siySIEETkbRRKRHpQevIi1ZHh0pbQ49mfof1papm2cm8FW1wvGtMQ2txK2KfZ2vfqktmpE15lfh0MPQtqfyd5Uq0XFrd48iQW4RBtb9FX2LtC44ptnloOHVoObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=NilH7rSr; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 92gRtjv9SnNFG9EWvtymzG; Fri, 08 Nov 2024 02:15:21 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 9EWut4nTahpRI9EWvtBZE4; Fri, 08 Nov 2024 02:15:21 +0000
X-Authority-Analysis: v=2.4 cv=KsJL23WN c=1 sm=1 tr=0 ts=672d7439
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8pBq5nZzN7qRhjUDnvWtnO107E9iL/uuUpSysjylwVc=; b=NilH7rSrSnMIxXXRHVk1TrD249
	Ei/qWAgMHtTAyxg4eAvxDLQM2ZJj5AgemGRKsojPE/a+n/Ydg0fwzbe3urL8Eo0GS6ontUPP9scgW
	3zL2v0zBgYSUK/FAVFckVFzPsl/XQivq3ySt3R5RNdq8uegFMwcqRkWFAxhwYfmTmduqgKGFEMhnT
	ps782iW+vuTusQ+RcLZXy0asPBgd9e6Jj2HcyvRCdgkDQgnhTRG3pee3TT/QFne1dIfan9reQK8js
	nOWk+8pp8Lgwn/lokayQSTP6dFj0wWQDd7iaTmwaD24hHscxeKSHaxYdJLsDU76Hw7YVRxKUwiVGM
	hcRewCVw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:35494 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t9EWs-001Sqd-1r;
	Thu, 07 Nov 2024 19:15:18 -0700
Subject: Re: [PATCH 6.6 000/151] 6.6.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
References: <20241106120308.841299741@linuxfoundation.org>
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <3c3968c1-cac3-4a13-b3fa-13e5cefc7e27@w6rz.net>
Date: Thu, 7 Nov 2024 18:15:16 -0800
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
X-Exim-ID: 1t9EWs-001Sqd-1r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:35494
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDH+dVkZ/h6NrfNODjKcmsI7Bg4jae1GATXRntjpRsp3RXnU3teQJaFB0jRxOa7RLsujrMK7hw2o9H9sWbbvIXYuVVo6axooilLgN2FE77sCFld7ibKY
 YtBAQF08ywg9z0kY7zOgfAZBJFTKcIW5/L/u1SPmhQ8aRsDuW3FGTagAu42Iw8Fx0sj7LCCIObSooScoHZh/78ZWaBay9xJ77zo=

On 11/6/24 4:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.60 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.60-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


