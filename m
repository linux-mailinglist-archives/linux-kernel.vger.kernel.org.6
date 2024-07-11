Return-Path: <linux-kernel+bounces-248467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90B92DDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8A8B245AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0B84C8B;
	Thu, 11 Jul 2024 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwBH1hun"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172146FC3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660149; cv=none; b=ehLssgdWWtLMJxhdrDsWedUrtwCQOFlWA8lkb5kJF3iuwiXvtX6Q4FBjIKGWJWKqJCJ2cucFjKvtNdW8FHz8L93CNzhuyO+2q3tiUBVQ52L4o32rqCQp3rtBzQv8UrMSkHndlL79Ud4IIXr9UozIvFBn74LhsPstwMYCW0l9aiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660149; c=relaxed/simple;
	bh=Cz6OZqlhx70bk8PvuENaCR3AhYPx/ageX/Es7/Sj0aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/xtNE+1nnMU71tOFwBIn753nM+RalDFplZ+ceu1rZdH2kip4l2V9Mluie8guwDUZ9zn/PXck/ppccgiPVPjNDUxKQ/e8gQXyKZLJ9gsuo87CMxAJg4ilpvD4vR7HFiTGV+fpYHANz300vHx5tLq/HYcQAC6hJHpMk0fVeUgR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwBH1hun; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb3e9e32ffso2209615ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720660147; x=1721264947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqCvHAYPbXi+bXWOTcgpjsS2oEkHfV0BUOm/T2chX4o=;
        b=AwBH1huna4w0W4cEE/Snl4c1E88HHYh1zYbZR50Ys0SvgGlKdhvNK0Wz/MbXq5Tzq4
         oKJGdOI9+QXpLoQRMGJhAOoneocnfP3d9vaYI6PoQAtlFoQw004A6lXNYOmfpOh57Nwt
         SLRktkGdYfRcVOj5PvxC+nZMpmZIYGimAP6MMwvTtm8rRYF6hfkJnfNrAk2YjNlhAyiz
         Wbs7LgwJEkH/DP0GFIuxhKf/zEGoad4WTC2aEDKr/jgTHd80J5atnRQYcVdSDxzqlMqQ
         YnHBf/SN4Nt9nJsp5dec1i+AXqRJRTCBWslvS5up8YxT8rOP1+ziZ9Z3qOe/27ovbzuc
         Sh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720660147; x=1721264947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqCvHAYPbXi+bXWOTcgpjsS2oEkHfV0BUOm/T2chX4o=;
        b=o6rl39qZKvrZs3kGcg8EIyXt7/5UXDnSr1LmOZyNQz+rB4n5skFjTu5GaV1u4EGlWj
         knwhvl2JE6qYr8td9WbCMHmedE8LGeimFOTDQSFip9Isb/wQ5MWLsxmmoNCta/J9K5MA
         oequOqncv2uU6NQ7IHACXU5BU9WKjejxspq85cRepjY8u7A/fzk1OenGQw/VmvidpKoy
         tIcBfwvhP01bVseHSOnZcjDaHWbeHWPCL7BZd2k0MevRZ2J5XvUyagRNfu383GsY0ePo
         DAw9tcHT8XDsD18xRr6F9wHZci0AAxHrjH0ROILiGRkLiGVxqpLKrjtHWNntZBubcS64
         MOBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1+0qiCioi2FpK0kxE12DWOo6KRvipTgO3CKnH02qcDK/xpEnagkXo7ohtrxTSVZkqSE8+QLfY66qWSn/Lz0dPp5cnY3SrUX2U08rY
X-Gm-Message-State: AOJu0YxjzIfkai4Zi4w3n2UHBalFFGihmRHiw3WWMYNee8ExT7eWkJJy
	VeFVKcElkH8IduKvVKO1djU4ct5kKRumkeDOpjPXW+8tTPEsXgph/QDSvkGixaQ1+iQcCHxy3DX
	6fhpEmAHO6ujI8I/guLiut69W8hZ9Z/z25cNbzw==
