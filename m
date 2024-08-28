Return-Path: <linux-kernel+bounces-305615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D86963135
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2885E1C23BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD851ABEC4;
	Wed, 28 Aug 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNIzkp+6"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D6125BA;
	Wed, 28 Aug 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874517; cv=none; b=ntWqjZ0scpFtp4Y1+PiRoTAlGmiXCpklgP4trhzsoTPKgVgUPpowBYvvLQHTOJUlxBcYct3FysoBjg1mbhQQAAsEe9z7SHmOBX5wBc5zUCC6/8aHDzYOHvlvRkm5/W4cc45kZ8PJn9v+Q2FVnQbBQ57+Ntd1rGvxls6SukyWi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874517; c=relaxed/simple;
	bh=T+y2Sp2I/AnCuxrPMoWAy41YouAMEHYew2EbmzfD8y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lj5DfdxbD4FAs9O1PLymzMvqrsmOCZeB9VZ+/Jy1TtbZCqT6dvaBqaMcq/YvYrLAvVI6oCQihuIAcQloWpI6n+8d7A9q6lMnZ0u2ao5jU72okhI1lvp+0Skn2+Oa678vYIdSiN3U7oBtVVUWNOpm7XqH8gtx/C2nXKpJPXOEMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNIzkp+6; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf825d779eso34720506d6.0;
        Wed, 28 Aug 2024 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724874515; x=1725479315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xplm6NVOjj7WQ4sm6b8trxIQwwR4NFeBU2VDjNPXlzc=;
        b=dNIzkp+6a83ezIC/BYYrhBj2ZGNWbY8SdWmwqDMGAc4HbvJhBCo/cmsjICkMp06w4o
         fvFafzPZqRiQwpCpdfNrL9RoY0bZ2YFEgY2RdVsvKq6qyUXEhSS1Kdd9jJRfYD6WdKdB
         36ZCJva6nGGWwDoSvYbL8aWObN8JXA2/LJp2OkPheiuyTPB79La5JWzAEZFapVn2Jy52
         ZZAP4L+c+UQZihDnviGRueeZWb/7P36XVLJOCa+TU0BulcjjihTFVcfAPip8adzEdrsp
         ecrmzLZMMUcBoPTim+2er5Z2xUaXnlnu6o3WoviDGV1wXvtM1Ut67IHzNgoHuqB9A+c3
         ZUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874515; x=1725479315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xplm6NVOjj7WQ4sm6b8trxIQwwR4NFeBU2VDjNPXlzc=;
        b=raZ6cfmhuLW6CDODDhdtA9lRZMaipvTjUl/Zx6LuJGlTWhwZd+RGcYDr4CBXbLaxSv
         RPj3tkPc5pDr4P6AUK8QxEc3c1bEuLdpQOm132WZxHOQA4JnWwhVmzXBTfr9Isuvzs/N
         bY6rvm0M0oHlwsDm+n3lBT7QZ/v7nFJQ7TOI4ZVvxamDZJgm4+wFVFi86ECM+WoEsr8H
         p7EKPNRK1b1EkhEsDERJROhAjgI9ZaAPOnEI37oFcoS241gxQ4nEb4GPhoF8QvchKNAu
         92l3FhiEFSp8Qt5ozrcC/D+nvAV8RRTy0TSIlpkuqcCgFFBjhZNOy6IUA0MXWjOunEcf
         nuzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXloWuIG3EpYBeMaH7XHpSRHWj2A8IKM3fzsfqbBd61uOzrTJSlFlkfhzbOCYfjFywBXrKkmSqkEzKp@vger.kernel.org, AJvYcCXyf9ya+JMkUdwzihI6OS3okqDOxfDks2uq6/jtkbzwvb7k1M51jKSJ0dODZoe15i4FihjlTPY0xfy0a6IZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxyA2SeLgpBvvge6mScfHHxK77w+ZczqNXBtxcioTqwRTsmk3dh
	OrXf07z1eyLYUOmzlvjNgjFYiPcTkRvZVEyXcsCj0CLP/Rv502I2wFiKmpT3nz8+W7D+izRgzy3
	3UZooXNWROCCXkfBkJcOegV8nSfozIQ==
X-Google-Smtp-Source: AGHT+IHcNA1i+ClZxAmogf8L75nNE/ZbojI8W7DLFgdNeoyUDfp9cwp5v1AqlcpV+VB0TP8xunu8fM+SahM89YO+zFs=
X-Received: by 2002:a05:6214:5c0a:b0:6b5:7e70:3537 with SMTP id
 6a1803df08f44-6c33e69bfccmr6912876d6.50.1724874514838; Wed, 28 Aug 2024
 12:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com> <2774e7e5-8c03-4f38-90c3-b414bc6af255@kernel.org>
 <CAOCHtYhK36QyKOmQhY+Q31rB23ASoxUXTX+0R1tzK-ZhvvWSLA@mail.gmail.com>
 <CAOCHtYiPdxpxz9oPO-deLMMgMZtjCjtEMqPARAPtqMKg8JxOhQ@mail.gmail.com> <87752439-1b41-4f4b-9e94-5c2a43fab4f4@kernel.org>
In-Reply-To: <87752439-1b41-4f4b-9e94-5c2a43fab4f4@kernel.org>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Wed, 28 Aug 2024 14:48:08 -0500
Message-ID: <CAOCHtYg2hEYZVQ-5P3PPh03-q+FjijJtk2j2=9kKKz9fev=HZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
To: Roger Quadros <rogerq@kernel.org>, "Aldea, Andrei" <a-aldea@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
	Jason Kridner <jkridner@beagleboard.org>, Deepak Khatri <lorforlinux@beagleboard.org>, 
	Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 2:44=E2=80=AFPM Roger Quadros <rogerq@kernel.org> w=
rote:
>
>
>
> On 28/08/2024 17:33, Robert Nelson wrote:
> > On Fri, Aug 23, 2024 at 10:33=E2=80=AFAM Robert Nelson <robertcnelson@g=
mail.com> wrote:
> >>
> >>>> +
> >>>> +&cpsw3g {
> >>>> +     pinctrl-names =3D "default";
> >>>> +     pinctrl-0 =3D <&rgmii1_pins_default>, <&gbe_pmx_obsclk>;
> >>>
> >>> Why do you need OBSCLK for Ethernet MAC?
> >>> The OBSCLK is connected to the Ethernet PHY via C406 which is not eve=
n populated.
> >>> It seems that the PHY is clocked by a crystal oscillator X5 so doesn'=
t really
> >>> need OBSCLK in the stock configuration?
> >>
> >> Ah crap, I'll take a look at this... I bet it's left over from the
> >> first pcb, (all my first rev pcb's are now locked up so i don't use
> >> them anymore)..  Seeed/BeagleBoard was playing it safe and designing
> >> in both options.. Once the internal clocks were verified newer
> >> revisions removed the external clock.
> >>
> >> Yeah, I'm pretty sure final production boards removed every external
> >> clock option.
> >
> > Yeap, external clock is the default for all production boards, i
> > removed this internal clock configuration.
>
> Did you mean internal clock is the default?
> Earlier you mentioned
> "after verification newer versions removed the external clock"

Yeah sorry Roger, screwed up on my previous message... I thought one
of our goals was to have an internal clock for everything. But @Aldea,
Andrei reminded me Monday night, that Ethernet was external..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

