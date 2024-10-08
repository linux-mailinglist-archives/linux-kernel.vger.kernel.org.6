Return-Path: <linux-kernel+bounces-354521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE1993E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4CF1C234F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCF313B582;
	Tue,  8 Oct 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dMAu7ROq"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2917E101
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367344; cv=none; b=U18+HfIZq4lCt0dyhTp7gK4teyH0/IK/hVchkssKzXaSLaAlTaJumPW8pLb39EJUrma5IRDEXm5YWdKGSaYn48Fqf2noRRUCioaJHRqpXHKkIyoql3U2il7aNi6M9vJl1Jmlvg5Nir/PmP0w74ZYG7QzTZ7Y7EwEnw93AnksFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367344; c=relaxed/simple;
	bh=dFnX9PjNcVwbuqSXpJJLYjtAhapfOLBOMv5cyvvkYNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VHAceZr+nVfPxmFiYvQcLeI0ZN598BqD0zDl1MSKptsd/aYrwzUdicV3qfX8jyCaFK6Ho5Z50iU8bpcq0NJTSZDo9Tl3JyeQPCkd2WLATAdOncD+nASFtnZAgOMI7ZtQl3lWKzEQvUJI/mkRdi0+M5J2GVaf4TJc60SNW0xCY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dMAu7ROq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ccfbbd467so3708598f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 23:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728367340; x=1728972140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFnX9PjNcVwbuqSXpJJLYjtAhapfOLBOMv5cyvvkYNA=;
        b=dMAu7ROqQInhqCkD9nVSV0u9PqTEpXMLw8leXCuP8/Cf2dKHmAzmLPmJ6FU3xXk5cZ
         YtnsX6jfInpH7AwJxOl+MkORcK2x7ospBzNxa367eg7NP/KbP/j050VXTL3Tz/Gq0UK9
         dckjuvsm5lpR0gYz623apVVwic4NE8a0m4MPswQzFx4tYtO3zzQaY41PHNItuzNO9tN6
         u5i98sWGB12lwYbifG6s9BqEoFN34e5VIAsZJCeS+QHvnx8RIqeKBD4soj7+vYnmmjgU
         ZG6gRukXnGRoi8m+8qLbbSS0Asn2dDxUgtrC0arCq07p63PGnW4E5Syzf2Q/8OC/AIhB
         wRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728367340; x=1728972140;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFnX9PjNcVwbuqSXpJJLYjtAhapfOLBOMv5cyvvkYNA=;
        b=Blf6bmQqzXU724REjXtI6d7/sRy/aCt0SqWf2odPHKX9b5MAi80a1a+eaCGxeDtE0S
         1VyOutqnm9rmV2shk/JFMf4tm+6wj3TnI7ByuOfAbBvUCxPyJmhdbZHGFsQkK8a2J1wf
         5gLJRh+NMNXzBtDlWaXAab5XiXyfUSJxnVGt50RMiWpDdjNi7ZGgg/ceW/oTJt5o0xAn
         RrKBPQ6qEq10zdtZdDoOv//OSxvGNxDQNygYYLpcClwNss1rQ1sqdWECsKX/Uc9n7e4u
         I2NZd9ajBV5zhoK28OKiOwQ15fNY2AGTyRsJCmsSfmtPzcj+75VRLSaFMWe2Ro9JxxBu
         DPbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVtJTDzJxHApJSXuD4Lv4g8vlCEncegKAHxOK8KkO62jvmiImQErgKoNMYY9CdiUBsRo9ypnHVwFIBxfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytZRRWaGH63BNPuS4p7dc8r1hqHEvefqr0KNZUTWwsO1y67Vxz
	t+j+P1SZifOoEEfqfNU+SRPUX4AislJy1tRvWq6u2NRehnPCiCS3MrWuhNiLo2Y=
X-Google-Smtp-Source: AGHT+IHe+A9wTyATKAfiRoVRSil4JXvoDYrf57UaYrGEMYze/HZIN0MycxHFtINVSh9VQvZZ8GlaIA==
X-Received: by 2002:a5d:598f:0:b0:37c:cdcd:68ac with SMTP id ffacd0b85a97d-37d0e8f74e6mr10479650f8f.52.1728367339614;
        Mon, 07 Oct 2024 23:02:19 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1697024fsm7195797f8f.95.2024.10.07.23.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:02:19 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,  Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
