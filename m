Return-Path: <linux-kernel+bounces-212047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBCE905A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6461028479F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648A18306C;
	Wed, 12 Jun 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGE1Wg++"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743216E895
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215998; cv=none; b=e3vigWDE+EEwym8XRox0e4De9pT60WMdCfZJuu9KvoR2kSnHMSZUZJQQdxvqByBTd/48Ki5Y98Vw+IiQ8Pc6T0+EXzx2N7JXC5ZmyQrFpC1aBvaLNtjFIZ0vd1SVWS1g0+FqX3XXVWiPMGXn13+NE8fggNb71TRNG0D2DQN9w4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215998; c=relaxed/simple;
	bh=/ShJS2RsD6IOV3S0b7xD5uM3uAGmHGRcmp6lYjD4Rs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNcvIU2KGWq3FTkHKbEm/16YwrRLtUvaqUKRlljN4motJ1sIaltRrTM0+ipZK0OiT/uOkr0R6tumoc7jzGlFYQKx+/9KMvhcZtfYZzSsBTbIzhaWIYs6yDqx+D+0bvVWH6ynV5TDJn6CwB1ZRSz4F8yAMurFVMFpu5UuzLmOfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VGE1Wg++; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so166345276.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718215994; x=1718820794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk/PriGPmFJoIWbwcdF3L4d1fQIDRSRyN4fnZfXOrQ8=;
        b=VGE1Wg++CaBnkz/QaJ2RyrtC8HzjPR1oJCXPYODE5TEcZUcnquxIXBM7pbo+3oRgsl
         01qCoDySW/jVOriDxWAi3F+2v8Zn3D/31bj5fcra22x9cE7nnpCMLOuG/81yEMh29jSS
         whp1V1RlWXWMgRXqgRMbfJk8bustq+dIHBTnkHyV6tDoe0qXEnnNkvQrNVyFOO2TUnCK
         1HrGC73GYaxSgwGQ0fXeZ+u5YFvQJE1SySGlD8xQE3sF/MK8xEpDDQE0eJ3GN6nsyLUI
         JPlG0tKf56PiQKVnFhfi4IObGfkhMUXeyKIn9fwtV4wB3JbksUM7rTQuOfJJ5baoJLah
         OvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718215994; x=1718820794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vk/PriGPmFJoIWbwcdF3L4d1fQIDRSRyN4fnZfXOrQ8=;
        b=k4DB5LH+OfQXTjGEEh6O8HKId7z1KdQ9ic69bkqRc5fUxC5XnA2ujdpj35KMOQ7lZK
         V8BJEyCKlqyhc8ODj/WeUkDdmG4zGJYaPOVlWoJKxYB8ukYA/1QoNLh/1F2shnr9y9S9
         q/SVaVlntswba9WTfFQH9DgI992DgHl/JajpH4irYBmcubO9uLk6ovVtDnhBQ71W2OYD
         DZOAB292W5QwzJ1F/MOqnFHylT0YxsS9Nss8n7Kv0CXOxyShm+lLGkTUR4EuTITJXhzb
         NpTFyLzuD2sEisNLBEhEuq3msREKcwclfcHderU4xS/xBKzxvAag9SgTL93JTi7mVwDy
         7IoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX16LloxLfYreWuzGfNZzGHU8Fxwccf0GgAJPnF9TjUaVZ7mDw7/l/YhocU+srkQE1hJSMjZh94psEyPAIrYV93HoKPn8HMbm93KOQa
X-Gm-Message-State: AOJu0Yz4kNH/GWd49SF6nf0poy6jp/9Yew3Yxy9WdR35P3YIL+Dmbaay
	/UdtpGMG2NiqzGWmYqZlNghZjVHg0bgMzCqYlpSDyCOgfzVWJoLMwZnQaxHPhGITAlIHBfcxaHc
	uHGhhJ8PWCdoPGbfWmEU7QWBsLTRQ43wSqgaTgA==
X-Google-Smtp-Source: AGHT+IF6/xz9wzOXAOOEVpHYVAwPbs/GJXPgfY0I46o2OvJeO1Svt93Jr+6EnXSV8J5OKndG7JusmWzs8eeebNU7YDI=
X-Received: by 2002:a25:aac5:0:b0:dc2:5553:ca12 with SMTP id
 3f1490d57ef6-dfe66175fdbmr2383958276.14.1718215994315; Wed, 12 Jun 2024
 11:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606122559.116698-1-srinivas.kandagatla@linaro.org>
 <20240606122559.116698-3-srinivas.kandagatla@linaro.org> <qjyuvejxvjfanhqi3xpgobqjuugh52okxiutdprprx43emee7t@gzh7go6yc77z>
 <5bf5ee5e-d24f-476f-9500-9d1b7adcfc72@linaro.org> <mpm4pmt5ieofmpxmq5putvytyuiepbmnv5flsfqiwbtc54sb6k@jpoeaeojzzis>
 <171afc10-b69b-4c76-be34-7e93ec03355c@linaro.org>
