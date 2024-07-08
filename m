Return-Path: <linux-kernel+bounces-244173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B068792A03C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43DD1C216E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7517E591;
	Mon,  8 Jul 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL3mhze6"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708624D8A9;
	Mon,  8 Jul 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434558; cv=none; b=cqjUfSULhO7la9l1OBn19S4fAqklGQOYxC3Zf2mVjMBlGGlqAWoga+NsN3wXAS9enjwIUKUCHYeurdDb4ZuP8uj/AYnDlW5IF0ayTOGvqmfChEXw+kOB5OESliWlcgAumoV01sQXroCsjZCcKPZa5FN1Pbnjrtd47VYsUDApTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434558; c=relaxed/simple;
	bh=UkOFXWGuw2BgLaxpDmUV6yQ/P5AbU9pHwMHoCnn9EOU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IDeN4ScLcyRGCF9AcRQOozcpNWVIHOVVkiFJ7MRnz09mgygBZ7FlPWD7dNi2K1ToZIzeQYCb+KmLaBJ8p1IT6JVmCfzOQrp+mT0yHWycB5CgIcW3MDhvW7lsrQSyvxOVtAEhEHmrGt8oqKBv6mjeTjI/EhQZmlEIzMRYxB4wiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL3mhze6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77e5929033so200233266b.0;
        Mon, 08 Jul 2024 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720434555; x=1721039355; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkOFXWGuw2BgLaxpDmUV6yQ/P5AbU9pHwMHoCnn9EOU=;
        b=RL3mhze6uPo4Uj21hlPqwd/5pRs4QvclHyOou85YrZ1QYubRsyH5coU2fWvy2SVsB+
         ckBc8TYCpIQM1kLLMu4YW+dYR7a8e6h/hm9fbZAicaaEuErItGj5uAjbEcpgNfHBh/lM
         ymvrXWqemzkiQvRF8xpWA+/pKtPr5eX85EcZyPv9gduwYcPHQwfM9eJDMg+ToMfFdX0V
         eTDFyO09STEEFcWsyW08tGCbtxSa3jqjYU0Eu2qHWTSx4V5tUdLkww30ya4HUAztQTkQ
         iBbEZVkKVUAxpUFUlSqJHXWfOF+Lwd2nJRjH6ijSmfsz9wDRqV+MrZX1tRENSSMIQUq6
         xhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720434555; x=1721039355;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkOFXWGuw2BgLaxpDmUV6yQ/P5AbU9pHwMHoCnn9EOU=;
        b=S14nb1Gid6YneT19aK023pmpVnFMbhjhLKGoqcWwXtHIMHGhZZNivs3NxrhVci+uwo
         jtuVcb0SxmWeMP3N3yhwtS4VVUMKgpUf5XzQsSSW/SWeuSlLtZb6h0yHgY62EfnyYTH4
         C81ZUhKS2nlTt+tHt5yBzh53NAl9f2AjH0PkH2vvjwJHWunJ2dwfobd0UNEf1r/PiASs
         a7iWS1+JKcuVY4d0WW7JQXTg59uX69k4oEVcTk3suSzagAINs56bWzjLJLfwXPKXQN/1
         LWV38xDofdEVycN5zD3dl4GE0bUnJJ3paDUjf8sGT4WP5+5LleSJ0aCpxE3sBwO6B0BJ
         Ubyg==
X-Forwarded-Encrypted: i=1; AJvYcCUYmavzXANxQ6o4SwyQICle0n6vxSJPOYAex6i9lz+jLpvHfq/GEapxzu2nn3+os7uej/DKXYLPlpohMOtBAxZsXe0E9xpNhBiMuT3wTwMBFcwpevTwjCwLMHDlgNjmBDq0kxkOiAIPBw==
X-Gm-Message-State: AOJu0YzZNo8+KUgZivsYQ9Ep5JJEmAqOT+jfKs2R+yOX7UMFMDdOu7Fk
	sXZw3knk8tFQalo+Ja3Uc60AQYhdlvM4MCusGAoHLjpT92h7yKCh
