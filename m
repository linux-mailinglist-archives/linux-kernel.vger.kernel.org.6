Return-Path: <linux-kernel+bounces-424501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479999DB505
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA40167BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFA0156F5F;
	Thu, 28 Nov 2024 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8ptslbz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD45155C83
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787282; cv=none; b=Z5Zsp3BSsc1YxG7beXoozlTp0CA1knYTFEfSopk/NzuHS5jTOJjpMsVFvJHfximHuLqzByi7ELZYgpWe3lHlPH26bm1TTfG+VJrFEKqqygEf61DistUOjXXzpMVi3vD0iHEI2yyYNc3EsESwp8kq/qa2jLEmyqJY2ZLx+E1M4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787282; c=relaxed/simple;
	bh=IzibHMJzFiD5Dua2J4TNL4jqP8yxjzvGE85oSCdZ9sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBTkefXNBqq0K+60icFXtLuz/xXt2vfU6IknvQj8eYhzWe7ArgTLozvbTbvKGwq4d+/6WrUxMtVAqKwck9r7bqwFo6i27ikNWHM0H+ArXS9bZS0Rmo9IK+MHfZuOPkZoFu2DHXuId5fQu4YBl5zQFv4biwuEX/QzMrMpejq9XSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8ptslbz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732787278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNbRZATueezg81CZReVlx5jV0RK0ryx+s0XgVPaZYI=;
	b=A8ptslbzi50H0PxI4qfnUwn1utvOct4pOmz8Bs20PyNEXyOaSYZVFyJTI9z/6T5+wHIp38
	ycYRAlu42o6/mC5VFv4XYhbErZ/foyqVIVRHpVMlD1qUJnq4lBFOm+LFKJyQzxhXz4nKnX
	JDbxKwsgu8k6N4IzvY2ZGZWyQhN8mvI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-b6vUvqISP6a0c7wZETnP9A-1; Thu, 28 Nov 2024 04:47:54 -0500
X-MC-Unique: b6vUvqISP6a0c7wZETnP9A-1
X-Mimecast-MFC-AGG-ID: b6vUvqISP6a0c7wZETnP9A
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5ee1d5de51fso15939eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732787274; x=1733392074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oNbRZATueezg81CZReVlx5jV0RK0ryx+s0XgVPaZYI=;
        b=Td/pRKVV73+iWl9sqFQhnNbpFOWKqKVdlr6fG0oIZL1ppUabEd/J8JxGiZI4xulXnL
         WAGkgBSZ4Zdh1EOZ4jODe9k8b32QQMqUMQ8Jb/LO6LzNswNDxnNHnP7iTVPN3iD6qCg+
         RQCA06jEL1GH5ULPsPkYokuHx2MrcheRBTN/Gw2v5U0V7ANtQZyh0LqpCgO28PgmdCGN
         IRDy/Nu8scrCRkp1ijPAZRJGIttOj1Yv/GpksF2YBipPGoLonxqfp4B3U/drJwTdAO+y
         Lw5Itb0flImUVBw+vHOmwBO2GUM3X5auuIL+rkADtQV1AhWAURg/ieGELNoc5YAdpMmq
         HF4A==
X-Forwarded-Encrypted: i=1; AJvYcCVPIEAk41GAIvbUJyajSGoJXQPazeb1dmlqhuFrDE2DSQJbXYnYTAMKk9ohArLyYAXTuETwJLKq18f+p8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxubn2KuXVMKaZ+Ss3wAlN3czIGQDXDX6cCLs6ZRKJcB5vnJEW1
	ATv3Xs0QwNm54LTBTWXjv40L8GIznRcg+R7YVyrf2986fhX8XpHEFTSS+eP8Nrhqet2BgecvsF9
	E+EW+6WQ4zxmLMwSao9SAI/uWrKhC8SshvV8Aa+w+c2gGTN2MNgm4G0UpcXaOghgLo0qw4wnbSc
	S/byqlDNkQKV6SYU7K+4AvwOse15oL+uiffWOC
X-Gm-Gg: ASbGncsZKyeEIm53t/KOyuSIjXhKGkttde+8ajloep00QNVGiJY4WvWVIvwJ6dX7r/f
	g7YyY6+11eLXRKvymzfOf0wc3RkEMxA==
X-Received: by 2002:a05:6830:3146:b0:717:f7b9:e229 with SMTP id 46e09a7af769-71d65d30197mr1404035a34.7.1732787273868;
        Thu, 28 Nov 2024 01:47:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTAME9UHHiL0FJTpRauKthCid+eKGwe6kyh+EMyOOhg7rXyOzJ0JB3RkIoWUs3QEYs+kMb3CeH/rBKs806tdc=
