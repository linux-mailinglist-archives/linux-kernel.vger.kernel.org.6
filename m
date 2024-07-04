Return-Path: <linux-kernel+bounces-240538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6996E926E88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121961F26E22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9F39AE7;
	Thu,  4 Jul 2024 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ik9S7gl4"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7099381C7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067813; cv=none; b=kghJj6jkqx14qPwOYHECbmCKU3QXOpmuwQtOP4kNdJGEateqjE1K2ChTTvpmvE4MpT0TunZd4x7nutEzgxZGNmRYJVI5tcATAle9Ji3TZx7Ngrc5orUxd2MDSlhZ2kw8enhuwyeZyM0pVDCbBNeHe/ATESpffnRPTriU7avlfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067813; c=relaxed/simple;
	bh=9slmyaBlklEvimC+IoLVf5ZWppbjvVs6SBoZDCByeC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7HfvxWKbLicBGKcVtpNz2nXHOaEyXCFC9RA7au50DK6MhsaFLFuoSnHIr6Om7nsJi9CkFnnFgAk3QAC0yn1uE1+OiyRL8wYp5l/Mq2AO7pXQ3GKtDJfyWMJYPYAa1JcfnUWnvQjoAy38YbGSeD3YaZuckxsuReoLGx3kHQaeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ik9S7gl4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c8e7553c9eso189877a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 21:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720067811; x=1720672611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAbXjXG0fSvMf5pJhFu2VS2Kd5/IOX1LZWjusen/NTs=;
        b=Ik9S7gl4Ioi7+3thnWC7qXyQPBEr5A1fI3Ta+TYgemDdCImd/lja8NPeg4FhBYYi49
         RQfAIKU/CKmAUJGVsozgF7BeGAb97XqyCD4jn++KdJYa1BrJ+Ff0EA/guI/kFdUKScy4
         eZQpocrEB//JayKnhrcU7fPfAAMNFhR+97gED8iFHt3DyRs9TIMm5Gl3I54uHBzmvaMd
         mUFZ8/2/5sTb1/I1dbGT1kud/MluW9pzdzuhIOMDt7Ag7wupVngN/c14e3SGlc9oknQK
         vpGJ43ziVdlJ6puNCTtA57+zUetMWSA7/eUgYkscqI13dYls3hfOhst9pVC1q1TdQpXl
         3Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720067811; x=1720672611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAbXjXG0fSvMf5pJhFu2VS2Kd5/IOX1LZWjusen/NTs=;
        b=LzyG5sRheAD75g4uW8oPSVy3cODRgQYX0QLoYSHxk+IP1/buxpay15Z7wpLRoZLfAj
         yzZ7W2/bG3ED0kIeogZX+qyvA4qAD3qo4dFSkB3/Sf1ro9fxD2h3i8/0htqZfEqUgBpM
         Tlq88dMmqSss3oBT1/eqMMwGrodhZSu0/pkCuOWKRpg3nu3QKCJGs7jt7LPA0dN2Km7O
         NttC7bJwSZx1EI5wsFHKxuTYawPIM/DS+aibLAtwT8+gWrw76QruuAkpysrQAUjIM5dq
         3bjbI/E5hX3b/8l6iBV7aoR4N60JKK5dWK8edfME89kF/rVe8VCHJ65HN4v5MUULWoJz
         RRhA==
X-Forwarded-Encrypted: i=1; AJvYcCWZQFq6YH/gX2vF/KGPpk8ZYarQaEwvbjdG90CqEPNFHGFe3pf+P+MUACWkv93xV0sJRixBE+X5/H3WajOmwWHVkCBUMm6zOJXT1jE1
X-Gm-Message-State: AOJu0YxI9L3F48LVrZRAcA7+2PJq0Lqus4UAP1SM5Eugqz6kh2YsT2ox
	HMC4A7mhqonpwYzJ75TGgvNC6oF/hFQsn4KOUTznSk/i4C0rteLOULFrB95ZlxBsnMYdsm6Jeo6
	NS+7l7Go1Uh3bm63YlowDRqETdSTCwpKgJZSP5w==
X-Google-Smtp-Source: AGHT+IFtkJ+EuL8PoDKfInod5fFnpjY15Fd6bShoE64mF1c8evcN7TimB/7UEAKFN0CDsuw+N1TkXgUJNgqJPD6HU2A=
X-Received: by 2002:a17:90a:1fc8:b0:2c2:f6a2:a5f7 with SMTP id
 98e67ed59e1d1-2c99c53b414mr431715a91.13.1720067811171; Wed, 03 Jul 2024
 21:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com>
 <20240702130138.2543711-3-yangcong5@huaqin.corp-partner.google.com> <CACRpkdY+nuSWz7rnVVUpF_mZOfDUb_6fgoJpnG2Pt-+AGLqt0g@mail.gmail.com>
In-Reply-To: <CACRpkdY+nuSWz7rnVVUpF_mZOfDUb_6fgoJpnG2Pt-+AGLqt0g@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Thu, 4 Jul 2024 12:36:40 +0800
Message-ID: <CAHwB_N+Gr=Kso6=UabHseB0UTb+4wWpHR5MAZ82bHe5At_y-cw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: jd9365da: Support for Melfas
 lmfbx101117480 MIPI-DSI panel
To: Linus Walleij <linus.walleij@linaro.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	dianders@chromium.org, swboyd@chromium.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Linus Walleij <linus.walleij@linaro.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=B8=89 21:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 2, 2024 at 3:02=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
>
> > The Melfas lmfbx101117480 is a 10.1" WXGA TFT-LCD panel, use jd9365da
> > controller, which fits in nicely with the existing panel-jadard-jd9365d=
a-h3
> > driver. Hence, we add a new compatible with panel specific config.
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
>
> This is certainly OK
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> > +static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
> > +{
> > +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard->ds=
i };
> > +
> > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
> > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
> > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
> > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
> > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
> > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);
>
> Until this point *all* displays have the same init sequence, what about
> a follow-up patch that start to break things that are always the
> same into helper functions?
>
> These sequences all have a lot of the same magic bytes, so if
> you guys have a datasheet for this display controller then start
> adding gradually some #defines for the e0, e1, e2 etc commands
> please.

Okay, will add a patch in V2 series to fix it. Thanks.

>
> Yours,
> Linus Walleij

