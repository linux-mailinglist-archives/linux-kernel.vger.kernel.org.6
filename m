Return-Path: <linux-kernel+bounces-565552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C21A66A84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD031899F39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF31C84B7;
	Tue, 18 Mar 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/RSRj6e"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C54C6D;
	Tue, 18 Mar 2025 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279637; cv=none; b=QCKHwSp2aAncObXIMro+UZ6jtVw6fbAZXAREVwfuT/4KUcqvRIDx09XByuY3vlMNott4zYpgUiTb+/lJVByDAuLO86OjEKMceeBTUbZhNoPbt1196OdmGEIkXBGMJv8t3Q5TOfU/AmzCTDPZFQyWcxXQyCSPTJm7xhDgOZxoGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279637; c=relaxed/simple;
	bh=2YLVdjrDzSnHGCr9S9cjxJix9o2Sp6XYctDLThUToCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCeOhOLDaPdeLdpAxcalU0/HrxZWDRuQz6sa+d04m/JHH0lUzpME4YTdo7YXB7q2EO1CXUSuznPxskN98viqur5QqGQB500uFHmnEZ+/gKmKQ4HlMiC4OOHDxeZ2OitwXZK4YDGKBbBpO/hk4jUJE+Bf59JQeKGJm7rntAT4w6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/RSRj6e; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so4876543276.3;
        Mon, 17 Mar 2025 23:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742279634; x=1742884434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh/c4R4dsLwT0KHsmAXe2nYKu7hkZRhQrjMuRdUu63o=;
        b=G/RSRj6eT5xatxhUDhGfQ1sYJCXnvyPUABmX2b0ILQO5KhbDNVdALRigLdRbWt/YXD
         1sK0NoTNMT3zZBKXDNOvtRVKTtmnFfVxBlB6B8mDIYa/4GOyuFIvOSzNzwb9hhLxA0Xr
         RqDf2WBl8zbPdzfI9lk+UO5/Vqi3NrhrjTN078DDvGWck9JbtoeU1UNk9x0u25fPWho0
         JpuTuNusRklWALw7KkyhPV7IP6q778YZ6hucV+fo3zPOGWK7PkJ7c8aen1X0hb/0fPkE
         RzM20jU+GxKMevrecmgkY7hlv0hYZ+jI3mFbLLphSV8hB6nJpEalqlf21xE9z2cQAKRl
         MujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742279634; x=1742884434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh/c4R4dsLwT0KHsmAXe2nYKu7hkZRhQrjMuRdUu63o=;
        b=TkYyrfZjzXPGGYqqG+mAVonzTuKqtNlbl/TSuE8DFoLpwEVZsQ06jFinVit846V8rH
         360vzIKOyv0NsnD4OihfSAm9zMvtgUVnr/eQgDU32vHFbjHuJUzb2qm6uJJM6lPyRFUi
         F7Tnm7T+Ccn85X6XbtvpUa9GnYixLqgA/UIY//7XsOb2AISEsHLinCCrKSVtYP2lI6KK
         nmjaCcmBT1GGYpEGi3RNZ93wDAaB6ywFR0qfYc57d4Lst26fQ+SBZ64r7bgyfIivIUBO
         IDanhcN0BZjkkCWQ8Tqcy7Zr40Tvl3yMnLdbkegCsU1Ynf+wQgpOHy2BOrMbd/5fprzq
         Lg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGjU8+qCJNj1EjXIg6UUGHyNMsV9U49R8xpBecjC1GuijfB+YurSf04sn7252QLIWw11ytoDtdaLOfrefc@vger.kernel.org, AJvYcCVusxV006q58+uaH9dnLukO4ru1DZAj0tYwL6eKfN2YWv7kja59t2y6uMuv8CwDqSp84GqLFZLDhz4A@vger.kernel.org, AJvYcCX5tb5npgsUmvlQcng+1bLGhZvzqSWOlEOcIPIsdKBQeEhzVWRKC+Wp8t/rhraeWlL5FCYTQ3/jKtnA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/cP17u+ggY+lr/m/hzxfUhfUz0KUg4h3+ODEwQxBkljcoCKO
	KmLEMjp8QyK+RPyvYe5KCRI/1vAmXVFcwAviXW116vwkbT7dl07gVc5s866tNXT2saciZGkEGBC
	vJXJGaRDNDY7NKs2uVGm3OBdwc4k=
X-Gm-Gg: ASbGnctf9BFYw2YsuL0cL4N+zQoGRpTovNIaTsWt4dXQRjnMrmFTsu45eJckTit7Z00
	c/Ykdb81CbGnDi2y+WgQ10LmDLDKi5kVqo+JXrjMLY0p6HBHWwTLHPfQnYnOAjxXTbFXZP78ZhV
	tEk6BMJdEsVbD09gJmqnlBA9wSNRc=