X-Received: by 2002:a05:6830:3146:b0:717:f7b9:e229 with SMTP id
 46e09a7af769-71d65d30197mr1404027a34.7.1732787273591; Thu, 28 Nov 2024
 01:47:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-am69sk-dt-usb-v1-1-aa55aed7b89e@redhat.com>
 <2nuncc5rscu6h74ylaiu6yozg34aoigaj5d4uzvdtolt5q7bmv@6hacpxyb2532> <CALE0LRtUN2N_Z05jH_BMSg7yvirSRob0pSErmQxTu8AatmODgw@mail.gmail.com>
In-Reply-To: <CALE0LRtUN2N_Z05jH_BMSg7yvirSRob0pSErmQxTu8AatmODgw@mail.gmail.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 28 Nov 2024 10:47:42 +0100
Message-ID: <CALE0LRu-Sx5oTVNY3hm+Msu-zb04a7_ZD+r3xF1eRfR_WtK0VA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Add USB SuperSpeed support
To: s-vadapalli <s-vadapalli@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 27, 2024 at 11:00=E2=80=AFAM Enric Balletbo i Serra
<eballetb@redhat.com> wrote:
>
> Hi,
>
> On Wed, Nov 27, 2024 at 9:27=E2=80=AFAM s-vadapalli <s-vadapalli@ti.com> =
wrote:
> >
> > On Tue, Nov 26, 2024 at 11:08:19AM +0100, Enric Balletbo i Serra wrote:
> >
> > Hello Enric,
> >
> > > From: Dasnavis Sabiya <sabiya.d@ti.com>
> > >
> > > AM69 SK board has two stacked USB3 connectors:
> > >    1. USB3 (Stacked TypeA + TypeC)
> > >    2. USB3 TypeA Hub interfaced through TUSB8041.
> > >
> > > The board uses SERDES0 Lane 3 for USB3 IP. So update the
> > > SerDes lane info for PCIe and USB. Add the pin mux data
> > > and enable USB 3.0 support with its respective SERDES settings.
> > >
> > > Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> > > Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
> > > ---
> > > I've been carrying this patch for quite long time in my builds to hav=
e
> > > support for USB on my AM69-SK board without problems. For some reason=
 this
> > > patch was never send to upstream or I couldn't find it. So I took the
> > > opportunity, now that I rebased my build, to send upstream.
> > >
> > > I have maintained the original author of the downstream patch as is
> > > basically his work.
> > > ---
> > >  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 33 +++++++++++++++++++++++++=
++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/=
dts/ti/k3-am69-sk.dts
> >
> > [...]
> >
> > > +&usb0 {
> > > +     status =3D "okay";
> > > +     dr_mode =3D "host";
> >
> > Since the Type-C interface is also connected to USB0, shouldn't "dr_mod=
e"
> > be "otg"? Also, has the Type-C interface been tested with this patch?
> > Please let me know.
> >

So I changed the dr_mode to otg instead of host and tried to configure
a usb mass storage gadget but unfortunately didn't work, but this
could be a driver problem, I got the following error

  UDC core: g1: couldn't find an available UDC

As the devicetree should describe the hardware, and as far as I can
see it should support the type-c port act as a gadget, I'm fine with
changing the dr_mode, unless anyone have more information about this,
the thing that makes me think a bit more is that, in the TI kernel
this is set to host, so I'm wondering if I'm missing something or is
just that was never tested.

Thanks,
  Enric

>
> Yes, all usb from the board were tested. I'll try otg mode for the
> Type-C interface and resend the patch.
>
> $ lsusb -t
> /:  Bus 001.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 48=
0M
>     |__ Port 001: Dev 002, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
>         |__ Port 001: Dev 003, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
>             |__ Port 001: Dev 004, If 0, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 1.5M
>             |__ Port 001: Dev 004, If 1, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 1.5M
>         |__ Port 002: Dev 005, If 0, Class=3DMass Storage,
> Driver=3Dusb-storage, 480M
> /:  Bus 002.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 50=
00M
>     |__ Port 001: Dev 002, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
>         |__ Port 003: Dev 004, If 0, Class=3DMass Storage,
> Driver=3Dusb-storage, 5000M
>         |__ Port 004: Dev 003, If 0, Class=3DMass Storage,
> Driver=3Dusb-storage, 5000M
>
> Thanks,
>    Enric
> > [...]
> >
> > Regards,
> > Siddharth.
> >


