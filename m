Return-Path: <linux-kernel+bounces-205011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823CF8FF621
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239DA286756
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FFA13AA41;
	Thu,  6 Jun 2024 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Klky7R6T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791316F08E;
	Thu,  6 Jun 2024 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707307; cv=none; b=gJrcgh7OO5T7SOQLRfI485c6iG5VoawhGNP8+nPkOZbe/Qax6eu7ZvznfR92qpeFAgxqonaVrEMhPLgJY5n3R8xbkkHM9a7trrT1JfK0LpifjkcuB/Ff8eeBFY6NeXYlOU9ixhf0FhWYgjULGEBZnmDp+lZ01bKIy8OdCLg7HDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707307; c=relaxed/simple;
	bh=Z8HC3+x9qczXYWa/ofXyj/rI+neSSVhiNEmmwFi1TnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO2/XBCVJ4k33N+DhRQpJiMqeGoSmpyQyrceFpHe1WzBKhyVbd/Nr2DGJ6jzfcaXhkzbMssu8S/xLR+M+TvCRcgzc9vEi6EaY82/WyZjBr5GKsh0odO9AEZltTp1yisRc4u5ewIGx0p0U0KzoRvYSimr6mA0rTbX65Hl+Btko0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Klky7R6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF90C2BD10;
	Thu,  6 Jun 2024 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717707307;
	bh=Z8HC3+x9qczXYWa/ofXyj/rI+neSSVhiNEmmwFi1TnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Klky7R6TvA/SWXm/3TuVDEjMLW3UqxspVLmDYT/2iTA4/7C6i4efRD9ro7cSI/aDp
	 XeJppgwIqMwU8TJKQ8Kq2LqDq2GN3EuRN20lpzB6RyAR/A8XvSucBFfIEg1EhMdHwr
	 T62FuL+zpYjoyYlOH5DUt9oPeZx1qZ11Omx2ajIYWPct9oxVWI64xE3P1GEu39+xqA
	 2eaejkBazyqIckLhLZlvCHR1BdtNQGZyB3b+or6Nt7JI8F0M9MrZPZpivxKEv84vhH
	 3LE4SZlLxMVA9BSQ2dAP8UhR9VRPdorkm13Pnh1EIuuMwRs1yIWkotJ5SjPVOKHNFP
	 fpyJIKqlJiRVw==
Date: Thu, 6 Jun 2024 14:55:04 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-kernel@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	David Wronek <david@mainlining.org>,
	Daniel Vetter <daniel@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] dt-bindings: display: panel: constrain 'reg' in DSI
 panels (part two)
Message-ID: <171770730263.3844490.8634760691751503375.robh@kernel.org>
References: <20240605105659.27433-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605105659.27433-1-krzysztof.kozlowski@linaro.org>


On Wed, 05 Jun 2024 12:56:59 +0200, Krzysztof Kozlowski wrote:
> DSI-attached devices could respond to more than one virtual channel
> number, thus their bindings are supposed to constrain the 'reg' property
> to match hardware.  Add missing 'reg' constrain for DSI-attached display
> panels, based on DTS sources in Linux kernel (assume all devices take
> only one channel number).
> 
> Few bindings missed previous fixup: LG SW43408 and Raydium RM69380.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This should apply on any tree.
> ---
>  .../devicetree/bindings/display/panel/lg,sw43408.yaml        | 4 +++-
>  .../devicetree/bindings/display/panel/raydium,rm69380.yaml   | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 

Applied, thanks!


