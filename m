Return-Path: <linux-kernel+bounces-516246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580DA36EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF3A1895340
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239D1C84AD;
	Sat, 15 Feb 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="a3M0S/pu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40F186E54
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739627758; cv=none; b=Qq42T+VB0mLg3DS2qBRkqnVklN+hkHjHTljmwI+5ynCNt/5Lub1y7uN/mGwraBO5hd6EtqS99BeHa1cVCLxonExkkKGNeEt6r3bI7GuSN+Ppg0tReaWuQEHoMQch8S82hedfsA6+DafEOuYYkrx0Tj6qoqXvibDZR6h7PmZhi3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739627758; c=relaxed/simple;
	bh=ynQRGmv0k2LHJILsKLHBzXzaTuyPYqreNIxN9MimNAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqBr+JRKmFbNp78F6+EVkMHn1wvOzavx9TnQHLWIxsFnBmDEN/iql0iWprbUrP798/ekDtJ48kXxgZ5u/RBPQ9aaY7HL2efncThqMyE1fNsYTEj9LuK4fkF7LzWhMJvcxYz4iaQChNcashAnWakb4viWxqkxeh+6YUINJ7sgm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=a3M0S/pu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aba868c6e88so203762166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739627754; x=1740232554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ip35XfUe0PCV8P/WbBPAmeZvVqMfUDUUb94mizXHroE=;
        b=a3M0S/puKA9s5+jkPRpNMfF5c4AExwu9rvdiH4JolodtkWOWuXQrX9X7nuHYHZM4m2
         aUy+q8L0YQR8VVB2tzxna85AxYgKpnQBRe0l6zo2ILvlvSfahx+dUm26K7H2WS/dS0EP
         t7I+Gkc0V6twOFMZBnYvfH6cuc6gGywhECf0zpftwxg5K1sX57tfimXvArkDZkt4BvY2
         OoCTu6hck6N7EyTYhT9pgJvq9/MrM7oHaeVpS8UgmVmDwhwJbT+k3DcTzY4cav0KIx/b
         e5wRJd6WigWbFqGL3sAuMqVFDn5BYdG+QIE2eTd2jubHUy0hHoa8XXEEr5TfiqVHo3EH
         x7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739627754; x=1740232554;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip35XfUe0PCV8P/WbBPAmeZvVqMfUDUUb94mizXHroE=;
        b=nMAmFz6v1gIz/z8k0EqyhmGcTdlEH7QJzLGXgVcodiUC2y5UKBqN6/dthLqbtY2ADL
         jNTOAhVylNhGorXYaXhXTQN9zY12vhFCy78oG8G+j/aQZfMwFAzrFXsWFnrmVH6lXPzD
         EgzzwfSk+hPqXs2VzeUcI1nHufJFYpQFip1/NU2IwQTJdgwbghKJc0V337Mvo3YwJRmw
         2R0pJXdERHaZv7BEv2jcUzVTELbrKcZbgG2xyaZrF9vZ8G4CwwpXc0ulid3E5HJkS6nJ
         aBMMF5k3a0kK+AfwJ1rY4z5FxtrIUpZenvGdae/Af0yzEyTi9Pne1rWWT70LpXYkUnzL
         v2Gg==
X-Gm-Message-State: AOJu0YxuDliTZUW/uOQnVmo5LPmPzWVNGTODbxul2O/oVl/orX3LF2K+
	Vt0Zl5bxUH2tMLwN8mtazpwqQwBIl6AKVY2M2MQ2h6ilGPVQCPa2MNiYQwEDZUs=
X-Gm-Gg: ASbGncvcCNwwYepJ1sRokH4JAXO89z+JyFvBEFG2ic7Nbf+KDTa8fZSeYeAKu/2yqAo
	2WdG3FchXjmHG/aLfbUk+nW9SkfHkY/DY44HeDeFy6mU1qEqB9Ls5tdgV37/2Uh69w9cZEBdzOf
	gu3lAK8dsMLrcP6uv6fpMkI9ZEXqPTL8iUs9XceGrKUCR5Bt6MmYoSHpBDHEkGfnQZRfZotLABC
	Hn8H0il5dM6byYbFs2kdhoZkmK5bv1xqUgQ0QOoPRp4Xm8ot8Y22YQEvIDhJ2ZU8GVohRYP0M0V
	dLpr6HCc0Sq4f97esmKDqo9G
X-Google-Smtp-Source: AGHT+IHKDmH405xdj0jPJHIKuZ0K0kF6FFhjrC1+AWHo4C3rQtUztDXAnjVwRXBOlB15UUxyrtHq7g==
X-Received: by 2002:a17:907:7209:b0:ab7:b589:4f9e with SMTP id a640c23a62f3a-abb70de294cmr262384866b.39.1739627754103;
        Sat, 15 Feb 2025 05:55:54 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bce23sm532277766b.161.2025.02.15.05.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 05:55:53 -0800 (PST)
Message-ID: <ed953445-9c55-4658-af16-04eaa71d746e@tuxon.dev>
Date: Sat, 15 Feb 2025 15:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] clk: Overwrite clk_hw::init with NULL during
 clk_register()
To: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Doug Anderson <dianders@chromium.org>
References: <20190731193517.237136-1-sboyd@kernel.org>
 <20190731193517.237136-10-sboyd@kernel.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20190731193517.237136-10-sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Stephen,

