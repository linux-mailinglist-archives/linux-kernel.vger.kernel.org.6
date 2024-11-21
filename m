Return-Path: <linux-kernel+bounces-417352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD259D52E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BFD1F2148F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9A1DE3BD;
	Thu, 21 Nov 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X4vKXci1"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE781D0DF7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215185; cv=none; b=VEREvh14LZR/DI6nocPLIuWG/cToxE26flWfRxklvYarEK0pHsSgj8I7HJN4F/O/dKGcukRFH9xyMGMQXPZtPbdI5W8GWSc+ivgucRvP3yAR+RKzcjacC0lwEFIXO03m6RGqv4gvZ290tqUdGKmiVJ2mB/81pRzD2M8eLaeQWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215185; c=relaxed/simple;
	bh=x3cGfoVEihpQ6iJ8upGK+iS4YmQ7ELMjL/MQmp9LIhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFFcR5MDCYyv7srIlhUBn2P3LDBuumqraUKQdVpWUrhjC48UvrmocRRJtLR9p+drrABDAKL6T0cNfhJu23DPtsz4k5w6DxRuTW5gEYBRjplAPbwC5EBOaB9t3BNjRb0KBguBS7Ncj9h3wa3VtvKnh4YQZAP0iWooinKtPRhphOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X4vKXci1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720d5ada03cso1286729b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732215183; x=1732819983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p5Qth7Y59EGcplMI8RH/OJ6a3yjWKA2zdogBK7G3SxU=;
        b=X4vKXci1kd9Ik7G1suw+1Oo6ENBq9Bsxi++oKGuhlO3nxcxYWaC6HrcC/F/jQlrYVi
         d7IMEDreejwK07J7Zp6Fp8AmOP1OK67GgRfaybeS5ullbfbSihGG6X+rRoXzzQraqd4f
         lFcIYhtjWDBkr5JNLs0gvsUF3494wCLp9F24M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215183; x=1732819983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5Qth7Y59EGcplMI8RH/OJ6a3yjWKA2zdogBK7G3SxU=;
        b=MpYSDH+b0/b4IpW1sa7o3CylBZJpU4BRZrqpuLsubXF9cNyozOP4JIdtgi8u2QY816
         6ISp/GhSNm1NzwvsV5vQ2qcAQ0XqY09FRvwO+e/BAyCm43LfW9/9YIIPeLRXlc95u74E
         VDa4qhcv84iwLrPkQ+m9/5lnBrEvKAQ8gVshshwlzmpB/z0tBjaX9SCVkEuLeNyRdSNf
         /gA/0EUc7BvxnqsFPlLCMxc3CdOsLfNgi1SZPZJnwmhgMCx9iKl4iEO4gcinkxcIjRtc
         8RDmvqnV//RBVNqr+7qtj3dH0Mo+vtkobpinEwLhBpJYWH9hBtX7JcyL/2KPH+sZZHMH
         lMkg==
X-Forwarded-Encrypted: i=1; AJvYcCVRnGu3koncBX9Dql9nFWnLX/I+M3eMAwh/9nWKB39kGLnpK1XQg//J1VvPs7myxIa18OBFtj91lKiEtqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfEJj2DY9A5HmcGQ2vNzd9GSbsVcdwQfWsgH1ookHPGO2MuO2w
	bZVS2Y5fEBupD3UBZXe7zrAkb3suuI5d3FoUxRnNaQRsj1yM3zmFHKERwokdwg==
X-Gm-Gg: ASbGnctuPjvUcvtdsKvFbMGnR9a3bNvqvcXY3VOCcSr0pU3l9aUzCQzuWYwK1ExhEfe
	zkveNqDkg6C5kvjDz7dXKkZUI7UuK+lovAzgU3MBpYVaNq5BOsAJAzMCajI0qT5ryV1s2FuytLZ
	e9PiMNjxKjG/VQwyGvFaa+NQz5ivvqiKfS/vLs5k/kXQWIPqPEo1ZU2H70lOMa6u+4b5xIoNnpN
	ExkGHLQAdW0oYMY5d6wME/O22EdErjeRIzQM2ufQEZKoS/sZ43tkBdM+VzEpsIGoG/cwBf4tcl2
	WU/y4t+4AdiD
