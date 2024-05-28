Return-Path: <linux-kernel+bounces-192936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637348D2491
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621B41C24C88
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E14172769;
	Tue, 28 May 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc0voWwj"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F67CA6B;
	Tue, 28 May 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924390; cv=none; b=A02108/XYYOr8RtthxXfWD3T0bfcY1DvWlwYXNQYOm+Pb0AA2R0SdDESHQ0beMh8dBMGjewTgtda5p3vaRdPA0TuRimJOhVHA3h5sFgIsgju5LNwgxjVxYte4sTKsEU5tmnVUdr9TTUco4g7jTrdOyI/l3JyJlWxWEX5jc8DvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924390; c=relaxed/simple;
	bh=E0rpGeeCP7voGFn7lwlv1AWxiARDoQhLXHDzEw+nhBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTEZjvTNZphdkmdJEwKcfAGvHrnuZ0+dngtHcvFWvBayDizDudooOJLAIBns/+MSNZ4Ofm+DBNh7ir9m55l+0sBP14cB3BhqfjFThYX3I+ZGaSosM2mgFXjQmhw7RH4vtNvRjc/TG8cmvEQzV7IRf37fZwapj6K3ZP9EsG8d5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc0voWwj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6267778b3aso129054066b.3;
        Tue, 28 May 2024 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716924387; x=1717529187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0rpGeeCP7voGFn7lwlv1AWxiARDoQhLXHDzEw+nhBw=;
        b=Tc0voWwjw21IBFJZz5Knskh4/XPgHLceMdWaLtDT9Iwz9SRL+s7U5AjqAehvx/PmmH
         O90cKy8dKYLUFQvZixY8puqatiyFRFiTk+g/UKWOFiRBrOgq0i26D3NrcV2mk0E6M0tX
         fGEz8UAnNEa8eQfwDvG7hNlNqjqn4F/8CXZ38Mb67J/T5167+3a/hxPb6EUBqf/LUKt1
         reIK/hZfUgw1SsYuKHKixqkGrVQvTkmXVV9KXkpVFWYPSFEay3xANGti5Nd88YjxGMGD
         LznrgxdQixbiPj+qYEN8vPulPOcv+KoaR2uJa8MOYOOCf186aLMDCJ0OIf6UKIOFCwys
         1VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716924387; x=1717529187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0rpGeeCP7voGFn7lwlv1AWxiARDoQhLXHDzEw+nhBw=;
        b=oWcsXB1rV66gpQiiy0G8s+9vJpCpQL72hflWPqMOSgtxym8vTWqQ4HKrsPgCvgIQ/a
         zKvFKv6E8vk7NcwVnQnT7V5n116cRWs4rqwdPYZRugBzMyvGENqttla9f9sfH5P+/T4m
         +vnSkuPJ3applyaYlIP1KKim/ffhr/6TBIP4CVCYtx/eErGdz0vvM0e/PiYpBKLUBdT1
         LX4iHwwmRB5KdWZwPvULjvlfToVnMMkpbCUs14uogR/u9taJI/i8VCMq/SUpFIKfGx4c
         XIvYjLk4Sok74VhadMVXTlO5e3yi+56WThVIr9EchH57fWAkNtfk1bQTCeK394/05/zX
         c7IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYjgk3CxxfDG87wykwm2NU7+pawIZ7no6mIQ7V9TjsHhopsFbK2NvyoJyiTyhAPUAd8F4Ys9JEEY2FlMslYrm7XbL/HRFU8pK9UJHZ6v93BqzOsgpQX9oVZ0wTExu+kDL5WzXdcYuNOA==
X-Gm-Message-State: AOJu0YxY90twPiRG0K07DZ224VBJrGoTaAhT2IAktVFra3Jfry4A+PfJ
	nS2GfoBbu37MiJTmSpcDKY1BUOhX8bqJ5V+9X6WfZOSTO3OKc1AJH3el9sj3da1Xmfmsg0Yg8My
	8BBr4SmuO/k2PpLDq1mfV7jtthpo=
X-Google-Smtp-Source: AGHT+IH16cOJPSnFEdx+SAg83u+CDNAgZ/4MCePJYKfdz3zI1J15Xip1jbGI1A7GI0pR23/jJTZTkvuOBevQ2RqdsSE=
X-Received: by 2002:a17:906:5a70:b0:a5a:1562:5187 with SMTP id
 a640c23a62f3a-a626512942fmr890646166b.55.1716924386946; Tue, 28 May 2024
 12:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <5122636.irdbgypaU6@phil> <8727e1c29bd6f562a7fc3de0ddac62cf@manjaro.org>
 <6230150.aeNJFYEL58@phil> <CABjd4YyRJS0AGehuBTDn8ys9uRRkGc0Usme3GX1POq3AQiWTBA@mail.gmail.com>
 <646a33e0-5c1b-471c-8183-2c0df40ea51a@cherry.de>
