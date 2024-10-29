Return-Path: <linux-kernel+bounces-386376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C699B42A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF43B21E56
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515EA201278;
	Tue, 29 Oct 2024 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti9VOJxP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A7200CA4;
	Tue, 29 Oct 2024 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730185041; cv=none; b=R450S2+enO2q+k7vpZXlpHRb8aZ9Vb8u6PyMM++ZTubI8vcFjAGJc/0pJhVmdfh6Gpb1UoyBsF7S6jnjXPeLBkaCf65MUbgXLYVPxJamILYGhHGlIq1WUT5YUyHsvbNZY6Cp9RZAplpaHJn+ucPgeLZtW+mcsId7Nf6dECtMFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730185041; c=relaxed/simple;
	bh=+Q/V6WXCYROq0Q1G3AsK/wbeGU4RqG8R0bxG0WnUNVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUwhRObi4qUkxgeKAXCsg++qTcWOgav1cK+a1FPRLdYPEHrHg5g2o5IvXlPwAcybVsgKzqi/CXOMPXGSoPowjK4izbBhM/ndPIfZwuUrohdIOzxNdBKcoN8AixsaS0jZmlfco9ymhwZUo6Hep9/lMAuPAPeAZpsNlA8VQY3MXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti9VOJxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E29BC4CECD;
	Tue, 29 Oct 2024 06:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730185041;
	bh=+Q/V6WXCYROq0Q1G3AsK/wbeGU4RqG8R0bxG0WnUNVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ti9VOJxPFctnUTwirh+ch80KIKFIDoNfh2n0AhSXnf6ixc0zkDDvoWm+kv/xwDOSt
	 VgNUyPQd+2sUJJy6CI7FGqpVU6FQa+4APolRk0lLqlt1Yl42PlpqwabdNb9yAZUKSv
	 VrJUBIaH5Kv0AqZPkkQez731q1605KNwT0+n5fP7aDOhCsjYInGC1YJkghzP4VB3ig
	 IZOSe9X9rqR9aAJAcVdhfjrhZz7a1v3+lW6bOttDpPhA1lfccbxzIqkeMYDUlUPWi9
	 2zB48+HoHB7vMho6R3ViOjt/IE65XK4Ej/SkDYGu/WReJLUKTDYHjOXAp7Iyk6EmR2
	 A0hrjklGdsG6g==
Date: Tue, 29 Oct 2024 07:57:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	vkoul@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	mripard@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v18 3/8] dt-bindings: display: bridge: Add Cadence
 MHDP8501
Message-ID: <c664wq5wzzvivvkpedkicz6ku55epoa75oyycm3hohoms46yi5@myn542dqlpmu>
References: <cover.1730172244.git.Sandor.yu@nxp.com>
 <e11ba0cf836d6f27935f58b7987e792026ab0233.1730172244.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e11ba0cf836d6f27935f58b7987e792026ab0233.1730172244.git.Sandor.yu@nxp.com>

On Tue, Oct 29, 2024 at 02:02:11PM +0800, Sandor Yu wrote:
> +  interrupts:
> +    items:
> +      - description: Hotplug cable plugin.
> +      - description: Hotplug cable plugout.
> +
> +  interrupt-names:
> +    items:
> +      - const: plug_in
> +      - const: plug_out
> +
> +  data-lanes:
> +    $ref: /schemas/media/video-interfaces.yaml#/properties/data-lanes
> +    minItems: 4
> +    maxItems: 4
> +    description: Lane reordering for HDMI or DisplayPort interface.

Please look how existing bindings do it. data-lanes is a property of
port. Otherwise why would you like this to be applied to the input?

Best regards,
Krzysztof


