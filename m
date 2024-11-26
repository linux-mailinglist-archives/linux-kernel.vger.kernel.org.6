Return-Path: <linux-kernel+bounces-421927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9029D920A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDFA284459
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047218A943;
	Tue, 26 Nov 2024 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB1i18XR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9117BB6;
	Tue, 26 Nov 2024 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604497; cv=none; b=sEPXS5O+iTYDNLtfWAPnNMn/zmcioNlQKLw38XBReykC8EZl6xazgxTYPXKjnYG1M/Xbcz/H/D0YLk6Sn1AtYwljgcMqYj5dyhR6quoi97UajaG1VPTqh5hMG//3jpsYUxcBzWCBY8QN8lHeM8ARafNYJ0bpHYNnE3n7Me0gXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604497; c=relaxed/simple;
	bh=pnZXHU+pm2FOHMliUsr0+YCgaJf05DWVG2lDNbNCuig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkIaoz8mGweWrNMOZAwJbf4/gOVKD34Vi/QPHcJFa63D5bf6kTEmWC/zk91mD/0gNakQ+/5MicbCHFvOT9Qb7oYJ6PUiPH+KgHqfpZBURzpG8VCCjzQ1WKoSv6StWzcA3AFzM+tvox4sFsvzqqh9yyFbMZXYFHxvBYxbU4bJOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB1i18XR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00088C4CECF;
	Tue, 26 Nov 2024 07:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732604496;
	bh=pnZXHU+pm2FOHMliUsr0+YCgaJf05DWVG2lDNbNCuig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cB1i18XR6w6irbGEd1ZTKwH7OIigDPHYg8Kq7GONOGgjSvHx9ED5Uy5IZAIVXiewU
	 iT/FmiBEtqg27QvoY4/voafulDNNa8hgpMeram6kKnl8Lgzzn73f7ifqI3rWv6Qolc
	 r77J9ny+nyejUCgpl54W+wInTm2eFv52l2qPXRXLytmXeq2F2cBp6xP0+VdQeZ+0TF
	 NV3ms8WC66GumGf9xreRBkZrL2++LEctZTHQeRtj9KQX6S5fjLLeRAgypIRbJ07VE0
	 j8Gzqk3LJXCV1ue+0StVHe5JtQ3U7guTatPqjINO7GlQ1Qr5rzBCZdqAmEzuBpfNyX
	 2m+H9dmOlgNAA==
Date: Tue, 26 Nov 2024 08:01:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, p.zabel@pengutronix.de, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, glx@linutronix.de, vkoul@kernel.org, kishon@kernel.org, 
	aisheng.dong@nxp.com, agx@sigxcpu.org, francesco@dolcini.it, frank.li@nxp.com, 
	dmitry.baryshkov@linaro.org
Subject: Re: [DO NOT MERGE PATCH v4 15/19] dt-bindings: firmware: imx: Add
 SCU controlled display pixel link nodes
Message-ID: <6rijytubyumhgvhlvzx3dtyfncknizs3iz7arhno2mjottyu33@subihom7khzl>
References: <20241125093316.2357162-1-victor.liu@nxp.com>
 <20241125093316.2357162-16-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241125093316.2357162-16-victor.liu@nxp.com>

On Mon, Nov 25, 2024 at 05:33:12PM +0800, Liu Ying wrote:
> Document SCU controlled display pixel link child nodes.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v4:
> * No change.
> 
> v3:
> * No change.
> 
> v2:
> * New patch as needed by display controller subsystem device tree.

DO NOT MERGE means also do not review?

Your cover letter does not explain what you want here, except not
merging. Why posting things which should not be merged, without context?

I'll ignore this patch for now.

Best regards,
Krzysztof


