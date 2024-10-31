Return-Path: <linux-kernel+bounces-391121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4529B82E9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BDF6B216FC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7FB1CB316;
	Thu, 31 Oct 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dB41oaQ+"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0051C9EA1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400965; cv=none; b=KlR2WIW2sRdCDNY5/pxxjgw0+XMFiUUOfSLX33D4AxIsFgJrQOGUJoAJCjBJu9mV09D9TzwDu8na7qaAop2OCnXtBOfa1stRQTbFNlAyy48/pudZT00qwn6Jnvqgcn/17bfhE7Yi8arfGuKGI3cSURj3hxrgew2MQIZ5yYHci+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400965; c=relaxed/simple;
	bh=B4oTAhRHxTZv6woXYBjT10l0sPULFpxloGX1fSZnhFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDrr5P2M/XH72qexCxXkOVg4atb27kZ/r4FNVMgUmmkrQcGg2nBNsue9zzWFUQe49uAW4RKk3auJjS/dhQef+wh1swPSBcC7uAis2QscRy+KfTwfBBnGFFwc6DSd3FoGIp705a1icF4Vys6dZOMs69qINwJLbzLLnZrnOtUMFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dB41oaQ+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so927602a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730400962; x=1731005762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n9x1m1RYOM7X235H8PXZkpmXCy7V1cpMxA3l6ZbKlLA=;
        b=dB41oaQ+F4hOH5iV62YOarY2em20muXAUpP+rNjx/qnok74eVh9BTQAINHjVus1EG4
         6LxZqXP0aevOdGY9AgsiYmxf+qre6vk1jLu3kpotKu+nQNUr1nuaV6vKJSEFqnjRgJZY
         DilzQlL+vkRXrWmwDfTdYPNha8xbO3q1O6oqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730400962; x=1731005762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9x1m1RYOM7X235H8PXZkpmXCy7V1cpMxA3l6ZbKlLA=;
        b=L08qXlNC07m0TVBbIWDPZdg2QCRTXK4YJWkTIzrxhSu+koC5h2wENhtvnNED/0C5YA
         zNA49pgpycL9rWWnhEvbH2p7ZasP2wWsQJsh/34RhJsknXtk+yUDzQArA2E/7XCOmK0M
         KapJxhju09QCBKT3n/0+EeAMA5oLZqULEOYIoj4qpARBchTheXkws3mDg81W8mA6q4Ei
         JsMFVVGCwIHhbN/n4fY6gncljdA0UK8FrEKrTc3Wg5oKlSzZp1TvxGA7cjLLDdCnNqqJ
         9V/xs4FR9LCNmmDbHd4oHOBiipt4MtLIQaqNwonUtdPGfqIPQS6BP8vLA5eTB6X3qFDv
         I5IA==
X-Forwarded-Encrypted: i=1; AJvYcCXqGhyZiazBwFhGwYzPe+Ps6SOyXalvf7mnB/LYiveGvWlb3eNeGmFOVE2x1SN4XlwY3V1g288Wrj1BnCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx20cCpw1VkV1wSyeIChwI59slyf95mT/dSBkwjQtBEjogihG8y
	8iYbHGZIiuFAcWoWum7PSuaKW6eTSSU7H9ALsAFMVKrjM3AhHAXGsdWxvGS9uustyhMVgSy3aYr
	NfoWaOTy2DNz7C9Z3VlrWYef5IJeelPQl/zNT
X-Google-Smtp-Source: AGHT+IGJpxj9d+x9ha4I4b3L3gglHusIK56TMkuuORxNw6XyB05oJPNEE+9L1slSzK08FESBEhhNbGUFCE1cpFuwIAc=
X-Received: by 2002:a17:90b:3a8d:b0:2e2:c1d0:68dc with SMTP id
 98e67ed59e1d1-2e94bdfa857mr1551852a91.9.1730400960308; Thu, 31 Oct 2024
 11:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030213400.802264-1-mmayer@broadcom.com> <20241030213400.802264-2-mmayer@broadcom.com>
 <db7b7745-404d-45f7-a429-c1c747de8e6b@linaro.org>
In-Reply-To: <db7b7745-404d-45f7-a429-c1c747de8e6b@linaro.org>
From: Markus Mayer <mmayer@broadcom.com>
Date: Thu, 31 Oct 2024 11:55:48 -0700
Message-ID: <CAGt4E5ud=0rwSKBTOAsx0RMB3Pkjo+HHxZ_JLPBFbOSZUTCRVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: rng: add binding for BCM74110 RNG
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Aurelien Jarno <aurelien@aurel32.net>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Golle <daniel@makrotopia.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 00:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/10/2024 22:33, Markus Mayer wrote:
> > Add a binding for the random number generator used on the BCM74110.
> >
> > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > ---
> >  .../bindings/rng/brcm,bcm74110.yaml           | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml b/Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml
> > new file mode 100644
> > index 000000000000..acd0856cee72
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml
>
> Filename as compatible.

I am not sure what you mean by this. That the filename should match
the compatible string? I did change the filename to
brcm,bcm74110-rng.yaml the ID to
http://devicetree.org/schemas/rng/brcm,bcm74110-rng.yaml# in response
to Florian's comment from yesterday.

> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rng/brcm,bcm74110.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: BCM74110 Random number generator
> > +
> > +description: |
>
> Do not need '|' unless you need to preserve formatting.

Removed.

> > +  Random number generator used on the BCM74110.
> > +
> > +maintainers:
> > +  - Markus Mayer <mmayer@broadcom.com>
> > +  - Florian Fainelli <florian.fainelli@broadcom.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - brcm,bcm74110-rng
>
> That's not what you have in DTS.

Fixed in the DTS to be "brcm,bcm74110-rng" everywhere.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    rng: rng@83ba000 {
>
> Drop unused label.

Done.

I am giving it a bit more time for additional feedback (on the driver
and the binding) and will send v2 in a few days. Meanwhile, the
generated DTS (with the changes incorporated) is now looking like
this:

$ cat ./Documentation/devicetree/bindings/rng/brcm,bcm74110-rng.example.dts
/dts-v1/;
/plugin/; // silence any missing phandle references

/{
    compatible = "foo";
    model = "foo";
    #address-cells = <1>;
    #size-cells = <1>;

    example-0 {
        #address-cells = <1>;
        #size-cells = <1>;

        rng@83ba000 {
            compatible = "brcm,bcm74110-rng";
            reg = <0x83ba000 0x14>;
        };
    };
};

Thanks,
-Markus

