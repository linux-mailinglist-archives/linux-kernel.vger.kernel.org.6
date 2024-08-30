Return-Path: <linux-kernel+bounces-308068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F149656D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAF61C21CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255F14A0B6;
	Fri, 30 Aug 2024 05:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HkehagCJ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734E6EEB7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724995359; cv=none; b=bZWgSFyEdTyxlLLo5MTvWZyc+lTovpXRaBwChxIzA4b5g5olJrxG7KxhrOlU8/yVCJacbcpCQ2iZ/mHi3+zqska0Rs1oerWc3lFL7pmqi5FqNE6MHk1PSVjcBp18SQ+3+hCa0Z96CgIvp5qyq5iKzjEe0TYllCf93U5CgCLheUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724995359; c=relaxed/simple;
	bh=Z9FpZIAERYl4K3YRyheNwrysYSCpYqYGRbzlMCgLbSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F97fCpcsVcBgWWfh/6agbQw9Evvq5leq7WEkqeYFseScQyFY1f0mlknHg5jFGb49e9VPHfe8VUPZecpwtL7S1ZNUuCcFvO9aSafuiDTNO8eJAAbiIGOIIVtwvxfW2AuXRCSNoRDFNxmRJbZsjUMr53yb4XZ8+2FUFNtJWnvBgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HkehagCJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724995343;
	bh=Z9FpZIAERYl4K3YRyheNwrysYSCpYqYGRbzlMCgLbSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkehagCJAubkEO5lKicU3gngC/851BWibLjtFmzEs+3wAsUUnPZE5Ma2K5KxMv4kP
	 DfLs5cQjNvy65yS5SoyFEiVKSauWYBtzjhxfgqEg0/h+xUOi4LqeQOgjuiB+6cTHQY
	 eI7+jpbXFNuo/xIeRbp+2iEE51NzvSVr5oclen9Y=
Date: Fri, 30 Aug 2024 07:22:22 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: commit c2fe0480cd77 leads to hang on boot
Message-ID: <717c608b-6280-45fd-bb88-eeb862a893e3@t-8ch.de>
References: <20240829230438.3226-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829230438.3226-1-spasswolf@web.de>

Hi Bert,

thanks for the report.

On 2024-08-30 01:04:37+0000, Bert Karwatzki wrote:
> To look into the issue I applied the following patch to next-20240829:
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 20517448487e..ba2b0d4b1bd3 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -573,6 +573,8 @@ static int efifb_probe(struct platform_device *dev)
>  		pr_err("efifb: cannot acquire aperture\n");
>  		goto err_fb_dealloc_cmap;
>  	}
> +	printk(KERN_INFO "%s: not calling devm_register_framebuffer\n", __func__);
> +	goto err_fb_dealloc_cmap;
>  	err = devm_register_framebuffer(&dev->dev, info);
>  	if (err < 0) {
>  		pr_err("efifb: cannot register framebuffer\n");
> 
> Now booting works again so the problem seems to be in devm_register_framebuffer().

What happens if you replace devm_register_framebuffer() with a plain
register_framebuffer() again?


Thomas

