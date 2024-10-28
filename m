Return-Path: <linux-kernel+bounces-385968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25579B3D92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA3A1C2167E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABAB1EE01C;
	Mon, 28 Oct 2024 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gjhq9Jqa"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E21E32DC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153790; cv=none; b=EF9huQmC0VJzjGQgNp6MBPLJ62FR7iEFNmqPj11tPPB9gtUOdzviMtDdmHCX9C9VI3g/SZkIMBSK7kNBDltDAhaBOhM984dqusNDxHVvf8A21zWV407vkA23UewqEl+0nlKKAMivEuygexFXxAAzIXHh2+Pw2ANlB04J7n20TOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153790; c=relaxed/simple;
	bh=9N+/R+yMClr79iDqjsc7AHBZ7heiAvpqxUMbmqWtWYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4dgyzqSgyJuShNilc/53+LMU49kQaGzlLtqSQ0KBNXi/BJp7TujMlkcZZjRXbuwm2lgxNTWdcHGF8q3dbZhGxXwKrPXxTsY98a7esGwBYRTzuXmjPJ50cT+TCdW+2ZzaEAFzkM7FWSLKhpP1Btz5TNMhWIa/CnvzlAFq5boYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gjhq9Jqa; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb587d0436so49449951fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730153787; x=1730758587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N+/R+yMClr79iDqjsc7AHBZ7heiAvpqxUMbmqWtWYw=;
        b=Gjhq9JqaglR5Dv0YNKzd0QzFGDBG0Jb/rfLMlCYYgPd5QXo0l0Tvp5rZknhrGL+KBB
         XMK1pbdRW9HX0tA5RKNc2FrtLDEPiHl82Ft48AUAqm1yoHvFvbTVOG7wekd6SKtEDfWp
         0Cuql2eBOF8QE6THVOfUr2Leobl2jTXdSc6gu4RyRV0ZWvlxJNv4qFMV7BePdH4JlWwy
         DvFOImJyowXz82fushA8pigPRBx9dd3bHdKqyYkklsQUOSy/9RLfcu6i28SZJpFP0fcY
         w4SbpFP83l3Jm5RLVgyYM2deUblJY0nCiXqNsylyq4yysLW5xSHQGn4OzfyafaeoU/Di
         7y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153787; x=1730758587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N+/R+yMClr79iDqjsc7AHBZ7heiAvpqxUMbmqWtWYw=;
        b=mDJhzhHuxI6MnCMbsmKhrMA1XJmGbTglxEZDRwJeYejPvT0lUMNJh0MK7jUiH98nRa
         ZLhErzrCDhZt2lK50sPH4r9qjWa/Mog0HkkG6HyuRGfgP+91KIny2iV5/9t7W+EacHKh
         D6+Qrj8LtLZ02KCSCYPAk24URPhkV+V/OsdkhHhdVzZgsiDsjGP+uHCPMNtFv1sYhyWY
         TUbg6f06XVzKnKy+9D7VnUz1E2gYQmMlRzrGfGtP7YWL8+PV403a74fEQM1Uc9N2dCXC
         eYLmHNpeUkDWb7OQdc15BSr9/gKUmICCzHMM2oQR6t4TphE+YnFYSYHaTosTdSzIU0i7
         ScNg==
X-Forwarded-Encrypted: i=1; AJvYcCVmqr9fC9TAIPgHvun2Mw0cfZtyMjlFbe96jmbDjONViUtQGNsj+3FDl9RUvPbztziCyUGsZtFmfrh0gq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJN9IudH05dL11lSrcUIT/fjrCEcdqnc/P59MRMmnGASMT3t4V
	EKe+MM2GcEf6dcmtU/ANpeW95RPfnlIdVxVtFiOJjHIXOqWOpHqL75//XUvZIER7DtjsCu9iT27
	gzK6zIuptdCkXMNoRSbPVprLLw0CHcl5sGZyMag==
X-Google-Smtp-Source: AGHT+IE6DtBNue66FAZk1osaVTZDa6IytIhVHf/6SKY95NzMmkOdQ/ZCObzh1LjqdFsUEbcb6iyLGOIb1MzYzR00K8s=
X-Received: by 2002:a05:651c:211a:b0:2fa:cc12:67de with SMTP id
 38308e7fff4ca-2fcbe0669f8mr41305041fa.32.1730153786652; Mon, 28 Oct 2024
 15:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730123575.git.andrea.porta@suse.com> <b189173d893f300e81b18844a1c164fe4ad5bc20.1730123575.git.andrea.porta@suse.com>
In-Reply-To: <b189173d893f300e81b18844a1c164fe4ad5bc20.1730123575.git.andrea.porta@suse.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 23:16:15 +0100
Message-ID: <CACRpkdZCbvNY=B05e9wGqNr5b4t8GrDVsr01C3xd5E-WWwPyMQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] pinctrl: rp1: Implement RaspberryPi RP1 gpio support
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 3:07=E2=80=AFPM Andrea della Porta
<andrea.porta@suse.com> wrote:

> The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
> Add minimum support for the gpio only portion. The driver is in
> pinctrl folder since upcoming patches will add the pinmux/pinctrl
> support where the gpio part can be seen as an addition.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

This looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can this patch and the GPIO/pinctrl bindings simply be applied to the pinct=
rl
tree once the bindings are finalized?

Yours,
Linus Walleij

