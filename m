Return-Path: <linux-kernel+bounces-514911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB2A35D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC081887213
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EFD263F25;
	Fri, 14 Feb 2025 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCxOplsl"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940C1DD9AC;
	Fri, 14 Feb 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534422; cv=none; b=kSwkXPFDcRXfxWruNmrGtSYqdUKBTQvxKo/VNez9/On7vdWFPde/tJjlaH1JNmb9usgFSYnpUYL5ll7j9sMrzsPt/DdkKboyCuDi8bEI6WAxUD2JvmBU63wP9GHDW8KY8+1plsOZpGMxVppEHzTpbHPieouQHOw5Q3gY+wT9WHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534422; c=relaxed/simple;
	bh=ggYQkjTmochz2xeS9LX4BGs7YZbV0H9wrud7PJQNKxE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ofAr5pT7mqPvw9WjIfvH8cfexzRuAd54UOxYazENBNf2RSF6OBW39O/Dc+clR3NNXg6Pfiklbr9i8k9/5wZWqdMBZQmCWqKFKHv6s86nXcIX31P7A6+d7ep+iCRR1WE2/uhwYZAVRmrdubqKWR10fOW1t3eJ9LwCpigvyIcJ+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCxOplsl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso6042328a12.0;
        Fri, 14 Feb 2025 04:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739534419; x=1740139219; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI3W9qR1fQieAycCsuIaEjCDuBJjNXKEwknKksP2WWw=;
        b=BCxOplslPR4o3bQwRhlSaXsSio1/RaYUBQFkrCsCVNvF2NNAa5YZfVRbi8PRBsakvY
         PXMdO00th9Co7aldDFAcgK6oAohsr1vBONCrILGnXyUegxYK+XWYMMCLv2ABkAWuw6AD
         iTXFRlVoVGpUNrwqMKFUeXGTC8tRo/VQ7yGeSF7sDvd34ptBQXfCnMkmIKuQVc3UHnIV
         TChT90AYGWRNoAJhTK/YPdAzTbsdYsIgFJwLKkZHbM3DK4sl6wWFpYjUPp+CSjh4knz/
         tRUIz8GnPYSIMfXi8+LZoR2mbRGajqjyPOJKiZ9HhHKNJIBqwJe03Atz3qwrLjeCPKCG
         rIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739534419; x=1740139219;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI3W9qR1fQieAycCsuIaEjCDuBJjNXKEwknKksP2WWw=;
        b=BELzR8O5v3Tzb/RT/xg+1+PjRJUCdn4R9E/HEMF6WOk5u0+BE/9lvhvwvzr28B15L8
         ECRz4HqbSkyG5S/hjU9Hj7xkiBZk42trsS/UfgvIZ1Ivrt5L9Nag3wZjymlDN7Hy/lZe
         45oSejc6lrTvbV201bK++gyshazdBzTZLRqBzkGj2Ea5C3lCwss4grDX4AFwzpH5bzJi
         Jw5L6CYoYNWwSRqHhhHgxD4e1IzBM/6+3lVPC0o6lex2tSOowjyxerKLw7IUCtXqMO4A
         EZuj0kH85IzyPzicxo5/qH62ufOpXwxdy968OEI1Xk6FgUJB3MYT4OgTbxxNtePZs7EO
         rzpg==
X-Forwarded-Encrypted: i=1; AJvYcCUGbVwuVYFZDPiIj4Z1jRrVO1xjOvIVSFnV128LgKKm262SoIvRIq9WrcaVaBYYrK6GiH4+iX/d1j8v9MPL@vger.kernel.org, AJvYcCVPkyFwciE5SKLQTTAogBwcb4/dmo8khUebVRLfeMQxEbzFh8abKv1oZKg+LDl8imDjfnZIvynilOdW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EhaSak703U91SKNIQC87xRVtRlwS/vpgUBOHz5OY04+YtB8S
	ZDLSZvEPUs06jYj3A4om9GXhLdZan5qs02/DLGg1xlBPAmnPW/0oa7z11Z6h
X-Gm-Gg: ASbGncuaSf0ZtBB2VagVGQy+ApRZO9HzI+eO+C+EfBmHX0AwA2Tk+8qFOeShBVODn1O
	r17cwwUAZaseI5Tn+HRPhAsy5x+Ei1M/RMe3McJWDHtcSpW08asTIR4qKxPpERMnGSoA/rShNEI
	3KZk/c2du+AxHOAd4lioZTLhpcZSCjqK8ZcutGuBDe7YYyE8J2UzAfS2g9Tu90mvdt2eqrrJQWy
	/VF47rf/L3ZNyf9Cs/dhZEGkvb2q9IwuZzUaEpNaYDLINf3IxOGntSKkevGhH1XH3+ZUt9suZya
	kD4+873TvfhqsNG6osenfQwvTJW1bdv8ppbKNA8bRikJZjPBa67UuX5E2dBlT0aXhhzTnE0y
