Return-Path: <linux-kernel+bounces-214884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6EB908B88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5337B233B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDD196D9A;
	Fri, 14 Jun 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="qT96+NjE"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CA187560
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367611; cv=none; b=cPnLcEkzwvtWDt3kv5O4tD6sE5G4LLuyPJ5FHxARdPPkDDmgdhpvVFE0iF6tWdF/B/kuDi+V5lctT2bv5oiZl9QVbbjdGtT6mILJUIzEjRYmCxARtI9ASmNmRt5uHVeCE3zVXKaS9DQFGUEK0WOLQdU45dORWg3MhlTj2xgWVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367611; c=relaxed/simple;
	bh=u0r125JIfBM8xdZLsVXut9omsTU2mE6jFwfr2wi8EUo=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=LkbJ3Z8bliBYhEwfiRz3ePZaCqQqcfFVO2GKsuVjtS2NtOPPPnl3R/tCeZR7qpD6fqkTANBij/ZI7rZ6BBid7q4jrnukMilHezxAwRq85zR09l/5iV8KCaGQWvavCkTK1BdmEe0kafgrDCrziJvitOqYh+SvWL40xRWiRWb32TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=qT96+NjE; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id HwEXsOIjXjfBAI5uZsBTw0; Fri, 14 Jun 2024 12:20:08 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id I5uYsQiPjHHoAI5uZsuFAn; Fri, 14 Jun 2024 12:20:07 +0000
X-Authority-Analysis: v=2.4 cv=dskQCEg4 c=1 sm=1 tr=0 ts=666c3577
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=k_VYlBbNjbJsBR3UXVkA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nzruOxlZhLS4L8njztAd5vTjVq7eS1cdLUBo3gnFjes=; b=qT96+NjEnP6B62URpbuXwfw0Vo
	hraih4Mhn7kADBC4yYMP3o8YLZJK9VfrzMTuhX+PeyYPkjF2ZCoYnyhCEpeo9Ps3LXFMSIoSOTxXI
	mkJsM5ppCHEK5xlaCfSmM1ZIIldfiDkvkdqXuMd7sdKMbtzXGakbTsIhC+HXRm/8xhmTrKMBq6Vso
	ZNS911WeEcgkHYzei6tYZxxvFUzyv5LLtKT0ZfWuB34zxW89M7C2ffoj6eE6EpnXRBwhGqKrR1T4m
	CBW+8K/Wxy5A3OOTF/FMNhLcmkI5B24P+hP4S5EFxyizJaNyYjJndyUWqT8ly2c/OKAXh7JXx1EVc
	pmieLvQA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:43690 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sI5uU-001sFc-0Q;
	Fri, 14 Jun 2024 06:20:02 -0600
Subject: Re: [PATCH 5.15 000/402] 5.15.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240613113302.116811394@linuxfoundation.org>
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <2c293d29-41da-7790-e7e3-182ba5420bf8@w6rz.net>
Date: Fri, 14 Jun 2024 05:19:56 -0700
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
X-Exim-ID: 1sI5uU-001sFc-0Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:43690
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMSWaLoOgWnjdTQGm3CS1ahh69dsQ+PTOLNBdDRDtqUZCh7RERi84ZQGwDkzWvOqWXG4RpR8OFfOmxGBCXIrKv0ZUMzqA+XBWXP87NH1kAJyyLQp515L
 2czZhKP/a8hSGyH/dCdssoChb5bmr8wssKnX76uIKh5h1kDNJJ+JPq/jJiD0bSIzK4OK8y7TybLKuJ4DhYuPS/MgVkTqZJ0wKw0=

On 6/13/24 4:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.161 release.
> There are 402 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.161-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


