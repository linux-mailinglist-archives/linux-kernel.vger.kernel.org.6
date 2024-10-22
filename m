Return-Path: <linux-kernel+bounces-375754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514159A9A67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC111F22874
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E411494BF;
	Tue, 22 Oct 2024 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtB/SN+6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2713C9D9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580546; cv=none; b=dzRmNZZhBisMm3BocpinnFuzkfYG2y+d0Izv8hvHh2kh4Vq+lWI/7YNzFg5oHJG//5uBPxmFQ3FSy3/Txb79sZxQszwNAbBuNjX+oxabgW98N0k95idAsUqzqNdtewwXIkdi9+Qec+eknTJG8mdJE+/ZfxEqhoi5+VPh2jMtMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580546; c=relaxed/simple;
	bh=4yE8s5Gg/D7Mg1mfXzs4xFsiwPIVCKqduCQJUZDhtGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X55WGadUGtQe2l6Whc9K7dDlu9xddoaEhQjRZENOzGRvd4CvffTdVUQVtqZjGz6+LLRhDG50tD2fpVD378Gt728+ThLgQITlMsFN9OpOyD7RpX02AR6A2AdkQEFcc1uuh5VdE7XjUUa27W0rRPUhnH+0Uyz5a4Nb+HNdpzqGhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UtB/SN+6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314f38d274so72280835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729580543; x=1730185343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo0xOmZ3bF1XOgnsXVyn+rFyT/PuDvUbKaYAetJa4ms=;
        b=UtB/SN+6Aqhrz6c63vBySYEAqogw7sBk/gBj9MhWxQofZXnmprhmpdzI0mUp1eJpk5
         c1C22idsUoMAt++oxTy3kFXXuz9q3dmomzII2e3ad4FJ90boRX++XCRf8pd49uEc/mjR
         8FycVbZY9OTtwe7FkD3sLAFbChmiz7mZOad8+53NRP/1CzOt7V9DpSV9+fdjHRYalu6c
         q/9l55AoNBc67kgboiJv+kRjLaeWnccllyBQYfihWBc31rJ2j7OpTWwI4xV7ecgvpd4n
         2UcdWBYZ3n+g3NOV9F8QfXhAT7s6O3OJLlL9Zfxg9y/DjN0/PUkY+RNFgCckgF5lAI3t
         yFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729580543; x=1730185343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo0xOmZ3bF1XOgnsXVyn+rFyT/PuDvUbKaYAetJa4ms=;
        b=HxcNF9EBSHZLLThdsjABXUfMOSiOUGZOLm+gKrpkhCQZFDWhKa6g6w9CcKLtXyb9Jg
         fmkmbdUiq2tWEMLo/1DDUXCLQ/XT65xebsN0OTQe6TTHcVM845x0aXayfPolj12Qugtt
         qI+OZUUn2slMQInevM4+TKU0GwOUrLOZPMLSm/NamXAi27OAsNWhqBi5NE0rEebv7eyO
         Y3OFlzQ/4FaLqMdYkrV3Wl1cVDdDX4/Oc8PsX33YZ9FL6A415FgG1cf8SrSwpWRci7Ap
         OJZW23kfUlBjU4xYxDqnvBr31tE1ZTdoEhN+DdP0jOTrSb0T7j3Y+v6GhF/LjFz1+gec
         qdBw==
X-Forwarded-Encrypted: i=1; AJvYcCWUCRUeQiIviM9tYV9Q2By2XwwDJrSfRXosHlVTrFyfRaR0aRlF+sb+vtFVRVsM5LjyImjQSgPHQpYGsbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcujqCM8u2JuvOyxCHN/XU6rde2eklnzFfxzUuoa8gWnyG1reG
	o53t8RdlXOp8vK18yALYaB+C9Tez5FrzKSqrX6RVPKfc+r+WkFWkoK76V5NtvFw=
X-Google-Smtp-Source: AGHT+IEb/90ZLK03pt7rWCnU1U7KPmd5ONg5GXEb+jncfPIGAWGKj/2uCiifR3O1/uN1UB+cMvzzSA==
X-Received: by 2002:a5d:4e0e:0:b0:37d:61aa:67de with SMTP id ffacd0b85a97d-37eab7555a4mr11958766f8f.42.1729580542648;
        Tue, 22 Oct 2024 00:02:22 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93f92sm5881454f8f.76.2024.10.22.00.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:02:22 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:02:20 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Johan Hovold <johan@kernel.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add Parade PS8830 Type-C
 retimer bindings
Message-ID: <ZxdN/Kr5ej2YFv9T@linaro.org>
References: <20241004-x1e80100-ps8830-v2-0-5cd8008c8c40@linaro.org>
 <20241004-x1e80100-ps8830-v2-1-5cd8008c8c40@linaro.org>
 <657a2qb727tm5ndz2wokxb5aiyqysppufm7evtwfbplu34yzmp@mlm4k775zm7a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657a2qb727tm5ndz2wokxb5aiyqysppufm7evtwfbplu34yzmp@mlm4k775zm7a>

On 24-10-06 18:28:52, Dmitry Baryshkov wrote:
> On Fri, Oct 04, 2024 at 04:57:37PM GMT, Abel Vesa wrote:
> > Document bindings for the Parade PS8830 Type-C retimer. This retimer is
> > currently found on all boards featuring Qualcomm Snapdragon X Elite SoCs
> > and it is needed to provide altmode muxing between DP and USB, but also
> > connector orientation handling between.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  .../devicetree/bindings/usb/parade,ps8830.yaml     | 129 +++++++++++++++++++++
> >  1 file changed, 129 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..f6721d6eee26c6d4590a12c19791b3d47a8145f3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
> > @@ -0,0 +1,129 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/parade,ps8830.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Parade PS8830 USB and DisplayPort Retimer
> > +
> > +maintainers:
> > +  - Abel Vesa <abel.vesa@linaro.org>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - parade,ps8830
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: XO Clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: xo
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: power supply (1.07V)
> > +
> > +  vdd33-supply:
> > +    description: power supply (3.3V)
> > +
> > +  vdd33-cap-supply:
> > +    description: power supply (3.3V)
> > +
> > +  vddar-supply:
> > +    description: power supply (1.07V)
> > +
> > +  vddat-supply:
> > +    description: power supply (1.07V)
> 
> Any additional details?

Documentation doesn't say anything more than this.

> 
> > +
> > +  vddio-supply:
> > +    description: power supply (1.2V or 1.8V)
> > +
> > +  orientation-switch: true
> > +  retimer-switch: true
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Super Speed (SS) Output endpoint to the Type-C connector
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        description: Super Speed (SS) Input endpoint from the Super-Speed PHY
> 
> or from another SS signal source, which can be a mux, a switch or
> anything else. I'd say, just 'Input Super Speed (SS)'

Will use that.

> 
> > +        unevaluatedProperties: false
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Sideband Use (SBU) AUX lines endpoint to the Type-C connector for the purpose of
> > +          handling altmode muxing and orientation switching.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - $ref: usb-switch.yaml#
> > +
> > +additionalProperties: false
> > +
> 
> -- 
> With best wishes
> Dmitry

