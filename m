Return-Path: <linux-kernel+bounces-425847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78B9DEBD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE860B21ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC419F12D;
	Fri, 29 Nov 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="acAEM3hM"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE61A00D6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732902306; cv=none; b=AY2bRhMUcR7dDEEPdRgI1lnaNsbvh7AEKaOkdMWi8FISYMzwWOdWcnSsW6w+ZHOVMq1PjGUu5B7dgVSMF64ews6H8ZVc4UemwuMLgugulJCBBJaGt4mjaH02tVeSfUB9qLIPkZ2f3LG47YE9rK4+i6bZVaQk/GlR/QtsAQJlJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732902306; c=relaxed/simple;
	bh=dN+m/OuOjAu8rOWkw1ptGTJSKEYTv9i6wNucxm9lJE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2FLXBdOfGMTyP5F4FKbSicHOPob7x0zJnWu2td/A1n17bgplJ0pGpgp2/a+0JhV2z9EWeS2EZfJ0gq8tG9xyiUJRi4NtWZJEZt5w41PEz/ddzdiaP9xjK9BZ1RDpGNyJKMfYr0jv6mb0NO0/ZONsRDNAceP1YJL0hqHKTfM1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=acAEM3hM; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22B941BF206;
	Fri, 29 Nov 2024 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732902302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSrvf/Tz9Ahw456wh1QxtSPDS/KV+CEmOfTnenQNvw4=;
	b=acAEM3hMBWtt61nkBLg4u9k/nNlb5fNAOm9Tt8mfctVm96A/lMCVzKoaSFmjkn4FKGaaeK
	nTN7mSEJ8epZAO9oM5Xb7yGkXWI/QAmZdSM09Yqjrx/3figngxxuqxPyY5s7+4mNTYXihS
	4MrL0TPRAhJNJkcg/5U7zdI+ikMXgOau/AoAxh622+TfK6/F5suBtCPh4SDAnC93Pj4QyT
	XWXtu2ph7xAs95MksEHtgCNUy8muLw2rioJm3Lq1rvBqZhvs9L93rvtDwZzundEDV9Vjuy
	ihukcGRKgldd5WeO7QLMdyb6CPFuQFguT3OLzIBBQ1Vp/OeIcxeOtVQHzpJXFQ==
Date: Fri, 29 Nov 2024 18:45:00 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: Kconfig: Make MCHP_LAN966X_PCI depend on OF, not
 select it
Message-ID: <20241129184500.6d72a7e1@bootlin.com>
In-Reply-To: <20241129-lan966x-depend-v1-1-603fc4996c4f@chromium.org>
References: <20241129-lan966x-depend-v1-1-603fc4996c4f@chromium.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Ricardo,

On Fri, 29 Nov 2024 10:41:17 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Most (maybe all?) the drivers depend on OF instead of selecting it. This
> is more convenient for CI because we can have test scripts that do:
> make allyesconfig
> scripts/config -d OF
> make olddefconfig
> 
> Without this patch, OF cannot be disabled that way.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/misc/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 902c306bc972..2ea5f40ff4e4 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -612,8 +612,7 @@ config MARVELL_CN10K_DPI
>  
>  config MCHP_LAN966X_PCI
>  	tristate "Microchip LAN966x PCIe Support"
> -	depends on PCI
> -	select OF
> +	depends on PCI && OF
>  	select OF_OVERLAY
>  	select IRQ_DOMAIN
>  	help
> 
> ---
> base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
> change-id: 20241129-lan966x-depend-8bc69b4954e5
> 

Not sure it should be done that way (See [1]). Also I pointed out this
patch in the discussion.

[1]  https://lore.kernel.org/all/dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol/

Best regards,
Hervé

