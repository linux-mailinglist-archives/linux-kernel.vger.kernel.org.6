Return-Path: <linux-kernel+bounces-290291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C825F9551E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8421D286183
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8880E1C4601;
	Fri, 16 Aug 2024 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ujsF9bEx"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB91B86E8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840550; cv=none; b=rQZZ95jwc6vVPBXuRJK70n0QP3esfUcnmWoFGjQ9eDrFwYHJTH4OSa9LEcmv9slmXhlsSMlMC8OCSp56UJvJ4EJdnugd87HXJweRFeyAOW7q/T87mfROJiLOpACcLxOUj461QzgtcxiSHYAMN+5L7u77MeCMgdrAecgIzs+09tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840550; c=relaxed/simple;
	bh=zF0DvAEpLaLvxfA6YrYv8VIXzNu21ifXJ3Hmuu84Ks0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=ZHPzLylOUq2nAxTpiycdoErKbkNH1elB/LZSYtn8tOvWGc4t3UWpG/X3Fp/YFsNF75VJlR7bQ0q7QpivIsGUOjluxWPVU9bWfKD8S1m9zCuVGZj9g+PsHtMu0ELFBko0BrHGPyijdzpktrEUIdWU6ljSMP7dbgrh2cPfr0qwM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ujsF9bEx; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id ejvHsNvFCumtXf3fisL1J7; Fri, 16 Aug 2024 20:35:42 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id f3fhsiGYleieBf3fhskTJW; Fri, 16 Aug 2024 20:35:41 +0000
X-Authority-Analysis: v=2.4 cv=BoBWwpX5 c=1 sm=1 tr=0 ts=66bfb81d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SrVSL5acz5B5d6aYpf8JLN+Q1KYy/MjMtk8UyZDjads=; b=ujsF9bExDfskUTQDbcLTijWlPf
	tbKAx62fO2kLVtefGyu6tS4V5AuNXbiG7LEHPZ3PnuZqHErk9vFDJWO0ZoUOscD3cNNdxqkIa8NVQ
	oGq63VYrAlxQHdvwBWBTlrbJh02WrCok6br22J5vj+Cdh55miiHPr1psSk84E+WxRTF4sbs36Ki8n
	YTP1E6zB6qh4Ilu/kiocJLAfAiG0puCDoVEmRWwPSqS3XvluFwm63pdT78TYGepiWC/5unrQmRAEU
	nt3gFWg26UqRzIqeALihFjOyb+7tbMr28fxJBaDejnUuBi7lru1TXqqrgrxeqiYur6D30NQUPDGZz
	i6j0aQAA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:35216 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sf3fc-00076U-1h;
	Fri, 16 Aug 2024 14:35:36 -0600
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240816085226.888902473@linuxfoundation.org>
In-Reply-To: <20240816085226.888902473@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <e42931f1-2053-24fb-07a5-c813e022c083@w6rz.net>
Date: Fri, 16 Aug 2024 13:35:29 -0700
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
X-Exim-ID: 1sf3fc-00076U-1h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:35216
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA0MEJUKqxTk5p7AOXu4F0CgyZgaLplHOX7GJ7vvyHqT3vFyJ471lYrHFG8UKYwi0g9oS1+W6TUBULjkskm76ZfC4MoFxaQFcfth8R/DCdlFmZvTwcnz
 j9RF6L9hbh/mNt6KEsDRvBIVNTo7/CdTcwc5ZEUdRQeupewom0Hm7eGNfgtsu+8uTJ7jp9Pz1Dj2D+2jssz3s3T14qPwSc0lsjU=

On 8/16/24 2:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Aug 2024 08:52:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


