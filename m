Return-Path: <linux-kernel+bounces-395160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 381759BB993
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9214BB2196A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8A1C729B;
	Mon,  4 Nov 2024 15:56:31 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153C1C07D3;
	Mon,  4 Nov 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735791; cv=none; b=eSjsUMZV9gD/HlRDxprHMYw5bnHXsmzXJbVPuS4UdfcdXW6klljQkROkxyn+gHCHdHZOYY+SYecPFm43uo1LKNMnVUuQqCDl49udOdMv0G5Koe5lKTBuaNkEnm2gXV8kzsX/w2rg8xKUiZ/SmbpwWaD6R8Nz1LVdgKuSfVZiGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735791; c=relaxed/simple;
	bh=STHL/UYDRFzYRey1JBPZ+/lKEezCeXNr3q6DL5WVntQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqZa9zVTwpSISS+u8zB2bzZwNsYCjjmLkxnzitHd03yNHDLedoXyacUgLapyA8o4HgU7tzkiD3/5WRtdGi4SF+2CGSXA4wRNMxPEQCpYBAaQZ28KE+OyZsJk2JVMGTqYxFOguZBw/pwP+99rn7nmmwQgngwvdXT490PC/srlhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e30eca40c44so3772881276.2;
        Mon, 04 Nov 2024 07:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735787; x=1731340587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z81NMGbuxUOa9XkPxAV+A5iia8KegJSMZSCO1E8CyfU=;
        b=paj1P4aJfNcYJHN21Okifhlfkg4AH8klSVdF8QFGTcAc2l6EG/7VOvx1Zkst9MQpLE
         pR0K1M6mGOgQ2gGS8xvt653bIZhDJoQPI46XB5H9SKlBfKzM6ydNR7JRqtHlPypwwov6
         BSQlBm6rwiFJi9gsdDo27dJFPmJ7urh+49Dz6ZWMx8sqQJ0EneVfvgrLXyrH2416kQp3
         +NIpBuUi5p5Irr+Sw6mmtoaH3/ZZqTVqpKiAV1Xv/eHeRsUQO8SwcODn2wNsT+fe1yMH
         dZSMkr9of1ksd0F5jUT5HbbH0RPtYTQmBD2BO4W48cZbP+ZWG99+IrgvuUHE2oLjf7y2
         Psaw==
X-Forwarded-Encrypted: i=1; AJvYcCVI0My0m88NX4pkh6TI9aEGVxNOtfJ5DjzW/tfW28mP1GwWKzxGAzU4NF31SDHacYXLDRL8aFLx7uku@vger.kernel.org, AJvYcCVmNFf5s1JozrKR10cukxglmVTqMJTRHqIIlKPsaW1QYNqY58KU4yf6bwpg/fGhfuZe6eFPjNEYUyfBQi3w@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdh0dwwAPKpN1aRnItZiDowzhJav4fRcMDlGsWqwUzZn0m4kC
	EqqhYLd9KKk0qqiBNvWnxQmuDXguvEW68D1TPaVd9Z5qJUpKNZf6DgdOulbp
X-Google-Smtp-Source: AGHT+IFwSrQ0uzX1RfXS5Z0Oq4kWSl0NEuCb4zGG37yYYyKkTdDDMQNaXzE6bQPS4U8cHSK++DX9yA==
X-Received: by 2002:a05:690c:102:b0:6db:4536:8591 with SMTP id 00721157ae682-6e9d8acb491mr258198487b3.28.1730735787346;
        Mon, 04 Nov 2024 07:56:27 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55ac9a22sm18419747b3.8.2024.11.04.07.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:56:26 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea8419a57eso16211807b3.1;
        Mon, 04 Nov 2024 07:56:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVk03SGr96EwWue4n59jPpe1/WOFGH2Ew8BbIG64B0wT+8WYMuj1RprQXPL2aOuLtuJkMc0ahhrBQafqy+Z@vger.kernel.org, AJvYcCXub+uVY1ptFZed2zPN4Ziuh6ECNU79jWNLq64wYljV6wMShZHfQo+TeGo5ATTsVJs1f3yWCvAC0MoY@vger.kernel.org
