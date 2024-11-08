Return-Path: <linux-kernel+bounces-401423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD099C1A46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA681F260E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450981D3625;
	Fri,  8 Nov 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y44aBSah"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C51E25E3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060876; cv=none; b=FfWpop2sxxVgJ8yyszkP5Xh2YP/VwuJv72CPxkNGus+XyyVliDn84snRMeis4yZdKLyWNtuv1cDsCzjilRbVT7yJ9frgKviBzyC7wujqa/wN69Jx+0W1Iey70jJG7/Cju6XXGjV1INNsi8RfMutv48SXMYnuA2tOIinKIfKIjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060876; c=relaxed/simple;
	bh=XkGgv5eX9hGP/+6vsdILQJodcuwb2z/IVmUjUdqJ/2g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjZeFfyDhRn+KDVtan1LO7eGgHNcC871w7LDdR4CSOLz6dv48XShoOeKvzLgYCazLowkMBj8LIKvBssqrUgb9uY/ZDOQvmWBnejZvQar0LJzb5q2yPd82KaPxyZOnvZJcM+Av3dRhB1YpDgcAGGbUU5Z71XnL7D76KLA+l3UEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y44aBSah; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a99ebb390a5so562752066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731060873; x=1731665673; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SnVZ0emV6bVkYUAc532QwJ4he0bCKDKGP+zZEkPy81k=;
        b=Y44aBSahMuLEW64kUDU8e5oWPxHX1p3+jAw2IQ+FDwJah7gKRz1KHXo5GAwFdlxy38
         ejBhlWG2pwG3x/RFPbF+gHpv3heebEVwAG1jqgJzUP7Vi3IDeP+zqc1xwtn3jO/+WkNG
         5lfE9hyQUoAwSgaCY/Eq5oB0FD5uDyCARVECCzN/zovWJAVed5P8cQ9/07gZxrqfmt7y
         HbRTXNZNfbPg9BzfuqxCkuFFEYP85FJbRTe9g1xblZnEQ8ZMv5U7CsLRLYKyWdZZzPUw
         QZYjNdeGhnBTwsgxJjs6FM879C+80DX6VT8jDLS1rxnZgdjLgGqF/kBB/hkEUzJ0t2j1
         nRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060873; x=1731665673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnVZ0emV6bVkYUAc532QwJ4he0bCKDKGP+zZEkPy81k=;
        b=HiAthNpiYHNhQjCKw6vDhJM5pVWUYo6+nB+kvuOdgf85lmaWg9i4JeJxORp8wvb0lA
         9OqQ6y3HRg498fTpijDS5JNU9P0AuSdyWeSyI9lrO8oLCKX9Cwur6+MbpsUkvAOiFnjR
         TYrzaf7nr56Oe9DRQGe5+3U+VBoPhNRCpgWaFsz6A2k9lGGuhwmTKlcSOkZ4NPy6P+Rb
         h+xxMAOIiCZ4coDUS+/Dy9TGF/SYpYIe5jhT82tuMNwmLGvYXjw1R/MOljDUW6Tz+u6w
         pUGvwzKQGZPDM0aDKTZwp0EJ6ZHOshEpysen3u+ZFtEFgPvJNBF8QLkC5+6Cvv6WPUGd
         63vA==
X-Forwarded-Encrypted: i=1; AJvYcCWdpvtddWEVct86LFiRWXH37SdQVL6wXGON9M3tMXIVk6seX3aUGATUR+u3vEBpWfLMnPQZ/YurkJFR+Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Skr7lNvgEu/iLRKsK20mah8XD4ZTgBkxQ8MGOv+aPkX4+mgN
	WLUMXPyDjtSlb8w3xkEPULqSWIvNYEHZOniJ5USoGKVIzoYV6HgmgZww4+8FXTo=
X-Google-Smtp-Source: AGHT+IGMkZNj149mgtvYpa+dcdi+Hv2GUHkHisgCOmyCoj4UxPuG3y0YVKFRG6NnyfhzAQT2cBQMhA==
X-Received: by 2002:a17:907:9455:b0:a9a:b818:521d with SMTP id a640c23a62f3a-a9eec9cf03dmr279872866b.18.1731060872701;
        Fri, 08 Nov 2024 02:14:32 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c7asm210184166b.96.2024.11.08.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:14:32 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 8 Nov 2024 11:14:59 +0100
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: of_property: Assign PCI instead of CPU bus address
 to dynamic PCI nodes
Message-ID: <Zy3koxz4KnV39__V@apocalypse>
References: <20241108094256.28933-1-andrea.porta@suse.com>
 <20241108110938.622014f5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108110938.622014f5@bootlin.com>

Hi herve,

On 11:09 Fri 08 Nov     , Herve Codina wrote:
> Hi Andrea,
> 
> On Fri,  8 Nov 2024 10:42:56 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > When populating "ranges" property for a PCI bridge or endpoint,
> > of_pci_prop_ranges() incorrectly use the CPU bus address of the resource.
> > In such PCI nodes, the window should instead be in PCI address space. Call
> > pci_bus_address() on the resource in order to obtain the PCI bus
> > address.
> > 
> > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> > This patch, originally preparatory for a bigger patchset (see [1]), has
> > been splitted in a standalone one for better management and because it
> > contains a bugfix which is probably of interest to stable branch.
> 
> Nothing to say for the patch itself.
> 
> Just here, you mentioned "see [1]" but you didn't provide the link.
> 
> IMHO, this is not blocking for applying the patch but, just for other people
> looking at this email in the mailing list, can you reply providing the link?

Thanks for pointing that out, sorry about that. Here it is:

[1] - https://lore.kernel.org/all/f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com/

Many thanks,
Andrea

> 
> Best regards,
> Hervé

