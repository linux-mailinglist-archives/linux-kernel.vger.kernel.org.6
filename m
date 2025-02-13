Return-Path: <linux-kernel+bounces-513441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7088A34A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA057A2540
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA4266B52;
	Thu, 13 Feb 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ZjaV1ZNq"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1A242934
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464058; cv=none; b=bWD9uBsWLzA/YIJ78+opTyNJ5GRM1hLF6QeDDMD0K8n2avFsN+ATOX2RX6or/fhsqpi19QYP/ZoQgPGInZVzBcixzbqVAkbda/yCsAAv0t1q79lY5tF/KfY4nga9yKDNJhBbr3aD0ae/vR51JMTK0fp0eR56EfEKpHsF0glfAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464058; c=relaxed/simple;
	bh=aixNwfpNLYxCXcI5ccF3I2q6OoCStOmv5r5FC5BMOR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ+werjoM6U5cnjPcZVHLavicXtEn/Vqu1HGRvR2pEZAFoqRkQP7cTgHlm8kdL9emam9/2zwUNgG6p4p3HrKbxZhDSXG3B7cVKq2BG4q6Fx4Gs/B7gPphBrv86TOhjCmszJnULLUfMihDaD7CUGIWpfhClntpZUk4wOaoCKZwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ZjaV1ZNq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso187944566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1739464055; x=1740068855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aixNwfpNLYxCXcI5ccF3I2q6OoCStOmv5r5FC5BMOR4=;
        b=ZjaV1ZNqmYvjW/J9hX4ZCLBp9Fb02u997YQh6qdKHSMif8rYRUrNHUgtB8BBQ2QLCR
         2fioYgRdEguSTwvpDMZpf0uecwykrIo89KN3KO+AyzeRBCmOuvl5eUQ/FdUQnT4FMnSA
         utyTJjZE6pSqnHtYo+a3NdRoOgrY0s9Kbvpe7QLMctxpEfxHW9IxscuVn3ZZSXntQcaf
         I86ETNlHeSSwXLw0dYbfD7MAnMOlNnz3gTLeILHthjrJLNZhzjqXtEHd74NMlGcJ859F
         9oeTD526IYnxt7OOM0CZsYyuAmBzHT7HtUvEN1lPYHZEKXPV+4hwVq+zPb31QLkUPubg
         oZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464055; x=1740068855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aixNwfpNLYxCXcI5ccF3I2q6OoCStOmv5r5FC5BMOR4=;
        b=d3qj22ueaGl/5LQu9kTdHV4RKTstzFx7NWoFj7en3YPunzWo4XG1D1LatRaz4SC9wC
         MN3GbXkw/F9LdxIOi3yl+BsqTDAZwu29uMc8B55LvE3l8MqlstdWvNnMfw2vQ+Po68qq
         fKIrCsa3c0shZYXlXG30dVkR4pAVKBHaDzYc4yX+vSMLYMCJXaFhudtnmuxr5rZmfJ0Q
         pl3h9mszoeHCqMNRHRcTfgjdGaRLeohs6gVfUD/ZdU+Yb2uPa6gXlus1cjfSfu5pWzN0
         NNzsfX5Q0gHTFn4iTuHDcm9YWK+i5CvxNbjMqoQ1qWZKmW3IeZYK/9hd02bRISLWjzxj
         b2tw==
X-Forwarded-Encrypted: i=1; AJvYcCVffbnOjHFYClVvIb3JJLfGeSTFzXV8iZF6AWmzjp4E6gqFyDdQiGTfPHZC3EpblkycdNEoRLLjOOJD1p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykuyuwqm6NzVmHPaLOR61FCgiCuQ0Khw3b0Kroke20MoV+NWlW
	d78bwe4rRJOdejQhyttHRd7p5gIisT9n6IJroFrOJ4foOBImZNGue0Y6fJYSoznC3JE2fWIGRtk
	9P/FpDYCb7q0RSGlS8dGKPi6652ljL6ShsPXJ/w==
X-Gm-Gg: ASbGncsHh3enwz4Yg9cI8/hwNIZjY8c3b6Y5TitNScbqapk8irydkTQ9cz437hbLPwX
	9zsPlaA8MtVSC+YjjkzBL/sI1/DBxADGZmG9D/hSoSQbHu6w6tYeKHRQ9gp9fZytgT3l7uI2syj
	U4pIeM0HXUD+/yADXai8dvL33lhBcw
