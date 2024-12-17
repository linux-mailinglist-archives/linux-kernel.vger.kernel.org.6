Return-Path: <linux-kernel+bounces-449155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE849F4AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2471890E71
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838701F12E3;
	Tue, 17 Dec 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="RqFXMEWl"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171A1E5708
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437289; cv=none; b=M4wXW1IbQDIiOKKniMqF2R9RTKe5UQ9mAcF0dJw6b4b08nwoWXfKxAa7nygYsyaDXhVktSL46ztjvjlaLNOgI1RLg3ZT8v1iajjQg0nZOO9+vj48WDQjJu2v6v6XLlhrjckbjRBlA9NtnCL58jUnHIOm3WgRpb9FiY7UemSfqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437289; c=relaxed/simple;
	bh=lYYtBVNiTzP3RgYx8Xv+r4vF7QVcr/k6+Wcfbpd/Ul8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkemY7VsySXv7e4vJ1qjq1tTen2QZgbcViOzXzPxsoPizd6vO+VYYgcNcRueWRjdmAg3AdYImgnySJroYScMoGi9zEyL0vcwkH8ifJW/+3HPk9hOjEcXoOc2gTWp3ybDehTqSvRU2/obnZPSOa07yC/vpYTWB8cfW9z6Kdf/+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=RqFXMEWl; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8e8445219so45622796d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1734437286; x=1735042086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j+dl3ly0rdbKwmGKotpv1oO2gk374L+s+XxGWg7hHC4=;
        b=RqFXMEWlIF+UeNmO2or3eBTQV9nCl8Z8Y/i9UUVx2kHh4gnHhpuxxQ4A96zrN/S8kc
         111adx4KJMEREGw+rPgCB9apMa92pTdh6p0Sf2DHJdsDToRZBjEKtj/xKbik0Y+hxiPu
         MmjEapqxjAhtdAus2MFw8DG2zslBvZAjS972IXQNzZwPyxZhjYQJSHTwusj63jie1Uay
         21sD4XJ3SpKSeONW4t03GsB5LVHiwiHAUKLFohZNgKOl+S4Df3UUrnMs3lEKEsxDcX1p
         0F0Bt3Jg3eeDj34z21Kqn6UHBGnArrpO2i9NxQtnGYCCHER0yGku7mAsMF3sgb6WIiUO
         60aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734437286; x=1735042086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+dl3ly0rdbKwmGKotpv1oO2gk374L+s+XxGWg7hHC4=;
        b=YTRh7vOPGCAC0yTtBIzAqaZBXCUr8CZUtelwQ3M8/vsZQz7L5MwuwfiUuadGZsqDSe
         ulnlG8+dCuiIxc9ZjX521rXtOb1urHruxc5LfQXVGO75lT3skutvBCUcdUEcmtNjoyVm
         nSowenrWTdldH4vz3HCF9N77cpyZbwP0KnVPT4Z4G65BixtrUC4cBh0rnu80nrF6XdAD
         QmsWceAD/PywNRN3628ipUQfLUIlmcU4my4bgcnZW8CEBnJw5l9E27SpnHVq6gWBPDj5
         UH+gBJngefRP3BmnF2qnUTyZk+GIHbriUBsKObg2vDWx+90aw1oUECCmUmMXHVRR9rCZ
         dvJg==
X-Forwarded-Encrypted: i=1; AJvYcCXxabnVVQbCxJ/2l4WJOe9GE1u6fsAzvBOBpwdfhBjBHtRlSunBjS21nEy4fi3DpUmg4MnzdBnIDYhaPa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KKKt7v1+IgJiLte5+2bLo3dXxi/psqySBpwOol3IpoozgMXE
	Ln+0Baih4+FHsGeuGD8b4lzPqrMkXFwuYTcd+sAIcNbW5MjYLLDejPYeKAiSZpdpMhbWgQjzRSb
	aWEuJXLboWhw6NKI/q8sOatRWXP2mhcVdiFIf3w==
X-Gm-Gg: ASbGncvsy4apS0QHAShXli1KgpVf4rM6RKNG0I/ev2HN4k/z3nCTA9CnoZ+9vgOXrLa
	2u9kHysxd19k9lLDkzFRbKPg8n5Ev8DL04d1X
X-Google-Smtp-Source: AGHT+IENXkFl1sf/3x7p8kafThXQqXSZZrmYVwhsRzFtxsCkGCBTgLsddU6Li0qrlY45bm/mZ6nEZU9yLbhu5otz4j4=
X-Received: by 2002:a05:6214:d48:b0:6d8:a754:9647 with SMTP id
 6a1803df08f44-6dc8ca57509mr252459736d6.17.1734437285918; Tue, 17 Dec 2024
 04:08:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214081719.3330518-1-andyshrk@163.com> <20241214081719.3330518-9-andyshrk@163.com>
 <CAPj87rOjqZdyht2y8MK7gVyk_eqEzk1Sy0DcxFtQRuhrHQ_oxA@mail.gmail.com> <165af58a.697.193d2100239.Coremail.andyshrk@163.com>
In-Reply-To: <165af58a.697.193d2100239.Coremail.andyshrk@163.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 17 Dec 2024 12:07:54 +0000
Message-ID: <CAPj87rMfFXkbyh7UEJQw4JV1R18KLXC3GyF0CznrN1k3UdL0Lw@mail.gmail.com>
Subject: Re: Re: [PATCH v6 08/16] drm/rockchip: vop2: Support 32x8 superblock afbc
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, krzk+dt@kernel.org, 
	s.hauer@pengutronix.de, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	derek.foreman@collabora.com, detlev.casanova@collabora.com, 
	Andy Yan <andy.yan@rock-chips.com>, Michael Riesch <michael.riesch@wolfvision.net>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Tue, 17 Dec 2024 at 00:41, Andy Yan <andyshrk@163.com> wrote:
> At 2024-12-16 21:06:07, "Daniel Stone" <daniel@fooishbar.org> wrote:
> >On Sat, 14 Dec 2024 at 08:18, Andy Yan <andyshrk@163.com> wrote:
> >> This is the only afbc format supported by the upcoming
> >> VOP for rk3576.
> >>
> >> Add support for it.
> >
> >Out of interest, how was this tested? There is no 32x8 modifier in the
> >format list in format_modifiers_afbc[], so it seems like it shouldn't
> >be possible to get a 32x8 buffer on a plane at all.
>
> The 32x8 modifier  added in PATCH 16/16:
>
> +/* used from rk3576, afbc 32*8 half mode */
> +static const uint64_t format_modifiers_rk3576_afbc[] = {
> +       DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_32x8 |
> +                               AFBC_FORMAT_MOD_SPLIT),
> +

Hmmm, that's strange; I applied the whole series with b4 but wasn't
seeing that block defined. Maybe a bad conflict resolution. Sorry for
the confusion.

> I write an ovltest[0] tool which can take linear/AFBC rgb/yuv data from a file, then
> commit to drm driver, I use this tool for most basic format test.
>
> But when tested on weston, I found that weston does not use the AFBC format for display,
> don't know why.

You'll need a Mesa tree with e0f48568c7f2 included; if you have this
then it should just work out of the box.

Cheers,
Daniel

