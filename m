Return-Path: <linux-kernel+bounces-255220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9E5933D98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240111F23D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E43180A77;
	Wed, 17 Jul 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="nW5nIvnc"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE931802AA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222901; cv=none; b=fZwo0Pi3F26H+QVFypoWvY1DAosvY0oqwTLK4fSorQi/zGiEvjJd3zQg76z/+AFH8F2oUGYlcUnlqwXtRZRXP7xK0cdShoqqUULe5GxA7RQoIeRt97vSVjHLubkwWnfsWCmd7Dd8sAci+YayeMW2ewhRSP7vPjYIpkNq0K+NP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222901; c=relaxed/simple;
	bh=8N34VMZed3IPqdLffPwpjQZsdnL5jIluRrlTb+4i7+w=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=AFki9NezfAtZKtk0GIaPtJBToR8fMZZYJh2Kv/DL0ml12K0X4/VgimUS/Y1C6AljR38bD1xhqSark+f+jts3c73cBa6OzF9n5Z137ccj1TH3gGUxarVT0R1s6eEej2jxdibmE5XVJY0ukdOAUerHXMZJqUo2KIOROXyrekpXmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=nW5nIvnc; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id TtFLsDuk7jnP5U4hesOGBa; Wed, 17 Jul 2024 13:28:18 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id U4hdsGbW1BlWFU4hds4xgN; Wed, 17 Jul 2024 13:28:17 +0000
X-Authority-Analysis: v=2.4 cv=BNe1rkQG c=1 sm=1 tr=0 ts=6697c6f1
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
	bh=pwNASrOVLQyx88vnRDBTR35iOZVBhzCkTrKHlNdU4JU=; b=nW5nIvnc5YAfhVvXBoLuJ41D15
	g8lptOKRNvCGzNkeE108PhkB6FqvoHkL7cbE0xhGPucN6SAyn+w9p1NCd5mwOICge45Nstik3h5oI
	an7ZCCY8ChbSTEd5pdS2o+3J2MXSu4ImMNo3XwuM2vNRHUIdBZo5H4of6J+ergA2YUBEksP9LHsiN
	vsBlHmF4jVZ2hCyGFB5WQJRg/e8fpCRVUWNOs9W1efeOGS5gFdZf2BfaohJxj4N1r3tZtyhuTrkJE
	nJbeHJThcCgxzyfNiiGjbNxmrD8uHaXf8gJZp4X5dnluE2MAPnM6UXGNdkup0E30XM0F4ByPH3hHo
	PxUEbMqg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57956 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sU4hb-000RQb-0Y;
	Wed, 17 Jul 2024 07:28:15 -0600
Subject: Re: [PATCH 6.9 000/142] 6.9.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063806.741977243@linuxfoundation.org>
In-Reply-To: <20240717063806.741977243@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <c5172c58-2874-4cb6-1575-74bf2550c08f@w6rz.net>
Date: Wed, 17 Jul 2024 06:28:12 -0700
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
X-Exim-ID: 1sU4hb-000RQb-0Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:57956
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGMHC53IhMiXoPROJvSyrFBjkgXetA5KQrp6I8iVnW/xV9B21pNBw6O9TkePFOSOXsnCoPZ3SehS/8jTJDwTRqYHmZhBc6en0rEebLHzyv4sxr/j6hlD
 509oq8kGnNW4PEKyOTWza67zo/1xAT68Pg2CQTDie4jA+qULr5e8xlG5rIlDNBL7K6dJ9v8hwlejOZYE7BPGs8Sjfd5tuz3+jsk=

On 7/16/24 11:40 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.10-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


