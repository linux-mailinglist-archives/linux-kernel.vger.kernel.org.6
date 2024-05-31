Return-Path: <linux-kernel+bounces-196672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0608D5FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A731F21218
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE8155741;
	Fri, 31 May 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCWKVfCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5E150997;
	Fri, 31 May 2024 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151264; cv=none; b=SeY4eNl3uM5xcl50HVpLKbb/U69TcqOhq5wUsgDBuWF2JOEd59vFWmUknrucl+AqxsPSGVhNAzuNM5Pgg8rCZJyw1G8UHPjPLrbv/KmCRtGHwTtKobMG1KjF15sX0bxFpP/ljFKDeYASymmSzmvUe3Qk84nI2HuUIm64PZcMR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151264; c=relaxed/simple;
	bh=PM8ANQnKhvkI+gz4ItjHDKqR6gOZxi2IR2Bb937AyPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx0nldO5ofz9F3xyKtYvmfQhxq5u45Z5dxRRppdQMpwLGi/ddcK7eY6b6W+0xxU4dN87kdzf8pvj+Ae/NVLIYQJEbupKa86R7y9xdj4O4bUD0wkmVMnI0gWfBd1L/vfolUVmLMcXtdHci7xzHEeB57gNqk7FZXRfE3lpG2rSMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCWKVfCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C960C116B1;
	Fri, 31 May 2024 10:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717151263;
	bh=PM8ANQnKhvkI+gz4ItjHDKqR6gOZxi2IR2Bb937AyPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCWKVfCMa9YNVJZ0npgh0NnanJsG2pPCP05jHEGQYUIKOXmoUP4ijuS0lttbjPNSz
	 xs1QABG861GkgPMFZ5kgeU9ksJLRoSjiaPzHV+wnMNdYT3h6jAWHOzFnKRr+raGyWm
	 fNj1jnTUcCYgrN5Jc4VoCH1pseZDuRPtEYlaGaJI=
Date: Fri, 31 May 2024 12:27:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Mack <daniel@zonque.org>
Cc: hvilleneuve@dimonoff.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: set driver name
Message-ID: <2024053127-custody-bankable-817d@gregkh>
References: <20240531101959.181457-1-daniel@zonque.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531101959.181457-1-daniel@zonque.org>

On Fri, May 31, 2024 at 12:19:59PM +0200, Daniel Mack wrote:
> Set the drv_name field of the driver struct so that the tty core
> registers a procfs entry for it. This is useful for debugging.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  drivers/tty/serial/sc16is7xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index bf0065d1c8e9..308edbacda7b 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -351,6 +351,7 @@ static struct uart_driver sc16is7xx_uart = {
>  	.owner		= THIS_MODULE,
>  	.driver_name    = SC16IS7XX_NAME,
>  	.dev_name	= "ttySC",
> +	.driver_name	= SC16IS7XX_NAME,

Are you sure this patch is correct?  Look 2 lines up :)