X-Google-Smtp-Source: AGHT+IELSIn5/BuHvlZqcoULDSggaDltMS8PE14gaoXkQgvkbGeEGMS2YRahcu5an6hVdQQfVhHyYYKUOx5w2IzK28E=
X-Received: by 2002:a05:6902:118f:b0:e5e:14d4:e63d with SMTP id
 3f1490d57ef6-e64af0eb437mr3891751276.9.1742279634060; Mon, 17 Mar 2025
 23:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912191038.981105-1-tmaimon77@gmail.com> <20240912191038.981105-3-tmaimon77@gmail.com>
 <536f5393-478c-4a50-b25f-180e221ef7a3@roeck-us.net> <CAP6Zq1ioebnqgJB1B8AqD9UtMZRy5CDT8+_dXF_aBZEjjj_B-A@mail.gmail.com>
 <9a9de8bd-d864-4e29-89b2-91db8aea8ce5@roeck-us.net>
In-Reply-To: <9a9de8bd-d864-4e29-89b2-91db8aea8ce5@roeck-us.net>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 18 Mar 2025 08:33:43 +0200
X-Gm-Features: AQ5f1JoL-dTyRxBEx8xKcjtrgVDVRemqDFE0mk_w3MNt2XunFXr57UTJfuPgstA
Message-ID: <CAP6Zq1h2bsODnSR6kiVmtueqbjOtEShu_=EYHtw65SPGaX+bgA@mail.gmail.com>
Subject: Re: [PATCH v28 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
To: Guenter Roeck <linux@roeck-us.net>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, 
	joel@jms.id.au, venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thanks a lot for your recommendations and sorry for the inconvenience.

We will fix the device tree and send the patch soon.

Best regards,

Tomer

On Mon, 17 Mar 2025 at 16:09, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi Tomer,
>
> On 3/17/25 03:39, Tomer Maimon wrote:
> > Hi Guenter,
> >
> > Yes, of course, it works in real hardware.
> > The modification was made since the reset and clock share the same
> > register memory region.
> >
> > To enable the clock change needs to be done in the device tree as
> > follows (we are planning to send these change patches soon):
> >
> > diff -Naur a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > --- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > 2025-02-26 16:20:39.000000000 +0200
> > +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > 2025-03-17 12:29:17.876551537 +0200
> > @@ -47,19 +47,16 @@
> >                  interrupt-parent = <&gic>;
> >                  ranges;
> >
> > -               rstc: reset-controller@f0801000 {
> > +               clk: rstc: reset-controller@f0801000 {
> >                          compatible = "nuvoton,npcm845-reset";
> > -                       reg = <0x0 0xf0801000 0x0 0x78>;
> > -                       #reset-cells = <2>;
> > +                       reg = <0x0 0xf0801000 0x0 0xC4>;
> >                          nuvoton,sysgcr = <&gcr>;
> > -               };
> > -
> > -               clk: clock-controller@f0801000 {
> > -                       compatible = "nuvoton,npcm845-clk";
> > +                       #reset-cells = <2>;
> > +                       clocks = <&refclk>;
> >                          #clock-cells = <1>;
> > -                       reg = <0x0 0xf0801000 0x0 0x1000>;
> >                  };
> >
> > +
> >                  apb {
> >                          #address-cells = <1>;
> >                          #size-cells = <1>;
> > diff -Naur a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> > b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> > --- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> > 2025-02-26 16:20:39.000000000 +0200
> > +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> > 2025-03-17 12:24:52.293171764 +0200
> > @@ -19,6 +19,13 @@
> >          memory@0 {
> >                  reg = <0x0 0x0 0x0 0x40000000>;
> >          };
> > +
> > +       refclk: refclk-25mhz {
> > +               compatible = "fixed-clock";
> > +               clock-output-names = "ref";
> > +               clock-frequency = <25000000>;
> > +               #clock-cells = <0>;
> > +       };
> >   };
> >
> >   &serial0 {
> >
> > Is it better to modify the reset driver with your suggestion or change
> > the device tree?
> >
>
> My assumption was that the devicetree file is correct, and that it would match
> the devicetree file in the actual devices. I since noticed that the file is
> widely incomplete when comparing it with the various downstream versions,
> so that was obviously wrong. Also, my change seemed odd, but then I did
> not know how such situations are supposed to be handled.
>
> Also, it looks like the devicetree file needs to be changed anyway unless something
> else is wrong, because booting Linux still stalls later. Presumably that is because
> the reference clock is missing in the upstream devicetree file (the serial port clock
> frequency is reported as 0). Given this, fixing the devicetree files seems to be the
> way to go.
>
> Thanks,
> Guenter
>

