Return-Path: <linux-kernel+bounces-406740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6499C63D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F343B44092
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF221A4A4;
	Tue, 12 Nov 2024 21:05:16 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A0C21745E;
	Tue, 12 Nov 2024 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731445515; cv=none; b=f5SktIfo8ZjKhP7PR2BeEg5xrVgWGzzsVXhvG/BqvcUB2VXEMJg4yMZlDENxoXwy89nb2aJgBRiP9ugoyOqxx2HRdE0gAibN47bacmE4JbifbAlU+Ru7YWB0/o219TxrtynnzXOFV826mj3d/YPP8DGmSScCnxs3faucszah6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731445515; c=relaxed/simple;
	bh=Mz4zDUojrg/ba8beeO++QWMcwibvf6eVZyXmiCDU+m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdQ51UsgKp3uMsXjgJH6Xpz3Idhc0i1V+JLzbSOC3zq++OOcXl+YPuApeF91mab39FuNe/QRnseEArKP4YTf1XCIDeBNCLCqUaQ5IRsKaTiromz7q5RKQaJx2SX2cHvvXJfAWMWdvzTTQ0BjU8BWP9eGTMsX8OdBMelPFCWdo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cceb8d8b4so405545ad.1;
        Tue, 12 Nov 2024 13:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731445514; x=1732050314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvfLiy46zAAc4YpHFE3RBOLl5fq2FOHK1NiPPVPoB5Q=;
        b=leax9RzGTMUdkMk3L6lXojEf/Pgv48v4k7YqydE8rZ/Je0lqFLvIZlh1VFI8DbHAkB
         bHjaFYo3/Y33knr3F3xpIXbVpHP3b+rw0lNI3oRO4bp01rOtJceAlokHIhVbZ+Yn2Gwc
         Vc7eG8PrLvKvPWLL6uASadVrkKi2MIJOaBnGTSi0PAIbATgA3TQDo+nlHJmXwEiGDtYs
         84a6R+s3rkpEPBHBjUmzKHf/j6tvKb7MgfE9ei8LMoVO0dqNh+P5Ht+sECTkfcb9Fjdl
         iyGcc2dsTyGsRGsa2xEaht+UwF0fVvX4j+CZ3HJ/OVQEfyTyOk9aiy4ZpVNKQZyKGIJ+
         HDMA==
X-Forwarded-Encrypted: i=1; AJvYcCUrGyztvIZQ9Fn2oV69rkX2Duda9KAd6D0ohjOIOcW38Mh9M6/xG1HowjXH4jCdFYbzdPejtjec3rmUFlBm@vger.kernel.org, AJvYcCVLLkcMAL+NOPwkPrf9Sg8TCzb771+BLtgWITCRgBIAUXa+yTgj6nE4zj9FUnbQrQCypElLIdooEGAA@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+6J/f3ZZJjXnRt91+RFHGXbUv7J4WTkFK6I1xpch70dKfMVZ
	ermj2yxHbOScI/DKD7nTtGn0axTUJQqgqg/TMnywbWR5FNIdB0r4KngSFq0m
