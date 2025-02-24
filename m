Return-Path: <linux-kernel+bounces-530033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C71A42DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B5517681B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DD324397F;
	Mon, 24 Feb 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV1Cbumd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676F18CBEC;
	Mon, 24 Feb 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429259; cv=none; b=lrihbVxceCo6FohxqGtA70o4akyWAZPHPOS4ODj99fOiPA3wK4eXMWASTIVekBEzKy3ku7rkBysHdy/JO5jRAWilVtCz6dI7Jmz8lq2tQ4ofomCv8A27fzGxcy8IQ2AiisCZZcs/H19qh70o21MMBV3tbScySgY2rKCUZDyYOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429259; c=relaxed/simple;
	bh=Dz1zijiLC2wKcMtXQyblBiBq7f6O6T+gxysG03w1iWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs8nuDDhpeGTUUrzehhUHDgORUGlhieYF/v6EQi4q163uZhNtFUnu58ltXLwoaaE864LqjPU+hUhNAICh3t+38FVOFBr/nTDhp+gJTqfRKzGJhmBy1/fnLs3eumIDI3PlKOhk2iRDXZ2oppWh2YqMtJhB2uc28e3EoroG4mGT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV1Cbumd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71810C4CED6;
	Mon, 24 Feb 2025 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429258;
	bh=Dz1zijiLC2wKcMtXQyblBiBq7f6O6T+gxysG03w1iWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RV1Cbumd8WV24tBKgQ5qqJ8TiYzFAliX+O20CmNduxhAJakvOuDpScQfCFfPnLE75
	 0NsM+C90r2KyfKW8KyHOR/Xc7FgYWgYw9QMYRVsmh3DMZL05qWmYqMp7FcX9GY/xPu
	 +cbykTKspAKorz8aB4Y4zyF04hyVn6sQSw+LHFnk1UVYTtMJKkm1+pFbI1fVP6JKLN
	 iTDk0LUgEFxBXZVXdocEYsQEhM8ZmHkZ3+M/VT87q6hzEeJK4eZmyFP4ZEY4psp90t
	 SnMkZTXbOWYdQiI8IO4W7sYK1DcpamtMcu2eguZsEKzdWdVHvqASvuJTIltEEAx0Yj
	 nYUhMzZxfrPOw==
Date: Mon, 24 Feb 2025 14:34:16 -0600
From: Rob Herring <robh@kernel.org>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, Liu Ying <victor.liu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/14] dt-bindings: vendor-prefixes: add GOcontroll
Message-ID: <20250224203416.GA4048823-robh@kernel.org>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
 <20250224-initial_display-v1-4-5ccbbf613543@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-initial_display-v1-4-5ccbbf613543@gocontroll.com>

On Mon, Feb 24, 2025 at 02:50:54PM +0100, Maud Spierings wrote:
> GOcontroll produces embedded linux systems and IO modules to use in
> these sytems, add its a prefix.

s/sytems/systems/
s/ a / /


> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

