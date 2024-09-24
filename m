Return-Path: <linux-kernel+bounces-337202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9079846D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4601C22A66
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05111AAE0E;
	Tue, 24 Sep 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kuDeqfmn"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9E1A7249
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184962; cv=none; b=C7PFbSpWiwu/dpIWS1gPi8cw02qWOE7kOwQTH2smQKxAgOsTiTNdAAJy0oChJkkYiatRQgKHnJ3MQFWHvLNhiTKRLn0FG4h4TJSAS2E5GQtbH6H9XscS8Qq3ziFEh+ngOVPdmMPSrZb/+PGpxoJJN3lyDDl5cySMFBrFKtdHN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184962; c=relaxed/simple;
	bh=a+CvjNi+x4ymrYTU0qFM3/gPdUn+AY63C+zKoxxXt9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sdejp0eG4AHmOQpSwFR8tmEwvH5srZicoT3VUpC7QEdpGvL5w2roXeb8mPf8czULumbtxfiIUzVRUkBh/8ZA3S5eexzTKgfje7Dc7uruTnyv8u5bsky7EekJ8weY7e+XE70tQiMTDZTgPC3rq9TGOx20GMgjtFh6NSx5pX4WQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kuDeqfmn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cc8782869so53108575e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727184957; x=1727789757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E6b+gVIkbGGzSkS722nePILW289klIZmg9uMPH6KhA=;
        b=kuDeqfmnlAuRtlbTLHFkxtuc9FI92tgYrtY8vF17EH/Y5j1KNIBpV6NmElaS8hV4AW
         HRjbHP6cVdlIwcJ4Dgv8V2AhbXwtH8CCTVbn717nRc3+sjrm+l58bl0eUgkrx50UPfRi
         s9Nwxn99oG1gBa5BFaVaM1a9QT4wpa6Fs923o4moAFCLXAWY4NgghpiMuoGJ5oJQsXba
         1WwWDCqGAlhP+1klWlVkGapcOCPf4R9aNzGwFl7/4aShyjXKpWNIHTmSm35seR9rOoB1
         rwV6VoFgF5DnynqpF/mfRWO9ENk0UCy5z73lyvghmkDLw8POg/O/ObZ06aT0BYl1cX2a
         Wflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727184957; x=1727789757;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3E6b+gVIkbGGzSkS722nePILW289klIZmg9uMPH6KhA=;
        b=t1cVVOhgIs0DigcJmSPI9P+zysouoZ1wezIGlwKN1YNwTQkWIjDmnAd3raDadt+x+1
         VwDj/L705IEsGz/mD7+dX/QOPkk/h6TU4301pMPF+iLfdR5fMf3JsbYZVqu9QNN6c7KS
         Y8lmDSeyRNBDW1XRgP1oCkC0ZB6DmA2rrpK20HBI5tJdwljftq4+bYr0H4nP2SLNeLVj
         HbNxB8vRjUxCmKhg5RGqeOosLu1A+TuJ5ncqKqunUXvHoZNKiflqgFwLlLWnmoFQAIpX
         dPpjn9itQiL4/9KK7SoiaRJWMw5bflLqUFPph+gRWS1+8Zk2cKUlLJvc+uc+efor320N
         NyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf5pAR0VZwfL7EBBCpCRM67RvEv0F3/ur3HiAzFZa2hwOgPHmS2CDqQJrCSDWgHbKtDCXkQjY3JY5nNbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEnhbHa2n22heHkyJMxyS2KyWf66onk5CpvD4SLDUo29Lb4DN
	HbVifRB6whsdulOaO7rqBlhsv6y8dGN77nX0iXYCmGB+QSCpOJw0OOJVEIupZeE=
X-Google-Smtp-Source: AGHT+IGBgky4n9wPxuyc6QNRHlbrRzfXmDQaavcvSD3rrUDX/VSO0yvgDNj5ySKrNuM0F3m0fGobvg==
X-Received: by 2002:a05:600c:470d:b0:42c:b63e:fea6 with SMTP id 5b1f17b1804b1-42e7ada50d8mr130393715e9.22.1727184956966;
        Tue, 24 Sep 2024 06:35:56 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e1a:2f3f:4335:573b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e9029eec6sm22472085e9.21.2024.09.24.06.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:35:56 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,  Neil
 Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: pll: Update the meson_clk_pll_init
 execution judgment logic
In-Reply-To: <e458a1c6-5e85-4ecd-a21a-3407a6dd832b@amlogic.com> (Chuan Liu's
	message of "Tue, 24 Sep 2024 18:27:04 +0800")
References: <20240920-optimize_pll_flag-v1-1-c90d84a80a51@amlogic.com>
	<1jy13hxwp2.fsf@starbuckisacylon.baylibre.com>
	<e458a1c6-5e85-4ecd-a21a-3407a6dd832b@amlogic.com>
Date: Tue, 24 Sep 2024 15:35:55 +0200
Message-ID: <1jtte5xjgk.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue 24 Sep 2024 at 18:27, Chuan Liu <chuan.liu@amlogic.com> wrote:

