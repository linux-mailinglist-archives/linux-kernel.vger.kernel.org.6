Return-Path: <linux-kernel+bounces-180295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62A8C6C92
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294CE2826E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13CD159562;
	Wed, 15 May 2024 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wMLtMQpm"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D87158DD1
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799772; cv=none; b=MsZTF4ktAzQgmRA1Hjx8hzgc9Hsaqx6mR9eeho9ud7yj9YRuPjAHIYHBGu+8npDA2ouW7g6Rab2/hFLS0JXUVrSbGRUETdIouIgfXLG07H+7GCGHBfpIynLO+BiexX7XoRYVfh74omLs+ohZLCSwHBQAFx+cYecOpSd4Gs+trQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799772; c=relaxed/simple;
	bh=mikBtoW97YbCBwyvNRnJ38Sg2mM7CDdV4ls2mCBZsd0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=ufqzDG4oJ2c4wbSFHbBl3D0y81k2C1pMwEkorLsgqiQzC8Rw3YSspzdHov9E2IKoimitd8PAeJiZIo0nma+cx7j4ggiGnlvCU4NAaz2J9624dz6UsnE12kd+OaLaE2lOmmJzHWuj6gxDcnoxJwBqS1DURKqtB3/y3ZIy1IEzB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wMLtMQpm; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id 6tplsXjafrtmg7JtpszTb2; Wed, 15 May 2024 19:02:50 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7JtosOXlXYakK7JtpswCJ7; Wed, 15 May 2024 19:02:49 +0000
X-Authority-Analysis: v=2.4 cv=a4T79lSF c=1 sm=1 tr=0 ts=664506d9
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
	bh=sKG1F6rhpqV48qN/JCq4XUf3fNgKXT99hRxa+V7xlp0=; b=wMLtMQpmdIzGIU5G+C3YKuWjIE
	UeRUetp3RdkJ7HylqiM2r0dBGEeJWuqnpgzdtcFQPJyoPh2kd/EISbLkqa090dWphocT6puzEV1z9
	I8tlTPnwHvaT0VSadIHbxAkbp9RSJlCoZYASJQrIrZ+vQ5ezNLCXaWkiO0z+FpXSpYJxJLlZz1kqI
	qeBkz3urzZlah1pkn/pX+8c7LdRv1w/MhysJfGLKJzaOOLN5BA4TVErO52EiJmOgSCSLSa2mnfbb9
	hbKy/qpMDQGSkFu9R4Zc7ANaWX8echZPcaJ7Cj/+tf4PBBTHEYP03UDD3IzXll8xla7sFaYAm2ewr
	/edVhRHA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35798 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1s7Jtm-002QwV-0X;
	Wed, 15 May 2024 13:02:46 -0600
Subject: Re: [PATCH 6.1 000/243] 6.1.91-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082456.986812732@linuxfoundation.org>
In-Reply-To: <20240515082456.986812732@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <d96667d0-f15b-ead0-5451-00471bbefd6e@w6rz.net>
Date: Wed, 15 May 2024 12:02:43 -0700
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
X-Exim-ID: 1s7Jtm-002QwV-0X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35798
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOfNz3EYg4Tjh8XUZaYKg3QIp+kzsNqZnVKGn8VYWje721PG2ZBMmZyqPXCzFX/DkGGdFIsyYYOGflV2td7P3x75UfChxCTKpEH38AUTq3h9MyWBFMPi
 6FHmkec20s4R6ZL5u0R9La7hCxPUzZPkMeZWfsoovmiGrxItoZjRBEkB5hLeUFeUXGIY6yIWx440mejwqcDclBBHoGQqSBQfDcU=

On 5/15/24 1:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.91 release.
> There are 243 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.91-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