In-Reply-To: <171afc10-b69b-4c76-be34-7e93ec03355c@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 12 Jun 2024 21:13:03 +0300
Message-ID: <CAA8EJpowb5eRdDH9HjiWoN5_n+VMd+sVkyx8fiuUTc5QYbxq0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: codec: lpass-rx-macro: add suppor for 2.5
 codec version
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, perex@perex.cz, lgirdwood@gmail.com, 
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org, neil.armstrong@linaro.org, 
	krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 20:09, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 12/06/2024 17:52, Dmitry Baryshkov wrote:
> > On Wed, Jun 12, 2024 at 03:37:56PM +0100, Srinivas Kandagatla wrote:
> >>
> >>
> >> On 07/06/2024 12:03, Dmitry Baryshkov wrote:
> >>> On Thu, Jun 06, 2024 at 01:25:59PM +0100, srinivas.kandagatla@linaro.org wrote:
> >>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>>>
> >>>> LPASS Codec v2.5 has significant changes in the rx register offsets.
> >>>> Due to this headset playback on SM8550, SM8650, x1e80100 and all SoCs
> >>>> after SM8450 have only Left working.
> >>>>
> >>>> This patch adjusts the registers to accomdate 2.5 changes. With this
> >>>> fixed now L and R are functional on Headset playback.
> >>>>
> >>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>>> ---
> >>>>    sound/soc/codecs/lpass-rx-macro.c | 565 ++++++++++++++++++++++--------
> >>>>    1 file changed, 410 insertions(+), 155 deletions(-)
> >>>>
> >>>> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> >>>> index f35187d69cac..bb8ede0e7076 100644
> >>>> --- a/sound/soc/codecs/lpass-rx-macro.c
> >>>> +++ b/sound/soc/codecs/lpass-rx-macro.c
> >>>>    static int rx_macro_probe(struct platform_device *pdev)
> >>>>    {
> >>>> +  struct reg_default *reg_defaults;
> >>>>            struct device *dev = &pdev->dev;
> >>>>            kernel_ulong_t flags;
> >>>>            struct rx_macro *rx;
> >>>>            void __iomem *base;
> >>>> -  int ret;
> >>>> +  int ret, def_count;
> >>>>            flags = (kernel_ulong_t)device_get_match_data(dev);
> >>>> @@ -3567,6 +3793,33 @@ static int rx_macro_probe(struct platform_device *pdev)
> >>>>                    goto err;
> >>>>            }
> >>>> +  rx->codec_version = lpass_macro_get_codec_version();
> >>>
> >>> What guarantees that VA macro has been probed already? If I'm not
> >>> mistaken, we might easily get a default '0' here instead of a correct
> >>> version.
> >>
> >> fsgen(Frame sync gen) clk is derived from VA macro, so if we are here that
> >> means the va macro is probed.
> >
> > Is this written in stone or is it just a current way how these codecs
> > are connected?
>
> LPASS Codec IP which encompasses 5 other codec macros blocks (wsa, wsa2,
> tx, rx, va) all the codec macros receive framesync from VA codec block,
> this is the hw design.
>
> Not sure what do you mean by written in stone, but this is LPASS Codec
> design, at-least to the codec versions that this driver supports.

Ack. Please add a comment on top of it.

>
> >
> >>>> +  switch (rx->codec_version) {
> >>>> +  case LPASS_CODEC_VERSION_2_5 ... LPASS_CODEC_VERSION_2_8:
> >>>> +          rx->rxn_reg_offset = 0xc0;
> >>>> +          def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_2_5_defaults);
> >>>> +          reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
> >>>> +          if (!reg_defaults)
> >>>> +                  return -ENOMEM;
> >>>> +          memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
> >>>> +          memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
> >>>> +                          rx_2_5_defaults, sizeof(rx_2_5_defaults));
> >>>> +          break;
> >>>> +  default:
> >>>> +          rx->rxn_reg_offset = 0x80;
> >>>> +          def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_pre_2_5_defaults);
> >>>> +          reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
> >>>> +          if (!reg_defaults)
> >>>> +                  return -ENOMEM;
> >>>> +          memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
> >>>> +          memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
> >>>> +                          rx_pre_2_5_defaults, sizeof(rx_pre_2_5_defaults));
> >>>> +          break;
> >>>> +  }
> >>>> +
> >>>> +  rx_regmap_config.reg_defaults = reg_defaults,
> >>>> +  rx_regmap_config.num_reg_defaults = def_count;
> >>>> +
> >>>>            rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
> >>>>            if (IS_ERR(rx->regmap)) {
> >>>>                    ret = PTR_ERR(rx->regmap);
> >>>> @@ -3629,6 +3882,7 @@ static int rx_macro_probe(struct platform_device *pdev)
> >>>>            if (ret)
> >>>>                    goto err_clkout;
> >>>> +  kfree(reg_defaults);
> >>>>            return 0;
> >>>>    err_clkout:
> >>>> @@ -3642,6 +3896,7 @@ static int rx_macro_probe(struct platform_device *pdev)
> >>>>    err_dcodec:
> >>>>            clk_disable_unprepare(rx->macro);
> >>>>    err:
> >>>> +  kfree(reg_defaults);
> >>>>            lpass_macro_pds_exit(rx->pds);
> >>>>            return ret;
> >>>> --
> >>>> 2.21.0
> >>>>
> >>>
> >



-- 
With best wishes
Dmitry

