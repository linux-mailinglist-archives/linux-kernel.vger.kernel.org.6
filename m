Return-Path: <linux-kernel+bounces-414563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45BB9D2A01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A14928284E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126EC1CFEBF;
	Tue, 19 Nov 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNQFR1U4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470B1D0786;
	Tue, 19 Nov 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030879; cv=none; b=jiVJW5EJFWtVecRY9LizcT1Oh1PC4Mbu7JP3p6fxvyEK4tGy4BN3j+ZKgrIr4Flgjlj3hR95mF0PjxQhMMX70SWDWkTlfsbovTcdxxuf5I5Q+KaiTFeLwZNY4Ii281ITBXdrSf9sGoDR/WKlwSojiOTGYtlH4WM8L3yrHXn3MLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030879; c=relaxed/simple;
	bh=LCJa+mqJlcqayphq5IXmD48HWyCdMQp5/f0kZG0ciBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH+ix49UZUlA0lnnu+zSylSfz9guEfpFtHiKgswH5QS2Qkp5n3YzWlmrmS8A3rbAUDMp9PD0O49oqqeYNOa2ndzA1KQjS3lDLUjPNXlcwYiccqHYgseVuxR3nPurZOdmcZtZ/e2XV1Pm/y+fW+g1cTdOXGl1IVunV67aashmdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNQFR1U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55EDC4CECF;
	Tue, 19 Nov 2024 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732030878;
	bh=LCJa+mqJlcqayphq5IXmD48HWyCdMQp5/f0kZG0ciBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNQFR1U4KMgjZ/wew/OFuKN7TkKaGv/hTOFLeKBkbWVumG17i0grqn1Pc1Vg0+EdT
	 C0Yb0G5Epe/DohfB199hMCq5PcB7nG0BceGGyH5M9iQw5OtQangn6LiWrWixu1Tcgn
	 YnSacQ3gewWmMJxZ/NMynVKt+BPQWSbB+/whdwXvZWZgHCHeTZkfehw9RciaZVHRZx
	 tHkdEAfZXlZxUt6QJOiSztFYWZohOGftpU+9whc94FL1rY/sUywp2CSzpOGfeLI/sA
	 rPDl3MTfd+1TRmDVM37S9mFgOepfgCsghb4MjRkn9xgmLS0FQ28yv8W9qrZVevts9a
	 ewXo3WWrvJboQ==
Date: Tue, 19 Nov 2024 09:41:17 -0600
From: Rob Herring <robh@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: fw_devlink: Do not use interrupt-parent
 directly
Message-ID: <20241119154117.GA1537069-robh@kernel.org>
References: <20241114195652.3068725-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114195652.3068725-1-samuel.holland@sifive.com>

On Thu, Nov 14, 2024 at 11:56:49AM -0800, Samuel Holland wrote:
> commit 7f00be96f125 ("of: property: Add device link support for
> interrupt-parent, dmas and -gpio(s)") started adding device links for
> the interrupt-parent property. Later, commit f265f06af194 ("of:
> property: Fix fw_devlink handling of interrupts/interrupts-extended")
> added full support for parsing the interrupts and interrupts-extended
> properties, which includes looking up the node of the parent domain.
> This made the handler for the interrupt-parent property redundant.
> 
> In fact, creating device links based solely on interrupt-parent is
> problematic, because it can create spurious cycles. A node may have
> this property without itself being an interrupt controller or consumer.
> For example, this property is often present in the root node or a /soc
> bus node to set the default interrupt parent for child nodes. However,
> it is incorrect for the bus to depend on the interrupt controller, as
> some of the bus's childre may not be interrupt consumers at all or may

typo

> have a different interrupt parent.
> 
> Resolving these spurious dependency cycles can cause an incorrect probe
> order for interrupt controller drivers. This was observed on a RISC-V
> system with both an APLIC and IMSIC under /soc, where interrupt-parent
> in /soc points to the APLIC, and the APLIC msi-parent points to the
> IMSIC. fw_devlink found three dependency cycles and attempted to probe
> the APLIC before the IMSIC. After applying this patch, there were no
> dependency cycles and the probe order was correct.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

I assume this should go to stable? It needs Fixes tags.

Otherwise, the change makes sense to me.

> ---
> 
>  drivers/of/property.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 11b922fde7af..7bd8390f2fba 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1213,7 +1213,6 @@ DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
>  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
>  DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
>  DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
> -DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
>  DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
>  DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
>  DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
> @@ -1359,7 +1358,6 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_mboxes, },
>  	{ .parse_prop = parse_io_channels, },
>  	{ .parse_prop = parse_io_backends, },
> -	{ .parse_prop = parse_interrupt_parent, },
>  	{ .parse_prop = parse_dmas, .optional = true, },
>  	{ .parse_prop = parse_power_domains, },
>  	{ .parse_prop = parse_hwlocks, },
> -- 
> 2.45.1
> 

