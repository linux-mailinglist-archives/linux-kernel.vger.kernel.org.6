Return-Path: <linux-kernel+bounces-535933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBEDA4796E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5859A3B22AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB1F227E8D;
	Thu, 27 Feb 2025 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u6PFrDzK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B1226177
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740649128; cv=none; b=rRExjqvSfRlTTZOiYQKbqzgQw/XVkNNX3+D+LSY/BnKflQRubbfjedspe2q9/YA875h6oIa5zp8QSX311CTqaZABU5xf+MYUBXW+j1ksLqZ3gvu2393YrH+5aUJ7VoF9GRUbUVFApFHWcCEnytXZANZW0JD1JUe8beFWcXx8jww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740649128; c=relaxed/simple;
	bh=klcyv/tjVkjs4m6UAHjQfCID6SW72sqaBFJeCg7JikA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W0V1zuYAclrM8VBsM+ItITpKL0uYnmZp8hkUqVWN+xsOXlWYPwkFeDQ/7CetGCpqDnU1lvF5SgMqae5yEts/g4smXhEofTeunD/pNk4Z/5PczJHwWBKzYLklkdeU+81TZhk0p/byzTbtWteaQalFfSvQIWcT/wo+ZlAa3+z3URI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u6PFrDzK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f403edb4eso357455f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740649123; x=1741253923; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSFMyHZjL2sLB+0egAbBkuSTNnV3nLYFcpeSny0Lnto=;
        b=u6PFrDzKtHyB66OdTUfN0SGd6NiQf5FLusKcUQeUKphGOUKuVCcouGOnkAH0UHqk7D
         z0+1vLuOUp1ef8I3y26+qQZnx9AjAZp2iaLZOdbd3nEMGHvR/q3Syjcjt+m2H5YGlyKr
         AjaxhmUFIZJE9x7jW3+ObNIFudJ72dY4C8YJtskwCfkr0sQVYXjtas+qWJRLq7uhCaWn
         sdX23vvmQqDY+AmqhQxfjHcTmyBXUnaHKHGVt1V6TgWp9S6/AQTXJgNspHE2Dg4Tuh7F
         XcPeIcAATwz4yc87FqJsAn5J5N4/ErTpUGm3OAGMZHTxxHxvDXSYtyvGQ9CR5hVAes0C
         uz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740649123; x=1741253923;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSFMyHZjL2sLB+0egAbBkuSTNnV3nLYFcpeSny0Lnto=;
        b=OqkDvwsWdsQu8xtSqBHkZsR4VIh/UGXhoKJz1NAEKdt2DTFdTDr9aZPjoeBlXJA/P4
         YwvzqLp7KOv83BwwOfw9qRYKRdmInFZkMMleldH8ZeXC7fk4t82kzDhCzAsRNjMxegyJ
         vhSG5plHF/8FYYlFxGcMLwUpj6QBzwCTAVeNaEnitsL2Wohpe3NNALNlrhqxSQY+0EKz
         /H/vGTS0LMWqUTULz6B5IkF/XYfGHuiWljZGQ+efkGmyemapdIPNl6snNx8ZPBwX6GYN
         KqrRfmNSd1Zu+vAw9QJQEu04ZeotR0uhRL/NmtGyDZv3mqQFSsrtyKFhQwSoJYjHoTtG
         TiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV14Z7+HfiXN/StKn/JuqxdTZpoUQ41fZcgSbt+mSnwmmRYIZJHuzf5xZhd56uwtI5+iIW/kgESnsLVcck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpiIvjCMkiKvJV48MbIak7iwsTEdpAVN7fp44KtuExv0xdkZA
	bZFgpDV1D4OqXRqQ55weGG/p/xYrGyC8y9ZnXmAx9nMXT3Vg5+/VZ2zCet7gCgYSbliQlcqD/iP
	cAjA=
