Return-Path: <linux-kernel+bounces-290414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3095537D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0381F21C18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E6145B1D;
	Fri, 16 Aug 2024 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5tVgNn/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ABA80034;
	Fri, 16 Aug 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723848349; cv=none; b=pEgH1p9RbPiX/vzJgggGuZGd/mn1RUJKHJsDjDXBXWFGgnzqZozbXxdf+wH707Ejuc+VdB81aTqAH4SqMoKqVall3L6Rg2eKRnmyG8l9QpcuqREyyK9NU7MtpqQ7mAFwnarqm9eCTlqQj6expdGaKRhteHxNUV6RADJua3oPb6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723848349; c=relaxed/simple;
	bh=iDrX16u0LelpRPgCqYpDAtw45aROAMIdsf3ytPkWCjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrmOpjqEBHMc/QBO0n+Drr7KvMZxEgYvAxcRT+FXW6adhKbHk5XMI1P8XI3gbuSymwFuxUQRv98jUub8jrWkCYPF8WQYIRqzs+41c0kHVfHbtoLFTOiExMNQh6K1mZfLDQd4dnX0QT0TAQGmcOuQ7/QNyiJSkAa0b0hPQvQkHe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5tVgNn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB398C32782;
	Fri, 16 Aug 2024 22:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723848348;
	bh=iDrX16u0LelpRPgCqYpDAtw45aROAMIdsf3ytPkWCjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5tVgNn/hemXq7NvKi/HfI7Sshqi9puD6hK31NaE2j+J4KFAcHQAcbwtsG7pmxRaC
	 qWP2roWS/1RyUFsylYf65vDG9x99ofiOV9Ft+hbMWsZX4fekuhmqmTZMac6OYhZJ1A
	 KGxx/8c48If8JFyYSNr68wjiKGA2ccEmU6hVo9Fl0gfm+uTytX9Iv/N+5B0UxI5Ina
	 x9PpLFFhdzto6KhWyvfzKEXyNcho+db74mdhsvSU2RySSLPFpuO8Sn2tTqVqASXSzR
	 fxLMJwMFbgmUzBmcHCZYdBsGmPW2vrxlIwE1DcH6MWDk29BJAAa92Wa8/yFoXycf7T
	 cnN17B1cQYU4w==
Date: Fri, 16 Aug 2024 16:45:48 -0600
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
Subject: Re: [PATCH v3 02/19] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller blit engine
Message-ID: <20240816224548.GF2394350-robh@kernel.org>
References: <20240724092950.752536-1-victor.liu@nxp.com>
 <20240724092950.752536-3-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724092950.752536-3-victor.liu@nxp.com>

On Wed, Jul 24, 2024 at 05:29:33PM +0800, Liu Ying wrote:
> i.MX8qxp Display Controller contains a blit engine for raster graphics.
> It may read up to 3 source images from memory and computes one destination
> image from it, which is written back to memory.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3:
> * New patch. (Rob)
> 
>  .../imx/fsl,imx8qxp-dc-blit-engine.yaml       | 204 ++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

