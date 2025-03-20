Return-Path: <linux-kernel+bounces-569470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB0EA6A365
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523673B795F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CEB33E4;
	Thu, 20 Mar 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="KVzzrbTP"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EAA1A5BBA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465741; cv=none; b=PwTK301KdPoE/jl7BzBltTvLLPoYzie0rXUd+VltKociptwHg3Q3u1SALsGLx74slubQ80zI59Z5cL9wKFqDiWubjv7TiXF87WSDjzhpa7hY9IgzHSq3XzNFWj7A3s+mf6yV1D0kS6WqYZrxQqIuWfsuQbxvKyZdIJAPDPb/uUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465741; c=relaxed/simple;
	bh=4VTXpDEltRP9tmY/UY7UmnYkLoz+YKNmwptimwr2jj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kO4j4yORxelft4gKCbFMa/dlvHI8ANe2jpg6y2CrdYgbmJvyN65/dTS6bTw3fEF6KLTGVJ1oAHbsSjfKDFu9fRCuzpbNOccblK8SE664o7GLyu6Cfp1evy5p/UCL7EPq72LrmFaZdQFgQqzYLBBqd4MQqh05rfWgyOJajCVgjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=KVzzrbTP; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id vBkytglQbVkcRvCw0tWLSF; Thu, 20 Mar 2025 10:15:32 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vCvztRaRORlrsvCvzt6cCL; Thu, 20 Mar 2025 10:15:31 +0000
X-Authority-Analysis: v=2.4 cv=Qamtvdbv c=1 sm=1 tr=0 ts=67dbeac3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CugIFSejTzcMExHdPSZF6GXe9DEmJbUCSV3ntiluwGY=; b=KVzzrbTP0ctNDWfQvbMHFwGiDE
	leWcpLa2HUUXT8nnJSe0fbz/xdRdhXaZtQ8Hi1uIQUnRAzDk+MtmvJxO1JcLB7PkPgaRG0Df0xm6I
	RgfCjBA92uQNdCT4/JXLW2dFDoCJTFSLGSwf9H0UCkNg6A06R+vCcMoiQMgLw6sq7zZBeEN5qKiX4
	INmQwMPbCdcY133xUIQNGtc+ZiO27aGmkyeEhrOMztjji/xIy6As2l11Vpz/K/GeFqec/GZoerawC
	/7/K7alxk3tUlgCcK6/yue0Vb/QscPHpOMxvz7Po+DrkkImXOEzdtkMnGlHvTSyoYkNTpTkQTvWBB
	K+m1v2kA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:48944 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1tvCvx-00000003IPl-0Xg1;
	Thu, 20 Mar 2025 04:15:29 -0600
Message-ID: <7d7f1f1c-72e7-49a0-abdd-fa1f8d924196@w6rz.net>
Date: Thu, 20 Mar 2025 03:15:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250319143027.685727358@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
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
X-Exim-ID: 1tvCvx-00000003IPl-0Xg1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:48944
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI5gkrcEqbxHIvoRX0FqBzinvWWmRCJQe4+2z+DvkDkqZGANt27JxvP/OL/LMTHuQvXDvpZjAkafBgR13R6e8Q8+O7m3UtUofXLkVLZWjL2sUp5rhBC+
 X0RJfSydtY+hKKRAU4dlDRbs2XuE5EpP6cFqe8tZhWf9G5nnPu8lhJXiWTPIO3L1LgZo22+Jal/x85++e65z9NKyaSOUgkyDqrU=

On 3/19/25 07:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


