Return-Path: <linux-kernel+bounces-344016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297998A2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5148A282140
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E835E18E344;
	Mon, 30 Sep 2024 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xZ/WaeXo"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A018B471
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699765; cv=none; b=A8ziNEFkwiZl3hDL/Gs8o1IPR665ccaSJjdrOoBQu2FC31JY1sJzo1VejAqXquLx0gSjiv5Z+naCxNZVNOfnbBZaN8UicHgu2Yg3t9RCfSD72ClpBECJ0+bpw37zo4N346xgr1nQAgLXREhLYlhUbI1E2Yfwnc2hiN7QfEVTg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699765; c=relaxed/simple;
	bh=ZuhqHBd5T6n4PR075ImTanf0AzLfvmBHac+iCin08lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cpVqF3wZMP0IFkFOIR/Vxvowg68b3zeeaZH582wUX+CmmfbkW08FDdty2gRGKTsgcCm/6M0DdcuyhDyDWIZlDPG//ivKNmEKoBlzWxR8lfNhTatjYJ7QHHjafcVsPi5Yq3ER92FpibHvmLMGp1ZisCtfQK89cR2/IGUIocODMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xZ/WaeXo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so38147355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727699762; x=1728304562; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ9Ka0Ys/+flIMJIlv308swHWJSLUyEk/wV/w9MEUkY=;
        b=xZ/WaeXoFUJFP2U/wALf1+6AtCzrmyN5MYmztpAN4BsUX/o2qWwwcRRojSTVsIdEmb
         7+DUS/BQI9i4tnjuFUhPtXY794vsZ7+q8oMM3ekWd5iTRonC8QcE19R1lLejNt+fNNg8
         HDpU8kg5hWyMXXwIrNr7xjcRC8TgjvxzcY5fUp2aGrB4DJxXEomkbGn7kZZpcJ7EcbEs
         Q2m0/d1I+24Oce/pQLTs3guU1f5ZC/ulw1pEK+R8ybkMI5nXFxGCZqDJ670WI/G2Qg5H
         R3y9BwvyTGYkhwNKyRrjQRhg0Q+wOTCY5H3IcaekGDsPrSrORnfwsPOmw7HwyYaK9bub
         dPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699762; x=1728304562;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ9Ka0Ys/+flIMJIlv308swHWJSLUyEk/wV/w9MEUkY=;
        b=S+AXZh3djkPIsuehJJXXH4dp8I13NTkKyPWUMKfnu2W2VKxWQRn9oTXinfi5T3FXDb
         8bJKItwxGdfexFaJJbmPey8zNQzwjRQioffK0Z2xWft72mFsnx3YzwVbRJ7rY57pOl1S
         nVlgGZQZJ/GpapWwYZ64aTMg+UKF0BZVV4Snp4qIqOGDGK2LoW8pqYGmWrKX7xQ4lYIr
         aogPwngC1jD+jYYl6rTvaaPdx5ZnZvTMykU5Taqg+tAqSGCDwfzzwZmYUQVzeEhHVcxY
         aLoBZIuSGv2n8uvIGwEgu7FNe9xLyHp1YccpaQ+FUk01K7a5yfJZMJHaQw2KVBBwQQCN
         ZFzA==
X-Forwarded-Encrypted: i=1; AJvYcCWZdVgMqT9pQ+Cp4orpgwRi3WseVso0gfa+2DcxVFsJV24oMVXGaBBWg5TaCvtt/b9rFpyjHotvFXrzcBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNG2LElyx9NXwemsPA16Qlf2fdWs4MQsHLjxYwWAFU6N11ToDC
	XAc2Pa06coBozLA3NcVyo0xQrZdgdiupt8FEubBJDUG1r7lMCp0o+ePNTRh5ODI=
X-Google-Smtp-Source: AGHT+IGmR7JFFUQuF6lVSWFCy+u7t+yYCBm95s5oHl3xul8GAli/rvg7sRR5FoOz2zLMnPu/hDQ2Yw==
X-Received: by 2002:a05:600c:5681:b0:42c:b843:792b with SMTP id 5b1f17b1804b1-42f6b1a2918mr22883345e9.2.1727699761890;
        Mon, 30 Sep 2024 05:36:01 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b6ba:bab:ced3:2667])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dd301dsm102743285e9.8.2024.09.30.05.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:36:01 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
