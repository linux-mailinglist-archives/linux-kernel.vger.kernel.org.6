Return-Path: <linux-kernel+bounces-207005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB63901138
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD021C21067
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B45178362;
	Sat,  8 Jun 2024 09:57:28 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE671779A4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840647; cv=none; b=dLQ3fDe+B7QVb/Hx85rw1RpKeswageDDGL9z9KC8kve31rdqUyXO0ZuRX+UYFEarySBOcvB35eNt1VBw+lXR7I66+C/ohvYmcQ2SArqg/y4Qp9ITrEKkJhKwQDLNBFxgvgsZJMjkfB2pL0w7Og+P8w9eXu6hYVKnbJN8lwqySHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840647; c=relaxed/simple;
	bh=QNr6XepZLJ1OumPJEZ6zp/XETbX9Dlf4CaIzjYktUqY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTLNJFYV9UY0C/ePvmQ7muScnASuwyggzeLJN/39Zw9erTovx7U8R9r1SM03SXO0TIOSq3aSHg0zBlij5/fS/T7mrqDAfo2OAhBJXMFP8Iab7WgXtYvB6Y7NqVAghHk6sVWpPnMUdZoJiz5nVGFCXrxMvF7uKu10QKwzZhiiD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 811b72ce-257d-11ef-ab0c-005056bdd08f;
	Sat, 08 Jun 2024 12:57:24 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 8 Jun 2024 12:57:23 +0300
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/6] tty: serial: 8250: Add check for setting default
 serial interface
Message-ID: <ZmQrA2_TjgK33uhn@surfacebook.localdomain>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <20240607114336.4496-5-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607114336.4496-5-crescentcy.hsieh@moxa.com>

Fri, Jun 07, 2024 at 07:43:34PM +0800, Crescent Hsieh kirjoitti:
> Moxa PCIe and Mini-PCIe boards are capable of switching the serial
> interface through software control, while other PCI boards switch the
> serial interface through hardware DIP switches.
> 
> This patch adds a check while setting the default serial interface.

...

> +static bool pci_moxa_is_pcie(unsigned short device)

Please, avoid potential collisions in the namespace, i.e.
start your function names with moxa, and not with pci.

This can be amended once you split out 8250_moxa.

> +{
> +	if (device == PCI_DEVICE_ID_MOXA_CP102E     ||
> +	    device == PCI_DEVICE_ID_MOXA_CP102EL    ||
> +	    device == PCI_DEVICE_ID_MOXA_CP104EL_A  ||
> +	    device == PCI_DEVICE_ID_MOXA_CP114EL    ||
> +	    device == PCI_DEVICE_ID_MOXA_CP116E_A_A ||
> +	    device == PCI_DEVICE_ID_MOXA_CP116E_A_B ||
> +	    device == PCI_DEVICE_ID_MOXA_CP118EL_A  ||
> +	    device == PCI_DEVICE_ID_MOXA_CP118E_A_I ||
> +	    device == PCI_DEVICE_ID_MOXA_CP132EL    ||
> +	    device == PCI_DEVICE_ID_MOXA_CP134EL_A  ||
> +	    device == PCI_DEVICE_ID_MOXA_CP138E_A   ||
> +	    device == PCI_DEVICE_ID_MOXA_CP168EL_A)
> +		return true;
> +
> +	return false;

Hmm... First of all, can this be done by using pci_is_pcie()?
Second, if the above is not sufficient, this can be read from driver data, no?

> +}

-- 
With Best Regards,
Andy Shevchenko



