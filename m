Return-Path: <linux-kernel+bounces-203603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 550D68FDDB5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8FB1C2247C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856571EB56;
	Thu,  6 Jun 2024 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F53KhOar"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534419D88B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 04:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717647370; cv=none; b=rsBzpSXVKBLKWQDCpYpsii8TOQPZk+X5DUCiYS8MPHf8ZGt7FgQ718CD7+VgIh4yBFc/pVGMcmQXFFbVHsT+ffTLsomd0rMcKlSRPumbaQRRCzAxexpLiNf7enrsxCduxZNiI7UrvdbbI1ikbP9ISfIz19UEv3qUCYJbYBuYJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717647370; c=relaxed/simple;
	bh=xUVakT0kzBhnD2BXL7s4n6v3zUaDCDz4HZiAPLEVR3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsZq9/Rhzy4BSfWUmWsx1MhQ6PIhPx/6szE+8WaUCvismmshhdX90mLrmHgiIb8HBng55d3Dmm/4itdLaJgsk49Nrz9SDx1+mNnv2YnzDrfmy73r2JmvhTd5w4uEs7SWgf49btnu8teLe9NknuohPdbeFMiF/af6fOy/RCGVr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F53KhOar; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso621185e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 21:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717647363; x=1718252163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URXRNILWO7LZ/MwdWR1JeNjmEaFUftirMHuX7Pvwbt0=;
        b=F53KhOarTSlkvbJ5UxGFbZDfIERfCjEXq2omofNjtJGU/hrqoSi0Zlkwbmy6dKb48b
         +o/HUEBiwhYHl/Oz9t3IXJB8dw2u5MaizsBRGz0WDoF+ySYdrhO5MMIRNaEvrwX+o9kn
         kyCywiAeTWKuPxZtcjqpdX7zdAUnqIuji88ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717647363; x=1718252163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URXRNILWO7LZ/MwdWR1JeNjmEaFUftirMHuX7Pvwbt0=;
        b=QHNlewV2TwM1/Y1BMrgPSZLmrzZI1ZZMDcRkGA8PEMBrFS5qXg0JaAkOxQSL4lbN8W
         h8FNTZDihYuyTxvaPlMU4t3FrGNhcVkcWkxmTTcCGPdHE5fYzJX9b05HMbtnbPSv7Fm0
         5Pk0AlbfJvi1DFUcLzq4dImPb0sUsELlckDzpojDeVieYfS7WgVqFfkNgxK7rpSSLf7M
         RNENVNmx18k3qavXxe3i5dQSzeUZORoj8+ShJz76l0uu2yWXf6F9EsKyWlL02NaNkI6Z
         0yYXKZPsLvNS34gRbMR86NnQDrfTccj7J0hCzfCrpplIAnz3nKGHu7SyUuPLIxK/LBXE
         cIPg==
X-Forwarded-Encrypted: i=1; AJvYcCUavg/SCJbUXTxa7j970Hzw+8j+2xe4hYsSzR/hnD8gBJE0dxM7WDQItTRQ51ykum3/cWiQfqKeLgaZBcRItXA2loDPz39ygUZwzeIm
X-Gm-Message-State: AOJu0Yz50rRpj3ZCQnsn2hUeI+N/MxmRzt1fVlNL53SHB5bs1JtyCfZl
	vl05AadRlydcLcY5zWZxv10kip71l3RD9vdhbjeB21o9B4aGY9O4njj0Lh86T6sIWdZfMTxmk3e
	6LWQzKR2qz6zxGKnzg84r9HZJt8N+hpA5Y9L4
X-Google-Smtp-Source: AGHT+IGDVi0x5PPWVVdHgpTQNURWwUeBkukHjuXk6z91V1QZIIbvs1uZFVAc1YhlkbIbH5GhY2rOcvp/C0AgH6thkKk=
X-Received: by 2002:a05:6512:b88:b0:51b:4204:2f51 with SMTP id
 2adb3069b0e04-52bab4b7f8fmr3100481e87.8.1717647363043; Wed, 05 Jun 2024
 21:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e5912054-0fc9-47ff-8f38-9b9a3e9d2156@notapiano>
 <CAGXv+5HJKur9vWq4j_x7-fuL5H0SY_oQNYFWTxFCC1EBxF9yQw@mail.gmail.com> <2491f962-a8e1-44c4-8ff9-f8c3e58a2a39@notapiano>
