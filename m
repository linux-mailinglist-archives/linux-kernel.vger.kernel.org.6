Return-Path: <linux-kernel+bounces-420672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE89D81FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289E1162696
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C46819007D;
	Mon, 25 Nov 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="egyou7Fb"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C10118FDC5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526078; cv=none; b=Fu14UGdL8l31Tc4cztYLWGGAHoQ4sYwH6ctTQPPnuat8Rcz2SwLCTTARJnVlFzd51ELgM1CJFDaGW5ZJy0F5sJRgPbHQNib64yGRpMubsPHgHLo+vMie3WcT+npwfXKbrDmM45PIp3z4DX9hedfmddxeGG0pfRjtrgvK2N+MB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526078; c=relaxed/simple;
	bh=Z8jQntIYUuDqbpeg8tuOdkkbLTKTkbcIxwmwmqoh6r4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyZ6nP8XfdoDcUdfBTBUu2if9GzZzBv22JPqii3KVmBizgQpzmh3ZFnhXE2XsVGWkcpqG3gEZhLCwjguuvVaT58lkCe8qTHDHdSWQYSU70uU90IE2dXw+WEhSwLmiY0cZLFcf1gHq1Yy7u7Knl3VZY5GoEnZOBQTVCAtXIlxmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=egyou7Fb; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso1626876e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732526074; x=1733130874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4toVw0A5ZDZA3zYjFx66d73EEMSNS7vgXv0fs9opgvU=;
        b=egyou7FbZgoU65bgdaRjf1eCy/5jmzFx13LzbEqle316n8PfA/yMdqI6isae75c9EA
         xXunXPa91zFfjxs8TvCxv7s/RrKGDYz8kT+Mu4PJN1Ginx2/YsHVSba9kVN+lofpDXMl
         tM2lBwdu2Fv+yZHnqLIrLGVKq2WgECP4dHz70Xtr7L4Tn79gZZdrFq/XkxtgNZU8ezuf
         eVeEbj4RQS6ASlsj4jnYkWxAoeIrUuXbjCo7ZyfL7BVGlZvamjJdrjxwongjYy4QeJVo
         f6CnBcG2KbCsUhCSVMGPI426DxSUC22xW0ArYV14V1DD9XTc1yPDsIHHTSOi8BYkXBY5
         fxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526074; x=1733130874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4toVw0A5ZDZA3zYjFx66d73EEMSNS7vgXv0fs9opgvU=;
        b=GLbpgyiVY3DrTWByH0Q45XMrjoiDnw2X9pNLs/+B7Lrm5LrDwD3w1SGT0tW/hRIU7m
         W/awTux66eOC5RBd9mjLEnBhbriWcWKW6lUEAenflLBHqDJOUyNJParmqEXZRqUVRFAM
         KgvCCJzKj3Px7dXzSmoqkPLcThe0rWRQt2+uG9aJwCL3q1UNqd/GMESnwBNE1zH28y6e
         b304oOYOuEIc3cb9/5KeHBenH7egyzQAIJkyZ5dQU3xv6sZtfWLgngx7JP307pePlnrZ
         GB6YXEt6w2JrFfLZN/doH8iNlBQU5uZSDJnq9SUlxtn7iiAtpPnAZArCZcuGbFX3g3wL
         B5gg==
X-Forwarded-Encrypted: i=1; AJvYcCXUKbPia6D4w3nqslKy4q80JP5vMXKj+BQPsP6I0Y/0YQDfGyCP1D6g8bjAUqmk6SbD7LHZ56/WSw/daNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cXqwKx7e7y31GpCisk3bfzzN97VMmXSRZYM0fvHXrZUlL9zj
	7YJLdmb6o6hzcbHe5amDJC/nkJM3obxfJghqnBR6l+Hq6iA/eB1wdMQVIZetD18=
X-Gm-Gg: ASbGncspVcHoJE2TmmtPssyHREEV6iW1H+E3gnMBfgZUSteSRGvzqXXAkGvm3CRGj+R
	RwaizC5m5CuDQR5fDHaCjdMMc790bbtYvcPMQvtsI8CA/duPHfS0GiTnZRMsqfd9pbMzBLdzcwr
	bg2e7alVUA1PAntaHumMgWmrzL44WiPQ54kfAI/SmUFILoYovcxDjg+PzPgdoeDNQaOS6uryuAX
	YCkXVSDC/0ahVm5FE20HfiPw5Dj90O5z/InTgaSdODM5OoZWOYmUHQe1akXpKcHK/gT1DDpNOdC
	ltO9+fvA6Ngdk6RgSgq/
X-Google-Smtp-Source: AGHT+IGzMekzBQYfXvbzxD9izRI1CL/rjOOOx/NwOujkSDTMSARyoXxxyDmvBO3p/5f/oLabAnZ/QA==
X-Received: by 2002:ac2:4e0c:0:b0:53d:dc0e:4da0 with SMTP id 2adb3069b0e04-53ddc0e56e9mr2499509e87.15.1732526074368;
        Mon, 25 Nov 2024 01:14:34 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa524615e8fsm363089966b.182.2024.11.25.01.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 01:14:34 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 25 Nov 2024 10:15:06 +0100
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Dragan Cvetic <dragan.cvetic@amd.com>, linux-gpio@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	Derek Kiernan <derek.kiernan@amd.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-arm-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Wilczynski <kw@linux.com>
Subject: Re: [PATCH v4 04/10] dt-bindings: misc: Add device specific bindings
 for RaspberryPi RP1
Message-ID: <Z0RAGkBc-yz5lqN6@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <ebb21da5cb41391421b364815705be8b4c415f8a.1732444746.git.andrea.porta@suse.com>
 <173250040873.6640.9720381303445148722.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173250040873.6640.9720381303445148722.robh@kernel.org>

Hi Rob,

On 20:06 Sun 24 Nov     , Rob Herring (Arm) wrote:
> 
> On Sun, 24 Nov 2024 11:51:41 +0100, Andrea della Porta wrote:
> > The RP1 is a MFD that exposes its peripherals through PCI BARs. This
> > schema is intended as minimal support for the clock generator and
> > gpio controller peripherals which are accessible through BAR1.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  .../devicetree/bindings/misc/pci1de4,1.yaml   | 74 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/pci1de4,1.example.dtb: clocks@c040018000: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ebb21da5cb41391421b364815705be8b4c415f8a.1732444746.git.andrea.porta@suse.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Sorry about that, but even if I see that this should be the case (I've dropped
the clock-name property from raspberrypi,rp1-clock.yaml), I can't reproduce it
with:

# make W=1 dt_binding_check DT_SCHEMA_FILES=pci1de4,1.yaml

and the output is:

  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/misc/pci1de4,1.example.dts
  DTC [C] Documentation/devicetree/bindings/misc/pci1de4,1.example.dtb

dt-schema seems up to date. Is my command line correct?

Many thanks,
Andrea


