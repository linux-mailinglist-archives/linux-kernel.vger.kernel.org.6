Return-Path: <linux-kernel+bounces-407461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122E89C6DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9776E1F25B04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4141FF5F2;
	Wed, 13 Nov 2024 11:18:15 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB171FF02F;
	Wed, 13 Nov 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496694; cv=none; b=Fwz12+05aTLEihfcFcco3qFxACGFu9xZW/+YJ3dxommonDPnfYISrFcCp46TWidUGlseyA7zRxs2Q+N6GudLIad0BO6wRej3T+CaLJiYoZ1xPSTX058MZCtUVLAEGNvtNAwS2NujdBsvEDwBkdGjnlcQn8DIo4GFnpUz4gP4900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496694; c=relaxed/simple;
	bh=E1Sct4+relrww9D5JCm/J3xkunBGQi0ittvIuPsLgS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGssG3sTchHrgOVVDFq+HC4AtoYDvRzezb7/5B8ONaSgZZMSi2Fv6mlWbzdRXbZuOf7dNqRHbdL6GlHBtF3ycmH9qAWBpcjU1LJATpef2WTVQD1p0S1e0F991QWo38F+GzFfwlTKXdLvAXxSV8MF4ezZB+FJ5tYZldSKJbxuhZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso432298a12.1;
        Wed, 13 Nov 2024 03:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496692; x=1732101492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZLVszQr9Nkh+sZo/ra97q/9lEPNc4oCdL7ClLqEoro=;
        b=vBI+wPmkhI8OG0kzw4gTIIs1YDw6/U62wQH5FOAgg0jLQR0qtvo7ULx0EUg4bu2M0q
         K5dReATh6e4rvVjg5RP620ilw8XNEbPC/7nSsOrNijUIFAA1mJa9DII6X7rCHKBy+rU5
         GDF4Pygnxwu9tD1WEWdrsWrMROvpzuXyarvqA7RIbxOdzlePOqtosKIjmsxaiZLtsIjh
         nKc5ozkzsGr6ORcAhVR6roRMHjEyELjTAoJb7RfS/GWZaY5XHFTdB4WSlDtjCcVoXXBm
         winG+rvSFfcOmpJPdHfum+Ju5xb2vQec6ugzcPqK0Z7JGNsKyG3sNROp5PBpkNA4iCRJ
         ywMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWrD/sE5jh/gdl7sQ/7qlUXSgfFcqxS22JMvjHYWFVb7nz29gXfAeafWpylQhHhG+AOBjwtetR82VB@vger.kernel.org, AJvYcCX3sjjwrAs+Qami/5W1QVq944XhtIl7jm65bbC80SOP8SvhXqipyC0cXoWOnGCAOciLjFw2+VcIjuqnj3fJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzBN4sa2RI331s8wIomfodXQY603dqQnAoNDgm5cRTNxJRzaMYa
	EZxLgjC9zYD6We+2JG/yAbQijvWudEfXYu06PS8SlGMjriKvdSOXXBfca1Dv
