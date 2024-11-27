Return-Path: <linux-kernel+bounces-423270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B579DA540
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3509F165866
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D741946D0;
	Wed, 27 Nov 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMis1mez"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848B18DF62
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701645; cv=none; b=csHQ8E8GOa2y96oVs7TJOLwF8a62ENWiJqxFiAGGp47AXPR1gnx6clJaSzehcK3KpYQAT1Ahfwj1UDEYGiXW+BzibOayS+3A7YACoFQR6zPUFKKb2qELTjDHgp1yF236CfkZmnOepg8McprZezLJBWkmNqMES/DlRm31LMmItBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701645; c=relaxed/simple;
	bh=zRYsYbGf/cDqfHjKWgxhLuI5WTXoZE+rVWtmg6t0YJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN4+o6sfXu33JN4DrJIfQgpW49bx3M+hMBjy+UTM8/tt1DIIGdBBe13V8Ai/BE5WaJoO4ABHYAwhbUA3NXLSkchS7SFqdL9IfmPlsjoeg0Tb987B3nNWAldHZWv/XxnWSMrWV6ee9rgM+wIufvJi4wZzKKGVVCRTu7d8JATnkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMis1mez; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732701640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0wPBAaMjSnNTX8RqBZAQUWmuUVI0sWePXuVzRgZ7Qw=;
	b=CMis1mezOLuEWSgzPQ9RrsOhrnjSsNheiPGpxoqKDYO2K9uxf7plcy8PFH/GE15MbgW0b0
	SHPWb5PD5IRRIHVlXjX2j+xnnS1UO4Ez4Pd3T4f69669NKiVy35ayDZv2hqepztoLl6lCt
	nIXZn4wf047neZz+OuAAioAxtQuIEzg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-hfhp4ZGsMraDcvFYILPDqg-1; Wed, 27 Nov 2024 05:00:39 -0500
X-MC-Unique: hfhp4ZGsMraDcvFYILPDqg-1
X-Mimecast-MFC-AGG-ID: hfhp4ZGsMraDcvFYILPDqg
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5f1f269bb5cso227394eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732701639; x=1733306439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0wPBAaMjSnNTX8RqBZAQUWmuUVI0sWePXuVzRgZ7Qw=;
        b=Ohk8B0WoeFbgza2F38fyoVXaBS3EbuPOnpvxzAqrKyqQHi9yL8rX2U+Bq76UJa/Who
         qrCbXhGnd65EUmplmS2pjDeQeAiV1Nz/TDJaqj1TZZGyBbb3xjyQZa1FwpmFtleJnmLO
         dJQ5OITbKT+z8kWPJpTe+AVosgfRwdjHFZVUXLN9eQMC+dC69Rmx5F2Qk6sePa+7M07T
         iSkHm0PIBfyQGscIbnK/veHOMruo1l50TT088F06StzBNDQVHEgcBFqMCfBcZAOa8GVy
         xB9h+p3QmuECX31DXsh028EAkOnKe02Cj3iyI5zkGATo7vmMNc0H86UwRUAlqeRVqeor
         NpnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6aQjjDpnzKAzoeo1WwuDX0yCw1Pf4mf5ehE8O1CGCIrua44aT3cqJadXwvlq5F8QRp+PZ0gO82I1Dulc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzK6ZA4Z1lsD5KfOlSKq86dke7Zo9+Q0T2jBSIv9VqpK2c0I/S
	WuYtQe6nl73L+DfTx2ljAW8dFjdMBcIl1kkHCxPenKYhXjG+1bff3HuFnOUyZtPqNJBZ9l4V3Kc
	JQVUnON2mce/532S92seWfngRA3VnysQ6141jmKX3v/JuQF0rYhtfFJT3lMa3fDZAY7EtPGEyRU
	MZjV+4jm9q4LxinfN1F/OIies85+V9xU7tr3xS
X-Gm-Gg: ASbGncvQw/kLcKwvmkq5zgQ3XzZuKYw+nk2Bt7iJ0056GElvqbHYQEPvltAPEGaiL1T
	n5aNSLJ2S5r54EoYIQPSATxkMP04Z+g==
