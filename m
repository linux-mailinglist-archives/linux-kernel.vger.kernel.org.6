Return-Path: <linux-kernel+bounces-553968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04CA59145
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EF93A6405
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50D722688C;
	Mon, 10 Mar 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeJGNqZb"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F428EA;
	Mon, 10 Mar 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602828; cv=none; b=em7Gxm9NT5yp6iJqUIB/gaRugccz7+EJXppEEM9C9ty60Ubg0BnOx9U4n1GgYmxLs83uYVborpqDEgr48FNOSb9VZ5sANU3i+d1Irf31Swi9msO8LmqkKrPgFO4o9Wh10zMKEPY55fq40RcnUefH+KexC3fydArnWIb2xRLCSAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602828; c=relaxed/simple;
	bh=ahaHl2BOI5agTSk3/eyDZZm6SXATEKEPbXPRLvyRAJE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5y1jxveng6q3LM+UlGPNpQdSLS9lGcF2VXp8s9axTGSUmFYbVbi/W+X4JrX9tSqblW94OqOVVziQYthel19wzAy2xLizY15SA+k6VXIHmPWe9i4UO2Gtbdi0DHLoCr1+bIFj01IfWvsTmkS8/r8Bz3GEkBc3ejKNqbBDTxl/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeJGNqZb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so107495866b.1;
        Mon, 10 Mar 2025 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741602824; x=1742207624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MGTml7RpCjpVWP8eom9oAacKLsbRqPW94SvzBXitgHg=;
        b=MeJGNqZbciP5JWbexu5OAMaStqvDt2jj0x9d2KIy5HePjxo1MOgHp7kYNQDV0mcQAe
         pk5qsrwn7X3MXePo5oHXrtbT0AEUC+JkFpebwAH/Q7iBefY0Sou0KzPIoU35ADe5K0DG
         lTBU8ZMmZZPbcSGREv5mMmpO++13fCKzCnxvUKwNVb/5SucGEixtR/Um5HRRrrBqZMCK
         UU9t+fb2IR62zs5Co0HpW3hGtJ5B+KblzTcdM+0uaOBhQxcWJQNM3dBUsfuaoYRi5SEP
         2H0+xhXH1p7Bu4FROHrvZlWrVZ4n/THADmhVSsLgd0wM4xN0sV9qecbuO8pOc6RBein9
         GzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741602824; x=1742207624;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGTml7RpCjpVWP8eom9oAacKLsbRqPW94SvzBXitgHg=;
        b=kbTSMHGjp0AAZMnRj08xMVVM+Oga++fG7JvPeiWqFkwKZlZoYZEGWlDIRBOk9uebV8
         MWI6C6pxkS5dtjzCE+5LakekCu2lAft2TQFaxz8QgdjMgcl/90mpnZVBWtOcUyZf6dPn
         CCOd+dibCh0cXpFjJ4WQFN4ZshdN2FEpktzGCWy97XoTFp7D8pty9T89LAvzuMSIXBZW
         A/P4hrSeTy7tU7IHVXSQMcS8uuzQrMnFuXYL5gmGuInWKMwrcMh4v+fM8JPSUXeDCTyj
         TqY477TelzeQEUN9QaAbNV/49A0GSJO1+g034zsyWZ3rZ1LTsDjcXAb7rYREJw5ZoBHc
         iL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaNgy/DSuysEZhdJ07JBuIRjzxGrcLZKiPkhc+2NySmlKFDstGBZazYmxEYALN6evKcUeEnuC7dppyHFUO@vger.kernel.org, AJvYcCWMbapWUxrMhPzJahL0ZIktyVVExd4DATaHhgV7uRJVzrlPy3daZO6mH9pywUWXrLL/oe9RR3Oxvde7@vger.kernel.org, AJvYcCWcxQQ4qKS2hAWF3wexF/NG7hHwJReMq/q4I5YbsxHvngSdexVCmUvde06LIIpZYtKhobS1Zzq/VCV/@vger.kernel.org, AJvYcCWucYymK8hUKRIbMI+A1yrN8Afp3bvwWXSiDI9yseSc7j18gUzGLuMepr4i3l50mOOSRZWK9fZ31/eS@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNPWcm7scppGPXmD6A9WQUP4JVzI+t1C7kRCYJRqsoNB6jCr6
	e9R6i/yCyow1UWU+OIC4y2JfdS+2oakn2P/fJxFwE3JoHfakm6OP
