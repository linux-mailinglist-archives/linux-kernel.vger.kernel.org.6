Return-Path: <linux-kernel+bounces-211646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D0F9054D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C0DB23294
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1117DE21;
	Wed, 12 Jun 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHWXG39v"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F817BB23;
	Wed, 12 Jun 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201684; cv=none; b=gUa2J2fWgx8hoCF00SDfPrBkVO+sBjWlbcL29k4kVzvZiNapUsYWZurlKwhj6qJO8zTLaV5DNkrVSzYZs8Oq9jajBEjw0fz6ei6ofyIdIDfiNviS+2xW1t3y+Gicn4Ra6Y7rt5XqG56I2UseUDc/eJczYfPnBpKzvTM6ESVf1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201684; c=relaxed/simple;
	bh=Wx/8/Myl4DsLtzdvgYRN+HtlVbAaQQR3l/UprCAbXt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qChyF72rLCSQV7VEoJh1Px6kJyhWs23zJux12n4mq5Hm42u3OVnU6hxl5jErwy3iV4SmiCeGQiKDwkT3k4zMfs+yZTnqpn/NoqG8OGUbRBJdbGXcdLyKR0C/DPrYHWd6DTdcUVprwBFnaPCXcVCXWR59Fs8v+JX1AK8c5n/E+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHWXG39v; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ba090b0336so1076760eaf.1;
        Wed, 12 Jun 2024 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201682; x=1718806482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3gvyllWWIRnYeJ4DjIIbMhoNnKxuOATp9pxj4Zd4Gc=;
        b=OHWXG39vBUWcxymMj17KNiJJ+F6B0jugF7STSxQTcUjFvUZQ69uIJCIMAUp3uj1r+/
         NeBVvgH/rONSIJmictvhHvBUgqMa+q751Y6Jz7DR7NXj+xfHCbzMqqn1J7NZ21mkMtn2
         Mqg66UmfjzcTddFZgLaMsdxByvNNTs+gJhrk6PKu4SCwJFumwDzFp9EJARzyRlI+k5xE
         E66aps+/0iTuurBYmsHg1bCVY2FbkwMimd84Klu4pb/bXgULevnc/uJ4SkYDMqzuzLxB
         1zK8ndvYU5bOYdQev4oU6kQcp6tTgt0VQZgSjWwL9wjgU08gFAR0Tji0DNLczIyzD+Q5
         jGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201682; x=1718806482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3gvyllWWIRnYeJ4DjIIbMhoNnKxuOATp9pxj4Zd4Gc=;
        b=iXQ1DMt6MCcUFtU8DHtbH9dTiQGqf9m/92XcN9t2EzdwyKRdK5Eizdr7EkMLlhATZe
         mOCM/ib+BWgZflGxRUcjNOR8x2N0w/bEG9ifWZQaZgiTNlVejSRFa4lsz2u7oGlrfi+u
         hw+5g4YHKlYc18Fpk6eHAdHz8kaNS4fipiCgaSPd68wOxtdK1rU9Vw0iy4YPgDT+YT7r
         /RmhJq7xTtmNbq+jyTZrs9yU2kYGnBdqiw2fmp3bMN9n+R0EcW4pBfVeKLu8SwzRix+f
         fK0FlFI/dG+3NUr2ZCm0ek2aRbrWSgHGgIBvIvOOrsQT4yHcmKXY5XOk3KEm5qa0y3I4
         QDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBUQZW5z/kwGMlpy9asDXVvWqzvNM2VO61NkgcYsFW2WNB7csnYRyG+fsl7Ibu0NVBTKpwRJkvlvx/o4TywSSieg/X6VrtJHYtw7kMZ29CLa7srygQP6Tw4YMxyllxhktzv23/98ImK3PY3AizTD5G5YcdRvc412QY4w4FoDMb5Mw1mm4z
X-Gm-Message-State: AOJu0Yzi97YxA/pHd36mtTRbwxMdzc3HLN/LJbVS/tSYoG5XTxUMWyDm
	jbu7vhbFga95Z9W255D8b/9KaTsoUnd63/uTUC7Ljw4DOHR+p+sn
X-Google-Smtp-Source: AGHT+IF8CtqpWGiINl3F7vHplq9qsdpwtyxs1QhLloQcjIXSAU91XSon8YqOspasNQsi7Nyhp4WKDw==
X-Received: by 2002:a05:6358:e4a6:b0:19f:4a60:e6f4 with SMTP id e5c5f4694b2df-19f69d54bb3mr242855355d.17.1718201681857;
        Wed, 12 Jun 2024 07:14:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6f7c4580888sm2268804a12.61.2024.06.12.07.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:14:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Jun 2024 07:14:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Amna Waseem <Amna.Waseem@axis.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: ti,ina2xx: Add
 ti,alert-polarity-active-high property
Message-ID: <f960ba3e-6673-41ae-b58e-5b6b2e700082@roeck-us.net>
References: <20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com>
 <20240603-apol-ina2xx-fix-v3-1-b9eff3158e4e@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-apol-ina2xx-fix-v3-1-b9eff3158e4e@axis.com>

On Mon, Jun 03, 2024 at 12:08:34PM +0200, Amna Waseem wrote:
> Add a property to the binding to configure the Alert Polarity.
> Alert pin is asserted based on the value of Alert Polarity bit of
> Mask/Enable register. It is by default 0 which means Alert pin is
> configured to be active low open collector. Value of 1 maps to
> Inverted (active high open collector).
> 
> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Note this is v3 which includes the Reviewed-by: tag since v4
does not have any other changes.

I removed the trailing whitespace while applying the patch.

Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> index df86c2c92037..9190ef0bda54 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> @@ -66,6 +66,14 @@ properties:
>      description: phandle to the regulator that provides the VS supply typically
>        in range from 2.7 V to 5.5 V.
>  
> +  ti,alert-polarity-active-high:
> +    description: Alert pin is asserted based on the value of Alert polarity Bit
> +      of Mask/Enable register. Default value is Normal (0 which maps to
> +      active-low open collector). The other value is Inverted
> +      (1 which maps to active-high open collector). Specify this property to set
> +      the alert polarity to active-high. 
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
>  required:
>    - compatible
>    - reg
> @@ -88,5 +96,6 @@ examples:
>              label = "vdd_3v0";
>              shunt-resistor = <1000>;
>              vs-supply = <&vdd_3v0>;
> +            ti,alert-polarity-active-high;
>          };
>      };

