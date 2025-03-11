Return-Path: <linux-kernel+bounces-555385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC1DA5B6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DDA3AD868
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA541E47C9;
	Tue, 11 Mar 2025 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="08A+CGjX"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65F339A1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660329; cv=none; b=bRLJDGncyzvMYYL+WdgA+MFjdmMZPbBK79FMk42Ai5VOk/zCVgH6/jZHIxLUQMREGAcBFVT7EO77VsA4ORj5fF+oHrj2WI1Pgiu5RWuV4ar/DIc25MW4mwH0ZLJnpSx4V32WDkgEa6lHmsJRr4PUGxAUJ6RRA6EUXwR/X1sf1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660329; c=relaxed/simple;
	bh=bJEaT5NClNSzR4NoT0SzsAEBFhjC79pDuLAjzyah4qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLvCVqe5Fzv2vwg7khaPbJIRuueiv+Rmo5g3v3z7ERDTvQ4s9D02cBhsonv5DE6UQhcbjlbpc+fLEA9Z3K9KEBeAqTmwt9uhC1HU+tbgoDdXz3J4t2K8HpxHdjAxZ84nR8hSK8wmRpFBgd3rud5sx+Un53g83Z/NaehVcz+P5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=08A+CGjX; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id rm1btoYpkMETlrpPVthsIy; Tue, 11 Mar 2025 02:32:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rpPUtpAjuvt5YrpPUtICHr; Tue, 11 Mar 2025 02:32:00 +0000
X-Authority-Analysis: v=2.4 cv=c9JgQg9l c=1 sm=1 tr=0 ts=67cfa0a0
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=-Qcm0AZxhyoZnww38z8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sECf+MjFpDqO93Pwt/5LVfQ3DgrElfihZkeLEdiFbDE=; b=08A+CGjX3PvtG8CZ82XWq+rFl7
	+5H7jaIlUaL5ObBv/PTyWGde46h7lmKgS8JKd2b1odJ0ieoJt02FQj4MTONBC6V3cNfPNx8TzCUEJ
	Pn+QOfaw3sZydGdxMfWZC+kbLg5cEyBzttmLbJg+5uHqsO9x+cT6RkT25hAVmQLnLUONNdI849VhR
	BVc0hmkp5YUjNslUDYn4aGCiKJIW0Yir70Wd5bFGZrWPONSoIRVao2TH1Vt5s/onjLxnaqgKZXuwx
	AR0sdpC0E3MZZ8h6n0oPoTDibtChjHYkfdRM6Gt1mg3KZZyG3mPkAkwjByodGJ1Bmv2jQsvb51yH0
	0jqP/yGQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57476 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1trpPS-00000002odE-0a4V;
	Mon, 10 Mar 2025 20:31:58 -0600
Message-ID: <81784d87-b837-4476-974a-87b0333e7e38@w6rz.net>
Date: Mon, 10 Mar 2025 19:31:54 -0700
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
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1trpPS-00000002odE-0a4V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:57476
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD6Dw6QTZOX80vclxSlf+4xOXyEmnwTnp3DdTUXxNAHx7iCErcMj9jZFUsavs5vGb29M18YaR8Mrm5rlF1ANJcyK4ft7J4pQmE8yJXzhVlwYoV89KCVN
 wxNrlXhgKICUL2ur8UE9RIDfl1Vz4R0MWKPK4qnY8O3VaUuS8j7tVAPj5cxRWGtvHbwqPFK9vaqvlpwZtx9ARJWaRsk4YLNuoMs=

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
>
The build fails on RISC-V with:

arch/riscv/kernel/suspend.c: In function 'suspend_save_csrs':
arch/riscv/kernel/suspend.c:14:66: error: 'RISCV_ISA_EXT_XLINUXENVCFG' 
undeclared (first use in this function); did you mean 
'RISCV_ISA_EXT_ZIFENCEI'?
    14 |         if 
(riscv_cpu_has_extension_unlikely(smp_processor_id(), 
RISCV_ISA_EXT_XLINUXENVCFG))
| ^~~~~~~~~~~~~~~~~~~~~~~~~~
| RISCV_ISA_EXT_ZIFENCEI
arch/riscv/kernel/suspend.c:14:66: note: each undeclared identifier is 
reported only once for each function it appears in
arch/riscv/kernel/suspend.c: In function 'suspend_restore_csrs':
arch/riscv/kernel/suspend.c:37:66: error: 'RISCV_ISA_EXT_XLINUXENVCFG' 
undeclared (first use in this function); did you mean 
'RISCV_ISA_EXT_ZIFENCEI'?
    37 |         if 
(riscv_cpu_has_extension_unlikely(smp_processor_id(), 
RISCV_ISA_EXT_XLINUXENVCFG))
| ^~~~~~~~~~~~~~~~~~~~~~~~~~
| RISCV_ISA_EXT_ZIFENCEI
make[4]: *** [scripts/Makefile.build:243: arch/riscv/kernel/suspend.o] 
Error 1

Reverting commit "riscv: Save/restore envcfg CSR during suspend" 
8bf2e196c94af0a384f7bb545d54d501a1e9c510 fixes the build.