On 31.07.2019 22:35, Stephen Boyd wrote:
> We don't want clk provider drivers to use the init structure after clk
> registration time, but we leave a dangling reference to it by means of
> clk_hw::init. Let's overwrite the member with NULL during clk_register()
> so that this can't be used anymore after registration time.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 
> Please ack so I can take this through clk tree
> 
>  drivers/clk/clk.c            | 24 ++++++++++++++++--------
>  include/linux/clk-provider.h |  3 ++-
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..efac620264a2 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3484,9 +3484,9 @@ static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
>  	return 0;
>  }
>  
> -static int clk_core_populate_parent_map(struct clk_core *core)
> +static int clk_core_populate_parent_map(struct clk_core *core,
> +					const struct clk_init_data *init)
>  {
> -	const struct clk_init_data *init = core->hw->init;
>  	u8 num_parents = init->num_parents;
>  	const char * const *parent_names = init->parent_names;
>  	const struct clk_hw **parent_hws = init->parent_hws;
> @@ -3566,6 +3566,14 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>  {
>  	int ret;
>  	struct clk_core *core;
> +	const struct clk_init_data *init = hw->init;
> +
> +	/*
> +	 * The init data is not supposed to be used outside of registration path.
> +	 * Set it to NULL so that provider drivers can't use it either and so that
> +	 * we catch use of hw->init early on in the core.
> +	 */
> +	hw->init = NULL;

I found that this line impact the drivers/clk/clk-versaclock3.c driver when
doing unbind/bind. The driver provides statically initialized hw.init
object for registration, the hw.init pointers are set to NULL after clock
registrations then the next registration (when re-binding) fails.

In the driver probe the clock are registered like:

	for (i = 0; i < ARRAY_SIZE(clk_pfd_mux); i++) {
		clk_pfd_mux[i].regmap = regmap;
		ret = devm_clk_hw_register(dev, &clk_pfd_mux[i].hw);
		if (ret)
			return dev_err_probe(dev, ret, "%s failed\n",
					     clk_pfd_mux[i].hw.init->name);
	}

and entries in clk_pfd_mux[] are like:

static struct vc3_hw_data clk_pfd_mux[] = {
	[VC3_PFD2_MUX] = {
		.data = &(struct vc3_clk_data) {
			.offs = VC3_PLL_OP_CTRL,
			.bitmsk = BIT(VC3_PLL_OP_CTRL_PLL2_REFIN_SEL)
		},
		.hw.init = &(struct clk_init_data) {
			.name = "pfd2_mux",
			.ops = &vc3_pfd_mux_ops,
			.parent_data = pfd_mux_parent_data,
			.num_parents = 2,
			.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT
		}
	},

// ...

};

I tried with the following diff, too:

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index 9fe27dace111..c1776c313e9b 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -1022,10 +1022,11 @@ static int vc3_probe(struct i2c_client *client)
        /* Register pfd muxes */
        for (i = 0; i < ARRAY_SIZE(clk_pfd_mux); i++) {
                clk_pfd_mux[i].regmap = regmap;
+               pr_err("%s(): hw init=%08x\n", __func__,
clk_pfd_mux[i].hw.init);
                ret = devm_clk_hw_register(dev, &clk_pfd_mux[i].hw);
                if (ret)
                        return dev_err_probe(dev, ret, "%s failed\n",
-                                            clk_pfd_mux[i].hw.init->name);
+                                            "test");
//clk_pfd_mux[i].hw.init->name);
        }

        /* Register pfd's */
@@ -1034,7 +1035,7 @@ static int vc3_probe(struct i2c_client *client)
                ret = devm_clk_hw_register(dev, &clk_pfd[i].hw);
                if (ret)
                        return dev_err_probe(dev, ret, "%s failed\n",
-                                            clk_pfd[i].hw.init->name);
+                                            "test");
//clk_pfd[i].hw.init->name);
        }

        data = i2c_get_match_data(client);
@@ -1050,7 +1051,7 @@ static int vc3_probe(struct i2c_client *client)
                ret = devm_clk_hw_register(dev, &clk_pll[i].hw);
                if (ret)
                        return dev_err_probe(dev, ret, "%s failed\n",
-                                            clk_pll[i].hw.init->name);
+                                            "test");
//clk_pll[i].hw.init->name);
        }

        /* Register divider muxes */
@@ -1059,7 +1060,7 @@ static int vc3_probe(struct i2c_client *client)
                ret = devm_clk_hw_register(dev, &clk_div_mux[i].hw);
                if (ret)
                        return dev_err_probe(dev, ret, "%s failed\n",
-                                            clk_div_mux[i].hw.init->name);
+
"test");//clk_div_mux[i].hw.init->name);
        }

        /* Register dividers */
@@ -1068,7 +1069,7 @@ static int vc3_probe(struct i2c_client *client)
                ret = devm_clk_hw_register(dev, &clk_div[i].hw);
                if (ret)
                        return dev_err_probe(dev, ret, "%s failed\n",
-                                            clk_div[i].hw.init->name);
+                                            "test");
//clk_div[i].hw.init->name);
        }

        /* Register clk muxes */
@@ -1082,7 +1083,7 @@ static int vc3_probe(struct i2c_client *client)
                ret = devm_clk_hw_register(dev, &clk_mux[i].hw);
                if (ret)
                        return dev_err_probe(dev, ret, "%s failed\n",
-                                            clk_mux[i].hw.init->name);
+
"test");//clk_mux[i].hw.init->name);
        }

        /* Register clk outputs */

Can you please let me know if this is a wrong pattern? I noticed there are
other drivers following similar approach, e.g.:
- drivers/clk/clk-axm5516.c
- drivers/clk/qcom/camcc-sm6350.c
- drivers/clk/meson/c3-pll.c

Full console log with my trials can be found here:
https://p.fr33tux.org/9d976f

Thank you,
Claudiu

