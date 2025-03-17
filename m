Return-Path: <linux-kernel+bounces-563924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B6A64A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8291189256A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B12376FF;
	Mon, 17 Mar 2025 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5Xfnf3C"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F723315F;
	Mon, 17 Mar 2025 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207974; cv=none; b=n9buwfptBlQDdf7krYzSUSh/haZEXm8YmTBOpxv5e1NEqzIl8RtFfiuelsGTORH9c/p0/faAz8viSCJfovScbtfI3y1QIGDDosMjOPkAZQ8PYDfUuDhh2aGc53/QSR2O3FezRcdveroYc4TefJ4XrT9VXGdKKmPEriUyf3OO7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207974; c=relaxed/simple;
	bh=TfpfaeLI4S6m1v+uddZe93RivyyarsvruxbycvEgKas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhivIXWcQZHmonM4dJb1FoHsDICirEW4n4a/92KemCgzk9s3/Ezn4NqrXdVP3iS9UY2hrFkbz15gv+GDtgB2ofwm5UbJACPDan6Y2dJ9+za8NQRfidZx0M7AO1CKLx3KUh7pbz5IYhnp2Uija5Y2aA34PJVcX9yHb4Pn+dJq+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5Xfnf3C; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so3872350276.3;
        Mon, 17 Mar 2025 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742207972; x=1742812772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IoGBlbe9Czmc/JKLBj0F16RNsymqq1dJ1tqyI1v1Ytg=;
        b=a5Xfnf3Ciqz7oqMk15UVEWLqMLB/mSoOu+Rd0RHYnuJ1LV6glpYu0flheE9LAERkaV
         HtNA3Da5wCrtTEsI3IlHW1Fo6g1VkgXlRxoktTpTIUtbQ6u84Cr5LoZz4l/+OE9wyUz1
         cqvdsXJjKkPunL6ajUNDrSqhvJEi66dFmQPtsAJd4ygSFOuqrY7yhaD7jg1ezvfRv5GP
         HPYKLarBQIssxTecEjRCEhTIPjWwPyUt2IlZJ3YPm48zqMdE+iOlftIliRrcRT7pwJCI
         DPYCnSodApaHcgSJxGfXU+02s1xbHR0FjNiaP7Q9D9mgV5afhj7U9/hUk0xaFupBA7w0
         vniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207972; x=1742812772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoGBlbe9Czmc/JKLBj0F16RNsymqq1dJ1tqyI1v1Ytg=;
        b=MWxDxcfcnaDk9Z0hFTnCU+OLqBNS8fIkKowmo0zY8i7AtaxFJIc09nEHn3/j3q3P8N
         fJHFQE9V1QYAJPuCfJCCN9ig1ZFCO2UnBHivOtic/A1zV/0q///vS1+dRdyPOVHx0uul
         4ZNBqAxc7rgJNkPqc9+gia4lQVJINPwlImHJ9DwftRrTI8vPkRqH5PMwqN569emACu+L
         csJ9pT7q/wb2JafNNWg5KibN78GQAQed1CyFcA30107bnXkDauCRPnR9n7OI6ebS6ibP
         9pDhhP+vDrQylXb9DUEcIL+g3keFB9yzi90zHX3JrU956qseEdGSLJoPAP7IXWzgEDGR
         CS4A==
X-Forwarded-Encrypted: i=1; AJvYcCX7eB2GKkKXS5JKu822lYBHhf4COcL5pBLgVx33+T9/Jf4tchqqBiVTuJjKGw/SnJbfoccIbk5sobmf@vger.kernel.org, AJvYcCXA4rsuV5a7nZ5alTWowKjvc6cBS+5VjR0JYwYZse4R3jQS7eVXg5qkEpH+WAy2Td45I0ARQXJCN+kBKAte@vger.kernel.org, AJvYcCXvFflsz4yAHJLcDj2vFxJCnoceR/ZQDB1MEQ7cuxuivGpqlr5t7C3ZgCDComyXsez+KCG3KVYVcKOG@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbnCQub/E6+6Rsxp/I4m2WlXiEXDDapjEsTk4kUdwz4URRP42
	snCmS/2scp2syUrsgES6bD4xx2KY6lku/gz6/oxQx5Ji6bQNPjvZAA6U7FK2LE8yCIdNbH5JAPS
	2nZMOqbQNxHFPBdcnq9mAPKvT9LM=
X-Gm-Gg: ASbGncsaybJhhl/VkOMjr0kMZw4D3MeRsuxcJEtZoz3649AUKSwYxgM/mJ/DrswtERR
	Y1ormk0ePRbf/rGPSMbTFKc6Dj+HTguZlTyqV6xkyUWUS1S198dBELHP6Bd4Z6e3EZ0jtkMFPVR
	CtnO7CZp8c5qvXXN1kN21xuGj0Occ=
