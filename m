Return-Path: <linux-kernel+bounces-366100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E499F0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B4DB21D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB7157494;
	Tue, 15 Oct 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wMv588MR"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE361CBA1F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005505; cv=none; b=OV7Hlc7CRz14geQjJH7KsTaP6Jp2e5YNthW0DmLmqjzNXBwYplWeCziInJmIQYgATC8FqBoK5vheRGklB8QxWulR96/LLyQVfu1Ix+rCDcvWZhUEgi5/mib4ImE5zGiQTlhWSPEXVuOBhR0kBOm19v8QsKQcJ0RSR4zPXmx7vYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005505; c=relaxed/simple;
	bh=vHnnki3w2dy00jpZowkE0stouy/ZhxusNf/x+YFdyiw=;
	h=Subject:To:Cc:References:From:In-Reply-To:Message-ID:Date:
	 MIME-Version:Content-Type; b=pv7uTz84X48mImijW7eLnAznFxQtiRMqNg+NQhvDgLX4wBIpsWEvHQcWAmnPk7HRX1XVK0FrSExcyEnGlmBtQz97yksCYilPUoSfa02H5q/uFPQY2oPNJhJp+8rnZ8+dbmsf5RJSnPL1r8LiYA5LwCX9d8f97oqdr1oNTvRtK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wMv588MR; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id 0ZfBtbt1lg2lz0jJQtjVq9; Tue, 15 Oct 2024 15:18:16 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 0jJPtHNBPiG4P0jJPtRPiy; Tue, 15 Oct 2024 15:18:15 +0000
X-Authority-Analysis: v=2.4 cv=VdfxPkp9 c=1 sm=1 tr=0 ts=670e87b7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=UiXv1XNBzq_yEhrWseEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:In-Reply-To:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0chHwBH4LCzMXRkBikginENruzJPKwJRgc6zLSmldsg=; b=wMv588MR7Nu4fIjNT7hejsSV4E
	cAQ41zXPVb+MEfzdWMcLea1YCt2FpZRizUaOUyhBx5eldPesDBgMrJ06KUQQTesFb8JgAtv2oHtp6
	7q2sSJcOyfTpTK3Ww+odBvSXCBkkNV8/4+lW/RVsJX5Y6/frg+7dI5C/PLaB2va+ImzD+fip3oYvH
	lAQrz13D60oG6zg9MwUbcHWhCq76L8JS3ry8uPIHnWyAZoYxATvm62wrPQr8oL08WrBvYUVrEK6Tv
	r1tWxfPucXPnNNj1qnjuQwNSDsO9jqeYbipoD5AiPCRF2rrXiyWHu/ZA8SID8a7tg5/39UyNZ/0av
	yuDfRPEw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:47872 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t0jJN-0020ky-03;
	Tue, 15 Oct 2024 09:18:13 -0600
Subject: Re: [PATCH 6.11 000/212] 6.11.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Gabriel Krisman Bertazi <krisman@suse.de>
References: <20241015112329.364617631@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241015112329.364617631@linuxfoundation.org>
Message-ID: <48040478-dda1-9424-9dc8-4a8bdce0987b@w6rz.net>
Date: Tue, 15 Oct 2024 08:18:03 -0700
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
X-Exim-ID: 1t0jJN-0020ky-03
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:47872
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMbFK2gSkL0UxjsdUdbhfhV7lOXJtccgnX9mQoaKGOB8cX3ZofokX/1F5FlgHH+RbhpNV/XgHoCM+U9RCTxhYc1gsgvwA9HO4emSayoR/DU7fpam+fvK
 ZuUo6GssyH8gO0zRlRzMzYVQaDT36vMyqvdzNL01xpKb2Ti/Qta6qKY/vvOfGl80yNeaD6aM7u2tukfZYdk2wDaPEA8I48iXnU8=

On 10/15/24 4:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.4 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


