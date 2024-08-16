Return-Path: <linux-kernel+bounces-290409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0619955371
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88165283AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324E2145FEE;
	Fri, 16 Aug 2024 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObvEDYP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D268BA33;
	Fri, 16 Aug 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723848053; cv=none; b=rHGboKbmNAMczOoxFhAzb4Of7I9tE3k1mUX4IdZk+pNWIz/zrAwrakuM9a2qsv//APX+yhi7tqSTCnFNaMSZuo8zXAvMJysLSlY/0kmZTn8wlDcHZGnOChx1ozyeBirQ2Stb0R7OmbEnk4O+2y+Zc7mAQ6eOdX5LonV/u4vbCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723848053; c=relaxed/simple;
	bh=35Gggnneu4ZsX1jEkgo7SKcrzozXMNAhO7CG53M/PLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCpe2dmjOO4hjGFbjEVLmvqunUxlH9+NUUAY4+vfh8JlOa9ORFGoxW7bI1uiHnCXpaJ81c0SJbrEO8jXiAglhD27/wfY3w1HHYJKzMfMh+DpJFjg9IxNDzilzZy+P16c5y1NgK/Efq2uART61UXsVR0v5B9kw4qbSMepKd9vqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObvEDYP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25373C32782;
	Fri, 16 Aug 2024 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723848053;
	bh=35Gggnneu4ZsX1jEkgo7SKcrzozXMNAhO7CG53M/PLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObvEDYP4s28qGNh8+dScvtQ3Ge9sCUNL4/VV3ncRwmwDXEIFPv6kzzb90iIrspzSW
	 EejbsO1BKu1KaoXBZbgEtyGcoCJ1T4LRBhsygoJNItdS/T+MbrCPDxJA7JclCOFY1B
	 L16OOTLiroTpWEg/JscLQnGcHTwMy5XaJHqzJZCw7FP3qRdSDh7tysllljZybASaxb
	 3QLOA6dIrUbiWsz4Gi+TPm4S8JXNv/AYFc7Uh8zZBxN5alUkdG06aX5tJdW9BGq7rf
	 LGVXI6/pW3Bn5W7hVb12D2VK712CXwf1HqZ9X1hsgyiFpm9ivGRPMk4Sc/BzEx6Nrb
	 E7Ku3h0izOk7Q==
Date: Fri, 16 Aug 2024 16:40:52 -0600
From: Rob Herring <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org,
	kishon@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org,
	francesco@dolcini.it, frank.li@nxp.com
Subject: Re: [PATCH v3 03/19] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller display engine
Message-ID: <20240816224052.GD2394350-robh@kernel.org>
References: <20240724092950.752536-1-victor.liu@nxp.com>
 <20240724092950.752536-4-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724092950.752536-4-victor.liu@nxp.com>

On Wed, Jul 24, 2024 at 05:29:34PM +0800, Liu Ying wrote:
> i.MX8qxp Display Controller display engine consists of all processing units
> that operate in a display clock domain.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3:
> * No change.
> 
> v2:
> * Drop fsl,dc-*-id DT properties. (Krzysztof)
> * Drop port property. (Krzysztof)
> * Fix register range sizes in example.
> 
>  .../imx/fsl,imx8qxp-dc-display-engine.yaml    | 152 ++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-display-engine.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


