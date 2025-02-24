Return-Path: <linux-kernel+bounces-530053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ADEA42E32
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C467A7C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A824FBE8;
	Mon, 24 Feb 2025 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwWbpNhC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9B1FDE0B;
	Mon, 24 Feb 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429872; cv=none; b=UMC3rgdTgVluf8WNPSN7LSVVQFWKnrtO0ONPzVpmlXxxOInuctFsWcCW0FKjKKVfH15oDh4rV/aR4S/MYn4wnS1v2JFnQUkJJCY69d249v3yQORuuUCK89VAxlLloCPS3YTSPeLl8TFYhFzymS3gk42EJD2u2rhurWgTVE8iAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429872; c=relaxed/simple;
	bh=6ZQ2uzFiFhD7gkzk+n7hLxToXvw9f/qLjNwvw3IN058=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTHlSXE3OVKoKUoOeDG3bjCWLmXBbW0LhmsqMB7ldz8A6aTxlmj80JETrMp3sCz8DNHGzVa0nvcGLQRuQ+5YQQ2a1lsm8sepS5sVdozAXdFdXvyjSv0liC7qFScaSYPftDoLltv2HJkTAj0SZa2EgfbgZr+oNXYBb7epeuY96C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwWbpNhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9165DC4CED6;
	Mon, 24 Feb 2025 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429870;
	bh=6ZQ2uzFiFhD7gkzk+n7hLxToXvw9f/qLjNwvw3IN058=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwWbpNhCqwW2+IaFJM8s1EadrnggVS8HGVSkSAatxVKhTW1CDmZCPuIV58P2ejefE
	 9fFCKKpdviw7OhuqtW474AqL9TJoMz+idxN5Dg1PXNJ2HAJs/aJP2T2Com9JjsU/WN
	 ccOvcuOl8SzV1MhWguZaOXc2gHGBy2MZfmB8pjl0yWZLUKRgLpAgoxCgkJBeAPKcV/
	 6Mkkpf0jw2ofTdTGrB+rw6+cpM20zOg8/7qHNCeg+WOYOaTA1nymb9+I6nhpR0oc/f
	 UM9JJvk16LHop1JdTSdslzTFJrIcugsdLECkKsvah8C1ZpSmpEWHx+fpN/InM+TFRx
	 2YaKffluH7H3w==
Date: Mon, 24 Feb 2025 14:44:28 -0600
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
Subject: Re: [PATCH 05/14] dt-bindings: trivial-devices: add GOcontroll
 Moduline IO modules
Message-ID: <20250224204428.GA4050751-robh@kernel.org>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
 <20250224-initial_display-v1-5-5ccbbf613543@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-initial_display-v1-5-5ccbbf613543@gocontroll.com>

On Mon, Feb 24, 2025 at 02:50:55PM +0100, Maud Spierings wrote:
> The main point of the Moduline series of embedded controllers is its
> ecosystem of IO modules, these currently are operated through the spidev
> interface. Ideally there will be a full dedicated driver in the future.
> 
> Add the gocontroll moduline-module-slot device to enable the required
> spidev interface.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 8255bb590c0cc619d15b27dcbfd3aa85389c0a54..24ba810f91b73efdc615c7fb46f771a300926f05 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -107,6 +107,8 @@ properties:
>            - fsl,mpl3115
>              # MPR121: Proximity Capacitive Touch Sensor Controller
>            - fsl,mpr121
> +            # GOcontroll Moduline module slot for spi based IO modules

I couldn't find anything about SPI for GOcontroll Moduline. Can you 
point me to what this hardware looks like. Based on what I did find, 
this seems incomplete and not likely a trivial device.

> +          - gocontroll,moduline-module-slot
>              # Honeywell Humidicon HIH-6130 humidity/temperature sensor
>            - honeywell,hi6130
>              # IBM Common Form Factor Power Supply Versions (all versions)
> 
> -- 
> 2.48.1
> 