X-Google-Smtp-Source: AGHT+IGh1IZYUOs4P7JSIz9yKatxKcYCpkTha4+Vt1XXHAvpLvRRPqSwJWHf/GTRbZo8Nm9ZR0QzY9EHYI9QcB0Oy7A=
X-Received: by 2002:a17:906:7956:b0:ab7:f221:f7b4 with SMTP id
 a640c23a62f3a-ab7f34738c0mr776743366b.43.1739464054629; Thu, 13 Feb 2025
 08:27:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com>
In-Reply-To: <20250213171435.1c2ce376@bootlin.com>
From: Phil Elwell <phil@raspberrypi.com>
Date: Thu, 13 Feb 2025 16:27:23 +0000
X-Gm-Features: AWEUYZl0UFEHY2kV2h1h_cYG6cbTpw7bZVsKquFMakyrJEadnvQ1Edus79HpRwQ
Message-ID: <CAMEGJJ1++aeE7WWLVVesbujME+r2WicEkK+CQgigRRp2grYf=A@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device using
 a DT overlay
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, andrew@lunn.ch, Arnd Bergmann <arnd@arndb.de>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, bhelgaas@google.com, brgl@bgdev.pl, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, derek.kiernan@amd.com, 
	devicetree@vger.kernel.org, dragan.cvetic@amd.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org, kw@linux.com, 
	Linus Walleij <linus.walleij@linaro.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, lpieralisi@kernel.org, 
	luca.ceresoli@bootlin.com, manivannan.sadhasivam@linaro.org, 
	masahiroy@kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, saravanak@google.com, Stephen Boyd <sboyd@kernel.org>, 
	thomas.petazzoni@bootlin.com, Stefan Wahren <wahrenst@gmx.net>, 
	Will Deacon <will@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Thu, 13 Feb 2025 at 16:14, Herve Codina <herve.codina@bootlin.com> wrote=
:
>
> Hi Phil,
>
> On Thu, 13 Feb 2025 15:18:45 +0000
> Phil Elwell <phil@raspberrypi.com> wrote:
>
> > Hi Andrea,
> >
> > The problem with this approach (loading an overlay from the RP1 PCIe
> > driver), and it's one that I have raised with you offline, is that
> > (unless anyone can prove otherwise) it becomes impossible to create a
> > Pi 5 DTS file which makes use of the RP1's resources. How do you
> > declare something as simple as a button wired to an RP1 GPIO, or fan
> > connected to a PWM output?
>
> The driver could be improved in a second step.
> For instance, it could load the dtbo from user-space using request_firmar=
e()
> instead of loading the embedded dtbo.
>
> >
> > If this is the preferred route to upstream adoption, I would prefer it
> > if rp1.dtso could be split in two - an rp1.dtsi similar to what we
> > have downstream, and an rp1.dtso that #includes it. In this way we can
> > keep the patching and duplication to a minimum.
>
> Indeed, having a rp1.dtsi avoid duplication but how the rp1.dtso in
> the the kernel sources could include user customization (button, fan, ...=
)
> without being modified ?
> At least we have to '#include <my_rp1_customizations.dtsi>'.
>
> Requesting the dtbo from user-space allows to let the user to create
> its own dtso without the need to modify the one in kernel sources.
>
> Does it make sense ?

I think I understand what you are saying, but at this point the RP1
overlay would no longer be an RP1 overlay - it would be an
RP1-and-everything-connected-to-it overlay, which is inherently
board-specific. Which user-space process do you think would be
responsible for loading this alternative overlay, choosing carefully
based on the platform it is running on? Doesn't that place quite a
burden on all the OS maintainers who up to now have just needed a
kernel and a bunch of dtb files?

If it is considered essential that the upstream Pi 5 dts file does not
include RP1 and its children, then Raspberry Pi are going to have to
walk a different path until we've seen how that can work. By splitting
rp1.dtso as I suggested, and perhaps providing an alternative helper
function that only applies the built-in overlay if the device node
doesn't already exist, we get to stay as close to upstream as
possible.

Phil

