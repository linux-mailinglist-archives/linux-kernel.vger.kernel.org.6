Return-Path: <linux-kernel+bounces-330203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB85979AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA68E1C22651
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7FB39AD6;
	Mon, 16 Sep 2024 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjMxRi52"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630CA381AF;
	Mon, 16 Sep 2024 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726466240; cv=none; b=b9JAbR473GNNpU0bld73RDqcGvUN0AUG3AQJ/6sunTXwxBAIuL2CDoq9v/1NOxhkEZzzbdpMD9avYcWyN5Z0tMYih7hGmpsjDhApZnDZIpOP2M5u1HtiA0fhsnsrxrNy1B0TtHHLlVjWHbMZld1dNQ1CnWY+4a7JckQ3ME5YNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726466240; c=relaxed/simple;
	bh=heu3h5xPTZynklA/KdK+Bu/fXkHcxEz7osud4gmzRQs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mSP3/OaSTxiCg3i2tPIfSvVh/kON8Cy9xWx+UKM9tXb8S2Z6sezLNXvsyXreWax82r6W64tnlg3uzjKe0WcTYgb9FXk+ednGeR710DUOvpvvi6HepdXNWBB4zISEgEsE8onPBCnZSkWYZewPbO0rg8AVjEZgyYsjdObDULHfTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjMxRi52; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so40010975e9.0;
        Sun, 15 Sep 2024 22:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726466237; x=1727071037; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl+2AAWYETldwVjUaHiUK47kWu/JCIO2jHwLCtQuXp4=;
        b=PjMxRi52A+BG3ihYNviXV6+loZf0Vwn8pa3BEqEdd7OQF2GP6Sa3vjiqVorKzfKASK
         +wEie3HU5WjCqCrJMtCeW6gfEAsqySN8/JMPPXSFKwoHrDKhfZNSSUa0P8hdWZEPHg/m
         +x5wucbEnbFhYt+yHdYJE0QwceOXk0SBG1kvf3xt5Hrm2bBaCY7+0xmzD2d828i9nQxa
         RY+OMPBeOjzQ+QfH+RrKdtrtkmDr+wq/BHV6duict2CYtzP0Ar7awDQufmcYOxE60psl
         XlNG6pCR0khYjrF1EgjnIS+xVy+upbDkL1RruNVT0AZnVOEP52FqSz7TR/xRpNqkgRCk
         D57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726466237; x=1727071037;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl+2AAWYETldwVjUaHiUK47kWu/JCIO2jHwLCtQuXp4=;
        b=ZBZq3CTKoDgsCgza3szzVp1c5Sqm2ziW/pyEwhJhCc4zpnavbvnyeR4MD6LRMbOR0t
         MrFaRowlFNvifi6IvwKk1xXS7lHpWenXm1EUEKEDvGdtZu8UflQk5nu/tgY06UPGEj6P
         quop+i082VcQk18r3GdWl9pTd1z4k496hVcYUl9bvVC5ftJog1b0a6k8U2wDdpQJb/w+
         INHchYJTGsxu6GxDpYxXRHSq0HcikeRJreN73CSs1jy5NiYNMaSsMCOIYGDpIYLykvou
         OF7RkyQ7TMtFW9rSpMmTFHsofFVxdIEgxL/cfW05gVKeK2dWzbwfK5F/FnfrmXLXLtSP
         8b7A==
X-Forwarded-Encrypted: i=1; AJvYcCVn3eu5Wze+XvQjEGZj0ukcr51YqpeUp9CsMobdNIy+nYMaTeujJKMWm2DhsYo4ZRjuFOQjG/y8CgGckWbg@vger.kernel.org, AJvYcCVxlm7ER/hqhA5I2nSS7JOA0FPp9Q6Zxn+A2ViycaYTHx/g5qvEbL/IbDBQGd3mwpd8YD/gLI7Pfw92@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVMWOhCADOPmic5BWgXQZtsXoaGPiGqLrTjl6Cbz8B1w93hkD
	nRYxwmT894qzbZLFh1EQCqCTfUuyI7GLkYyWi6hD9cGy7ntTUqRO
X-Google-Smtp-Source: AGHT+IEUrSWUGDZnMQIILFOWp5/d6rroNjHBe56J1xM6fccQhg4po9Tmf6aYuU2sa0K/wdKqgsJ0sw==
X-Received: by 2002:a05:600c:5248:b0:42c:de6e:7f4d with SMTP id 5b1f17b1804b1-42cde6e8056mr96239625e9.34.1726466235893;
        Sun, 15 Sep 2024 22:57:15 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc137556esm193612195e9.1.2024.09.15.22.57.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2024 22:57:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 4/7] ARM: dts: amlogic: meson6: delete undocumented nodes
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAFBinCD+txhz0x20LXhydZpLk=u4d9FT4=1sOX1bKuDeQqsMjQ@mail.gmail.com>
Date: Mon, 16 Sep 2024 09:57:01 +0400
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 AML <linux-amlogic@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DAFA9AA0-F51E-438E-A486-389164C043CE@gmail.com>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
 <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-4-feaabb45916b@linaro.org>
 <CAFBinCD+txhz0x20LXhydZpLk=u4d9FT4=1sOX1bKuDeQqsMjQ@mail.gmail.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3776.700.51)