In-Reply-To: <20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com> (Chuan Liu's
	message of "Tue, 8 Oct 2024 13:44:54 +0800")
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
	<20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
	<CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
	<20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
Date: Tue, 08 Oct 2024 08:02:18 +0200
Message-ID: <1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue 08 Oct 2024 at 13:44, Chuan Liu <chuan.liu@amlogic.com> wrote:

> Hi Martin,
>
>
> On 2024/10/1 4:08, Martin Blumenstingl wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hello,
>>
>> On Sun, Sep 29, 2024 at 8:10=E2=80=AFAM Chuan Liu via B4 Relay
>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>
>>> glitch free mux has two clock channels (channel 0 and channel 1) with
>>> the same configuration. When the frequency needs to be changed, the two
>>> channels ping-pong to ensure clock continuity and suppress glitch.
>> You describe the solution to this below:
>>> Add flag CLK_SET_RATE_GATE to channels 0 and 1 to implement Ping-Pong
>>> switchover to suppress glitch.
>> It would be great to have this change in a separate patch.
>> The clocks to which you're adding CLK_SET_RATE_GATE aren't switched at
>> runtime in mainline kernels (at least I think so).
>
>
> Okay, I will separate it into two patches and submit it in the next versi=
on.
>
>
>>
>>> Channel 0 of glitch free mux is not only the clock source for the mux,
>>> but also the working clock for glitch free mux. Therefore, when glitch
>>> free mux switches, it is necessary to ensure that channel 0 has a clock
>>> input, otherwise glitch free mux will not work and cannot switch to the
>>> target channel.
>> [...]
>>> glitch free mux Add flag CLK_OPS_PARENT_ENABLE to ensure that channel 0
>>> has clock input when switching channels.
>> This describes a second problem. I think it's best to have this in a
>> separate commit/patch.
>> Also you're updating some mali clocks (e.g. on G12 and GX) but not all
>> of them (Meson8b for example is missing).
>
>
> Yes, M8 missed it, I will complete it in the next version.
>
>
>>
>> I still have some questions to the CLK_OPS_PARENT_ENABLE approach -
>> please share your findings on this.
>>
>> There's multiple clocks involved in a glitch-free mux hierarchy:
>> - a number of clock inputs (e.g. fclk, xtal, ...)
>> - two muxes (one for every channel of the glitch-free mux)
>> - two dividers (one for every channel of the glitch-free mux)
>> - two gates (one for every channel of the glitch-free mux)
>> - the glitch-free mux
>>
>> When switching from channel 0 (which is active and enabled) CCF
>> (common clock framework) will:
>> a) on channel 1:
>> - find the best input clock
>> - choose the best input clock in the mux
>> - set the divider
>> - enable the gate
>> b) switch the glitch-free mux
>> c) on channel 2:
>> - disable the gate
>>
>> To me it's not clear at which level the problem occurs (glitch-free
>> mux, gate, divider, mux, input clock).
>> Also I don't understand why enabling the clocks with
>> CLK_OPS_PARENT_ENABLE solves any problem since CCF is doing things
>> automatically for us.
>> Can you please explain (preferably with an example) what problem is
>> solved with this approach?
>
>
> If CLK_OPS_PARENT_ENABLE is configured in mux, 'new_parent' and
> 'old_parent' will be enabled first when __clk_set_parent_before() is
> called. And disable them at __clk_set_parent_after(). Our glitch free
> only has two clock sources, so adding this flag ensures that both
> channels 0 and 1 are enabled when mux switches.
>
> In fact, we just need to make sure that channel 0 is enabled. The
> purpose of CLK_OPS_PARENT_ENABLE may not be to solve our situation,
> but adding this flag does solve our current problem.

This is last point is important.

It is OK to use a side effect of CLK_OPS_PARENT_ENABLE but it needs to
be documented somehow, so what really matters is still known 2y from now.

Make sure the information appears in the code comments at least once.

>
>
>>
>> Last but not least: if we're running into bugs when
>> CLK_OPS_PARENT_ENABLE is missing then that patch should carry a Fixes
>> tag.
>
>
> Thanks for the heads-up. I'll keep an eye on it in the next version.
>
>
>>
>> Best regards,
>> Martin

--=20
Jerome

