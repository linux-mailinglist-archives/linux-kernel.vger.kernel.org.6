Return-Path: <linux-kernel+bounces-378706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6876F9AD437
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D4EB24403
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF3D1D14E9;
	Wed, 23 Oct 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pS8ItPWY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B291BFE05
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709110; cv=none; b=nS0P0/PNSyUY0EufNJgPURHKdr+NPMW7pj1/DWp/b+KUjRjb4pMDMRTKB1C/zgW5tEaTb/pKoB+aPZHzfvS0Gin7dwTq9OjlilDt94k/Ggpnmsfd4TOpN3QQcfm/GnMi09tTbzI4daapXPaoiUMBjJcIWIx4CpLvCC+iq/Mg9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709110; c=relaxed/simple;
	bh=b9NwgqiPijcxe+rH2hf1VDuereYmfE3ICe6f2s34nvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOfrPII8Tkuh/ycZaIBcbsC4TIdrUWXE8q+0oGboPL1zxBchJM+FmGVZAhF3AM7zNIBE6JRY8ameVC0CUqIkuswqreleZ6JGHXwTTVVILBDIb1TvRSWxmgxXmmMlxTHgVxB/uYb9oJNUD5PQqDczAjZ1fFN5GsU2cUlApyTyo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pS8ItPWY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1568b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729709108; x=1730313908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeEzIbcTN9Qo6z/WsUu5E7xET1l3eAfufIwhM53Y5us=;
        b=pS8ItPWYn7rBPNf0Pn1yTxU+SGBds/Njkz/TzwmBkZrTuqU1WsSSTPGQE5LTRb/OYO
         N3CcNuWzvaN8uduvn39yDav8rDnb8XdN3sMwjyYWNVGq//VjD0WNncR+6p1p0TYJmfMZ
         UrwehHfbQGwbJrkp1TZwo+blAu3NWhq8VyxvkA2TW8byi0xmzoZ3AY7VbCoiPhE2dqOE
         93yoVwsEWsh/HFyxd1LDb64s0/5LHqbwgBYy4edUrNAfQ9ZcBfiKF6tJxWCjqLN7j5Mo
         5Ba8Mt6UcS5g3JrSwys2EPu9qdbT9jmlpREkITLTYJHZ49VtPw8dR8KzW6zizn54Innw
         h4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709108; x=1730313908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeEzIbcTN9Qo6z/WsUu5E7xET1l3eAfufIwhM53Y5us=;
        b=uUdDpy9OZR42Kqrdqd6qUQTzaugGXieR7pugo02hr/HnPJkS+J3SSRy1xh0gWfO54X
         feszengb61NO5VtB+BuaisWXiwo10ing0Sbxn51yWGp5sI4mF8/csEJwwmFR3IAIweg+
         eAuJhYA6wZ6FVgJKtFaZIcA318aoiNjkYsaj9bDMjY3wkn8XrxT5YWTZxv6zGUTg5kSy
         uzKuuR9D0ADJPw01VZoDt2WAAECCSb9ZmAF6CXr2SC9/rlgjd4wAZISl/TE4bXuY6deF
         +9DH/oI4MisZcY2dkYNtQLzwIcofPkVgE61deI62zHIMpVfX373NCGN/JiGt/LifbE94
         hqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsRY0NfwzELBcPUY3W8+94RfNAaP2n9FwmAEffYg/gyBavesg0xGGDY5JEOYCgfYQmBs13peUejhpYVQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiI6zTf+DVn2o8XRk5epoittnrtML2zwxTjZKHjlNoKh8RKxSN
	PdGqMZVDcsRJSGLJqnaO2MMP++Xon48UGB1U3KCtyWk0NAnOaIrnN9mFR0IL+VFksYyR1VSUUcd
	thhjZBI3XIy1+/WhcOHTQzyVyzLEFGkDJGKhv
