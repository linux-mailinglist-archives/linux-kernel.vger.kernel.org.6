Return-Path: <linux-kernel+bounces-357211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61ED996DB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3211C229FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD663199223;
	Wed,  9 Oct 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fO3K7ls4"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A11993B5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484084; cv=none; b=NUXqzFdZD146KSG1XBbqRcIBUoHdH190V68metKWDkc7prMh1UDjHrdYHxzgu4fyzzpUWJx2Er5XjoQLlh+r5LVOqod8ocydmzN7GRuuFIqJ+KJGdc9lu1BfS/Oxe+nKhqYpGeWRsKwG82Vg8SvbSJCsjgp1bBqsb/aBTckRtAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484084; c=relaxed/simple;
	bh=23cA1onqzwt1q7lhY9JMGOcwOd3fOLWS2ciwmGet5bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd5rXN9tWhyhaYBP+wSsIaVecWzqtnebrzfrjbQql48ByH/XBovBR0FRWabfkmLx+KrAlGs5ykte5haW6x/3oOg79buZNJijbRCCu+4+TJreTMsvUbKu37Op08if8SuJcQzLeOi7pnQCNIxHNDjMfhpCBLbf5nys2/esdOBdy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fO3K7ls4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c5bca59416so9232798a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728484081; x=1729088881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CylJOmagGAkGpdVrMr6+1cW2iaVLREpDJiGPFs09KAk=;
        b=fO3K7ls4i7JsT/TnbFPklx+ss4sTEg5Vamz+C/xNw9i2AWD+LILRtzZSsU8G6q8ICM
         DIAaS70BV0ySeOQjK5gEPIRQOU3b/PeemR5PyEaINKVErU44QDKjKiFR/VontsQIJtxS
         Q49RvF3C16Zc59Lu98D5vx1rSL/R5LZxJLA8c1KSelg8f3oMe2CocktgG4yxAyTPTE5m
         x9BOrrFpfVJgiDtVP4EM5xD6Es8FwvW8Uv2DELaPxlczIUyzYgXwsa3KttttekI1f06m
         8usIaa1UIZcNo9m9ns2K2cTREJkOyXHpk25nnIb4Nlac+VyFShKX6sFOjCYP/wNQPMSN
         +EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484081; x=1729088881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CylJOmagGAkGpdVrMr6+1cW2iaVLREpDJiGPFs09KAk=;
        b=D/jP1cMtmILBL5BEEwq19auR241PY9xZebQYC9Exc69TMmuU2J5ZB+GKMP/abiMCPM
         L5AH9qatmHv8hVN2CbtQmupL30h0SRkGRpROXPE6k0ycYea391RlSGJEjuaigPTBi4gG
         VhX8xI3BDkViiWWtHBRGV+Wo0H2jbVc0k1TtHJYo95NDKbIH7rYXopydHpds+hA9ywrX
         UY0vrfcm1FaHTD1opJmDMyyCyACoDEm9lFdPttjsmhAPg7IdXt5u6u2r9Hve4mSJ2z9S
         fP7gArJObREfP2TASb2dTpaewgMPVj24yHiTbGZDDDrrQKaG4v/FUItzE7QKsgKzyr40
         Wfag==
X-Forwarded-Encrypted: i=1; AJvYcCU41kCsBdAweG5c5IsUsS42dpVzPt5Q4ALUUren+hPxZ7JUGUa6XspU6ip1ozEQs3JYZd0mqSOEJ0Vj85g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5WTy6i6cUDTQ5azKvJ1PJpsl5evBJRM/rzEb1r11Kt0BmLVi
	zzaXMv7xady4+Gz0I15MjRwjgq79wHovUY4MdwdFe9w/6ZMI+n5QTXNzWLdxBRs=
X-Google-Smtp-Source: AGHT+IFC2+aNftX1wtcYA5gceGi5A5G0BYMh6bKRimAvEmAv1nnzz79VY6eqA3p/ELTcZ0JDKdD5Pw==
X-Received: by 2002:a05:6402:528a:b0:5c8:84d9:ce26 with SMTP id 4fb4d7f45d1cf-5c91d5c3636mr2060269a12.19.1728484080612;
        Wed, 09 Oct 2024 07:28:00 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c91cd8eadesm1016377a12.12.2024.10.09.07.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:28:00 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:27:58 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: backlight: convert
 zii,rave-sp-backlight.txt to yaml
Message-ID: <20241009142758.GB16179@aspen.lan>
References: <20241008-zii_yaml-v1-0-d06ba7e26225@nxp.com>
 <20241008-zii_yaml-v1-2-d06ba7e26225@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-zii_yaml-v1-2-d06ba7e26225@nxp.com>

On Tue, Oct 08, 2024 at 06:00:58PM -0400, Frank Li wrote:
> Convert device tree binding doc zii,rave-sp-backlight.txt to yaml format.
> Additional Changes:
> - Remove mfd parent node at example.
> - Ref to backlight's common.yaml
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../leds/backlight/zii,rave-sp-backlight.txt       | 23 --------------
>  .../leds/backlight/zii,rave-sp-backlight.yaml      | 36 ++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
> deleted file mode 100644
> index ff5c921386502..0000000000000
> --- a/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Zodiac Inflight Innovations RAVE Supervisory Processor Backlight Bindings
> -
> -RAVE SP backlight device is a "MFD cell" device corresponding to
> -backlight functionality of RAVE Supervisory Processor. It is expected
> -that its Device Tree node is specified as a child of the node
> -corresponding to the parent RAVE SP device (as documented in
> -Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
> -
> -Required properties:
> -
> -- compatible: Should be "zii,rave-sp-backlight"
> -
> -Example:
> -
> -	rave-sp {
> -		compatible = "zii,rave-sp-rdu1";
> -		current-speed = <38400>;
> -
> -		backlight {
> -			compatible = "zii,rave-sp-backlight";
> -		};
> -	}
> -
> diff --git a/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.yaml
> new file mode 100644
> index 0000000000000..fe9dba8231bf1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/zii,rave-sp-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Zodiac Inflight Innovations RAVE Supervisory Processor Backlight
> +
> +maintainers:
> +  - Lee Jones <lee@kernel.org>

How did you arrive at this maintainer list?

It's not the usual backlight group and it also doesn't match the
maintainer for the mfd bindings.


Daniel.

