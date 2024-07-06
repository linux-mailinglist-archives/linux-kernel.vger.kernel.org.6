Return-Path: <linux-kernel+bounces-243334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4D9294CC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 18:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5152E1F21140
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED12A13B58B;
	Sat,  6 Jul 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYInJxk/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3692C8E1;
	Sat,  6 Jul 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720284543; cv=none; b=Z11bytaTakbT8v5pT5zMdY3avbutRLGbNCyUAd/ic5UTB1IharomnfhAzUucn70A4NuOsIS2HBsIo0zuAmTR4C/I5KrsE72Ude1LP0iqAn9E3y/IVbgsMxttY/PulilEkPNpkljOxl7rtsV90SdogJyKEnvjtrniJ75/hLzPd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720284543; c=relaxed/simple;
	bh=lVLS1J+a6VwpogBP/TJsabzltLu0nFkAMMRxA/hKr6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8128RxIbf+KrPQTQglEXYDYqiThidLzf330gjUyHiRP4r/x/C+aT7H/KN4Hj6HVnb9cQbpPqWpEkrZf40TOHCzWUaHKjcN9WaLzOGl9Z0TVfT/wj3SiAwgUE70yWtc51HB8fj6/L+43cPDKIfADxdps6LY9j0v/SaYd2rCz4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYInJxk/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb70169c23so1573025ad.1;
        Sat, 06 Jul 2024 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720284541; x=1720889341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pPLymTdWA31lQrXZwdfEII/TYIYPSXMJ6wqAirrqs4=;
        b=OYInJxk/sGH2PwBEDOl/32wgiVeefpOJFok2f6EFSdTCqwn/Qn5/jYiamBfwewXiwV
         b7Xn356e8jJIO8AjptvVKt6JGjxc9CC4M/+Knk3vk35YHeCTKsflo9IN98JauwQHHVFz
         hOLZ9YxynigTgH6Cw39izIvsp4pTiFttvm3bP/yp5AGVbN5pXkyXDfQWs3fEjKD2iLOp
         b4ZmmdkagyKBz0Hu0ZhP8e5l5ZdI10cLZhoEL6h61Kt0MGE//wgBrJTZCM3FfOrJT8gh
         NhEsHC/Ra90s/1ssvu4tEIGV4MrwjLrs/nUWeyh+e1X/yJLaTSYZ2PXgdDGSeL5OZfxo
         vIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720284541; x=1720889341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pPLymTdWA31lQrXZwdfEII/TYIYPSXMJ6wqAirrqs4=;
        b=k5lxXXe4Kh4MkiPOoOu5UOx44dQrHPREdaqWBiAEYlDIslWRBMcy7FCJ2aG7RqQni0
         funPvkelpPg4RTCOhLT80BdD/KkbKeG+tQt/x5hYfO3jB14nvYwQpuTUx99oc8Dls6is
         bZyNr76d2VWCFiI00u/1/a629b/Z41o4tdy7LG125yCEgsE0Lz3CU1jIe1GThxGL/Lc8
         QbfQMM01LPlQQEQOzydjihXd3U4O7VEDBHnSDwHK6fPBsFX+VvFbGsE1kqskTaRYUkkJ
         Xc2fOJNPcbfFiGdYfZG2BB23yTdgrlcrsa6n7tcVFwoiiF+fe89k0NdqrgPOf8cSV+Ku
         t/kA==
X-Forwarded-Encrypted: i=1; AJvYcCXS9Te4spjKeGliRe73ZVfS/4915OMzvCQPBAeBZJ9xaCUVpsGcvBoivZyNhwtLwKOwBd9OwpB0desj4NBkOYl5/3gBrSqdENsy69rTFhC2D3ESeu3HLUDOPhm03UXAndpAzil9jIDdTwzlRpNpeZ2DyGk1Suhc+YClKXEJwDGU/5hsSNUjde2QOyU1TZ+2k9vpwZZuwQGl7QcU17k+TTZh
X-Gm-Message-State: AOJu0Yx8gklIB+Rm02tXGO+Csj1UdldbZbmzSqcaaC48FlHTXrU5M8iT
	P/CB+Co1mejlWSPhHf2PE4rDQMx/IG6rRcPrGDoyy4S4FDpwb/oJ
X-Google-Smtp-Source: AGHT+IENJeiU7Mi8p64xH7HmJ8ROz4UbZ9E6gDDBcfa1jvirP9W3uzmIUxJcyVS/Lt1WZqvP42h/qQ==
X-Received: by 2002:a17:902:f541:b0:1fb:29d1:501b with SMTP id d9443c01a7336-1fb33dfc2f8mr53062975ad.5.1720284540933;
        Sat, 06 Jul 2024 09:49:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3419e297sm50786015ad.70.2024.07.06.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 09:48:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 6 Jul 2024 09:48:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external
 hardware monitor support
Message-ID: <5a2e23f4-d54a-45ae-a09d-e557b110e017@roeck-us.net>
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F58B631D836F3863115ABBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953F58B631D836F3863115ABBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>

On Wed, Jul 03, 2024 at 10:30:43AM +0800, Inochi Amaoto wrote:
> Due to the design, Sophgo SG2042 use an external MCU to provide
> hardware information, thermal information and reset control.
> 
> Add bindings for this monitor device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> 
> --
> 2.45.2
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> new file mode 100644
> index 000000000000..f0667ac41d75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 onboard MCU support
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-hwmon-mcu

According to the other patch, this actually covers four
distinct models/devices.

static const struct sg2042_mcu_board_data sg2042_boards_data[] = {
> +	{
> +		.id = 0x80,
> +		.name = "SG2042 evb x8",
> +	},
> +	{
> +		.id = 0x81,
> +		.name = "SG2042R evb",
> +	},
> +	{
> +		.id = 0x83,
> +		.name = "SG2042 evb x4",
> +	},
> +	{
> +		.id = 0x90,
> +		.name = "Milk-V Pioneer",
> +	},
> +};
> +

Is it really appropriate to use a single compatible property for all of those ?

Guenter

