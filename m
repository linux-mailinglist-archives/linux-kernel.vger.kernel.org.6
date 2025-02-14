Return-Path: <linux-kernel+bounces-514414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A175A356C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAA67A4D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5B1FBEBF;
	Fri, 14 Feb 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="DtQBJAsp"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505E1DF242
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513470; cv=none; b=aRc3eKBpmcwNq/zxK5YuZ6JOCPcbR22kks62IG9EByapiRUGEgHOy3wMyrk4K0ENWyLqKTuD3zifaEkOs94oSUmNC5NHlwhGhAv/b5oVl25T8/UG2GG3OAo9wrBlaKILO2Vn1QNN6hThnCYPQ4KHWOv9koQJxFk3SmdwKJk6vsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513470; c=relaxed/simple;
	bh=EpxQNILeQf4iHUHF9psqZqh37LlM3snSG06cnd2ZXVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiVIzrBOXxodOTIUC1cmncMYOosv/5k7253rGLAGjCq6LovKe93QU8WlcCl3eBxOcDHL3wF6qKWtL5BNSL8NzfNoAhHw7p0b6BROTz5kpAfQJAko16xceMS1u6bqFfsgX+JFO1+QIXh8TNsv5RbrVVtOOpOhF5lkEqyVOtxBQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=DtQBJAsp; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id imaZtJJclWuHKiotIthI0w; Fri, 14 Feb 2025 06:09:32 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id iotHtbNJGs5XHiotHt47nZ; Fri, 14 Feb 2025 06:09:31 +0000
X-Authority-Analysis: v=2.4 cv=avG0CzZV c=1 sm=1 tr=0 ts=67aede1b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=4041MwwcWqwrnTXoSgMA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hHhUPKIyS1IaI5YCk9QFOAYvzJTNPcTF17M8bgIhefM=; b=DtQBJAspRl58PPehvPSBt/e0f1
	bpLT5TqJiF8fvFOY7qXuVJDAcuRcIw9RDu17gL6XX0JYfnOhgeZqLZ+DlL8qnY47vidoh06/L8Zqz
	+9RYsv5E6kaki0lPyLiP5siIro/acUrfmCnr8uXI/ewUF+mxE72lpUwuALyCbYb3da93T6Z3wZr+v
	gdEvrvpCnEhPfQ7vJilCTvgNwOEvAa4e83Pu1evDbB09Nhs+FBO+mVnTALHrNNIcQFyZjTtOxNtoT
	+KQyXykLjxg1fIgOEnuIwZEGx7/ShhJjzTkza6BaMTNJgh1WCOYIbvpJIhoHzSvfxtNCQqxK0Vdpk
	+Yb+a4KQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38664 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tiotF-003d6P-1k;
	Thu, 13 Feb 2025 23:09:29 -0700
Message-ID: <31805c47-3245-4b92-87c8-8bcd6a049ac3@w6rz.net>
Date: Thu, 13 Feb 2025 22:09:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250213142440.609878115@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
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
X-Exim-ID: 1tiotF-003d6P-1k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:38664
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDftexOh2t/8v485G0sDNKY74cIugOcyoTNgIZqiRrfg88IyENQG0uq6CC/A+TPoCRqLZTbXIZdoz+Z4sdjGTvxrR+yxrq74gjB4zWy9VLteliRBPWL2
 6jtPx1ne/1QAl+z5SSAQJqggqNW/xoyGZNJsrvLM/t2sNhQ5IfK+OD6Zuh/xhkdA2iibpH3BcT7xyiG98nOOP+KT35iY0sdvx10=

On 2/13/25 06:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


