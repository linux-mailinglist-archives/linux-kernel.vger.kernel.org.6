Return-Path: <linux-kernel+bounces-180278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2AA8C6C56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B8B23028
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6111591E8;
	Wed, 15 May 2024 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="riIiIv4S"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54451158DCF
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715798804; cv=none; b=eIcZCZqIXWl2Yqs62PsVDOmW8aDc7fx16nsQtnTqvk+ENmkvX+l3W4KYh0xgi58Ncb1HnOEndJ7M2TKk5Y3+IPkXo4PiArmamw7h0yoeTPFDRyVIsg2CSFRoR3KpI4byoDt6iyFHF8Aq/ojIFf0zai5coQNFMacpw1cYMODF4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715798804; c=relaxed/simple;
	bh=NLm/A4aOGodHk7UpTsgF4L2V1jE/fd6Fmr0C+mdAMyg=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=jnnsGvRbTGYJEOXkn6OtfgjMWcsKxdPF1ztdL7glKDXyLgscPXNYuvoKWI7jhdgSw8CsXiFk9sI0ihgmIS1dfaolUmbMAPU6cI3uy/0YSd3tVw+PkHI+I+mL+TqL8nzNNFRDmIp8uOQAPEwG+sUKb2Yc8jnWDTwBDpTV8p6TTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=riIiIv4S; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id 6vbQsnSQPFfFD7JcesEqdB; Wed, 15 May 2024 18:45:05 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7JcdsThE6nbVE7Jces3nM6; Wed, 15 May 2024 18:45:04 +0000
X-Authority-Analysis: v=2.4 cv=MbFquY/f c=1 sm=1 tr=0 ts=664502b0
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
	bh=rpE1f/Avsk4JtoARdzzHoFOQIic7ENEEYSuxgA0GeXM=; b=riIiIv4SdWqmVDS/LIpwOOrgsx
	NiGlzXGrmTs8crBYkZnPzDLsCfONUXHXzWEwSj5GZ2R+xWwoVsyxYxFxnKDGNdNI5thXXm4EJ+3Pi
	gFcqhNj0PRlWqNK+2GJY1Jsk7rOfmBv2q53PzpbdA06b+10qcItPukGr1vM21+MUjDhlfdnrsc/bR
	Fw51ouMdxn/V2wIlV2Ar1OenKgiDeToLmW8jul67Tk5xO8YPZYHVj9LhStwFXULgrsOKN/CerESye
	lEFEyN10IOMXXYHkie06av+3svW9maxyKp5C5dU6mpVH/1/gEaKgEH38XGn5K2HhHfubG9Afz6c0c
	TJnxKdvA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35780 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1s7Jca-002K8O-2i;
	Wed, 15 May 2024 12:45:00 -0600
Subject: Re: [PATCH 6.8 000/340] 6.8.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082517.910544858@linuxfoundation.org>
In-Reply-To: <20240515082517.910544858@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <d56f3d69-fe6f-83e0-127f-c30085ce34d4@w6rz.net>
Date: Wed, 15 May 2024 11:44:57 -0700
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
X-Exim-ID: 1s7Jca-002K8O-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35780
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPfqEVmEFwfCGlL0k0Zv989BUS8F4Dn4XdoBRKGaWHJLWY4zsCs4Is2LVy05YjJOgbLEcOf9PnOKYNQRd1yPLK6ryGqiGKLqhrmty8Ysoh349YiF8upH
 cGnTiY2ADga5I0NmSdAWySs0y+xotHc+o6MQjSCEIgBq0/XrOihnHppscRggRlNYiNpqlzZBjG+2+tOwimWbDZivKNCSiF1p5SI=

On 5/15/24 1:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 340 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


