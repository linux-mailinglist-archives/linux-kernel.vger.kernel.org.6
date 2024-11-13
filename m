Return-Path: <linux-kernel+bounces-407389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583009C6CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E0428C768
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55BD1FC7DE;
	Wed, 13 Nov 2024 10:24:54 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FA1FC7C1;
	Wed, 13 Nov 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493494; cv=none; b=iA7sBthu9SQu4PX74sehqPPYNZYbV6cTSHAX3dXj6rgMWT1q7v+BpZmbrBvXs/vI6ocA13EyUEp3ez2CuhsXp2XC40sijvg46kbG65VQeGTaM5y1QTL66m57Fd9PbT5ZXdVXG03k2RUc0RaehykTgW5IIkrB/rp9DZmV3QunrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493494; c=relaxed/simple;
	bh=YHGgAHDSD1d75iSz5m30jFqz+rTg/QEaxxUVsXe5ubQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2/e1q2hpU2Ipom0botUvHw7Et0SqlL+6PYhz9D9pobM61e+mEvNP0KLa37W/V09mn8yMm5hHEIhkOdg9Empf6WdqFfq6ddBcHeEumZAlL2nke/PoZ8mLDwt5oZfHMmHCjGA0srtAFpitM5SMjgfSxz/KNEMpwPw/7J708lxogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720d01caa66so6380451b3a.2;
        Wed, 13 Nov 2024 02:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493491; x=1732098291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLqGr7oL/tSva7ESNw1qx1bjzbqf+XtuouYHn6T1qfA=;
        b=fKc0C5CdParkHztydVc4192pg92jjyUNb4IbfctVcv/kVW8yY44I3ZAqKcvq2oD8nq
         pCHwMQwq8q77rDgP2vS2fM+B0czHKXzqfIMVe+3eQhnR+JIXlepijAnj+O1NaDFNLUkn
         FLLygLMVEuxSz7uF+OmaLqjjsmcTQ5cMXA+R747EG+O2tzqULMPUG41VceTgqu8nLT9b
         W50163JFgw+7oQmTguQbfYqjnz18iKoJaL42F8ftnU7vBg3btMu4I8EcsIWvfvGdzFyG
         vhZzQNg04Q+SZJCXUe2BQ+sfoktQ5IKmmHtUP0aHlYs626aL2Nmsotoa4G9Ijb96TOL8
         4KXg==
X-Forwarded-Encrypted: i=1; AJvYcCUjK3JB5MvjYRrDQeA13WVnwTq9+Xpt0E7bqU1I0Eb+VU2ictM6l1XJatXTCIZ77EeIMTnqRudOI4Dd@vger.kernel.org, AJvYcCVxP5OkSrjA4ZHJDrVJHJxdH+HUcBNNMfBccQC5Ku51UYr2QxkEkylgl/9Gi52fjPvK56Xnlynj541EXPnD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ku77JBd8zcpzMZy3WROCv9dGBB4Qp0DKBOI8DYD1kir89Wjv
	N8ETN7BbQxkJ3NfNzOniI2nyUag9qkuFVDB90KxtsshGDLhYe2JytYvlQnel