In-Reply-To: <2491f962-a8e1-44c4-8ff9-f8c3e58a2a39@notapiano>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 6 Jun 2024 12:15:51 +0800
Message-ID: <CAGXv+5HjRmn5o6uogn89OMLONWWaxBA5MJNKCesYXoR7G_FOEA@mail.gmail.com>
Subject: Re: Probe failures on mt8183-kukui-jacuzzi-juniper-sku16
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: linux-mediatek@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 8:33=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Wed, Jun 05, 2024 at 04:01:06PM +0800, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Tue, Jun 4, 2024 at 11:52=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > Hi,
> > >
> > > We're monitoring the status of device probe on the
> > > mt8183-kukui-jacuzzi-juniper-sku16 platform in KernelCI, and I though=
t it'd be
> > > helpful to share the results.
> > >
> > > These are the current failures:
> > >
> > > * /soc/i2c@11009000/trackpad@15
> > > * /soc/svs@1100bc00
> > > * /thermal-sensor1
> > > * /thermal-sensor2
> > >
> > > In more details:
> > >
> > > * /soc/i2c@11009000/trackpad@15: I believe this is a second source tr=
ackpad and
> > >   is thus waiting for the "platform/chrome: Introduce DT hardware pro=
ber" series
> > >   [1] to be merged before it can be handled. Although looks like ther=
e haven't
> > >   been updates to the series in a while.
> >
> > I've been working on other stuff and haven't had time to respin this se=
ries.
>
> No worries, but it's good to know that that's the latest status and I did=
n't
> miss something.
>
> >
> > Just to confirm, is the failure due to pinctrl conflicts when the track=
pad
> > variants probe asynchronously?
>
> Yes:
>
> [    2.185408] input: hid-over-i2c 06CB:CDB5 Mouse as /devices/platform/s=
oc/11009000.i2c/i2c-2/2-002c/0018:06CB:CDB5.0001/input/input2
> [    2.845044] mt8183-pinctrl 10005000.pinctrl: pin GPIO7 already request=
ed by 2-002c; cannot claim for 2-0015
> [    2.854700] mt8183-pinctrl 10005000.pinctrl: error -EINVAL: pin-7 (2-0=
015)
> [    2.869503] mt8183-pinctrl 10005000.pinctrl: error -EINVAL: could not =
request pin 7 (GPIO7) from group GPIO7  on device pinctrl_paris
> [    2.894885] elan_i2c 2-0015: Error applying setting, reverse things ba=
ck

Yup. That's the issue. We work around it either with staggered driver probe
(built-in vs module) or move the pinctrl up to the i2c bus node.

> >
> [..]
> > > * /thermal-sensor1, /thermal-sensor2: The following is reported:
> > >
> > >     [    2.813605] thermal_sys: Failed to find 'trips' node
> > >     [    2.813611] thermal_sys: Failed to find trip points for therma=
l-sensor1 id=3D0
> > >     [    2.813619] generic-adc-thermal thermal-sensor1: Thermal zone =
sensor register failed: -22
> > >     [    2.813624] generic-adc-thermal thermal-sensor1: probe with dr=
iver generic-adc-thermal failed with error -22
> > >
> > >   And the same for thermal-sensor2. So both are missing the required =
'trips'
> > >   subnode.
> >
> > IIRC either the driver or the DT had comments saying "these zones don't
> > need trip points". In that case maybe the driver should use
> > thermal_tripless_zone_device_register() for them?
>
> I believe you're thinking of the SoC thermal zones, which had trips added=
 (and
> the comment removed) in commit 978979409209 ("arm64: dts: mediatek: mt818=
3:
> Refactor thermal zones"). But these are the kukui board thermal zones.

I see. I dug through the schematics we have, and they all seem to say that
the first NTC is for the SoC. The use for the second one seems to depend
on the project, with some saying close to the LCM (display?) or LTE PA,
and on the Jacuzzi family it's for ambient temp.

Regarding trip points, for the NTC close to the SoC, I guess we could copy
the SoC thermal trip points and reduce the values by some amount, 20
degrees maybe? For the other one we could probably make the critical
trip point some value that feels hot to the touch?

ChenYu

> The thermal-zones dt-binding does describe the 'trips' node as required, =
so I
> think the only option in this case is to add trips to them, or remove the
> thermal zones altogether. I'm guessing the
> thermal_tripless_zone_device_register() helper is meant for other thermal=
 zones
> that aren't described in the DT.
>
> Thanks,
> N=C3=ADcolas

