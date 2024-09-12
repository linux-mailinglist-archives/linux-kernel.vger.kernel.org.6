Return-Path: <linux-kernel+bounces-327282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3F977354
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28B7B21A80
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5E81C2314;
	Thu, 12 Sep 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBoviauP"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393F1C1AC9;
	Thu, 12 Sep 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175206; cv=none; b=PGOzmy9cfw0aVtM+ZCE2MWMVASoyiniPSfJ70sJ4oHW8esQtrScVBWuGfJdgV7V+qoiLR7oDKo6nXQPW7ATEJexpGdewvcIPZx5IiGNBNvzW7O7x7bwuXX50kXrFmM+VJJSfi/nYSN98VP5o6CctwTIenOa5FtvywBePrJU3ZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175206; c=relaxed/simple;
	bh=HNLAMrxrjiMfUQP1t9c/9Bsvhia8nbus+nR8JGadFp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVUo8bnVfqOVqw8RdAvDB6pIX8fzN3+8y+86D9G9BlFWWiFwnhRT/aQthOxqVaUir5A3PR7wwIzuOrvPDI3mAm3tHDJzg/SpuQ2OCSX2eFwNFT5awKAMwPr8kZxtMekbHo4pUIKaTV7fcO9a/KvOs4+EzR9JEQ10i07kwVsfghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBoviauP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d4979b843so194453266b.3;
        Thu, 12 Sep 2024 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726175203; x=1726780003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3icDhOuZ25W4TPAI+V+FnNmr4Y9zRWbBHCfxgpLHww=;
        b=FBoviauPbBHDgUXMxplHap8uZjk+c4HrU1SLbMkOwo0AWXqruo5LDmB1sjDhIW9Okv
         kd952ETb6DMqxXBmhFFE4Qo9lK8Wmik5LadBgxe14JXYdP+i/uocFbFqsIdUEDXD/KLQ
         byM37Lgb96YmmbSIywZAzPtS3pWDqNhpuNPLvss8Ng1pZFL/znO2ew+8FsKYbND/f66N
         weMxdm3ZmQOb91cfAZXURfBV5rgCc/9a+trqYHqBWMcmb7f9OZXRXAR4hqzKe+87jigr
         OF2vQPTHZZbPYzAot3D0PAN4cKC1lePJahebkPTfMjLeWkmxduWO0XuZzkWZcNMgbFYf
         +ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175203; x=1726780003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3icDhOuZ25W4TPAI+V+FnNmr4Y9zRWbBHCfxgpLHww=;
        b=fi2F3hR8qR6aoMUtsVO6VPwzt9WY3fnjO5VDmMQ2OQA6dR75y19VMdR6BoS9dEVcPq
         8wB2f+4qWTB7cplh7Fet0NsIEvpkIpKZPIiJ4HUpyFhnFviK867KHnJ4EcZ2i2rmBjQn
         /oggzoWin/uq8qbWayaeerQiIc//GZQxgynpJTm2eBsYPof+t+t1MT6cdCMThZhaIjZH
         Yn5b8hD9diGpSyFZPaDo5rFRBvGveMoI5vVQoSGzlvGsjRrv10NlA9uqVlwPD9zLSEBz
         a4SAGOKpXkg7fSoljTzkdKpPTlId9IIDw35yTMUVHx1gj6dwKtfv43Y7vE5yraallQDd
         Xqhw==
X-Forwarded-Encrypted: i=1; AJvYcCUyf1jJtVNs8gOGBf/kfNWv2GsT6uQ0/eVuV8WQatmABiA3jNzNLpSiPTAc1kJMVIDLmWTVRIPVdMmha1kh@vger.kernel.org, AJvYcCV9B+iLU/+u4hAzzmcsNajnGUmit0I2pJL/zEOc/M30e3bOxFT1B6WWL2uATrLVA63Y/wPNvMLhnCkd@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOTpJ5W7uwk84v7sYplqxbCDYyW/TVPLRvxvjhmykgbrXbhum
	tehZMYBOhfJM3M9Hw0OlgCHBVKM8+HFcbHE/VrvTCW2Hiu+iVccfHYSenGutlrHZ/+VMg52zU15
	6pwDneCDXrABmNBo4F54rldSGFe8=
