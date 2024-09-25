Return-Path: <linux-kernel+bounces-338404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA1985764
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18301F21D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285615C121;
	Wed, 25 Sep 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZrJEVyLX"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B618A6A8
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261473; cv=none; b=mzyYR+5dluYMRy4JfjVg+q2513HGgUPZ+Uebu4bhPHMvCzMerE1ScktIZhvtiUEustpu/UfB092cOM3qeKHrcalyTtghnDflCBSKM8QsY2NBGUOYBPcAuzGiWiL4ASmMsfZA6bGAwrULm7xQ3PY2zx3/Nqn1WkS+eo1hAQBnQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261473; c=relaxed/simple;
	bh=eZB4LOI2lkeUA+pjxtovKm5NOWL9RR/AMSJTQ9GenbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ4G8MNYg35h87oBMjIHKpHHuPEbYwq8BQkQ2Z5YmV7eqjl2QEZIy/k0CWlY0D6ADuhc4PVhHwN9tDl/Y5umi6WJCD10L3cVk+BcHDD73EJlDjXJFEwVi+FsD0gx4iFZItmwx8+eDfHQYzOtvnfgupOx6qpoAeQgIlyHs1JZ24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZrJEVyLX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=gIE4ClAg/4k+U9GvOpWkePBtiyhmqAlYWcwX8eAqx+A=; b=ZrJEVyLXlfblnAFN
	d9cGWTv2QXKXj6/dpz2R5xc7sfvGc2jaEbmpJNr9lhJUItTiRP1rdKcZuQZQm0qplFTMMMjqC/ULJ
	bLjc/gfEwoWLP0W5dXopywK7JvodEjesjeJ+k9Rx/hUKWcUr1J9Nx5F+q7BK4YDbrEO8xPh6ogkyF
	0uFeo2pXn3BmiMjbCV0zMbVh7IS4rNj78YOE6nfpZQAudPotc1VqkrnZyXUIKNWCbV+bBv2JkRmG8
	98dLlNmHMRlcihrj6f6Xyilr5XTWO90obQAvZA+9mZ3hJnw/QkhCnUUoYu4A52BKACwJiaA995KJ6
	OR1sA+qcoJ5rh8Gz/g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1stPbr-0079y9-0a;
	Wed, 25 Sep 2024 10:51:03 +0000
Date: Wed, 25 Sep 2024 10:51:03 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, W_Armin@gmx.de,
	hkallweit1@gmail.com, jdelvare@suse.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: fix cacography of switch
Message-ID: <ZvPrF9FRuY88aq3J@gallifrey>
References: <20240921103644.14667-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240921103644.14667-1-liujing@cmss.chinamobile.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 10:49:00 up 139 days, 22:03,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* liujing (liujing@cmss.chinamobile.com) wrote:

As well as fixing the sign-off that Greg's script noticed, 
I suggest changing 'cacography' to 'spelling'

'Cacography' is a rare word - I had to look it up!

Dave

> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index 9df12399bda3..cb1c4b8e7fd3 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -97,11 +97,11 @@ config EEPROM_DIGSY_MTC_CFG
>  	  If unsure, say N.
>  
>  config EEPROM_IDT_89HPESX
> -	tristate "IDT 89HPESx PCIe-swtiches EEPROM / CSR support"
> +	tristate "IDT 89HPESx PCIe-switches EEPROM / CSR support"
>  	depends on I2C && SYSFS
>  	help
>  	  Enable this driver to get read/write access to EEPROM / CSRs
> -	  over IDT PCIe-swtich i2c-slave interface.
> +	  over IDT PCIe-switch i2c-slave interface.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called idt_89hpesx.
> -- 
> 2.27.0
> 
> 
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

