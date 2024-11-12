Return-Path: <linux-kernel+bounces-406055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC7E9C5A79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22411F236C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957C1FE10A;
	Tue, 12 Nov 2024 14:35:59 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E971FCC4F;
	Tue, 12 Nov 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422158; cv=none; b=gxTy8EuNpLkznpXRIjqnnBr/TXg8HtINNRuFtoX1E50Yo9pNjYDj+7pMxAFZVc0GL31P5YzSbPwqoMUvexUVP5lyEbuPL1xwk1Vkk7YnVbtI7KnpcfAQd3446zocv+YvMvt4/gZp5/XfP47+9XXBl9kUMsEy3FKLbxiwtMyTLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422158; c=relaxed/simple;
	bh=O/QFFDdB0PMXz57l8UUccbGHsIa6UG3BDGFr0OekP5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpTkj0p+M3imIlUw8wRkH/PYFAMR3P3uJk+JT7OQTrGaZsOEBaskY0w6Q6iS9KFzU+VxJt3VtOlRrtCJPwwaRQJkpgeiiM5WuO9rC3M87U9EbcxVvSO0TKrWw1VPc3obHxjFdomvhXRl2MjH1IZjDy3I8EsignvKMKMBRUJLlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e60d3adecbso3043658b6e.2;
        Tue, 12 Nov 2024 06:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731422156; x=1732026956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McjUok6KfDUiGy+BXB2JFJst16pFs7oxIw6Lr01GESI=;
        b=Gx53aciJfHfMEuciN8PphC59N2cNiTnYvTP+EDX8YhvjB7hQKKhPHLNvuTCXgDilrV
         hcILdI7/Ix70TqbLIDvuhMwhsCQ2JfeiK46l/uYbh+yB9ODztPxTJ8VDJMZA0ZjEDzYq
         rkqSTh5mpZkGbNi/VUId2Wk9e0u3bXb7bWszeJAIKZHfvZQC8GhuM6ZBzWrEIjNtVovv
         GCZes3cGIaU6GRNauA37JZVB/ZnHlB8a/uo2qYi46jhiY8bmfLNdaiBLQxsg+7bKFaX6
         oZZSLel7iUyJ2YG0DUooC5GKupMRwHtpqAG0x/n/ZjisMBXHQbLh3Q3D6QHQ+P0wkaaa
         4wxA==
X-Forwarded-Encrypted: i=1; AJvYcCV+QHws+W9ZgoQ4fDOK/Un+iQvAsM+15ZFT+4yqVPIrHwM3injZuqJxJb5V3Km3k05avInopT1BxM+8oa+2@vger.kernel.org, AJvYcCX5Dyy+BF6Ydf9JGf/sQbVbew5myNPap2FD0vhgQeAdrGjRlrUCapYR5ZiFVZBeENHl34fp9g3wAq6W@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3rNjFOvNI1ng48LPYE7Y0Xt1NYztiLxpLLZDAjLuo9iayj8B
	hrqyv4KhzzslVYqzu3ENu7swoRK0gVwJC3JEpBAQPCvAdgSPNCl+sgkgjoiTl9ZHjQ==