X-Google-Smtp-Source: AGHT+IEnHqovNtzlCmc+PDaMnUFqqZzrIPq8HhFFCMkNi3Dndp8nmsfdHbOYSzctEa5FweZZz0sEwg==
X-Received: by 2002:a05:6a00:1a87:b0:71e:8023:c718 with SMTP id d2e1a72fcca58-724df5d0d90mr122658b3a.8.1732215183145;
        Thu, 21 Nov 2024 10:53:03 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:6485:23c4:db3b:3c93])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-724dea69e96sm62889b3a.73.2024.11.21.10.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 10:53:02 -0800 (PST)
Date: Thu, 21 Nov 2024 10:53:00 -0800
From: Brian Norris <briannorris@chromium.org>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <Zz-BjF3rZRyfv0Mg@google.com>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>

Hi Manivannan,

Dredging up an old one, but it seems like there was almost consensus on
this patch, and yet it stalled because the series does too much. I'm
interested in reviving it, but I also have some thoughts on the
usability.

On Fri, Aug 02, 2024 at 11:25:03AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Unlike ACPI based platforms, there are no known issues with D3Hot for the
> PCI bridges in the Devicetree based platforms. So let's allow the PCI
> bridges to go to D3Hot during runtime. It should be noted that the bridges
> need to be defined in Devicetree for this to work.

IMO, it's not an amazing idea to key off the presence of a bridge DT
node for this. AFAIK, that's not really required for most other things
(especially if we're not mapping legacy INTx support), and many
platforms I work with do not define a bridge node. But they do use DT,
and I'd like to be able to suspend their bridges.

Personally, I'd choose to match the same requirements as used by
devm_pci_alloc_host_bridge() -> devm_of_pci_bridge_init() -- that the
parent device under which the host bridge is created has an of_node.
Code sample below.

> Currently, D3Cold is not allowed since Vcc supply which is required for
> transitioning the device to D3Cold is not exposed on all Devicetree based
> platforms.
> 
> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/pci.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c7a4f961ec28..bc1e1ca673f1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2992,6 +2992,18 @@ static bool pci_bridge_d3_allowed(struct pci_dev *bridge, pci_power_t state)
>  		if (pci_bridge_d3_force)
>  			return true;
>  
> +		/*
> +		 * Allow D3Hot for all Devicetree based platforms having a
> +		 * separate node for the bridge. We don't allow D3Cold for now
> +		 * since not all platforms are exposing the Vcc supply in
> +		 * Devicetree which is required for transitioning the bridge to
> +		 * D3Cold.
> +		 *
> +		 * NOTE: The bridge is expected to be defined in Devicetree.
> +		 */
> +		if (state == PCI_D3hot && dev_of_node(&bridge->dev))
> +			return true;
> +

For me, a way to lighten the bridge-node restriction is:

	struct pci_host_bridge *host_bridge;

	...
		/*
		 * Allow D3 for all Device Tree based systems. We check
		 * if our host bridge's parent has a Device Tree node.
		 * None of the D3 restrictions that applied to old BIOS
		 * systems are known to apply to DT systems.
		 */
		host_bridge = pci_find_host_bridge(bridge->bus);
		if (dev_of_node(host_bridge->dev.parent))
			return true;

Brian

>  		/* Even the oldest 2010 Thunderbolt controller supports D3. */
>  		if (bridge->is_thunderbolt)
>  			return true;
> @@ -3042,7 +3054,7 @@ bool pci_bridge_d3cold_allowed(struct pci_dev *bridge)
>   *
>   * This function checks if the bridge is allowed to move to D3Hot.
>   * Currently we only allow D3Hot for recent enough PCIe ports on ACPI based
> - * platforms and Thunderbolt.
> + * platforms, Thunderbolt and Devicetree based platforms.
>   */
>  bool pci_bridge_d3hot_allowed(struct pci_dev *bridge)
>  {
> 
> -- 
> 2.25.1
> 
> 

