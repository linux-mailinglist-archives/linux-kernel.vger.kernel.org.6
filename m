Return-Path: <linux-kernel+bounces-382387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F009B0D15
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695801C2279E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CF18DF91;
	Fri, 25 Oct 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjcxmZ1Z"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27D18BC0E;
	Fri, 25 Oct 2024 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880560; cv=none; b=efbzicnPWGs6WzzvthtcV1tomrqTM8G7T9/B84j5PZXXvVlAb5wU+JK2vYCfTIb2SFRD/UKhJheYDVrfHqCa/NxJELjWVkDEJQ5DNLgw4pUz8zW5YqGCaMKsyAMudVAP/wYy142JFv3DkiQYNfXcXZw5tH1FI/yh3+KDprZsyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880560; c=relaxed/simple;
	bh=/OBP+eHB23x72DLaO+CERFVjaZx2M1cz+29AbwRyQHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD8wELkQzf3ODx9HzPJG2M0z6iLYBACT0/NN5PGK04Z2dTdfrIC9h3zb4BPrtiGShWiPC/XKYuZwvCOIDYt2hgVgqWxT5tLaa/L2Zqgflr/UD814vGe1kEQznere50Lln4pwSwDaxSgzXHhUwWtlNXK5z+bNkjwS5nU/10N8NUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjcxmZ1Z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdbe608b3so18915945ad.1;
        Fri, 25 Oct 2024 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729880558; x=1730485358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdZgAeQbXwDS7g4GyXvG4yiWM59tpYiPm04+9PqDW4I=;
        b=gjcxmZ1ZcSSWo4b/CViiUE1d7N7H1lbzGVXRsZ8QQ5kbrsDntlsbnEI6jQpl3qbN3v
         WJD1Hwen34j9HKWS/KUa29/XGLDYmzw5e/L0eE5ZinXoUJRf7zlOrWVUMqogCvnHDcym
         Vl85mLIqhzPUukL4hZOJp0BTg2kZXcgmASLCz+55of15ta7j4NVNBa61JyoqFLclDSoY
         tAOnADhDj3d+PUJ8COtCVB7Yh8LEJjFJuL7P8/DR0Co57MeFuv4peCCTsG7ko5vYeP3S
         BUNCJjLUzb7TgtcnUP3US7h5kypxcRNOBH+5GHO6nZjfdxGDeIPWSQJOX7oovvXdPrEu
         PY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880558; x=1730485358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdZgAeQbXwDS7g4GyXvG4yiWM59tpYiPm04+9PqDW4I=;
        b=a/m/2ioHQgrgsCdEg7BPtw39OsdAqN6zQglAW9QqF1cFdgRRVjoHoq2A/lNmVcFiZe
         KEkqPU2t8wpvsQ8BvYtHZ4zoOooyY2t7oSniGL4DTOp5nClrDFcQw52VnV0y+2ow3fT6
         8gG1ZuzoWOumAnm011/EZfRVKnuyyRGmyJw9fAYWkRF5gCGMW7E1o94PB9nzF598hOOE
         7xiIJN41dKQbvIDr0VPsc+sqgoM1uAuLoo0GDSLjThyA5U/SpGJ8oOnpGKV8Bm+1puK2
         YFeaXU1dOtOQAtkZENGxRc38du4d8v0ZsOBv1dGaR1epZbP7c50W3peNIv7KF+3Exf6i
         FLGA==
X-Forwarded-Encrypted: i=1; AJvYcCU+vfiaIqVHUVC/han6BGjfsaEOuJrchn1j0HgjoBZIdkJUjxCO1C1d6Sz+dRe99pF7m0LlAVtLFsSb@vger.kernel.org, AJvYcCXWeQmS49tX3nDjZgMgJhFMc2uBdycIYReMe58s8H2akhQLMdTctPb/Nr05qvUgYdHkOtra6vKrOuary0+6@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKxqCGg2DIeslFFfjKZyyd+edDWVioV6CUYcEF5xWfQmkrJzC
	lkDbuWf1x21Q2TZJcOEY7LFWkSvHFSnkc+u7D5RMFT16d0cmzoi9
X-Google-Smtp-Source: AGHT+IECgj/DRT4MIRpjfxiNTH0AcYMnjzisn+25RaTmGnxcNSh6nxoiQDFDrmRc5aFmXn9tiE4VBQ==
X-Received: by 2002:a17:902:e951:b0:20b:6458:ec83 with SMTP id d9443c01a7336-210c686c57fmr1051845ad.4.1729880557787;
        Fri, 25 Oct 2024 11:22:37 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:f151:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc043d13sm12038805ad.233.2024.10.25.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 11:22:37 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:22:28 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, 
	Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2] dt-bindings: soc: bcm: Convert
 raspberrypi,bcm2835-power to Dt schema
Message-ID: <zaqykppssizdpd2mynpoatp4smbzkr7atuurxkkegbegk5dw6s@a2daqovt2aod>
References: <20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com>
 <lfzxcilud65ype66frb7eihq2hvranzxp6fomjvjyxvciiixlj@2efv5266wt5r>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lfzxcilud65ype66frb7eihq2hvranzxp6fomjvjyxvciiixlj@2efv5266wt5r>

On Wed, Oct 23, 2024 at 09:12:53AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Oct 22, 2024 at 06:17:03PM +0000, Karan Sanghavi wrote:
> > Convert the raspberrypi,bcm2835-power binding to Dt schema
> > 
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > ---
> > Changes in v2:
> > - Added original file maintainers
> > - Removed unnecessary headers from example and formating from description 
> > - Link to v1: https://lore.kernel.org/r/20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com
> > ---
> 
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/bcm/raspberrypi,bcm2835-power.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom BCM2835 power domain driver
> 
> Drop "driver"
> 
> > +
> > +maintainers:
> > +  - Alexander Aring <alex.aring@gmail.com>
> > +  - Eric Anholt <eric@anholt.net>
> > +
> > +description:
> > +  The Raspberry Pi power domain driver manages power for various subsystems
> 
> Drop "driver"
> 
> > +  in the Raspberry Pi BCM2835 SoC.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - raspberrypi,bcm2835-power
> > +
> > +  firmware:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> 
> phandle to what? Missing description.
> 
> > +
> > +  '#power-domain-cells':
> 
> Use consistent quotes, either ' or ".
> 
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - firmware
> > +  - "#power-domain-cells"
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    power: power {
> 
> Drop label. Node name: power-controller
> 
> I don't think this passes tests because of this. See power-domain.yaml
> schema.
>

Below code is from bcm2711-rpi-4-b.dts decompiled from the dtb file.

firmware {
         compatible = "raspberrypi,bcm2835-firmware\0simple-mfd";
         mboxes = <0x1d>;
         phandle = <0x1e>;
        ...
};

power {
         compatible = "raspberrypi,bcm2835-power";
         firmware = <0x1e>;
         #power-domain-cells = <0x01>;
         phandle = <0x0b>;
};

I had a doubt that as above the raspberrypi,bcm2835-power compatible node
is defined with power keyword, so should I still rename the node as
power-controll or keep it has power?

Also it does passes the dt_binding_check and CHECK_DTBS=y broadcom/bcm2711-rpi-4-b.dtb
but does gives the message as
soc: power: 'ranges' is a required property
so do I need to add the range property here?

> Best regards,
> Krzysztof
> 