X-Google-Smtp-Source: AGHT+IEdb2C7EfEG6ZkbRX7xGk6PLJsox15F9HL4LmCArCwFkH9Xj+5yECle6yBdYyPqXqQt34rH4g==
X-Received: by 2002:a05:6808:3090:b0:3e6:5f3:f0d8 with SMTP id 5614622812f47-3e7946a60a9mr13884685b6e.24.1731422156104;
        Tue, 12 Nov 2024 06:35:56 -0800 (PST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com. [209.85.215.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f644200sm10615243a12.60.2024.11.12.06.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:35:55 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ee4c57b037so4203463a12.0;
        Tue, 12 Nov 2024 06:35:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWC+Y3tG/2I355ipHOPhM5zVLZa8g4zeWbJwifC+9LRr6O3eiKSmQ/6DQw4mrWvEbkskklKZn2WEj1xNi2@vger.kernel.org, AJvYcCWa/56XbLnROA7uqkqZb1dWLigVxvgPdUISCSa8PQMPrVTS7u86pYDzB4JFenUdKVKRyoKfn0f/E6sT@vger.kernel.org
X-Received: by 2002:a17:90b:3146:b0:2e2:cf63:224c with SMTP id
 98e67ed59e1d1-2e9b17838ddmr19179314a91.35.1731422155186; Tue, 12 Nov 2024
 06:35:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111181807.13211-1-tszucs@linux.com> <20241111181807.13211-3-tszucs@linux.com>
 <9fbdf05c-42e6-4ac5-9542-805200bc8c87@kwiboo.se> <260af427ae64d6f3b02a1579ee83eb3b@manjaro.org>
In-Reply-To: <260af427ae64d6f3b02a1579ee83eb3b@manjaro.org>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Tue, 12 Nov 2024 15:35:44 +0100
X-Gmail-Original-Message-ID: <CA+Gksr+WvS-S+jeYYG=Bo9cemvnJmjsmU4aj9YnD3t8-HY7wbw@mail.gmail.com>
Message-ID: <CA+Gksr+WvS-S+jeYYG=Bo9cemvnJmjsmU4aj9YnD3t8-HY7wbw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Enable sdmmc2 on rock-3b and
 set it up for SDIO devices
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>, Chukun Pan <amadeus@jmu.edu.cn>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas, Dragan,

I think it was totally fine to disable sdmmc2 at first, especially if
it couldn=E2=80=99t be tested or wasn=E2=80=99t needed right away. From wha=
t I=E2=80=99ve
seen, this board works great even at higher clock speeds than what
rk356x-base.dtsi suggests. I don=E2=80=99t have access to the RK3568 errata=
,
and there don=E2=80=99t seem to be any limits mentioned in the TRM either.
Overall, this board is doing just fine as it is.

Regarding device tree overlays, they would be ideal for implementing
secondary functions, such as PCIe endpoint mode for users with
specific requirements. However, the primary functions for PCIe on the
M2E will be root complex mode, along with SDIO host, etc. In my view,
the hardware is well-designed and interconnected. Users have a
reasonable expectation that these primary functions should work
seamlessly without additional configuration, right out of the box.

Dragan, what did you mean by SDIO related power timing requirements?

Kind regards,
Tamas



Tam=C3=A1s Sz=C5=B1cs
tszucs@linux.com

On Tue, Nov 12, 2024 at 5:41=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Jonas and Tamas,
>
> On 2024-11-11 20:06, Jonas Karlman wrote:
> > On 2024-11-11 19:17, Tam=C3=A1s Sz=C5=B1cs wrote:
> >> Enable SDIO on Radxa ROCK 3 Model B M.2 Key E. Add all supported UHS-I
> >> rates and
> >> enable 200 MHz maximum clock. Also, allow host wakeup via SDIO IRQ.
> >>
> >> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@linux.com>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> index 242af5337cdf..b7527ba418f7 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> @@ -688,14 +688,20 @@ &sdmmc2 {
> >>      cap-sd-highspeed;
> >>      cap-sdio-irq;
> >>      keep-power-in-suspend;
> >> +    max-frequency =3D <200000000>;
> >>      mmc-pwrseq =3D <&sdio_pwrseq>;
> >>      non-removable;
> >>      pinctrl-names =3D "default";
> >>      pinctrl-0 =3D <&sdmmc2m0_bus4 &sdmmc2m0_clk &sdmmc2m0_cmd>;
> >> +    sd-uhs-sdr12;
> >> +    sd-uhs-sdr25;
> >> +    sd-uhs-sdr50;
> >
> > I thought that lower speeds was implied by uhs-sdr104?
>
> Last time I went through the MMC drivers, they were implied.  IIRC,
> such backward mode compatibility is actually a requirement made by
> the MMC specification.
>
> >>      sd-uhs-sdr104;
> >> +    sd-uhs-ddr50;
> >>      vmmc-supply =3D <&vcc3v3_sys2>;
> >>      vqmmc-supply =3D <&vcc_1v8>;
> >> -    status =3D "disabled";
> >> +    wakeup-source;
> >> +    status =3D "okay";
> >
> > This should probably be enabled using an dt-overlay, there is no
> > SDIO device embedded on the board and the reason I left it disabled
> > in original board DT submission.
>
> Just went through the ROCK 3B schematic, version 1.51, and I think
> there should be no need for a separate overlay, because sdmmc2 goes
> to the M.2 slot on the board, which any user can plug an M.2 module
> into, and the SDIO interface is kind-of self-discoverable.
>
> Of course, all that unless there are some horribly looking :) error
> messages emitted to the kernel log when nothing is actually found,
> in which case the SDIO/MMC driers should be fixed first.  Also, I'm
> not sure what do we do with the possible SDIO-related power timing
> requirements?

