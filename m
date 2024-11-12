Return-Path: <linux-kernel+bounces-405742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122E9C5675
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11821F24840
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09F215012;
	Tue, 12 Nov 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r3pqfyRb"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FC213159
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410162; cv=none; b=dVhaCxQ+QYAxus4pZxeZ452fEJ5AU6fk2nbmokxBF+ggz1u+5rZbpngoO0esj+Bi3fcEWKOGHlwCN5/bmBx6FTXyEo9KvGjdfpYu82q3IIPv6TlwC1BC7r5UdKNLWzfnDlf/w2cEToZQoTkhiTUMV7dfm9DuDkg3QRssV+BYbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410162; c=relaxed/simple;
	bh=hizP8//P3AhJvbUN64BSYyGnfn9TgWLhX61hhPFjptQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a2yVtfc4wmB8vH4JQRM9ya/gxxM9wjIowHm+KpaCNiuJj1u8o6KelYXHD12V0jGTLofRgAwDuuv5n0yJyUvoxR2Hfw0MdKUCjTS5tsaNWUMPl9lUiqs5GlsOjWDzmlnCWJIdrWHmg7VWMXpP1Pu8h9+kdKXkSzPoe2I18iqYkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r3pqfyRb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so5366488e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731410157; x=1732014957; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLL0CXWtIsqIF65EdxQpHUFOBAjPtfjPtszmjqI/qoY=;
        b=r3pqfyRbOotqH9zZn5/V8s7zuA5dyYo4om0O2mTBkrDWg53IXSG7pdOhWgx+7yJl0b
         Mqj62NjhcXK1UJEOq2z+B1IWqac6gxpAkUvAuzp1xL6b6xJmleBL+GiidLMSuvy6BCFR
         C2OxY9dv7BF0cLDwfYOM65ZOgo66vjaLvppCDElDcxzKRYmou+UtAM7t8zmekFhRfXYz
         Hk4JKeZ8g+WPUuR+AcrLaA6Of49e9YMwa4z9KG876hjwV6Izsr1UhlgEwnQUwampOhHx
         T8s4vFWKvLWjyl0riEeWCntMtFaQZ+wFpyyQLGZIRmC6WiI+rTr9lSoYwUrJKNxFKdWy
         ufQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731410157; x=1732014957;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLL0CXWtIsqIF65EdxQpHUFOBAjPtfjPtszmjqI/qoY=;
        b=s9TISammIbcdrf0EHH7wCaQqaLUM5LriU1RIHPvCDr5u9Qha/FxE9PuP6WaFQHZlX4
         T23zIz1X++RyeEsN1Lm6pSg83tTH/fYMv7NrgAYPKYhgF5C0bsivSlNu1XL5cWxecw8A
         ahE0VSN2ECtGk91hl0+ej3FTgop6h5XVXEbnWtyW4v5a2ito5T/BGCo+/EpX/fuI2lBU
         ZAEkEBT7AuPLgi/HdINIXs2HxkUETLf7AYGKY5+wwAyY746C9qYtIds8iFuhivQXbMdv
         Ny7KrkQZoSdLMJwfADN2mdSp9kgak2MzNTN+mwybqFEnWYmb4hxKL1y84n7jOlbUr6RN
         FWhA==
X-Forwarded-Encrypted: i=1; AJvYcCUf0O1hXI31AHwrLP8o3IKug3mE7Fq/YaZxMv0fAFXl781xKhe35iZiuws0Ci3sVsm42t+UXikz9UXsqKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxLIzH9r3xZzSMuJ8bNvFhIeeeRZnBYTrlVjRZVjImk302aOE
	qz9eFh6fe/sH4jkiiLSnee2g1oKx8K4geHLlffbhaeUIc7mauHysK0U+hk15ptA=
