Return-Path: <linux-kernel+bounces-240993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB5927572
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEDD1F226F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EA71ACE63;
	Thu,  4 Jul 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CX3LoUce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAA1ABC29;
	Thu,  4 Jul 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093637; cv=none; b=tGNpQ0LDI3AMlHJSfXnoEcMMt+TXEudNS6m99swdPCcaNUe69C1RlgMaYyILnuuZ7Fw0dGwm+xymqCQdUvukCzcWdlMAMEu3QuWva/ypKk1dy4Ppluf0OoSn66G3jOGNmogk6mJbeumVytnwcaNvg7QsqDcZ6FqQnUW2Pv4D3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093637; c=relaxed/simple;
	bh=2hHfiNTrMunafGHifKj+0dJHBw6gtN+42Y+OqGplmJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To2VZ9Gd6bGVkMz5cVphTOW/MRLHFg8Pw0/qeb/K4lh12Sh56K1oH6LqUf2DwZwwycbTkUNkI48++Root9htqp7/BGjOSgxh+3ygv/eeD4wje6/7Ntz7rSAOZiMP3lR2AdV3zApXOeLKKJp3vw7liMVtrJj6OY6ll5wgf6DYsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CX3LoUce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72547C4AF10;
	Thu,  4 Jul 2024 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720093637;
	bh=2hHfiNTrMunafGHifKj+0dJHBw6gtN+42Y+OqGplmJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CX3LoUce3s/jfHnb8Qy1WdNi+QrHQbDxUOadSBx2mDFEGNY3GdHmo714FV8q39Jq8
	 wEn7CCsqgedkMKhlW0Fw0Wobi4EI2d6scgbOui1ECHdDZCZFc7H0zOd75qTvtGhOYX
	 zFrLNqC9Rl1IRC24dLbMYv9/N1G9gIlU89Txou1c=
Date: Thu, 4 Jul 2024 13:47:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 1/6] hwmon/misc sbrmi: Move core sbrmi from hwmon to misc
Message-ID: <2024070448-spectacle-pungent-38ba@gregkh>
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
 <20240704111624.1583460-2-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704111624.1583460-2-akshay.gupta@amd.com>

On Thu, Jul 04, 2024 at 11:16:19AM +0000, Akshay Gupta wrote:
> --- a/drivers/hwmon/sbrmi.c
> +++ b/drivers/hwmon/sbrmi.c
> @@ -3,190 +3,18 @@
>   * sbrmi.c - hwmon driver for a SB-RMI mailbox
>   *           compliant AMD SoC device.
>   *
> - * Copyright (C) 2020-2021 Advanced Micro Devices, Inc.
> + * Copyright (C) 2020-2024 Advanced Micro Devices, Inc.

Are you sure this shouldn't be "2020-2021,2024"?

thanks,

greg k-h

