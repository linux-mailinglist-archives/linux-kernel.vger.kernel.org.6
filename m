Return-Path: <linux-kernel+bounces-222974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54967910AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDFCB24528
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BBB1B141E;
	Thu, 20 Jun 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIaCFUrw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABA22616
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899446; cv=none; b=D1YfOm7fUB8G15F6iQ8KRPOu9/Gbecz+mw1bMJB70Nm0aKSVzEa0FEpovCOQJIqHI/ivGTFW/dARjITo0kUbg8uP2DYy8Vxs+1jLAKoleySsTM1NSND6TPWhpbKRbNMDelF6hx8pDht9Tk/n+d8kSEzLh3WlfjG8G1XVNh3Nxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899446; c=relaxed/simple;
	bh=sQzq/TKljZMD4pKsJgwfiUeJ9tPpo+3DV47u3VvC5mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJSokP0BbFX/y9tw4qkXdAKc7vKLpsj5fLlt34cGOsutQPFK/0ZdTf7K3df9udr2PFGGN2JQeU9bHb8yubm21lyVUVzdziUSVZavQHwESpjk0+HrttZraqrYtl8aqYvS+DqUJ9VNsYLkfic7QvKg6ihI4J9LtkxzbA2LE0g/9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIaCFUrw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718899442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDqQrPGd42O44YfWw+IRXhYqcC8xwDaLQyCUqbKdOfM=;
	b=NIaCFUrwiKTKZwwmOfDWDwRT8pz2quqQizr/z7x5FaFaa5PvBpTOpxl0N7TshrGSBwug37
	9+3ky3cy4+M0YzuF9qBOAqMUVOrIQYn7l3RthRbZ85UUJhgSUvMusuvBse6HuX4N9I7GOz
	DOYJAy5Gprxt/qfhUJg4yWGH15LZ3bY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-2G-oAVgeMq25OuuHHPCZSA-1; Thu, 20 Jun 2024 12:04:01 -0400
X-MC-Unique: 2G-oAVgeMq25OuuHHPCZSA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44212083709so21836071cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899439; x=1719504239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDqQrPGd42O44YfWw+IRXhYqcC8xwDaLQyCUqbKdOfM=;
        b=NmQjjd4KZJmHlPVWu/9uz1rW+rPNd7Rp4EQgIDwU8r0W0O4uhyZXt5wWUQlL2uFgUn
         +stP53qnInrudEL72HJAF/bn5S2BG8CE+tn9dXDUv8IE7YsCV7lfM9fkaxU4WQ4bb04i
         peNjNXqzYk9dOS9eVsahfsqd6BzHdddteSsmlWjMAEViYVvrht6vNAU/PBJmJ9Xa90UB
         VKXFWb50Ac0fEoQv3rPmEtj2AhTMMutoAO3u/OUVs7ti2FLvub5ACYq4e1wt7Xz/b1X7
         P3lvFiM6F2goW1aoZy9ssmREyqDde2wOtXWByg9z3F+F7lTDI7l5w1U4jm7b1n0figs9
         MVHA==
X-Forwarded-Encrypted: i=1; AJvYcCVG95hSkqZooy45MLOhAVIUEMvA9IJs2S40R4op9/UvTO63eeJedstajedMxm1SeV8cP5iZ397KuHmwaNmH3vn4Bcd/B0RBaBCHJoxp
X-Gm-Message-State: AOJu0YwtmUIT1ExL9uzYacsMRGd5x7vLbMblDswp6j4l0MZhel0QrS9f
	P8dMJSGRt99vBO9BSlRUwkCeQplA9M79Mi+xYsGAOJ3nkD6mBSMO5niiHCR6zs2MS+xECTvWmOI
	zAirmdEZNW2TRjFs1o6PdqSuCbqLOnUN75r8UwzFqyoWQUkTJMArobaJVRtoK0s/ETPK5ow==
X-Received: by 2002:ac8:574f:0:b0:440:e39:372a with SMTP id d75a77b69052e-4449b8cc771mr147429531cf.3.1718899439062;
        Thu, 20 Jun 2024 09:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhB1DYbQ7e1+d1lc5JGo+U74y4WtMNDo+mQhkOQObAXNZnPDXfG8If9cx7sbaD1+JFxdxvwQ==
X-Received: by 2002:ac8:574f:0:b0:440:e39:372a with SMTP id d75a77b69052e-4449b8cc771mr147429061cf.3.1718899438587;
        Thu, 20 Jun 2024 09:03:58 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-442198f6160sm66411891cf.45.2024.06.20.09.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:03:58 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:03:55 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8775p-ride-r3: add new board file
Message-ID: <henuash23dwkj5fcmub6sabygwo4kam7fgots2pp2j3eu4asuk@cn3o7a62lo74>
References: <20240619183255.34107-1-brgl@bgdev.pl>
 <20240619183255.34107-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619183255.34107-3-brgl@bgdev.pl>

On Wed, Jun 19, 2024 at 08:32:54PM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Revision 3 of the sa8775p-ride board uses a different PHY for the two
> ethernet ports and supports 2.5G speed. Create a new file for the board
> reflecting the changes.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |  1 +
>  arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts | 42 ++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 0c1cebd16649..916fbdbf5631 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -112,6 +112,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-acer-aspire1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
> new file mode 100644
> index 000000000000..d7f0a25c1fc4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include "sa8775p-ride.dtsi"
> +
> +&ethernet0 {
> +	phy-mode = "ocsgmii";
> +};
> +
> +&ethernet1 {
> +	phy-mode = "ocsgmii";
> +};
> +
> +&mdio {
> +	compatible = "snps,dwmac-mdio";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	sgmii_phy0: phy@8 {
> +		compatible = "ethernet-phy-id31c3.1c33";
> +		reg = <0x8>;
> +		device_type = "ethernet-phy";
> +		interrupts-extended = <&tlmm 7 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <11000>;
> +		reset-deassert-us = <70000>;

I need to read your other series still wrt "ocsgmii", but any chance you
have access to docs indicating the reset timing? I've never had docs for
the specific Marvell phy on the prior board or the Aquantia one on the
new board...

Boot time is something automotive is always concerned over, so I just
want to make sure that this timing isn't any longer than it needs to be.
Right now it looks the same as the Marvell phy's in the "v2" boards etc
and that made me raise my eyebrows.

Thanks,
Andrew


