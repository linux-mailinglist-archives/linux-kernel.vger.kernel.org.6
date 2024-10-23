Return-Path: <linux-kernel+bounces-378493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893B9AD152
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D81B219BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56B1CEAC4;
	Wed, 23 Oct 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lajEjjna"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB51CC8AC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702175; cv=none; b=l/uqJXSbRpK7hYSd+47JikE078oIvbyErCeUTJuxaXEdXLgBBHF6OhZglOkrf/ioYyIL/8YwCl4daPTVPNRBhmBBsAGPhCh5KiXjHJFu5e1RxCkCarJd6SdKRPNV7O5TFZJzYZs1ve1iUTEr//HhyeC/T/cqMwl0tINptD/PxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702175; c=relaxed/simple;
	bh=HbnEFb3ObL/9cDeROaPzISBgD2bOMtvcCUvYiCPts9c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNaNDcxjJHX6y5nrcmSK8XGyMlOw5wDo9HN2Z/nifP4YiY5hXeMNlRefZMWKcqA8Wlv7ekvSPHWfVJuryMLjNnbuHtRmlMvSacT7PBSe5G9D497hoJtcqC8huqR4lQS8Q1+UTZSQzMavMl6S9i3Cfjju6tF/KXKVYDmJhPINIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lajEjjna; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2056B4120D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729702171;
	bh=w2QaCC8q/9wFycITOyNXbtjclLYtA/uPr5wOP7wkZg4=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=lajEjjnaOld7ZLmATWTgV0F65cRG4Fil+kWozfLhUYUkFhBACuCacIz3/s3aMNCli
	 invc05LX5t/39eT29jpNULVpfR0pOiudhP9q7wxoIuE8DSwXkbsBFkfdjKeVyq1Hj2
	 juPWnz5wYPYoTr65QIEFWD1BmuS8b87h033ppOtt+pdOyQ4OLvEgkm/pEIhU2yKOZh
	 9L0OY+nCR/LhhjVZ4MBwgyt1c6+DAe3aK87IYruFU8jMdMFr+rgjMMxFY4GK5B+J4f
	 FhuEh/z2gJfGsw22bF1GsBZwMxrYFvLMdH4yD+e2dz2xzouqM7rn5P907XP3DAx2Ib
	 7D8jPSL3TpUIA==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-288b904d3d3so67284fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702169; x=1730306969;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2QaCC8q/9wFycITOyNXbtjclLYtA/uPr5wOP7wkZg4=;
        b=UYfk1ygeb1R2KT5obDhw7JiN9rho4tkl+RYOX5yLo5kNjd7aFWnrOxetXZVmUKp5Zv
         93EqKr63yznYr4fUS1gIGhP6ShtfSRHt+C8yyBqE6MREcKynnlv9Py0mpE1jWttDw0WY
         ObVIcS+93mXKrom3/20Ku21h8lmtiAoweH0RUw3SoRziZ2+7Sm8KYYJhbt+M4+4QENGd
         rC93UZEQRAxFTUNa90Qb0U6kuI4KjiOxahD7QpDaX9NDKQ3B0cr9MMHY58qp9jNtd01I
         WzlPIOaVvC/VrF4hQJc+0H9J2iNSpwxihyRJ7imwAyA/QJxLmiBoEuZRqEV+cXw1243P
         Qbsw==
X-Forwarded-Encrypted: i=1; AJvYcCWyAoELq3LSAswzI9XA9hbDRSf7v0LEpIdVeDh1FjIJOyFozh3KpNqhOR0dVxqddxAzff3YklSRf5wcAsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Gg/86ftKFL/LjBXRmDVbYf5VZ7KAbxhRTCdR7OseW8YDw97D
	Phr69DR9r45P7PA1gGfVLe4wQ/OVK/0UvESZ2DcUkZvdBgPrhaCNG0QOouIAyvpEaWrdjxFPkyj
	3nxNKoFKbOuJMm6ccbZ49M7yQCduSVXWzG7a/4L9dwkyxcocpLK5fz3Yls3OvtvYizCZRshCZpr
	9e8EvoUXRsfC39NTVJy+wmA/8YeKxNa70qJOKS3epjwxSpQqjwgK2O
X-Received: by 2002:a05:6870:a905:b0:260:eae3:5ec2 with SMTP id 586e51a60fabf-28ccb4a44e1mr3290254fac.26.1729702169191;
        Wed, 23 Oct 2024 09:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAONy/ra7wiBLGnnWDTFW/U6U7FnGggdnF7DYXmB3kSGSkFwOtZGKVkkKys9wyfe40jfUT0o4lf5kU/ZKjmnA=
X-Received: by 2002:a05:6870:a905:b0:260:eae3:5ec2 with SMTP id
 586e51a60fabf-28ccb4a44e1mr3290232fac.26.1729702168925; Wed, 23 Oct 2024
 09:49:28 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Oct 2024 12:49:28 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241021-crimson-translate-291eaba4e640@spud>
