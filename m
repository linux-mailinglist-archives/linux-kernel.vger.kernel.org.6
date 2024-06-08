Return-Path: <linux-kernel+bounces-207001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F8E901130
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09141C2117C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D20176FC3;
	Sat,  8 Jun 2024 09:51:07 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543CF1EB40
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840266; cv=none; b=Pnx+GiLKDOIQcbNudIMrh1VE4NurlKS3I/bZn+pJYBKJnp10wvwfOedJmuB0ufiCdzAp4z+rjOzz+rom6s4uXX2diQqKRGXztbxzOy2pR8sY6c5Q2nv+TMKob9aPVnFfUbnODPDgv8trFszQOppv+taTIk5jMV7ZTCck2tHOmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840266; c=relaxed/simple;
	bh=D/jB0XgeuTal8IdtuQ9W6D7Q5suMcgKwNYSpOc0QwWg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5NE+jFuBa8jhtECmTJBgRw+0wBDyDbNlqyrScGgB1XmPF86PEh0/8dq3k56d50RAB7msVs3zT784ogvrJ2GYv1y+uKUytAGpwUdpYFe9F9yQ4916wgl2XPMzWyAyRsZRUbiRAcBvODXl8ODKREiWZavuHtsbSPPbiiGrn7foWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 9e1bbe5b-257c-11ef-8d59-005056bd6ce9;
	Sat, 08 Jun 2024 12:51:03 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 8 Jun 2024 12:51:02 +0300
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 5/6] tty: serial: 8250: Add support for Moxa PCIe boards
 to switch interface
Message-ID: <ZmQphhYQi7tSjBIM@surfacebook.localdomain>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <20240607114336.4496-6-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607114336.4496-6-crescentcy.hsieh@moxa.com>

Fri, Jun 07, 2024 at 07:43:35PM +0800, Crescent Hsieh kirjoitti:
> This patch adds support for Moxa PCIe serial boards to switch the serial
> interface by using ioctl() command "TIOCSRS485" with the flags of struct
> "serial_rs485":
> 
>     - RS232                  = (no flags are set)
>     - RS422                  = SER_RS485_ENABLED | SER_RS485_MODE_RS422
>     - RS485_2W (half-duplex) = SER_RS485_ENABLED
>     - RS485_4W (full-duplex) = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
> 

...

> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		if (rs485->flags & SER_RS485_MODE_RS422)
> +			mode = MOXA_RS422;
> +		else if (rs485->flags & SER_RS485_RX_DURING_TX)
> +			mode = MOXA_RS485_4W;
> +		else
> +			mode = MOXA_RS485_2W;

> +	} else {
> +		if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))

	} else if ... {

> +			return -ENODEV;
> +	}

...

> +	if (pci_moxa_is_pcie(dev->device) || pci_moxa_is_mini_pcie(dev->device)) {
> +		if (pci_moxa_supported_rs(dev) & MOXA_SUPP_RS485) {

Two if:s can be replaced with if (foo && bar), but it's up to you.

> +			port->port.rs485_config = pci_moxa_rs485_config;
> +			port->port.rs485_supported = pci_moxa_rs485_supported;
> +
> +			if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))
> +				port->port.rs485.flags = SER_RS485_ENABLED | SER_RS485_MODE_RS422;
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko



