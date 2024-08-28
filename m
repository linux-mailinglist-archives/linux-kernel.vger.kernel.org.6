Return-Path: <linux-kernel+bounces-305154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD7962A53
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B6A1F24CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358818A6B9;
	Wed, 28 Aug 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxRjhOMv"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92591BC20;
	Wed, 28 Aug 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855651; cv=none; b=n4zTrKMFGAaHOy35YTOGEigpXK58bS3QUpYbjlghhUq+pG87horH+o97h8QZXFFqTUJKPOWj707v9w0FAgWIFaU9BCZ6v01unlBuUsc9hReCcq36/QDYi2N2Znjck95RbqHLEfttu+vjfu8BoPi5jybPcTW4PYENpM1D+ES1ds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855651; c=relaxed/simple;
	bh=LURcFRroKnT5wgo+eFJtTh8WtbX/dDOkgUZzFjst0co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWqKpScF2+SNZxE5EsTojCMnY3qLDnXooc/lE05y68l37DyVAb2oHyjkDe7K6D3LwxwXBaHeyq20l7TxsIrP0NFc+yPEy8NNOlqkZLIwIEGCOmjeC1UM1m+mpyTjQQ0aICYezRRcj894JRCbOC8BdYBj+LDDCyvVTTbldPO28Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxRjhOMv; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a7d7ec7395so175659685a.3;
        Wed, 28 Aug 2024 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724855649; x=1725460449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY+kQnopqYf4JLBsGjvkE7C+Uhqy25XmburGUYLLN3A=;
        b=hxRjhOMvQ01X2a6ZRftgUeviOqyyRjxYJtYyJPVm7CEY+TK0Vm27er+wro9LoZQWPm
         vCJFUCi961vSo4iZG1z1Jov0Z2eEKSergrT8dGAUHP+EObYWE9yEcYaDbuYQ9zn3unJA
         0DbFoZwD4KAdGwnA3vgJOUxuxe+COhIUaAkS8Ul1IhVly/Chkw/SoRO9PktRx429uPi4
         98xbLAB5zQAyR69p55+8+RSybhBKRW1olz2mnleLnIoR0XqhaCTUwc/VtCOQBxxgyoPM
         Ztz39lDD7oMyXNGKaFm8WmBXrQHJ3BzK/WdbQkRrvPr0W+kDToSnPpKpXgACamKR5NyA
         yyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724855649; x=1725460449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wY+kQnopqYf4JLBsGjvkE7C+Uhqy25XmburGUYLLN3A=;
        b=B0iDH+BISyy1UP+8FIjtSWXFGzTbhypwjA8omqWsWnL186tJjrVzg2mXdGMgIYdVMT
         yIYpcF8H0gHtMTR0R5Zkj4GMyxbIMYjFFUp5yT3M4YucLLnz2v+iWyfIYqHctyR65s/+
         7WJ0UkKGHGltdU6CCQRMXDYStskp47Qh/mzy9Kdh3XSkFg0wMgwpNUW03dBXi3xVQJH8
         WL+JWvlHA8jImP5rL1ZfJlOYLRkcDMGk41uquxqmw04GGP6drxXfeOhAOsJcbJbEnNz9
         dres0U9uhnAX53yAIceKt44U0r4+03TTgY+R/XlSmPGsEByYUlzWWldNxuJ0PpTBrtUK
         yjIA==
X-Forwarded-Encrypted: i=1; AJvYcCUeB3/e7p+WD73bvGpvPOEbXSWZdjrnIac5JdRSVSxIyY5zwVxQ4q2lCgfA46nuxnhidlH3YucA+KLl@vger.kernel.org, AJvYcCVdQ79DrtsU2y8f+9IQLBhItOQCKl/Ldp1GEXAFvrfzRsh7BPMa6SmwnWttUY0/kxH3vWAjhJSRsm63o4Km@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUiUjApYkZkWAB6EeZejh5PZ05PMUEmURHwfksXTGJwGUHGjD
	GRunw8lnfrThshXnEKvxSMmVWRXT9EVbalgQDgyqMXu1A6SheLad+YdQwHb7mhFvsFUlbluJcdP
	Zyz04mQZbi+y08oUiEj0mJnLKTFMWEw==
X-Google-Smtp-Source: AGHT+IE6pfQMU/hFWirObvxGWVXC5CnUF5j9zoWtgyu7lzevFa+EzYUDHElDUUtnbmXUzBGyG43+xnxxO3o3mj0mJE8=
X-Received: by 2002:a05:6214:5544:b0:6b5:d0de:8ab5 with SMTP id
 6a1803df08f44-6c16dc8f203mr211916656d6.30.1724855648714; Wed, 28 Aug 2024
 07:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com> <2774e7e5-8c03-4f38-90c3-b414bc6af255@kernel.org>
 <CAOCHtYhK36QyKOmQhY+Q31rB23ASoxUXTX+0R1tzK-ZhvvWSLA@mail.gmail.com>
In-Reply-To: <CAOCHtYhK36QyKOmQhY+Q31rB23ASoxUXTX+0R1tzK-ZhvvWSLA@mail.gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Wed, 28 Aug 2024 09:33:40 -0500
Message-ID: <CAOCHtYiPdxpxz9oPO-deLMMgMZtjCjtEMqPARAPtqMKg8JxOhQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
To: Roger Quadros <rogerq@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
	Jason Kridner <jkridner@beagleboard.org>, Deepak Khatri <lorforlinux@beagleboard.org>, 
	Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:33=E2=80=AFAM Robert Nelson <robertcnelson@gmail=
.com> wrote:
>
> > > +
> > > +&cpsw3g {
> > > +     pinctrl-names =3D "default";
> > > +     pinctrl-0 =3D <&rgmii1_pins_default>, <&gbe_pmx_obsclk>;
> >
> > Why do you need OBSCLK for Ethernet MAC?
> > The OBSCLK is connected to the Ethernet PHY via C406 which is not even =
populated.
> > It seems that the PHY is clocked by a crystal oscillator X5 so doesn't =
really
> > need OBSCLK in the stock configuration?
>
> Ah crap, I'll take a look at this... I bet it's left over from the
> first pcb, (all my first rev pcb's are now locked up so i don't use
> them anymore)..  Seeed/BeagleBoard was playing it safe and designing
> in both options.. Once the internal clocks were verified newer
> revisions removed the external clock.
>
> Yeah, I'm pretty sure final production boards removed every external
> clock option.

Yeap, external clock is the default for all production boards, i
removed this internal clock configuration.

Thanks

--=20
Robert Nelson
https://rcn-ee.com/

