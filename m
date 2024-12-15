Return-Path: <linux-kernel+bounces-445696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303799F19D8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2F6188DC7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97E1B5ED0;
	Fri, 13 Dec 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="y0lx99um"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853F2E62B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132420; cv=none; b=koZTmBO+Ny1Wd0zPyI+uyxRMLTHwBRBIrNLRJLhjNru/4S/xtLxhWCII27BEQ4YBDM5vTzOU3mtsy951NsdrWGSlfyxn1mwANuh7j1yw8guNW7H9ZZVWTVlZroH58X8uxrySFEL997Oiv3wSvQPXjfzNxYYB+tshulg9HVtcuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132420; c=relaxed/simple;
	bh=BHrLTdwBiNKxUxgQMArlYQbP945rCn+PVan2X24N9h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8d9TBQ5emyfTLBrUfoMyaTw5lOhyP91uISYwKdWoAsU2oCQR00vIAztVHXnqX/gOTloTS1YZtG2rxJcJKLzcg2EkW0dSC3ZAHSM3Pyzoi5UjLVHxbh3iW3j4huoqoQJko0BWIpj6+9fEFvVcXu6O3odEyl0L0+GJ0wDeWxMThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=y0lx99um; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id MDtFtZ8qaumtXMF3htfRV9; Fri, 13 Dec 2024 23:26:57 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MF3htZnDdfkSoMF3htULX1; Fri, 13 Dec 2024 23:26:57 +0000
X-Authority-Analysis: v=2.4 cv=dtLdCUg4 c=1 sm=1 tr=0 ts=675cc2c1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qmSoeCZyupaVDAntIZ+imo1H1rHWMIT7bhpEXo504BA=; b=y0lx99umbqySOH74Ux2XL9l6qP
	N0ar+kOWrqKK5TdFkqVOtEd/Iy0Zzh5Ad8+FGKmt4TetiwAWhZ8YEITts+wuMFSVcGzg99sVWbtU2
	gXPIztTLOXBXBxvuBNHgTkmolARzg0dNqU2pEW5UdB1cSjNcxVmQzw7Sup4lbKCYwM1P4u+x4CuUA
	+11ac51X+k5v6bWaDCN/0zR7as3iFBp+0gCRsQTLwYJru7QAsPo2nuWW65DN9+/zoD0tqJDSMxBpb
	uryomNpHNNEk5t9gZytU/ESMzQ9g/FKqx+HJXzQdYHC/fSuO3aEZVP/HLvn3D9CT+rU8BazOGMoZw
	QmkDTCTg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:56392 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tMF3f-002UPg-2q;
	Fri, 13 Dec 2024 16:26:55 -0700
Message-ID: <3a9498c4-ea44-4bb2-a578-b640fedf4d11@w6rz.net>
Date: Fri, 13 Dec 2024 15:26:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241213150009.122200534@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241213150009.122200534@linuxfoundation.org>
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
X-Exim-ID: 1tMF3f-002UPg-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:56392
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEmCYHG5HzbjmcterXINHCGYC+aASKl+zKHhSb3PU/0GAB33JZs1nQ8NOJnqzKb01wALyDdzJeh4YtV0B430IzTiZC0rSazMDP525LyZeOTHtUd0N88H
 dWgz4q60w+IgHsdXnRg9fpFeK6gnZrc9MFE+dOIv6GFURpvIz8i0fz1jAQz7LBpI5U5MLEZWksQaudBCHMz6JqHruBMx2oEAopQ=

On 12/13/24 07:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.120-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


