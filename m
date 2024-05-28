Return-Path: <linux-kernel+bounces-192712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA38D210F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F5F1F25AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5743171E6A;
	Tue, 28 May 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnpKWxVg"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A91173346;
	Tue, 28 May 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912115; cv=none; b=i/DvQODccFVYl0gs5/f9Scg8aiOI3XynZAU0EjY6Y6TCSdW2FId+64aMyTbkXs2yjZK2QI46Kzs++rYQ21V+G7pfDjwIWzoD1VeFCcGioe83fCsZ8LpCof8+LXxVJVdpwwH2togKf0UtPFMQMbbAVARtbWkDjUq4JC58sc8hASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912115; c=relaxed/simple;
	bh=93/ZAcDJU7tMCrl1u6rFqplJEb56C7KgT8AcIidewh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kezLp8JjI05rfJagquDliXAjsGdtWKRhFfD7GUKHYOmRyPSO9M3jg8Xu3dZOI4pxeKlD+E56j4JEFbdbFaDqUgooR/TCJ+inubav5Etpumst41HXsFKYZlsh/tPh4OddJzy2rhSqavFvmZpONpy+JaF4sq+QiFUYtBwTk4CCUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnpKWxVg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5786988ae9bso1319429a12.3;
        Tue, 28 May 2024 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716912112; x=1717516912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsjOHizdrvfqmJxqxDMpN3lCIsfUt5pRyM4spPwkenU=;
        b=gnpKWxVgLqlF2x5Rt0c9Y8L+HuPOttAkRxIdffJs+6puqgTCXd4APO2GK7e+RbmfdI
         WBZNvk+d7/nL5XkerU/ClRM+Sappb20vePT6toHyJ7hgvT/nTih8A2svHpufvEvoceuU
         pPngiFyEHKJWL8t5nw9pszgK1SJLb/8niTs3wiF5p3+5WEP/k/rfmNHLY0mnIGTVr4en
         s68+2YXMCanz3fDU+l53/4F9b/hNceI543eh1KFoGMx8ehenxkSadlFPzCc8sEa+ka9L
         9p1BHnixyXMZeHynnkZtJ+eFdFa9eslJG4NdIWn32BEe0+g0KGvKrcsNu/dsAE1DO+iB
         CW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912112; x=1717516912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsjOHizdrvfqmJxqxDMpN3lCIsfUt5pRyM4spPwkenU=;
        b=Hfy7HDUajLIc3KY2CVh9G6ZI+tNcdX5wPI3uT30agJOOcuAxK19YJbYmIXJSB9eYbQ
         I6QiAZvpTjXcaaxHYmJdap/t8b+SjRKzAaJnW0W3F4aHhUw4rUJ78cEjI+xT80X2p8XB
         sD9GI+5EErdaHufWSNFpDgMM02oVpZvNTt6zs54xPX/7hK2HR6jCVEH056Wnz06xRynM
         nXU8QshKLIOF3FqJtNoBmrqUBJFQxCOk0ND8evmRMtTh2e9/9MN5hgIrAgo4zThTGbjy
         RERij+UqKFZ2+Tmcl+xdDRG3DCItYjwckvwk7gyq9Rj/KOxnNy3yoMmxQj2HI7S6D4YE
         KINw==
X-Forwarded-Encrypted: i=1; AJvYcCXUvUB7E8RmjQOkmWdUg/bzdJL9jMrd1MzHiQTv4FcPNIroUN59kos0eYhNGkAVZXcOQMWtGgyDrD2IHNF+D7i7AQX7eX8u8qFBN2B2h6lxWeGeSbXcZXH7iZFVgnzMt6aNL8YVNzpXoQ==
X-Gm-Message-State: AOJu0Yw6xQKgoeAKd3aI0zil4/0wQKrDyeT8j3zn6H2TI45jhV0zki8X
	He8D8aAbpiFp8M32hgZME9+WMSURbZ/KKp5VPhBGxeSxycd1BtM5butPdOF+vCj7StKRl4WNhq2
	ELRrnugAqoEQEyLUQcOBrqnRez40=
X-Google-Smtp-Source: AGHT+IHNuE7nLtgH5tbabZBoP5F4JkJPXbp/M6maPBMqXy141pqHfqme/UZVDsjVlC/xrsMnW/wR2sqSs0md2gDnT0U=
X-Received: by 2002:a17:906:cc4d:b0:a59:ba2b:590b with SMTP id
 a640c23a62f3a-a62650118f2mr833227266b.71.1716912112089; Tue, 28 May 2024
 09:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <5122636.irdbgypaU6@phil> <8727e1c29bd6f562a7fc3de0ddac62cf@manjaro.org> <6230150.aeNJFYEL58@phil>
In-Reply-To: <6230150.aeNJFYEL58@phil>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 28 May 2024 20:01:39 +0400
Message-ID: <CABjd4YysYZ5o17-nhRjyKqAw2sWi=GR1Q_OSHzAFOHLF5vh9GQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal, OPP and fan
To: Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[sorry if you get this twice: I messed up and sent the previous one in
HTML instead of plain text - resending now]

