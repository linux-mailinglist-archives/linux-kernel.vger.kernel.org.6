Return-Path: <linux-kernel+bounces-342866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F69893CF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CBB1C224FF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F63613C9D4;
	Sun, 29 Sep 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="GdQFGbM+"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277713B5A0
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727599413; cv=none; b=Z80InPc6gvRY9zZW68A5lhCavBd4QAxNr549pHT46rVK5v7kAZV1fHlbs3yzC/UL4J6AxtK7MecCblsAp+ZHkZRSKozBMa/YiQ48bPgu2i3dbyvQdTgElwB4kGsxsTz0kc9NaIo45KvfNxjN+EHXKJAirWpNek5ZvOIagknCo20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727599413; c=relaxed/simple;
	bh=T19KQz2/tTECmsi+5N/bBijXJzba822WCfvlRud2QjU=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=o9yNIRg0fuWqB1eHLOBPWiwINRDZRflcv0cURngHwi0Bx+9voBFX2lJeHp2jEPP80UJLwcHwdTQR4AQP8AKCFGPPcNoqm+BAE3Ksk7+glz7mwoibew7amLgRJBbW7U7BIthKpvhVyPM9Krc/D0LvVVgs5oa0IQGvqv+2HRFISpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=GdQFGbM+; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id ug6csq0hTnNFGupWcsgHlW; Sun, 29 Sep 2024 08:43:30 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id upWcsIliHmNYjupWcsh0yg; Sun, 29 Sep 2024 08:43:30 +0000
X-Authority-Analysis: v=2.4 cv=fb9myFQF c=1 sm=1 tr=0 ts=66f91332
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PeMHkyFFRZyyPOSMFU2k1WM65T2JKiwqNKpCmYj1jqA=; b=GdQFGbM+R61tslx17hD3031fUZ
	xjkEINEhnsTZFYEoM2R9JazkE1p2h1mq53QW0QyHXv7U90VqF34YND/hv9BU9VlmkdkKvH/Thoa2g
	Mn1RZovERGasEbfqjKqFq0Pl/JPFkG6yvFfq3mTVGKhFSHUfxDXVlHRuUGE06aqftvYodiT0HAiP4
	y8NqFAR95OtHKJG/0zSbCs2HHlPfLI6ikKFFoPtUmYBA41ZMGAQkLcgZOX3VLcbMo0ustgV94p+0V
	4Ceb94PnqX0bVY8qVq4quEeIGxNH3PUQb0gVCA8X66kjl60EOGX39Gnb6CQCLSid7i/XpdzGoqTSe
	1s6r7SdA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:43258 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1supWa-003szQ-0d;
	Sun, 29 Sep 2024 02:43:28 -0600
Subject: Re: [PATCH 6.1 00/73] 6.1.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240927121719.897851549@linuxfoundation.org>
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <b8dc892a-7b23-eb3d-f016-9494f2b902b2@w6rz.net>
Date: Sun, 29 Sep 2024 01:43:25 -0700
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
X-Exim-ID: 1supWa-003szQ-0d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:43258
X-Source-Auth: re@w6rz.net
X-Email-Count: 61
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMhT+jIzKXF3Epz/NJShLIOWdC+CtFJFYpD0ASBNEGg8WSuM5wNP4x2PDQEOMoPKv4+vDc9KjcQ1zPCM9K51jSD+0Ak+WcZ/ZcwUU8V0GyD23RnQY60k
 gk81zGoedTl06J/tjvsJdu4hOKRrQkzv/C9R139MXwyDnw+N+9mNrI2o6kF3Gzay3v4Pjphryy6mdmpeUOAoUTn4LJc8nhEBiy4=

On 9/27/24 5:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.112 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.112-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