X-Google-Smtp-Source: AGHT+IHxa5gE5b1F1A7q7oo7jC17jD22gNAknD/zzvYzgfasK6hs4n9unaYyQQtRfEzcphLv8qUO8w==
X-Received: by 2002:a17:902:c942:b0:20b:c043:3873 with SMTP id d9443c01a7336-2118379faefmr249556005ad.21.1731445513595;
        Tue, 12 Nov 2024 13:05:13 -0800 (PST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com. [209.85.215.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf754sm98826165ad.98.2024.11.12.13.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 13:05:13 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso52021a12.0;
        Tue, 12 Nov 2024 13:05:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCtovP52fbN/3XfhmpAB+6MjNgX03Pvk5a4wgS1fM4gvnGmH0v7Dk+AI1jbqYlA7VarXlbLODLiXG0@vger.kernel.org, AJvYcCWr5760NkMu+ENdI3ULwtX3Y3zeIPZLx0MQ54ZozReC8hrgHDj4eDUwjsWLtIWGpDmgk6rRSEu7OjncLK5C@vger.kernel.org
X-Received: by 2002:a17:90b:1e45:b0:2c9:6abd:ca64 with SMTP id
 98e67ed59e1d1-2e9b1f074b1mr28605933a91.9.1731445512591; Tue, 12 Nov 2024
 13:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111181807.13211-1-tszucs@linux.com> <20241111181807.13211-3-tszucs@linux.com>
 <9fbdf05c-42e6-4ac5-9542-805200bc8c87@kwiboo.se> <260af427ae64d6f3b02a1579ee83eb3b@manjaro.org>
 <CA+Gksr+WvS-S+jeYYG=Bo9cemvnJmjsmU4aj9YnD3t8-HY7wbw@mail.gmail.com> <303ad3910668e852d6670d1c79dc22e0@manjaro.org>
In-Reply-To: <303ad3910668e852d6670d1c79dc22e0@manjaro.org>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Tue, 12 Nov 2024 22:05:00 +0100
X-Gmail-Original-Message-ID: <CA+GksrLLbfyHdvu1VYB4S+W78C0T1DEWu5W6pP2-g3KdBeT-LQ@mail.gmail.com>
Message-ID: <CA+GksrLLbfyHdvu1VYB4S+W78C0T1DEWu5W6pP2-g3KdBeT-LQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Enable sdmmc2 on rock-3b and
 set it up for SDIO devices
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>, Chukun Pan <amadeus@jmu.edu.cn>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Tue, Nov 12, 2024 at 4:16=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Tamas,
>
> On 2024-11-12 15:35, Tam=C3=A1s Sz=C5=B1cs wrote:
> > I think it was totally fine to disable sdmmc2 at first, especially if
> > it couldn=E2=80=99t be tested or wasn=E2=80=99t needed right away. From=
 what I=E2=80=99ve
> > seen, this board works great even at higher clock speeds than what
> > rk356x-base.dtsi suggests. I don=E2=80=99t have access to the RK3568 er=
rata,
> > and there don=E2=80=99t seem to be any limits mentioned in the TRM eith=
er.
> > Overall, this board is doing just fine as it is.
>
> Sorry, I'm missing the point of mentioning some clock speeds?  Any
> chances, please, to clarify that a bit?

It's all about stress scenarios, right. Sustained transfer at maximum
clock, multiple SD/MMC blocks used concurrently. That kind of thing.
Different data rates forced. I hope that answers your question.

>
> > Regarding device tree overlays, they would be ideal for implementing
> > secondary functions, such as PCIe endpoint mode for users with
> > specific requirements. However, the primary functions for PCIe on the
> > M2E will be root complex mode, along with SDIO host, etc. In my view,
> > the hardware is well-designed and interconnected. Users have a
> > reasonable expectation that these primary functions should work
> > seamlessly without additional configuration, right out of the box.
>
> That's basically what I referred to in my earlier response, and in my
> previous response regarding the UART.  Users would expect the Bluetooth
> part to work as well, but the error messages I mentioned look nasty, so
> perhaps something should be done about that first.

I'm not aware of any nasty error messages especially related to UART.
Well, MMC core will acknowledge when the platform part fails to
enumerate a device on sdmmc2, but there's nothing wrong with this.
It's not even an error -- certainly not a nasty one.

[    1.799703] mmc_host mmc2: card is non-removable.
[    1.935011] mmc_host mmc2: Bus speed (slot 0) =3D 375000Hz (slot req
400000Hz, actual 375000HZ div =3D 0)
[    7.195009] mmc_host mmc2: Bus speed (slot 0) =3D 375000Hz (slot req
375000Hz, actual 375000HZ div =3D 0)
[   13.029540] mmc2: Failed to initialize a non-removable card

>
> > Dragan, what did you mean by SDIO related power timing requirements?
>
> Whenever there's an SDIO module, there's usually some required timing
> of the power rails.  Though, I don't know what's that like with the
> non-standard M.2 SDIO modules that Radxa sells, which are intended to
> be used on Radxa boards with "hybrid" M.2 slots.

Ok, I see. Not always. I can't comment on Radxa's SDIO module but I'm
sure it's reasonably standard. And so is the M.2 Key E on this board.
Actually, part of the appeal is that all standard buses are very
nicely wired up. I want everybody to be able to use them.


>
> Once again, please use inline replying. [*]
>
> [*] https://en.wikipedia.org/wiki/Posting_style
>
> > On Tue, Nov 12, 2024 at 5:41=E2=80=AFAM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >>
> >> Hello Jonas and Tamas,
> >>
> >> On 2024-11-11 20:06, Jonas Karlman wrote:
> >> > On 2024-11-11 19:17, Tam=C3=A1s Sz=C5=B1cs wrote:
> >> >> Enable SDIO on Radxa ROCK 3 Model B M.2 Key E. Add all supported UH=
S-I
> >> >> rates and
> >> >> enable 200 MHz maximum clock. Also, allow host wakeup via SDIO IRQ.
> >> >>
> >> >> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@linux.com>
> >> >> ---
> >> >>  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 8 +++++++-
> >> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> index 242af5337cdf..b7527ba418f7 100644
> >> >> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> @@ -688,14 +688,20 @@ &sdmmc2 {
> >> >>      cap-sd-highspeed;
> >> >>      cap-sdio-irq;
> >> >>      keep-power-in-suspend;
> >> >> +    max-frequency =3D <200000000>;
> >> >>      mmc-pwrseq =3D <&sdio_pwrseq>;
> >> >>      non-removable;
> >> >>      pinctrl-names =3D "default";
> >> >>      pinctrl-0 =3D <&sdmmc2m0_bus4 &sdmmc2m0_clk &sdmmc2m0_cmd>;
> >> >> +    sd-uhs-sdr12;
> >> >> +    sd-uhs-sdr25;
> >> >> +    sd-uhs-sdr50;
> >> >
> >> > I thought that lower speeds was implied by uhs-sdr104?
> >>
> >> Last time I went through the MMC drivers, they were implied.  IIRC,
> >> such backward mode compatibility is actually a requirement made by
> >> the MMC specification.
> >>
> >> >>      sd-uhs-sdr104;
> >> >> +    sd-uhs-ddr50;
> >> >>      vmmc-supply =3D <&vcc3v3_sys2>;
> >> >>      vqmmc-supply =3D <&vcc_1v8>;
> >> >> -    status =3D "disabled";
> >> >> +    wakeup-source;
> >> >> +    status =3D "okay";
> >> >
> >> > This should probably be enabled using an dt-overlay, there is no
> >> > SDIO device embedded on the board and the reason I left it disabled
> >> > in original board DT submission.
> >>
> >> Just went through the ROCK 3B schematic, version 1.51, and I think
> >> there should be no need for a separate overlay, because sdmmc2 goes
> >> to the M.2 slot on the board, which any user can plug an M.2 module
> >> into, and the SDIO interface is kind-of self-discoverable.
> >>
> >> Of course, all that unless there are some horribly looking :) error
> >> messages emitted to the kernel log when nothing is actually found,
> >> in which case the SDIO/MMC driers should be fixed first.  Also, I'm
> >> not sure what do we do with the possible SDIO-related power timing
> >> requirements?