References: <20241020134959.519462-1-guodong@riscstar.com> <20241020134959.519462-4-guodong@riscstar.com>
 <ae5gels34ozgzrcrwz53wj22hoy5cq3crn3dmkhitxlffmnavt@6lbmrcpjmqyd>
 <20241021-unroll-empower-3ab903615d6d@spud> <c048d270-7a07-4807-b816-0f4e0aeb67f7@kernel.org>
 <2b449955-6596-4c9a-9799-f15d186e260f@riscstar.com> <20241021-crimson-translate-291eaba4e640@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 23 Oct 2024 12:49:28 -0400
Message-ID: <CAJM55Z_jp7ZGUcV=4Ciq0ZMPbrf_YARpSDwWgxBa9OjbYzhiFw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] riscv: dts: starfive: add DeepComputing FML13V01
 board device tree
To: Conor Dooley <conor@kernel.org>, Alex Elder <elder@riscstar.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
	Michael Zhu <michael.zhu@starfivetech.com>, Drew Fustini <drew@beagleboard.org>, 
	Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>, 
	Sandie Cao <sandie.cao@deepcomputing.io>, Yuning Liang <yuning.liang@deepcomputing.io>, 
	Huiming Qiu <huiming.qiu@deepcomputing.io>, linux@frame.work, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conor Dooley wrote:
> On Mon, Oct 21, 2024 at 08:44:16AM -0500, Alex Elder wrote:
> > On 10/21/24 7:47 AM, Krzysztof Kozlowski wrote:
> > > On 21/10/2024 13:16, Conor Dooley wrote:
> > > > On Mon, Oct 21, 2024 at 09:17:59AM +0200, Krzysztof Kozlowski wrote:
> > > > > On Sun, Oct 20, 2024 at 09:49:59PM +0800, Guodong Xu wrote:
> > > > > > From: Sandie Cao <sandie.cao@deepcomputing.io>
> > > > > > +&camss {
> > > > > > +	status = "disabled";
> > > > > > +};
> > > > > > +
> > > > > > +&csi2rx {
> > > > > > +	status = "disabled";
> > > > > > +};
> > > >
> > > > You can drop these two, I marked them disabled in the common file
> > > > earlier this week.
> > > > 1
> > > > > > +
> > > > > > +&gmac0 {
> > > > > > +	status = "disabled";
> > > > > > +};
> > > > > > +
> > > > > > +&i2c0 {
> > > > > > +	status = "disabled";
> > > > > > +};
> > > > > > +
> > > > > > +&pwm {
> > > > > > +	status = "disabled";
> > > > > > +};
> > > > > > +
> > > > > > +&pwmdac {
> > > > > > +	status = "disabled";
> > > > > > +};
> > > > > > +
> > > > > > +&spi0 {
> > > > > > +	status = "disabled";
> > > > >
> > > > > If your board has to disable all these, then they should not have been
> > > > > enabled in DTSI in the first place. Only blocks present and working in
> > > > > the SoC (without amny external needs) should be enabled.
> > > > >
> > > > > I suggest to fix that aspect first.
> > > >
> > > > Eh, I don't think I agree. Having 5 disables here is a lesser evil than
> > > > reproducing 90% of jh7110-common.dtsi or shunting a bunch of stuff
> > > > around. Emil?
> > >
> > > Why reproducing 90%? Only enable would be here, no? Or you want to say
> > > the common DTSI has things which do not exist?
> >
> > For what it's worth, I agree with Krzysztof.  In the (long) cover
> > page we pointed this out, and offered to do it in a followup patch.
> > But if requested we can do it now.
> >
> > So in v6, a new patch would be inserted before the other three,
> > and it would:
> > - Remove the status = "okay" lines for those nodes that are not enabled
> >   in this new platform, in "jh7110-common.dtsi"
> > - Add nodes where appropriate in:
> >     jh7110-milkv-mars.dts
> >     jh7110-pine64-star64.dts
> >     jh7110-starfive-visionfive-2.dtsi
> >   They'll look like this, to enable the ones disabled above, e.g.:
> >     &gmac0 {
> >         status = "okay";
> >     };
> >
> >     &i2c0 {
> >         status = "okay";
> >     };
> >
> > You guys should come to agreement, but I do think what Krzysztof says
> > is the right approach.  And unless convinced otherwise, this will be
> > what shows up in the next version of this series.
>
> Ultimately, it is up to Emil how he wants these laid out.

Thanks, but I agree. Please begin with a patch moving the nodes that are no
longer common out of jh7110-common.dtsi and into the vf2, mars and pine64
consumers. You should probably do the same with the &usb0 node instead
of overriding the dr_mode property.

/Emil