X-Google-Smtp-Source: AGHT+IG3LRjp1/LOLE3+RewHLY09BiJqEtYlKnAdcO8yy9Lxu4NhpIk2WtG28GMxmrQKCnaxfXejjQ==
X-Received: by 2002:a17:90b:314a:b0:2e2:85b8:14e with SMTP id 98e67ed59e1d1-2e9b0b383ebmr29683208a91.15.1731496692312;
        Wed, 13 Nov 2024 03:18:12 -0800 (PST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3edd836sm1220345a91.23.2024.11.13.03.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 03:18:12 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72458c0e0d5so489070b3a.1;
        Wed, 13 Nov 2024 03:18:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6SKhJRvdsmavzFjMmbMh53/KMFZYlPxDgDZJjf7qCcTp4hI8Z9XX7iSUfTs4nGH9q8ASBo3gI9SaO@vger.kernel.org, AJvYcCWZCsDhaVKx3CHfNrsqNtmJ8JZB7SHxH0jldOTJUvR9rChTYru5htCYQJkrdgHxq4r2p7h6Tu5hlilp3t7q@vger.kernel.org
X-Received: by 2002:a17:90b:3d4d:b0:2e2:a5fd:7e4c with SMTP id
 98e67ed59e1d1-2e9b1edc08fmr31921095a91.8.1731496691401; Wed, 13 Nov 2024
 03:18:11 -0800 (PST)
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
 <eed7f35d1311eced9144fd7a5656b58f@manjaro.org> <CA+Gksr+aoDazT3b7uPFTOf5h3Drn3idZ5Kiris3k1fAxweXcyQ@mail.gmail.com>
 <7229c5a3e9cef5dc05f6c42a846fcd29@manjaro.org>
In-Reply-To: <7229c5a3e9cef5dc05f6c42a846fcd29@manjaro.org>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Wed, 13 Nov 2024 12:17:59 +0100
X-Gmail-Original-Message-ID: <CA+Gksr+6pjsHY=Mx2gmPnTV6TRbD_4dXptAqph8RSpR1pR9LtA@mail.gmail.com>
Message-ID: <CA+Gksr+6pjsHY=Mx2gmPnTV6TRbD_4dXptAqph8RSpR1pR9LtA@mail.gmail.com>
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

On Wed, Nov 13, 2024 at 11:44=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Tamas,
>
> On 2024-11-13 11:24, Tam=C3=A1s Sz=C5=B1cs wrote:
> > On Wed, Nov 13, 2024 at 12:38=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg>
> > wrote:
> >> On 2024-11-12 22:05, Tam=C3=A1s Sz=C5=B1cs wrote:
> >> > On Tue, Nov 12, 2024 at 4:16=E2=80=AFPM Dragan Simic <dsimic@manjaro=
.org>
> >> > wrote:
> >> >> On 2024-11-12 15:35, Tam=C3=A1s Sz=C5=B1cs wrote:
> >> >> > I think it was totally fine to disable sdmmc2 at first, especiall=
y if
> >> >> > it couldn=E2=80=99t be tested or wasn=E2=80=99t needed right away=
. From what I=E2=80=99ve
> >> >> > seen, this board works great even at higher clock speeds than wha=
t
> >> >> > rk356x-base.dtsi suggests. I don=E2=80=99t have access to the RK3=
568 errata,
> >> >> > and there don=E2=80=99t seem to be any limits mentioned in the TR=
M either.
> >> >> > Overall, this board is doing just fine as it is.
> >> >>
> >> >> Sorry, I'm missing the point of mentioning some clock speeds?  Any
> >> >> chances, please, to clarify that a bit?
> >> >
> >> > It's all about stress scenarios, right. Sustained transfer at maximu=
m
> >> > clock, multiple SD/MMC blocks used concurrently. That kind of thing.
> >> > Different data rates forced. I hope that answers your question.
> >>
> >> Ah, I see.  Though, I don't think we should worry much about that,
> >> although testing it all is, of course, a good thing to do.
> >
> > Better be safe than sorry. Let's just say I've seen worse.
> >
> >> >> > Regarding device tree overlays, they would be ideal for implement=
ing
> >> >> > secondary functions, such as PCIe endpoint mode for users with
> >> >> > specific requirements. However, the primary functions for PCIe on=
 the
> >> >> > M2E will be root complex mode, along with SDIO host, etc. In my v=
iew,
> >> >> > the hardware is well-designed and interconnected. Users have a
> >> >> > reasonable expectation that these primary functions should work
> >> >> > seamlessly without additional configuration, right out of the box=
.
> >> >>
> >> >> That's basically what I referred to in my earlier response, and in =
my
> >> >> previous response regarding the UART.  Users would expect the
> >> >> Bluetooth
> >> >> part to work as well, but the error messages I mentioned look nasty=
,
> >> >> so
> >> >> perhaps something should be done about that first.
> >> >
> >> > I'm not aware of any nasty error messages especially related to UART=
.
> >> > Well, MMC core will acknowledge when the platform part fails to
> >> > enumerate a device on sdmmc2, but there's nothing wrong with this.
> >> > It's not even an error -- certainly not a nasty one.
> >> >
> >> > [    1.799703] mmc_host mmc2: card is non-removable.
> >> > [    1.935011] mmc_host mmc2: Bus speed (slot 0) =3D 375000Hz (slot =
req
> >> > 400000Hz, actual 375000HZ div =3D 0)
> >> > [    7.195009] mmc_host mmc2: Bus speed (slot 0) =3D 375000Hz (slot =
req
> >> > 375000Hz, actual 375000HZ div =3D 0)
> >> > [   13.029540] mmc2: Failed to initialize a non-removable card
> >>
> >> This looks acceptable to me, but I'm now not really sure that we
> >> should enable the sdmmc2 in the board dts.  Let me explain.
> >>
> >> As Jonas demonstrated with the WiFi+Bluetooth DT overlay, additional
> >> DT configuration is needed to actually make an SDIO M.2 module plugged
> >> into the ROCK 3B's M.2 slot work, so what do we actually get from
> >> enabling the sdmmc2 in the board dts?  Just some error messages in
> >> the kernel log :) and AFAICT no additional functionality when an SDIO
> >> M.2 module is actually plugged into the slot.
> >
> > I think if you want to add a specific bluetooth DT overlay for your
> > favorite module, you should.
> > Our modules need this much and it's very useful already. I'm not
> > interested in nailing down every single one we have in a separate
> > overlay at this point.
>
> It would help if you'd share more details about the M.2 SDIO
> module you're referring to, please.

Kindly refer to 3/3.