X-Google-Smtp-Source: AGHT+IFrQrdqAxHzrPLVGz1hbEuwHetZrtXDERaEA0Nn5RHxr3g5dYXt3TyxDHWraN+GSFlYSOXR30ibkiavfFB5P2Y=
X-Received: by 2002:a17:907:f168:b0:a77:d52c:c42d with SMTP id
 a640c23a62f3a-a902941e749mr390227666b.13.1726175202427; Thu, 12 Sep 2024
 14:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912025034.180233-1-CFSworks@gmail.com> <20240912025034.180233-5-CFSworks@gmail.com>
 <ed4b6913-f19b-4280-b3b2-f5bb1e7f47eb@kwiboo.se>
In-Reply-To: <ed4b6913-f19b-4280-b3b2-f5bb1e7f47eb@kwiboo.se>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 12 Sep 2024 14:06:30 -0700
Message-ID: <CAH5Ym4jEMvBVQNNS6U49RWTAVPX4GmOVC-VjgXsFCR=X68QWgA@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: Enable all 3 USBs on Turing RK1
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>, 
	Chris Morgan <macromorgan@hotmail.com>, Alex Zhao <zzc@rock-chips.com>, 
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Jing Luo <jing@jing.rocks>, 
	Kever Yang <kever.yang@rock-chips.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Daniel_Kukie=C5=82a?= <daniel@kukiela.pl>, 
	Joshua Riek <jjriek@verizon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 12:53=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wr=
ote:
>
> Hi Sam,
>
> Sounds like this may be missing
>
>         rockchip,dp-lane-mux =3D <0 1 2 3>;
>
> or
>
>         rockchip,dp-lane-mux =3D <3 2 1 0>;
>
> if all lanes are used for DP and none are used for USB.
>
> It should help describe the hw and also help the driver set mode to
> UDPHY_MODE_DP and that should disable the u3 port, or there may be an
> issue to fix in the phy driver.

Thanks for your insights Jonas!

I haven't yet gotten to DP enablement so I don't know the correct DP
layout. Ultimately I do want the USBDP0 node to have the necessary
properties for DP, but alas that's a patch for another day.

Nonetheless, I briefly tried it and I don't think UDPHY_MODE_DP
affects the PHY's "backend" (ctrl<->phy iface) at all, only the
availability of frontend lanes to the USB-specific backend: So port u3
is still enabled, there's just no way to reach it electrically.

With that in mind, would you recommend that I add a placeholder
dp-lane-mux of 0 1 2 3 for now, just to keep the PHY from attempting
to speak USB to a DP device? I don't foresee any harm in leaving it
as-is but you may know something that I don't.

>
> > +     status =3D "okay";
> > +};
> > +
> > +&usb_host0_xhci {
> > +     extcon =3D <&u2phy0>;
> > +     maximum-speed =3D "high-speed";
>
> If this only use the USB2 phy, this should probably also override the
> default phys and phy-names props with:
>
>         phys =3D <&u2phy0_otg>;
>         phy-names =3D "usb2-phy";

I agree completely: if the controller doesn't need the USB3 PHY, then
it should not (implicitly) be specified in the DT. Being able to add
these overrides is a big goal of mine as well. :)

Sadly, `phys` is what initializes USBDP's USB-side backend, so without
it the RX_STATUS line goes floating, and because the controller still
expects a port there, it misbehaves:
[   30.981076] usb usb2-port1: connect-debounce failed

I can tell the controller that there is no u3 port by doing this in U-Boot:
=3D> mw.l 0xfd5ac01c 0xf0000000 # usb3otg0_host_num_u3_port=3D0
=3D> boot
...and that makes single-PHY operation work perfectly! But unless
Linux itself effects that change, this patch can't rely on that GRF
being set correctly.

Do you have a recommendation on how I might go about disabling this
port? I sent a patchset last year [1] that had the DWC3/xHCI driver
ignore enumerated u3 ports when the maximum-speed was set to
high-speed, but the consensus seems to be that this shouldn't be
addressed at the xHCI driver level, so somehow zeroing the necessary
GRF bits sounds like the way to go here. What do you think?

Kind regards,
Sam

[1]: https://lore.kernel.org/all/20231208210458.912776-1-CFSworks@gmail.com=
/

