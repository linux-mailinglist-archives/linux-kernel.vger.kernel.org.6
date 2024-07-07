Return-Path: <linux-kernel+bounces-243533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1F192974E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA881C20C41
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524331429B;
	Sun,  7 Jul 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjA8BN54"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC914265;
	Sun,  7 Jul 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720345204; cv=none; b=L61/0HHlaI/sKL9WcjckadKGGMdGOqA2/92f7TQAnrbpWZ49dZ5UCFD/sy3jwfEMyJRhQlGdzPegbXR8QfgYl7P5cM5S0MicRW47/DzrlBWmJ/VjpAhqDy+JAAuMBuK8me4nmzwBq0WSmu3EviUAuTBjtWrcfQNl7w53Sr+MoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720345204; c=relaxed/simple;
	bh=w3ZQv/D9tFn67+rfe2c4zPsTkngfKhsZrNmKVJ8F2QM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pL2kzESRVkfdj7TL3bDWEnQXCL7TWiVurIikrjRw6RFwYMKmjxdqU/CHijHCt85ARYGEmPVZWclSnpbKyHsRGv0nRIGJwnHyl5WOhFxyunPO8Y+z5PTU0Kma8bCjFd9OO8Xqoq0E/5dnkG6F9g7wiNMLt2ZSV/XtKXiDVevIg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjA8BN54; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58b447c513aso3315743a12.2;
        Sun, 07 Jul 2024 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720345201; x=1720950001; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ46zJkbG0+aNmfxCVW2p8Rzaq+o7YnA81L2x4H3Q3w=;
        b=HjA8BN54QGm5aIDIB5PqwfqC01A+Ac0ECj+h6+oIlLwTQMmV2KNxxTHyaw2APSfEjG
         2e22gkN5ubiKwqjEyZRJe6vQPxQ+NfjJuIlYMyVrFnBiLtEHSmPtfKjFmOMxYYpZZCIW
         ELykGbOOhuat8MwYn3vP0O4hsFj5x9RSeuOFbKr5vxvYINQzYXb2C3/HQiznEu8cZGoG
         38pNOtQMGl2cVLk9wQ+37mt759Ckf5ScPkTWJtWpCte+zyOuBWUPPwBKlyFI2H32h4fk
         L1N4jsGGu6nTtdTIVXIgpRPQoz13j6Nwrm7nvaxmUbuAS3HumtQp+82+JO/nWCVb7uOZ
         EsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720345201; x=1720950001;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZ46zJkbG0+aNmfxCVW2p8Rzaq+o7YnA81L2x4H3Q3w=;
        b=rg7SWbON2NjIAHU+qh8ZDZ4VRqfQBz+eijvXTK3AYqt2cCLI6HcGW8uuhZGXSVHVDu
         R5dQfzdLgcZBPeK39J/AhLOxNPKQebjpoYkRWF4LPEIhn+UGNt8LfSIE1THjyA2NUbFt
         JrgytPL4mzH6iCULHY16NbVdc7iDDdYG19NwuObCpFkH+HuA6Isj9gV/5uW2Vc0qQGNi
         z27a5BUJSYwyXKRXJmGtlzRwzEFAutZeS06+lEYoHOFITZqV7iZk9jSWm2nQYGs8CMS6
         r3WrRGVAIPbPfUoIPvmEJq5VwKzXSo4CicZCwQStsSmyxQqwzV5g7XvVLhU9/tCYjwu0
         nIhg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ULYC1KgbY2s7v1sSgREmeBFJ93epCFrF2m8tWDVafSvTxwkf2wpTLLOYRekMTv62oPAzTQjWe8dMYLiOKIDbsMmTF9SQtWdo25otvVcOv89li6FgvlUPWAXBLap2TL8VR78ZQctGUQ==
X-Gm-Message-State: AOJu0YwlqY0EwPVAlD+NUU0lZG49ZMbaT2v+zDVK+k3LKdjpuKNC5Ppv
	P/loxpwa2CGIY5vbHMwxwqTHrQENvu5Ymq55c+6G99myJwXP+z3T