> On 15 Sep 2024, at 11:12=E2=80=AFPM, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> Hi Neil,
>=20
> On Wed, Sep 11, 2024 at 12:19=E2=80=AFPM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>=20
>> Delete nodes in meson6.dtsi that are clearly undocumented & unused =
for meson6,
>> fixing the following check errors:
>> audio-controller@5400: compatible:0: 'amlogic,aiu' is not one of =
['amlogic,aiu-gxbb', 'amlogic,aiu-gxl', 'amlogic,aiu-meson8', =
'amlogic,aiu-meson8b']
>>        from schema $id: =
http://devicetree.org/schemas/sound/amlogic,aiu.yaml#
>> audio-controller@5400: compatible: ['amlogic,aiu'] is too short
>>        from schema $id: =
http://devicetree.org/schemas/sound/amlogic,aiu.yaml#
>> /soc/bus@c1100000/pwm@8550: failed to match any schema with =
compatible: ['amlogic,meson-pwm']
>> /soc/bus@c1100000/pwm@8650: failed to match any schema with =
compatible: ['amlogic,meson-pwm']
>> phy@8800: compatible: 'oneOf' conditional failed, one must be fixed:
>>        ['amlogic,meson-mx-usb2-phy'] is too short
>>        'amlogic,meson-mx-usb2-phy' is not one of =
['amlogic,meson8-usb2-phy', 'amlogic,meson8b-usb2-phy', =
'amlogic,meson8m2-usb2-phy']
>>        'amlogic,meson-gxbb-usb2-phy' was expected
>>        from schema $id: =
http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#
>> phy@8820: compatible: 'oneOf' conditional failed, one must be fixed:
>>        ['amlogic,meson-mx-usb2-phy'] is too short
>>        'amlogic,meson-mx-usb2-phy' is not one of =
['amlogic,meson8-usb2-phy', 'amlogic,meson8b-usb2-phy', =
'amlogic,meson8m2-usb2-phy']
>>        'amlogic,meson-gxbb-usb2-phy' was expected
>>        from schema $id: =
http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#
>> /soc/bus@c1100000/mmc@8c20: failed to match any schema with =
compatible: ['amlogic,meson-mx-sdio']
>> mmc@8e00: compatible:0: 'amlogic,meson-mx-sdhc' is not one of =
['amlogic,meson8-sdhc', 'amlogic,meson8b-sdhc', 'amlogic,meson8m2-sdhc']
>>        from schema $id: =
http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
>> mmc@8e00: compatible: ['amlogic,meson-mx-sdhc'] is too short
>>        from schema $id: =
http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
>> remoteproc@1c: compatible:0: 'amlogic,meson-mx-ao-arc' is not one of =
['amlogic,meson8-ao-arc', 'amlogic,meson8b-ao-arc']
>>        from schema $id: =
http://devicetree.org/schemas/remoteproc/amlogic,meson-mx-ao-arc.yaml#
>> remoteproc@1c: compatible: ['amlogic,meson-mx-ao-arc'] is too short
>>        from schema $id: =
http://devicetree.org/schemas/remoteproc/amlogic,meson-mx-ao-arc.yaml#
>>=20
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Generally I'm fine with this. I'm wondering if we should go one step
> further by decommissioning Meson6 support?
> To be specific here, I'm thinking of removing MACH_MESON6 from
> arch/arm/mach-meson/Kconfig and deleting meson6{.dtsi,-atv1200.dts}
>=20
> I don't have any boards with Meson6 SoC, there's no upstream GPIO,
> pinctrl, clock, MMC, <you name it> driver for that SoC either.
> So all we have upstream is the ability to boot to initramfs and use
> serial console(s).
> If someone is interested in Meson6 support they should bring it back
> along with a few more patches for upstream support of further
> peripherals.

I think that=E2=80=99s a sensible move. LibreELEC was one of the few =
distros
that supported Meson6 hardware in the past (via the vendor kernel)
but we ended support in 2018. Meson6 devices are mostly/all? cheap
Android boxes dating from 2011-2013 and these have either been been
discarded by users through upgrades or the boxes died long ago. There
is still community interest in supporting Meson8 boards (the 8x core
devices are used for retro-gaming) but not the earlier Meson6 ones.

Christian=

