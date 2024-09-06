Return-Path: <linux-kernel+bounces-318300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038B96EB78
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192B6287F33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382C14AD3F;
	Fri,  6 Sep 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hCenTb6e"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09D14AD03
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606267; cv=none; b=bxSjaRgmmH82h/5BNQ4iRopqtkDYNzuEPiZ1+/gj8S5KNgCvYAmYMHrb8VG1GVZQvhrDyLSkCzWSoO97jNHql60pJ5GSxnusvPz2gPYvgJP/8K/T5epCifbZxkucoOK6196k+UkGjA1n+EqG07cDAjAkC12doznC7pinzl2leUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606267; c=relaxed/simple;
	bh=8WjZia20575zWwWqBXNo4kBtOCi4n8bCZvJqfR2vml4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MzvWKXjo0v2liQosCXCA40W+CS3gU275iJ98qeeW+JuA6+RGq6kAp/JW2U6pb2eV61ixBDF+4Joeb0nIjQdw2u2submPh9f1wYQ/wZTyhzcrzVYY/hIRCj81lJnDUMTkUsBV1Uax1UUa46JV+SSkXrcoyNkCAyqoSyo9ejo56Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hCenTb6e; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374ba78f192so907987f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725606263; x=1726211063; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mmvQ+Tp6rwj8ytkbPRHE2L4V7NjEhAGYliO1vaPNhGg=;
        b=hCenTb6e1BckR3gufECmL1ihXasB6qKBHcGNdNiX6rH7SXGtigQqRGVbJMKqkO9Rd/
         YaN+vvVx9UO93yUupadZzuE0O1upp83Ou9PcIeFs6dp+VmoqBTcu854zJgofFX6ht8lW
         sttSciWlnWq1iOgy1HRwLWAnhG8tR+H5f8N3DeVLaVlCko6b7zaCpPtI1rePjL+RDUGW
         IDsYdKeeO7nzOIJTuj9jUJfA4BacEz5Kfa4GeWqZ/mvqCE/1Dp/STmYKBc59fx8/aIlS
         5jXCWBgV8uAvra657YpoMBwePp/OUauG7jCrENJX5CfnKb3J7SdoKGAZL0dTRkTYOTJN
         4LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725606263; x=1726211063;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmvQ+Tp6rwj8ytkbPRHE2L4V7NjEhAGYliO1vaPNhGg=;
        b=OzGtqV5paj7nwKJAWXUZsd0Igdgcv3UaIfEJszEyg5iUlDW1IK4hPvheofz8FtcHFB
         G7gi1u2ClymilSMqNEVJQk/lilw7rvX7WerQVAyaarJuvQ4cbHoyb1136YYg6XPCaYbb
         d/IJ60hehxpJFG1tegQ69+zagE8cXYfkFChEYknTQK6qiTPRWDRu1Ji9x+SU868aaKOG
         WNQrSmb5v31/WZWzeI+wUmSBadKS/Bm8ME7gIydhTxTd+DzWKckQaAlM5rRb+f9JcoIY
         WnCsfW/jpHPucDgTe1ZU5sMvRmrOgUHUppXbSdctQZNRdxX1l5O7xFN7czO8egX7N7nY
         Foqg==
X-Forwarded-Encrypted: i=1; AJvYcCW9IHT2+clFEjYjhZVDCXL/0myDocgSpSN0hP/+fRli4s2U+0i3xg9Kc3SNgjFg/AWyajSVQ2oOOW7j/rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpKm6sITcbum7qXjLRPBpUQAQTvy6arlZQvStpgKSuyx8Gc6X
	PT5TiM0IzmkxOBrDaA+5xJtDlGt5OFYkT4vSVBcjQN2+DR+O3MVFt36Yg6IdZwQ=
X-Google-Smtp-Source: AGHT+IGlyWHVSEWro5k26v/9BbprNSe8PT6hvmfZpe/tLbwFZ0rhCf+beAnjTByheeKXnnumuvMrBw==
X-Received: by 2002:adf:e747:0:b0:374:c847:866 with SMTP id ffacd0b85a97d-378895cb1ddmr1033472f8f.23.1725606263243;
        Fri, 06 Sep 2024 00:04:23 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:4e33:801c:cee0:ee57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05c70d6sm10465345e9.5.2024.09.06.00.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:04:12 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] clk: meson: Fix an issue with inaccurate hifi_pll
 frequency
In-Reply-To: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com> (Chuan Liu via's
	message of "Fri, 06 Sep 2024 13:52:32 +0800")
References: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
Date: Fri, 06 Sep 2024 09:04:01 +0200
Message-ID: <1jo751qn4u.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 06 Sep 2024 at 13:52, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> Some PLLs with fractional multipliers have fractional denominators that
> are fixed to "100000" instead of the previous "(1 << pll->frac.width)".
>
> The hifi_pll for both C3 and S4 supports a fractional multiplier and has
> a fixed fractional denominator of "100000".
>
> Here are the results of the C3-based command tests (already defined
> CLOCK_ALLOW_WRITE_DEBUGFS):
> * echo 491520000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
> * cat /sys/kernel/debug/clk/hifi_pll/clk_rate
> 491520000
> * echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
> * cat /sys/kernel/debug/meson-clk-msr/clks/hifi_pll_clk
> 491515625       +/-15625Hz
> * devmem 0xfe008100 32
> 0xD00304A3
> * devmem 0xfe008104 32
> 0x00014820
>
> Based on the register information read above, it can be obtained:
> m = 0xA3 = 0d163;
> n = 0x1 = 0d1
> frac = 0x14820 = 0d84000
> od = 0x3 = 0d3
>
> hifi_pll calculates the output frequency:
> calc_rate = xtal_rate / n * (m + (frac / frac_max)) >> od;
> calc_rate = 24000000 / 1 * (163 + (84000 / 100000)) >> 3;
> calc_rate = 491520000
>
> clk_rate, msr_rate, and calc_rate all match.

Thanks for the detailed description.

Is there a possibility this applies to the g12/sm1 as well ? HiFi PLL
has had trouble on these SoCs since support has been added. It sometimes
takes a long time to report a lock. So long we consider it a failure.

There was no such issue on AXG. If you check DT, it is the reason why
AXG use the HiFi PLL for the sound card and G12/SM1 does not.

>
> The test and calculation results of S4 are consistent with those of C3,
> which will not be repeated here.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
> Chuan Liu (4):
>       clk: meson: Support PLL with fixed fractional denominators
>       clk: meson: c3: pll: hifi_pll frequency is not accurate
>       clk: meson: s4: pll: hifi_pll support fractional multiplier
>       clk: meson: s4: pll: hifi_pll frequency is not accurate
>
>  drivers/clk/meson/c3-pll.c  |  1 +
>  drivers/clk/meson/clk-pll.c | 22 +++++++++++++++++++---
>  drivers/clk/meson/clk-pll.h |  1 +
>  drivers/clk/meson/s4-pll.c  |  9 +++++++--
>  4 files changed, 28 insertions(+), 5 deletions(-)
> ---
> base-commit: adac147c6a32e2919cb04555387e12e738991a19
> change-id: 20240904-fix_clk-668f7a1a2b16
>
> Best regards,

-- 
Jerome