X-Gm-Gg: ASbGnctjSthzGTxQ/TtyLr9sZvH0cirm/H/rnqp+B7Dv5srdiBqrPG3oZUdNVAPZe1d
	PWpJPjBFWqV3TUS27Dcjhro5bWxPq5lLTGJx0kZPkyKxvIaXvtjRz3N5ysIwYBYg8vIl8OUW7xx
	a9VqnNDxcJMbh8CpPrlVekUCq6FJ6HBrL5i/dhfRcA4dcgc8FklL0W3hUsTVoaxTn0u0CN/5g8X
	a+vE17oB4RNVRi4Hd7T1aqoKE30hLBbVXFgt2/QCqNKBh/9aWDLvVSsgGGOU+7jD8U9sQtfpOtc
	iN0EtT0Z3lJFF97pJtpbf8oHsRqA/l3+P5Bj1NManw==
X-Google-Smtp-Source: AGHT+IEWMSU1qAY2ggbAzuaICqttRpwRQzqd5Fp6/64RTbush8Y1vjOdi5AqZxhsuRglYeOy1RqUkg==
X-Received: by 2002:a17:906:9586:b0:abf:56e3:e899 with SMTP id a640c23a62f3a-ac252f8d705mr1216793066b.40.1741602824270;
        Mon, 10 Mar 2025 03:33:44 -0700 (PDT)
Received: from Ansuel-XPS. ([85.119.46.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2397363b7sm736352266b.121.2025.03.10.03.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:33:43 -0700 (PDT)
Message-ID: <67cec007.170a0220.37245a.99cd@mx.google.com>
X-Google-Original-Message-ID: <Z87ABZwgZPU2P5-X@Ansuel-XPS.>
Date: Mon, 10 Mar 2025 11:33:41 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 04/13] dt-bindings: soc: airoha: add Documentation for
 Airoha AN7581 SCU SSR
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-5-ansuelsmth@gmail.com>
 <20250310-aromatic-chihuahua-of-priority-4ee73b@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-aromatic-chihuahua-of-priority-4ee73b@krzk-bin>

On Mon, Mar 10, 2025 at 09:00:40AM +0100, Krzysztof Kozlowski wrote:
> On Sun, Mar 09, 2025 at 02:29:35PM +0100, Christian Marangi wrote:
> > The Airoha AN7581 SoC have in the SCU register space particular
> > address that control how some peripheral are configured.
> > 
> > These are toggeled in the System Status Register and are used to
> > toggle Serdes port for USB 3.0 mode or HSGMII, USB 3.0 mode or PCIe2
> > or setup port for PCIe mode or Ethrnet mode (HSGMII/USXGMII).
> > 
> > Modes are mutually exclusive and selecting one mode cause the
> > other feature to not work (example a mode in USB 3.0 cause PCIe
> > port 2 to not work) This depends also on what is physically
> > connected to the Hardware and needs to correctly reflect the
> > System Status Register bits.
> > 
> > Special care is needed for PCIe port 0 in 2 line mode that
> > requires both WiFi1 and WiFi2 Serdes port set to PCIe0 2 Line
> > mode.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../soc/airoha/airoha,an7581-scu-ssr.yaml     | 106 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 107 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml b/Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
> > new file mode 100644
> > index 000000000000..4bbf6e3b79a4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
> > @@ -0,0 +1,106 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/airoha/airoha,an7581-scu-ssr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha AN7581 SCU System Status Register
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description: >
> > +  The Airoha AN7581 SoC have in the SCU register space particular
> > +  address that control how some peripheral are configured.
> > +
> > +  These are toggeled in the System Status Register and are used to
> > +  toggle Serdes port for USB 3.0 mode or HSGMII, USB 3.0 mode or PCIe2
> > +  or setup port for PCIe mode or Ethrnet mode (HSGMII/USXGMII).
> 
> typo, Ethernet
> 
> > +
> > +  Modes are mutually exclusive and selecting one mode cause the
> > +  other feature to not work (example a mode in USB 3.0 cause PCIe
> > +  port 2 to not work) This depends also on what is physically
> > +  connected to the Hardware and needs to correctly reflect the
> > +  System Status Register bits.
> > +
> > +  Special care is needed for PCIe port 0 in 2 line mode that
> > +  requires both WiFi1 and WiFi2 Serdes port set to PCIe0 2 Line
> > +  mode.
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,an7581-scu-ssr
> 
> That's not a separate device, but part of the SCU.
>

More comments on this in the MFD patch.

> But more important - such definition of choice of serial engines is
> really not flexible, not reabable and not helping integrating into DTS.
> Are you going to grow this for next chip airoha,serdes-wifi20, then
> airoha,serdes-wifi21, 22... ? And then how the if:then: would look like?
> 
> Assuming you do not have here child-parent relationship, like usually
> for serial engines, so then this should be somehow list of devices
> (strings) you want to run.
> 

You are right, string is more flexible and I don't need the include
file.

-- 
	Ansuel

