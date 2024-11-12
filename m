Return-Path: <linux-kernel+bounces-406058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BAF9C5DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF54B279AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DE11FE0EE;
	Tue, 12 Nov 2024 14:36:16 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18291FCF6C;
	Tue, 12 Nov 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422176; cv=none; b=AEWOxDfKWxjEOeqUcwSbj6qa33ndnPkeNU8taA8qqVhUeGOKhss56gBNC0jm+RIfuaTlqV8p+5FHuLl9qRKBwNF0PTrISTUdkBQRVU4XmvfDAdAIyhMC/q9671f+3Rjlz2ENrabFuwacy9nyOTuXzNL4iYDqYb7O+N2ej+pRv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422176; c=relaxed/simple;
	bh=Swj4SJsULX+YIa8TLSPmrrh1lNABYWXUZCNeI6pAgC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofDxr9m1kuhrYoBrqMLzgQi4hCeteCgYB87n6hb7l/Su4/HlUYqJM2JW61mqyhPfvifg1xD1rP/g82jG1PE7MRJpatxl4nLjklolZocAyh9RwdK0kt16Y0/LlQJ7Fy6eQ6oiJpJsdd4Vq3UdVKf7xjXKTQriAKcaQlcREmsorFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cb7139d9dso53249235ad.1;
        Tue, 12 Nov 2024 06:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731422174; x=1732026974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU6W7rKC1LDOoPqE+zgv8rY63qL2TykSBZFtxfoHqJQ=;
        b=b4fG0o/09cBIx8Z6h4prwEcRDFmVomAXLOQC8+FBVg4RDIU1iI6WtVIfqpbzr6aqAt
         +9eYCkXbWkWUfGbjMPNtMifED+7NJWm7d6sExSUBWg4pfXTYG3GOULVxNYJeqdDE4zFn
         fBFLo8nlGBLuEmp5H8F9fe1wLwwIeGFCSIcIG4Ur9HiFiWP4rde+iToDhpITnklwqykf
         XmO5dLnz/ht5BHeZ6wYUcQUZz4ovLsLggZzKd2/9c4chw0cxQBFCsY42RO21jRJx9FeY
         KHSemnr8JuB4N2cH6X+gpGRTqXVmGOr+VWkWJRD3n29UTJAbgweM0Hps0V0R8LaeGZL7
         g2ng==
X-Forwarded-Encrypted: i=1; AJvYcCUKgXyw0OjfYUeFN2UDNDZUi6lfaC6VrY031lvZ9FtNOs2DFepKyL8fLWsTgFn+La0w6wN1hUdXQ8vr@vger.kernel.org, AJvYcCURrRJCinDSGoj1l87h5prVHPB1T3YvXEEcLo1r/LA0ZyFN24SjrUd4si0l23hSBEhqX42smEVQys1dfZeb@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtTVuaA2tfjHHLznWpMF7A1Yww9lnMcYbW4yvJaFNcd0JPaaQ
	s9oflgf57+6IwEBY3KpgYQNVzB5iNzIsrxl2+clEtx+xumDAnDAkpfXoASedTeNGwQ==
X-Google-Smtp-Source: AGHT+IEBldIykjeOMBEw6JcPYD1BWPf3DRE9rWz+yBHxL0qv7kC4+C6xg5z6GXyXJDwsL3vajYna2Q==
X-Received: by 2002:a17:903:2a8b:b0:20c:cd23:449d with SMTP id d9443c01a7336-21183e1eff6mr220783885ad.46.1731422174169;
        Tue, 12 Nov 2024 06:36:14 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e418bfsm94417445ad.169.2024.11.12.06.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:36:13 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso4337669a91.2;
        Tue, 12 Nov 2024 06:36:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgvaXPA9XYnoRtoCvbCwh+/grG+Tp865E/nRl+alZIpNGLewv97gjfnrug954E4r9yJan6WglUX1rUbZ+8@vger.kernel.org, AJvYcCVEn1NLIHaw0i14pE/4Eh0imt5OpGkoqiAYfSgZ0Ps9MfpNgb0s9RBxoioqSZHxKLP6H1w92Hdn0cwi@vger.kernel.org