X-Gm-Gg: ASbGncvJwReaXQ0MFom/1JfWnEOFBMLBjFI5lzsngoWl8wQEAWUUdnVg5OoC+4RW9Gw
	dvifhB1NA+h+afxo5zPA7JpyH8nvUgR+V72JXAh24N2TWUcMJo2fbvuGXFQAw3SJXNOI8Z2NqrN
	xfGJC0Xt4MXFb1tQ6jMZI8eUpCL9lik1nbjddm4gY2Xde3YnEdRqowRB72/Ud2J8GPJ746qF+N2
	cPxTDFiheYQkRnMQlEo0B6kJz6mVF7s3cAHJmPigfSbSWa6pQa65cbwuNmw2h2KHleTxHek7Oev
	9GFW9f163d0uy9A/J1xP0wGxuw==
X-Google-Smtp-Source: AGHT+IFUel99Gq412qHUYoqq4QU0Kh33QuQ9q7aFAyceuOEGM3mTTh0OtaZyPMhSjBmzd7LFLY/Vng==
X-Received: by 2002:a5d:64a9:0:b0:390:e853:85bd with SMTP id ffacd0b85a97d-390e8538bfdmr865626f8f.48.1740649122847;
        Thu, 27 Feb 2025 01:38:42 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:ede3:f33f:7555:723d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e479652dsm1484719f8f.16.2025.02.27.01.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:38:42 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: <linux@martijnvandeventer.nl>
Cc: "'Neil Armstrong'" <neil.armstrong@linaro.org>,  "'Michael Turquette'"
 <mturquette@baylibre.com>,  "'Stephen Boyd'" <sboyd@kernel.org>,  "'Kevin
 Hilman'" <khilman@baylibre.com>,  "'Martin Blumenstingl'"
 <martin.blumenstingl@googlemail.com>,
  <linux-amlogic@lists.infradead.org>,  <linux-clk@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: meson: g12a: Fix kernel warnings when no display
 attached