On Tue, May 28, 2024 at 7:16=E2=80=AFPM Heiko Stuebner <heiko@sntech.de> wr=
ote:
>
> Am Dienstag, 28. Mai 2024, 17:01:48 CEST schrieb Dragan Simic:
> > On 2024-05-28 16:34, Heiko Stuebner wrote:
> > > Am Dienstag, 28. Mai 2024, 16:05:04 CEST schrieb Dragan Simic:
> > >> On 2024-05-28 11:49, Alexey Charkov wrote:
> > >> > On Mon, May 6, 2024 at 1:37=E2=80=AFPM Alexey Charkov <alchark@gma=
il.com>
> > >> > wrote:
> > >> >>
> > >> >> This enables thermal monitoring and CPU DVFS on RK3588(s), as wel=
l as
> > >> >> active cooling on Radxa Rock 5B via the provided PWM fan.
> > >> >>
> > >> >> Some RK3588 boards use separate regulators to supply CPUs and the=
ir
> > >> >> respective memory interfaces, so this is handled by coupling thos=
e
> > >> >> regulators in affected boards' device trees to ensure that their
> > >> >> voltage is adjusted in step.
> > >> >>
> > >> >> This also enables the built-in thermal sensor (TSADC) for all boa=
rds
> > >> >> that don't currently have it enabled, using the default CRU based
> > >> >> emergency thermal reset. This default configuration only uses on-=
SoC
> > >> >> devices and doesn't rely on any external wiring, thus it should w=
ork
> > >> >> for all devices (tested only on Rock 5B though).
> > >> >>
> > >> >> The boards that have TSADC_SHUT signal wired to the PMIC reset li=
ne
> > >> >> can choose to override the default reset logic in favour of GPIO
> > >> >> driven (PMIC assisted) reset, but in my testing it didn't work on
> > >> >> Radxa Rock 5B - maybe I'm reading the schematic wrong and it does=
n't
> > >> >> support PMIC assisted reset after all.
> > >> >>
> > >> >> Fan control on Rock 5B has been split into two intervals: let it =
spin
> > >> >> at the minimum cooling state between 55C and 65C, and then accele=
rate
> > >> >> if the system crosses the 65C mark - thanks to Dragan for suggest=
ing.
> > >> >> This lets some cooling setups with beefier heatsinks and/or large=
r
> > >> >> fan fins to stay in the quietest non-zero fan state while still
> > >> >> gaining potential benefits from the airflow it generates, and
> > >> >> possibly avoiding noisy speeds altogether for some workloads.
> > >> >>
> > >> >> OPPs help actually scale CPU frequencies up and down for both coo=
ling
> > >> >> and performance - tested on Rock 5B under varied loads. I've drop=
ped
> > >> >> those OPPs that cause frequency reductions without accompanying
> > >> >> decrease
> > >> >> in CPU voltage, as they don't seem to be adding much benefit in d=
ay to
> > >> >> day use, while the kernel log gets a number of "OPP is inefficien=
t"
> > >> >> lines.
> > >> >>
> > >> >> Note that this submission doesn't touch the SRAM read margin upda=
tes
> > >> >> or
> > >> >> the OPP calibration based on silicon quality which the downstream
> > >> >> driver
> > >> >> does and which were mentioned in [1]. It works as it is (also
> > >> >> confirmed by
> > >> >> Sebastian in his follow-up message [2]), and it is stable in my
> > >> >> testing on
> > >> >> Rock 5B, so it sounds better to merge a simple version first and =
then
> > >> >> extend when/if required.
> > >> >>
> > >> >> [1]
> > >> >> https://lore.kernel.org/linux-rockchip/CABjd4YzTL=3D5S7cS8ACNAYVa=
730WA3iGd5L_wP1Vn9=3Df83RCORA@mail.gmail.com/
> > >> >> [2]
> > >> >> https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqp=
md2kwkbguiolmozntjuiajrb@gvq4nupzna4o/
> > >> >>
> > >> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > >> >> ---
> > >> >
> > >> > Hi Heiko,
> > >> >
> > >> > Do you think this can be merged for 6.11? Looks like there hasn't =
been
> > >> > any new feedback in a while, and it would be good to have frequenc=
y
> > >> > scaling in place for RK3588.
> > >> >
> > >> > Please let me know if you have any reservations or if we need any
> > >> > broader discussion.
> > >
> > > not really reservations, more like there was still discussion going o=
n
> > > around the OPPs. Meanwhile we had more discussions regarding the whol=
e
> > > speed binning Rockchip seems to do for rk3588 variants.
> > >
> > > And waiting for the testing Dragan wanted to do ;-) .
> >
> > I'm sorry for the delays.
>
> Was definitly _not_ meant as blame ;-) .
>
> The series has just too many discussions threads to unravel on half
> an afternoon.

FWIW, I think the latest exchange we had with Quentin regarding the
OPPs concluded in =E2=80=9Cfalse alarm=E2=80=9D, given that this version of=
 the series
only introduces a subset of them which should apply to all RK3588(s)

Performance binning here is more geared towards how low the voltages
can go for a given frequency, and right now we=E2=80=99re only introducing =
the
highest-voltage setting for each OPP. Thus the binning and/or
intermediate frequencies should be possible to introduce at a later
stage in a backwards compatible way (if deemed relevant).

> > > So this should definitly make it into 6.11 though, as there is still
> > > a lot of time.
> > >
> > >> As I promised earlier, I was going to test this patch series in
> > >> detail.
> > >> Alas, I haven't managed to do that yet, :/ due to many reasons, but
> > >> I still remain firmly committed to doing that.
> > >>
> > >> Is -rc4 the cutoff for 6.11?  If so, there's still time and I'll do =
my
> > >> best to test and review these patches as soon as possible.
> > >
> > > As early as possible, the hard cutoff would be -rc6 though.
> > > I guess I'll just start picking the easy patches from the series.
> >
> > I'll do my best to have the patches tested and reviewed in detail ASAP.
> > As a suggestion, perhaps it would be better to take the series as a
> > whole,
> > so we don't bring partial merging into the mix.
>
> Patches need to work individually anyway (in correct order of course),
> so like starting at the top with the general thermal stuff should not
> create issues ;-)

Indeed, those are self-contained and can be merged independently of
the OPPs. Having OPPs without thermal is more risky though, but that
doesn=E2=80=99t sound like what we=E2=80=99re after here :)

Best regards,
Alexey