X-Google-Smtp-Source: AGHT+IFyrtGUaUGdRNgeSP7+9iE929t4jQSmmz5maOkAya9CBSMFs5XxwCa8KTcvEuvQSO8TuEpKJpL1DfHMvT+wAeE=
X-Received: by 2002:a17:90a:69a5:b0:2c9:6f06:8009 with SMTP id
 98e67ed59e1d1-2ca35bf40acmr5527910a91.1.1720660147368; Wed, 10 Jul 2024
 18:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
 <20240710084715.1119935-5-yangcong5@huaqin.corp-partner.google.com>
 <D2LQJROQYIY3.2Q88EXS8HUDLQ@kernel.org> <CAD=FV=WAosZPSKdpwR6pjOmiy4hih=jXaMg2guuVgmc+qj-Csw@mail.gmail.com>
 <D2M42ODWQPAU.I0BMEOLKUP29@kernel.org>
In-Reply-To: <D2M42ODWQPAU.I0BMEOLKUP29@kernel.org>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Thu, 11 Jul 2024 09:08:56 +0800
Message-ID: <CAHwB_NJ+YEMoL18Sr9HFmTVH_ErDztyF7vxxPFAE0Y2ta3dO0A@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] drm/panel: ili9806e: Break some CMDS into helper functions
To: Michael Walle <mwalle@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, quic_jesszhan@quicinc.com, 
	neil.armstrong@linaro.org, linus.walleij@linaro.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Michael Walle <mwalle@kernel.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=8811=E6=97=
=A5=E5=91=A8=E5=9B=9B 03:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed Jul 10, 2024 at 9:12 PM CEST, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Jul 10, 2024 at 2:02=E2=80=AFAM Michael Walle <mwalle@kernel.or=
g> wrote:
> > >
> > > On Wed Jul 10, 2024 at 10:47 AM CEST, Cong Yang wrote:
> > > > Break select page cmds into helper function.
> > >
> > > Why though? I don't find that anything easier to read. In fact, I
> > > deliberately chose not to factor that out into a function. It's just
> > > a sequence of magic commands, taken straight from the datasheet. So,
> > > I'd like to keep it that way.
> >
> > The consensus of previous discussion on the lists was that folks
> > agreed that we should, where possible, make it more obvious what these
> > magic sequences of commands were doing. IMO separating out the page
> > switch command helps. Certainly I'm always happy to hear other
> > opinions, though.
>
> Fair enough, but in that case, one should take the datasheet (which
> you can find online) and replace all the magic numbers with the
> correct command names from it. E.g. 0xff is the ENEXTC register. To
> be clear, I'm not just talking about the "switch page command".
>
> As patch stands, I don't see much value, TBH. On the contrary, you
> make it harder to compare it with the Ortustech panel datasheet.
>
> just my 2c,
> -michael

If all drivers replace all the magic numbers with the correct command names=
,
it will be a huge amount of work (assuming that the datasheet can be found)=
.
 I am afraid I don't have enough time to complete it.  Thanks.

>
> > > -michael
> > >
> > > > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-ilitek-ili9806e.c | 14 ++++++++++----
> > > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c b/driver=
s/gpu/drm/panel/panel-ilitek-ili9806e.c
> > > > index e4a44cd26c4d..68fb9a1a4d80 100644
> > > > --- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
> > > > +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
> > > > @@ -35,6 +35,12 @@ struct ili9806e_panel {
> > > >       enum drm_panel_orientation orientation;
> > > >  };
> > > >
> > > > +#define ILI9806E_DCS_SWITCH_PAGE     0xff
> > > > +
> > > > +#define ili9806e_switch_page(ctx, page) \
> > > > +     mipi_dsi_dcs_write_seq_multi(ctx, ILI9806E_DCS_SWITCH_PAGE, \
> > > > +                                  0xff, 0x98, 0x06, 0x04, (page))
> > > > +
> > > >  static const char * const regulator_names[] =3D {
> > > >       "vdd",
> > > >       "vccio",
> > > > @@ -227,7 +233,7 @@ static void ili9806e_dsi_remove(struct mipi_dsi=
_device *dsi)
> > > >  static void com35h3p70ulc_init(struct mipi_dsi_multi_context *ctx)
> > > >  {
> > > >       /* Switch to page 1 */
> > > > -     mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0xff, 0x98, 0x06, 0x0=
4, 0x01);
> > > > +     ili9806e_switch_page(ctx, 0x01);
> >
> > I think with your change you should remove the "Switch to page X"
> > comments since they're now obvious. Other than that, I'm happy with:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>