X-Google-Smtp-Source: AGHT+IHEnq216Q7LNkZLWrIemOsyxij0OgTuGcQwQihenpTOIVLKF1wFfG65zMsIE16TFRIJKtz4ww==
X-Received: by 2002:a05:6512:124b:b0:539:e454:942e with SMTP id 2adb3069b0e04-53d862c6d31mr7835933e87.16.1731410157372;
        Tue, 12 Nov 2024 03:15:57 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:50f9:1df6:c2b9:a468])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0562642sm208909975e9.21.2024.11.12.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:15:56 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,  Neil
 Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Jian Hu <jian.hu@amlogic.com>,
  Dmitry Rokosov <ddrokosov@sberdevices.ru>,  Yu Tu <yu.tu@amlogic.com>,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: Fix children of ro_clk may be tampered with
In-Reply-To: <e13bc132-fc90-4378-852b-1ff45a6872b9@amlogic.com> (Chuan Liu's
	message of "Tue, 12 Nov 2024 18:16:40 +0800")
References: <20241111-fix_childclk_of_roclk_has_been_tampered_with-v1-1-f8c1b6ffdcb0@amlogic.com>
	<1jr07g25da.fsf@starbuckisacylon.baylibre.com>
	<e13bc132-fc90-4378-852b-1ff45a6872b9@amlogic.com>
Date: Tue, 12 Nov 2024 12:15:56 +0100
Message-ID: <1jikss1z4j.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 12 Nov 2024 at 18:16, Chuan Liu <chuan.liu@amlogic.com> wrote:

> On 11/12/2024 5:01 PM, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Mon 11 Nov 2024 at 17:37, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>
>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>
>>> When setting the rate of a clock using clk_regmap_divider_ro_ops, the
>>> rate of its children may be tampered with.
>>>
>>> Fixes: 84af914404db ("clk: meson: a1: add Amlogic A1 Peripherals clock controller driver")
>>> Fixes: 87173557d2f6 ("clk: meson: clk-pll: remove od parameters")
>>> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
>>> Fixes: 64aa7008e957 ("clk: meson: add a driver for the Meson8/8b/8m2 DDR clock controller")
>>> Fixes: 57b55c76aaf1 ("clk: meson: S4: add support for Amlogic S4 SoC peripheral clock controller")
>>> Fixes: e787c9c55eda ("clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver")
>> Think about stable trying to pick up this ...
>>
>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>> ---
>>> Background: During the execution of clk_set_rate(), the function
>>> clk_core_round_rate_nolock() is called to calculate the matching rate
>>> and save it to 'core->new_rate'. At the same time, it recalculates and
>>> updates its 'child->newrate'. Finally, clk_change_rate() is called to
>>> set all 'new_rates'.
>>>
>>> In clk_regmap_divider_ro_ops, there is an implementation of
>>> 'determine_rate'. If a clock (name as 'ro_divider') that references
>>> clk_regmap_divider_ro_ops is not configured with CLK_DIVIDER_READ_ONLY,
>>> it will result in the calculation of an incorrect core->new_rate and
>>> potentially tamper with child->newrate, ultimately leading to the
>>> corruption of the rate for 'ro_divider's' children.
>> A slitghtly more simple way to put it, is that ro_ops have the regular
>> determine_rate function, so it can actually alter the rate.
>>
>> That should be in the commit description, not where it will be dropped.
>>
>> Requiring the flag in addition to ro_ops in redundant.
>> Plus, it is not the platform that should be fixed but the divider
>> driver.
>>
>> Just put the content of the CLK_DIVIDER_READ_ONLY if clause into a
>> function, clk_regmap_div_ro_determine_rate(), and use it
>> - directly for ro_ops
>> - under if clause for regular ops.
>
> The approach of adding clk_regmap_div_ro_determine_rate() will be
> inconsistent with the style in clk-divider.c in CCF, and
> CLK_DIVIDER_READ_ONLY will also become meaningless for our driver.
> Do we need to maintain the style of clk-divider.c in CCF?

There is no point in having ro_ops that are not actually RO.
Please fix the ops.

