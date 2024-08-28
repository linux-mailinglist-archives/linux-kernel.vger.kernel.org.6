Return-Path: <linux-kernel+bounces-304781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6739624C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FEB1C213DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A716C847;
	Wed, 28 Aug 2024 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xRNOZVR9"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC516C69E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840604; cv=none; b=gLHoCd48XNDNmv/c+lChk4hSYCNQWxOXQlAzH/6xVG3mjQo0Kzd5iV66apwZo5PWRPigJQzfUT9Nly0WgmJ+C0IAz21OBjVYzCkmegwN6zchVUBhkdaqC2iCK4+n1bVXob6VWj84JiQiKzsl6SkEMfoApsw3bkj7+DMWnKBn41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840604; c=relaxed/simple;
	bh=pcmoMHkfM6+rVu9NGxIUa/tgdGuUsUHn2TixcQ7+jBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVyVzSYglF4g96R9lbwvpdqUsgkdhuN3+EaAac1pN+7BN+K6b41eNbbeg/Bu2W4cQCivbgkyiveVewohCGeeth2E5KnBTFPiR4PlU10TVo1t3FzYBMry/HpaGB0KOWnSGX/vcFBW+1EQOgkgPz+Wa3u5TIPfEly6zun/dQ44Gl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xRNOZVR9; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-498d14b9b8cso2244924137.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724840602; x=1725445402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Mbi6UDIyTd2bDtcfNWtgeu1nnW22anmzdjv6AWS1kU=;
        b=xRNOZVR9KJLSv7UMEP/2pMW7e/I6KpxUGJqVk2BgkYJuAjl6pha8zmpykWXST+9v+z
         hCvQyNc1uSdYXD0cPP1YymS2c2dntk/XfIuPv/k7imQbshMpQC8JMp5HLmKGA8a/ATgR
         Y1EBzO7snbX87v+rmMUB5mw4fobN9MlNVav4ZDCdgESseL4Hnb1zJ7xl58y2wLl7Zr6l
         ncufmw1wzBNHP37LVAjzhgjKwlqOKjsgYWqyURK1RSElBoJyDxag70+5fzV3z12dqFdS
         QgJ+CbWkC8yGWXBwTaE1Yq1lfbVMHoT0JAU05l6PqNT+Jggjxq0IoeSNszDeuH+C0n+E
         aAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724840602; x=1725445402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Mbi6UDIyTd2bDtcfNWtgeu1nnW22anmzdjv6AWS1kU=;
        b=DPWexckSNiQCvXJU32XpWjtcB6PUi9XUen9dgFc2pz+fnzh1wigG/ysPGsyeGVFjTE
         jmvfGRibpPLQ3dPicihK7U/4KZiU+9+6Ku+zGUok4oFcnG/NnkgCO4rEavilERtcyw1i
         KqD6qUMEix2wD7cfU5Cf5M1ruu7r+nysVt/rtCACIoKSldrX/lD/WviP/4yCLgSGISiK
         HcZBQEfrgyclXFQjCf1cc7GOoFjp2w/atAAaFvVsG+d1GBpvYCS//IzKCMkvlslFhlmD
         mZQHDNvWkMDvOMV3Ami+eHUrcnUfvdNrln2Zy+g/JcCZ9R7uTI19jHSJC6/xkTPbsAR7
         +r8g==
X-Forwarded-Encrypted: i=1; AJvYcCVUXZLfJcBrYr+U66C0shML8ZtAEiSHZ71D9Q/HIyWPX1nJTShV9HeQLVfXX3hbYoxvqXNdTco3/LSKS4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYCs/Fh5gXREVuTF6zCbrxT51KFwK5dAAbDrsOZ4S7/AMhpvl
	Qd1jy7LdB/6nJKspq+qSmtMDGPxRmBh97xXMn4T3x1I71UTX7oNyyuYNHSSwGIHj2zqgdU31J9O
	VDFS52VqHuFKe/8WUXs2RR4Kw1jkNAuIRyeMxmQ==
