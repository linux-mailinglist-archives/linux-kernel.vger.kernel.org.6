Return-Path: <linux-kernel+bounces-243696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F6929953
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 20:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1578F1F20F1B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8A5FBB1;
	Sun,  7 Jul 2024 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqNJNHu4"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9283A8CE;
	Sun,  7 Jul 2024 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720377145; cv=none; b=Dl8Jf2pr7N5qjdzkF5Z6jq6UhP+lDVC67Wll8hpw6Bb9ZgIyShWhKbxCSs0snc61Mf8vgHNiiMwfIXFNGDXyTFZuC9eVvaeUJ0CehmEdgW+f1Xr5rz+X+Fq5nBddRxvdauOWEipde7XkKDQ698B2jrCsEwEKmD7dOucUjayNp+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720377145; c=relaxed/simple;
	bh=PUwYvtSs4dAh2GNW0AlNlGIxZD9EfCfPtRWgu5+06Ec=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q7w9VyETrrNFSeMPWUAH8uO73G+8iltZZNThnAGIT/AZGlxGjm3gz9v82sIfR6tJA9pJDV2qOj0cizzh49mY5BCryw87N/CC8eKA2I+gQJl6b40C7Zz0Min3Tmc5Esg04Tq/YLvE4QU1glscniaibjqhSaRjG6aE92o/qobFxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqNJNHu4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7523f0870cso376391966b.3;
        Sun, 07 Jul 2024 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720377142; x=1720981942; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSQ2k1ZfQBZLe252vJL66rHXJ8887qSMUh6gPtklvIU=;
        b=UqNJNHu4PnttMJ4qPpFslQ1NbG+Sn4OpNy/JrQy9NFrESGEOYEwqRXVjcca9DOh67p
         PxmiGX6lyO5JAXADyijEudJWk+bLyz2ge+QW5K+9sGu2/Dif2jPvXdkEUNmOHIYzOshm
         jNtBtTsvkDFy0Sv8xbTyjoLkVsltCG4CSxkBiG75phcJBzk+ry0nACid9ePK/9zVI+MN
         wx+bC9tYdQp+L1rypPDP6b6xCiESCY22qeWrOHnICKmDgEMEjz//Eml4OAxkHcu3dCAn
         XHsejqhLa83IA6moSAHRhFYJfbylhvKdY6husk/x1+RCBHh3pznsHnJF++aP9b8Pqn0v
         cZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720377142; x=1720981942;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSQ2k1ZfQBZLe252vJL66rHXJ8887qSMUh6gPtklvIU=;
        b=L3gBPhnY1dgEBY6hsWs0F+Qo/6LzddsuD8B1HBlfmQUHXhKuKU50+3CCChxkCp2toJ
         ndfjxGNjGJLilKEY7kdE4cOM18rSvjtLmHb1kWd5aM6wBDqs22HCOLBb+BM9Q01mr1S6
         5M1uYt2L4FIcsLPR4ffvyTlwR4wMz1kiCmb7SzMuYyDdlv4Xp+RVtzN6DXhsvm9m39s1
         kVMYjMxMoWrMyi9yPCrjYDrr+D4nI9VtAQBk5NSYaaQSiwgwfmDvZ0FGDivoyGeOZBX8
         sBQyt+HU8hCVEaiLvvmFLhVKMzpOLlOC63diFWRzo2yXgTdPKb20AlqwssVcncmpjzBU
         h36A==
X-Forwarded-Encrypted: i=1; AJvYcCX8Otr80xDZQB3QDjl71oP+xqBYnILUxdE1QVdMCKFCOqIbNjaBVGQ0uvfHfsj7f/MXNNrb5B7bSdMurAzQa2MRxSX6EmJniG6X0IfZ4k/elW/b3Z1rzAMJo2o7n3TY/9RCl/lW6EhHuQ==
X-Gm-Message-State: AOJu0YxNlope66s6H0QqxG7p/QS4GmTPKTylvXkAGqp7BNDClN2vq2io
	JZWP+AxESGwaJLhZaHVQWGaZn7tH9reUJ98VvTSmr6+jYz7YeQ7V
