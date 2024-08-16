Return-Path: <linux-kernel+bounces-290408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F38095536D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049ED1F219DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9AB145FED;
	Fri, 16 Aug 2024 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drt0e7SJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAABBBA33;
	Fri, 16 Aug 2024 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847998; cv=none; b=id7ALX6Gd5I+EWzA2m5jYX2RdVPkKSArYDeHfrZNjBUoSJGE629bPXxP+h4hGpiIDRcuPXVmRP8120AgzQEwLXFFnslScOiKmAjO9qkZxr1l0Ta3IVy1AkbYGOTRyr3SytN+pRdtBlAQ2qLbuqQYuyffpLq5lgeGuY4vHYGHxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847998; c=relaxed/simple;
	bh=yLgBm9EHFdqhhjPZ0xAEPGSJiVwgSWNa0lcI/kftets=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkiNMF6d+Ed9w1gJZSJczCB+DIRXJWxcJednVnp+G4CG9fSF67TmhrIRULHyppe5sDi3sVXqqNInJHdcFeFLOvX6w/MXyCk6s1SIjUcrEM6Gu/C3kiw3SegqmuAqaTx0uggAA4ui9O7FuWRhxTMs35VIR+AhZsiGk5TNkZYa+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drt0e7SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC1C32782;
	Fri, 16 Aug 2024 22:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723847998;
	bh=yLgBm9EHFdqhhjPZ0xAEPGSJiVwgSWNa0lcI/kftets=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drt0e7SJlXPXlA5dgoJrHp/EE6nyWURgh3JHxpgb3xvT7uRmoe2zziG2njkn2Obcx
	 P1jWxlq/Z/NbE8rNjwIzmworTxqMWk48ZFT2EZ9FF5vmAirX8Tg1MFUfV6e2FcFyHD
	 FbIWKcl6cdSSz5kwxbrFjJadhLYGvZKCCU5bZ4faHRp02Tz9oFKNkzE/a9XQBC1NVo
	 NqUNd6WOu4KaDu0bHzQU1/cha920gSrChM+k9GHvgP3DLqd8kWXFROosgadTWRLD+d
	 oCRLWdN5t3dGxJprHRVdgtAY6DIOEIg4LLPE5FJLBKMqZNtZjLpyQZ5NCrkGgwFlJM
	 Tz+YKhKeAsiHg==
Date: Fri, 16 Aug 2024 16:39:57 -0600
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
Subject: Re: [PATCH v3 04/19] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller pixel engine
Message-ID: <20240816223957.GC2394350-robh@kernel.org>
References: <20240724092950.752536-1-victor.liu@nxp.com>
 <20240724092950.752536-5-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724092950.752536-5-victor.liu@nxp.com>

On Wed, Jul 24, 2024 at 05:29:35PM +0800, Liu Ying wrote:
> i.MX8qxp Display Controller pixel engine consists of all processing units
> that operate in the AXI bus clock domain.  Command sequencer and interrupt
> controller of the Display Controller work with AXI bus clock, but they are
> not in pixel engine.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3:
> * No change.
> 
> v2:
> * Drop fsl,dc-*-id DT properties from example. (Krzysztof)
> * Fix register range sizes in example.
> 
>  .../imx/fsl,imx8qxp-dc-pixel-engine.yaml      | 250 ++++++++++++++++++
>  1 file changed, 250 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

