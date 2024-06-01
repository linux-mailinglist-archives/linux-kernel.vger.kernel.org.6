Return-Path: <linux-kernel+bounces-197948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C838D711B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 18:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC01F21ECD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5253153506;
	Sat,  1 Jun 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSTRqRbb"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539010949
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717259285; cv=none; b=IgaVq8CZXqZagD8LCbuvFV5xEy9Ge9zFmBnJpIMprRxMtXfcLI7FWPwfrV1CAPbwD1Jv2PGYXstNVX/WBG6wGcM+bRJisdGJE+QjNBlfdjBLmFUvLkkFc7aZsaOyAsqrfOEGaTkZ4nOi3CsiKaqIAlT34B8EPq7y790JBk/8qW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717259285; c=relaxed/simple;
	bh=CuHaze8vUeuTJmclt6kK3pbwQ+VhNnBk8fwURWrhQ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q48PnRXqzMkw3U9rgY28/rDDYJH2onYODJiryVKhgI0CSalaIQsjwjq+6VIS2laviVwx8mG4QyRxEBM8cnWflA+qS+ZZdNa5GC/+DnM3bUkWqnD2/hdvNAMntX0m/TxJxwlX6FxWheOxIKQwBiInUQTNeVCHGR32NiUrtgPgYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GSTRqRbb; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso32466661fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717259281; x=1717864081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8dCetMXBNsdnzLsPwECOfBM/mDQHWqh8OSO5TH9kB2E=;
        b=GSTRqRbbh/JTjrW7/qoNyIDUXwD40nwj72Q3Nov70aEi9lOeuy/rNFEEyMzgvo1y/r
         WSbrJwBqYhyVbnvnBIR+qVrUI6IbimW2AjlvAL6tcj5mi6wagdAfDQQPVL+czZU0H8cR
         t7afESAK/sI+QODi/uOUJlpPGTy2eCNQCHK1yjQJpvfkq91HOi9jyoeoFc1WXRPhRmwP
         +Iagf3GQuL9thR3GW6S+voGNPAs7+zrrfGrrZyXETzxvJkucDl7/ok+nBcmBS0VQNmP4
         qy2m4RLrR62tvmvi+PFehWJdgJqJAaUbSKGgF++GagU9Sayu9Mkj1vpA4gHD+B7tZMvS
         RLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717259281; x=1717864081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dCetMXBNsdnzLsPwECOfBM/mDQHWqh8OSO5TH9kB2E=;
        b=OiB3H6Oeln3ZGSXbvMCwwAR1vXDSLTOUhYc20sT9cP8A2ginq5oJKxCY6VOuBcQkQG
         cR1MtVG16vIT4IkexmCY2pQWN+FokN86tw6TbRRPkarIemA3uhmw49O5VwaNiaUKyjUT
         ZOT/sVsSJW4HCgJjbQgLH/g0M/EnykB2E+ZFL8TR3BzP4bJx/s7nmW15+PxkQ65S5Kwf
         y6W6PA2gbVNuEex9PxB6xAIhatPOTFRrJ+QKRga1fhzs4g/YRukcZMwT5AloIHVBJdr3
         QNg8FbaKXPNQ+ckicJ4T/CZC5fZtuPgHZYfvPqYqCpCwKg3sDB11obgrESSnwwDhu0KL
         qeAw==
X-Forwarded-Encrypted: i=1; AJvYcCV4/dnfAuQMXg21z8ki12b+5Hy34QT3JmH3Hz0Ectw1+7mcQxujYHnQNK8gunFLV8G2Z1YQgElJ99SkH4/LtlbovATvn0Gx2Wg3l8VY
X-Gm-Message-State: AOJu0YzQGxDHVZ1gd0VvVBzXEOEnUMF8obYpiWUsTsIY40nQAv5kf4WC
	CBlV/+y9ODuoF4Haf1mu7TY6Ury0tWvY7toq4KuVFAj7HIozsjqeqoOl5syq110=
X-Google-Smtp-Source: AGHT+IFZK15yzRbt5D2yDEHSiUdr/2IUT19M7aJMN/lyCgBX92vgdTniZ1S91kTimZ/n6owI25KOJg==
X-Received: by 2002:ac2:5626:0:b0:52b:8342:e0fc with SMTP id 2adb3069b0e04-52b896c672fmr2853711e87.54.1717259280607;
        Sat, 01 Jun 2024 09:28:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d3f1c7sm697442e87.91.2024.06.01.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 09:28:00 -0700 (PDT)
Date: Sat, 1 Jun 2024 19:27:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: Add KD101NE3-40TI
 support
Message-ID: <oo6gggt2kpufvbwg6emoblg4opj2izdfjad4hzojbe7ddp57rp@a5vf23zrk22o>
References: <20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240601084528.22502-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601084528.22502-2-lvzhaoxiong@huaqin.corp-partner.google.com>

On Sat, Jun 01, 2024 at 04:45:25PM +0800, Zhaoxiong Lv wrote:
> Create a new dt-scheam for the kd101ne3-40ti.
> The bias IC of this kindisplay-kd101ne3 panel is placed
> on the panel side, so when the panel is powered on,
> there is no need to control AVDD and AVEE in the driver.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> 
> Chage since V2:
> 
> -  Drop some properties that have already been defined in panel-common.
> -  The header file 'dt-bindings/gpio/gpio.h' is not used, delete it
> 
> V1: https://lore.kernel.org/all/20240418081548.12160-2-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> ---
>  .../panel/kingdisplay,kd101ne3-40ti.yaml      | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml
> new file mode 100644
> index 000000000000..b0cf12bb727d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/kingdisplay,kd101ne3-40ti.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kingdisplay KD101NE3-40TI based MIPI-DSI panels
> +
> +maintainers:
> +  - Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>

Any reason for using a separate bindings instead of extending
panel-simple-dsi.yaml ?

> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - kingdisplay,kd101ne3-40ti
> +
> +  reg:
> +    description: the virtual channel number of a DSI peripheral
> +
> +  pp3300-supply:
> +    description: core voltage supply
> +
> +required:
> +  - compatible
> +  - reg
> +  - pp3300-supply
> +  - enable-gpios
> +  - backlight
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        panel: panel@0 {
> +            compatible = "kingdisplay,kd101ne3-40ti";
> +            reg = <0>;
> +            enable-gpios = <&pio 98 0>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&panel_pins_default>;
> +            pp3300-supply = <&en_pp6000_mipi_disp>;
> +            backlight = <&backlight_lcd0>;
> +            rotation = <90>;
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&dsi_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