X-Google-Smtp-Source: AGHT+IHwSTL3KX0afGSX02xV1X/xgTaL42pm9wQFn/U91HAmh4EJph3KtsH7XmwytiLCHydjfc0Zjw==
X-Received: by 2002:a05:6a20:9151:b0:1db:92a9:4cd8 with SMTP id adf61e73a8af0-1dc70338b6cmr2826036637.6.1731493491410;
        Wed, 13 Nov 2024 02:24:51 -0800 (PST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078bfccfsm12964757b3a.82.2024.11.13.02.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:24:51 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e59746062fso5367695a91.2;
        Wed, 13 Nov 2024 02:24:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURCKdQ8DuqLCaZUOEa5Ycm6lZS9UmwQr2IW5hfPBxihcdTMGuzQPmxYLw3D1GjbYePDRprPtkkZbuFH0Xe@vger.kernel.org, AJvYcCW81ieM73O126+8GCrFOGmK2Yl/HpHVhR1J04xRlPYH6RAa4zus3LBQlnlt6JTNj5mNGmoRzPmhLXP0@vger.kernel.org
X-Received: by 2002:a17:90b:4acb:b0:2e2:ddfa:24d5 with SMTP id
 98e67ed59e1d1-2e9f2c78504mr3063104a91.15.1731493490622; Wed, 13 Nov 2024
 02:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111181807.13211-1-tszucs@linux.com> <20241111181807.13211-3-tszucs@linux.com>
 <9fbdf05c-42e6-4ac5-9542-805200bc8c87@kwiboo.se> <260af427ae64d6f3b02a1579ee83eb3b@manjaro.org>
 <CA+Gksr+WvS-S+jeYYG=Bo9cemvnJmjsmU4aj9YnD3t8-HY7wbw@mail.gmail.com>
 <303ad3910668e852d6670d1c79dc22e0@manjaro.org> <CA+GksrLLbfyHdvu1VYB4S+W78C0T1DEWu5W6pP2-g3KdBeT-LQ@mail.gmail.com>
 <eed7f35d1311eced9144fd7a5656b58f@manjaro.org>
In-Reply-To: <eed7f35d1311eced9144fd7a5656b58f@manjaro.org>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Wed, 13 Nov 2024 11:24:39 +0100
X-Gmail-Original-Message-ID: <CA+Gksr+aoDazT3b7uPFTOf5h3Drn3idZ5Kiris3k1fAxweXcyQ@mail.gmail.com>
Message-ID: <CA+Gksr+aoDazT3b7uPFTOf5h3Drn3idZ5Kiris3k1fAxweXcyQ@mail.gmail.com>
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

On Wed, Nov 13, 2024 at 12:38=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Tamas,
>
> On 2024-11-12 22:05, Tam=C3=A1s Sz=C5=B1cs wrote:
> > On Tue, Nov 12, 2024 at 4:16=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >> On 2024-11-12 15:35, Tam=C3=A1s Sz=C5=B1cs wrote:
> >> > I think it was totally fine to disable sdmmc2 at first, especially i=
f
> >> > it couldn=E2=80=99t be tested or wasn=E2=80=99t needed right away. F=
rom what I=E2=80=99ve
> >> > seen, this board works great even at higher clock speeds than what
> >> > rk356x-base.dtsi suggests. I don=E2=80=99t have access to the RK3568=
 errata,
> >> > and there don=E2=80=99t seem to be any limits mentioned in the TRM e=
ither.
> >> > Overall, this board is doing just fine as it is.
> >>
> >> Sorry, I'm missing the point of mentioning some clock speeds?  Any
> >> chances, please, to clarify that a bit?
> >
> > It's all about stress scenarios, right. Sustained transfer at maximum
> > clock, multiple SD/MMC blocks used concurrently. That kind of thing.
> > Different data rates forced. I hope that answers your question.
>
> Ah, I see.  Though, I don't think we should worry much about that,
> although testing it all is, of course, a good thing to do.

Better be safe than sorry. Let's just say I've seen worse.

>
> >> > Regarding device tree overlays, they would be ideal for implementing
> >> > secondary functions, such as PCIe endpoint mode for users with
> >> > specific requirements. However, the primary functions for PCIe on th=
e
> >> > M2E will be root complex mode, along with SDIO host, etc. In my view=
,
> >> > the hardware is well-designed and interconnected. Users have a
> >> > reasonable expectation that these primary functions should work
> >> > seamlessly without additional configuration, right out of the box.
> >>
> >> That's basically what I referred to in my earlier response, and in my
> >> previous response regarding the UART.  Users would expect the
> >> Bluetooth
> >> part to work as well, but the error messages I mentioned look nasty,
> >> so
> >> perhaps something should be done about that first.
> >
> > I'm not aware of any nasty error messages especially related to UART.
> > Well, MMC core will acknowledge when the platform part fails to
> > enumerate a device on sdmmc2, but there's nothing wrong with this.
> > It's not even an error -- certainly not a nasty one.
> >
> > [    1.799703] mmc_host mmc2: card is non-removable.
> > [    1.935011] mmc_host mmc2: Bus speed (slot 0) =3D 375000Hz (slot req
> > 400000Hz, actual 375000HZ div =3D 0)
> > [    7.195009] mmc_host mmc2: Bus speed (slot 0) =3D 375000Hz (slot req
> > 375000Hz, actual 375000HZ div =3D 0)
> > [   13.029540] mmc2: Failed to initialize a non-removable card
>
> This looks acceptable to me, but I'm now not really sure that we
> should enable the sdmmc2 in the board dts.  Let me explain.
>
> As Jonas demonstrated with the WiFi+Bluetooth DT overlay, additional
> DT configuration is needed to actually make an SDIO M.2 module plugged
> into the ROCK 3B's M.2 slot work, so what do we actually get from
> enabling the sdmmc2 in the board dts?  Just some error messages in
> the kernel log :) and AFAICT no additional functionality when an SDIO
> M.2 module is actually plugged into the slot.

I think if you want to add a specific bluetooth DT overlay for your
favorite module, you should.
Our modules need this much and it's very useful already. I'm not
interested in nailing down every single one we have in a separate
overlay at this point.

