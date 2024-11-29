Return-Path: <linux-kernel+bounces-425777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562B89DEAF1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A5F2819AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429D198842;
	Fri, 29 Nov 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SXKYN/KE"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235B14B075
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897671; cv=none; b=n4TFu55V0tmLsOnkaOYL/UYJZ73ZnqlQFDlN53tLnvcSRnTR0PnEJjFnxnhzsPd2omtPRwLo8YfmihcoXh6ZI/CHuhcbtn1hegvWHlXm9MaWhsU4N0Rdr9/UFbHFC9cQ3np/x+zkGmiqsYi5Supetlw3AbE9jNpYePbp+leDbYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897671; c=relaxed/simple;
	bh=5w1O89chOqgyMhWZqb9VM6E+m7Ixqgv0RFEj+OZES/M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+56deaHKE9K2SjsxXoVJTboG6QAYPE/IPeAPMZipZcBfSl7i9g7AgEbJeoUqsAsM2ecxd3sGNxtqEW/oknVpj6Ys/PchaT6xwfcc7OmYhRNnH+jhfxE9ORt10bT5Tpsyju4rGt6pa4UqrsO0RK13et0RSo9tl9WyLlA/NOQ/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SXKYN/KE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso392809666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732897666; x=1733502466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OwH5v+3GE18kFTNrayT4BgfE0WPSq36ccL8dVwg+Yh0=;
        b=SXKYN/KEOyynrFJcDSY9fKinPxPtzm7uWRAULf7byMbXWKz2zCJu6+aQnV0Ep6+Wpz
         UWoux77G37vEbXIdP0h95EneTQqw8W2nAx5UaY/ePqEfSOrxE9elLbGEcs/ZIqsv6bqF
         Y6Ukh96oPrRmCQvTdqpOU/xxQW0kIQIsYqzpkA823EiuH7tr+sBr8y/aZY7OEBoPuO07
         4yeVObIAAL64qCdwaLxiXHktmKeQrd/sagClP4y8JbCRwV36elsRVvcFRCncLiiHcx1g
         NDURsOThUhktc//Il1++bMjEk9NqtJYNbliGeWiyN9/7LaoAe4Js8NNjnaRwr1ql/4DY
         EUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897666; x=1733502466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwH5v+3GE18kFTNrayT4BgfE0WPSq36ccL8dVwg+Yh0=;
        b=kUm4PK4eYGQAUtG/iC1A/WaddBRswgXhkVzVEZoEpwxAe0ONVTTNhqtlPVQXI9H2n1
         RFVGK8yyiC3zPuQwerqcTsl/zbdRSJs0Qv33tnV9OypMuRvXGyETflReq7xX91ADDujb
         KEIwcY0+d4qn3qFe9kf0Df0nJoXFN/XOV2jkj9K6/oANE5wsj2ysgFTJ9F+auvVMiZau
         hugp5evpcrxY/mLoIZd/0Thy0av0lqlTSclr+iU+h+sEmlMQAPKfWLYX3w+oQdTDu6BK
         TjIu/IesF6cQokcEuutdGczJ/3CSTTouI/+1vIjOLTKZJRmD5eBymQ6MUygiCvT0E9b6
         BiGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCcFVyGTzbCnnKs3IRwY4NhQC9SZ5w4Aug4L1tKOk5oYuH9+LNCdizp7H+6DlG60GUUQwReO6aGkakyvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0PoIIffw3wMLmEtwnp8mLh1QD/Foh7P4xqKNqrQ896kPLcxoN
	S0k8sPHeBLV7NSfDK7BoT49WTfdL2khAc4kLKJXOs8Lw8kse8PwdbsldmjNCDB8=
X-Gm-Gg: ASbGncvH25/T93kltX1+0TQcDrzepcyy5Ol5DB7fOh0spvWNcI/cMRfL8TkxH7oKQfu
	QuvFbZSBI/W1E8YZJ5lhoW1TPb1qq+pztKPxwLn6m8hqA7RE+F56k+9M1hpUcm2MTmpRx8tJSU/
	0FadJ4+pmlW141C5QGY6v2oDGdnBu26bzB7UdZl5b9pz4VuaqxZy8spCXQOKBAjRTFJr75ZAuey
	V//kxPpZsSvl9CTLjVKtWDUX5SRAJKlM2tfiwqgJGbI2HFsa5y2xDJqhvNoEvdjX0MP31dPhCcP
	H4XRElbub0RalO3sp1Sc
