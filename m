Return-Path: <linux-kernel+bounces-222804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C829107EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E6A1C22195
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AD81AE0A1;
	Thu, 20 Jun 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="cRMrVZj0"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2221AE096
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893108; cv=none; b=tF78TNiywUZjlvMc0A+KuXzt7zjnWSw5AK/VU+ojMZ9KONpbQkGzgM4Zj5Syc5SjzsE4czSa3QkO0y6TlSMMdGG0vf7zaRM66UscCZ4aw25tQy6S+nRGxMak0bTW4+CHd3P56qns9QHJ5gLvdcs4Qy462DeHqsVZQb1Sh1wn/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893108; c=relaxed/simple;
	bh=FiTIEM2586OeYCc04M4ohcysGxM456/1S9cHdyWyxlI=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=fe5QBlUt/nj5m/6WkWQclT6tloBF/19uz7kXXPZUurNVD/dh3jHJlURDR6JwO1qydXDMOH+qpMtsSnmDVUrOTTMFk8wBNDnYQvgd6pkbVMoaToNSviZ03pe1LkfPHF85cFCzugR4aRPD9ZjgAypvhHWFsjtsE+dnHFCD8aqlgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=cRMrVZj0; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id KFSgsfifzJXoqKIcJsJilx; Thu, 20 Jun 2024 14:18:23 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id KIcIsFpm8y2LPKIcIs7fwy; Thu, 20 Jun 2024 14:18:22 +0000
X-Authority-Analysis: v=2.4 cv=CZoO5qrl c=1 sm=1 tr=0 ts=66743a2e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kNzFyEQwpmlpIjNtX5zmjNPnL9cJHaoTaVBgjYFDMbA=; b=cRMrVZj0AJvLQz2cxQk8O6LZxA
	feTp3+P55CLY05MKDc5sS5bMVlwOVDHIyzQJDvMeCHYt/hoBK8LE9R+V3F29SoBayI+ayoQFqnriM
	aQJGvBty/YfsbDla4pf4fQv4KVD3vMRLt+R5RPEA1tiwH87l54NyFBRLLeVRC1nPNVZt7KSZpymS5
	7v2BvDP+J/6HULZk4juRuIXK3nx8O3DI1SJ84rH90d1jl6Tr7iYIWSs0ao7lInd102pJZIz+dyi9y
	lW9jsF2tbXXmcdnGeBPVl1tYByxUMRliJMAX4HIR931RAcEE/MGoRy2FnWw2C/T3ejufK2t9rql5Z
	z+/aHiYg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:44936 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sKIcG-001dNG-0V;
	Thu, 20 Jun 2024 08:18:20 -0600
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240619125609.836313103@linuxfoundation.org>
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <8ac334b8-2b8e-41b9-e532-873216d57c5a@w6rz.net>
Date: Thu, 20 Jun 2024 07:18:17 -0700
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
X-Exim-ID: 1sKIcG-001dNG-0V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:44936
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHpSV+FgStSUPIcUT5cEd5bDXNqiLqvlRJ5jBFLO5Yfnp7joTou7ufYVjqjWYMKHHGZn4EiSNHiOc/T0Z5d7TmuBmY+dhN2JstoOyQQ1Q/wwUuuTK4Xw
 nZBfZTIB0HwO/8dzixglEmiURWKh7e9O9PnakWWIn5q/USYMeS5yVey7ImYWXXCjVbewF7RHRUyggIztC8nD2pjedBQfKUc8SAI=

On 6/19/24 5:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.6 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


