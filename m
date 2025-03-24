Return-Path: <linux-kernel+bounces-574169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F59A6E16D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D284016953E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2526561A;
	Mon, 24 Mar 2025 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jauDl7DA"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD126462D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837664; cv=none; b=iu9ydSYcPQfoNV0leIkg/q1vaWAjRmiPvtky34P7AXQZJE6t0r9zWp9lVAQIB6GJdl0mPkh3iCPhIiZMkhw0B5361bR1/poEaSfwrPgdVnJLJxoKTMie8ixT7vNOk/qMv/ANq8fttUdn9YXdtPIJQxYZQc5f1qcMIk0S9mT0djk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837664; c=relaxed/simple;
	bh=9VD5yRc3tLAiwhVEBXo82ZOS86iUaUZI1Asrk4moJko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5khBR01PUYe+CihamxWrMvu8SD1gaCY9vVVTsVuU34mKlD/eKwNKRXOriiYMJ/emh+ycgbEsQ2E4GlLDkVJYiKLSQwMsU1oAsB5W6S+J7wENJGoOWu8K6QvQOjKrG8bFnALF0QSC1s+97VCUv+ynFB2OUz87H6fZSPbhEk5aq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jauDl7DA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff64550991so6337512a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742837660; x=1743442460; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=83CYsZDlIxjagBMUpXjJLP1JyYGcnqEAQYBsR+/D8Lg=;
        b=jauDl7DA903iMHf6apJ2L7OURIkE3timkN3eaGgGcFlnz+vhePrbWCtTTCnLaGHrxh
         NCtZBUowGzKx2mdDZDPWcvUP29SprxinIZHb727ZzMQOJREO52Xgg43TviMIdwlmjcqU
         +CA04U8f+85g0a1jQ0hayxPckUVK+BLKIkhpVtbJtpH0pcJy3e8zO3LDlEK8Pr8JPbEM
         VFLioNdCP+1afQtg5L9Lu9vD5gDoUaOs/OsvLvQ8zpdjcoXNJbLxXxa5K6+WTCgWmLxT
         sjFHEkG6+a+wjYjNHwhVOMKy9RKVHtx6vP4qu6aI90DqOc2reWvgWX9FaH+4iTyPcewc
         XPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837660; x=1743442460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83CYsZDlIxjagBMUpXjJLP1JyYGcnqEAQYBsR+/D8Lg=;
        b=VOsL9GBidZN9rVRZ8ew8+U5jjLO9Nbktlz3jp63Yg7aXWm5RSE2C5nfvMxqn2iFWYw
         BSGJGzSSnXOeOAtK53uX3JhW5xm24RQzs4tPFfzpZ7Ym4mtj32olJaCLw0g2boXSWddK
         wpoVd7pBbJb1IDOdtQ2WfnrogUu0+H8BWLiNc/95qo9X1zZhy0IaHvO1b4qL8DeQHS/t
         vKPt6ntAm9wv0A/q0Dz5MJd99FjZ1I/NICSykcXTbIQohl6cpovMbEjjBdEp92GLmiXP
         2HyqyNPqen/l4mAHQP2vE6rOKIlZnnbhbWXWrRz1pvVqhukCTlbAs8xLGFl4DZrspuM5
         Uy4w==
X-Forwarded-Encrypted: i=1; AJvYcCUl19vreVCit0qsflejz8D1kbns5EYD5Ov2TlYzgoF+m4kDNKCXgvgHwV0uQs6n3oO0gTyC/8bTWOZ09HY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zzdBojZ/JFmQFvHDNHS19k6WRKYGfyMJLL/t4l5CYIY1hUtu
	WPy8jg9wrM9baZXoTRQjJcr4leZDe62wPTC8YkYVUvH807LvilpiNDWIysAiDA==