X-Google-Smtp-Source: AGHT+IE9j6t+ifEQi3Va7HkMy6gIw2KexFA4NUkIE94ip/SupXT7bjNTEuuXMhBmzRpTLoGhJaym6w==
X-Received: by 2002:a05:6402:5210:b0:586:2fdf:f827 with SMTP id 4fb4d7f45d1cf-58e5c72fd3cmr6628124a12.31.1720345200608;
        Sun, 07 Jul 2024 02:40:00 -0700 (PDT)
Received: from smtpclient.apple (84-10-100-139.static.chello.pl. [84.10.100.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b43df9efdsm6909890a12.57.2024.07.07.02.39.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2024 02:40:00 -0700 (PDT)
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
In-Reply-To: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
Date: Sun, 7 Jul 2024 11:39:57 +0200
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
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
Message-Id: <0418B5BB-6759-4BFA-BE6E-F5C7FA0CBF4F@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
To: Alexey Charkov <alchark@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)

Alexey,
I=E2=80=99m playing with this series on rock5c on 6.10-rc6.

Is code in this series enough to get working pwm-fan on rock5c?
(of course after adding required changes from rokc5b dts to rock5c dts)

In my case i=E2=80=99m getting constantly full speed of fan on my =
rock5c.

hw seems ok as echo 96 > /sys/devices/platform/pwm-fan/hwmon/hwmon0/pwm1 =
changes fans speed as expected.

May you pls hint me what i=E2=80=99m missing here?
=20

> Wiadomo=C5=9B=C4=87 napisana przez Alexey Charkov <alchark@gmail.com> =
w dniu 17.06.2024, o godz. 20:28:
>=20
> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> active cooling on Radxa Rock 5B via the provided PWM fan.
>=20
> Some RK3588 boards use separate regulators to supply CPUs and their
> respective memory interfaces, so this is handled by coupling those
> regulators in affected boards' device trees to ensure that their
> voltage is adjusted in step.
>=20
> This also enables the built-in thermal sensor (TSADC) for all boards
> that don't currently have it enabled, using the default CRU based
> emergency thermal reset. This default configuration only uses on-SoC
> devices and doesn't rely on any external wiring, thus it should work
> for all devices (tested only on Rock 5B though).
>=20
> The boards that have TSADC_SHUT signal wired to the PMIC reset line
> can choose to override the default reset logic in favour of GPIO
> driven (PMIC assisted) reset, but in my testing it didn't work on
> Radxa Rock 5B - maybe I'm reading the schematic wrong and it doesn't
> support PMIC assisted reset after all.
>=20
> Fan control on Rock 5B has been split into two intervals: let it spin
> at the minimum cooling state between 55C and 65C, and then accelerate
> if the system crosses the 65C mark - thanks to Dragan for suggesting.
> This lets some cooling setups with beefier heatsinks and/or larger
> fan fins to stay in the quietest non-zero fan state while still
> gaining potential benefits from the airflow it generates, and
> possibly avoiding noisy speeds altogether for some workloads.
>=20
> OPPs help actually scale CPU frequencies up and down for both cooling
> and performance - tested on Rock 5B under varied loads. I've dropped
> those OPPs that cause frequency reductions without accompanying =
decrease
> in CPU voltage, as they don't seem to be adding much benefit in day to
> day use, while the kernel log gets a number of "OPP is inefficient" =
lines.
>=20
> Note that this submission doesn't touch the SRAM read margin updates =
or
> the OPP calibration based on silicon quality which the downstream =
driver
> does and which were mentioned in [1]. It works as it is (also =
confirmed by
> Sebastian in his follow-up message [2]), and it is stable in my =
testing on
> Rock 5B, so it sounds better to merge a simple version first and then
> extend when/if required.
>=20
> This patch series has been rebased on top of Heiko's recent for-next =
branch
> with Dragan's patch [3] which rearranges the .dtsi files for =
per-variant OPPs.
> As a result, it now includes separate CPU OPP tables for RK3588(s) and =
RK3588j.
>=20
> GPU OPPs have also been split out to accommodate for the difference in =
RK3588j.
>=20
> [1] =
https://lore.kernel.org/linux-rockchip/CABjd4YzTL=3D5S7cS8ACNAYVa730WA3iGd=
5L_wP1Vn9=3Df83RCORA@mail.gmail.com/
> [2] =
https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kwkbgu=
iolmozntjuiajrb@gvq4nupzna4o/
> [3] =
https://lore.kernel.org/linux-rockchip/9ffedc0e2ca7f167d9d795b2a8f43cb9f56=
a653b.1717923308.git.dsimic@manjaro.org/
>=20
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Changes in v5:
> - Rebased against linux-rockchip/for-next with Dragan's .dtsi =
reshuffling on top
> - Added separate OPP values for RK3588j (these also apply to RK3588m)
> - Separated GPU OPP values for RK3588j (RK3588m ones differ slightly, =
not included here)
> - Dragan's patch: =
https://lore.kernel.org/linux-rockchip/9ffedc0e2ca7f167d9d795b2a8f43cb9f56=
a653b.1717923308.git.dsimic@manjaro.org/
> - Link to v4: =
https://lore.kernel.org/r/20240506-rk-dts-additions-v4-0-271023ddfd40@gmai=
l.com
>=20
> Changes in v4:
> - Rebased against linux-rockchip/for-next
> - Reordered DT nodes alphabetically as pointed out by Diederik
> - Moved the TSADC enablement to per-board .dts/.dtsi files
> - Dropped extra "inefficient" OPPs (same voltage - lower frequencies)
> - Dropped second passive cooling trips altogether to keep things =
simple
> - Added a cooling map for passive GPU cooling (in a separate patch)
> - Link to v3: =
https://lore.kernel.org/r/20240229-rk-dts-additions-v3-0-6afe8473a631@gmai=
l.com
>=20
> Changes in v3:
> - Added regulator coupling for EVB1 and QuartzPro64
> - Enabled the TSADC for all boards in .dtsi, not just Rock 5B (thanks =
ChenYu)
> - Added comments regarding two passive cooling trips in each zone =
(thanks Dragan)
> - Fixed active cooling map numbering for Radxa Rock 5B (thanks Dragan)
> - Dropped Daniel's Acked-by tag from the Rock 5B fan patch, as there's =
been quite some
>  churn there since the version he acknowledged
> - Link to v2: =
https://lore.kernel.org/r/20240130-rk-dts-additions-v2-0-c6222c4c78df@gmai=
l.com
>=20
> Changes in v2:
> - Dropped the rfkill patch which Heiko has already applied
> - Set higher 'polling-delay-passive' (100 instead of 20)
> - Name all cooling maps starting from map0 in each respective zone
> - Drop 'contribution' properties from passive cooling maps
> - Link to v1: =
https://lore.kernel.org/r/20240125-rk-dts-additions-v1-0-5879275db36f@gmai=
l.com
>=20
> ---
> Alexey Charkov (8):
>      arm64: dts: rockchip: add thermal zones information on RK3588
>      arm64: dts: rockchip: enable thermal management on all RK3588 =
boards
>      arm64: dts: rockchip: add passive GPU cooling on RK3588
>      arm64: dts: rockchip: enable automatic fan control on Rock 5B
>      arm64: dts: rockchip: Add CPU/memory regulator coupling for =
RK3588
>      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
>      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588j
>      arm64: dts: rockchip: Split GPU OPPs of RK3588 and RK3588j
>=20
> .../boot/dts/rockchip/rk3588-armsom-sige7.dts      |   4 +
> arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 197 =
+++++++++++++++++----
> .../dts/rockchip/rk3588-edgeble-neu6a-common.dtsi  |   4 +
> arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  16 ++
> arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts   |   4 +
> arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi       | 190 =
++++++++++++++++++++
> .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 ++
> arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  34 +++-
> .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |   4 +
> .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |   4 +
> arch/arm64/boot/dts/rockchip/rk3588.dtsi           |   1 +
> arch/arm64/boot/dts/rockchip/rk3588j.dtsi          | 141 =
+++++++++++++++
> arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |   4 +
> arch/arm64/boot/dts/rockchip/rk3588s.dtsi          |   1 +
> 14 files changed, 577 insertions(+), 39 deletions(-)
> ---
> base-commit: 5cc74606bf40a2bbaccd3e3bb2781f637baebde5
> change-id: 20240124-rk-dts-additions-a6d7b52787b9
>=20
> Best regards,
> --=20
> Alexey Charkov <alchark@gmail.com>
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