X-Received: by 2002:a05:690c:2d85:b0:6e3:12a3:bd36 with SMTP id
 00721157ae682-6e9d8b171cbmr233704207b3.43.1730735786661; Mon, 04 Nov 2024
 07:56:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
 <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com> <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
 <a65e17e9-0055-4e5a-902f-8ee2807a86df@ti.com> <299b6b75-beef-46aa-9203-b96009226677@solid-run.com>
 <cd02e760-54c6-4a92-af4e-e786d80cfbbd@ti.com> <533c54e5-d024-4fd0-b92d-0f320f25999f@solid-run.com>
In-Reply-To: <533c54e5-d024-4fd0-b92d-0f320f25999f@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Nov 2024 16:56:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWY0J7uooeRbUGwjkeCLd2UVyN9dtDWUkg5pJ3sAULdsQ@mail.gmail.com>
Message-ID: <CAMuHMdWY0J7uooeRbUGwjkeCLd2UVyN9dtDWUkg5pJ3sAULdsQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
To: Josua Mayer <josua@solid-run.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Wed, Oct 30, 2024 at 1:18=E2=80=AFPM Josua Mayer <josua@solid-run.com> w=
rote:
> Am 28.10.24 um 19:44 schrieb Vignesh Raghavendra:
> > On 28/10/24 22:49, Josua Mayer wrote:
> >> Am 28.10.24 um 16:31 schrieb Vignesh Raghavendra:
> >>> On 25/10/24 19:27, Geert Uytterhoeven wrote:
> >>>> On Mon, Feb 19, 2024 at 4:05=E2=80=AFPM Josua Mayer <josua@solid-run=
.com> wrote:
> >>>>> HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
> >>>>> The single SerDes lane of the SoC can be routed to either M1 pci-e
> >>>>> signals, or M2 usb-3 signals by a gpio-controlled mux.
> >>>>>
> >>>>> Add overlays for each configuration.
> >>>>>
> >>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>

> >>>>> --- /dev/null
> >>>>> +++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso

> >>>>> +&usbss0 {
> >>>>> +       /delete-property/ ti,usb2-only;
> >>>> /delete-property/ (and /delete-node/) to delete something in the bas=
e DTS
> >>>> does not work.
> >> My understanding is that flags are equivalent to boolean, i.e:
> >>
> >> ti,usb2-only =3D <true>;
> >> ti,usb2-only;
> >>
> >> are equivalent.
> >>
> >> If so, can we assign <false> within the overlay?

> Is there any chance of reassigning <false> and making an argument
> that this should be fixed?

In theory, it can be done, if (1) all code that checks boolean
properties would use of_property_read_bool() instead of
of_property_present(), and (2) of_property_read_bool() would be changed
to actually read the boolean value instead of just checking for the
presence of the property.  And of course we have to do that in all
software that uses DT (i.e. not just Linux).
See [1][2][3] below for caveats.

Using a similar solution for /delete-node/ is more complex, but still
feasible, by setting its "status" property to "disabled" . I think
that can be made to work if all DT core code that looks up nodes would
just ignore any node that has a disabled status. I.e. callers would
no longer see disabled nodes at all.

> I find it frustrating that overlays can't override boolean properties,
> and for consistency reasons I would otherwise change both
> pcie and usb3 overlays to standalone dts.

OK.

[1] The example in Documentation/devicetree/bindings/sound/rt5651.txt has:

        realtek,dmic-en =3D "true";
        realtek,in2-diff =3D "false";

    Obviously the second line doesn't really work with the current
    code, but fortunately there are no actual users of that (in
    upstream DTS).
    Note: "realtek,in2-diff" is a typo for "realtek,in2-differential".

[2] The example in Documentation/devicetree/bindings/sound/pcm3060.txt has:

        ti,out-single-ended =3D "true";

    Again, this is an open invitation for replacing "true" by "false".
    Fortunately there are no such users (in upstream DTS).

[3] arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi has:

        gpmc,device-nand =3D "true";

    But "gpmc,device-nand" does not exist. Oh, it is under removal:
    https://lore.kernel.org/all/20241009-gpmc-omap-dtbx-v2-2-fc68124a090a@k=
ernel.org/



Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

