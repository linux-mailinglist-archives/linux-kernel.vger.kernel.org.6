Return-Path: <linux-kernel+bounces-305500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B09DE962FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D35CB2186B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CED1ABEAF;
	Wed, 28 Aug 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ptki9936"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82271AB51D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869019; cv=none; b=ZIgE98lGjUtiputy33f2QEuzO2h7hyXQNh6G5oVwNIJZBqFKzYiLXd87nSlWvCBaoo+ntR0arCRBiD6nmk7Zznemv6zxLY0QjNG3x0xu9EAyAA3DZtojBWu3ujlMhfCZ45oQKOXOT6QHuE0WO0G8mH40FfefI0rLuadtZjBzr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869019; c=relaxed/simple;
	bh=jhwB4jvLa98ab1yJS3Y/fvpdWNZHbszKjImSUE+xsLQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=BF6ouzWiEUsQbU4bFidIAG9eqYQAQQZ0zLkQSEyi7+DGfQF7IfUWZWMg8T/gTxFW6g5lpQ9X17F4yFE5H4r8q7KoqKvTFSizhgfQL421eozuxMbi/ZXPpZbogPvWWZa+fFgOUWubzHfIi6+UFKzRt9Z4cH6pwT2kP33WP5qg8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ptki9936; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id jCIBsfuwbnNFGjNDvstnuK; Wed, 28 Aug 2024 18:16:51 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id jNDusbCCToEXyjNDussijQ; Wed, 28 Aug 2024 18:16:51 +0000
X-Authority-Analysis: v=2.4 cv=d7zzywjE c=1 sm=1 tr=0 ts=66cf6993
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=pvbMRhK_gA1k-AccEgoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1JEqY8sjFsJlOEnaBDSBNyiVABiyV0rZ0bUhu1d/8JY=; b=ptki9936QP45Q01m/QlrYsZY/H
	WIW8wsU77pGr/Y5GHrS2bVfOUUxCijL8tq1NpBV1rZchZY2QSdbgB6CjOkRkHoq+ftnSNHbG0xtFC
	QJgJQgJD+n+01eptvgZq9ReaHAiL9O5c+EpHXCLiupYr2cDQzHsjNNSOvqkUGjRUS8kwNWZx2FM44
	qQJNy+qikNRlKL/eEZ/Z9kjUga98eJQyuIeUuZeOdEEvL2rhkMd84qT2+oEqvk0HBZ2LKcO2+04PU
	XP3n/equodxlvdDo5pf007pnlALmmGhNVnKoVkvtZDj8Mel9Zon01XPspBc9NZHpfGO7HfocPnsy5
	wbExsqFg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37098 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sjNDq-001IAf-04;
	Wed, 28 Aug 2024 12:16:46 -0600
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143843.399359062@linuxfoundation.org>
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <e4891588-6098-27ab-15f1-fcb3f46c0267@w6rz.net>
Date: Wed, 28 Aug 2024 11:16:40 -0700
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
X-Exim-ID: 1sjNDq-001IAf-04
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:37098
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGGj0Ll+pwy3BoYL+rPYrf9pDe9EA3JhOjwRvtPtlf1Jbvf01B6kM85HHIVO56UTaC2rSgbpichQPRixB+GiCHG7F7s5MBnT0BHVLTPyK0uejpqAkV+r
 8iL5Uy+Id6jhTwfiWsd1nDTuv1MQyvcvFE0L4tYJ9kFnO7G1mEd9V59jlHQ4RdOXO/mLyvs89/FqabXdb9zELlGxZJzlUmO8Ufs=

On 8/27/24 7:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.48 release.
> There are 341 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.48-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


