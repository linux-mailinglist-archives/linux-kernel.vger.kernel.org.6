Return-Path: <linux-kernel+bounces-425830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2FF9DEB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D051B21C08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463E155CA5;
	Fri, 29 Nov 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bDOwkwrp"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486B155391
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900285; cv=none; b=RYq9HTwNuYrIqRvjDiYE/druOvMAKqpvwc+mN2aIWXcbGqvoJTf/gyxrvKO1S4cF3aOpvI82Xa6ZGCqxvG7vOmHbMS5bWHkjvvpBn6g+K0JlB13fnULt3h0HZWkaTD7fkPQ8te9tdNepYHHZjlwoHutHHVqE4BTm6Fvd/dESV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900285; c=relaxed/simple;
	bh=u4VeqDNvTWRAhnRMPvx5ZxHgDaIe1hpfxIJoqfWrVgE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnQGshmNccKuX8V3SoQXakPV3+tJZN2yzuHEtdS7qjqyoHYcPXf3ggz0iP8THDsxTJwNACG28HMY5nRry+IFW7aGDOlRuWBbrYFAOGK4Maw652TumXvWLrIfsQDoRGlX8MyR6IxGCaDm2cIzJE8k6S3WBwel6NLyZ90Zn8PEVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bDOwkwrp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53df80eeeedso2134694e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732900281; x=1733505081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKStJ4JMYm6/f7jAdkMonmjOHy/XStYH3AHNh9QPw+k=;
        b=bDOwkwrp57+hdJuQM2yuTXFuR2uJQz4KquU51t8PIHqO8eQiDyD9aQNlzcorNorPaT
         xp7YOLadRHiHqNeLg9IJY6J/ulFR/j/syM1NdPODXmEbzVOl5mUR/WOlAKf2q/W7pRWF
         OVISodhH2VoKdzyWp6LX1fXe+h47Uvf/jzI/K4qJMK0C/xvuS5ytvS7xf5oYa3VTLyd7
         VWtiSLzoTH2KjPpjC534rVGaPgyoky1fRIlQrXwp05orw95J08DpqUP7G6xtWuVpeMBw
         wDC8XOyxR1Qfs1jSuK0KTWCb5rsWjIdgrxuwVXnYBHN2hXoRrC0USPiYqn3iDJLpFYf4
         VHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732900281; x=1733505081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKStJ4JMYm6/f7jAdkMonmjOHy/XStYH3AHNh9QPw+k=;
        b=CUzPTUb0Bba8dCClJFadIHEPCb5e3UzSdlrxmTZjtD0+2hEEpvUygyZSFjSdE1wuGQ
         JGg1v0cIPv6SepWW8CJ6aj3Myz6yHsrQxmyatxH3KubTtm/aJya5x6RS9ZZTpNnWfztV
         To65szmDpKDRY5w2p0xBZyCDeacFjOyAlDeg5sBbrD1uHalAO17BbtPjYWDqV9X+wirl
         HBgyg8PlifmUneiNEs2p5O7aFS2pCFJXcNnEqtczi7Ck8PGjKWKkOoJKkHn0Xp0jc28b
         mPcYuPt97f93ux8YeYa5zUkyvRHHFyG4pHHSAu3KphdHIvcJUWgx18ZMcMSjV/8RYuSW
         8iqw==
X-Forwarded-Encrypted: i=1; AJvYcCXGIhibmpmRXZnZLIPeXlV3UR0Hl4vkLkTnqkHn9SiFvbqPW9SQYx/r92NvZZejcZ6S0kczko/wcJ+THHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSEU1hE1klkSwDqr7vrE9xriAX1muCt7r+3Kui9DS0xynJmjX
	ReGwAIzT5ZBn8IhzSEZZa9L5itWyY/CmATJtzfjieZIIxLFoMRkOoSJf9PoES/k=
X-Gm-Gg: ASbGncvH5DUdPyTfTU5mwdnEbOkNHSIMHFgpRQJpFfjS2DX3LLUvtB+FFKkdXmBZZao
	dPDCOqI/ARI7l6CT4ePzikCZZl32SskcuvZbs5qiuV5jZprVUgRraLd/K/WxOXbAYMz96y2l1rP
	Qurthl0TRhoIiczfrlYS5xfoqzjZzhUHRfbjI5+c191aUSSNkgExDEqxVXpBIK7ivgvg1di1LgQ
	9GOrp26ufiV22b8QjXDIfu+g94n3dlz2c0pJtIPTbDqp8ybpqykSlel7ICF6hLnhRj0fZGh7kj+
	XsAcQ1O7rVLnI+8xGtBD
X-Google-Smtp-Source: AGHT+IHZ3oTCh7gVSsmHhrZ3fiOp7cXkhyrNMHuydkCIk2tz2qxDfVIno+QP7oK2bTxacMEqt16MJg==
X-Received: by 2002:a05:6512:39d2:b0:53d:ec9a:138f with SMTP id 2adb3069b0e04-53df0112687mr8431697e87.57.1732900280754;
        Fri, 29 Nov 2024 09:11:20 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e63a2sm192130166b.113.2024.11.29.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 09:11:20 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 29 Nov 2024 18:11:53 +0100
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 02/10] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <Z0n12a6irbXQomdD@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <9b83c5ee8345e4fe26e942f343305fdddc01c59f.1732444746.git.andrea.porta@suse.com>
 <4ufubysv62v7aq53qfzxmup5agmqypdvemd24vm6eentph46qq@3kveluud3zd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ufubysv62v7aq53qfzxmup5agmqypdvemd24vm6eentph46qq@3kveluud3zd3>

Hi Krzysztof,

On 08:55 Wed 27 Nov     , Krzysztof Kozlowski wrote:
> On Sun, Nov 24, 2024 at 11:51:39AM +0100, Andrea della Porta wrote:
> > +  '#interrupt-cells':
> > +    description:
> > +      Specifies the Bank number [0, 1, 2] and Flags as defined in
> > +      include/dt-bindings/interrupt-controller/irq.h.
> > +    const: 2
> > +
> > +  interrupt-controller: true
> > +
> > +patternProperties:
> > +  "-state$":
> > +    oneOf:
> > +      - $ref: "#/$defs/raspberrypi-rp1-state"
> > +      - patternProperties:
> > +          "-pins$":
> > +            $ref: "#/$defs/raspberrypi-rp1-state"
> > +        additionalProperties: false
> > +
> > +$defs:
> > +  raspberrypi-rp1-state:
> > +    allOf:
> > +      - $ref: pincfg-node.yaml#
> > +      - $ref: pinmux-node.yaml#
> > +
> > +    description:
> > +      Pin controller client devices use pin configuration subnodes (children
> > +      and grandchildren) for desired pin configuration.
> > +      Client device subnodes use below standard properties.
> > +
> > +    properties:
> > +      pins:
> > +        description:
> > +          List of gpio pins affected by the properties specified in this
> > +          subnode.
> > +        items:
> > +          pattern: "^gpio([0-9]|[1-5][0-9])$"
> 
> You have 54 GPIOs, so up to 53.

Ack.

> 
> Use also consistent quotes, either ' or ".

Ack.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Many thanks,
Andrea

> 
> Best regards,
> Krzysztof
> 

