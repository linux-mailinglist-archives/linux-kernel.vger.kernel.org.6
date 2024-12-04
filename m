Return-Path: <linux-kernel+bounces-430732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CC9E34CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4312B168CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC951922DC;
	Wed,  4 Dec 2024 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg46Bgf9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED9188012;
	Wed,  4 Dec 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298852; cv=none; b=Jt7Rqg5qmI4ZqKpbLZgGyxaVzlXSXtrHMI2v+BEic2lKwCrrOIeh6wuJn6dK8iedyTfyPjGuWfO8ODxHkkRjFsDjEefWAZ7HQ3PuwWWdSukZT2t1tTBj3TVT1v6+UtRNLnaHV/mu+NDU78X7td6fkqeb1zvM5B5lk2/6KY0t14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298852; c=relaxed/simple;
	bh=r7spAKgJ9nwULUJ94kYk71uQKUoe4HtwLYlFt5AYFJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6OYhAVcTLU2pPvSQ0SlWwc5TywjALJC1w816w0AR/9Du+u8hnqFKAC8M8AHhzeh276ENPQgZwDyGMZk3njuUSOAb7NHaUr/ZhhzusXjg3AA8qhxac+xao7h3PMqslDNX0YwpJ21+SDbWdax8v/K8WHet6BQ80DFm9V8Lc2s5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg46Bgf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EA3C4CED1;
	Wed,  4 Dec 2024 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733298852;
	bh=r7spAKgJ9nwULUJ94kYk71uQKUoe4HtwLYlFt5AYFJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dg46Bgf9jwMe6I1uCUp3Lsqtqf6L/k+MOBRHQoLdYmuzUIj0YUPcWbX0FtmUbIOMh
	 /+dpPtOR1Mg9DF47VITfak8t3HqsepZ8N0gAtcWbT/6pxjIAqvvjniAX1LLVgw7bAv
	 V31ZZPZO5JGoHe70R9EUujt8ApeIxGQSN2FHtuLpDeFwBHMvZt7nUB4zPOdfIl+35Y
	 shSaxILOJRNytxvk+PlaGNVVI6LhNiGKKuEe1HsxGlNunsHDkFmJ/hO3htzzthOhGs
	 WoTh7KGN6Wdvj/s576JgluvmyghHZTCHILiPJucuZ5Ury76Jttc74A+mCtU4XIUUMJ
	 t5DVVQuNwx9MQ==
Date: Wed, 4 Dec 2024 08:54:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrej Picej <andrej.picej@norik.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, marex@denx.de, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
Subject: Re: [PATCH v3 1/3] dt-bindings: drm/bridge: ti-sn65dsi83: Add
 properties for ti,lvds-vod-swing
Message-ID: <vgg3bygtmj6sotatddkqfapset5bofsqvkzuj7ejuvomn6hs3n@mscq2jbhtaux>
References: <20241203110054.2506123-1-andrej.picej@norik.com>
 <20241203110054.2506123-2-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203110054.2506123-2-andrej.picej@norik.com>

On Tue, Dec 03, 2024 at 12:00:52PM +0100, Andrej Picej wrote:
> Add properties which can be used to specify LVDS differential output
> voltage. Since this also depends on near-end signal termination also
> include property which sets this. LVDS differential output voltage is
> specified with an array (min, max), which should match the one from
> connected device.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
> Changes in v3:
> - no change


One version of patchset per 24h.

> Changes in v2:
> - move LVDS port schema to a $defs and reference it from there
> - properties are now defined in microvolts/ohms
> - use 1 property for data-lane and 1 for clock-lane LVDS voltage swing
> - add 1 property which sets LVDS near-end termination
> - since major change was done change the authorship to myself
> ---
>  .../bindings/display/bridge/ti,sn65dsi83.yaml | 36 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 3 deletions(-)

...

>  allOf:
>    - if:
>        properties:
> @@ -120,7 +150,7 @@ allOf:
>            properties:
>              port@1: false
>  
> -additionalProperties: false
> +additionalProperties: true

This cannot be true. Not explained in commit msg and this is not shared
schema.

>  
>  examples:
>    - |
> -- 
> 2.34.1
> 

