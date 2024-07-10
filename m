Return-Path: <linux-kernel+bounces-248145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E5092D8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C701F260B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089D4197A87;
	Wed, 10 Jul 2024 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eEv/v7pm"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9103197A72
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638799; cv=none; b=NsHda80cTiYF70AmK5OjqKEgRx4AUHX9wACc8QdQxAsPEqXpj7180iODONHiSK0potBKhW0KN7DRjwFk+M9N9F6tga2tYOlFCxMMaLPu0XsaoKD03pXHTYVeDjDvnx7fp2lVpKcXzeFWUoQt3PyrWJsizbshaZKnGtZtSReTDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638799; c=relaxed/simple;
	bh=w6Cd9JxYQr3oSlfhrzlHyozKmwFFDkIPTQcG3FZGAZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geYIn52AkZyBAOYsDhpUL9YfwB9RsaIE85egRIsT5L4XYocmOC6X7wsv+lSiYw5TYWsjNjTnGT2waVOmF3yP41Go+ELz8DJ0LI4O2IfQGLip/xxknyp8phdFn2F1p3y6wemno4/0bWUBH+xYXkjR+0DpxUxni/JgjJKKav1zQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eEv/v7pm; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70361c6fd50so34850a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720638794; x=1721243594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CJcQA4rqRaCFjiUl3yXOwI538Rxwz2YD9AUd38FoKk=;
        b=eEv/v7pmJzeQq56FeWcimabv7fDwBYtoeTYLq4cADmcw746EIZTGfRBqhBSRuVXXuE
         Ve8ZiQ6RlRF8rJPn2yhLIXExORqXtkUzR+K+CAgM9acF4Q79no0brubpC2q7uG0FvAJy
         5fVZnmCehrfDnL/h+pwYn8pOc/VWsoAOfZkIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638794; x=1721243594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CJcQA4rqRaCFjiUl3yXOwI538Rxwz2YD9AUd38FoKk=;
        b=m5HKMKVC+PN7M5A7+Au7OnVslv/4NqVeYREzqcqqKcuRBbmwuQDyqWEh4o2EL8alTx
         YbVLR5lHrNkXQ13CJcJpkltd0bx019ohqi5SkLqlHFjXhYn9yRrtQSM74KiqeKHUUZ1S
         ZZDaEjdPwN3YQQWDG6fUK61DtLAoClHK+BgLZ4y5vlfukPzbfbxLJD8nIOPEoOuiQMHX
         dBPwk2ist/y7Btp3KCz2GvbhY7loJXwM0FBAzi/9SxqM2ZF6ZHDYR7AAeLSUiqYQFsnc
         RAAM3q8JcXTteAo9Ap4uthNCiWwEnQJaJ1vB0u5TWH1DcE5s0tbG1LNMgiKb6w/DpzXS
         UNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv+J4jlWEgXBuWunwIbi+bgJnVastOeOMzW4lnGUk8UOqzQXgiGE27B94+gW+fxCS9HXV4Qgz5yVbycT8RzbqRWhiCtzJYlVKrH/0o
X-Gm-Message-State: AOJu0YxN9WddsnzOByorGnWq3nFLy281UQpjkNYWWLrQfD+hpUwvpEdH
	sQ1aa4Y5S5vxd8yi/oqqaPJ1YPew3ToEwdi0T+XTbNGky+O+3df5FFyKhabjtP+MFBBJNGUwo8m
	YLg==
X-Google-Smtp-Source: AGHT+IGZqVCBDhqhn4tPseSWStjq2zs0fRZEJLUn1PkjEYMiG5r5qeO4InJa1QYBIzP88tw0surLYw==
X-Received: by 2002:a05:6870:c6a1:b0:25e:97a:cd69 with SMTP id 586e51a60fabf-25eaec3f148mr4224032fac.55.1720638794320;
        Wed, 10 Jul 2024 12:13:14 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190158cfsm218936885a.52.2024.07.10.12.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:13:14 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447f8aa87bfso83921cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:13:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtF6Ei/rvSGFlZ+Hg/rawSwgfNWXD58TJndu+lZcwe4u/CShWdO0B260BSKfpzXPTN24gN6Rp1D81SG9XA3fc4tL7ASanapUrHPRon
X-Received: by 2002:ac8:730a:0:b0:447:d7fd:63f with SMTP id
 d75a77b69052e-44d11f851f2mr337601cf.19.1720638789687; Wed, 10 Jul 2024
 12:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
 <20240710084715.1119935-5-yangcong5@huaqin.corp-partner.google.com> <D2LQJROQYIY3.2Q88EXS8HUDLQ@kernel.org>
In-Reply-To: <D2LQJROQYIY3.2Q88EXS8HUDLQ@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 12:12:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WAosZPSKdpwR6pjOmiy4hih=jXaMg2guuVgmc+qj-Csw@mail.gmail.com>
Message-ID: <CAD=FV=WAosZPSKdpwR6pjOmiy4hih=jXaMg2guuVgmc+qj-Csw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] drm/panel: ili9806e: Break some CMDS into helper functions
To: Michael Walle <mwalle@kernel.org>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, quic_jesszhan@quicinc.com, 
	neil.armstrong@linaro.org, linus.walleij@linaro.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 2:02=E2=80=AFAM Michael Walle <mwalle@kernel.org> w=
rote:
>
> On Wed Jul 10, 2024 at 10:47 AM CEST, Cong Yang wrote:
> > Break select page cmds into helper function.
>
> Why though? I don't find that anything easier to read. In fact, I
> deliberately chose not to factor that out into a function. It's just
> a sequence of magic commands, taken straight from the datasheet. So,
> I'd like to keep it that way.

The consensus of previous discussion on the lists was that folks
agreed that we should, where possible, make it more obvious what these
magic sequences of commands were doing. IMO separating out the page
switch command helps. Certainly I'm always happy to hear other
opinions, though.


> -michael
>
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-ilitek-ili9806e.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c b/drivers/gp=
u/drm/panel/panel-ilitek-ili9806e.c
> > index e4a44cd26c4d..68fb9a1a4d80 100644
> > --- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
> > +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
> > @@ -35,6 +35,12 @@ struct ili9806e_panel {
> >       enum drm_panel_orientation orientation;
> >  };
> >
> > +#define ILI9806E_DCS_SWITCH_PAGE     0xff
> > +
> > +#define ili9806e_switch_page(ctx, page) \
> > +     mipi_dsi_dcs_write_seq_multi(ctx, ILI9806E_DCS_SWITCH_PAGE, \
> > +                                  0xff, 0x98, 0x06, 0x04, (page))
> > +
> >  static const char * const regulator_names[] =3D {
> >       "vdd",
> >       "vccio",
> > @@ -227,7 +233,7 @@ static void ili9806e_dsi_remove(struct mipi_dsi_dev=
ice *dsi)
> >  static void com35h3p70ulc_init(struct mipi_dsi_multi_context *ctx)
> >  {
> >       /* Switch to page 1 */
> > -     mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0xff, 0x98, 0x06, 0x04, 0=
x01);
> > +     ili9806e_switch_page(ctx, 0x01);

I think with your change you should remove the "Switch to page X"
comments since they're now obvious. Other than that, I'm happy with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

