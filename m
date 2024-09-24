Return-Path: <linux-kernel+bounces-337418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E7F9849D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE822854E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383541AB6F6;
	Tue, 24 Sep 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfjQhOMn"
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E417A1AB6F3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196106; cv=none; b=jt2XN48D58KMFLFhCyY2UdTIfwyLujai0o7TQ17RGZdLq84u/qCIIMW5hgTscjd+4+8iAM1vX9Q1Cu9WYV7cO2vg0PjDJwjV1tYK1jR/zHOK9FLu0qXLzboTAgqsFTPpZYtz3Io6PMDTCtmKDNBqvAgTrbGp++w+Ltw/qUNwIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196106; c=relaxed/simple;
	bh=Prh+3j7UaMsFa6Z08/GrdXNcF2VkeTu8GBdMUK87Lo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojl12zTOR2vmqwKG3+wXjuzbzpfQf+jAQTcaZPc/rrlqDbahJt3cTkr9rJePcbmC1yj6vTWAIcgMU9RZt/u8JwzrSQbEKTfNJiqQ5QGWlXnoBHa3zO2jhYV3XYj/1qfD1EqPJPs0cwextJJ05c4+sqpblGFVOpLpQboDLiW3apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jfjQhOMn; arc=none smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-49bcf6b9b64so1965231137.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727196104; x=1727800904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKFcq68krKcoUA32HXrqc6ME7X0w/Gnspu3t4IYxZ54=;
        b=jfjQhOMntQ5t/ywzfQqO0x9ejAxlNJbuDPCLjKgBiznqt4lDo6ZhEQlZQKlNLvwObG
         hS7PluPQ4W9xHnOPakFocXcMSK9K5YL8Oh7mLv9dMtcE1FQjm1A5H0LoEFyQF2h/ftW7
         bKRVsLccuZAq42YZca3IvYxKn2JF5RA+apc9CJtzPlAA8VwHtlq5D+TWAV1k7UR7Dmfw
         fnbE2EaUhza+5/j+Ca/3YPHYHND6r4m4bnNGV9z0M7SV9RaDy3AcM4LdmuCJKxQBHXos
         y0d7he0V5Jce7yD+0Ed9eMBdna9MUdUaDzXSEeWL72Tgloy0jGtq39VCJ4Mclr+FBBEZ
         c5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196104; x=1727800904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKFcq68krKcoUA32HXrqc6ME7X0w/Gnspu3t4IYxZ54=;
        b=JkM10TBBeAr8MNE1Cpb95ayhJpzmAliFKagVYbmGaLXjr5qYYCu4zxpIiaXUL+ghlC
         Pa0V7WEIuJ3/uG5np3bsu+KnBTd7U9iZwjZXBJp8R6U1GJbRP8ZdVf8KCHI/ZM1Dpx8S
         LzG/Eh1rThFZ6F85N6rslViEyBgSq8wC3v1ewTTi1snXJlvoHBOMoKOoPWEB956HtaII
         kMgtUGGkz6nMN8RFYI2jNmHxZeD9Fx3ygahUzxmClRbRp0WUvs88wwYrHPpiMa3/oUKe
         Nppvgh4WlU327JAY+PUfTBrzh4y0v4HCtxdtg6vUOnaAjXHJzT2vkq+z0EahXOCLIUCT
         EYrg==
X-Forwarded-Encrypted: i=1; AJvYcCXR5oDUBBHCbO4MZxv5Bm3Acu1epKZ+1JYVBBAKv4vFxdO9pWs0otmwW5sUcKiufp4n6EKeIJtCLO2Ss4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnJbOvYtSKeLXjb9aMZTl5x6m1Z8h7JrWnaE+Vr65mQfKHa+q
	H2hEGzZU007HR5tJ/bQAL7L3SPxY+P3lRUqulp6LkkbaNbT7nQq1zufE28HQTl0=
X-Google-Smtp-Source: AGHT+IEbKvtyjKhabAyEh03JO+iNT62nJhG9gP0ReHnRFsz8uhKocJKHDYfMutFSgoagOKKUmV2zYw==
X-Received: by 2002:a05:6102:e0a:b0:492:876e:6d15 with SMTP id ada2fe7eead31-4a15dc99b01mr152354137.8.1727196103814;
        Tue, 24 Sep 2024 09:41:43 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:4518:32:3b61:babd])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a1517c0cacsm1003262137.19.2024.09.24.09.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 09:41:42 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:41:35 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add NXP PTN3222 eUSB2 to USB2
 redriver
Message-ID: <ZvLrv4rW6vbOws8E@linaro.org>
References: <20240830-nxp-ptn3222-v2-0-4c6d8535cf6c@linaro.org>
 <20240830-nxp-ptn3222-v2-1-4c6d8535cf6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-nxp-ptn3222-v2-1-4c6d8535cf6c@linaro.org>

On Fri, Aug 30, 2024 at 11:20:45AM +0300, Dmitry Baryshkov wrote:
> The NXP PTN3222 is the single-port eUSB2 to USB2 redriver that performs
> translation between eUSB2 and USB2 signalling schemes. It supports all
> three data rates: Low Speed, Full Speed and High Speed.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

FWIW:

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

> ---
>  .../devicetree/bindings/phy/nxp,ptn3222.yaml       | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/nxp,ptn3222.yaml b/Documentation/devicetree/bindings/phy/nxp,ptn3222.yaml
> new file mode 100644
> index 000000000000..acec5bb2391d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/nxp,ptn3222.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/nxp,ptn3222.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PTN3222 1-port eUSB2 to USB2 redriver
> +
> +maintainers:
> +  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,ptn3222
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  vdd1v8-supply:
> +    description: power supply (1.8V)
> +
> +  vdd3v3-supply:
> +    description: power supply (3.3V)
> +
> +  reset-gpios: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#phy-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        redriver@4f {
> +            compatible = "nxp,ptn3222";
> +            reg = <0x4f>;
> +            #phy-cells = <0>;
> +            vdd3v3-supply = <&vreg_3p3>;
> +            vdd1v8-supply = <&vreg_1p8>;
> +            reset-gpios = <&gpio_reset GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +...
> 
> -- 
> 2.39.2
> 

