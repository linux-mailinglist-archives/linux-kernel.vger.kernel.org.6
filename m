Return-Path: <linux-kernel+bounces-558515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90960A5E6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330FB3BB045
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEAB1EDA02;
	Wed, 12 Mar 2025 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9WEAZnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F641EE7DD;
	Wed, 12 Mar 2025 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817066; cv=none; b=C+XPfOI9ssfALJDTzro3ikwLuXU62EXbos5VkTc5ok1Sx4TvyCw7vXFmGyceIVcdXhaxqzam5oe1zgPEzZfZ82MrQxX+Y+zRIpWLcAHfu7qxKoSTfXBbBZiFg/JW9q2cB1akTYC+lKplIEwWdGQYTwripmHAFa2WzjRWqh9JePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817066; c=relaxed/simple;
	bh=/sBtyAsM65N4B5RyoYwCJ72E6UZV3xXX6NeGudU3MPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=brFSZRWtZpO7XFXB1sOcO5bmyPJLvAugOh1fnPOm9rwR7opja6CJypMLhOqnKUGJQtvVFt33ZJmVDXNgWxIcFWhWgf7hJfnQBUgOZLGLFhEGEHNPjHcNrMnVobpHGplMmgSg3fa1Wjjq8iOgWG7gWgxje08V6iGlI48qF6OcV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9WEAZnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ED4C4CEDD;
	Wed, 12 Mar 2025 22:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741817066;
	bh=/sBtyAsM65N4B5RyoYwCJ72E6UZV3xXX6NeGudU3MPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K9WEAZnzaYoIKkk7haWh8wYbDaunkAo2lU6vWYI2jXs5qJBRthzTejGsrr1tmvhTQ
	 qgOmjrLQ7v/cmRSnNSSc8gdAUQ6YdSfYjUOaLxemm97fsmuhTNRGTaD/UmRYfyEoN6
	 X9lmowYTggIbZklNSJ4i/IWmRe9P/qx0yWavsWNrs8wIFKrOUTV8fW1teatrfswJcA
	 wNAV4/4NjVGCliEIteWN2FfA3TKNGiZf8gQfe+maLVJ87y9Rl9eG3EP0NOEFFBoPOW
	 aivTXzUaKtUF+jcbum/4ZMtvpaX09/yhnxhqWrixneKblEZD3nNePJzVsQaME/NrVP
	 bqUwPoKcMRRPw==
Date: Wed, 12 Mar 2025 17:04:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v10 08/10] PCI: dwc: Print warning message when
 cpu_addr_fixup() exists
Message-ID: <20250312220424.GA711004@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-pci_fixup_addr-v10-8-409dafc950d1@nxp.com>

On Mon, Mar 10, 2025 at 04:16:46PM -0400, Frank Li wrote:
> If the parent 'ranges' property in DT correctly describes the address
> translation, the cpu_addr_fixup() callback is not needed. Print a warning
> message to inform users to correct their DT files.

> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1125,6 +1125,8 @@ int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
>  
>  	fixup = pci->ops->cpu_addr_fixup;
>  	if (fixup) {
> +		dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n");

I don't think we need this.  The mere presence of .cpu_addr_fixup()
doesn't tell us the DT is broken.  When we have .cpu_addr_fixup(), the
DT is only broken if DT tells us something different than
.cpu_addr_fixup() tells us.  And we already warn about that in the
"reg_addr != fixup_addr" case.

> +
>  		fixup_addr = fixup(pci, cpu_phy_addr);
>  		if (reg_addr == fixup_addr) {
>  			dev_info(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",

This message is really just a hint that DT is fine and
.cpu_addr_fixup() is redundant but harmless.  If you want a dev_warn()
here to encourage people to remove .cpu_addr_fixup(), I'm fine with
that.

Seems like "dev_warn()" would be enough, probably no need for
"dev_warn_once()" since we should only run this once per controller
anyway, so I don't think we'll get spammed with messages.