In-Reply-To: <646a33e0-5c1b-471c-8183-2c0df40ea51a@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 28 May 2024 23:26:15 +0400
Message-ID: <CABjd4Yxi=+3gkNnH3BysUzzYsji-=-yROtzEc8jM_g0roKB0-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal, OPP and fan
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Diederik de Haas <didi.debian@cknow.org>, 
	Dragan Simic <dsimic@manjaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:08=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi all,
>
> On 5/28/24 5:42 PM, Alexey Charkov wrote:
> > On Tue, 28 May 2024 at 19:16, Heiko Stuebner <heiko@sntech.de> wrote:
> >
> >> Am Dienstag, 28. Mai 2024, 17:01:48 CEST schrieb Dragan Simic:
> >>> On 2024-05-28 16:34, Heiko Stuebner wrote:
> >>>> Am Dienstag, 28. Mai 2024, 16:05:04 CEST schrieb Dragan Simic:
> >>>>> On 2024-05-28 11:49, Alexey Charkov wrote:
> >>>>>> On Mon, May 6, 2024 at 1:37=E2=80=AFPM Alexey Charkov <alchark@gma=
il.com>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> This enables thermal monitoring and CPU DVFS on RK3588(s), as wel=
l
> >> as
> >>>>>>> active cooling on Radxa Rock 5B via the provided PWM fan.
> >>>>>>>
> >>>>>>> Some RK3588 boards use separate regulators to supply CPUs and the=
ir
> >>>>>>> respective memory interfaces, so this is handled by coupling thos=
e
> >>>>>>> regulators in affected boards' device trees to ensure that their
> >>>>>>> voltage is adjusted in step.
> >>>>>>>
> >>>>>>> This also enables the built-in thermal sensor (TSADC) for all
> >> boards
> >>>>>>> that don't currently have it enabled, using the default CRU based
> >>>>>>> emergency thermal reset. This default configuration only uses
> >> on-SoC
> >>>>>>> devices and doesn't rely on any external wiring, thus it should
> >> work
> >>>>>>> for all devices (tested only on Rock 5B though).
> >>>>>>>
> >>>>>>> The boards that have TSADC_SHUT signal wired to the PMIC reset li=
ne
> >>>>>>> can choose to override the default reset logic in favour of GPIO
> >>>>>>> driven (PMIC assisted) reset, but in my testing it didn't work on
> >>>>>>> Radxa Rock 5B - maybe I'm reading the schematic wrong and it
> >> doesn't
> >>>>>>> support PMIC assisted reset after all.
> >>>>>>>
> >>>>>>> Fan control on Rock 5B has been split into two intervals: let it
> >> spin
> >>>>>>> at the minimum cooling state between 55C and 65C, and then
> >> accelerate
> >>>>>>> if the system crosses the 65C mark - thanks to Dragan for
> >> suggesting.
> >>>>>>> This lets some cooling setups with beefier heatsinks and/or large=
r
> >>>>>>> fan fins to stay in the quietest non-zero fan state while still
> >>>>>>> gaining potential benefits from the airflow it generates, and
> >>>>>>> possibly avoiding noisy speeds altogether for some workloads.
> >>>>>>>
> >>>>>>> OPPs help actually scale CPU frequencies up and down for both
> >> cooling
> >>>>>>> and performance - tested on Rock 5B under varied loads. I've
> >> dropped
> >>>>>>> those OPPs that cause frequency reductions without accompanying
> >>>>>>> decrease
> >>>>>>> in CPU voltage, as they don't seem to be adding much benefit in
> >> day to
> >>>>>>> day use, while the kernel log gets a number of "OPP is inefficien=
t"
> >>>>>>> lines.
> >>>>>>>
> >>>>>>> Note that this submission doesn't touch the SRAM read margin
> >> updates
> >>>>>>> or
> >>>>>>> the OPP calibration based on silicon quality which the downstream
> >>>>>>> driver
> >>>>>>> does and which were mentioned in [1]. It works as it is (also
> >>>>>>> confirmed by
> >>>>>>> Sebastian in his follow-up message [2]), and it is stable in my
> >>>>>>> testing on
> >>>>>>> Rock 5B, so it sounds better to merge a simple version first and
> >> then
> >>>>>>> extend when/if required.
> >>>>>>>
> >>>>>>> [1]
> >>>>>>>
> >> https://lore.kernel.org/linux-rockchip/CABjd4YzTL=3D5S7cS8ACNAYVa730WA=
3iGd5L_wP1Vn9=3Df83RCORA@mail.gmail.com/
> >>>>>>> [2]
> >>>>>>>
> >> https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kw=
kbguiolmozntjuiajrb@gvq4nupzna4o/
> >>>>>>>
> >>>>>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >>>>>>> ---
> >>>>>>
> >>>>>> Hi Heiko,
> >>>>>>
> >>>>>> Do you think this can be merged for 6.11? Looks like there hasn't
> >> been
> >>>>>> any new feedback in a while, and it would be good to have frequenc=
y
> >>>>>> scaling in place for RK3588.
> >>>>>>
> >>>>>> Please let me know if you have any reservations or if we need any
> >>>>>> broader discussion.
> >>>>
> >>>> not really reservations, more like there was still discussion going =
on
> >>>> around the OPPs. Meanwhile we had more discussions regarding the who=
le
> >>>> speed binning Rockchip seems to do for rk3588 variants.
> >>>>
> >>>> And waiting for the testing Dragan wanted to do ;-) .
> >>>
> >>> I'm sorry for the delays.
> >>
> >> Was definitly _not_ meant as blame ;-) .
> >>
> >> The series has just too many discussions threads to unravel on half
> >> an afternoon.
> >
> >
> > FWIW, I think the latest exchange we had with Quentin regarding the OPP=
s
> > concluded in =E2=80=9Cfalse alarm=E2=80=9D, given that this version of =
the series only
> > introduces a subset of them which should apply to all RK3588(s)
> >
>
> Correct.
>
> However... I'm wondering if we shouldn't somehow follow the same pattern
> we have used for the rk3399 OPPs? We have a file for the "true" RK3399
> OPPs, then the OP1 variant and the RK3399T.
>
> We already know there are a few variants of RK3588 with different OPPs:
> RK3588(S/S2?), RK3588J and RK3588M. I wouldn't be surprised if the
> RK3582 (though this one has already one big cluster (or two big cores)
> fewer than RK3588) has different OPPs as well?
>
> So. We have already discussed that the OPPs in that patch are valid for
> RK3588(S) but they aren't for the other variants.

