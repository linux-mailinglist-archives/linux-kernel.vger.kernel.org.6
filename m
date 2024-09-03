Return-Path: <linux-kernel+bounces-312327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E980969504
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DA92822AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E91D6C53;
	Tue,  3 Sep 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="pShoSYiJ"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B191D61B4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347793; cv=none; b=EtsRG+yI76U57l/vzYp1N7iG+1EkqYvZEc/engXQx4b8tjNLTN3TtvKoMQqIeDAbFzMr2GUNr7b3WzbWb77iNgLeWEkuf6XtkepCg6T0T3EVMnhBaMLYoT5VPBqWWv5ymvQbqDYemUbiA9g5NVpOrbVLAGqdSgrwlioax9Ly6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347793; c=relaxed/simple;
	bh=dbqZHXeY2GElJhu4chOZTfuww+6wbdw8Pspqnzri+P0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=QY8U5p2j/H7LhhDczNMTlWW1d5C5BceZgHnDJI6OKtbVQYFVB9MIAIJ6lq8qZoequ8VeDOCmTbmT96V7VVmToSZBSuqzFFXjGhyLH603C07Dr6osQklvUU0aD9qBl1N2YF2WybnvK/SR9c8eQwQxhoPFaF14FatRPTKcpAoggUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=pShoSYiJ; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id lJ0PsuHXXqvuolNm4sENCw; Tue, 03 Sep 2024 07:16:24 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id lNm3sBVPfZlJQlNm4sXawR; Tue, 03 Sep 2024 07:16:24 +0000
X-Authority-Analysis: v=2.4 cv=DMBE4DNb c=1 sm=1 tr=0 ts=66d6b7c8
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
	bh=W1KCT4/fDvFOriO9Ow8GKZ/URfk+QMxRSIoknlmeAHo=; b=pShoSYiJl8w5toR2rg22f6X6O8
	6ccTXPVJjWKdZv3E2XC/W01YIHGxXF9uut9KrVMLM6sPpoecxyNGR5NuwqwDc8+8dhwHB7ZjTXp9O
	9VU9zKWMPoxvx+uqgtN1VOnmZVzZI6yFSAmFTuxA0yhQ43LfA5p4VPczT6dn5pzEq6bK0y5Q4yzNm
	jpDYPIBeTbI+RDiVbddsLWiFblZfUrrIElch3/0+pg3KEW1gJt0HznjJFxj3liJdn/JpQzTiB7Ywb
	qoHTCgLc/2mzEmAyrauMZkP8WvHZTIEwf7qLQiFRX4ZiS2qRuzCE1ag0R3OoqyTlIswTYLxh7yDQP
	aJ0W3baA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38096 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1slNm1-003nZi-2I;
	Tue, 03 Sep 2024 01:16:21 -0600
Subject: Re: [PATCH 6.6 00/93] 6.6.49-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240901160807.346406833@linuxfoundation.org>
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <ed637a40-4526-f17c-3f64-c4d5949ac316@w6rz.net>
Date: Tue, 3 Sep 2024 00:16:19 -0700
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
X-Exim-ID: 1slNm1-003nZi-2I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:38096
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC5NFgfi40vg3XOLYEDeEJ3IHMYVh4nV2HSKRNeGZgwNobAQoWbHesUTVhfCVUE76IZaZeZrwOEMYWwjdyDyL2FVbdXn0nwsJFfIk6n7SDGIyUTudXDj
 YnD/sAWtcIAQaf2IlUassZr4lpnGsz0dQV/tBxVvkMhJGVmAg8HfrqRgzKAXqIcUenSl03XjkcR6c0NCR+cjjXfJQSHnVfDaVEg=

On 9/1/24 9:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.49 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.49-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


