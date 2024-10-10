Return-Path: <linux-kernel+bounces-358671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E483899823A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EAB1C210ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915E1AF4E9;
	Thu, 10 Oct 2024 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDHCjX2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DABE6F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552651; cv=none; b=kH51xpyThXFcAVE5+dCsTBd94i/0X7nw7f1GhEW88kZTj31w5V+3lFUvSGpPBDG06MNJkpamROHMA44TNdLyAxb1qDeiGplaeX+0TGUYn1f52HAap37Wz5BlMcN7e3uMgCVS01wsCkmhflV1DNjZtLcSidCEIGMtsVMZ8pT3rNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552651; c=relaxed/simple;
	bh=PCsFGJ2SHp43DooRSUPo3AoKpYvjwDcTvUcLBVAOyFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmWNkPuGChBwpUlVHk2EzEVRlARGqtnU8efiexXrAE4KcjkAJBOwjGkN3OFUIOh/2t7vsjQ2G1JHoVQmhXKPTeaz1qmph2CkachRHJK0I79Alp+/h5UpFi8hwScXVVsuN0NUG4fXz+lp3AJUlN3FM6gnH4FOCufhWGPVqQSdFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EDHCjX2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293FAC4CECC;
	Thu, 10 Oct 2024 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728552650;
	bh=PCsFGJ2SHp43DooRSUPo3AoKpYvjwDcTvUcLBVAOyFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDHCjX2dyaox+lIl/6V5oVljaCgtjGsqO4s3NyZTAyYsBer07fkUC0NMVRToP77D0
	 INxJG8+JG3JFNieDDEi1G8iQZ3PNOlJMy9wrpzQSNPPW50Gqgipluf5O3dwSNLU70/
	 bdXtGKzGTTQr4cJzzPH1bD8qQN7UtamF13PToH+Y=
Date: Thu, 10 Oct 2024 11:30:47 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "jikos@kernel.org" <jikos@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] apm-emulation: Make use of the helper macro kthread_run()
Message-ID: <2024101016-shun-disparity-c5d3@gregkh>
References: <TYUPR06MB62170C727B3C58B906A9ED11D2782@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB62170C727B3C58B906A9ED11D2782@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Thu, Oct 10, 2024 at 09:23:46AM +0000, 胡连勤 wrote:
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
>  drivers/char/apm-emulation.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/apm-emulation.c b/drivers/char/apm-emulation.c
> index e795390b070f..3c183370a5d6 100644
> --- a/drivers/char/apm-emulation.c
> +++ b/drivers/char/apm-emulation.c
> @@ -636,13 +636,12 @@ static int __init apm_init(void)
>  		return -ENODEV;
>  	}
>  
> -	kapmd_tsk = kthread_create(kapmd, NULL, "kapmd");
> +	kapmd_tsk = kthread_run(kapmd, NULL, "kapmd");
>  	if (IS_ERR(kapmd_tsk)) {
>  		ret = PTR_ERR(kapmd_tsk);
>  		kapmd_tsk = NULL;
>  		goto out;
>  	}
> -	wake_up_process(kapmd_tsk);

Do you have this hardware?  If not, I would not recommend making changes
like this without being able to test it.

thanks,

greg k-h