X-Google-Smtp-Source: AGHT+IHy+RO89nDi9FmYtvf/yESHna7TilFKwweegOO/mX3S8jWkfc8ZcfeV/QYwVZlEKxwfn3Yq7ZH5aj8lCxwN4uE=
X-Received: by 2002:a05:6902:2191:b0:e61:1c18:3f36 with SMTP id
 3f1490d57ef6-e63f65e5ea6mr14903162276.44.1742207971658; Mon, 17 Mar 2025
 03:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912191038.981105-1-tmaimon77@gmail.com> <20240912191038.981105-3-tmaimon77@gmail.com>
 <536f5393-478c-4a50-b25f-180e221ef7a3@roeck-us.net>
In-Reply-To: <536f5393-478c-4a50-b25f-180e221ef7a3@roeck-us.net>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 17 Mar 2025 12:39:20 +0200
X-Gm-Features: AQ5f1Jq_X-0lZX7kkWxOU1PNLphKdtirYmAhXmqFll0JeXRXfeWOSuOpsLz0fxM
Message-ID: <CAP6Zq1ioebnqgJB1B8AqD9UtMZRy5CDT8+_dXF_aBZEjjj_B-A@mail.gmail.com>
Subject: Re: [PATCH v28 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
To: Guenter Roeck <linux@roeck-us.net>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, 
	joel@jms.id.au, venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Yes, of course, it works in real hardware.
The modification was made since the reset and clock share the same
register memory region.

To enable the clock change needs to be done in the device tree as
follows (we are planning to send these change patches soon):

diff -Naur a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
2025-02-26 16:20:39.000000000 +0200
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
2025-03-17 12:29:17.876551537 +0200
@@ -47,19 +47,16 @@
                interrupt-parent = <&gic>;
                ranges;

-               rstc: reset-controller@f0801000 {
+               clk: rstc: reset-controller@f0801000 {
                        compatible = "nuvoton,npcm845-reset";
-                       reg = <0x0 0xf0801000 0x0 0x78>;
-                       #reset-cells = <2>;
+                       reg = <0x0 0xf0801000 0x0 0xC4>;
                        nuvoton,sysgcr = <&gcr>;
-               };
-
-               clk: clock-controller@f0801000 {
-                       compatible = "nuvoton,npcm845-clk";
+                       #reset-cells = <2>;
+                       clocks = <&refclk>;
                        #clock-cells = <1>;
-                       reg = <0x0 0xf0801000 0x0 0x1000>;
                };

+
                apb {
                        #address-cells = <1>;
                        #size-cells = <1>;
diff -Naur a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
2025-02-26 16:20:39.000000000 +0200
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
2025-03-17 12:24:52.293171764 +0200
@@ -19,6 +19,13 @@
        memory@0 {
                reg = <0x0 0x0 0x0 0x40000000>;
        };
+
+       refclk: refclk-25mhz {
+               compatible = "fixed-clock";
+               clock-output-names = "ref";
+               clock-frequency = <25000000>;
+               #clock-cells = <0>;
+       };
 };

 &serial0 {

Is it better to modify the reset driver with your suggestion or change
the device tree?

Thanks,

Tomer


On Sun, 16 Mar 2025 at 17:22, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Thu, Sep 12, 2024 at 10:10:37PM +0300, Tomer Maimon wrote:
> > Add NPCM8xx clock controller auxiliary bus device registration.
> >
> > The NPCM8xx clock controller is registered as an aux device because the
> > reset and the clock controller share the same register region.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > Tested-by: Benjamin Fair <benjaminfair@google.com>
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> Does this work with real hardware ? I tried with the new qemu emulation,
> but that gets stuck in the serial driver initialization. I found that the clock
> device instantiates but does not register as clock provider because it does
> not have a device node. I needed something like the patch below to get beyond
> that point.
>
> Thanks,
> Guenter
>
> ---
> From: Guenter Roeck <linux@roeck-us.net>
> Subject: [PATCH] reset: npcm: Provide device node to clock driver
>
> Without device node, the clock driver can not register itself as clock
> provider. With debugging enabled, this manifests itself with
>
>  of_serial f0000000.serial: error -EPROBE_DEFER: failed to get clock
>  of_serial f0000000.serial: Driver of_serial requests probe deferral
>  platform f0000000.serial: Added to deferred list
> ...
>  Warning: unable to open an initial console.
>
> Look up the device node and attach it to the clock device to solve the
> problem.
>
> Fixes: 22823157d90c ("reset: npcm: register npcm8xx clock auxiliary bus device")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/reset/reset-npcm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> index e5b6127783a7..43bc46755e82 100644
> --- a/drivers/reset/reset-npcm.c
> +++ b/drivers/reset/reset-npcm.c
> @@ -409,6 +409,8 @@ static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_d
>         adev->name = clk_name;
>         adev->dev.parent = rst_data->dev;
>         adev->dev.release = npcm_clock_adev_release;
> +       adev->dev.of_node = of_find_compatible_node(rst_data->dev->parent->of_node,
> +                                                   NULL, "nuvoton,npcm845-clk");
>         adev->id = 555u;
>
>         ret = auxiliary_device_init(adev);
> --
> 2.45.2
>