X-Google-Smtp-Source: AGHT+IGiYzqoMHpp0MAoVgUWF9ZasIX8jeUlgNpRL3MOlPNFy1/rfUwF8T0ImEZUhZW1LvMGbo0ZvCX5hvYP3bgA260=
X-Received: by 2002:a05:6102:38c8:b0:498:efe0:f91d with SMTP id
 ada2fe7eead31-498f46ea982mr17511357137.19.1724840601668; Wed, 28 Aug 2024
 03:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819064721.91494-1-aardelean@baylibre.com>
 <20240819064721.91494-7-aardelean@baylibre.com> <zuvwoy5wtdel7qgkz6wa6valwjwajpwoqnizyoooiawghrxvc3@cuoswu32h4fl>
 <CA+GgBR_V8r0Vz1PeKxwD6ovwHXxGM6=Z6XVd03ehokT5C3zjnQ@mail.gmail.com>
 <20240821212606.6981eae1@jic23-huawei> <46153017-9ab2-4a2f-afe6-9321e0f65f03@kernel.org>
In-Reply-To: <46153017-9ab2-4a2f-afe6-9321e0f65f03@kernel.org>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 28 Aug 2024 13:23:10 +0300
Message-ID: <CA+GgBR-ZPfJuOJJuXqUu6YEBmzHf6SLYWFprQUo8X-UhyRTyEg@mail.gmail.com>
Subject: Re: [PATCH 6/7] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 12:09=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 21/08/2024 22:26, Jonathan Cameron wrote:
> >
> >>>> +    type: object
> >>>> +    $ref: adc.yaml
> >>>> +    unevaluatedProperties: false
> >>>> +
> >>>> +    properties:
> >>>> +      reg:
> >>>> +        description: The channel number.
> >>>> +        minimum: 0
> >>>> +        maximum: 7
> >>>> +
> >>>> +      diff-channel:
> >>>> +        description: Channel is bipolar differential.
> >>>
> >>> There is diff-channels property, why do we need one more?
> >>
> >> Yeah, I wanted to use that.
> >> Maybe I will try another spin at that.
> >> The thing with "diff-channels" is that it requires 2 ints.
> >> So,  diff-channels =3D <0 0>.
> >> To use it here, a rule would need to be put in place where  "reg =3D=
=3D
> >> diff-channels[0] && reg =3D=3D diff-channels[1]".
> >> That also works from my side.
> >> Part of the reason for this patchset, was to also get some feedback
> >> (if this is the correct direction).
> >>
> > So I 'think' this is a datasheet matching thing.
> > In many cases, even for strictly differential devices, the pin
> > naming allows for a clear A - B channel description. Here
> > in the non differential modes, the negative pins are effectively
> > not used (from a really quick look at the datasheet)
> >
> > So we 'could' introduce magic channels (give them high numbers) for
> > the negative ends. I think we may want to do that for the
> > userspace ABI (0-0 on the few times it has come up has been a
> > calibration / self check mode not what you have here - it
> > wires the actual inputs together).  Alternative is just present
> > them as a simple voltage and don't worry about the differential aspect
> > as it's not hugely different to bipolar (where the zero level is
> > effectively the negative input of a differential ADC.
> >
> > For the binding I'm fine with the binding using A, A as you suggest
> > with an update to adc.yaml to cover this corner.

The main difference the "diff-channels" property brings is a change to
the available scales.
They differ a bit between differential, and single-ended (unipolar and bipo=
lar).

I'll update the adc.yaml file then.

>
> Yep, let's add it to adc.yaml.
>
> >
> > We never (I think) have bindings for the self check case where the inpu=
t
> > is wired to both sides. It's just a mode that is applied to
> > any inputs that are wired.
> >
> Best regards,
> Krzysztof
>

