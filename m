Return-Path: <linux-kernel+bounces-386032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E89B3E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4101EB21C16
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E21F757D;
	Mon, 28 Oct 2024 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fj6HdWsv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3811865E3;
	Mon, 28 Oct 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730157779; cv=none; b=Kppg90rFylxc5KFPMAsI5zD7AtFtbCnZxygf43EQnN4FH6XYwrFsXf7cn3jhoJIn8XtV1RkOLtVGOv7pNKAPnRXn9yhK8m+fPRTXF9tvnmEn/rwcBotiLcXVAhEvQBR1BzqCHt4RoIJ+HFQItSLnyLAxhKmTYqX9GGKPv47QIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730157779; c=relaxed/simple;
	bh=clcnLITg0dyXfdxuOg7CzAxWSBbASftx2mnw/aAekpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf/BBqU4r29koy2Htz08ZNuSTRHhiedIEvBEbEWv6nDJcAU6GqfmYjbwhtbBlSYUQU8yYw4RygMvJ3JQuEbq8x8WB7lBAhYuT4rfj5xPr2wkvQXI+VL4IbGb3EjsgcmLE+lIniJlG4MV+TsdpNDA6XInI/2Zzfw7qon9IQcf6GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fj6HdWsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DC4C4CEC3;
	Mon, 28 Oct 2024 23:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730157778;
	bh=clcnLITg0dyXfdxuOg7CzAxWSBbASftx2mnw/aAekpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fj6HdWsvXIvmvz1wkZaB/Q+gax/NIkUEdVrXQUMUdGCb2Y0Cb6b9x0ZLnbddsX+g0
	 cuZmZv6vxSnl7MgwntAVA58ygox3YJiFsV0TU2b2lcuYSbCnhuaKihXEXteNYMKwPt
	 4e8MfnzaDP7UI0riB7VSPuNL1YuU9F74tvxApwak=
Date: Tue, 29 Oct 2024 00:22:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: latest stable-rc tarballs missing? (was: Re: [PATCH 6.11
 000/261] 6.11.6-rc1 review)
Message-ID: <2024102920-crib-poking-50d5@gregkh>
References: <20241028062312.001273460@linuxfoundation.org>
 <b1675bcb-41bd-41ab-8e10-ab80943b1ff8@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1675bcb-41bd-41ab-8e10-ab80943b1ff8@leemhuis.info>

On Mon, Oct 28, 2024 at 11:02:37AM +0100, Thorsten Leemhuis wrote:
> On 28.10.24 07:22, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.11.6 release.
> > There are 261 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.6-rc1.gz
> 
> I don't care much, but TWIMC: that URL gives a 404 here. Not idea if
> that is a issue with the local mirror or if the upload went sideways.

Sorry, this was my fault, new laptop and I forgot to install the
perl-simple-config package that kup requires.  Should now be fixed.

greg k-h

