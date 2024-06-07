Return-Path: <linux-kernel+bounces-206779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02835900D91
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44831F22D2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFD91552F9;
	Fri,  7 Jun 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0Cua+W7a"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F017BB7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796071; cv=none; b=mkJaXvcP50iQkCv+FgULMCK4LsZipOSWdcYl0XTK5FKAbtb1WyyYHvnjt4mRHBeugqgxwTr26cyIfM3h0uaPb2S0QuERmrL48jN7ijsQVg6ezOkiWdsTnORjMfAe4kcPcwibIuMtjZ9Fv3x7FhQDCPSSe5/HRDf3B9+8qvQCkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796071; c=relaxed/simple;
	bh=xfNSsQUzNewVN/mboc6Q0xEqgOp4BA88MYFHp0Rzyi8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=txg2Bjz+1sOSA/wkveIoGNFyvxyBQrhd+bBLVolLG0EZFVAE6cVll7A+NCXkWCLEfP7bPES7ecOTQY1OZqoNgeASHS+sPOWggnSXhEf/W6S6Zwqp7BgohZ+H7f1ypQLKtJGGG22HoRanPcGg8TfmaTSi7iJv/nCF09ixXsgH1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0Cua+W7a; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id FfkrspNVgSqshFhECsJ2Q4; Fri, 07 Jun 2024 21:34:28 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id FhEBsx9eK0dJ4FhEBswvgE; Fri, 07 Jun 2024 21:34:28 +0000
X-Authority-Analysis: v=2.4 cv=CsO5cG4D c=1 sm=1 tr=0 ts=66637ce4
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=3U1NTj930rUM-GEF0QgA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xS6YINBT7fbz6uzLiMSH6n3vsUox7c6GFJJbpYf/fSM=; b=0Cua+W7aRUDuBA939JItWF6TcY
	xB7dxFdkugngH5ApnAKbRywy2WV9u2z7LvMdH1y7qDaup3TuOpLK632OE33baKIB2f+dyjSBcjVOX
	pi1OVuI862KyU1QIog0UXe+ZCKO4PC0fmS2gAry8tL9ol93r7A2EBrStUCshOON6MaN6P6SLXT+28
	TJPvOKVITYskO3rjZDno10ToPYbO4T7C5AxC4TeaA1dx89gqHZuXw0edn/Xg+RfVSrFXK0ivoKBIY
	q77zoUFnyQYyEovzfzPjz3Hvv/6iFtaEjyiH2PvLjY549UBUjyDJO9G2Fv+fZZAi6P2xhe9K3YR0z
	ExWCIMLg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:42394 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sFhE6-000sT9-2r;
	Fri, 07 Jun 2024 15:34:22 -0600
Subject: Re: [PATCH 6.1 000/473] 6.1.93-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240606131659.786180261@linuxfoundation.org>
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <a5332a9b-092a-7aa5-dfc2-d28565167411@w6rz.net>
Date: Fri, 7 Jun 2024 14:34:17 -0700
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
X-Exim-ID: 1sFhE6-000sT9-2r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:42394
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOFeGo2JfHyyVcX345gwZRVopylNw/cZwhJWzpckGPJvTCedhU9OBSo6RPAfY2q21PmJuW03pFm0pX6Sj5SRRzoeF4RVs70L+fx6eTuVcuOhIGBNfNk8
 qmtij67j0A4Ja1+dpZH4oVloJoEoEjAS9JSG3E5K3FTKmNW0KJzzSvnJ3ISBA3JHqk5EOsH/pDJaVSfvTT6PuSAZA1Gv9CuIJNE=

On 6/6/24 6:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.93 release.
> There are 473 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.93-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


