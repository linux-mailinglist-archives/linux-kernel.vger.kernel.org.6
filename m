Return-Path: <linux-kernel+bounces-402761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 381A59C2BD4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 11:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD970B22354
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6894515098A;
	Sat,  9 Nov 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+w28rTX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E00233D73;
	Sat,  9 Nov 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731148391; cv=none; b=Qyp6mPuWtwmA2Jz6CNug3qXCo5s3z0VfW3ShbiWxzDmU/Bs0KAjOXJk1KqxUZtO+Y3BWgyLsrOzKacQLH5EjkiuoGWo8EwDJGCLu38y6s10dgzvkvc/rDBBb0/RT00J7BWlh1xCnzp+QczBqpRmFF915gz1i7gfs6gTVXuJnf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731148391; c=relaxed/simple;
	bh=hkIXgjeoP8Tr/1pRsgvqVGJ6QKu0159soEwLNEAlfLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t246pbLqh+aooEYEI3mrFJhmEKGrLgu2JfE4QQhV7kIklbT43KO45rjIC1UnbbYhSj+Wo0M/8VTp2rf84iBGUtvBrzWj6Ivnlb0ZEqrVVqrjh7YF8RjbsfTBx0N7otaCB0M0xGWof9240UCpnKaKY6771/BwKowgGHAvjULDJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+w28rTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E57C4CECE;
	Sat,  9 Nov 2024 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731148391;
	bh=hkIXgjeoP8Tr/1pRsgvqVGJ6QKu0159soEwLNEAlfLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+w28rTX6tKbp/9zGefNzDiTA+j3e2bVIuse2tSFkRmKokILwY58JxyaLIcaIM9ng
	 gC05xzxIrLe/f+8qLjYNy/2/Q/JRpx1TevYiDGFp0yghxkwCUjyWBFmpVj7loZaAL0
	 rnM9ZP1YlouaLp2Y8HkVFDyLl9zmC5Cllf4AL5RKNxxQuOyPvFYcgYbriZrH5UBsP+
	 HrDQVxh+MTuLCGGcBQZNw2DDlmNvBjBYBA0U8avLM4DSAa9cBNcsnJDuAjyigXbd+M
	 h9M9DobqV9DXoBbcYzEg7XBsIMlGeQlGhGv0ZN7/GobUjeYtb40rTjnx002rO8Ea0E
	 H5CK9F98dJ9bQ==
Date: Sat, 9 Nov 2024 11:33:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mithil Bavishi <bavishimithil@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings: display: bridge: lvds-codec: add
 doestek,dtc34lm85am
Message-ID: <3qb4bnrh3ilivzcq6kwbg3vc5rp2mfhi7lnoqe3i77dvvw4dhg@bpy44nrq52nn>
References: <20241108200440.7562-1-bavishimithil@gmail.com>
 <20241108200440.7562-4-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108200440.7562-4-bavishimithil@gmail.com>

On Fri, Nov 08, 2024 at 08:04:32PM +0000, Mithil Bavishi wrote:
> Add compatible strings for the Doestek DTC34LM85AM Flat Panel Display
> Transmitter
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


