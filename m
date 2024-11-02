Return-Path: <linux-kernel+bounces-393512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5889BA194
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 18:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EE71F2184F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5B19DF4B;
	Sat,  2 Nov 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZetXxDm"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF018A956
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730567364; cv=none; b=GBvp4jD/a2nfHhS4TN+88QyBLfIH4j10+gL4UEvZMc557V4yXsow0xpkoFObthAfjYgIgaaJDt6H35cMnui3+dM2jL3CW26chsH8zrA1bA4jvTpcUx/ACw4RO4vLHaI/09eh23kK6JGUfYWGPspctE3jhgMSYnpeN5M0xkmzhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730567364; c=relaxed/simple;
	bh=Z4ujPaeRMEt6r7M7H1TsEVcv9xtm5hvQruVS6LMJgNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5aOZuyqyEwPr6hr34aVSIApHeg43xHSdYWMrWAmrwqAXIa7W4vN+B7YunBALz7ix5iF0dU0unlD3RDB44Agp34fshYLGEfKsLiInB+uOapyBGSp7XwCbuF5kfzhxBZtLcdOtyqTjNitB+/iRXtx/KfYvyPYHo6wk9Q9hkKOeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HZetXxDm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c77459558so25502435ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730567361; x=1731172161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=niemCpBaWtNTD33HK4hY7EmVvjCf6wQeZoDXMitV7Gw=;
        b=HZetXxDmN8QlshSNxk61fUsiuCnePcI18I10cz+pzFpr+14WVEiM39mazf6BBNEn2h
         Ohk2XXW3EVZWFVBVUoQz3Pfo7SLXp2+pomwWdwL1qj4NJjJC2siL2ZI0CqUfWbLmvN+H
         t2Xy0pfNFas3HqknRQgMVVva1eRgp3ZF6cXplHW8favIvAYICny5tyiHpqvjlmLvXMId
         i/mJFBoZgG5iX0+Ty304/YEGG/bI6o+zR78E2QiDTPiPddGMAjNZrwXdr2V0OkuorvLR
         0G25Z69OIMq6gmkQMSGyuIXjAPrlCnEAoa1u9R4L+R/zs95PB5i92aLURxawFfHyedAd
         QObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730567361; x=1731172161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niemCpBaWtNTD33HK4hY7EmVvjCf6wQeZoDXMitV7Gw=;
        b=sGfwO6kDOumdZsB0xdQwy/BoyJdcTYILPgOg1k5BJIfEouPkyTYj6VkEw3TsOJNEdy
         uPyRp0WErff9ueFCiZbZuOG2HrZcS8k73lfsJTzUibjY/DZBE4d+OalE4gXFiMTP1d6N
         XDgPqX5vIXXbYmZ1I+4aLjkb8oRn3u4jFc7lDU9Iy6L5SIFCxDC0YO8ZjE2DkScHBLu7
         ZrB4EXAy4cHwVpN2WGjisv0aaRHqTlfqXApIZdHUnen4yIoROFUeg5oHoxPC4zrrfU5V
         5ZEvkmRq8sNwXANDDE1ma2NJozNsCDvsXOSinTuSSVxIMr/i096+v0KApkoKS8bgL8vf
         XNng==
X-Forwarded-Encrypted: i=1; AJvYcCXMyatxFA8cD+eGg0UjIR9GbdjY35mdJTDPgfZ7Zyj8exrY0wwEDVffpp9ju2X062dKdTERz/GJS8OMRZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMriHIL4Z58fChzRnvGCumWfF7Z0ldwJpj7KuALbInAaLQ/XRX
	kksVI0XM9SdYC8rKWIMegx1GGHmvXUwmpEBYph/oBqIQr/B+an7wFPnChIVsMQ==
X-Google-Smtp-Source: AGHT+IE57YiawuzlnoPc/P8d7TUPT1NkGH0WXOgqoMFowdmCtN7jxWsbHJCr+a/Z5Z8OOuUwKEUShw==
X-Received: by 2002:a17:902:e810:b0:210:e8b7:58c5 with SMTP id d9443c01a7336-210f76ff16fmr219810025ad.56.1730567361173;
        Sat, 02 Nov 2024 10:09:21 -0700 (PDT)
Received: from thinkpad ([220.158.156.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed8efsm35882265ad.55.2024.11.02.10.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 10:09:20 -0700 (PDT)
Date: Sat, 2 Nov 2024 22:39:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
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
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 05/12] PCI: of_property: Assign PCI instead of CPU bus
 address to dynamic bridge nodes
Message-ID: <20241102170908.fa5n6pz5ldxb66zk@thinkpad>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com>

On Mon, Oct 28, 2024 at 03:07:22PM +0100, Andrea della Porta wrote:
> When populating "ranges" property for a PCI bridge, of_pci_prop_ranges()
> incorrectly use the CPU bus address of the resource. Since this is a PCI-PCI
> bridge, the window should instead be in PCI address space. Call
> pci_bus_address() on the resource in order to obtain the PCI bus
> address.
> 

of_pci_prop_ranges() could be called for PCI devices also (not just PCI
bridges), right?

- Mani

> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/pci/of_property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 5a0b98e69795..886c236e5de6 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -126,7 +126,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>  		if (of_pci_get_addr_flags(&res[j], &flags))
>  			continue;
>  
> -		val64 = res[j].start;
> +		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
>  		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
>  				   false);
>  		if (pci_is_bridge(pdev)) {
> -- 
> 2.35.3
> 

-- 
மணிவண்ணன் சதாசிவம்