X-Received: by 2002:a05:6870:c152:b0:27b:b2e0:6af with SMTP id 586e51a60fabf-29dc3fb9cd2mr485564fac.2.1732701638776;
        Wed, 27 Nov 2024 02:00:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxVRugfM1h6RP4poBOiNX8qRrDOehBisqylVM+eiLebPmXpS2cMHMjj58RYifbv8/vFUZK4bOyHhB27KGFiHc=
X-Received: by 2002:a05:6870:c152:b0:27b:b2e0:6af with SMTP id
 586e51a60fabf-29dc3fb9cd2mr485554fac.2.1732701638432; Wed, 27 Nov 2024
 02:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-am69sk-dt-usb-v1-1-aa55aed7b89e@redhat.com> <2nuncc5rscu6h74ylaiu6yozg34aoigaj5d4uzvdtolt5q7bmv@6hacpxyb2532>
In-Reply-To: <2nuncc5rscu6h74ylaiu6yozg34aoigaj5d4uzvdtolt5q7bmv@6hacpxyb2532>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 27 Nov 2024 11:00:27 +0100
Message-ID: <CALE0LRtUN2N_Z05jH_BMSg7yvirSRob0pSErmQxTu8AatmODgw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Add USB SuperSpeed support
To: s-vadapalli <s-vadapalli@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 27, 2024 at 9:27=E2=80=AFAM s-vadapalli <s-vadapalli@ti.com> wr=
ote:
>
> On Tue, Nov 26, 2024 at 11:08:19AM +0100, Enric Balletbo i Serra wrote:
>
> Hello Enric,
>
> > From: Dasnavis Sabiya <sabiya.d@ti.com>
> >
> > AM69 SK board has two stacked USB3 connectors:
> >    1. USB3 (Stacked TypeA + TypeC)
> >    2. USB3 TypeA Hub interfaced through TUSB8041.
> >
> > The board uses SERDES0 Lane 3 for USB3 IP. So update the
> > SerDes lane info for PCIe and USB. Add the pin mux data
> > and enable USB 3.0 support with its respective SERDES settings.
> >
> > Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> > Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
> > ---
> > I've been carrying this patch for quite long time in my builds to have
> > support for USB on my AM69-SK board without problems. For some reason t=
his
> > patch was never send to upstream or I couldn't find it. So I took the
> > opportunity, now that I rebased my build, to send upstream.
> >
> > I have maintained the original author of the downstream patch as is
> > basically his work.
> > ---
> >  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 33 +++++++++++++++++++++++++++=
++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dt=
s/ti/k3-am69-sk.dts
>
> [...]
>
> > +&usb0 {
> > +     status =3D "okay";
> > +     dr_mode =3D "host";
>
> Since the Type-C interface is also connected to USB0, shouldn't "dr_mode"
> be "otg"? Also, has the Type-C interface been tested with this patch?
> Please let me know.
>

Yes, all usb from the board were tested. I'll try otg mode for the
Type-C interface and resend the patch.

$ lsusb -t
/:  Bus 001.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
    |__ Port 001: Dev 002, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
        |__ Port 001: Dev 003, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
            |__ Port 001: Dev 004, If 0, Class=3DHuman Interface Device,
Driver=3Dusbhid, 1.5M
            |__ Port 001: Dev 004, If 1, Class=3DHuman Interface Device,
Driver=3Dusbhid, 1.5M
        |__ Port 002: Dev 005, If 0, Class=3DMass Storage,
Driver=3Dusb-storage, 480M
/:  Bus 002.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000=
M
    |__ Port 001: Dev 002, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
        |__ Port 003: Dev 004, If 0, Class=3DMass Storage,
Driver=3Dusb-storage, 5000M
        |__ Port 004: Dev 003, If 0, Class=3DMass Storage,
Driver=3Dusb-storage, 5000M

Thanks,
   Enric
> [...]
>
> Regards,
> Siddharth.
>