X-Received: by 2002:a17:90b:3c0e:b0:2e2:dcea:2b8c with SMTP id
 98e67ed59e1d1-2e9b16eeb4emr22784902a91.6.1731422173348; Tue, 12 Nov 2024
 06:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111181807.13211-1-tszucs@linux.com> <20241111181807.13211-2-tszucs@linux.com>
 <c89c2f16-ffb0-4b61-a962-9705f9f1e0e2@kwiboo.se>
In-Reply-To: <c89c2f16-ffb0-4b61-a962-9705f9f1e0e2@kwiboo.se>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Tue, 12 Nov 2024 15:36:02 +0100
X-Gmail-Original-Message-ID: <CA+GksrJzkxffSQbuseGFL0=2PDxV+TRevX0-NOkc6FNYLmNgYA@mail.gmail.com>
Message-ID: <CA+GksrJzkxffSQbuseGFL0=2PDxV+TRevX0-NOkc6FNYLmNgYA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Add supported UHS-I rates to
 sdmmc0 on rock-3b
To: Jonas Karlman <jonas@kwiboo.se>
Cc: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>, 
	Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

Thank you for pointing this out! I haven't noticed this before. I've
done some testing and I believe I am able to reproduce the issue you
described, although I cannot confirm the reason.
The only occasion I encounter any problems is when a UHS SD card or
SDIO device is connected to sdmmc0 during bootup. Sometimes the device
is recognized as HS only. Obviously no tuning value reported. Also,
sdmmc2 cuts out completely. I'm booting from eMMC and when the SD card
is removed in this state I lose my rootfs. Certainly, this needs more
attention but it seems to be unrelated to the changes here.

I need more time to check but are you sure this SD card during bootup
issue is gone with UHS-I disabled?

Also, in every other case, when you connect any device to sdmmc0 after
bootup, performance and stability is perfect.
Interestingly I also don't experience this behavior with an eMMC
device and / or an SDIO device connected to sdmmc2 during bootup. Only
sdmmc0 is problematic and only during bootup.

Any more thoughts on this are very welcome.

Kind regards,
Tamas



Tam=C3=A1s Sz=C5=B1cs
tszucs@linux.com

On Mon, Nov 11, 2024 at 8:00=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Tam=C3=A1s,
>
> On 2024-11-11 19:17, Tam=C3=A1s Sz=C5=B1cs wrote:
> > Add all supported UHS-I rates to sdmmc0 and allow 200 MHz maximum clock=
 to
> > benefit modern SD cards.
> >
> > Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@linux.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm=
64/boot/dts/rockchip/rk3568-rock-3b.dts
> > index 3d0c1ccfaa79..242af5337cdf 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> > @@ -670,8 +670,14 @@ &sdmmc0 {
> >       bus-width =3D <4>;
> >       cap-sd-highspeed;
> >       disable-wp;
> > +     max-frequency =3D <200000000>;
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> > +     sd-uhs-sdr12;
> > +     sd-uhs-sdr25;
> > +     sd-uhs-sdr50;
> > +     sd-uhs-sdr104;
> > +     sd-uhs-ddr50;
>
> There is an issue with io-domain driver not always being probed before
> mmc driver, this typically result in io-domain being configured wrong,
> and mmc tuning happen before io-domain is correctly configured.
>
> You can usually observe this by looking at the tuning value during boot
> and comparing it to the tuning value after removing and re-insering a
> sd-card.
>
> Because of this uhs modes was left out from initial DT submission, some
> cards will work others wont, sd-uhs-sdr50 is known to be working with
> most cards even with the probe order issue.
>
> Also I thought that lower speeds where implied?
>
> Regards,
> Jonas
>
> >       vmmc-supply =3D <&vcc3v3_sd>;
> >       vqmmc-supply =3D <&vccio_sd>;
> >       status =3D "okay";
>

