Return-Path: <linux-kernel+bounces-526787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0FFA40348
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26367A4B54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D83204C0E;
	Fri, 21 Feb 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgvJqDQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B61E282D;
	Fri, 21 Feb 2025 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179079; cv=none; b=KcbvgwPBVwpBbPZt2/wzNOADQ8JIqcPT1g4NYRzZpBMgV7KMCzgCbK5NzplDC1+9nre1GFOr3ZY87GFSfgMBE33k2BdqDv1wU9CxgfzUydDaGd1a6VkQCjcFPJ/2/+rWOOzfQ4KLlCV3+z9TvoAFX8zUujW/5iwX7f94OhMo+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179079; c=relaxed/simple;
	bh=TD01oMs/cT4X0Fy2SpIRvb3nsE0dn+rUszo1Uxi/EQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwQV/SFSOcbahcWIdW45pXgzakjjmHv1qP0s+3IhOUQLaS7iYW2AkqeS15lbtdeC1+JokwT3A76JG3HtbqF6yOKCR464yGpQQYuJ1n/JhfxkChZ3RxlHIerTcc1vYmOF+Klk4+Xt7rNGDf6EoBInpTGh3a8Dsc8guWDqB1xxojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgvJqDQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F20C4CED6;
	Fri, 21 Feb 2025 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179079;
	bh=TD01oMs/cT4X0Fy2SpIRvb3nsE0dn+rUszo1Uxi/EQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tgvJqDQdtUNY39WPOqVS0RcbLiV6KR6BcEFsD26sDIRauIw7lst3emjdm7zbEwCY6
	 n4xAfwbp/icn7AafbN1reijfR+ChYIQh3r3QzKKEaDqlN2ypBeRkWq8guD8YVAN9ZN
	 t1IoLIqNAjSv4PPZpO4dy11dFfjku+Bs76eBWlunAVpjZkBStElkKlu/oRc7qX+Mi2
	 FrEbRtbn5f0kQzLVDFyExrinB1rKTbbr/Y3jwE9yU6AxX+63LGhBLy7psl/UP4PZyZ
	 6ooYaar6fKyRn7oYwb5w7kqkpucekupVCgrqVG8IcQjYvW1pvousLuZoc5/fBtwwVc
	 /M5VE/EtMmlaQ==
Date: Fri, 21 Feb 2025 17:04:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>, devicetree@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Jonas Karlman <jonas@kwiboo.se>, Robert Foss <rfoss@kernel.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindigs: display: extend the LVDS codec with
 Triple 10-BIT LVDS Transmitter
Message-ID: <174017907686.233693.6584851812411863603.robh@kernel.org>
References: <20250220094456.32818-1-clamor95@gmail.com>
 <20250220094456.32818-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220094456.32818-2-clamor95@gmail.com>


On Thu, 20 Feb 2025 11:44:54 +0200, Svyatoslav Ryhel wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> LVDS transmitter used in the Microsoft Surface RT.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