In-Reply-To: <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com> (Chuan
	Liu via's message of "Sun, 29 Sep 2024 14:10:06 +0800")
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
	<20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
Date: Mon, 30 Sep 2024 14:36:00 +0200
Message-ID: <1j8qv9tj2n.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun 29 Sep 2024 at 14:10, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> glitch free mux has two clock channels (channel 0 and channel 1) with
> the same configuration. When the frequency needs to be changed, the two
> channels ping-pong to ensure clock continuity and suppress glitch.
>
> Channel 0 of glitch free mux is not only the clock source for the mux,
> but also the working clock for glitch free mux. Therefore, when glitch
> free mux switches, it is necessary to ensure that channel 0 has a clock
> input, otherwise glitch free mux will not work and cannot switch to the
> target channel.
>
> Add flag CLK_SET_RATE_GATE to channels 0 and 1 to implement Ping-Pong
> switchover to suppress glitch.
>
> glitch free mux Add flag CLK_OPS_PARENT_ENABLE to ensure that channel 0
> has clock input when switching channels.

Several 'glitch_free' are not touched by your change. Why ?
I thinking about the mali glitch free mux for example.

>
> Change-Id: I6fa6ff92f7b2e0a13dd7a27feb0e8568be3ca9f9
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  drivers/clk/meson/a1-peripherals.c | 12 ++++++------
>  drivers/clk/meson/axg.c            | 16 ++++++++++------
>  drivers/clk/meson/c3-peripherals.c |  6 +++---
>  drivers/clk/meson/g12a.c           | 18 +++++++++++-------
>  drivers/clk/meson/gxbb.c           | 18 +++++++++++-------
>  drivers/clk/meson/s4-peripherals.c | 32 ++++++++++++++++----------------
>  6 files changed, 57 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
> index 7aa6abb2eb1f..7f515e002adb 100644
> --- a/drivers/clk/meson/a1-peripherals.c
> +++ b/drivers/clk/meson/a1-peripherals.c
> @@ -423,7 +423,7 @@ static struct clk_regmap dspa_a = {
>  			&dspa_a_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -471,7 +471,7 @@ static struct clk_regmap dspa_b = {
>  			&dspa_b_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -489,7 +489,7 @@ static struct clk_regmap dspa_sel = {
>  			&dspa_b.hw,
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -569,7 +569,7 @@ static struct clk_regmap dspb_a = {
>  			&dspb_a_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -617,7 +617,7 @@ static struct clk_regmap dspb_b = {
>  			&dspb_b_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -635,7 +635,7 @@ static struct clk_regmap dspb_sel = {
>  			&dspb_b.hw,
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 1b08daf579b2..e2d3266f4b45 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -1077,7 +1077,8 @@ static struct clk_regmap axg_vpu_0 = {
>  		 * We want to avoid CCF to disable the VPU clock if
>  		 * display has been set by Bootloader
>  		 */
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1126,7 +1127,8 @@ static struct clk_regmap axg_vpu_1 = {
>  		 * We want to avoid CCF to disable the VPU clock if
>  		 * display has been set by Bootloader
>  		 */
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1144,7 +1146,7 @@ static struct clk_regmap axg_vpu = {
>  			&axg_vpu_1.hw
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_NO_REPARENT,
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -1194,7 +1196,8 @@ static struct clk_regmap axg_vapb_0 = {
>  			&axg_vapb_0_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1242,7 +1245,8 @@ static struct clk_regmap axg_vapb_1 = {
>  			&axg_vapb_1_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1260,7 +1264,7 @@ static struct clk_regmap axg_vapb_sel = {
>  			&axg_vapb_1.hw
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_NO_REPARENT,
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
> index 7dcbf4ebee07..27343a73a521 100644
> --- a/drivers/clk/meson/c3-peripherals.c
> +++ b/drivers/clk/meson/c3-peripherals.c
> @@ -1364,7 +1364,7 @@ static struct clk_regmap hcodec_0 = {
>  			&hcodec_0_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1411,7 +1411,7 @@ static struct clk_regmap hcodec_1 = {
>  			&hcodec_1_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1431,7 +1431,7 @@ static struct clk_regmap hcodec = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_data = hcodec_parent_data,
>  		.num_parents = ARRAY_SIZE(hcodec_parent_data),
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index d3539fe9f7af..21a25001e904 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -2746,7 +2746,8 @@ static struct clk_regmap g12a_vpu_0 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vpu_0_div.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -2790,7 +2791,8 @@ static struct clk_regmap g12a_vpu_1 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vpu_1_div.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -2812,7 +2814,7 @@ static struct clk_regmap g12a_vpu = {
>  			&g12a_vpu_1.hw,
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_NO_REPARENT,
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -3035,7 +3037,8 @@ static struct clk_regmap g12a_vapb_0 = {
>  			&g12a_vapb_0_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -3083,7 +3086,8 @@ static struct clk_regmap g12a_vapb_1 = {
>  			&g12a_vapb_1_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -3105,7 +3109,7 @@ static struct clk_regmap g12a_vapb_sel = {
>  			&g12a_vapb_1.hw,
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_NO_REPARENT,
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -4039,7 +4043,7 @@ static struct clk_regmap g12a_mali = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = g12a_mali_parent_hws,
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 262c318edbd5..812b3e20c366 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -1132,7 +1132,7 @@ static struct clk_regmap gxbb_mali = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = gxbb_mali_parent_hws,
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -1543,7 +1543,8 @@ static struct clk_regmap gxbb_vpu_0 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &gxbb_vpu_0_div.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1591,7 +1592,8 @@ static struct clk_regmap gxbb_vpu_1 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &gxbb_vpu_1_div.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1613,7 +1615,7 @@ static struct clk_regmap gxbb_vpu = {
>  			&gxbb_vpu_1.hw
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_NO_REPARENT,
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -1674,7 +1676,8 @@ static struct clk_regmap gxbb_vapb_0 = {
>  			&gxbb_vapb_0_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1726,7 +1729,8 @@ static struct clk_regmap gxbb_vapb_1 = {
>  			&gxbb_vapb_1_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
> +			 CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1748,7 +1752,7 @@ static struct clk_regmap gxbb_vapb_sel = {
>  			&gxbb_vapb_1.hw
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_NO_REPARENT,
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
> index c930cf0614a0..cf10be40141d 100644
> --- a/drivers/clk/meson/s4-peripherals.c
> +++ b/drivers/clk/meson/s4-peripherals.c
> @@ -1404,7 +1404,7 @@ static struct clk_regmap s4_mali_mux = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = s4_mali_parent_hws,
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -1466,7 +1466,7 @@ static struct clk_regmap s4_vdec_p0 = {
>  			&s4_vdec_p0_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1516,7 +1516,7 @@ static struct clk_regmap s4_vdec_p1 = {
>  			&s4_vdec_p1_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1536,7 +1536,7 @@ static struct clk_regmap s4_vdec_mux = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = s4_vdec_mux_parent_hws,
>  		.num_parents = ARRAY_SIZE(s4_vdec_mux_parent_hws),
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -1586,7 +1586,7 @@ static struct clk_regmap s4_hevcf_p0 = {
>  			&s4_hevcf_p0_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1636,7 +1636,7 @@ static struct clk_regmap s4_hevcf_p1 = {
>  			&s4_hevcf_p1_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1656,7 +1656,7 @@ static struct clk_regmap s4_hevcf_mux = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = s4_hevcf_mux_parent_hws,
>  		.num_parents = ARRAY_SIZE(s4_hevcf_mux_parent_hws),
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -1712,7 +1712,7 @@ static struct clk_regmap s4_vpu_0 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_div.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1756,7 +1756,7 @@ static struct clk_regmap s4_vpu_1 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_div.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1774,7 +1774,7 @@ static struct clk_regmap s4_vpu = {
>  			&s4_vpu_1.hw,
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -1921,7 +1921,7 @@ static struct clk_regmap s4_vpu_clkc_p0 = {
>  			&s4_vpu_clkc_p0_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1969,7 +1969,7 @@ static struct clk_regmap s4_vpu_clkc_p1 = {
>  			&s4_vpu_clkc_p1_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -1989,7 +1989,7 @@ static struct clk_regmap s4_vpu_clkc_mux = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = s4_vpu_mux_parent_hws,
>  		.num_parents = ARRAY_SIZE(s4_vpu_mux_parent_hws),
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };
>  
> @@ -2049,7 +2049,7 @@ static struct clk_regmap s4_vapb_0 = {
>  			&s4_vapb_0_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -2097,7 +2097,7 @@ static struct clk_regmap s4_vapb_1 = {
>  			&s4_vapb_1_div.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -2115,7 +2115,7 @@ static struct clk_regmap s4_vapb = {
>  			&s4_vapb_1.hw
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  	},
>  };

-- 
Jerome

