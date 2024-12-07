Return-Path: <linux-kernel+bounces-435938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4FD9E7ED0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2F828506C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C310139CEF;
	Sat,  7 Dec 2024 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="DmHAHXMO"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116382C7E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733558036; cv=none; b=NuIiL3wvpmaz2ddWewFcwLnT93qpfIwvKBqUrHK04h6ct+xcOv2uFXrLSyRFG28dwIr2BiagP8zSC7Qtb/8bmRNTEDkEvTn1aAWWizvet6NHIJinv1ZbSwjvZjidZ5EFqVdAxYOsoU9t5pjWlqHdZuMuHfwegYFTeXrCPs65U9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733558036; c=relaxed/simple;
	bh=esN7QsntwI4AA1UJrsf/v0wSrB5LxUaOwlnCZFn0Rcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbYR7el5of+7Z7QMNIUDUirHLXAXiVGRoYHt5XNTC8kRG5js6FPBz5NDzFspnSBomSdrBzW/BPmLNMox9HeR6gB39z8vM4fgUT684lBylJ1x0vQz7pHSWH/gzekgFJN/V9voljsIgCFw1XZJgYDZ80cEEsPHMJl6B0QEge7Opk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=DmHAHXMO; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id JnrIt8i43vH7lJpdMtDB7t; Sat, 07 Dec 2024 07:53:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id JpdLttFGHmNYjJpdLtvCrz; Sat, 07 Dec 2024 07:53:47 +0000
X-Authority-Analysis: v=2.4 cv=fb9myFQF c=1 sm=1 tr=0 ts=6753ff0b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=28vsWALzorOhdgl1oEpWYzWCOsWhDTgvkf0wFHoptoo=; b=DmHAHXMOEOQMZpqS0neCTg9Pdz
	z7gD+QuNJY6CHnwzb/axj80jmxgy7Iu2UIp+y8tLH1v7mjYCaKievPdjHouSAvYuaOCqJ+EKTdPDm
	HfEzbamnICk6Y2OOwakVUkOVZcuaRaR+WrMfZ+ZrA6OxTNUdiXJ9F5W+sPSuz0vJtSGIriJCRwAAu
	svz7ozKpP26rf5I3reRftPuYYqyfejnJkE7a/q54QmjvwJxcRVYZ9Fv1BukX5R/kwKnorJb/bEvMM
	w3MN4mu2Be9i2PsRMtXEMQYHpTGUnzdxb2TKapVoxJk6fuGeyTEjwgosYd3zoatirRAWRY7fqPFhZ
	5AM+voiQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38480 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tJpdK-0032ua-0h;
	Sat, 07 Dec 2024 00:53:46 -0700
Message-ID: <ea363e0e-1072-4c32-bdca-0175ab90fb16@w6rz.net>
Date: Fri, 6 Dec 2024 23:53:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/676] 6.6.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241206143653.344873888@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
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
X-Exim-ID: 1tJpdK-0032ua-0h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:38480
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA5gLGaP1UqIEK2RE9y6wWQmsTCPuTqi7aDMAclttzoscZnVPhffZrpbU2xPCypbn56isPgPGGZmq4ZY60wCUeB6MjQO0LhlPOwSIwJOZtqNkhfgowOK
 hFvCoO+oZSuFfConNOkrRE/9frcHj4aki1GbXd35e3NzWTpDsYMknh3308kIykSiZzOgBefk+ckiSc1auDn+ZBYDa7agZyAhK9k=

On 12/6/24 06:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.64 release.
> There are 676 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 08 Dec 2024 14:34:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.64-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


