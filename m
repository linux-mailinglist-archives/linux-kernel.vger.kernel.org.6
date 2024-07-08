Return-Path: <linux-kernel+bounces-244665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375B92A793
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E33B212CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC38146A77;
	Mon,  8 Jul 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3d6P2iJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAEB1D69E;
	Mon,  8 Jul 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457260; cv=none; b=pVNtZiaapcFYiJA9UaqJXeaVri/EJjdunapQBXJ8e5MJphgkwqJ2SlwFAaxrdnMB33svWL5hPbBPa6ApV8V4vFOu7NaKc8j2uXhREDHZBJNwwXcSyDaqfJZaoOBtrVyLna04HstRaZnLbGaXVjmjkA4TNN+03TnWr6dtkWmJrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457260; c=relaxed/simple;
	bh=VHvm2D3xsSEmwhh+btt7E0FxJz3widPba7++CMSHLQE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QrLIqczPoV0yEddR527ovQURuKWkOOsUBOseaIQR4QUWONJ7N/Clez7i54eaYwsZ2LPmOCN1qwJ32OxVAVl7GPXD0l3SPf8YIuSLMuxnnmS2Y4Dthb1czxJMlTRvCHIR5QiPoHeeQFZGFE0OwJp1AEXYfZXjtBxUaGSSW5IMZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3d6P2iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C90C116B1;
	Mon,  8 Jul 2024 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720457259;
	bh=VHvm2D3xsSEmwhh+btt7E0FxJz3widPba7++CMSHLQE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=D3d6P2iJU/gosDUr6HODB+GG4Cc7+yOYSEC4NwlKdiNkou68LahgTgitDx/mff8qs
	 IL/Yj7XLzrMrxD4q1APndxB8mAqE7U5aKw1KvCVRyiAZqiQZ2Xd8rhxNcu9Blmmldh
	 scF/wUab8KNLcKuz78/taVhnsPXU8Ngn5nJaw1ZMy1Wqj4rqTEgHxMJb1zs0touTRp
	 CaIW6HQYT62OFvXoTM8QEtbTie7fTxkcxR23mVhaUQLgLKn6RsqyfmhS9zhjUD0SAU
	 P3FQaPx8XqU7/uUeCW++FURI73QKLhuh+x29smXSBrJlfpdQ2Ym1RLvGy5ReoadrAS
	 K6n3UagFqsY8w==
Date: Mon, 08 Jul 2024 10:47:37 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: stefano.radaelli21@gmail.com
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Daniel Vetter <daniel@ffwll.ch>, "Noah J . Rosa" <noahj.rosa@gmail.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240708151857.40538-1-stefano.radaelli21@gmail.com>
References: <20240708151857.40538-1-stefano.radaelli21@gmail.com>
Message-Id: <172045725750.3389992.15451403448241421795.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: display: bridge: ti,sn65dsi83: add
 burst-mode-disabled


On Mon, 08 Jul 2024 17:18:56 +0200, stefano.radaelli21@gmail.com wrote:
> From: Stefano Radaelli <stefano.radaelli21@gmail.com>
> 
> It allows to disable Burst video mode
> 
> Co-developed-by: Noah J. Rosa <noahj.rosa@gmail.com>
> Signed-off-by: Noah J. Rosa <noahj.rosa@gmail.com>
> Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> ---
>  .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml: burst-mode-disabled: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240708151857.40538-1-stefano.radaelli21@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