X-Google-Smtp-Source: AGHT+IF8QzD8gF4amt85JoD0kaL9nDjpaIsKJ+OHLgAO+stKLPNnAyIyw9LcMeIssI6YfBg75oM6JA==
X-Received: by 2002:a17:906:3b12:b0:a6f:4fc8:2666 with SMTP id a640c23a62f3a-a77ba70e48emr793543766b.44.1720434554514;
        Mon, 08 Jul 2024 03:29:14 -0700 (PDT)
Received: from smtpclient.apple (84-10-100-139.static.chello.pl. [84.10.100.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77cbb3ef7asm292277366b.74.2024.07.08.03.29.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2024 03:29:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH v5 0/8] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CABjd4YyY68dcA+Z0nWAUq1UmVLeLw52Pg6NGpzcW=WMNX8ioqA@mail.gmail.com>
Date: Mon, 8 Jul 2024 12:29:12 +0200
Cc: Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B28C503C-B1A6-49E4-ADF0-82FA9A412D40@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <0418B5BB-6759-4BFA-BE6E-F5C7FA0CBF4F@gmail.com> <2236519.ZfL8zNpBrT@diego>
 <1E6ED98C-BD49-485D-9FE9-9E7CAEDB4564@gmail.com>
 <503ECE3A-CA1C-43A7-AEB2-C0000A930B3A@gmail.com>
 <CABjd4YyY68dcA+Z0nWAUq1UmVLeLw52Pg6NGpzcW=WMNX8ioqA@mail.gmail.com>
To: Alexey Charkov <alchark@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)

Alexey,
pls see inline

> Wiadomo=C5=9B=C4=87 napisana przez Alexey Charkov <alchark@gmail.com> =
w dniu 08.07.2024, o godz. 09:59:
>=20
> Hi Piotr,
>=20
> On Sun, Jul 7, 2024 at 9:32=E2=80=AFPM Piotr Oniszczuk
> <piotr.oniszczuk@gmail.com> wrote:
>>=20
>> Heiko, Alexey,
>>=20
>> After some more tests: is varying fan-speeds working stable for you?
>=20
> Yes, in my testing on Rock 5B it's been stable.
>=20
>> In my case - 1 per few reboots results with board enters state with: =
constant full speed and no any reaction for cpu temp.
>> In such state - I need multiple hw poweroffs (remove usb-c plug) to =
get fan-speeds working again.
>> When board is such state - all seems to work ok (frequency scaling, =
etc) except fan is constantly full speed=E2=80=A6
>=20
> One thought: could you please check which thermal governor gets
> loaded? I used stepwise in my testing.
>=20

this is from system when - after boot - i have constant full speed of =
fan=20

root@myth-frontend-3614ae04f23f:~ # cat =
/sys/class/thermal/thermal_zone0/policy
step_wise
root@myth-frontend-3614ae04f23f:~ # cat =
/sys/class/thermal/thermal_zone1/policy
step_wise
root@myth-frontend-3614ae04f23f:~ # cat =
/sys/class/thermal/thermal_zone2/policy
step_wise
root@myth-frontend-3614ae04f23f:~ # cat =
/sys/class/thermal/thermal_zone3/policy
step_wise
root@myth-frontend-3614ae04f23f:~ # cat =
/sys/class/thermal/thermal_zone4/policy
step_wise
root@myth-frontend-3614ae04f23f:~ # cat =
/sys/class/thermal/thermal_zone5/policy
step_wise
root@myth-frontend-3614ae04f23f:~ # cat =
/sys/class/thermal/thermal_zone6/policy
step_wise
root@myth-frontend-3614ae04f23f:~ # cat =
/sys/class/thermal/thermal_zone7/policy

dmesg: https://gist.github.com/warpme/5d12df382ce353205c6ff0c37f5b4791

lsmod: https://gist.github.com/warpme/1c74b3be2cabe85366f227594d8a3e90

pls let me know is there anything else i can provide to investigate this =
issue...


