Return-Path: <linux-kernel+bounces-555851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1651A5BD70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24421889386
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D754230D0D;
	Tue, 11 Mar 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="v38GcD+o"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AF1E883A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687994; cv=none; b=WblWuUujU2cetV2Z5epmcWu7/GoPVyls9KhfSJTAkXSuKti9mb5fARONFxV8SKXzFYxIHw69vS9QUELMEA8npQBtaQlJ3Ndqb1ZfWO/ieM7Ibn8t+EtoWwnhiCurEtsmpN5hbH6f+I1KpoFYpfpRiFcbJZmtPxYBve/qmby1Epg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687994; c=relaxed/simple;
	bh=eKZ21sAfzTBNzYWki/MIvFoXRYxeTYoWGzwrhM4B4YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQEIiXlBTO40br1HOXH26D1Wz1cNMgB3pQo1q+pehn6tEodkp0DID+3XOGQ+upTdL5Rr4g85GzyN4mnJio4GSQ/4bHgDNatOA84argo2GP7LrbJgPeUx6Pq0kAwt3EAJ6fwpn1xC4HMZJFTGZubdY+szRVnKaE6z1ePeGRRweKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=v38GcD+o; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id rfY8t3ax8AfjwrwbitOOe4; Tue, 11 Mar 2025 10:13:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rwbdtNHUzHEACrwbdt3r0F; Tue, 11 Mar 2025 10:13:01 +0000
X-Authority-Analysis: v=2.4 cv=HdLfTTE8 c=1 sm=1 tr=0 ts=67d00cb2
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
	bh=c9ZH/a8/3JJBb4/soWP2O1bASmEOVWhEZDkVB/Rb6R8=; b=v38GcD+oSGsQ0DQwnq3R/bbbPn
	dhUusb3SXIcH/Y1rFzkkgUoUTkB8jyADUWx/Xp9dZbXjvfdJmGgUePl7BJgcp6+zcbU5pkltkbiTm
	bEqsvl/3AkzjO+3U1kHQlgB5+5wu0FAjt3tEFUgwAJMfoKO6F9bwxJwKa86aKRaDigPxhvQ4Yg4Jk
	vIY+1zBLRu+3aj44ngGSLqYAzRtsN0UoKuzm+c0kw6pW1vr2xb67I/h9ZZCTUMm7AwM1qhLzdy0LK
	/I9gZAMOzYZ9h13X5FfKTuWU3Xv8IQw+o9raQrDMmngbbdNYtsTAVdgAIYFqRx/Co1qsxxvNzmGqU
	QZLhwriA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:41848 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1trwbb-00000001VIl-0O7N;
	Tue, 11 Mar 2025 04:12:59 -0600
Message-ID: <c958fd6f-9381-4571-a1be-b2080122f78f@w6rz.net>
Date: Tue, 11 Mar 2025 03:12:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/145] 6.6.83-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170434.733307314@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
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
X-Exim-ID: 1trwbb-00000001VIl-0O7N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:41848
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDE/mjoQnYVT0NOrVYPKCidclJUWhm4F+RHCNGF2G6xl8Aiq2q5S9nbs+gx/bXAJWJxkV/JbER8nmKJhccZ6HlnkIVipbf/3pL2N6IvmVAbrMT5XPyt7
 SIwy4hbPxJ90zLgBrcCjQ8ePQ0F3nBiU/dkl8SKPiX6YeGc44Sg/hFlIOJNCfs37zMREO2pd9p3jd0C/Dj74ehe8sqm7DAf3VNE=

On 3/10/25 10:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.83 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.83-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