>
> >> >> > Dragan, what did you mean by SDIO related power timing requiremen=
ts?
> >> >>
> >> >> Whenever there's an SDIO module, there's usually some required timi=
ng
> >> >> of the power rails.  Though, I don't know what's that like with the
> >> >> non-standard M.2 SDIO modules that Radxa sells, which are intended =
to
> >> >> be used on Radxa boards with "hybrid" M.2 slots.
> >> >
> >> > Ok, I see. Not always. I can't comment on Radxa's SDIO module but I'=
m
> >> > sure it's reasonably standard. And so is the M.2 Key E on this board=
.
> >> > Actually, part of the appeal is that all standard buses are very
> >> > nicely wired up. I want everybody to be able to use them.
> >>
> >> Yes, but getting it all wired in some way unfortunately doesn't mean
> >> that it will all work without additional DT configuration in place,
> >> as described above.
> >
> > Agreed, well these are the common changes needed.
>
> They are common indeed, but unless demonstrated they're all that's
> needed to get some M.2 SDIO module fully functional, it escapes me
> to see what are the benefits of including (and more importantly,
> enabling) these changes under the umbrella of commonality.

Please don't make it look harder than it is. Load device driver,
download firmware(s), you're set.

Kind regards,
Tamas


>
> >> Also, I'm not really sure there's some strict standard for the "GPIO"
> >> and "UART" M.2 modules, that part of the specification was/is a bit
> >> blurry or perhaps even non-existent.  It's been a while since I wrote
> >> the M.2 aricle on English Wikipedia, :) maybe it's become defined
> >> better in the meantime.
> >>
> >> >> Once again, please use inline replying. [*]
> >> >>
> >> >> [*] https://en.wikipedia.org/wiki/Posting_style
> >> >>
> >> >> > On Tue, Nov 12, 2024 at 5:41=E2=80=AFAM Dragan Simic <dsimic@manj=
aro.org>
> >> >> > wrote:
> >> >> >>
> >> >> >> Hello Jonas and Tamas,
> >> >> >>
> >> >> >> On 2024-11-11 20:06, Jonas Karlman wrote:
> >> >> >> > On 2024-11-11 19:17, Tam=C3=A1s Sz=C5=B1cs wrote:
> >> >> >> >> Enable SDIO on Radxa ROCK 3 Model B M.2 Key E. Add all suppor=
ted UHS-I
> >> >> >> >> rates and
> >> >> >> >> enable 200 MHz maximum clock. Also, allow host wakeup via SDI=
O IRQ.
> >> >> >> >>
> >> >> >> >> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@linux.com>
> >> >> >> >> ---
> >> >> >> >>  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 8 +++++++-
> >> >> >> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >> >> >> >>
> >> >> >> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> >> >> b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> >> >> index 242af5337cdf..b7527ba418f7 100644
> >> >> >> >> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> >> >> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >> >> >> >> @@ -688,14 +688,20 @@ &sdmmc2 {
> >> >> >> >>      cap-sd-highspeed;
> >> >> >> >>      cap-sdio-irq;
> >> >> >> >>      keep-power-in-suspend;
> >> >> >> >> +    max-frequency =3D <200000000>;
> >> >> >> >>      mmc-pwrseq =3D <&sdio_pwrseq>;
> >> >> >> >>      non-removable;
> >> >> >> >>      pinctrl-names =3D "default";
> >> >> >> >>      pinctrl-0 =3D <&sdmmc2m0_bus4 &sdmmc2m0_clk &sdmmc2m0_cm=
d>;
> >> >> >> >> +    sd-uhs-sdr12;
> >> >> >> >> +    sd-uhs-sdr25;
> >> >> >> >> +    sd-uhs-sdr50;
> >> >> >> >
> >> >> >> > I thought that lower speeds was implied by uhs-sdr104?
> >> >> >>
> >> >> >> Last time I went through the MMC drivers, they were implied.  II=
RC,
> >> >> >> such backward mode compatibility is actually a requirement made =
by
> >> >> >> the MMC specification.
> >> >> >>
> >> >> >> >>      sd-uhs-sdr104;
> >> >> >> >> +    sd-uhs-ddr50;
> >> >> >> >>      vmmc-supply =3D <&vcc3v3_sys2>;
> >> >> >> >>      vqmmc-supply =3D <&vcc_1v8>;
> >> >> >> >> -    status =3D "disabled";
> >> >> >> >> +    wakeup-source;
> >> >> >> >> +    status =3D "okay";
> >> >> >> >
> >> >> >> > This should probably be enabled using an dt-overlay, there is =
no
> >> >> >> > SDIO device embedded on the board and the reason I left it dis=
abled
> >> >> >> > in original board DT submission.
> >> >> >>
> >> >> >> Just went through the ROCK 3B schematic, version 1.51, and I thi=
nk
> >> >> >> there should be no need for a separate overlay, because sdmmc2 g=
oes
> >> >> >> to the M.2 slot on the board, which any user can plug an M.2 mod=
ule
> >> >> >> into, and the SDIO interface is kind-of self-discoverable.
> >> >> >>
> >> >> >> Of course, all that unless there are some horribly looking :) er=
ror
> >> >> >> messages emitted to the kernel log when nothing is actually foun=
d,
> >> >> >> in which case the SDIO/MMC driers should be fixed first.  Also, =
I'm
> >> >> >> not sure what do we do with the possible SDIO-related power timi=
ng
> >> >> >> requirements?