X-Google-Smtp-Source: AGHT+IH7Z9EpyQCMLSf7QY8DBtxZ8PceWBWNikn2dTf/MQLKllPJhYPKlXHM7Wqz/Hu9/4PzNXZhJg==
X-Received: by 2002:a17:906:2803:b0:a77:c548:6452 with SMTP id a640c23a62f3a-a77c54864c9mr493914666b.41.1720377141976;
        Sun, 07 Jul 2024 11:32:21 -0700 (PDT)
Received: from smtpclient.apple (84-10-100-139.static.chello.pl. [84.10.100.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065667sm862552966b.114.2024.07.07.11.32.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2024 11:32:21 -0700 (PDT)
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
In-Reply-To: <1E6ED98C-BD49-485D-9FE9-9E7CAEDB4564@gmail.com>
Date: Sun, 7 Jul 2024 20:32:18 +0200
Cc: Rob Herring <robh+dt@kernel.org>,
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
Message-Id: <503ECE3A-CA1C-43A7-AEB2-C0000A930B3A@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <0418B5BB-6759-4BFA-BE6E-F5C7FA0CBF4F@gmail.com> <2236519.ZfL8zNpBrT@diego>
 <1E6ED98C-BD49-485D-9FE9-9E7CAEDB4564@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
 Alexey Charkov <alchark@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)

Heiko, Alexey,

After some more tests: is varying fan-speeds working stable for you?

In my case - 1 per few reboots results with board enters state with: =
constant full speed and no any reaction for cpu temp.
In such state - I need multiple hw poweroffs (remove usb-c plug) to get =
fan-speeds working again.
When board is such state - all seems to work ok (frequency scaling, etc) =
except fan is constantly full speed=E2=80=A6

Is it varying fan-speed working stable for you?
Maybe my issue is some kernel modules loading race?


> Wiadomo=C5=9B=C4=87 napisana przez Piotr Oniszczuk =
<piotr.oniszczuk@gmail.com> w dniu 07.07.2024, o godz. 14:37:
>=20
> Heiko,
> pls see inline
>=20
>> Wiadomo=C5=9B=C4=87 napisana przez Heiko St=C3=BCbner =
<heiko@sntech.de> w dniu 07.07.2024, o godz. 13:11:
>>=20
>> Hey,
>>=20
>> Am Sonntag, 7. Juli 2024, 11:39:57 CEST schrieb Piotr Oniszczuk:
>>> Alexey,
>>> I=E2=80=99m playing with this series on rock5c on 6.10-rc6.
>>>=20
>>> Is code in this series enough to get working pwm-fan on rock5c?
>>> (of course after adding required changes from rokc5b dts to rock5c =
dts)
>>>=20
>>> In my case i=E2=80=99m getting constantly full speed of fan on my =
rock5c.
>>>=20
>>> hw seems ok as echo 96 > =
/sys/devices/platform/pwm-fan/hwmon/hwmon0/pwm1 changes fans speed as =
expected.
>>>=20
>>> May you pls hint me what i=E2=80=99m missing here?
>>=20
>> at least on my rock 5 itx patches, I get varying fan-speeds.
>> The fan starts high and then lowers its speed once the cpu-regulators
>> and every is set up.
>=20
> Ah - ok.
> I verified and it looks there was typo from my side in dts fan stanza =
:-/
> Now it works as expected :-)
>=20
> Many thx for your time!
>=20
>>=20
>> While I was working on the dts and the cpu-supplies were not yet =
working,
>> the fan speed stayed high, so maybe check that frequency scaling =
actually
>> works?
>> And of course you need the thermal map to handle the fan.=20
>=20
>>=20
>> Also of course I don't see a rock5c patch anywhere, so where did that
>> board dts come from?=20
>=20
> rock5c is my development: =
https://gist.github.com/warpme/6b2fa9004d8b28c0e43fa16b0b6595f3
>=20
>>=20
>>=20
>> Heiko
>>=20
>>>> Wiadomo=C5=9B=C4=87 napisana przez Alexey Charkov =
<alchark@gmail.com> w dniu 17.06.2024, o godz. 20:28:
>>>>=20
>>>> This enables thermal monitoring and CPU DVFS on RK3588(s), as well =
as
>>>> active cooling on Radxa Rock 5B via the provided PWM fan.
>>>>=20
>>>> Some RK3588 boards use separate regulators to supply CPUs and their
>>>> respective memory interfaces, so this is handled by coupling those
>>>> regulators in affected boards' device trees to ensure that their
>>>> voltage is adjusted in step.
>>>>=20
>>>> This also enables the built-in thermal sensor (TSADC) for all =
boards
>>>> that don't currently have it enabled, using the default CRU based
>>>> emergency thermal reset. This default configuration only uses =
on-SoC
>>>> devices and doesn't rely on any external wiring, thus it should =
work
>>>> for all devices (tested only on Rock 5B though).
>>>>=20
>>>> The boards that have TSADC_SHUT signal wired to the PMIC reset line
>>>> can choose to override the default reset logic in favour of GPIO
>>>> driven (PMIC assisted) reset, but in my testing it didn't work on
>>>> Radxa Rock 5B - maybe I'm reading the schematic wrong and it =
doesn't
>>>> support PMIC assisted reset after all.
>>>>=20
>>>> Fan control on Rock 5B has been split into two intervals: let it =
spin
>>>> at the minimum cooling state between 55C and 65C, and then =
accelerate
>>>> if the system crosses the 65C mark - thanks to Dragan for =
suggesting.
>>>> This lets some cooling setups with beefier heatsinks and/or larger
>>>> fan fins to stay in the quietest non-zero fan state while still
>>>> gaining potential benefits from the airflow it generates, and
>>>> possibly avoiding noisy speeds altogether for some workloads.
>>>>=20
>>>> OPPs help actually scale CPU frequencies up and down for both =
cooling
>>>> and performance - tested on Rock 5B under varied loads. I've =
dropped
>>>> those OPPs that cause frequency reductions without accompanying =
decrease
>>>> in CPU voltage, as they don't seem to be adding much benefit in day =
to
>>>> day use, while the kernel log gets a number of "OPP is inefficient" =
lines.
>>>>=20
>>>> Note that this submission doesn't touch the SRAM read margin =
updates or
>>>> the OPP calibration based on silicon quality which the downstream =
driver
>>>> does and which were mentioned in [1]. It works as it is (also =
confirmed by
>>>> Sebastian in his follow-up message [2]), and it is stable in my =
testing on
>>>> Rock 5B, so it sounds better to merge a simple version first and =
then
>>>> extend when/if required.
>>>>=20
>>>> This patch series has been rebased on top of Heiko's recent =
for-next branch
>>>> with Dragan's patch [3] which rearranges the .dtsi files for =
per-variant OPPs.
>>>> As a result, it now includes separate CPU OPP tables for RK3588(s) =
and RK3588j.
>>>>=20
>>>> GPU OPPs have also been split out to accommodate for the difference =
in RK3588j.
>>>>=20
>>>> [1] =
https://lore.kernel.org/linux-rockchip/CABjd4YzTL=3D5S7cS8ACNAYVa730WA3iGd=
5L_wP1Vn9=3Df83RCORA@mail.gmail.com/
>>>> [2] =
https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kwkbgu=
iolmozntjuiajrb@gvq4nupzna4o/
>>>> [3] =
https://lore.kernel.org/linux-rockchip/9ffedc0e2ca7f167d9d795b2a8f43cb9f56=
a653b.1717923308.git.dsimic@manjaro.org/
>>>>=20
>>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>>>> ---
>>>> Changes in v5:
>>>> - Rebased against linux-rockchip/for-next with Dragan's .dtsi =
reshuffling on top
>>>> - Added separate OPP values for RK3588j (these also apply to =
RK3588m)
>>>> - Separated GPU OPP values for RK3588j (RK3588m ones differ =
slightly, not included here)
>>>> - Dragan's patch: =
https://lore.kernel.org/linux-rockchip/9ffedc0e2ca7f167d9d795b2a8f43cb9f56=
a653b.1717923308.git.dsimic@manjaro.org/
>>>> - Link to v4: =
https://lore.kernel.org/r/20240506-rk-dts-additions-v4-0-271023ddfd40@gmai=
l.com
>>>>=20
>>>> Changes in v4:
>>>> - Rebased against linux-rockchip/for-next
>>>> - Reordered DT nodes alphabetically as pointed out by Diederik
>>>> - Moved the TSADC enablement to per-board .dts/.dtsi files
>>>> - Dropped extra "inefficient" OPPs (same voltage - lower =
frequencies)
>>>> - Dropped second passive cooling trips altogether to keep things =
simple
>>>> - Added a cooling map for passive GPU cooling (in a separate patch)
>>>> - Link to v3: =
https://lore.kernel.org/r/20240229-rk-dts-additions-v3-0-6afe8473a631@gmai=
l.com
>>>>=20
>>>> Changes in v3:
>>>> - Added regulator coupling for EVB1 and QuartzPro64
>>>> - Enabled the TSADC for all boards in .dtsi, not just Rock 5B =
(thanks ChenYu)
>>>> - Added comments regarding two passive cooling trips in each zone =
(thanks Dragan)
>>>> - Fixed active cooling map numbering for Radxa Rock 5B (thanks =
Dragan)
>>>> - Dropped Daniel's Acked-by tag from the Rock 5B fan patch, as =
there's been quite some
>>>> churn there since the version he acknowledged
>>>> - Link to v2: =
https://lore.kernel.org/r/20240130-rk-dts-additions-v2-0-c6222c4c78df@gmai=
l.com
>>>>=20
>>>> Changes in v2:
>>>> - Dropped the rfkill patch which Heiko has already applied
>>>> - Set higher 'polling-delay-passive' (100 instead of 20)
>>>> - Name all cooling maps starting from map0 in each respective zone
>>>> - Drop 'contribution' properties from passive cooling maps
>>>> - Link to v1: =
https://lore.kernel.org/r/20240125-rk-dts-additions-v1-0-5879275db36f@gmai=
l.com
>>>>=20
>>>> ---
>>>> Alexey Charkov (8):
>>>>    arm64: dts: rockchip: add thermal zones information on RK3588
>>>>    arm64: dts: rockchip: enable thermal management on all RK3588 =
boards
>>>>    arm64: dts: rockchip: add passive GPU cooling on RK3588
>>>>    arm64: dts: rockchip: enable automatic fan control on Rock 5B
>>>>    arm64: dts: rockchip: Add CPU/memory regulator coupling for =
RK3588
>>>>    arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
>>>>    arm64: dts: rockchip: Add OPP data for CPU cores on RK3588j
>>>>    arm64: dts: rockchip: Split GPU OPPs of RK3588 and RK3588j
>>>>=20
>>>> .../boot/dts/rockchip/rk3588-armsom-sige7.dts      |   4 +
>>>> arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 197 =
+++++++++++++++++----
>>>> .../dts/rockchip/rk3588-edgeble-neu6a-common.dtsi  |   4 +
>>>> arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  16 ++
>>>> arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts   |   4 +
>>>> arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi       | 190 =
++++++++++++++++++++
>>>> .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 ++
>>>> arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  34 +++-
>>>> .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |   4 +
>>>> .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |   4 +
>>>> arch/arm64/boot/dts/rockchip/rk3588.dtsi           |   1 +
>>>> arch/arm64/boot/dts/rockchip/rk3588j.dtsi          | 141 =
+++++++++++++++
>>>> arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |   4 +
>>>> arch/arm64/boot/dts/rockchip/rk3588s.dtsi          |   1 +
>>>> 14 files changed, 577 insertions(+), 39 deletions(-)
>>>> ---
>>>> base-commit: 5cc74606bf40a2bbaccd3e3bb2781f637baebde5
>>>> change-id: 20240124-rk-dts-additions-a6d7b52787b9
>>>>=20
>>>> Best regards,