In-Reply-To: <003301db888e$8ea84e90$abf8ebb0$@martijnvandeventer.nl>
	(linux@martijnvandeventer.nl's message of "Wed, 26 Feb 2025 21:39:39
	+0100")
References: <20250213221702.606-1-linux@martijnvandeventer.nl>
	<1jpljkzyf0.fsf@starbuckisacylon.baylibre.com>
	<003301db888e$8ea84e90$abf8ebb0$@martijnvandeventer.nl>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 27 Feb 2025 10:38:41 +0100
Message-ID: <1jplj3g21q.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 26 Feb 2025 at 21:39, <linux@martijnvandeventer.nl> wrote:

> Hi Jerome,
>
> Thank you for reviewing, and apologies for my late response due to a holiday.
>
>> On Thu 13 Feb 2025 at 23:17, Martijn van Deventer
>> <linux@martijnvandeventer.nl> wrote:
>> 
>> > When booting SM1 or G12A boards without a dislay attached to HDMI,
>> > the kernel shows the following warning:
>> >
>> > [CRTC:46:meson_crtc] vblank wait timed out
>> > WARNING: CPU: 2 PID: 265 at drivers/gpu/drm/drm_atomic_helper.c:1682
>> drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
>> > CPU: 2 UID: 0 PID: 265 Comm: setfont Tainted: G         C
>> > Tainted: [C]=CRAP
>> > pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> > pc : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
>> > lr : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
>> > Call trace:
>> >  drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
>> >  drm_atomic_helper_commit_tail_rpm+0x84/0xa0
>> >  commit_tail+0xa4/0x18c
>> >  drm_atomic_helper_commit+0x164/0x178
>> >  drm_atomic_commit+0xb4/0xec
>> >  drm_client_modeset_commit_atomic+0x210/0x270
>> >  drm_client_modeset_commit_locked+0x5c/0x188
>> >  drm_fb_helper_pan_display+0xb8/0x1d4
>> >  fb_pan_display+0x7c/0x120
>> >  bit_update_start+0x20/0x48
>> >  fbcon_switch+0x418/0x54c
>> >  el0t_64_sync+0x194/0x198
>> >
>> > This happens when the kernel disables the unused clocks.
>> > Sometimes this causes the boot to hang.
>> >
>> > By (re)adding the flag CLK_IGNORE_UNUSED to the VCLK2 clocks, these
>> > clocks will not be disabled.
>> >
>> > This partially reverts commit b70cb1a21a54 ("clk: meson: g12a:
>> > make VCLK2 and ENCL clock path configurable by CCF").
>> 
>> It looks like DRM needs those clock enabled regardless of connection
>> status on HDMI. Even with this change applied, you would get the same
>> problem again if the bootloader does not take of turning the clock on,
>> which is not a given.
>> 
>> CLK_IGNORE_UNUSED gives not guarantee a clock will be enabled or stay
>> enabled at any point.
>> 
>> A proper fix to this issue should be done in DRM, IMO.
>
> I know and I totally agree. Unfortunately, I don't have access to any vendor 
> documentation, nor do I have any real knowledge about the DRM/HDMI 
> subsystem to fix that.

You have identified which clocks are not properly claimed, by what they
are not claimed and even when. 50% of the job is done. Thanks for this.

>
> And I guess if it were as easy as adding a clock to the DT and calling 
> clk_prepare_enable on it in the probe function, Neil would have done that 
> already.
>
> So, all I can do, for now, is revert to the previous situation when it did  work
> for (probably) most boards.

Maybe so, but it does not make this change appropriate. The problem
is the DRM driver which does not enable what it needs to properly
operate. This should be fixed.

>
>> >
>> > Fixes: b70cb1a21a54 ("clk: meson: g12a: make VCLK2 and ENCL clock path
>> configurable by CCF").
>> > Signed-off-by: Martijn van Deventer <linux@martijnvandeventer.nl>
>> > ---
>> >  drivers/clk/meson/g12a.c | 12 ++++++------
>> >  1 file changed, 6 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>> > index cfffd434e998..1651898658f5 100644
>> > --- a/drivers/clk/meson/g12a.c
>> > +++ b/drivers/clk/meson/g12a.c
>> > @@ -3234,7 +3234,7 @@ static struct clk_regmap g12a_vclk2_div = {
>> >  			&g12a_vclk2_input.hw
>> >  		},
>> >  		.num_parents = 1,
>> > -		.flags = CLK_SET_RATE_GATE,
>> > +		.flags = CLK_SET_RATE_GATE | CLK_IGNORE_UNUSED,
>> >  	},
>> >  };
>> >
>> > @@ -3270,7 +3270,7 @@ static struct clk_regmap g12a_vclk2 = {
>> >  		.ops = &meson_vclk_gate_ops,
>> >  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_div.hw
>> },
>> >  		.num_parents = 1,
>> > -		.flags = CLK_SET_RATE_PARENT,
>> > +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> >  	},
>> >  };
>> >
>> > @@ -3354,7 +3354,7 @@ static struct clk_regmap g12a_vclk2_div1 = {
>> >  		.ops = &clk_regmap_gate_ops,
>> >  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>> >  		.num_parents = 1,
>> > -		.flags = CLK_SET_RATE_PARENT,
>> > +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> >  	},
>> >  };
>> >
>> > @@ -3368,7 +3368,7 @@ static struct clk_regmap g12a_vclk2_div2_en = {
>> >  		.ops = &clk_regmap_gate_ops,
>> >  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>> >  		.num_parents = 1,
>> > -		.flags = CLK_SET_RATE_PARENT,
>> > +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> >  	},
>> >  };
>> >
>> > @@ -3382,7 +3382,7 @@ static struct clk_regmap g12a_vclk2_div4_en = {
>> >  		.ops = &clk_regmap_gate_ops,
>> >  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>> >  		.num_parents = 1,
>> > -		.flags = CLK_SET_RATE_PARENT,
>> > +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> >  	},
>> >  };
>> >
>> > @@ -3396,7 +3396,7 @@ static struct clk_regmap g12a_vclk2_div6_en = {
>> >  		.ops = &clk_regmap_gate_ops,
>> >  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>> >  		.num_parents = 1,
>> > -		.flags = CLK_SET_RATE_PARENT,
>> > +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> >  	},
>> >  };
>> 

-- 
Jerome

