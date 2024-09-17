Return-Path: <linux-kernel+bounces-332138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33B97B5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326DF28A809
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A01174EFA;
	Tue, 17 Sep 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="goBsZDet"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147114D71E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612965; cv=none; b=LCm3p7CW0/mXkVY/9vlm5xloH951is/fdbwoAgRyfYH+oB7lmMZa4G8IUw7eztnwAfvqql2Irwvm99sSefjatYoysGljBA93Vw1GeIvAIeukDcKI7LP/OV74B1Msn0E1eQ4npNUpTwOh9GlRV4sZwk1xpjDgcFpnHSIRI2Trh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612965; c=relaxed/simple;
	bh=BBNjmIWBCsZNu1/uEkhu7oFp65Vm/I1f1NhL7x6AVzI=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=QPJu/jW4iHsNKH4RJ2PJfQsQHxbCEm7zpzQmP8orBsGR3abo2VsBhiWawglq72Z5yc9kJCPdCsXzVU1IjC1JJSivdFJ0cQwzssmclG3M9WOdswsluZd4IbjdINHMpbVxTXlychfxPlcsWZ9C4ym/kdTgy6CPh1foGjBUIroezQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=goBsZDet; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id qgTVsYRs3vH7lqguAsPplJ; Tue, 17 Sep 2024 22:42:43 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id qguAsCjHSuVcZqguAsceUJ; Tue, 17 Sep 2024 22:42:42 +0000
X-Authority-Analysis: v=2.4 cv=EpfUrzcA c=1 sm=1 tr=0 ts=66ea05e2
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
	bh=q+ziK1mF6ooGl3p53okCzUyZN3QRERL/Rrdkp5DpIBc=; b=goBsZDeteaj1eoCk66Bb8V7Nw5
	kxAkMdismO6qKyKOMUj3VkbadDCg/KRhiDck9Qu9G64WIlpXXIXa4cpqYT2O3FlHMVrg93RzigKnE
	gCpVhNsah4avA8ulhnJXRPzwdWibWjUQrlp3ayEItL6IwRtzJp8nVexHPWR8kXHI8b2KNqzFlP3VA
	DlZacYRysM73x/tAAuGqg6Z1rwNM4ecsBeFkQb5c4d+lrGR5eKuukXfHxjYIbYkgrn+dOLW6/xAL8
	VT0UEtRmrsklgxXKdc+52e3Deb8yUohzQ01KY1CT4qwBSU4TuT3ukD/VxIVf7+T4WHx6T3G+pYhwV
	fy/tS4Qw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:41188 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sqgu8-001ahl-0b;
	Tue, 17 Sep 2024 16:42:40 -0600
Subject: Re: [PATCH 6.1 00/63] 6.1.111-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240916114221.021192667@linuxfoundation.org>
In-Reply-To: <20240916114221.021192667@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <7b8639b8-43b8-47d6-8506-d1ce9409f492@w6rz.net>
Date: Tue, 17 Sep 2024 15:42:37 -0700
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
X-Exim-ID: 1sqgu8-001ahl-0b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:41188
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCRmX5TpFNaaBkqN+suNer38Hiavsu9q977GuCn8muTZMeDv44AJwBDPjb/Hwfd5jmdz3+d0ecLz6ujVMmU+aEXER9DAWpMymXTx26iZuHKIWUGRjBFm
 cNu5SIt2rifAPcGojL0q0GOBv051WNbCz2Wm4nD3Gv5LRoN6OE+H6fnakzSqKHnH24DGAVm89tKTSbG694vcJu+Bu9unFy8IAG4=

On 9/16/24 4:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.111 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.111-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


