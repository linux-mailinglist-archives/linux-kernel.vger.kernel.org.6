Return-Path: <linux-kernel+bounces-527880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850FA410CD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DB918934C5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99816F288;
	Sun, 23 Feb 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHtmnjkZ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080415CD46
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740335137; cv=none; b=Y7lvU4ecNz7n6r9g1Eo1S3eeD9h0Ilo882UXtw/JxS5feDZ8kkb0mD1LHC5A8dEbQMKZY4X/22GxrMdZask5qAn92C798xovDYtPy3+JgezEZ827CaXLBAmufMd5kGVFRVue9Mbd0k5JCZ17MhyY9glw1T20zxHnX54CD9llWKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740335137; c=relaxed/simple;
	bh=IebdohvZSQVB2m0xM8vghThlOlO40yKJD09EDoioSGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/uI2OzdSAUEBKupCaKqCMgWIcfkmipkemAa+Be2qmxn7G/0bZ71MDFR2eNwoMk857VwQQmNoB6WZaRJ825fwuzZhXZmKR2DR5z+R73LY9//aZ4iunUW6NFwvehYLoWiJxT1yA0lZlMUr25ZMwj+1DyEG72J43VGYLjoyYqdo78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHtmnjkZ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a2f240156so36800371fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740335133; x=1740939933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtNMK+QZB8Ju1QcEFH1uDPKTHzJj1OW/FdNy3G2F6jE=;
        b=kHtmnjkZEQEkeKO+kQQ7+rM2m2hLtegoQ0KyhQV89jmpIzFcerpFqBB6op9EdofpjG
         wRmsu4NBF4N1AXrpnjTzv2Fu7o2Kbg+wslGVJXPUrhIoqwl04TxkEXGfFy7UMwiU2zg0
         Z33ON6AjhWVJt4qd8uZZ+Z174Y3l3hMKl9lcE3yrM7hgET/hJ3uWewxcK6KQfJWcpLct
         U/OSdfT9sSLm4aRfd4T8w+JGds8aE0QgV6/jKVIlmk8S5iLI4c2ns0rEhCT8D3D//DWh
         0b+7PEOV5XGffnhKpLXKkrh7ZurRW2SqjFBqfISeuMAgRwX/QbqQ4jhuArK2vmGACvJ8
         rT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740335133; x=1740939933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtNMK+QZB8Ju1QcEFH1uDPKTHzJj1OW/FdNy3G2F6jE=;
        b=h0laxeX2pisH1bazi4IhaVf0v9EaipswJT5BbJ94zgh2QvdSFyIfbce6goPOiXyVpM
         WdO65fZU2J9dNLmVKKkRBx6hIhS+F1X0tGmp9xFBgvajdOWyA839NwcP25xlNu+rXoP2
         pr60xrhdo5v/wAxUCffb9VcBmt5MymbBKR1CaAeIW1qEnQMKYzVCOzYBwSpcgZo/B6zb
         5DEL9Y6YWCecCbDsN3aoHFhhlHvn4uNamZ2QuIxuFe68WeqENOdQEFrGL5YpGl9PMHF0
         Luqy8N6q8g11TkX3emBUHaGZKU+/tM6JDWljb1R+wm93i6XkHOhHmvKk40PklJprh5lE
         8adg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5XnYWw/jOpfotMq47auoocFdLmT4YF2U5d0605rMKo7gLHaHfjPa21b2VHKW1rk1QeWgNI6KUBwIiMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPiJzsrNFDFJUeRyEXZov4ccHPUMwNxOM3Y2o5Zaem/IjViVw
	6Lp+hBpWzOxhcmhMnWpIMHPMIGYKgrc3LGu2A1WLye0Ma/W5+thQ7xEOVVhBGmWiUWW2s9kltXQ
	4
X-Gm-Gg: ASbGncv07p10PIsL72PrwCniuVBJH+tkWYizkFIS7MuBlcoCas2i6LMe5AOCAaDFRHU
	IkXq82GqxPmp24BBCfbi3r2L5AqhEOmQFWOup7XyPXKoXZ8K//0JfokIQCFbAy/9NdhFaOx+jVH
	pL+wRZQwHbID5MTaaLaQXkRVtWjvu7vPiXErnIerdrZyNkqQNUUD7kNwO234zpdzYD857IOljiE
	xQSVaqzpe/4IlDhY5ZW5dRe0DHed8pF7x+mGYjQFhrnmI0a4GRwPX7ZYOMWb0gw2StwR5TnWj78
	MZ8c0H03hRmKrxqJWnkVdIIHycStnGD+j+sJMAtDIqsEFQv/kIoYqvGIwIIB1W4goNqla0MISH4
	63AgPtQ==
X-Google-Smtp-Source: AGHT+IGKB1vocXj8KVqyAz4vvD7IpDGljmlluQ7IMEzMaAFJ3qaRjIbImaAgV9NSc9jWouTyZFOjIg==
X-Received: by 2002:a2e:80d3:0:b0:302:4a61:8b85 with SMTP id 38308e7fff4ca-30a599951ebmr34295601fa.37.1740335132749;
        Sun, 23 Feb 2025 10:25:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3097b6584efsm26654891fa.33.2025.02.23.10.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:25:31 -0800 (PST)
Date: Sun, 23 Feb 2025 20:25:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: panel: Add Himax HX83112B
Message-ID: <77wat26ggsfqwssgt5wfq6yz6w3ccqz3pmn727a4aphqv4ljhx@vrzneg2rvzfj>
References: <20250222-fp3-display-v1-0-ccd812e16952@lucaweiss.eu>
 <20250222-fp3-display-v1-2-ccd812e16952@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222-fp3-display-v1-2-ccd812e16952@lucaweiss.eu>

On Sat, Feb 22, 2025 at 06:58:05PM +0100, Luca Weiss wrote:
> Himax HX83112B is a display driver IC used to drive LCD DSI panels.
> Describe it and the Fairphone 3 panel from DJN using it.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  .../bindings/display/panel/himax,hx83112b.yaml     | 75 ++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..e6bd4b33d40be98e479d84617aea6d2af0df70e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/himax,hx83112b.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax HX83112B-based DSI display panels
> +
> +maintainers:
> +  - Luca Weiss <luca@lucaweiss.eu>
> +
> +description:
> +  The Himax HX83112B is a generic DSI Panel IC used to control
> +  LCD panels.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: djn,fairphone-fp3-panel

Would you know a better name or ID for a panel?

> +
> +  reg:
> +    maxItems: 1
> +
> +  iovcc-supply:
> +    description: I/O voltage rail
> +
> +  vsn-supply:
> +    description: Positive source voltage rail
> +
> +  vsp-supply:
> +    description: Negative source voltage rail
> +
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - iovcc-supply
> +  - vsn-supply
> +  - vsp-supply
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "djn,fairphone-fp3-panel";
> +            reg = <0>;
> +
> +            reset-gpios = <&tlmm 61 GPIO_ACTIVE_LOW>;
> +
> +            iovcc-supply = <&pm8953_l6>;
> +            vsn-supply = <&pmi632_lcdb_ncp>;
> +            vsp-supply = <&pmi632_lcdb_ldo>;
> +
> +            port {
> +                panel_in_0: endpoint {
> +                    remote-endpoint = <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