X-Google-Smtp-Source: AGHT+IERGNFvesrjfkA68h18NkTDtTEV1fRw3F/7aiylrOx6fyBXV9N+orq1T0sVvVFSF5V9RYn6zKm5KrhQxkmAhno=
X-Received: by 2002:aa7:88cb:0:b0:71d:f2e3:a878 with SMTP id
 d2e1a72fcca58-72030b70485mr4902092b3a.5.1729709108125; Wed, 23 Oct 2024
 11:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910130019.35081-1-jonathanh@nvidia.com> <2024091152-impound-salt-c748@gregkh>
 <d89c89f8-0036-44a4-8ffa-ea89ed576a9f@nvidia.com> <2024091627-online-favored-7a9f@gregkh>
 <b1b67db0-3b9c-4d96-a119-fe3fcf51b6e3@nvidia.com> <CAGETcx8E9FddpwMO4+oqeEc0RVMLbUOs2m+=B900xzrLvEkSXw@mail.gmail.com>
 <2c42677c-5e8e-4805-b6a5-0a5baa3e55b5@nvidia.com> <d9aadede-dfac-410a-b65b-e295c9a64951@notapiano>
 <CAGETcx-_z4hxyNSwT-D1MKNzAjOGSX+o7x5G8J0KkiUyy+RkDQ@mail.gmail.com>
 <8b4723ba-fffe-4616-8055-02a9cf6f2894@nvidia.com> <f979aff2-34f4-4f6d-bb9a-03a02afc4635@notapiano>
 <5312c3c8-8e23-4f4b-88d5-3962f67da572@nvidia.com> <CAGETcx99h+HzL__E8w5VWgn9NrjdMk3KAdeijJXmdDF6fm7NOQ@mail.gmail.com>
In-Reply-To: <CAGETcx99h+HzL__E8w5VWgn9NrjdMk3KAdeijJXmdDF6fm7NOQ@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 23 Oct 2024 11:44:29 -0700
Message-ID: <CAGETcx-cgst26+2bRScx7mmJtOmrHzEfg0eVxzqHfQDTewy_yA@mail.gmail.com>
Subject: Re: [PATCH] driver core: Don't try to create links if they are not needed
To: Jon Hunter <jonathanh@nvidia.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Btw, Nicholas and Jon, can you give a Nack for the patches that are
removing the error logging?

-Saravana

On Wed, Oct 23, 2024 at 11:34=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Wed, Oct 23, 2024 at 7:09=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com>=
 wrote:
> >
> >
> > On 23/10/2024 14:58, N=C3=ADcolas F. R. A. Prado wrote:
> >
> > ...
> >
> > > I'm guessing a similar change to what Saravana suggested for the
> > > of_dp_aux_populate_bus() helper is needed here:
> > >
> > > diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> > > index cfdb54b6070a..0a2096085971 100644
> > > --- a/drivers/phy/tegra/xusb.c
> > > +++ b/drivers/phy/tegra/xusb.c
> > > @@ -543,7 +543,7 @@ static int tegra_xusb_port_init(struct tegra_xusb=
_port *port,
> > >
> > >          device_initialize(&port->dev);
> > >          port->dev.type =3D &tegra_xusb_port_type;
> > > -       port->dev.of_node =3D of_node_get(np);
> > > +       device_set_node(&port->dev, of_fwnode_handle(of_node_get(np))=
);
> > >          port->dev.parent =3D padctl->dev;
> > >
> > >          err =3D dev_set_name(&port->dev, "%s-%u", name, index);
> > >
> > >
> > > As a side note, I wonder if it would be possible to detect these mist=
akes... But
> > > I'm guessing there are legitimate situations where there's no fwnode.
> >
> >
> > Yes! That does indeed fix the issue.
> >
> > Saravana, let me know if you can send a patch? I would but I can't say =
I
> > understand that actual issue.
>
> Heh... didn't know you were hitting the exact same issue. I'll send
> out a patch. Okay to add your tested by too?
>
> -Saravana

