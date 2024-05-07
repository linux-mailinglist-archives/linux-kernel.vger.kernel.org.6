Return-Path: <linux-kernel+bounces-172522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4608BF309
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8DB1F2116B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7A87FBB4;
	Tue,  7 May 2024 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E3SO/rAm"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A227F7ED
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124944; cv=none; b=tXchjuBDqcqmBZlOg5yYj5r4i5r3gCB/LBD5j5POD15Sl5O22e7Z1Fm47KcEqaVBCtr6tGxY9fLZ+jkHJ+616fAXoTVGPLu/8U1+SeP0Zdo5TqG+0UVvDFMHvD+XCPjz29cBKWY8uzrlUajGxFt0LJQOlzkDflrsJmeLWTldZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124944; c=relaxed/simple;
	bh=Li0X4iqoRtM4qps2P21m1AAYS3O31kVrWcT2DZZF9Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmvnJMm0bcxOfjG2YOHWTznXnpKPWB87c/gdrP+jhzbnwLtn478SkDuOUb73w5zE9pU1Rtn/ZLXIQ2WYs9tSoy7t6B1K+QlkcGCkM+pFvaNcOyC9f0+hewtg1Srrn8mFc72OBZJLyL2b2+JdiMxAQTC2HaikzDcOugPbw3VKJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E3SO/rAm; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7928c54e945so305415785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715124938; x=1715729738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqTzibYiVMH3+7a4PfBn8xbaOrudxt3kbfsLVjNZMAo=;
        b=E3SO/rAmGuugm692GhdLVoTxGv1jlAr0664wJ79zhKxH/OE7yoCTjNANVIbE39To3V
         w3Pdvl/4IqzWHmIaDcO3SnxDzMRdsu025isNs/+TiCV2dF8MvvXJvyP39mXUJSvmUgQh
         mRjbds3Yo8ZGYg3VQIklHS86RXvl3i5fZGIyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715124938; x=1715729738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqTzibYiVMH3+7a4PfBn8xbaOrudxt3kbfsLVjNZMAo=;
        b=iWJ9L1oBuL85rJ8s/mXisdU0og45S5Y34mUefi25XrGMY9Q64QgBKhJ8V+g5ACXeCs
         rPUVeQcnky/pNvR2klBOzgevhKl0nNonenHutU/igKBF8hNjLTOsTf/lOaFKsWcjtQth
         45rzT0KDlUh9B7G1rrohfHiJLUo8Y0CIePybPHUxp0U9eIaax/4LK4+VCM3LD1LCEdi2
         7jlaG1juE5iksV1NJpDsjXX/ozd359txbguhe6oRq5l1b4KoY16sr1ziAk7bplsOfi7D
         5pZaH4/5aqU3qttAvAINEdl9/64zbrIFk1P09+bdAlSvKq58dFbeVzsf/U6MTDDDT1aR
         ZY8w==
X-Forwarded-Encrypted: i=1; AJvYcCWFgOfzinbSaeMJ6x5fQ3bGXdSJLl25LPrXQmikuHoLUBPWDFG/QCn/4SchZz9bv8lnzx4d8Xa/zNK5ZTECtLCZ3mjZfbd1H/ITnJrA
X-Gm-Message-State: AOJu0YzEUc2bucsuDYVLKCURG299CNUEu5GMml4Msl3MbF0X1dJxdHcp
	dclVB/MkCDfGfKiB0JMJgsbjL9VLkIDYkbnSnug4MVcLooPbDKEI8Zwxg4GatydHP0nBdVmuVSw
	=
X-Google-Smtp-Source: AGHT+IGlysxwi9XB7y3IzYrdxPIayPw67ImWmftNzJ922RH60WIJY6PeEiCEWtUjwAoplL6x/vfKyA==
X-Received: by 2002:a05:620a:4104:b0:792:956c:b9a0 with SMTP id af79cd13be357-792b26ed346mr143108285a.33.1715124938473;
        Tue, 07 May 2024 16:35:38 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a145500b00792aad04aeasm900835qkl.102.2024.05.07.16.35.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 16:35:37 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43d55133609so66671cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 16:35:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgBGaWorl3Owz02kHlkQP3O206TBXwymulmTGVJJ93AQNjbISeK3I1+d4JMKyAX9G6dbYfYtW1MN2cqmSzUfAyW+RA7IEIoBLSgXd7
X-Received: by 2002:a05:622a:191b:b0:43a:c166:4d7e with SMTP id
 d75a77b69052e-43dc3180484mr1013991cf.28.1715124936576; Tue, 07 May 2024
 16:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240507135234.1356855-3-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 May 2024 16:35:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wj5WKcVbNGHQ_BbZa_fsVJkpYb2C8TE8bjhvJvx+N_hw@mail.gmail.com>
Message-ID: <CAD=FV=Wj5WKcVbNGHQ_BbZa_fsVJkpYb2C8TE8bjhvJvx+N_hw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 7, 2024 at 6:53=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> +static int hx83102_enable_extended_cmds(struct hx83102 *ctx, bool enable=
)
> +{
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +       if (enable)
> +               mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETEXTC, 0=
x83, 0x10, 0x21, 0x55, 0x00);
> +       else
> +               mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETEXTC, 0=
x00, 0x00, 0x00);
> +
> +       return 0;

You're throwing away the error codes returned by the
mipi_dsi_dcs_write_seq_multi(), which you shouldn't do. You have two
options:

Option #1: return dsi_ctx.accum_err here and then check the return
value in callers.

Option #2: instead of having this function take "struct hx83102 *ctx",
just have it take "struct mipi_dsi_multi_context *dsi_ctx". Then it
can return void and everything will be fine.

I'd prefer option #2 but either is OK w/ me.


> +static int starry_himax83102_j02_init(struct hx83102 *ctx)
> +{
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +       hx83102_enable_extended_cmds(ctx, true);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x2c, 0x=
b5, 0xb5, 0x31, 0xf1,
> +                                        0x31, 0xd7, 0x2f, 0x36, 0x36, 0x=
36, 0x36, 0x1a, 0x8b, 0x11,
> +                                        0x65, 0x00, 0x88, 0xfa, 0xff, 0x=
ff, 0x8f, 0xff, 0x08, 0x74,
> +                                        0x33);

The indentation is still off here. You have 5 tabs followed by a
space. To make things line up with the opening brace I think it should
be 4 tabs followed by 5 spaces.


> +static int hx83102_enable(struct drm_panel *panel)
> +{
> +       struct hx83102 *ctx =3D panel_to_hx83102(panel);
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct device *dev =3D &dsi->dev;
> +       int ret;
> +
> +       ret =3D ctx->desc->init(ctx);
> +       if (ret)
> +               return ret;

You're still changing behavior here. In the old boe-tv101wum-nl6
driver the init() function was invoked at the end of prepare(). Now
you've got it at the beginning of enable(). If this change is
important it should be in a separate commit and explained.


> +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> +       if (ret) {
> +               dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> +               return ret;
> +       }
> +
> +       msleep(120);
> +
> +       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> +       if (ret) {
> +               dev_err(dev, "Failed to turn on the display: %d\n", ret);
> +       }

The old boe-tv101wum-nl6 driver didn't call
mipi_dsi_dcs_exit_sleep_mode() nor mipi_dsi_dcs_set_display_on() in
its enable routine, did it? If this change is important please put it
in a separate change and justify it.


-Doug

