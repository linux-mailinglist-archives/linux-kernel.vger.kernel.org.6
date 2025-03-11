Return-Path: <linux-kernel+bounces-556356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72672A5C468
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17063A6FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6B25DD12;
	Tue, 11 Mar 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="o9mn6wcM"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC225D8E8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705346; cv=none; b=ZLn/wbLTK2Z9nd9CIDeDR/SZNCGZVcLbUX9rPKqCv4a2kknT8Hxfmop9MvGxUvPf5z3QbPpjqTUAsufqlbWuArAmr00fqPIFECJEJjgCEhHBpsgGNlPmNpwF9suN1K8IrAcvawZJKD3n5pZGMOGR7H4y5flW2vRzmy157Ubh1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705346; c=relaxed/simple;
	bh=i6FKgTj5MZo+UPVgwcnfUsz1yxRRIG3odNTlKaEDJJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtX+qkDREFLeXZcjqwl5pdmyAlvgiwyjKRhwX19rqqVfJKtY+F5q4Kl4ngsnnoDEuzJoZJHr904iAHsDn9PNiwgG/wa3UgGpabW9qTSLT99Uv8zLCwe7kORRY1grsZomDhG3EPtBnNG9nidxE+9E1JcdZF6XyiM+LaqNlfyVuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=o9mn6wcM; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id rzdYt996oAfjws17dtQyeV; Tue, 11 Mar 2025 15:02:21 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id s17PtU4s7WjcTs17PtJVbL; Tue, 11 Mar 2025 15:02:07 +0000
X-Authority-Analysis: v=2.4 cv=DOeJ4TNb c=1 sm=1 tr=0 ts=67d0507c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=v1K_5SRFfWpoqNt-hKsA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Aza/48pLKQk3qyNSMWVp2QBHEFFNsEqbo0/L8MW1NJQ=; b=o9mn6wcME7gfsFdaHkK1twZ+/H
	0JvL7escQeevADPGY5RAwDp3vqUjf4Ouoih+RpjMLearhrT3QAhgD2TDqGqNcXufvxoT+Sw1SokOn
	d4vAhaeRK5LDsVBOocOoEHZlWi2fptwFp9IIuaWriNBxfwv09SqtWIeS0lusvjTPZitCuRjAOJ3Jw
	L3/X1UTmhtBNFJiYa5eL3p7LhB8FdV7+mOwVVnNUDTdrsIE0EMHKWFUc/7yQk5+AEHHblEJ7P+LJn
	md/lM4a+2WPYCvlZySBoVj/OyvPGrHIzc8edTh4wpVS6NXYvRdhcOYMtX+hdH+SWm6QnlbhiHNh3I
	DeVgSMpw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:41150 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1ts17M-00000003MkF-48At;
	Tue, 11 Mar 2025 09:02:05 -0600
Message-ID: <10d814df-e74f-4474-ba66-b08d94d03006@w6rz.net>
Date: Tue, 11 Mar 2025 08:02:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/616] 5.15.179-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250311135758.248271750@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250311135758.248271750@linuxfoundation.org>
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
X-Exim-ID: 1ts17M-00000003MkF-48At
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:41150
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEV1Mypg1C0WOSE+SdPwL14wtUuQkK6QHOIAnoWeFLzqGbxZCdbXPyyh6lewEDoaPZFzROyYHxH5ePIF8PGAYFiKDM4dD0B6/Zzu2F2628tcgBrjO2LX
 I69LEUv5pEbpAfw3/FIUGApHC9VJdl+ZF//drhac8YEiNTG3JgMhZwDtB1vETFh7uwTHKGL9ZzqSsiHzd8wL4vK/4UXdX+TUU1Y=

On 3/11/25 07:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.179 release.
> There are 616 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 13:56:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.179-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