>
>>
>>> ---
>>>   drivers/clk/meson/a1-peripherals.c |  2 ++
>>>   drivers/clk/meson/axg.c            |  5 +++--
>>>   drivers/clk/meson/g12a.c           | 23 ++++++++++++++---------
>>>   drivers/clk/meson/gxbb.c           | 18 ++++++++++--------
>>>   drivers/clk/meson/meson8-ddr.c     |  2 +-
>>>   drivers/clk/meson/meson8b.c        |  4 +++-
>>>   drivers/clk/meson/s4-peripherals.c |  2 ++
>>>   drivers/clk/meson/s4-pll.c         |  2 +-
>>>   8 files changed, 36 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
>>> index 7aa6abb2eb1f..eedf7c2bf970 100644
>>> --- a/drivers/clk/meson/a1-peripherals.c
>>> +++ b/drivers/clk/meson/a1-peripherals.c
>>> @@ -266,6 +266,7 @@ static struct clk_regmap sys_b_div = {
>>>                .offset = SYS_CLK_CTRL0,
>>>                .shift = 16,
>>>                .width = 10,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "sys_b_div",
>>> @@ -314,6 +315,7 @@ static struct clk_regmap sys_a_div = {
>>>                .offset = SYS_CLK_CTRL0,
>>>                .shift = 0,
>>>                .width = 10,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "sys_a_div",
>>> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
>>> index 1b08daf579b2..eb86c4d10046 100644
>>> --- a/drivers/clk/meson/axg.c
>>> +++ b/drivers/clk/meson/axg.c
>>> @@ -71,7 +71,7 @@ static struct clk_regmap axg_fixed_pll = {
>>>                .offset = HHI_MPLL_CNTL,
>>>                .shift = 16,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "fixed_pll",
>>> @@ -130,7 +130,7 @@ static struct clk_regmap axg_sys_pll = {
>>>                .offset = HHI_SYS_PLL_CNTL,
>>>                .shift = 16,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "sys_pll",
>>> @@ -471,6 +471,7 @@ static struct clk_regmap axg_mpll_prediv = {
>>>                .offset = HHI_MPLL_CNTL5,
>>>                .shift = 12,
>>>                .width = 1,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "mpll_prediv",
>>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>>> index d3539fe9f7af..c7c9fdfd021f 100644
>>> --- a/drivers/clk/meson/g12a.c
>>> +++ b/drivers/clk/meson/g12a.c
>>> @@ -76,7 +76,7 @@ static struct clk_regmap g12a_fixed_pll = {
>>>                .offset = HHI_FIX_PLL_CNTL0,
>>>                .shift = 16,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "fixed_pll",
>>> @@ -443,6 +443,7 @@ static struct clk_regmap g12a_cpu_clk_mux1_div = {
>>>                .offset = HHI_SYS_CPU_CLK_CNTL0,
>>>                .shift = 20,
>>>                .width = 6,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "cpu_clk_dyn1_div",
>>> @@ -627,6 +628,7 @@ static struct clk_regmap g12b_cpub_clk_mux1_div = {
>>>                .offset = HHI_SYS_CPUB_CLK_CNTL,
>>>                .shift = 20,
>>>                .width = 6,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "cpub_clk_dyn1_div",
>>> @@ -746,6 +748,7 @@ static struct clk_regmap sm1_dsu_clk_mux0_div = {
>>>                .offset = HHI_SYS_CPU_CLK_CNTL5,
>>>                .shift = 4,
>>>                .width = 6,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "dsu_clk_dyn0_div",
>>> @@ -781,6 +784,7 @@ static struct clk_regmap sm1_dsu_clk_mux1_div = {
>>>                .offset = HHI_SYS_CPU_CLK_CNTL5,
>>>                .shift = 20,
>>>                .width = 6,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "dsu_clk_dyn1_div",
>>> @@ -1198,7 +1202,7 @@ static struct clk_regmap g12a_cpu_clk_apb_div = {
>>>                .offset = HHI_SYS_CPU_CLK_CNTL1,
>>>                .shift = 3,
>>>                .width = 3,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "cpu_clk_apb_div",
>>> @@ -1232,7 +1236,7 @@ static struct clk_regmap g12a_cpu_clk_atb_div = {
>>>                .offset = HHI_SYS_CPU_CLK_CNTL1,
>>>                .shift = 6,
>>>                .width = 3,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "cpu_clk_atb_div",
>>> @@ -1266,7 +1270,7 @@ static struct clk_regmap g12a_cpu_clk_axi_div = {
>>>                .offset = HHI_SYS_CPU_CLK_CNTL1,
>>>                .shift = 9,
>>>                .width = 3,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "cpu_clk_axi_div",
>>> @@ -1300,7 +1304,7 @@ static struct clk_regmap g12a_cpu_clk_trace_div = {
>>>                .offset = HHI_SYS_CPU_CLK_CNTL1,
>>>                .shift = 20,
>>>                .width = 3,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "cpu_clk_trace_div",
>>> @@ -1736,7 +1740,7 @@ static struct clk_regmap sm1_gp1_pll = {
>>>                .shift = 16,
>>>                .width = 3,
>>>                .flags = (CLK_DIVIDER_POWER_OF_TWO |
>>> -                       CLK_DIVIDER_ROUND_CLOSEST),
>>> +                       CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_READ_ONLY),
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "gp1_pll",
>>> @@ -1999,7 +2003,7 @@ static struct clk_regmap g12a_hdmi_pll_od = {
>>>                .offset = HHI_HDMI_PLL_CNTL0,
>>>                .shift = 16,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "hdmi_pll_od",
>>> @@ -2017,7 +2021,7 @@ static struct clk_regmap g12a_hdmi_pll_od2 = {
>>>                .offset = HHI_HDMI_PLL_CNTL0,
>>>                .shift = 18,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "hdmi_pll_od2",
>>> @@ -2035,7 +2039,7 @@ static struct clk_regmap g12a_hdmi_pll = {
>>>                .offset = HHI_HDMI_PLL_CNTL0,
>>>                .shift = 20,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "hdmi_pll",
>>> @@ -4048,6 +4052,7 @@ static struct clk_regmap g12a_ts_div = {
>>>                .offset = HHI_TS_CLK_CNTL,
>>>                .shift = 0,
>>>                .width = 8,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "ts_div",
>>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>>> index 262c318edbd5..e2b419100e0c 100644
>>> --- a/drivers/clk/meson/gxbb.c
>>> +++ b/drivers/clk/meson/gxbb.c
>>> @@ -131,7 +131,7 @@ static struct clk_regmap gxbb_fixed_pll = {
>>>                .offset = HHI_MPLL_CNTL,
>>>                .shift = 16,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "fixed_pll",
>>> @@ -267,7 +267,7 @@ static struct clk_regmap gxbb_hdmi_pll_od = {
>>>                .offset = HHI_HDMI_PLL_CNTL2,
>>>                .shift = 16,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "hdmi_pll_od",
>>> @@ -285,7 +285,7 @@ static struct clk_regmap gxbb_hdmi_pll_od2 = {
>>>                .offset = HHI_HDMI_PLL_CNTL2,
>>>                .shift = 22,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "hdmi_pll_od2",
>>> @@ -303,7 +303,7 @@ static struct clk_regmap gxbb_hdmi_pll = {
>>>                .offset = HHI_HDMI_PLL_CNTL2,
>>>                .shift = 18,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "hdmi_pll",
>>> @@ -321,7 +321,7 @@ static struct clk_regmap gxl_hdmi_pll_od = {
>>>                .offset = HHI_HDMI_PLL_CNTL + 8,
>>>                .shift = 21,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "hdmi_pll_od",
>>> @@ -339,7 +339,7 @@ static struct clk_regmap gxl_hdmi_pll_od2 = {
>>>                .offset = HHI_HDMI_PLL_CNTL + 8,
>>>                .shift = 23,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "hdmi_pll_od2",
>>> @@ -357,7 +357,7 @@ static struct clk_regmap gxl_hdmi_pll = {
>>>                .offset = HHI_HDMI_PLL_CNTL + 8,
>>>                .shift = 19,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "hdmi_pll",
>>> @@ -413,7 +413,7 @@ static struct clk_regmap gxbb_sys_pll = {
>>>                .offset = HHI_SYS_PLL_CNTL,
>>>                .shift = 10,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "sys_pll",
>>> @@ -703,6 +703,7 @@ static struct clk_regmap gxbb_mpll_prediv = {
>>>                .offset = HHI_MPLL_CNTL5,
>>>                .shift = 12,
>>>                .width = 1,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "mpll_prediv",
>>> @@ -911,6 +912,7 @@ static struct clk_regmap gxbb_mpeg_clk_div = {
>>>                .offset = HHI_MPEG_CLK_CNTL,
>>>                .shift = 0,
>>>                .width = 7,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "mpeg_clk_div",
>>> diff --git a/drivers/clk/meson/meson8-ddr.c b/drivers/clk/meson/meson8-ddr.c
>>> index 4b73ea244b63..950f323072fb 100644
>>> --- a/drivers/clk/meson/meson8-ddr.c
>>> +++ b/drivers/clk/meson/meson8-ddr.c
>>> @@ -65,7 +65,7 @@ static struct clk_regmap meson8_ddr_pll = {
>>>                .offset = AM_DDR_PLL_CNTL,
>>>                .shift = 16,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "ddr_pll",
>>> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
>>> index e4b474c5f86c..4dba11c0ab7e 100644
>>> --- a/drivers/clk/meson/meson8b.c
>>> +++ b/drivers/clk/meson/meson8b.c
>>> @@ -104,7 +104,7 @@ static struct clk_regmap meson8b_fixed_pll = {
>>>                .offset = HHI_MPLL_CNTL,
>>>                .shift = 16,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "fixed_pll",
>>> @@ -457,6 +457,7 @@ static struct clk_regmap meson8b_mpll_prediv = {
>>>                .offset = HHI_MPLL_CNTL5,
>>>                .shift = 12,
>>>                .width = 1,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "mpll_prediv",
>>> @@ -635,6 +636,7 @@ static struct clk_regmap meson8b_mpeg_clk_div = {
>>>                .offset = HHI_MPEG_CLK_CNTL,
>>>                .shift = 0,
>>>                .width = 7,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "mpeg_clk_div",
>>> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
>>> index c930cf0614a0..470431355e25 100644
>>> --- a/drivers/clk/meson/s4-peripherals.c
>>> +++ b/drivers/clk/meson/s4-peripherals.c
>>> @@ -175,6 +175,7 @@ static struct clk_regmap s4_sysclk_b_div = {
>>>                .offset = CLKCTRL_SYS_CLK_CTRL0,
>>>                .shift = 16,
>>>                .width = 10,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "sysclk_b_div",
>>> @@ -221,6 +222,7 @@ static struct clk_regmap s4_sysclk_a_div = {
>>>                .offset = CLKCTRL_SYS_CLK_CTRL0,
>>>                .shift = 0,
>>>                .width = 10,
>>> +             .flags = CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "sysclk_a_div",
>>> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
>>> index d8e621e79428..5dc051afc06a 100644
>>> --- a/drivers/clk/meson/s4-pll.c
>>> +++ b/drivers/clk/meson/s4-pll.c
>>> @@ -72,7 +72,7 @@ static struct clk_regmap s4_fixed_pll = {
>>>                .offset = ANACTRL_FIXPLL_CTRL0,
>>>                .shift = 16,
>>>                .width = 2,
>>> -             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
>>>        },
>>>        .hw.init = &(struct clk_init_data){
>>>                .name = "fixed_pll",
>>>
>>> ---
>>> base-commit: 664988eb47dd2d6ae1d9e4188ec91832562f8f26
>>> change-id: 20241111-fix_childclk_of_roclk_has_been_tampered_with-61dbcc623746
>>>
>>> Best regards,
>> --
>> Jerome

-- 
Jerome

