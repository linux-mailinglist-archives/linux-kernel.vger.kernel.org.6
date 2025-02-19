Return-Path: <linux-kernel+bounces-522607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB95A3CC47
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FE8189CEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6D02580DA;
	Wed, 19 Feb 2025 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ZopvyFX0"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E825333B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003956; cv=none; b=U8Q4qwifFdXFsd3fLW2KjplTaQGFnJUYsjM11aCT2DhioyLXtqniSutLN8CxIj1Nk1F1EtEPDxYnh1g0IqTRuHm26+i/UVoWSusWZW4TxcbRDF5pUhUK1MKtcC4QpwoJJCHtNly2WU0IsUdlcBSOaC46ICi0eeh/DOJty10hieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003956; c=relaxed/simple;
	bh=u2tqcqCTos/mvVoG9SA2/8Mptv1CIIlVh0FDbvQwBG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcrwTM0KoWvwW+AzuGwFJidQxokcvtuBKY4yIph3qrr/ABegLgME24M+z0DdgqU0aRaJ3neARKfTfU7wH//8wQelNDURy4NsX8yhuYX1aFTIGdtZRJ7DQueodq6PB2sMUUr+2Q2+VIY+XYpS4WUXv6O0ipkZYRseYw9z6PNAbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ZopvyFX0; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id kKLhtIYktiuzSksVotBu2Z; Wed, 19 Feb 2025 22:25:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ksVnts07SbZHUksVnts87w; Wed, 19 Feb 2025 22:25:48 +0000
X-Authority-Analysis: v=2.4 cv=M/dLKTws c=1 sm=1 tr=0 ts=67b65a6c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XuDxmZHshaIfwV7d83o/IVeM2bOm16daCRLmJQnB7Y4=; b=ZopvyFX0iyz6Qhk7kNFrfidoVR
	n9Cs4mwCVrS0S78Tc2TXH79j7HFcpiCWyd0fEEey4QR5VlOq01bIUZDj5DQzxlUi5FkYwlETK+O8e
	QZ2y0ORjpbx2PTknDSOmHUDtu1Kcepu9LxuuKOyxSdJZHt/pUvyvdqik1w/Bp5KrjDPWA5U00QYgP
	flFfWTwP9NUKKSEQPSX+P4b+bJdE6YrD005N4/tg22SFe/ZYGYGtLc2djefh0xA5KveZMcC0Zo6rn
	yhO8CWcs830KS5WlMgUqJEProsv+Cgd+tAPj356hudoaJLBBMX7VkRKL2rlPTmbz4ei7TDZhEvHDs
	DHO4E+6w==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36884 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tksVl-000BhJ-1Z;
	Wed, 19 Feb 2025 15:25:45 -0700
Message-ID: <3db657cb-ccc2-44ab-bddd-bef10e6a5462@w6rz.net>
Date: Wed, 19 Feb 2025 14:25:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/152] 6.6.79-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250219082550.014812078@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
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
X-Exim-ID: 1tksVl-000BhJ-1Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:36884
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGPAa0FthCu4CV0tgayDWaZe7s27jK+OyKIe99H/8cwHpv/7NIs5wC+OJCiWTli/qaAc9UOoqRQk1PeS+8dzLEaohQ69dj6eJ03WUsGrla3NrdZVQQl3
 3eUo8kMNLcDrQ9Rqbu/ceD3iEes9hEN7wufgYGCpio2RyR82i7eLxIietE1Ygj7YoxVN5frU5suzHO8q/bclnOmD3JWwJAkCttA=

On 2/19/25 00:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.79 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.79-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


