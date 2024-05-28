Return-Path: <linux-kernel+bounces-193179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340928D2800
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7740B2172D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2173413E028;
	Tue, 28 May 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ZDpCT2Yj"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08817C8FF
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935189; cv=none; b=oQ+FTqViHBKb81Kc7f4hP1mLvZVOmC93lUyRQrfadNm8MbLAYv/5nQNJVz6dSWhxE71OmHzAVB4igUIn/lBDB4sKarqXv0vHhpO2/vvF3apCbPnDmG1R0MdRTZrSO9uBxuK+Ww35HdvY+p21SvM5dETfB7iJ7H8s0CFHgXLPQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935189; c=relaxed/simple;
	bh=jMfkznnnfae76gAqqY2DsKGqCOvHFrVXmQnewsFd08Q=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=q/068PbGHESJcu+8WBWKrm2mUwjRjQNus8N60ZkG0w3ytS2T14lVE8G9sWjPz8S6+4FFa25BfhbMhLCEpqRQikhhS7yYqgA+jHaImWW81BgWAdQGg5LuZcKjkTHb5bdzgf9oIpYo0KkvBmsbtqzG9E3g5HZZ47J59BBgHcuId0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ZDpCT2Yj; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id C3uJsJIfuAidIC5Gzs6sox; Tue, 28 May 2024 22:26:25 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id C5GyswRHfYakKC5GysCOwe; Tue, 28 May 2024 22:26:24 +0000
X-Authority-Analysis: v=2.4 cv=a4T79lSF c=1 sm=1 tr=0 ts=66565a10
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bS3Jp/lKIo3aDuxQIqM+MR8qJ9frs81TUT5DmdlVLpY=; b=ZDpCT2YjSS8pK55UUOdKwenFA1
	NXS/+xyYciJfIqddW5I8BuANwjImqQ0VzEAHiSjQbBwXkGwxaaCndy2p8wFDIcsUmIMtwDXvDhap/
	h14V/rO47N1O/GynaeM6bmIspT7oICWL7rw7GIw5GoDkNfz9lxgUw3MtrQgvLYV70EqPI0sIkSZCz
	oYTfI2WW5P5fXgX+dGtoJWPDwh/CH94bESGJKrnJ5UthE6QMBSyGJ2IKCyEBV0uYI0lujoJO2Z1mN
	qUxm6H3r6VivLh3QAS3Uf8DS5mUpXB2bRRworH7KK7yyq2hmRIBfMjfcOu4yEcLX78DO2h8w/jlTQ
	4cJy87rQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:40666 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sC5Gv-002lPC-2k;
	Tue, 28 May 2024 16:26:21 -0600
Subject: Re: [PATCH 6.9 000/427] 6.9.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240527185601.713589927@linuxfoundation.org>
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <db3b85cb-7edd-5404-f6ca-c9db8b1b0255@w6rz.net>
Date: Tue, 28 May 2024 15:26:19 -0700
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1sC5Gv-002lPC-2k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:40666
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIZY5s+G6RSGnLZFvqS0ihTuDJRb8kjmhVFM9FnFKe3SkoQvXUq0sFRbtoAeI58dGMCo8uQpCbIXe/iGQQMfC0MX4Nsmgwn4/iaxTyG/KTfF0hXZoCk4
 6Iy6vQLkInems03+oRaUPIbWupG+Paf76a6SJIgZnTBx+ZSjFcof7D02epYiQL5daIP1aRKQNEyF/vqA1jcWVB4d9GDeGhtc6a4=

On 5/27/24 11:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.3 release.
> There are 427 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 May 2024 18:53:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