>
> >> > Dragan, what did you mean by SDIO related power timing requirements?
> >>
> >> Whenever there's an SDIO module, there's usually some required timing
> >> of the power rails.  Though, I don't know what's that like with the
> >> non-standard M.2 SDIO modules that Radxa sells, which are intended to
> >> be used on Radxa boards with "hybrid" M.2 slots.
> >
> > Ok, I see. Not always. I can't comment on Radxa's SDIO module but I'm
> > sure it's reasonably standard. And so is the M.2 Key E on this board.
> > Actually, part of the appeal is that all standard buses are very
> > nicely wired up. I want everybody to be able to use them.
>
> Yes, but getting it all wired in some way unfortunately doesn't mean
> that it will all work without additional DT configuration in place,
> as described above.

Agreed, well these are the common changes needed.


>
> Also, I'm not really sure there's some strict standard for the "GPIO"
> and "UART" M.2 modules, that part of the specification was/is a bit
> blurry or perhaps even non-existent.  It's been a while since I wrote
> the M.2 aricle on English Wikipedia, :) maybe it's become defined
> better in the meantime.
>
> >> Once again, please use inline replying. [*]
> >>
> >> [*] https://en.wikipedia.org/wiki/Posting_style
> >>
> >> > On Tue, Nov 12, 2024 at 5:41=E2=80=AFAM Dragan Simic <dsimic@manjaro=
.org>
> >> > wrote:
> >> >>
> >> >> Hello Jonas and Tamas,
> >> >>
> >> >> On 2024-11-11 20:06, Jonas Karlman wrote:
> >> >> > On 2024-11-11 19:17, Tam=C3=A1s Sz=C5=B1cs wrote:
> >> >> >> Enable SDIO on Radxa ROCK 3 Model B M.2 Key E. Add all supported=
 UHS-I
> >> >> >> rates and
> >> >> >> enable 200 MHz maximum clock. Also, allow host wakeup via SDIO I=
RQ.
> >> >> >>
> >> >> >> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@linux.com>
> >> >> >> ---
> >> >> >>  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 8 +++++++-
> >> >> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >> >> >>
> >> >> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> >> b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> >> index 242af5337cdf..b7527ba418f7 100644
> >> >> >> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> >> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> >> @@ -688,14 +688,20 @@ &sdmmc2 {
> >> >> >>      cap-sd-highspeed;
> >> >> >>      cap-sdio-irq;
> >> >> >>      keep-power-in-suspend;
> >> >> >> +    max-frequency =3D <200000000>;
> >> >> >>      mmc-pwrseq =3D <&sdio_pwrseq>;
> >> >> >>      non-removable;
> >> >> >>      pinctrl-names =3D "default";
> >> >> >>      pinctrl-0 =3D <&sdmmc2m0_bus4 &sdmmc2m0_clk &sdmmc2m0_cmd>;
> >> >> >> +    sd-uhs-sdr12;
> >> >> >> +    sd-uhs-sdr25;
> >> >> >> +    sd-uhs-sdr50;
> >> >> >
> >> >> > I thought that lower speeds was implied by uhs-sdr104?
> >> >>
> >> >> Last time I went through the MMC drivers, they were implied.  IIRC,
> >> >> such backward mode compatibility is actually a requirement made by
> >> >> the MMC specification.
> >> >>
> >> >> >>      sd-uhs-sdr104;
> >> >> >> +    sd-uhs-ddr50;
> >> >> >>      vmmc-supply =3D <&vcc3v3_sys2>;
> >> >> >>      vqmmc-supply =3D <&vcc_1v8>;
> >> >> >> -    status =3D "disabled";
> >> >> >> +    wakeup-source;
> >> >> >> +    status =3D "okay";
> >> >> >
> >> >> > This should probably be enabled using an dt-overlay, there is no
> >> >> > SDIO device embedded on the board and the reason I left it disabl=
ed
> >> >> > in original board DT submission.
> >> >>
> >> >> Just went through the ROCK 3B schematic, version 1.51, and I think
> >> >> there should be no need for a separate overlay, because sdmmc2 goes
> >> >> to the M.2 slot on the board, which any user can plug an M.2 module
> >> >> into, and the SDIO interface is kind-of self-discoverable.
> >> >>
> >> >> Of course, all that unless there are some horribly looking :) error
> >> >> messages emitted to the kernel log when nothing is actually found,
> >> >> in which case the SDIO/MMC driers should be fixed first.  Also, I'm
> >> >> not sure what do we do with the possible SDIO-related power timing
> >> >> requirements?

