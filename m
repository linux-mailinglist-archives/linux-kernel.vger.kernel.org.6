Return-Path: <linux-kernel+bounces-255228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8715933DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168731C2297F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203C9180A6D;
	Wed, 17 Jul 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="C/jFbqPR"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE591802CD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223422; cv=none; b=FrS24pIJuw1QahbyFFVFDZ+IizgJ9Boz34WD94w4TCEbwdCSkc4GNGRw0hj5KqHeuXBx2loIGMxXaT91NBdJqL6jw8RD1Qe6OXdlErQMXZ7XBcPmP63zy+w/8EaLA6tS8zyZEfvGMrcQS58+qD2gk4tYLJUK63mG4WgUrryK488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223422; c=relaxed/simple;
	bh=gFc25+aTieHILquz8TZBMxHk141z6MjGAqix5s+Bb6s=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=W18pPlqLZUweM0qCEaJ0hcCMSqqnEjeEAZUAtH+Sv3cE66BlW8b2u8NDHl79Cg5mTkz8yMF6KJ078bzF4EGHA3bSNh1hM68xtoKWbul8vMc+1v+UJZjCHRzQeJeaLFPvynseFG6q46ZXcsdQjVfO8aQnpm7z8woorQ/hJLNTRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=C/jFbqPR; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id TePpsWX9onNFGU4q3s7zvX; Wed, 17 Jul 2024 13:36:59 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id U4q2sSbf84PreU4q3siQwl; Wed, 17 Jul 2024 13:36:59 +0000
X-Authority-Analysis: v=2.4 cv=VbjxPkp9 c=1 sm=1 tr=0 ts=6697c8fb
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a20dnE9ujfw65UJe39jtGgA9aWrGKfkl1W7y0XVG0OA=; b=C/jFbqPRpw7NnxUAW6hL2mr1j+
	M2i3yD0T3Da6lKk8B3xFCMmHk2doqy0+8GsqStLZrcH8+md0+5UZK5AuB8XCq6ayDMU4rvqWT3YtG
	tqyGa1eUEgN+ydfYiZyxS4PZu0cM9J9XzvlDNWaisly4fYnMF3dE8C8f8ytAknTbymAqhr/i9hbug
	8rguBBw0hgzwMcMU2FPMLK/ScM+YQAlrb6OK4oZlm3pF+K2D1VxMYJm6u9/iA3QgEabPSaBTOFGfK
	2V3uY6VaWSUQnQOElWAX5ELCxiVCpyxxtas+W6dMbdLGE9tEZa4/qNWgH3QTnaHy08IH7ZAOwhM/w
	wxUGb19w==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57968 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sU4q0-000UZm-2F;
	Wed, 17 Jul 2024 07:36:56 -0600
Subject: Re: [PATCH 6.1 00/95] 6.1.100-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063758.086668888@linuxfoundation.org>
In-Reply-To: <20240717063758.086668888@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <190e51e5-c279-ec7b-90c5-8c32523321ee@w6rz.net>
Date: Wed, 17 Jul 2024 06:36:53 -0700
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
X-Exim-ID: 1sU4q0-000UZm-2F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:57968
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPy+PwiZB9SuVFCS6+nSEETU9F2E+T+lGV26apB3oFDmzYwJqxGgjUaFJo8E5ufc0/iliPiS+hMKizPo0i3FRCQEB2Zq5KxE7/AAy686kEFccCS7w7fn
 AzZXBaIKji1Ge5Hq2x9hk8LBXRmTX4Ha/JP8NhX3AyiyHE1Btrd08qDwu0XXAwgRz+DgF6AhiYJ1nDb1Z3zLgVaYWsqR95ErdNE=

On 7/16/24 11:39 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.100 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.100-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