Hmm. Looking at Rockchip sources [1] more closely as opposed to the
Radxa tree I've been using as the basis, it does indeed show that
RK3588J and RK3588M use a different OPP table altogether (frequencies
are similar, but voltages differ).

We currently have an RK3588J based board in the mainline tree
(rk3588-edgeble-neu6b-io.dts), so it can't be ignored. However, given
that Rockchip sources only differentiate those OPPs by SoC revision,
and that is (currently?) known for each board at dtb compile time, it
seems easier to just include two different OPP tables for RK3588(S)
vs. RK3588J - thus avoiding all the headache with opp-supported-hw.
Similar to RK3399, yes.

Will split those out and send a separate version.

> In the downstream kernel, any OPP whose opp-supported-hw has a first
> value masked by BIT(1) return non-0 is supported by RK3588M. In the
> downstream kernel, any OPP whose opp-supported-hw has a first value
> masked by BIT(2) return non-0 is supported by RK3588J.
>
> This means that, for LITTLE clusters:
> - opp-1608000000 not supported on RK3588J
> - opp-1704000000 only supported on RK3588M (but already absent in this
> patch series)
> - opp-1800000000 only supported on RK3588(S), not RK3588J nor RK3588M
>
> For big clusters:
> - opp-1800000000 not supported on RK3588J
> - opp-2016000000 not supported on RK3588J
> - opp-2208000000 only supported on RK3588(S), not RK3588J nor RK3588M
> - opp-2256000000 only supported on RK3588(S), not RK3588J nor RK3588M
> - opp-2304000000 only supported on RK3588(S), not RK3588J nor RK3588M
> - opp-2352000000 only supported on RK3588(S), not RK3588J nor RK3588M
> - opp-2400000000 only supported on RK3588(S), not RK3588J nor RK3588M
>
> This is somehow also enforced in downstream kernel by removing the OPP
> nodes directly (hence, not even requiring the check of opp-supported-hw
> value), c.f.:
> https://git.theobroma-systems.com/tiger-linux.git/tree/arch/arm64/boot/dt=
s/rockchip/rk3588j.dtsi
> https://git.theobroma-systems.com/tiger-linux.git/tree/arch/arm64/boot/dt=
s/rockchip/rk3588m.dtsi
>
> You'll not that the RK3588J also has less OPPs for the GPU and NPU (but
> those should also be masked by the opp-supported-hw value).

Same with DMC, but we don't currently have either DMC or NPU in the
mainline tree, so it sounds like something to be dealt with later :)

Best regards,
Alexey

[1] https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/b=
oot/dts/rockchip/rk3588s.dtsi