X-Gm-Gg: ASbGncsOdwxoko2VH3JCW3iblLgsKADdVtz88mi05l42Ho98NHKJKb+xs+Oz2JxtbYQ
	mDIRE0rZaJFo6RYemD9taVFOaIIeu+3d1IQV5ezAVoZhKpC4bQ26yZWf6M0/vM8zEf9lcM4ClVy
	ZzpxKGozKudE+stEgIi8mvbPB/qtCb6yoTAfezm1hfXFBXyQYQg3Dk8ofBmO7Qx6cmIGhvaeYUt
	KMSXlE8YB+C0Gs4LI+ajCe3JJxHfBy24QWTBDqek3SDFU0VJ9DG50Olhri8nczksGAh4di061oy
	pNjBigoJw7uuD/d8KIkRhuGqyZK9mWqcsuEyc4SZecolZSkBsR/juIs=
X-Google-Smtp-Source: AGHT+IHbIVCssVeg7Lv61Tjada9UpukwFQFdXBab670umPHzvG4MJv+C/Yb75yCUgxbb10I3kj+LVA==
X-Received: by 2002:a17:90b:510d:b0:2ff:4bac:6fba with SMTP id 98e67ed59e1d1-3030fefd847mr23814182a91.24.1742837660393;
        Mon, 24 Mar 2025 10:34:20 -0700 (PDT)
Received: from thinkpad ([120.60.67.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61b525sm12457882a91.35.2025.03.24.10.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:34:19 -0700 (PDT)
Date: Mon, 24 Mar 2025 23:04:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 00/13] PCI: Use device bus range info to cleanup RC
 Host/EP pci_fixup_addr()
Message-ID: <sffiojhyyu5gc7nx4oe6re53r3ti4nbnkworsxzawkus6ovlsh@3auwqhcpdp3c>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>

On Sat, Mar 15, 2025 at 03:15:35PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a v12 based on Frank's v11 series.
> 

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> #SA8775P-RIDE

- Mani

> v11 https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com
>     
> Changes from v11:
>   - Call devm_pci_alloc_host_bridge() early in dw_pcie_host_init(), before
>     any devicetree-related code
>   - Call devm_pci_epc_create() early in dw_pcie_ep_init(), before any
>     devicetree-related code
>   - Consolidate devicetree-related code in dw_pcie_host_get_resources() and
>     dw_pcie_ep_get_resources()
>   - Integrate dw_pcie_cfg0_setup() into dw_pcie_host_get_resources()
>   - Convert dw_pcie_init_parent_bus_offset() to dw_pcie_parent_bus_offset()
>     which returns the offset rather than setting it internally
>   - Split the debug comparison of devicetree info with .cpu_addr_fixup() to
>     separate patch so we can easily revert it later
>   - Drop "cpu_addr_fixup() usage detected" warning since we always warn
>     about something in that case anyway
> 
> Any comments welcome.
> 
> 
> Bjorn Helgaas (3):
>   PCI: dwc: Consolidate devicetree handling in
>     dw_pcie_host_get_resources()
>   PCI: dwc: ep: Call epc_create() early in dw_pcie_ep_init()
>   PCI: dwc: ep: Consolidate devicetree handling in
>     dw_pcie_ep_get_resources()
> 
> Frank Li (10):
>   PCI: dwc: Use resource start as iomap() input in
>     dw_pcie_pme_turn_off()
>   PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
>   PCI: dwc: Call devm_pci_alloc_host_bridge() early in
>     dw_pcie_host_init()
>   PCI: dwc: Add dw_pcie_parent_bus_offset()
>   PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
>   PCI: dwc: Use devicetree 'reg[config]' to derive CPU -> ATU addr
>     offset
>   PCI: dwc: ep: Use devicetree 'reg[addr_space]' to derive CPU -> ATU
>     addr offset
>   PCI: dwc: ep: Ensure proper iteration over outbound map windows
>   PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()
>   PCI: imx6: Remove cpu_addr_fixup()
> 
>  drivers/pci/controller/dwc/pci-imx6.c         | 18 +---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 74 +++++++++++------
>  .../pci/controller/dwc/pcie-designware-host.c | 57 ++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.c  | 82 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  | 24 +++++-
>  5 files changed, 171 insertions(+), 84 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