> On 2024/9/24 16:50, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Fri 20 Sep 2024 at 16:13, Chuan Liu via B4 Relay <devnull+chuan.liu.a=
mlogic.com@kernel.org> wrote:
>>
>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>
>>> The hardware property of PLL determines that PLL can only be enabled
>>> after PLL has been initialized. If PLL is not initialized, the
>>> corresponding lock bit will not be set to 1, resulting in
>>> meson_clk_pll_is_enabled() returning "false".
>>>
>>> Therefore, if PLL is already enabled, there is no need to repeat
>>> initialization, and the judgment "CLK_MESON_PLL_NOINIT_ENABLED" in
>>> meson_clk_pll_init() appears redundant.
>> Apparently you messed something up with b4 ...
>
>
> emmmm... I'm not familiar with this tool=F0=9F=98=82
>
>
>>> ---
>>> The hardware property of PLL determines that PLL can only be enabled
>>> after PLL has been initialized. If PLL is not initialized, the
>>> corresponding lock bit will not be set to 1, resulting in
>>> meson_clk_pll_is_enabled() returning "false".
>>>
>>> Therefore, if PLL is already enabled, there is no need to repeat
>>> initialization, and the judgment "CLK_MESON_PLL_NOINIT_ENABLED" in
>>> meson_clk_pll_init() appears redundant.
>
>
> You have a point, but we do get this kind of situation all the time:
>
> For example, hifi_pll provides a clock for audio, which needs to be
> configured
>
> in the bootloader phase in order to play audio as soon as possible after
> boot.
>
> After entering the kernel, the hifi_pll frequency may be dynamically
> adjusted

Whatever was feeding the audio fifo is gone by that stage and fifo, tdm
and everything will be reset as soon the audio drivers are probed.
I hardly see how keeping the PLL init through boot could apply to audio,
especially with the use of assigned-rate in DT.

>
> (to match the audio bit rate/audio and video synchronization, etc.). The
> gp_pll
>
> that provides the clock for eMMC and the hdmi_pll that provides the clock
> for
>
> HDMI are all configured during the bootloader phase and cannot be configu=
red
>
> as RO in the kernel.

HDMI, you presumably want to avoid a glitch in video until you're ready
to reconfigure the pipeline. That would be a valid use-case for
CLK_MESON_PLL_NOINIT_ENABLED.

>
>
> My idea is to still describe the init_regs information in the kernel in t=
he
> driver:
>
> 1) If the bootloader is not enabled, the PLL will be judged as unused
> during the
>
> bootloader phase, and then enter the kernel for initialization.
>
> 2) If the bootloader has enabled PLL, in order to ensure clock continuity
> after
>
> entering the kernel, it will not repeat initialization (re-initialization
> may cause the
>
> module that references PLL to work abnormally).

I understood your idea the first time around. I still do not agree.
Use CLK_MESON_PLL_NOINIT_ENABLED if you must keep an enabled PLL and
justify the use with a proper comment. For eMMC I'm not convinced.

>
> Can the coupling between bootloader and kernel be avoided on the premise =
of
>
> ensuring functional integrity.
>
>
>> If the PLL is enabled, it has been initiallized, to some extent
>> yes. However we have no idea what the setting was. In general, I really
>> don't like inheriting settings from bootloader. It brings all sorts of
>> issues depending on the bootloader origin and version used by the
>> specific platform.
>>
>> So in general a PLL should be re-initialized when possible. When it is
>> not possible, in most case it means the PLL should be RO and linux
>> should just use it.
>>
>> Someone brought a specific case in between, where they needed to keep
>> the PLL on boot, but still be able to relock it later on. The flag
>> properly identify those PLLs. Much like CLK_IS_CRITICAL or
>> CLK_IGNORE_UNUSED, each usage shall be properly documented.
>>
>>> In actual application scenarios, PLL configuration is determined during
>>> the bootloader phase. If PLL has been configured during the bootloader
>>> phase, you need to add a flag to the kernel to avoid PLL
>>> re-initialization, which will increase the coupling between the kernel
>>> and the bootloader.
>> The vast majority of those PLL should be RO then.
>> If you can relock it, you should be able to re-init it as well.
>
>
> re-init may cause glitch in the PLL, which affects module work at later P=
LL
> levels.
>
>
>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>> ---
>>>   drivers/clk/meson/clk-pll.c | 3 +--
>>>   drivers/clk/meson/clk-pll.h | 1 -
>>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>>> index 89f0f04a16ab..8df2add40b57 100644
>>> --- a/drivers/clk/meson/clk-pll.c
>>> +++ b/drivers/clk/meson/clk-pll.c
>>> @@ -316,8 +316,7 @@ static int meson_clk_pll_init(struct clk_hw *hw)
>>>         * Keep the clock running, which was already initialized and ena=
bled
>>>         * from the bootloader stage, to avoid any glitches.
>>>         */
>>> -     if ((pll->flags & CLK_MESON_PLL_NOINIT_ENABLED) &&
>>> -         meson_clk_pll_is_enabled(hw))
>>> +     if (meson_clk_pll_is_enabled(hw))
>>>                return 0;
>> I'm not OK with this.
>>
>>>        if (pll->init_count) {
>>> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
>>> index 949157fb7bf5..cccbf52808b1 100644
>>> --- a/drivers/clk/meson/clk-pll.h
>>> +++ b/drivers/clk/meson/clk-pll.h
>>> @@ -28,7 +28,6 @@ struct pll_mult_range {
>>>        }
>>>
>>>   #define CLK_MESON_PLL_ROUND_CLOSEST  BIT(0)
>>> -#define CLK_MESON_PLL_NOINIT_ENABLED BIT(1)
>>>
>>>   struct meson_clk_pll_data {
>>>        struct parm en;
>>>
>>> ---
>>> base-commit: 0ef513560b53d499c824b77220c537eafe1df90d
>>> change-id: 20240918-optimize_pll_flag-678a88d23f82
>>>
>>> Best regards,
>> --
>> Jerome

--=20
Jerome