X-Google-Smtp-Source: AGHT+IFdG9GOu7z7VbF3RaWxqyGcxIpQuKws1pr8ZUhjgAPYuz3ueFSPxNUGdj5E67EBohC3LgYQSw==
X-Received: by 2002:a17:906:318d:b0:aa5:1957:3431 with SMTP id a640c23a62f3a-aa580edfbfcmr1150158266b.1.1732897666347;
        Fri, 29 Nov 2024 08:27:46 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c193asm189510666b.38.2024.11.29.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:27:45 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 29 Nov 2024 17:28:19 +0100
To: Stefan Wahren <wahrenst@gmx.net>
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
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 08/10] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Z0nro2vMNxoU35GH@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <c48e6b9b178cdaa01b92ae82e8fd24c2ba5f170c.1732444746.git.andrea.porta@suse.com>
 <c5575991-eab1-40ef-a984-b23076b09cf3@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5575991-eab1-40ef-a984-b23076b09cf3@gmx.net>

Hi Stephan,

On 19:35 Mon 25 Nov     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 24.11.24 um 11:51 schrieb Andrea della Porta:
> > The RaspberryPi RP1 is a PCI multi function device containing
> > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > and others.
> >
 
...

> > +          Support the RP1 peripheral chip found on Raspberry Pi 5 board.
> > +	  controller, USB controller, I2C, SPI and UART.
> > +
> > +          The driver is responsible for enabling the DT node once the PCIe
> > +	  endpoint has been configured, and handling interrupts.
> > +
> > +          This driver uses an overlay to load other drivers to support for
> > +	  RP1 internal sub-devices.
> Please fix up the leading whitespace here

Ack.

> > diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
> > new file mode 100644
> > index 000000000000..508b4cb05627
> > --- /dev/null
> > +++ b/drivers/misc/rp1/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0-only

...

> > +#define RP1_INT_SYSCFG		58
> > +#define RP1_INT_CLOCKS_DEFAULT	59
> > +#define RP1_INT_VBUSCTRL	60
> > +#define RP1_INT_PROC_MISC	57
> > +#define RP1_INT_END		61
> > +
> > +struct rp1_dev {
> > +	struct pci_dev *pdev;
> > +	struct irq_domain *domain;
> > +	struct irq_data *pcie_irqds[64];
> > +	void __iomem *bar1;
> > +	int ovcs_id;
> /* overlay changeset id */

Ack.

> > +	bool level_triggered_irq[RP1_INT_END];
> > +};
> > +
> > +static void msix_cfg_set(struct rp1_dev *rp1, unsigned int hwirq, u32 value)
> > +{

...

> > +	struct device_node *rp1_node;
> > +	struct rp1_dev *rp1;
> > +	int err  = 0;
> Please remove the extra space after err

Ack.

> > +	int i;
> > +
> > +	rp1_node = dev_of_node(dev);
> > +	if (!rp1_node) {
> > +		dev_err(dev, "Missing of_node for device\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	rp1 = devm_kzalloc(&pdev->dev, sizeof(*rp1), GFP_KERNEL);
> > +	if (!rp1)
> > +		return -ENOMEM;
> > +
> > +	rp1->pdev = pdev;

...

> > +	err = pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
> > +				    PCI_IRQ_MSIX);
> > +	if (err < 0)
> > +		return dev_err_probe(&pdev->dev, err,
> > +				     "pci_alloc_irq_vectors failed");
> > +	else if (err != RP1_INT_END) {
> Please add braces for the if case

Ack.

Many thanks,
Andrea

> > +		dev_err(&pdev->dev, "Cannot allocate enough interrupts\n");
> > +		return -EINVAL;
> > +	}
> > +
> > 

