Return-Path: <linux-kernel+bounces-259476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5068E9396CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA15281EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22C4CE0F;
	Mon, 22 Jul 2024 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRHIZiUI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD718EB8;
	Mon, 22 Jul 2024 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689589; cv=none; b=QzkoadajtGggymk2KTW0zFJw+8zHeQE6BWacgNyW4YSeYu5FPYUnbHXB1vVgdOOEr35QtxhU8J6FiFhisG8msXq/tdSJgaVmPKBWNeZ0lQSjOgIu3lWsfaGgCQxgTCBVSpRiLtgZ7yWnH/J7CmwiROYRANXRhMfUKkXyO1Wzhpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689589; c=relaxed/simple;
	bh=cC5eyWtTP19+7MNd7JmetoV2H8+x45FW1NUV40fuwgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia/TGFldwnq2bZlutjRZ8SR+vZcMkZKWb1EkCE9eog5MsndXz+/Erp/v2Gle2WnCevDqLPZdkBB2a92X4BPs0IZsSENackB0TrzHtQ6XwwNWUar5eI2ml15k+SsDjECA1O3ji242IUzCYwi7YuO9JvWoNXPykGM3be6c08mQp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRHIZiUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4E2C4AF0A;
	Mon, 22 Jul 2024 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721689589;
	bh=cC5eyWtTP19+7MNd7JmetoV2H8+x45FW1NUV40fuwgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRHIZiUIVpBScGRm9xbLaUYGpJcDXoWRnV0M3ZsGI/g/HEID7Iw1+in0LjpYpLbF+
	 nGdv8aSeztRhfOp/G751tSkgIw60t5W4bIinFFc/sgMXCwvXU+OoEW9B12juQhv9Zz
	 dmR5yNCiPdjOm5Ml6Ec26FHWaKSJqCoNNk8WkWDwA+hBeguGZHPR1BNhHw6oPxE/wF
	 xYHxvLjxGSuvsCPN4mWLY/GX35mBAcfjabgi9wX/jO3eF8USuiPIUrDHg2v5mzKNZy
	 XpLGu0eExUL/St9Jn64YPUYLM7Puiw41FUNNObDuWm0CMGjFEyLrry4+8GC1ibXehL
	 AIhdxpECb2RkA==
Date: Mon, 22 Jul 2024 17:06:23 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: francesco@dolcini.it, aisheng.dong@nxp.com, vkoul@kernel.org,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	airlied@gmail.com, mripard@kernel.org, s.hauer@pengutronix.de,
	frank.li@nxp.com, kishon@kernel.org, agx@sigxcpu.org,
	maarten.lankhorst@linux.intel.com, tglx@linutronix.de,
	devicetree@vger.kernel.org, shawnguo@kernel.org, festevam@gmail.com,
	tzimmermann@suse.de, kernel@pengutronix.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, daniel@ffwll.ch
Subject: Re: [PATCH v2 04/16] dt-bindings: interrupt-controller: Add i.MX8qxp
 Display Controller interrupt controller
Message-ID: <172168958076.231033.5039687741098447913.robh@kernel.org>
References: <20240712093243.2108456-1-victor.liu@nxp.com>
 <20240712093243.2108456-5-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712093243.2108456-5-victor.liu@nxp.com>


On Fri, 12 Jul 2024 17:32:31 +0800, Liu Ying wrote:
> i.MX8qxp Display Controller has a built-in interrupt controller to support
> Enable/Status/Preset/Clear interrupt bit.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2:
> * Drop unneeded "|". (Krzysztof)
> 
>  .../fsl,imx8qxp-dc-intc.yaml                  | 318 ++++++++++++++++++
>  1 file changed, 318 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


