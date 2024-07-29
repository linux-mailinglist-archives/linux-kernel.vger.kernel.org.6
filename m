Return-Path: <linux-kernel+bounces-264977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C92F893EAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AAAB20CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDBE74420;
	Mon, 29 Jul 2024 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2rxg2ep"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476A26AC3;
	Mon, 29 Jul 2024 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217823; cv=none; b=rGZ8VhkSb0y1nOU4dxy2UWMWVbenn/dDU5nGDc3JkDLqMKKmEiJ4MlkRIPt97uhHIr1RGoz9gEk94frHMKfyUPLKJdXRVPUJrOfZjvOCMYjFS+it1lbKdMR8jCmIjP5Q4XUDqt57QLc1J/V/iQ9x5wvwLnPx4LUyTgjizMbWiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217823; c=relaxed/simple;
	bh=jBUXQhkoazAPZ8J2tXt7mqM/p9w5yDrY+JlE4y1D8qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sosgZ9B5lZDXj1mxcl+CScRda/AyyfPKpx3YDzHH2BHokFqWMDpXBqF87VZdZ6CKaOdZ3AKXZfg9zeWmxCZbhDZCLjtnXdaoAguA6PAeltheeZ9OxpW0oBX///zn4TUM8DvMa/9PNg5AYqSVcEEhy+hbvkKVluiyQD/uESf15tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2rxg2ep; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso4674537e87.2;
        Sun, 28 Jul 2024 18:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217820; x=1722822620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQwsAFM3hC76AQ773wrjNWmUPai4QYsRyLly5BlNDbY=;
        b=L2rxg2ep84xbXRc/ZsINa2T7eaFrSVEUKS39hGGSrfRybMldYZ8VrUPq2Fkhj4W5ec
         kgtrBdjFbjvob3uTeXbz8iTFCd5SOSrxDFHTSBn0jWt9VUQ4ygavDmY7B9KQQGCPo+5t
         lp8uL/FSE2Zg7FRDC6VOMl4pAn247MTTkKXqtXcL9vM732yXIjqUgHjApaJHvIPZ6o/k
         77sSCJkRXgQWbdkQdjHxQmyBzmockGlAmo1XfycowVmQo61P6kfxkg3FIYJCBwFvblyY
         +16px4Blp+scXBqrh6ATA20sTzPna02QsAYLbzepOgi2ankSHU7zGo+h5Ds1VJIuIT+p
         KM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217820; x=1722822620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQwsAFM3hC76AQ773wrjNWmUPai4QYsRyLly5BlNDbY=;
        b=pp5VLWvN4KHYoqQm3ylqBf17zJzPuwceHjV/5XdKr/924svLPeDDw1h4lLl5lPFona
         8dCinyOw0+bSlh8RkFkGexxNza3YXMyqkmHtoyoyBUNjkZUgZxt4zaXN24Xf7PpRa2L0
         aw7WI0lzMz1iwjnh/hnaaAAfLv/eVxxC2SnHw4DfOupBbRoB3wjMla2PIPfmPP2AlFLq
         V99OrvpRLT8sE4ZJAPYdbmOhiP937eHC9VhWK+CFjSRCsS/1rIpkbCN68CpDaYzCWUqr
         GhgCEFRCvhi7iLFSMrT8KCFOucVhc+XLtwPLlIy2UJe+mrUqXMtxM3WIMlgyO6lbs8rM
         T9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU8EV+NHcZnfCRC6E5fOVvok05WFbpeZeoUJZKY5YSvbOcOzKM9CD/6uOfoB2yUo5tZGHbN+dI5JMlbUechan1o2xme+C8zHlOmyE7IHgwXkC5PbaMzC4bFCxEsUlv4Q3cRuKsAIBgTyg==
X-Gm-Message-State: AOJu0Ywp6NOfYVo7gx1vGPZ5MYxftJ6tQn6KfFU3/1Hts5ZjhFA+ClKo
	+w65fPevjTjc0hMgG0Y27h56Q6UhtAlfuXvYOLiv8zReBuMqI+zAn/aACqEBXjONy8mUyUTGSLr
	q7i3r4tIr39PaUXmo6WZhPn67TCE=
X-Google-Smtp-Source: AGHT+IG2fQ9db4L8JJmxDk7HV4wxYgRsFxk5O8HaXTbeBbrhkpr0uX212Bjp7MPM9I2rfq5AiGqF6vbWnVAeub1cI8E=
X-Received: by 2002:ac2:539c:0:b0:52b:8ef7:bf1f with SMTP id
 2adb3069b0e04-5309b2707aamr3601949e87.17.1722217819853; Sun, 28 Jul 2024
 18:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com>
 <172199921421.1507234.14901757413141840919.robh@kernel.org> <6d73dcf20c726ad59e2aa16e507af17b3af59c42.camel@codeconstruct.com.au>
In-Reply-To: <6d73dcf20c726ad59e2aa16e507af17b3af59c42.camel@codeconstruct.com.au>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 29 Jul 2024 09:50:08 +0800
Message-ID: <CAGfYmwVSd846mX=WwhPu9dzZ0-d92jEzWG=dbDA+hQP+25uC9A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Patrick Williams <patrick@stwcx.xyz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	Conor Dooley <conor+dt@kernel.org>, Potin Lai <potin.lai@quantatw.com>, 
	Joel Stanley <joel@jms.id.au>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 9:17=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Potin,
>
> On Fri, 2024-07-26 at 08:09 -0500, Rob Herring (Arm) wrote:
> > On Fri, 26 Jul 2024 18:26:48 +0800, Potin Lai wrote:
> > > Add Linux device tree entry related to Meta(Facebook) Catalina specif=
ic
> > > devices connected to BMC(AST2600) SoC.
> >
> ...
> >
> > My bot found new DTB warnings on the .dts files added or changed in thi=
s
> > series.
> >
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warning=
s
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to rep=
ly
> > unless the platform maintainer has comments.
> >
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> >
> >   pip3 install dtschema --upgrade
> >
> >
> > New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-ca=
talina.dtb' for 20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com:
> >
> >
> ...
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@2/pwm@21: failed to match any schema with =
compatible: ['maxim,max31790']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@2/pwm@27: failed to match any schema with =
compatible: ['maxim,max31790']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@60: failed to match any schema with =
compatible: ['isil,raa228004']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@61: failed to match any schema with =
compatible: ['isil,raa228004']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@62: failed to match any schema with =
compatible: ['isil,raa228004']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@400/ipmb@10: failed to match any schema with compatible: ['ip=
mb-dev']
> ...
>
> The snipped errors are mostly from the DTSI, but these errors above are
> specific to your DTS. Can you please address them?
>
> Andrew

Hi Andrew,

I tried to follow exist dts files to add the compatible strings, but
all of them are showing error when I manual running "make ARCH=3Darm
CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-catalina.dtb".

- "ipmb-dev": arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts at lin=
e 432
- "max31790": arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts at lin=
e 196
- "maxim,max31790": arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
at line 511
- "isil,raa229004": arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
at line 512

And there is no .yaml file for these drivers to check the proper
compatible string.
Do you have any suggestions in this case? Thank you.

Best Regards,
Potin

