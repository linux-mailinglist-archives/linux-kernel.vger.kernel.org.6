Return-Path: <linux-kernel+bounces-425868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFCC9DEC04
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB4AB21B96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DCE1A01B8;
	Fri, 29 Nov 2024 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SnQRzeNL"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DA14A60F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904262; cv=none; b=dqr0S0/KDzwffurcnx7+UJXAVg6FTXUhwA2skTwGpcKs+1+oCfTPhaHrB7piswYq/8ySvVFr8ZEbXau6wUcEO6LdtHzcCY2Cr0aAXisxU4SJVQ2Wos9qi3SslOeS8VUGHtMKFcbwckbG7fNyFAMWohQLV2zI/daXmgzQAzDHyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904262; c=relaxed/simple;
	bh=fN0bLk90ZCqU7t/VgLksSaWfjvLd7tuev8IlpU2KjsE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuZTY0z863mUfGb5OefB/pgAPM6BeHw25zG0b7rBMgEdOVfNmCgoUwnbtKOjy/2OAPM3+1RZSfKVN2aReRPQTsL0Hbep94LTTr7XGqQFjkptjuTxDPJktpOX/hy3m73ZBC3Gva36FO73eyMYeTSFBCGsQzM4bkxw6gX+NmjgcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SnQRzeNL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9e44654ae3so249584866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732904259; x=1733509059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/K5xGcTYHJ/8xAu9IkRPPHbt4WWLkz+NlJpLlbPrtJ8=;
        b=SnQRzeNLk5c7PEqfpHhgVBsmwKuQCsuV1f/0oERNlyJqz/K2rylASeCEgXxa60Pgcc
         ingVz5XZcah5FZXSfGj1/zDe/yy1YB/q+eZStOeMvUeG0eVNyTZVuacz1SbBxShKBhrB
         6da0qBDYWpnWYwfk6kmc20th2IXKiXfhqDQnunlU2tcq/XxRy7KIPxQ730SudN+mAYJz
         ioIIzug23+X977rvz2y7R+JMJ96tozihtkpI6BBY2UW7Zq3JiJmcQn8nI+aR+7WYH9Uk
         nS3FBAogQJm0+f1tLMAyVOPtcImOrptr1UUfa82JCWIN8qoHQvMzbso32yD89Xlj4dta
         yg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732904259; x=1733509059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K5xGcTYHJ/8xAu9IkRPPHbt4WWLkz+NlJpLlbPrtJ8=;
        b=j8fmf3eCwveqkitUQa3vdNdaUeXahID/7X13huAzdUlqAc+cSWZ/qxtcv6nUGS7EBd
         QUSptmZQUZR38KPaQT6kOSdwhN/vSjfvERyM6CYnYheFAf9IWt+UNsHs7K6sPQ7Nd7AJ
         qmYuIpnpGTsZBtY8nhAsgCbMz2Xgt0G5yoj5tADFSRhvIZiV5uG+c8WChosqmflJpBiQ
         lM0AWQQVpBh+QK8gFj5rHmcSvelaXnFUVcMjXb6Lj/bWukTUWNv9MO4yDB5t5cpZUqQ6
         6+eTqf/rmbM2nemWsSw1ufS7k6abqdcHZZQzgZgSf4r3K2UtXdJ4KaBhxmdZv2Ill4Ce
         AW+g==
X-Forwarded-Encrypted: i=1; AJvYcCWZYqDYWkdvnnBIDu4EytTheauJ7Dvjzqzq36Un6eKM8pUdneadeaWn9wwY10OxDqJ/dSIbKbygJTdS9V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVe2lu/DVZiW5aNkv+Jf4G66bkDBndH9CZL9m2wLOkmlPZa5+J
	JfUFjXQsZob5xXRGtZJ+O/6CbWRa+7Y4hib1Gyor8vm8AbIq+L/p9YGmU/qjy/g=
X-Gm-Gg: ASbGncsKTqOHhF1rd2BZd6qxqAfTha6MGTVOdKhSS6jyAxNvqYLeVAdjacOgj9aawAV
	7Ct8fSWcgpJLKUfRhS+2QUJeZONBlh2+igktkpAzpJhYAJvmuDGksepkPr2esLf7kY19SU7f8F2
	1Cs+DhiCUalhfV1zdY6QqA+qWYYawm08IEm6/dZhPPZvwBvqviz9VhlJqhwE3zXk+Xyl6K/n2eI
	+JCVN2F83VNPyhGhgTNZaDD1btNdWfo5IS6h2u/B8TpU3qrOFnib/mqP/zoQoZC8Uc8mHyH9di6
	ZtaWCpnTmHTWZ86HLAE2
X-Google-Smtp-Source: AGHT+IFoJJFPtLBuSMIqJyGFIVwrCuTOeFzAqiPp8piO0gnCMrA5ajUljudZL/pGS/GtLks+6yCgNQ==
X-Received: by 2002:a17:906:2189:b0:aa5:391e:cadf with SMTP id a640c23a62f3a-aa58103cca7mr869419266b.42.1732904258959;
        Fri, 29 Nov 2024 10:17:38 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e64dcsm197279866b.95.2024.11.29.10.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:17:38 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 29 Nov 2024 19:18:12 +0100
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 08/10] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Z0oFZGM72FDQX55N@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <c48e6b9b178cdaa01b92ae82e8fd24c2ba5f170c.1732444746.git.andrea.porta@suse.com>
 <2024112535-viper-uncivil-3054@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024112535-viper-uncivil-3054@gregkh>

Hi Greg,

On 14:46 Mon 25 Nov     , Greg Kroah-Hartman wrote:
> On Sun, Nov 24, 2024 at 11:51:45AM +0100, Andrea della Porta wrote:
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2611,6 +2611,9 @@
> >  #define PCI_VENDOR_ID_TEKRAM		0x1de1
> >  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
> >  
> > +#define PCI_VENDOR_ID_RPI		0x1de4
> > +#define PCI_DEVICE_ID_RPI_RP1_C0	0x0001
> 
> As you only use these in one file, please read the top of this file for
> why this isn't needed here, but rather should be back in that one
> driver.

The reason I've defined them in pci_ids.h is due to the fact that they are
indeed used both by the driver (drivers/misc/rp1/rp1_pci.c) and in 
drivers/pci/quirks.c.

Many thanks,
Andrea 

> 
> thanks,
> 
> greg k-h