X-Google-Smtp-Source: AGHT+IEuZ76Lk8B5kT7BpvuBO88bUmgM7KzRYxZvjjTT1LTHSgCtEgbI85Tx+usx0aBQ6F7U8VS0vA==
X-Received: by 2002:a17:906:fe02:b0:ab7:c11:a980 with SMTP id a640c23a62f3a-aba510aecf0mr643697766b.17.1739534416957;
        Fri, 14 Feb 2025 04:00:16 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c416asm2819667a12.18.2025.02.14.04.00.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2025 04:00:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v6 00/14] Add eDP support for RK3588
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <tg6eyew4qahuxqakmmejne7xx2rkouj6htp55acun4ajz2irz2@vlmvqv3zc5vc>
Date: Fri, 14 Feb 2025 13:00:03 +0100
Cc: Damon Ding <damon.ding@rock-chips.com>,
 heiko@sntech.de,
 robh@kernel.org,
 conor+dt@kernel.org,
 algea.cao@rock-chips.com,
 rfoss@kernel.org,
 devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com,
 kever.yang@rock-chips.com,
 dmitry.baryshkov@linaro.org,
 vkoul@kernel.org,
 andy.yan@rock-chips.com,
 krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 l.stach@pengutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <C81810F2-6E9B-4DCC-85D1-CCB63CBFBFEA@gmail.com>
References: <20250123100747.1841357-1-damon.ding@rock-chips.com>
 <5044FFCB-B325-40D0-BA82-03AF64EAF029@gmail.com>
 <tg6eyew4qahuxqakmmejne7xx2rkouj6htp55acun4ajz2irz2@vlmvqv3zc5vc>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Sebastian Reichel =
<sebastian.reichel@collabora.com> w dniu 13 lut 2025, o godz. 18:26:
>=20
> Hello Piotr,
>=20
>=20
> The RK3588 has two different DP controllers. The one handled in this
> series should get the eDP port running, which is routed to the
> "eDP Panel" in the block diagram on page 3 of the Rock 5 ITX =
schematics.
> So this series adds support for using "HDMI/eDP TX0" and "HDMI/eDP =
TX1"
> in DP mode.
>=20
> The port routed to HDMI0 via RA620 is the other DP controller, which
> also exists twice: "TYPEC0/DP0" and "TYPEC1/DP1". This DP controller
> is not yet supported upstream and there is no pending patchset. As far
> as I know Rockchip plans to work on preparing upstream support for =
that
> soon.
>=20

Oh - this is very valuable info and explains a lot.
Thx.=20

> Note, that the two DisplayPort controllers are completely different.
> The HDMI/eDP controller is a design from Analogix and the TypeC/DP
> controller is a design from Synopsys.
>=20
> P.S.: Heiko merged support for HDMI1 (RK3588 SoC level) recently. So =
you
> should be able to get that running by some DT additions to the Rock 5
> ITX board DT with the latest linux-next code :)
>=20

And it works perfectly on all my 3588 bards (including audio and my cec =
addition)
But only on boards using both hdmi tx0 and tx1 to hdmi0/hdmi1 ports.

on rock5 itx: =20

With both hdmi tx0 and tx1 enabled in dts it looks like kernel detects =
hdmi tx0 as connected and tries read edid.=20
As nothing is connected to J11 (eDP con) - i=E2=80=99m getting i2c ddc =
timeouts=20
[   54.188880] dwhdmiqp-rockchip fde80000.hdmi: i2c read timed out
[   54.292207] dwhdmiqp-rockchip fde80000.hdmi: i2c read timed out
[   54.395554] dwhdmiqp-rockchip fde80000.hdmi: i2c read timed out


disabling hdmi0 makes kernel talking to hdmi1 but with issues:=20
[    0.540446] dwhdmiqp-rockchip fdea0000.hdmi: registered DesignWare =
HDMI QP I2C bus driver
[    0.541230] rockchip-drm display-subsystem: bound fdea0000.hdmi (ops =
dw_hdmi_qp_rockchip_ops)
[    0.542285] [drm] Initialized rockchip 1.0.0 for display-subsystem on =
minor 0
[    0.542933] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes
[    0.543605] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes

and here i=E2=80=99m a bit puzzled as on other 3588 boards (i.e. rock5b) =
- when i connected monitor to hdmi1 - all works perfectly
(kernel, OS and app nicely skipping hdmi0 and talking to actually =
connected hdmi1 port. all works)=20

on rock5 itx this not works.

my observations so far are:
-on rock5 itx hdmi0 is falsely detected as connected - even when eDP =
connector (J11) has nothing connected
-on rock5 itx disabling hdmi0 in dts breaks hdmi1=20
-on other 3588 (e.g. rock 5b) disabling hdmi0 in dts NOT breaks hdmi1 =20=


strange=E2=80=A6.

  =20

> Greetings,
>=20
> -- Sebastian
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


