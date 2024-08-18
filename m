Return-Path: <linux-kernel+bounces-291074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A14F955CF5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F582281DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B9912C52E;
	Sun, 18 Aug 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq7IggzJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED441760;
	Sun, 18 Aug 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723991044; cv=none; b=HE2PU27/u0RDOx9JcpcPBi1nnFA/f29F37IxWlPEMrYoivEDfpCEVm9LCTCQilkk3SP0UZJfPX7RomJAhZVIO6tNGn8U7zvpqC9gquYxmyVWMzyozHZHkH88fqF8eyQ7WecGnr1e+nEHn5ICTBy1PgZXgRkax6ChKG9cGnR65NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723991044; c=relaxed/simple;
	bh=p3xChge9ucTtWR9EXLrqY/hgcj62+4knZXEk2TA3eQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCZafa06Ay+QhdB4lPyReuSTHA/BvkTvrKye+2oRPkdflvrSSJooEvum4olZfRK6gzyIbLCvGEMUzAaEItOFSuW/HHl0tSJ34cBb1NOv/NqfmSO/b8uedBv3oJ/k24BLGt+4c+4Rnb9bBdrzBPSDAPxwuIGmqXMvQBvRcR6MNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq7IggzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE5CC32786;
	Sun, 18 Aug 2024 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723991044;
	bh=p3xChge9ucTtWR9EXLrqY/hgcj62+4knZXEk2TA3eQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xq7IggzJZvSFhjmkhMAzVG4GSJYhuSulvTLRuDNrGl34WSAtAJG7Csa/WXtnTTOSq
	 j12xW3EkfpjsteJm+igFb/YjxL6dWJA3/b3E7Y67Hat14V+YPKBGzYoHo1QaAtsbiZ
	 ip6IIQwmlEYULQmKEPJipIET54djlSTzVySuYQlXP6c7VGwSvfyoo23x40ZNcAckJz
	 pClhBJfTM2CMxEH13Xm2lALBccoY/NdzbJOgXnxL3/36o63I6B2sHXZJE+aw77prR/
	 CMe/dKyvV6ZgGENkEvp+/3bKUtLvY1Cjd+WL9wctN44T7OiKf/NVzQ+9H4eOlWU4st
	 zoqNPLiDa/Hqw==
Date: Sun, 18 Aug 2024 08:24:02 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: aisheng.dong@nxp.com, linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	kishon@kernel.org, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, p.zabel@pengutronix.de,
	tzimmermann@suse.de, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev, festevam@gmail.com,
	airlied@gmail.com, francesco@dolcini.it, kernel@pengutronix.de,
	conor+dt@kernel.org, s.hauer@pengutronix.de, agx@sigxcpu.org,
	shawnguo@kernel.org, frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
	dri-devel@lists.freedesktop.org, vkoul@kernel.org,
	mripard@kernel.org
Subject: Re: [PATCH v3 08/19] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller
Message-ID: <172399104139.23572.10090663935384596561.robh@kernel.org>
References: <20240724092950.752536-1-victor.liu@nxp.com>
 <20240724092950.752536-9-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724092950.752536-9-victor.liu@nxp.com>


On Wed, 24 Jul 2024 17:29:39 +0800, Liu Ying wrote:
> i.MX8qxp Display Controller(DC) is comprised of three main components that
> include a blit engine for 2D graphics accelerations, display controller for
> display output processing, as well as a command sequencer.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3:
> * No change.
> 
> v2:
> * Drop fsl,dc-*-id DT properties from example. (Krzysztof)
> * Use generic pmu pattern property. (Krzysztof)
> 
>  .../bindings/display/imx/fsl,imx8qxp-dc.yaml  | 236 ++++++++++++++++++
>  1 file changed, 236 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


