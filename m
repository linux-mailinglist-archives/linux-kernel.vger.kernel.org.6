Return-Path: <linux-kernel+bounces-319533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C4A96FE09
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A20284D19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0815AAD3;
	Fri,  6 Sep 2024 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="43anE2gk"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477C1B85D8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661949; cv=none; b=EtNt2iPL8CBYqABMRluz+dk3O4rnzuH4zCoGrZDwvZCy9XGVoeK0DZfX1roAWY6rEuPumPJ3AwboQv0qunI1UEEo2n2NL19EBdeXAiur44ApRqM8mqsAezQU8Uztf56mfPCKN4slOEYHilb4HcMogyWE5ZiMBQ/ihcCd7kUti68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661949; c=relaxed/simple;
	bh=XSlIhTL85Dkf7AG09eQo8nLBuD0ZJMyOsY3Hl7kCHwQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=K0ghWP/fFLPObti7kx01tTxmRVsWZBzc3iKT1hJycmuDoizKbrUdDX15N6hWVy4f74C4fZ8Le6FhQecsmhYKvVIlRoqGll/KnEBb6uAYSYYDjN71ZSP1wrgolNoqaWY4VDadpMctagONn/2zOb00MsroNLg5rXQepfVlR/6hPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=43anE2gk; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id mZVNsp0lWvH7lmhV6s6uAr; Fri, 06 Sep 2024 22:32:21 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mhV5sE7YFeCxMmhV6sUehC; Fri, 06 Sep 2024 22:32:20 +0000
X-Authority-Analysis: v=2.4 cv=M/yGKDws c=1 sm=1 tr=0 ts=66db82f4
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=BEK6XHwdWclZZPXDZJEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rDBREgK2nH9Lrz8BAvt0Zr2D2ezNqb3hegHj37VRtaY=; b=43anE2gkfSBVW0YXX8O8sb11rI
	S/Tf1whLfV3kOEj7IcMe4HO0uqQbPEi8SPeyIB5DcdvqYqYmmg4psEvgq5E7enUaY5RUxqnlE0HVU
	Txw7s952kc08M6ewvnC6IP5nBn45aapK3z+HQi3miqjAaC0LJLG4svSOP+CZMss/ZXYV877ha6JDo
	t7Imk6zcKVDGeMii6299itZkNUP3hEkMgZenRp/VkFQx74sfOPH8RRvR8NzQ0+71x1P25O/NhMtdC
	VABNmULqQ+JRsjr+elQ33K/33wcVM2/3KqGFA8CCu2aNZWva1SG7kxzNb2VT0kqogC/PxdamTBZKo
	7urhr2rg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38802 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1smhV3-000aQH-2w;
	Fri, 06 Sep 2024 16:32:17 -0600
Subject: Re: [PATCH 6.1 000/101] 6.1.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240905093716.075835938@linuxfoundation.org>
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <82de129c-6ed3-a47a-ca35-3bdfa7c23d89@w6rz.net>
Date: Fri, 6 Sep 2024 15:32:15 -0700
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
X-Exim-ID: 1smhV3-000aQH-2w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:38802
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEqcMqx2S4S+WyjwQXgnixVHWF6Ss3mQ3Q/aQByuRntPw7mfL52lCuz79I87zrnLAhIlECKX2p2bPYZxx/FEmXkHvyAKyyQl8OT7yxR03srcBHutw7BN
 fjpAiDUzO+U0CEiWvnspTk4YcBmfpaK7GD5k+1FhDiL/Mlp0FuwyyEFo+qDXthCROexOv9yqDV5tXKVx9x7wCX3WgHHfF5YZISk=

On 9/5/24 2:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.109 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.109-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


