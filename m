Return-Path: <linux-kernel+bounces-290301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC76D9551FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA601C20AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329A1C57A4;
	Fri, 16 Aug 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="kERu4hm+"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1991C3F14
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841102; cv=none; b=ukRLyRhPKINgLYtA9HDClztkOx4J25xrHyoo0RiPh0InqvepM5b79GVv+JrW/EzUguhPlUisr6W4TU7dm2K2Rhdu3BurlwfR6KirXGvTR1lHkqJHe6cdLDFFXFnGuaLh62kKBFmlR85fmsu1zNpdHGb3/Z3+UBPKi4fQFHOsSSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841102; c=relaxed/simple;
	bh=D0CIyrrVM4FwGv/7HrMqU9NODuSehPITjjwcgc4dANE=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=ADlJURH14BFU2AYuLzOiI+DggQUWNljCgV7qCLkyjhzsCjl192Oc3H3ETpXeWKqPYFGC1S/pRVOE+amr2krFUnN5foJuASvtukJscqQEZMhI9/PH4AlNt2hbQ5PSaBjBQg1dGJMRuNBneN0PTTcqs6rOoocIGPKxIbwbG5ljCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=kERu4hm+; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id eiLisXZG1g2lzf3ohsbFIr; Fri, 16 Aug 2024 20:44:59 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id f3ogsA6cqRBkMf3ogslAy9; Fri, 16 Aug 2024 20:44:58 +0000
X-Authority-Analysis: v=2.4 cv=CbPD56rl c=1 sm=1 tr=0 ts=66bfba4a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=dMa8K_NYSMvRJTca4hgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GHlsHH8KZhX4WinjSa7N+Lbm/VjM/IFlrjYyrlMyRMU=; b=kERu4hm+sd+T1lmSJ4RQvz2Qw1
	+mJXGMf1RtntWeBFnqubS0tBZvIeuvCd3QNMDdQoO/C9IVUItgnVGdgVqb5tT15/7khF0UYSjlD6k
	G5deIXnTbBNt6+cIhyiR65VWh5mRqijmIVzaWhFz315dAMUGuFXblsdrQnt7bQFTvy9ONUuWO+ac4
	xZKTLOCknQt8pbV5aGPDDT3dqXIJjObLtT3DlLYGqBcEysdSw1D2lpkE4HU0w+aRg8q+wLyTuWvt2
	0Att4gmT4oXMwBg7P1T2GkiO6YaXnWf0MOdGUJsnv3f8DSKc8YsR95oNWiTNA+A2klV4r1aMXxHiq
	62tFmVpg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:35224 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sf3oc-000AtD-03;
	Fri, 16 Aug 2024 14:44:54 -0600
Subject: Re: [PATCH 6.1 00/38] 6.1.106-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131832.944273699@linuxfoundation.org>
In-Reply-To: <20240815131832.944273699@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <bb711081-78a5-a8bd-3605-442db115b69d@w6rz.net>
Date: Fri, 16 Aug 2024 13:44:47 -0700
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
X-Exim-ID: 1sf3oc-000AtD-03
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:35224
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKQYJX1PWs8jj4b+oTv/DrtInmvdOMqvVdn7DDL2ArD6N65SWN8Nc70N10+l5Y6Qvv1FvOwXILlRqO0CwZRAm3hgEOItQQ1ztm1AhuyI5ZVt0oR+qhJw
 x+ulS0UAy/edQhME9NH87mAVbTkest2WgvRj0FdRyewV5aUn2XBQ4wKPfDb2pklnPRiHoNFm4arxc1JwRkpQ6VKRNyC8gUGargo=

On 8/15/24 6:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.106 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.106-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


